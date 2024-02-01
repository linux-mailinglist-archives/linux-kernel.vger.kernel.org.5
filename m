Return-Path: <linux-kernel+bounces-47536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B3A844F17
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB261F285D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6AD17BD1;
	Thu,  1 Feb 2024 02:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="okkk1Cb8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA433CC6;
	Thu,  1 Feb 2024 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706753955; cv=none; b=H3oSAK4HMkf5gjnMxFT0fSA39y4097DFOwLZIjys1i0Dqi6b5t8rFW7M0ZJgaKy7ruP6nvCSZ+QUiijOBrsMdF9xGUeVft1U+Ui51B7tyCwtZ4V223dOWHl6SXYhXQABufN7IuYgYuunzY+COvY7PRWKv47bCA/SFXfsKaP/zYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706753955; c=relaxed/simple;
	bh=LmNjmraZk+WS9gdE4M5+8LWWlzYmyX353zJe/xpeAeQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdE639RdZeTvCIGDcwQQeSYmcgJuTFUdu0gJfW5udItxCZ6fwBoPsnRALyJnKZPGcG2r7WUm9WYV0gz7NxmlPuCIhB230ZFeICyHowI8drNnfHhmU958yz7EIOkWKa/Kmexqk5vgzdsFhVPK6rvSSTUis7hsKOTptTOBPEgoSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=okkk1Cb8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VLIchp010605;
	Thu, 1 Feb 2024 02:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=PU1zeIEEaGx4EL7Rhsm2x
	OONX/kLjzZ7k7bT4ihUE80=; b=okkk1Cb8sK11reuiCwu0RcooacXIVbkrAqBrK
	0IYsXtePaIKmiVNWE96YjmnCZBDVvwqdKQjxVpoEV51RFFW5Ihcctn2FPEl6U6Ji
	F/3lc4RSeOzq093hpaJJ72tZcuAhJaj3+m4bbrDqXu6MYypHwnyInt2/TcVtlT+b
	VaFEIORzNuS7KClbk68qie+Dz8GeMRx1yTgoZswg5w9Anh/IIwgIE9UbyI8pdC0Y
	1Q5Yll1VsS1YwP5PuQqcXcG2T/6wQrsCIWr9M1H7zMeqFa7o3dvDjfb1kTTv0lQt
	Ej+WgHIge6jOgN3a73fYNmNNIIBJv6AbgGL/RJOoAXwn6Hr0g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyve60sgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 02:19:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4112J4WQ032591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 02:19:04 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 18:19:03 -0800
Date: Wed, 31 Jan 2024 18:19:03 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Abel Vesa <abel.vesa@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay
 Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] phy: qualcomm: eusb2-repeater: Rework init to drop
 redundant zero-out loop
Message-ID: <ocecdc6cmznvrvjbllm6vzuvwem7c2754phltllbfw6ab4bqfd@cj2fcywg4nso>
Mail-Followup-To: Abel Vesa <abel.vesa@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org
References: <20240129-phy-qcom-eusb2-repeater-fixes-v3-1-9a61ef3490de@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240129-phy-qcom-eusb2-repeater-fixes-v3-1-9a61ef3490de@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FypysBqDUxRfFH5VIscL6_p7rbdU-x6k
X-Proofpoint-ORIG-GUID: FypysBqDUxRfFH5VIscL6_p7rbdU-x6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010016

On Mon, Jan 29, 2024 at 03:03:24PM +0200, Abel Vesa wrote:
> The device match config init table already has zero values, so rework
> the container struct to hold a copy of the init table that can be
> override be the DT specified values. By doing this, only the number of
> vregs remain in the device match config that will be later needed, so
> instead of holding the cfg after probe, store the number of vregs in the
> container struct.
> 
> Fixes: 99a517a582fc ("phy: qualcomm: phy-qcom-eusb2-repeater: Zero out untouched tuning regs")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

I forgot I've been having this on my device for past few days and USB's
been coming up consistently, so I'll count that as:

Tested-by: Elliot Berman <quic_eberman@quicinc.com> # sm8650-qrd

> ---
> Changes in v3:
> - Reworked so that it uses base + reg-index.
> - Link to v2: https://lore.kernel.org/r/20240105-phy-qcom-eusb2-repeater-fixes-v2-0-775d98e7df05@linaro.org
> 
> Changes in v2:
> - The regfields is being dropped from the repeater init, but it's done
>   in the second patch in order to not break bisectability, as it is
>   still needed by the zero-out loop.
> - Added Konrad's R-b tag to the first patch. Did not add Elliot's T-b
>   tag as the second patch has been reworked massively.
> - The zero-out loop is dropped now by holding a copy of the init_tlb in
>   the container struct. This led to dropping the cfg from the container
>   struct (see second patch commit message for more details).
> - Link to v1: https://lore.kernel.org/r/20240104-phy-qcom-eusb2-repeater-fixes-v1-0-047b7b6b8333@linaro.org
> ---
>  drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 166 +++++++++----------------
>  1 file changed, 62 insertions(+), 104 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> index a623f092b11f..a43e20abb10d 100644
> --- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> +++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> @@ -37,56 +37,28 @@
>  #define EUSB2_TUNE_EUSB_EQU		0x5A
>  #define EUSB2_TUNE_EUSB_HS_COMP_CUR	0x5B
>  
> -#define QCOM_EUSB2_REPEATER_INIT_CFG(r, v)	\
> -	{					\
> -		.reg = r,			\
> -		.val = v,			\
> -	}
> -
> -enum reg_fields {
> -	F_TUNE_EUSB_HS_COMP_CUR,
> -	F_TUNE_EUSB_EQU,
> -	F_TUNE_EUSB_SLEW,
> -	F_TUNE_USB2_HS_COMP_CUR,
> -	F_TUNE_USB2_PREEM,
> -	F_TUNE_USB2_EQU,
> -	F_TUNE_USB2_SLEW,
> -	F_TUNE_SQUELCH_U,
> -	F_TUNE_HSDISC,
> -	F_TUNE_RES_FSDIF,
> -	F_TUNE_IUSB2,
> -	F_TUNE_USB2_CROSSOVER,
> -	F_NUM_TUNE_FIELDS,
> -
> -	F_FORCE_VAL_5 = F_NUM_TUNE_FIELDS,
> -	F_FORCE_EN_5,
> -
> -	F_EN_CTL1,
> -
> -	F_RPTR_STATUS,
> -	F_NUM_FIELDS,
> -};
> -
> -static struct reg_field eusb2_repeater_tune_reg_fields[F_NUM_FIELDS] = {
> -	[F_TUNE_EUSB_HS_COMP_CUR] = REG_FIELD(EUSB2_TUNE_EUSB_HS_COMP_CUR, 0, 1),
> -	[F_TUNE_EUSB_EQU] = REG_FIELD(EUSB2_TUNE_EUSB_EQU, 0, 1),
> -	[F_TUNE_EUSB_SLEW] = REG_FIELD(EUSB2_TUNE_EUSB_SLEW, 0, 1),
> -	[F_TUNE_USB2_HS_COMP_CUR] = REG_FIELD(EUSB2_TUNE_USB2_HS_COMP_CUR, 0, 1),
> -	[F_TUNE_USB2_PREEM] = REG_FIELD(EUSB2_TUNE_USB2_PREEM, 0, 2),
> -	[F_TUNE_USB2_EQU] = REG_FIELD(EUSB2_TUNE_USB2_EQU, 0, 1),
> -	[F_TUNE_USB2_SLEW] = REG_FIELD(EUSB2_TUNE_USB2_SLEW, 0, 1),
> -	[F_TUNE_SQUELCH_U] = REG_FIELD(EUSB2_TUNE_SQUELCH_U, 0, 2),
> -	[F_TUNE_HSDISC] = REG_FIELD(EUSB2_TUNE_HSDISC, 0, 2),
> -	[F_TUNE_RES_FSDIF] = REG_FIELD(EUSB2_TUNE_RES_FSDIF, 0, 2),
> -	[F_TUNE_IUSB2] = REG_FIELD(EUSB2_TUNE_IUSB2, 0, 3),
> -	[F_TUNE_USB2_CROSSOVER] = REG_FIELD(EUSB2_TUNE_USB2_CROSSOVER, 0, 2),
> -
> -	[F_FORCE_VAL_5] = REG_FIELD(EUSB2_FORCE_VAL_5, 0, 7),
> -	[F_FORCE_EN_5] = REG_FIELD(EUSB2_FORCE_EN_5, 0, 7),
> -
> -	[F_EN_CTL1] = REG_FIELD(EUSB2_EN_CTL1, 0, 7),
> -
> -	[F_RPTR_STATUS] = REG_FIELD(EUSB2_RPTR_STATUS, 0, 7),
> +enum eusb2_reg_layout {
> +	TUNE_EUSB_HS_COMP_CUR,
> +	TUNE_EUSB_EQU,
> +	TUNE_EUSB_SLEW,
> +	TUNE_USB2_HS_COMP_CUR,
> +	TUNE_USB2_PREEM,
> +	TUNE_USB2_EQU,
> +	TUNE_USB2_SLEW,
> +	TUNE_SQUELCH_U,
> +	TUNE_HSDISC,
> +	TUNE_RES_FSDIF,
> +	TUNE_IUSB2,
> +	TUNE_USB2_CROSSOVER,
> +	NUM_TUNE_FIELDS,
> +
> +	FORCE_VAL_5 = NUM_TUNE_FIELDS,
> +	FORCE_EN_5,
> +
> +	EN_CTL1,
> +
> +	RPTR_STATUS,
> +	LAYOUT_SIZE,
>  };
>  
>  struct eusb2_repeater_cfg {
> @@ -98,10 +70,11 @@ struct eusb2_repeater_cfg {
>  
>  struct eusb2_repeater {
>  	struct device *dev;
> -	struct regmap_field *regs[F_NUM_FIELDS];
> +	struct regmap *regmap;
>  	struct phy *phy;
>  	struct regulator_bulk_data *vregs;
>  	const struct eusb2_repeater_cfg *cfg;
> +	u32 base;
>  	enum phy_mode mode;
>  };
>  
> @@ -109,10 +82,10 @@ static const char * const pm8550b_vreg_l[] = {
>  	"vdd18", "vdd3",
>  };
>  
> -static const u32 pm8550b_init_tbl[F_NUM_TUNE_FIELDS] = {
> -	[F_TUNE_IUSB2] = 0x8,
> -	[F_TUNE_SQUELCH_U] = 0x3,
> -	[F_TUNE_USB2_PREEM] = 0x5,
> +static const u32 pm8550b_init_tbl[NUM_TUNE_FIELDS] = {
> +	[TUNE_IUSB2] = 0x8,
> +	[TUNE_SQUELCH_U] = 0x3,
> +	[TUNE_USB2_PREEM] = 0x5,
>  };
>  
>  static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
> @@ -140,47 +113,42 @@ static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
>  
>  static int eusb2_repeater_init(struct phy *phy)
>  {
> -	struct reg_field *regfields = eusb2_repeater_tune_reg_fields;
>  	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
>  	struct device_node *np = rptr->dev->of_node;
> -	u32 init_tbl[F_NUM_TUNE_FIELDS] = { 0 };
> -	u8 override;
> +	struct regmap *regmap = rptr->regmap;
> +	const u32 *init_tbl = rptr->cfg->init_tbl;
> +	u8 tune_usb2_preem = init_tbl[TUNE_USB2_PREEM];
> +	u8 tune_hsdisc = init_tbl[TUNE_HSDISC];
> +	u8 tune_iusb2 = init_tbl[TUNE_IUSB2];
> +	u32 base = rptr->base;
>  	u32 val;
>  	int ret;
> -	int i;
> +
> +	of_property_read_u8(np, "qcom,tune-usb2-amplitude", &tune_iusb2);
> +	of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &tune_hsdisc);
> +	of_property_read_u8(np, "qcom,tune-usb2-preem", &tune_usb2_preem);
>  
>  	ret = regulator_bulk_enable(rptr->cfg->num_vregs, rptr->vregs);
>  	if (ret)
>  		return ret;
>  
> -	regmap_field_update_bits(rptr->regs[F_EN_CTL1], EUSB2_RPTR_EN, EUSB2_RPTR_EN);
> +	regmap_write(regmap, base + EUSB2_EN_CTL1, EUSB2_RPTR_EN);
>  
> -	for (i = 0; i < F_NUM_TUNE_FIELDS; i++) {
> -		if (init_tbl[i]) {
> -			regmap_field_update_bits(rptr->regs[i], init_tbl[i], init_tbl[i]);
> -		} else {
> -			/* Write 0 if there's no value set */
> -			u32 mask = GENMASK(regfields[i].msb, regfields[i].lsb);
> -
> -			regmap_field_update_bits(rptr->regs[i], mask, 0);
> -		}
> -	}
> -	memcpy(init_tbl, rptr->cfg->init_tbl, sizeof(init_tbl));
> +	regmap_write(regmap, base + EUSB2_TUNE_EUSB_HS_COMP_CUR, init_tbl[TUNE_EUSB_HS_COMP_CUR]);
> +	regmap_write(regmap, base + EUSB2_TUNE_EUSB_EQU, init_tbl[TUNE_EUSB_EQU]);
> +	regmap_write(regmap, base + EUSB2_TUNE_EUSB_SLEW, init_tbl[TUNE_EUSB_SLEW]);
> +	regmap_write(regmap, base + EUSB2_TUNE_USB2_HS_COMP_CUR, init_tbl[TUNE_USB2_HS_COMP_CUR]);
> +	regmap_write(regmap, base + EUSB2_TUNE_USB2_EQU, init_tbl[TUNE_USB2_EQU]);
> +	regmap_write(regmap, base + EUSB2_TUNE_USB2_SLEW, init_tbl[TUNE_USB2_SLEW]);
> +	regmap_write(regmap, base + EUSB2_TUNE_SQUELCH_U, init_tbl[TUNE_SQUELCH_U]);
> +	regmap_write(regmap, base + EUSB2_TUNE_RES_FSDIF, init_tbl[TUNE_RES_FSDIF]);
> +	regmap_write(regmap, base + EUSB2_TUNE_USB2_CROSSOVER, init_tbl[TUNE_USB2_CROSSOVER]);
>  
> -	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &override))
> -		init_tbl[F_TUNE_IUSB2] = override;
> +	regmap_write(regmap, base + EUSB2_TUNE_USB2_PREEM, tune_usb2_preem);
> +	regmap_write(regmap, base + EUSB2_TUNE_HSDISC, tune_hsdisc);
> +	regmap_write(regmap, base + EUSB2_TUNE_IUSB2, tune_iusb2);
>  
> -	if (!of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &override))
> -		init_tbl[F_TUNE_HSDISC] = override;
> -
> -	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &override))
> -		init_tbl[F_TUNE_USB2_PREEM] = override;
> -
> -	for (i = 0; i < F_NUM_TUNE_FIELDS; i++)
> -		regmap_field_update_bits(rptr->regs[i], init_tbl[i], init_tbl[i]);
> -
> -	ret = regmap_field_read_poll_timeout(rptr->regs[F_RPTR_STATUS],
> -					     val, val & RPTR_OK, 10, 5);
> +	ret = regmap_read_poll_timeout(regmap, base + EUSB2_RPTR_STATUS, val, val & RPTR_OK, 10, 5);
>  	if (ret)
>  		dev_err(rptr->dev, "initialization timed-out\n");
>  
> @@ -191,6 +159,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
>  				   enum phy_mode mode, int submode)
>  {
>  	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
> +	struct regmap *regmap = rptr->regmap;
> +	u32 base = rptr->base;
>  
>  	switch (mode) {
>  	case PHY_MODE_USB_HOST:
> @@ -199,10 +169,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
>  		 * per eUSB 1.2 Spec. Below implement software workaround until
>  		 * PHY and controller is fixing seen observation.
>  		 */
> -		regmap_field_update_bits(rptr->regs[F_FORCE_EN_5],
> -					 F_CLK_19P2M_EN, F_CLK_19P2M_EN);
> -		regmap_field_update_bits(rptr->regs[F_FORCE_VAL_5],
> -					 V_CLK_19P2M_EN, V_CLK_19P2M_EN);
> +		regmap_write(regmap, base + EUSB2_FORCE_EN_5, F_CLK_19P2M_EN);
> +		regmap_write(regmap, base + EUSB2_FORCE_VAL_5, V_CLK_19P2M_EN);
>  		break;
>  	case PHY_MODE_USB_DEVICE:
>  		/*
> @@ -211,10 +179,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
>  		 * repeater doesn't clear previous value due to shared
>  		 * regulators (say host <-> device mode switch).
>  		 */
> -		regmap_field_update_bits(rptr->regs[F_FORCE_EN_5],
> -					 F_CLK_19P2M_EN, 0);
> -		regmap_field_update_bits(rptr->regs[F_FORCE_VAL_5],
> -					 V_CLK_19P2M_EN, 0);
> +		regmap_write(regmap, base + EUSB2_FORCE_EN_5, 0);
> +		regmap_write(regmap, base + EUSB2_FORCE_VAL_5, 0);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -243,9 +209,8 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct phy_provider *phy_provider;
>  	struct device_node *np = dev->of_node;
> -	struct regmap *regmap;
> -	int i, ret;
>  	u32 res;
> +	int ret;
>  
>  	rptr = devm_kzalloc(dev, sizeof(*rptr), GFP_KERNEL);
>  	if (!rptr)
> @@ -258,22 +223,15 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
>  	if (!rptr->cfg)
>  		return -EINVAL;
>  
> -	regmap = dev_get_regmap(dev->parent, NULL);
> -	if (!regmap)
> +	rptr->regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!rptr->regmap)
>  		return -ENODEV;
>  
>  	ret = of_property_read_u32(np, "reg", &res);
>  	if (ret < 0)
>  		return ret;
>  
> -	for (i = 0; i < F_NUM_FIELDS; i++)
> -		eusb2_repeater_tune_reg_fields[i].reg += res;
> -
> -	ret = devm_regmap_field_bulk_alloc(dev, regmap, rptr->regs,
> -					   eusb2_repeater_tune_reg_fields,
> -					   F_NUM_FIELDS);
> -	if (ret)
> -		return ret;
> +	rptr->base = res;
>  
>  	ret = eusb2_repeater_init_vregs(rptr);
>  	if (ret < 0) {
> 
> ---
> base-commit: 01af33cc9894b4489fb68fa35c40e9fe85df63dc
> change-id: 20240104-phy-qcom-eusb2-repeater-fixes-c9201113032c
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

