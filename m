Return-Path: <linux-kernel+bounces-145470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182348A568C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09882813E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1277A140;
	Mon, 15 Apr 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="pBTHd1dB"
Received: from mail-108-mta136.mxroute.com (mail-108-mta136.mxroute.com [136.175.108.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042CF78C88
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195284; cv=none; b=iMDXTl8KL4+ZgFSuz2cI8xjDMAWfURY5uoMs/kg5L+PO/EuNck6iNpxEaWpxyoyBKNTEQx5JvXMJVPU68Owt2gvh9/jQrbEdNFZohyNDKZtw3cuawCJ/7kkFFOHS3QU9Bpdolm2cyFt26fE2vnxSRZdEK8PWicHmR0kcBm8kVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195284; c=relaxed/simple;
	bh=BQJwnzilvg4UD89n3ZcykR+JOTh6boiTVVSb4aelVEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGC/QbvBHy4IE7NasBtBMLvC9o081E3I6gxw1+5uX0Lgw6XA00xtCvbaEwnElPXJ7HYmXgQk7hm6QrdY56aQ4BM9uDIKATIX0+1sn2A7CMkmsQG9ND+RBjyY9yTXY+0S4SJnXVkqTWzko2K5ir2sJ6IWmrp6BX4Et6+TkmztMLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=pBTHd1dB; arc=none smtp.client-ip=136.175.108.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta136.mxroute.com (ZoneMTA) with ESMTPSA id 18ee260b6630003bea.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 15 Apr 2024 15:29:32 +0000
X-Zone-Loop: c49729f103ff959f33ff6569a72d95466399824ef6fc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TdyKsI8DnERrZuKdN0O//oUhAMrnap0gDCjyJL2Q4mo=; b=pBTHd1dBFfKB54VL2BikMNLUHZ
	V28Prwosvn2cPIQlwWA6LKqYdgmtyPUIqnnluYUwFBSX25egud5/BcX5KrB9tba7JBA2gO1JzcjZ1
	5ht64rkc0lwrUQ3rzvHeXvC5stCUlqJiFYaripq2BdbON/QIo8Zta79kpiwvpepyF2PnlcgrRgGFo
	zumK1hNu5+Sf076ck9IKXg06Z0xXgKLsoF3EUx7vKR217gYB4DecA8U2HmRSwDMtIyNiHB3RAFF6e
	aHGLVE2//iTwSYEckJBmZJa1WAexJNIRO4PAMtVj/eB6+jQZzQPhWu+EycvxHhichrhE6bXJLZyQ4
	/xrt7I/A==;
Message-ID: <92ff05aa-4779-427c-96e5-a0bc200aac3c@luigi311.com>
Date: Mon, 15 Apr 2024 09:29:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/25] media: i2c: imx258: Convert to new CCI register
 access helpers
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 sakari.ailus@linux.intel.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, pavel@ucw.cz, phone-devel@vger.kernel.org
References: <20240414203503.18402-1-git@luigi311.com>
 <20240414203503.18402-26-git@luigi311.com>
 <Zh09+UCfQyll8eAL@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Language: en-US
From: Luis Garcia <git@luigi311.com>
In-Reply-To: <Zh09+UCfQyll8eAL@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: git@luigi311.com

On 4/15/24 08:47, Tommaso Merciai wrote:
> Hi Luis,
> 
> On Sun, Apr 14, 2024 at 02:35:03PM -0600, git@luigi311.com wrote:
>> From: Luis Garcia <git@luigi311.com>
>>
>> Use the new comon CCI register access helpers to replace the private
>> register access helpers in the imx258 driver.
>>
>> Signed-off-by: Luis Garcia <git@luigi311.com>
>> ---
>>  drivers/media/i2c/Kconfig  |   1 +
>>  drivers/media/i2c/imx258.c | 804 ++++++++++++++++---------------------
>>  2 files changed, 346 insertions(+), 459 deletions(-)
>>
>> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
>> index 56f276b920ab..6707b0c3c4eb 100644
>> --- a/drivers/media/i2c/Kconfig
>> +++ b/drivers/media/i2c/Kconfig
>> @@ -139,6 +139,7 @@ config VIDEO_IMX219
>>  
>>  config VIDEO_IMX258
>>  	tristate "Sony IMX258 sensor support"
>> +	select V4L2_CCI_I2C
>>  	help
>>  	  This is a Video4Linux2 sensor driver for the Sony
>>  	  IMX258 camera.
>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
>> index 65846dff775e..8fc9750e5ec9 100644
>> --- a/drivers/media/i2c/imx258.c
>> +++ b/drivers/media/i2c/imx258.c
>> @@ -8,22 +8,20 @@
>>  #include <linux/module.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/regulator/consumer.h>
>> +#include <media/v4l2-cci.h>
>>  #include <media/v4l2-ctrls.h>
>>  #include <media/v4l2-device.h>
>>  #include <media/v4l2-fwnode.h>
>>  #include <asm/unaligned.h>
>>  
>> -#define IMX258_REG_VALUE_08BIT		1
>> -#define IMX258_REG_VALUE_16BIT		2
>> -
>> -#define IMX258_REG_MODE_SELECT		0x0100
>> +#define IMX258_REG_MODE_SELECT		CCI_REG8(0x0100)
>>  #define IMX258_MODE_STANDBY		0x00
>>  #define IMX258_MODE_STREAMING		0x01
>>  
>> -#define IMX258_REG_RESET		0x0103
>> +#define IMX258_REG_RESET		CCI_REG8(0x0103)
>>  
>>  /* Chip ID */
>> -#define IMX258_REG_CHIP_ID		0x0016
>> +#define IMX258_REG_CHIP_ID		CCI_REG16(0x0016)
>>  #define IMX258_CHIP_ID			0x0258
>>  
>>  /* V_TIMING internal */
>> @@ -32,13 +30,11 @@
>>  #define IMX258_VTS_30FPS_VGA		0x034c
>>  #define IMX258_VTS_MAX			65525
>>  
>> -#define IMX258_REG_VTS			0x0340
>> -
>>  /* HBLANK control - read only */
>>  #define IMX258_PPL_DEFAULT		5352
>>  
>>  /* Exposure control */
>> -#define IMX258_REG_EXPOSURE		0x0202
>> +#define IMX258_REG_EXPOSURE		CCI_REG16(0x0202)
>>  #define IMX258_EXPOSURE_OFFSET		10
>>  #define IMX258_EXPOSURE_MIN		4
>>  #define IMX258_EXPOSURE_STEP		1
>> @@ -46,38 +42,38 @@
>>  #define IMX258_EXPOSURE_MAX		(IMX258_VTS_MAX - IMX258_EXPOSURE_OFFSET)
>>  
>>  /* Analog gain control */
>> -#define IMX258_REG_ANALOG_GAIN		0x0204
>> +#define IMX258_REG_ANALOG_GAIN		CCI_REG16(0x0204)
>>  #define IMX258_ANA_GAIN_MIN		0
>>  #define IMX258_ANA_GAIN_MAX		480
>>  #define IMX258_ANA_GAIN_STEP		1
>>  #define IMX258_ANA_GAIN_DEFAULT		0x0
>>  
>>  /* Digital gain control */
>> -#define IMX258_REG_GR_DIGITAL_GAIN	0x020e
>> -#define IMX258_REG_R_DIGITAL_GAIN	0x0210
>> -#define IMX258_REG_B_DIGITAL_GAIN	0x0212
>> -#define IMX258_REG_GB_DIGITAL_GAIN	0x0214
>> +#define IMX258_REG_GR_DIGITAL_GAIN	CCI_REG16(0x020e)
>> +#define IMX258_REG_R_DIGITAL_GAIN	CCI_REG16(0x0210)
>> +#define IMX258_REG_B_DIGITAL_GAIN	CCI_REG16(0x0212)
>> +#define IMX258_REG_GB_DIGITAL_GAIN	CCI_REG16(0x0214)
>>  #define IMX258_DGTL_GAIN_MIN		0
>>  #define IMX258_DGTL_GAIN_MAX		4096	/* Max = 0xFFF */
>>  #define IMX258_DGTL_GAIN_DEFAULT	1024
>>  #define IMX258_DGTL_GAIN_STEP		1
>>  
>>  /* HDR control */
>> -#define IMX258_REG_HDR			0x0220
>> +#define IMX258_REG_HDR			CCI_REG8(0x0220)
>>  #define IMX258_HDR_ON			BIT(0)
>> -#define IMX258_REG_HDR_RATIO		0x0222
>> +#define IMX258_REG_HDR_RATIO		CCI_REG8(0x0222)
>>  #define IMX258_HDR_RATIO_MIN		0
>>  #define IMX258_HDR_RATIO_MAX		5
>>  #define IMX258_HDR_RATIO_STEP		1
>>  #define IMX258_HDR_RATIO_DEFAULT	0x0
>>  
>>  /* Test Pattern Control */
>> -#define IMX258_REG_TEST_PATTERN		0x0600
>> +#define IMX258_REG_TEST_PATTERN		CCI_REG16(0x0600)
>>  
>> -#define IMX258_CLK_BLANK_STOP		0x4040
>> +#define IMX258_CLK_BLANK_STOP		CCI_REG8(0x4040)
>>  
>>  /* Orientation */
>> -#define REG_MIRROR_FLIP_CONTROL		0x0101
>> +#define REG_MIRROR_FLIP_CONTROL		CCI_REG8(0x0101)
>>  #define REG_CONFIG_MIRROR_HFLIP		0x01
>>  #define REG_CONFIG_MIRROR_VFLIP		0x02
>>  
>> @@ -89,14 +85,53 @@
>>  #define IMX258_PIXEL_ARRAY_WIDTH	4208U
>>  #define IMX258_PIXEL_ARRAY_HEIGHT	3120U
>>  
>> -struct imx258_reg {
>> -	u16 address;
>> -	u8 val;
>> -};
>> +/* regs */
>> +#define IMX258_REG_PLL_MULT_DRIV                  CCI_REG8(0x0310)
>> +#define IMX258_REG_IVTPXCK_DIV                    CCI_REG8(0x0301)
>> +#define IMX258_REG_IVTSYCK_DIV                    CCI_REG8(0x0303)
>> +#define IMX258_REG_PREPLLCK_VT_DIV                CCI_REG8(0x0305)
>> +#define IMX258_REG_IOPPXCK_DIV                    CCI_REG8(0x0309)
>> +#define IMX258_REG_IOPSYCK_DIV                    CCI_REG8(0x030b)
>> +#define IMX258_REG_PREPLLCK_OP_DIV                CCI_REG8(0x030d)
>> +#define IMX258_REG_PHASE_PIX_OUTEN                CCI_REG8(0x3030)
>> +#define IMX258_REG_PDPIX_DATA_RATE                CCI_REG8(0x3032)
>> +#define IMX258_REG_SCALE_MODE                     CCI_REG8(0x0401)
>> +#define IMX258_REG_SCALE_MODE_EXT                 CCI_REG8(0x3038)
>> +#define IMX258_REG_AF_WINDOW_MODE                 CCI_REG8(0x7bcd)
>> +#define IMX258_REG_FRM_LENGTH_CTL                 CCI_REG8(0x0350)
>> +#define IMX258_REG_CSI_LANE_MODE                  CCI_REG8(0x0114)
>> +#define IMX258_REG_X_EVN_INC                      CCI_REG8(0x0381)
>> +#define IMX258_REG_X_ODD_INC                      CCI_REG8(0x0383)
>> +#define IMX258_REG_Y_EVN_INC                      CCI_REG8(0x0385)
>> +#define IMX258_REG_Y_ODD_INC                      CCI_REG8(0x0387)
>> +#define IMX258_REG_BINNING_MODE                   CCI_REG8(0x0900)
>> +#define IMX258_REG_BINNING_TYPE_V                 CCI_REG8(0x0901)
>> +#define IMX258_REG_FORCE_FD_SUM                   CCI_REG8(0x300d)
>> +#define IMX258_REG_DIG_CROP_X_OFFSET              CCI_REG16(0x0408)
>> +#define IMX258_REG_DIG_CROP_Y_OFFSET              CCI_REG16(0x040a)
>> +#define IMX258_REG_DIG_CROP_IMAGE_WIDTH           CCI_REG16(0x040c)
>> +#define IMX258_REG_DIG_CROP_IMAGE_HEIGHT          CCI_REG16(0x040e)
>> +#define IMX258_REG_SCALE_M                        CCI_REG16(0x0404)
>> +#define IMX258_REG_X_OUT_SIZE                     CCI_REG16(0x034c)
>> +#define IMX258_REG_Y_OUT_SIZE                     CCI_REG16(0x034e)
>> +#define IMX258_REG_X_ADD_STA                      CCI_REG16(0x0344)
>> +#define IMX258_REG_Y_ADD_STA                      CCI_REG16(0x0346)
>> +#define IMX258_REG_X_ADD_END                      CCI_REG16(0x0348)
>> +#define IMX258_REG_Y_ADD_END                      CCI_REG16(0x034a)
>> +#define IMX258_REG_EXCK_FREQ                      CCI_REG16(0x0136)
>> +#define IMX258_REG_CSI_DT_FMT                     CCI_REG16(0x0112)
>> +#define IMX258_REG_LINE_LENGTH_PCK                CCI_REG16(0x0342)
>> +#define IMX258_REG_SCALE_M_EXT                    CCI_REG16(0x303a)
>> +#define IMX258_REG_FRM_LENGTH_LINES               CCI_REG16(0x0340)
>> +#define IMX258_REG_FINE_INTEG_TIME                CCI_REG8(0x0200)
>> +#define IMX258_REG_PLL_IVT_MPY                    CCI_REG16(0x0306)
>> +#define IMX258_REG_PLL_IOP_MPY                    CCI_REG16(0x030e)
>> +#define IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H       CCI_REG16(0x0820)
>> +#define IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L       CCI_REG16(0x0822)
>>  
>>  struct imx258_reg_list {
>>  	u32 num_of_regs;
>> -	const struct imx258_reg *regs;
>> +	const struct cci_reg_sequence *regs;
>>  };
>>  
>>  struct imx258_link_cfg {
>> @@ -143,329 +178,264 @@ struct imx258_mode {
>>   * To avoid further computation of clock settings, adopt the same per
>>   * lane data rate when using 2 lanes, thus allowing a maximum of 15fps.
>>   */
>> -static const struct imx258_reg mipi_1267mbps_19_2mhz_2l[] = {
>> -	{ 0x0136, 0x13 },
>> -	{ 0x0137, 0x33 },
>> -	{ 0x0301, 0x0A },
>> -	{ 0x0303, 0x02 },
>> -	{ 0x0305, 0x03 },
>> -	{ 0x0306, 0x00 },
>> -	{ 0x0307, 0xC6 },
>> -	{ 0x0309, 0x0A },
>> -	{ 0x030B, 0x01 },
>> -	{ 0x030D, 0x02 },
>> -	{ 0x030E, 0x00 },
>> -	{ 0x030F, 0xD8 },
>> -	{ 0x0310, 0x00 },
>> -
>> -	{ 0x0114, 0x01 },
>> -	{ 0x0820, 0x09 },
>> -	{ 0x0821, 0xa6 },
>> -	{ 0x0822, 0x66 },
>> -	{ 0x0823, 0x66 },
>> +static const struct cci_reg_sequence mipi_1267mbps_19_2mhz_2l[] = {
>> +	{ IMX258_REG_EXCK_FREQ, 0x1333 },
>> +	{ IMX258_REG_IVTPXCK_DIV, 10 },
>> +	{ IMX258_REG_IVTSYCK_DIV, 2 },
>> +	{ IMX258_REG_PREPLLCK_VT_DIV, 3 },
>> +	{ IMX258_REG_PLL_IVT_MPY, 198 },
>> +	{ IMX258_REG_IOPPXCK_DIV, 10 },
>> +	{ IMX258_REG_IOPSYCK_DIV, 1 },
>> +	{ IMX258_REG_PREPLLCK_OP_DIV, 2 },
>> +	{ IMX258_REG_PLL_IOP_MPY, 216 },
>> +	{ IMX258_REG_PLL_MULT_DRIV, 0 },
>> +
>> +	{ IMX258_REG_CSI_LANE_MODE, 1 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 1267 * 2 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0 },
>>  };
>>  
>> -static const struct imx258_reg mipi_1267mbps_19_2mhz_4l[] = {
>> -	{ 0x0136, 0x13 },
>> -	{ 0x0137, 0x33 },
>> -	{ 0x0301, 0x05 },
>> -	{ 0x0303, 0x02 },
>> -	{ 0x0305, 0x03 },
>> -	{ 0x0306, 0x00 },
>> -	{ 0x0307, 0xC6 },
>> -	{ 0x0309, 0x0A },
>> -	{ 0x030B, 0x01 },
>> -	{ 0x030D, 0x02 },
>> -	{ 0x030E, 0x00 },
>> -	{ 0x030F, 0xD8 },
>> -	{ 0x0310, 0x00 },
>> -
>> -	{ 0x0114, 0x03 },
>> -	{ 0x0820, 0x13 },
>> -	{ 0x0821, 0x4C },
>> -	{ 0x0822, 0xCC },
>> -	{ 0x0823, 0xCC },
>> +static const struct cci_reg_sequence mipi_1267mbps_19_2mhz_4l[] = {
>> +	{ IMX258_REG_EXCK_FREQ, 0x1333 },
>> +	{ IMX258_REG_IVTPXCK_DIV, 5 },
>> +	{ IMX258_REG_IVTSYCK_DIV, 2 },
>> +	{ IMX258_REG_PREPLLCK_VT_DIV, 3 },
>> +	{ IMX258_REG_PLL_IVT_MPY, 198 },
>> +	{ IMX258_REG_IOPPXCK_DIV, 10 },
>> +	{ IMX258_REG_IOPSYCK_DIV, 1 },
>> +	{ IMX258_REG_PREPLLCK_OP_DIV, 2 },
>> +	{ IMX258_REG_PLL_IOP_MPY, 216 },
>> +	{ IMX258_REG_PLL_MULT_DRIV, 0 },
>> +
>> +	{ IMX258_REG_CSI_LANE_MODE, 3 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 1267 * 4 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0 },
>>  };
>>  
>> -static const struct imx258_reg mipi_1272mbps_24mhz_2l[] = {
>> -	{ 0x0136, 0x18 },
>> -	{ 0x0137, 0x00 },
>> -	{ 0x0301, 0x0a },
>> -	{ 0x0303, 0x02 },
>> -	{ 0x0305, 0x04 },
>> -	{ 0x0306, 0x00 },
>> -	{ 0x0307, 0xD4 },
>> -	{ 0x0309, 0x0A },
>> -	{ 0x030B, 0x01 },
>> -	{ 0x030D, 0x02 },
>> -	{ 0x030E, 0x00 },
>> -	{ 0x030F, 0xD8 },
>> -	{ 0x0310, 0x00 },
>> -
>> -	{ 0x0114, 0x01 },
>> -	{ 0x0820, 0x13 },
>> -	{ 0x0821, 0x4C },
>> -	{ 0x0822, 0xCC },
>> -	{ 0x0823, 0xCC },
>> +static const struct cci_reg_sequence mipi_1272mbps_24mhz_2l[] = {
>> +	{ IMX258_REG_EXCK_FREQ, 0x1800 },
>> +	{ IMX258_REG_IVTPXCK_DIV, 10 },
>> +	{ IMX258_REG_IVTSYCK_DIV, 2 },
>> +	{ IMX258_REG_PREPLLCK_VT_DIV, 4 },
>> +	{ IMX258_REG_PLL_IVT_MPY, 212 },
>> +	{ IMX258_REG_IOPPXCK_DIV, 10 },
>> +	{ IMX258_REG_IOPSYCK_DIV, 1 },
>> +	{ IMX258_REG_PREPLLCK_OP_DIV, 2 },
>> +	{ IMX258_REG_PLL_IOP_MPY, 216 },
>> +	{ IMX258_REG_PLL_MULT_DRIV, 0 },
>> +
>> +	{ IMX258_REG_CSI_LANE_MODE, 1 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 1272 * 2 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0 },
>>  };
>>  
>> -static const struct imx258_reg mipi_1272mbps_24mhz_4l[] = {
>> -	{ 0x0136, 0x18 },
>> -	{ 0x0137, 0x00 },
>> -	{ 0x0301, 0x05 },
>> -	{ 0x0303, 0x02 },
>> -	{ 0x0305, 0x04 },
>> -	{ 0x0306, 0x00 },
>> -	{ 0x0307, 0xD4 },
>> -	{ 0x0309, 0x0A },
>> -	{ 0x030B, 0x01 },
>> -	{ 0x030D, 0x02 },
>> -	{ 0x030E, 0x00 },
>> -	{ 0x030F, 0xD8 },
>> -	{ 0x0310, 0x00 },
>> -
>> -	{ 0x0114, 0x03 },
>> -	{ 0x0820, 0x13 },
>> -	{ 0x0821, 0xE0 },
>> -	{ 0x0822, 0x00 },
>> -	{ 0x0823, 0x00 },
>> +static const struct cci_reg_sequence mipi_1272mbps_24mhz_4l[] = {
>> +	{ IMX258_REG_EXCK_FREQ, 0x1800 },
>> +	{ IMX258_REG_IVTPXCK_DIV, 5 },
>> +	{ IMX258_REG_IVTSYCK_DIV, 2 },
>> +	{ IMX258_REG_PREPLLCK_VT_DIV, 4 },
>> +	{ IMX258_REG_PLL_IVT_MPY, 212 },
>> +	{ IMX258_REG_IOPPXCK_DIV, 10 },
>> +	{ IMX258_REG_IOPSYCK_DIV, 1 },
>> +	{ IMX258_REG_PREPLLCK_OP_DIV, 2 },
>> +	{ IMX258_REG_PLL_IOP_MPY, 216 },
>> +	{ IMX258_REG_PLL_MULT_DRIV, 0 },
>> +
>> +	{ IMX258_REG_CSI_LANE_MODE, 3 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 1272 * 4 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0 },
>>  };
>>  
>> -static const struct imx258_reg mipi_640mbps_19_2mhz_2l[] = {
>> -	{ 0x0136, 0x13 },
>> -	{ 0x0137, 0x33 },
>> -	{ 0x0301, 0x05 },
>> -	{ 0x0303, 0x02 },
>> -	{ 0x0305, 0x03 },
>> -	{ 0x0306, 0x00 },
>> -	{ 0x0307, 0x64 },
>> -	{ 0x0309, 0x0A },
>> -	{ 0x030B, 0x01 },
>> -	{ 0x030D, 0x02 },
>> -	{ 0x030E, 0x00 },
>> -	{ 0x030F, 0xD8 },
>> -	{ 0x0310, 0x00 },
>> -
>> -	{ 0x0114, 0x01 },
>> -	{ 0x0820, 0x05 },
>> -	{ 0x0821, 0x00 },
>> -	{ 0x0822, 0x00 },
>> -	{ 0x0823, 0x00 },
>> +static const struct cci_reg_sequence mipi_640mbps_19_2mhz_2l[] = {
>> +	{ IMX258_REG_EXCK_FREQ, 0x1333 },
>> +	{ IMX258_REG_IVTPXCK_DIV, 5 },
>> +	{ IMX258_REG_IVTSYCK_DIV, 2 },
>> +	{ IMX258_REG_PREPLLCK_VT_DIV, 3 },
>> +	{ IMX258_REG_PLL_IVT_MPY, 100 },
>> +	{ IMX258_REG_IOPPXCK_DIV, 10 },
>> +	{ IMX258_REG_IOPSYCK_DIV, 1 },
>> +	{ IMX258_REG_PREPLLCK_OP_DIV, 2 },
>> +	{ IMX258_REG_PLL_IOP_MPY, 216 },
>> +	{ IMX258_REG_PLL_MULT_DRIV, 0 },
>> +
>> +	{ IMX258_REG_CSI_LANE_MODE, 1 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 640 * 2 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0 },
>>  };
>>  
>> -static const struct imx258_reg mipi_640mbps_19_2mhz_4l[] = {
>> -	{ 0x0136, 0x13 },
>> -	{ 0x0137, 0x33 },
>> -	{ 0x0301, 0x05 },
>> -	{ 0x0303, 0x02 },
>> -	{ 0x0305, 0x03 },
>> -	{ 0x0306, 0x00 },
>> -	{ 0x0307, 0x64 },
>> -	{ 0x0309, 0x0A },
>> -	{ 0x030B, 0x01 },
>> -	{ 0x030D, 0x02 },
>> -	{ 0x030E, 0x00 },
>> -	{ 0x030F, 0xD8 },
>> -	{ 0x0310, 0x00 },
>> -
>> -	{ 0x0114, 0x03 },
>> -	{ 0x0820, 0x0A },
>> -	{ 0x0821, 0x00 },
>> -	{ 0x0822, 0x00 },
>> -	{ 0x0823, 0x00 },
>> +static const struct cci_reg_sequence mipi_640mbps_19_2mhz_4l[] = {
>> +	{ IMX258_REG_EXCK_FREQ, 0x1333 },
>> +	{ IMX258_REG_IVTPXCK_DIV, 5 },
>> +	{ IMX258_REG_IVTSYCK_DIV, 2 },
>> +	{ IMX258_REG_PREPLLCK_VT_DIV, 3 },
>> +	{ IMX258_REG_PLL_IVT_MPY, 100 },
>> +	{ IMX258_REG_IOPPXCK_DIV, 10 },
>> +	{ IMX258_REG_IOPSYCK_DIV, 1 },
>> +	{ IMX258_REG_PREPLLCK_OP_DIV, 2 },
>> +	{ IMX258_REG_PLL_IOP_MPY, 216 },
>> +	{ IMX258_REG_PLL_MULT_DRIV, 0 },
>> +
>> +	{ IMX258_REG_CSI_LANE_MODE, 3 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 640 * 4 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0 },
>>  };
>>  
>> -static const struct imx258_reg mipi_642mbps_24mhz_2l[] = {
>> -	{ 0x0136, 0x18 },
>> -	{ 0x0137, 0x00 },
>> -	{ 0x0301, 0x05 },
>> -	{ 0x0303, 0x02 },
>> -	{ 0x0305, 0x04 },
>> -	{ 0x0306, 0x00 },
>> -	{ 0x0307, 0x6B },
>> -	{ 0x0309, 0x0A },
>> -	{ 0x030B, 0x01 },
>> -	{ 0x030D, 0x02 },
>> -	{ 0x030E, 0x00 },
>> -	{ 0x030F, 0xD8 },
>> -	{ 0x0310, 0x00 },
>> -
>> -	{ 0x0114, 0x01 },
>> -	{ 0x0820, 0x0A },
>> -	{ 0x0821, 0x00 },
>> -	{ 0x0822, 0x00 },
>> -	{ 0x0823, 0x00 },
>> +static const struct cci_reg_sequence mipi_642mbps_24mhz_2l[] = {
>> +	{ IMX258_REG_EXCK_FREQ, 0x1800 },
>> +	{ IMX258_REG_IVTPXCK_DIV, 5 },
>> +	{ IMX258_REG_IVTSYCK_DIV, 2 },
>> +	{ IMX258_REG_PREPLLCK_VT_DIV, 4 },
>> +	{ IMX258_REG_PLL_IVT_MPY, 107 },
>> +	{ IMX258_REG_IOPPXCK_DIV, 10 },
>> +	{ IMX258_REG_IOPSYCK_DIV, 1 },
>> +	{ IMX258_REG_PREPLLCK_OP_DIV, 2 },
>> +	{ IMX258_REG_PLL_IOP_MPY, 216 },
>> +	{ IMX258_REG_PLL_MULT_DRIV, 0 },
>> +
>> +	{ IMX258_REG_CSI_LANE_MODE, 1 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 642 * 2 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0 },
>>  };
>>  
>> -static const struct imx258_reg mipi_642mbps_24mhz_4l[] = {
>> -	{ 0x0136, 0x18 },
>> -	{ 0x0137, 0x00 },
>> -	{ 0x0301, 0x05 },
>> -	{ 0x0303, 0x02 },
>> -	{ 0x0305, 0x04 },
>> -	{ 0x0306, 0x00 },
>> -	{ 0x0307, 0x6B },
>> -	{ 0x0309, 0x0A },
>> -	{ 0x030B, 0x01 },
>> -	{ 0x030D, 0x02 },
>> -	{ 0x030E, 0x00 },
>> -	{ 0x030F, 0xD8 },
>> -	{ 0x0310, 0x00 },
>> -
>> -	{ 0x0114, 0x03 },
>> -	{ 0x0820, 0x0A },
>> -	{ 0x0821, 0x00 },
>> -	{ 0x0822, 0x00 },
>> -	{ 0x0823, 0x00 },
>> +static const struct cci_reg_sequence mipi_642mbps_24mhz_4l[] = {
>> +	{ IMX258_REG_EXCK_FREQ, 0x1800 },
>> +	{ IMX258_REG_IVTPXCK_DIV, 5 },
>> +	{ IMX258_REG_IVTSYCK_DIV, 2 },
>> +	{ IMX258_REG_PREPLLCK_VT_DIV, 4 },
>> +	{ IMX258_REG_PLL_IVT_MPY, 107 },
>> +	{ IMX258_REG_IOPPXCK_DIV, 10 },
>> +	{ IMX258_REG_IOPSYCK_DIV, 1 },
>> +	{ IMX258_REG_PREPLLCK_OP_DIV, 2 },
>> +	{ IMX258_REG_PLL_IOP_MPY, 216 },
>> +	{ IMX258_REG_PLL_MULT_DRIV, 0 },
>> +
>> +	{ IMX258_REG_CSI_LANE_MODE, 3 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 642 * 4 },
>> +	{ IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0 },
>>  };
>>  
>> -static const struct imx258_reg mode_common_regs[] = {
>> -	{ 0x3051, 0x00 },
>> -	{ 0x6B11, 0xCF },
>> -	{ 0x7FF0, 0x08 },
>> -	{ 0x7FF1, 0x0F },
>> -	{ 0x7FF2, 0x08 },
>> -	{ 0x7FF3, 0x1B },
>> -	{ 0x7FF4, 0x23 },
>> -	{ 0x7FF5, 0x60 },
>> -	{ 0x7FF6, 0x00 },
>> -	{ 0x7FF7, 0x01 },
>> -	{ 0x7FF8, 0x00 },
>> -	{ 0x7FF9, 0x78 },
>> -	{ 0x7FFA, 0x00 },
>> -	{ 0x7FFB, 0x00 },
>> -	{ 0x7FFC, 0x00 },
>> -	{ 0x7FFD, 0x00 },
>> -	{ 0x7FFE, 0x00 },
>> -	{ 0x7FFF, 0x03 },
>> -	{ 0x7F76, 0x03 },
>> -	{ 0x7F77, 0xFE },
>> -	{ 0x7FA8, 0x03 },
>> -	{ 0x7FA9, 0xFE },
>> -	{ 0x7B24, 0x81 },
>> -	{ 0x6564, 0x07 },
>> -	{ 0x6B0D, 0x41 },
>> -	{ 0x653D, 0x04 },
>> -	{ 0x6B05, 0x8C },
>> -	{ 0x6B06, 0xF9 },
>> -	{ 0x6B08, 0x65 },
>> -	{ 0x6B09, 0xFC },
>> -	{ 0x6B0A, 0xCF },
>> -	{ 0x6B0B, 0xD2 },
>> -	{ 0x6700, 0x0E },
>> -	{ 0x6707, 0x0E },
>> -	{ 0x9104, 0x00 },
>> -	{ 0x4648, 0x7F },
>> -	{ 0x7420, 0x00 },
>> -	{ 0x7421, 0x1C },
>> -	{ 0x7422, 0x00 },
>> -	{ 0x7423, 0xD7 },
>> -	{ 0x5F04, 0x00 },
>> -	{ 0x5F05, 0xED },
>> -	{ 0x0112, 0x0A },
>> -	{ 0x0113, 0x0A },
>> -	{ 0x0342, 0x14 },
>> -	{ 0x0343, 0xE8 },
>> -	{ 0x0344, 0x00 },
>> -	{ 0x0345, 0x00 },
>> -	{ 0x0346, 0x00 },
>> -	{ 0x0347, 0x00 },
>> -	{ 0x0348, 0x10 },
>> -	{ 0x0349, 0x6F },
>> -	{ 0x034A, 0x0C },
>> -	{ 0x034B, 0x2F },
>> -	{ 0x0381, 0x01 },
>> -	{ 0x0383, 0x01 },
>> -	{ 0x0385, 0x01 },
>> -	{ 0x0387, 0x01 },
>> -	{ 0x0404, 0x00 },
>> -	{ 0x0408, 0x00 },
>> -	{ 0x0409, 0x00 },
>> -	{ 0x040A, 0x00 },
>> -	{ 0x040B, 0x00 },
>> -	{ 0x040C, 0x10 },
>> -	{ 0x040D, 0x70 },
>> -	{ 0x3038, 0x00 },
>> -	{ 0x303A, 0x00 },
>> -	{ 0x303B, 0x10 },
>> -	{ 0x300D, 0x00 },
>> -	{ 0x0350, 0x00 },
>> -	{ 0x0204, 0x00 },
>> -	{ 0x0205, 0x00 },
>> -	{ 0x020E, 0x01 },
>> -	{ 0x020F, 0x00 },
>> -	{ 0x0210, 0x01 },
>> -	{ 0x0211, 0x00 },
>> -	{ 0x0212, 0x01 },
>> -	{ 0x0213, 0x00 },
>> -	{ 0x0214, 0x01 },
>> -	{ 0x0215, 0x00 },
>> -	{ 0x7BCD, 0x00 },
>> -	{ 0x94DC, 0x20 },
>> -	{ 0x94DD, 0x20 },
>> -	{ 0x94DE, 0x20 },
>> -	{ 0x95DC, 0x20 },
>> -	{ 0x95DD, 0x20 },
>> -	{ 0x95DE, 0x20 },
>> -	{ 0x7FB0, 0x00 },
>> -	{ 0x9010, 0x3E },
>> -	{ 0x9419, 0x50 },
>> -	{ 0x941B, 0x50 },
>> -	{ 0x9519, 0x50 },
>> -	{ 0x951B, 0x50 },
>> -	{ 0x3030, 0x00 },
>> -	{ 0x3032, 0x00 },
>> -	{ 0x0220, 0x00 },
>> +static const struct cci_reg_sequence mode_common_regs[] = {
>> +	{ CCI_REG8(0x3051), 0x00 },
>> +	{ CCI_REG8(0x6B11), 0xCF },
>> +	{ CCI_REG8(0x7FF0), 0x08 },
>> +	{ CCI_REG8(0x7FF1), 0x0F },
>> +	{ CCI_REG8(0x7FF2), 0x08 },
>> +	{ CCI_REG8(0x7FF3), 0x1B },
>> +	{ CCI_REG8(0x7FF4), 0x23 },
>> +	{ CCI_REG8(0x7FF5), 0x60 },
>> +	{ CCI_REG8(0x7FF6), 0x00 },
>> +	{ CCI_REG8(0x7FF7), 0x01 },
>> +	{ CCI_REG8(0x7FF8), 0x00 },
>> +	{ CCI_REG8(0x7FF9), 0x78 },
>> +	{ CCI_REG8(0x7FFA), 0x00 },
>> +	{ CCI_REG8(0x7FFB), 0x00 },
>> +	{ CCI_REG8(0x7FFC), 0x00 },
>> +	{ CCI_REG8(0x7FFD), 0x00 },
>> +	{ CCI_REG8(0x7FFE), 0x00 },
>> +	{ CCI_REG8(0x7FFF), 0x03 },
>> +	{ CCI_REG8(0x7F76), 0x03 },
>> +	{ CCI_REG8(0x7F77), 0xFE },
>> +	{ CCI_REG8(0x7FA8), 0x03 },
>> +	{ CCI_REG8(0x7FA9), 0xFE },
>> +	{ CCI_REG8(0x7B24), 0x81 },
>> +	{ CCI_REG8(0x6564), 0x07 },
>> +	{ CCI_REG8(0x6B0D), 0x41 },
>> +	{ CCI_REG8(0x653D), 0x04 },
>> +	{ CCI_REG8(0x6B05), 0x8C },
>> +	{ CCI_REG8(0x6B06), 0xF9 },
>> +	{ CCI_REG8(0x6B08), 0x65 },
>> +	{ CCI_REG8(0x6B09), 0xFC },
>> +	{ CCI_REG8(0x6B0A), 0xCF },
>> +	{ CCI_REG8(0x6B0B), 0xD2 },
>> +	{ CCI_REG8(0x6700), 0x0E },
>> +	{ CCI_REG8(0x6707), 0x0E },
>> +	{ CCI_REG8(0x9104), 0x00 },
>> +	{ CCI_REG8(0x4648), 0x7F },
>> +	{ CCI_REG8(0x7420), 0x00 },
>> +	{ CCI_REG8(0x7421), 0x1C },
>> +	{ CCI_REG8(0x7422), 0x00 },
>> +	{ CCI_REG8(0x7423), 0xD7 },
>> +	{ CCI_REG8(0x5F04), 0x00 },
>> +	{ CCI_REG8(0x5F05), 0xED },
>> +	{IMX258_REG_CSI_DT_FMT, 0x0a0a},
>> +	{IMX258_REG_LINE_LENGTH_PCK, 5352},
>> +	{IMX258_REG_X_ADD_STA, 0},
>> +	{IMX258_REG_Y_ADD_STA, 0},
>> +	{IMX258_REG_X_ADD_END, 4207},
>> +	{IMX258_REG_Y_ADD_END, 3119},
>> +	{IMX258_REG_X_EVN_INC, 1},
>> +	{IMX258_REG_X_ODD_INC, 1},
>> +	{IMX258_REG_Y_EVN_INC, 1},
>> +	{IMX258_REG_Y_ODD_INC, 1},
>> +	{IMX258_REG_DIG_CROP_X_OFFSET, 0},
>> +	{IMX258_REG_DIG_CROP_Y_OFFSET, 0},
>> +	{IMX258_REG_DIG_CROP_IMAGE_WIDTH, 4208},
>> +	{IMX258_REG_SCALE_MODE_EXT, 0},
>> +	{IMX258_REG_SCALE_M_EXT, 16},
>> +	{IMX258_REG_FORCE_FD_SUM, 0},
>> +	{IMX258_REG_FRM_LENGTH_CTL, 0},
>> +	{IMX258_REG_ANALOG_GAIN, 0},
>> +	{IMX258_REG_GR_DIGITAL_GAIN, 256},
>> +	{IMX258_REG_R_DIGITAL_GAIN, 256},
>> +	{IMX258_REG_B_DIGITAL_GAIN, 256},
>> +	{IMX258_REG_GB_DIGITAL_GAIN, 256},
>> +	{IMX258_REG_AF_WINDOW_MODE, 0},
>> +	{ CCI_REG8(0x94DC), 0x20 },
>> +	{ CCI_REG8(0x94DD), 0x20 },
>> +	{ CCI_REG8(0x94DE), 0x20 },
>> +	{ CCI_REG8(0x95DC), 0x20 },
>> +	{ CCI_REG8(0x95DD), 0x20 },
>> +	{ CCI_REG8(0x95DE), 0x20 },
>> +	{ CCI_REG8(0x7FB0), 0x00 },
>> +	{ CCI_REG8(0x9010), 0x3E },
>> +	{ CCI_REG8(0x9419), 0x50 },
>> +	{ CCI_REG8(0x941B), 0x50 },
>> +	{ CCI_REG8(0x9519), 0x50 },
>> +	{ CCI_REG8(0x951B), 0x50 },
>> +	{IMX258_REG_PHASE_PIX_OUTEN, 0},
>> +	{IMX258_REG_PDPIX_DATA_RATE, 0},
>> +	{IMX258_REG_HDR, 0},
>>  };
>>  
>> -static const struct imx258_reg mode_4208x3120_regs[] = {
>> -	{ 0x0900, 0x00 },
>> -	{ 0x0901, 0x11 },
>> -	{ 0x0401, 0x00 },
>> -	{ 0x0405, 0x10 },
>> -	{ 0x040E, 0x0C },
>> -	{ 0x040F, 0x30 },
>> -	{ 0x034C, 0x10 },
>> -	{ 0x034D, 0x70 },
>> -	{ 0x034E, 0x0C },
>> -	{ 0x034F, 0x30 },
>> +static const struct cci_reg_sequence mode_4208x3120_regs[] = {
>> +	{IMX258_REG_BINNING_MODE, 0},
>> +	{IMX258_REG_BINNING_TYPE_V, 0x11},
>> +	{IMX258_REG_SCALE_MODE, 0},
>> +	{IMX258_REG_SCALE_M, 16},
>> +	{IMX258_REG_DIG_CROP_IMAGE_HEIGHT, 3120},
>> +	{IMX258_REG_X_OUT_SIZE, 4208},
>> +	{IMX258_REG_Y_OUT_SIZE, 3120},
>>  };
>>  
>> -static const struct imx258_reg mode_2104_1560_regs[] = {
>> -	{ 0x0900, 0x01 },
>> -	{ 0x0901, 0x12 },
>> -	{ 0x0401, 0x01 },
>> -	{ 0x0405, 0x20 },
>> -	{ 0x040E, 0x06 },
>> -	{ 0x040F, 0x18 },
>> -	{ 0x034C, 0x08 },
>> -	{ 0x034D, 0x38 },
>> -	{ 0x034E, 0x06 },
>> -	{ 0x034F, 0x18 },
>> +static const struct cci_reg_sequence mode_2104_1560_regs[] = {
>> +	{IMX258_REG_BINNING_MODE, 1},
>> +	{IMX258_REG_BINNING_TYPE_V, 0x12},
>> +	{IMX258_REG_SCALE_MODE, 1},
>> +	{IMX258_REG_SCALE_M, 32},
>> +	{IMX258_REG_DIG_CROP_IMAGE_HEIGHT, 1560},
>> +	{IMX258_REG_X_OUT_SIZE, 2104},
>> +	{IMX258_REG_Y_OUT_SIZE, 1560},
>>  };
>>  
>> -static const struct imx258_reg mode_1048_780_regs[] = {
>> -	{ 0x0900, 0x01 },
>> -	{ 0x0901, 0x14 },
>> -	{ 0x0401, 0x01 },
>> -	{ 0x0405, 0x40 },
>> -	{ 0x040E, 0x03 },
>> -	{ 0x040F, 0x0C },
>> -	{ 0x034C, 0x04 },
>> -	{ 0x034D, 0x18 },
>> -	{ 0x034E, 0x03 },
>> -	{ 0x034F, 0x0C },
>> +static const struct cci_reg_sequence mode_1048_780_regs[] = {
>> +	{IMX258_REG_BINNING_MODE, 1},
>> +	{IMX258_REG_BINNING_TYPE_V, 0x14},
>> +	{IMX258_REG_SCALE_MODE, 1},
>> +	{IMX258_REG_SCALE_M, 64},
>> +	{IMX258_REG_DIG_CROP_IMAGE_HEIGHT, 780},
>> +	{IMX258_REG_X_OUT_SIZE, 1048},
>> +	{IMX258_REG_Y_OUT_SIZE, 780},
>>  };
>>  
>>  struct imx258_variant_cfg {
>> -	const struct imx258_reg *regs;
>> +	const struct cci_reg_sequence *regs;
>>  	unsigned int num_regs;
>>  };
>>  
>> -static const struct imx258_reg imx258_cfg_regs[] = {
>> -	{ 0x3052, 0x00 },
>> -	{ 0x4E21, 0x14 },
>> -	{ 0x7B25, 0x00 },
>> +static const struct cci_reg_sequence imx258_cfg_regs[] = {
>> +	{ CCI_REG8(0x3052), 0x00 },
>> +	{ CCI_REG8(0x4E21), 0x14 },
>> +	{ CCI_REG8(0x7B25), 0x00 },
>>  };
>>  
>>  static const struct imx258_variant_cfg imx258_cfg = {
>> @@ -473,10 +443,10 @@ static const struct imx258_variant_cfg imx258_cfg = {
>>  	.num_regs = ARRAY_SIZE(imx258_cfg_regs),
>>  };
>>  
>> -static const struct imx258_reg imx258_pdaf_cfg_regs[] = {
>> -	{ 0x3052, 0x01 },
>> -	{ 0x4E21, 0x10 },
>> -	{ 0x7B25, 0x01 },
>> +static const struct cci_reg_sequence imx258_pdaf_cfg_regs[] = {
>> +	{ CCI_REG8(0x3052), 0x01 },
>> +	{ CCI_REG8(0x4E21), 0x10 },
>> +	{ CCI_REG8(0x7B25), 0x01 },
>>  };
>>  
>>  static const struct imx258_variant_cfg imx258_pdaf_cfg = {
>> @@ -677,6 +647,7 @@ static const struct imx258_mode supported_modes[] = {
>>  struct imx258 {
>>  	struct v4l2_subdev sd;
>>  	struct media_pad pad;
>> +	struct regmap *regmap;
>>  
>>  	const struct imx258_variant_cfg *variant_cfg;
>>  
>> @@ -717,80 +688,6 @@ static inline struct imx258 *to_imx258(struct v4l2_subdev *_sd)
>>  	return container_of(_sd, struct imx258, sd);
>>  }
>>  
>> -/* Read registers up to 2 at a time */
>> -static int imx258_read_reg(struct imx258 *imx258, u16 reg, u32 len, u32 *val)
>> -{
>> -	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
>> -	struct i2c_msg msgs[2];
>> -	u8 addr_buf[2] = { reg >> 8, reg & 0xff };
>> -	u8 data_buf[4] = { 0, };
>> -	int ret;
>> -
>> -	if (len > 4)
>> -		return -EINVAL;
>> -
>> -	/* Write register address */
>> -	msgs[0].addr = client->addr;
>> -	msgs[0].flags = 0;
>> -	msgs[0].len = ARRAY_SIZE(addr_buf);
>> -	msgs[0].buf = addr_buf;
>> -
>> -	/* Read data from register */
>> -	msgs[1].addr = client->addr;
>> -	msgs[1].flags = I2C_M_RD;
>> -	msgs[1].len = len;
>> -	msgs[1].buf = &data_buf[4 - len];
>> -
>> -	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>> -	if (ret != ARRAY_SIZE(msgs))
>> -		return -EIO;
>> -
>> -	*val = get_unaligned_be32(data_buf);
>> -
>> -	return 0;
>> -}
>> -
>> -/* Write registers up to 2 at a time */
>> -static int imx258_write_reg(struct imx258 *imx258, u16 reg, u32 len, u32 val)
>> -{
>> -	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
>> -	u8 buf[6];
>> -
>> -	if (len > 4)
>> -		return -EINVAL;
>> -
>> -	put_unaligned_be16(reg, buf);
>> -	put_unaligned_be32(val << (8 * (4 - len)), buf + 2);
>> -	if (i2c_master_send(client, buf, len + 2) != len + 2)
>> -		return -EIO;
>> -
>> -	return 0;
>> -}
>> -
>> -/* Write a list of registers */
>> -static int imx258_write_regs(struct imx258 *imx258,
>> -			     const struct imx258_reg *regs, u32 len)
>> -{
>> -	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
>> -	unsigned int i;
>> -	int ret;
>> -
>> -	for (i = 0; i < len; i++) {
>> -		ret = imx258_write_reg(imx258, regs[i].address, 1,
>> -					regs[i].val);
>> -		if (ret) {
>> -			dev_err_ratelimited(
>> -				&client->dev,
>> -				"Failed to write reg 0x%4.4x. error = %d\n",
>> -				regs[i].address, ret);
>> -
>> -			return ret;
>> -		}
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>  /* Get bayer order based on flip setting. */
>>  static u32 imx258_get_format_code(const struct imx258 *imx258)
>>  {
>> @@ -828,28 +725,20 @@ static int imx258_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
>>  	return 0;
>>  }
>>  
>> -static int imx258_update_digital_gain(struct imx258 *imx258, u32 len, u32 val)
>> +static int imx258_update_digital_gain(struct imx258 *imx258, u32 val)
>>  {
>>  	int ret;
>>  
>> -	ret = imx258_write_reg(imx258, IMX258_REG_GR_DIGITAL_GAIN,
>> -				IMX258_REG_VALUE_16BIT,
>> -				val);
>> +	ret = cci_write(imx258->regmap, IMX258_REG_GR_DIGITAL_GAIN, val, NULL);
>>  	if (ret)
>>  		return ret;
>> -	ret = imx258_write_reg(imx258, IMX258_REG_GB_DIGITAL_GAIN,
>> -				IMX258_REG_VALUE_16BIT,
>> -				val);
>> +	ret = cci_write(imx258->regmap, IMX258_REG_GB_DIGITAL_GAIN, val, NULL);
>>  	if (ret)
>>  		return ret;
>> -	ret = imx258_write_reg(imx258, IMX258_REG_R_DIGITAL_GAIN,
>> -				IMX258_REG_VALUE_16BIT,
>> -				val);
>> +	ret = cci_write(imx258->regmap, IMX258_REG_R_DIGITAL_GAIN, val, NULL);
>>  	if (ret)
>>  		return ret;
>> -	ret = imx258_write_reg(imx258, IMX258_REG_B_DIGITAL_GAIN,
>> -				IMX258_REG_VALUE_16BIT,
>> -				val);
>> +	ret = cci_write(imx258->regmap, IMX258_REG_B_DIGITAL_GAIN, val, NULL);
>>  	if (ret)
>>  		return ret;
>>  	return 0;
> 
> What about reducing the usage of the "if (ret) return ret;" pattern?
> You can:
> 
> int ret = 0;
> 
> cci_write(imx258->regmap, IMX258_REG_GR_DIGITAL_GAIN, val, &ret);
> cci_write(imx258->regmap, IMX258_REG_GB_DIGITAL_GAIN, val, &ret);
> cci_write(imx258->regmap, IMX258_REG_R_DIGITAL_GAIN, val, &ret);
> cci_write(imx258->regmap, IMX258_REG_B_DIGITAL_GAIN, val, &ret);
> 
> return ret;
> 
> What do you think?
> 

Yeah that works, I have implemented that for the next revision

> 
>> @@ -891,53 +780,45 @@ static int imx258_set_ctrl(struct v4l2_ctrl *ctrl)
>>  
>>  	switch (ctrl->id) {
>>  	case V4L2_CID_ANALOGUE_GAIN:
>> -		ret = imx258_write_reg(imx258, IMX258_REG_ANALOG_GAIN,
>> -				IMX258_REG_VALUE_16BIT,
>> -				ctrl->val);
>> +		ret = cci_write(imx258->regmap, IMX258_REG_ANALOG_GAIN,
>> +				ctrl->val, NULL);
>>  		break;
>>  	case V4L2_CID_EXPOSURE:
>> -		ret = imx258_write_reg(imx258, IMX258_REG_EXPOSURE,
>> -				IMX258_REG_VALUE_16BIT,
>> -				ctrl->val);
>> +		ret = cci_write(imx258->regmap, IMX258_REG_EXPOSURE,
>> +				ctrl->val, NULL);
>>  		break;
>>  	case V4L2_CID_DIGITAL_GAIN:
>> -		ret = imx258_update_digital_gain(imx258, IMX258_REG_VALUE_16BIT,
>> -				ctrl->val);
>> +		ret = imx258_update_digital_gain(imx258, ctrl->val);
>>  		break;
>>  	case V4L2_CID_TEST_PATTERN:
>> -		ret = imx258_write_reg(imx258, IMX258_REG_TEST_PATTERN,
>> -				IMX258_REG_VALUE_16BIT,
>> -				ctrl->val);
>> +		ret = cci_write(imx258->regmap, IMX258_REG_TEST_PATTERN,
>> +				ctrl->val, NULL);
>>  		break;
>>  	case V4L2_CID_WIDE_DYNAMIC_RANGE:
>>  		if (!ctrl->val) {
>> -			ret = imx258_write_reg(imx258, IMX258_REG_HDR,
>> -					       IMX258_REG_VALUE_08BIT,
>> -					       IMX258_HDR_RATIO_MIN);
>> +			ret = cci_write(imx258->regmap, IMX258_REG_HDR,
>> +					IMX258_HDR_RATIO_MIN, NULL);
>>  		} else {
>> -			ret = imx258_write_reg(imx258, IMX258_REG_HDR,
>> -					       IMX258_REG_VALUE_08BIT,
>> -					       IMX258_HDR_ON);
>> +			ret = cci_write(imx258->regmap, IMX258_REG_HDR,
>> +					IMX258_HDR_ON, NULL);
>>  			if (ret)
>>  				break;
>> -			ret = imx258_write_reg(imx258, IMX258_REG_HDR_RATIO,
>> -					       IMX258_REG_VALUE_08BIT,
>> -					       BIT(IMX258_HDR_RATIO_MAX));
>> +			ret = cci_write(imx258->regmap, IMX258_REG_HDR_RATIO,
>> +					BIT(IMX258_HDR_RATIO_MAX), NULL);
>>  		}
>>  		break;
>>  	case V4L2_CID_VBLANK:
>> -		ret = imx258_write_reg(imx258, IMX258_REG_VTS,
>> -				       IMX258_REG_VALUE_16BIT,
>> -				       imx258->cur_mode->height + ctrl->val);
>> +		ret = cci_write(imx258->regmap, IMX258_REG_FRM_LENGTH_LINES,
>> +				imx258->cur_mode->height + ctrl->val, NULL);
>>  		break;
>>  	case V4L2_CID_VFLIP:
>>  	case V4L2_CID_HFLIP:
>> -		ret = imx258_write_reg(imx258, REG_MIRROR_FLIP_CONTROL,
>> -				       IMX258_REG_VALUE_08BIT,
>> -				       (imx258->hflip->val ?
>> -					REG_CONFIG_MIRROR_HFLIP : 0) |
>> -				       (imx258->vflip->val ?
>> -					REG_CONFIG_MIRROR_VFLIP : 0));
>> +		ret = cci_write(imx258->regmap, REG_MIRROR_FLIP_CONTROL,
>> +				(imx258->hflip->val ?
>> +				 REG_CONFIG_MIRROR_HFLIP : 0) |
>> +				(imx258->vflip->val ?
>> +				 REG_CONFIG_MIRROR_VFLIP : 0),
>> +				NULL);
>>  		break;
>>  	default:
>>  		dev_info(&client->dev,
>> @@ -1147,8 +1028,7 @@ static int imx258_start_streaming(struct imx258 *imx258)
>>  	const struct imx258_link_freq_config *link_freq_cfg;
>>  	int ret, link_freq_index;
>>  
>> -	ret = imx258_write_reg(imx258, IMX258_REG_RESET, IMX258_REG_VALUE_08BIT,
>> -			       0x01);
>> +	ret = cci_write(imx258->regmap, IMX258_REG_RESET, 0x01, NULL);
>>  	if (ret) {
>>  		dev_err(&client->dev, "%s failed to reset sensor\n", __func__);
>>  		return ret;
>> @@ -1162,30 +1042,30 @@ static int imx258_start_streaming(struct imx258 *imx258)
>>  	link_freq_cfg = &imx258->link_freq_configs[link_freq_index];
>>  
>>  	reg_list = &link_freq_cfg->link_cfg[imx258->lane_mode_idx].reg_list;
>> -	ret = imx258_write_regs(imx258, reg_list->regs, reg_list->num_of_regs);
>> +	ret = cci_multi_reg_write(imx258->regmap, reg_list->regs, reg_list->num_of_regs, NULL);
>>  	if (ret) {
>>  		dev_err(&client->dev, "%s failed to set plls\n", __func__);
>>  		return ret;
>>  	}
>>  
>> -	ret = imx258_write_regs(imx258, mode_common_regs,
>> -				ARRAY_SIZE(mode_common_regs));
>> +	ret = cci_multi_reg_write(imx258->regmap, mode_common_regs,
>> +				  ARRAY_SIZE(mode_common_regs), NULL);
>>  	if (ret) {
>>  		dev_err(&client->dev, "%s failed to set common regs\n", __func__);
>>  		return ret;
>>  	}
>>  
>> -	ret = imx258_write_regs(imx258, imx258->variant_cfg->regs,
>> -				imx258->variant_cfg->num_regs);
>> +	ret = cci_multi_reg_write(imx258->regmap, imx258->variant_cfg->regs,
>> +				  imx258->variant_cfg->num_regs, NULL);
>>  	if (ret) {
>>  		dev_err(&client->dev, "%s failed to set variant config\n",
>>  			__func__);
>>  		return ret;
>>  	}
>>  
>> -	ret = imx258_write_reg(imx258, IMX258_CLK_BLANK_STOP,
>> -			       IMX258_REG_VALUE_08BIT,
>> -			       !!(imx258->csi2_flags & V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK));
>> +	ret = cci_write(imx258->regmap, IMX258_CLK_BLANK_STOP,
>> +			!!(imx258->csi2_flags & V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK),
>> +			NULL);
>>  	if (ret) {
>>  		dev_err(&client->dev, "%s failed to set clock lane mode\n", __func__);
>>  		return ret;
>> @@ -1193,7 +1073,7 @@ static int imx258_start_streaming(struct imx258 *imx258)
>>  
>>  	/* Apply default values of current mode */
>>  	reg_list = &imx258->cur_mode->reg_list;
>> -	ret = imx258_write_regs(imx258, reg_list->regs, reg_list->num_of_regs);
>> +	ret = cci_multi_reg_write(imx258->regmap, reg_list->regs, reg_list->num_of_regs, NULL);
>>  	if (ret) {
>>  		dev_err(&client->dev, "%s failed to set mode\n", __func__);
>>  		return ret;
>> @@ -1205,9 +1085,8 @@ static int imx258_start_streaming(struct imx258 *imx258)
>>  		return ret;
>>  
>>  	/* set stream on register */
>> -	return imx258_write_reg(imx258, IMX258_REG_MODE_SELECT,
>> -				IMX258_REG_VALUE_08BIT,
>> -				IMX258_MODE_STREAMING);
>> +	return cci_write(imx258->regmap, IMX258_REG_MODE_SELECT,
>> +			 IMX258_MODE_STREAMING, NULL);
>>  }
>>  
>>  /* Stop streaming */
>> @@ -1217,8 +1096,8 @@ static int imx258_stop_streaming(struct imx258 *imx258)
>>  	int ret;
>>  
>>  	/* set stream off register */
>> -	ret = imx258_write_reg(imx258, IMX258_REG_MODE_SELECT,
>> -		IMX258_REG_VALUE_08BIT, IMX258_MODE_STANDBY);
>> +	ret = cci_write(imx258->regmap, IMX258_REG_MODE_SELECT,
>> +			IMX258_MODE_STANDBY, NULL);
>>  	if (ret)
>>  		dev_err(&client->dev, "%s failed to set stream\n", __func__);
>>  
>> @@ -1316,10 +1195,10 @@ static int imx258_identify_module(struct imx258 *imx258)
>>  {
>>  	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
>>  	int ret;
>> -	u32 val;
>> +	u64 val;
>>  
>> -	ret = imx258_read_reg(imx258, IMX258_REG_CHIP_ID,
>> -			      IMX258_REG_VALUE_16BIT, &val);
>> +	ret = cci_read(imx258->regmap, IMX258_REG_CHIP_ID,
>> +		       &val, NULL);
>>  	if (ret) {
>>  		dev_err(&client->dev, "failed to read chip id %x\n",
>>  			IMX258_CHIP_ID);
>> @@ -1327,7 +1206,7 @@ static int imx258_identify_module(struct imx258 *imx258)
>>  	}
>>  
>>  	if (val != IMX258_CHIP_ID) {
>> -		dev_err(&client->dev, "chip id mismatch: %x!=%x\n",
>> +		dev_err(&client->dev, "chip id mismatch: %x!=%llx\n",
>>  			IMX258_CHIP_ID, val);
>>  		return -EIO;
>>  	}
>> @@ -1507,6 +1386,13 @@ static int imx258_probe(struct i2c_client *client)
>>  	if (!imx258)
>>  		return -ENOMEM;
>>  
>> +	imx258->regmap = devm_cci_regmap_init_i2c(client, 16);
>> +	if (IS_ERR(imx258->regmap)) {
>> +		ret = PTR_ERR(imx258->regmap);
>> +		dev_err(&client->dev, "failed to initialize CCI: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>>  	ret = imx258_get_regulators(imx258, client);
>>  	if (ret)
>>  		return dev_err_probe(&client->dev, ret,
>> -- 
>> 2.44.0
> 
> The rest looks good to me.
> Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>
> 
> Thanks & Regards,
> Tommaso
> 

Thank you very much!

>>
>>


