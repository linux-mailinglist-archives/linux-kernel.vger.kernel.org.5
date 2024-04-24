Return-Path: <linux-kernel+bounces-157444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4AD8B11BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF551C226A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD9A16D9C5;
	Wed, 24 Apr 2024 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="bAZ3Gy+e"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C016DECE;
	Wed, 24 Apr 2024 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982216; cv=pass; b=GGiY/r6j5qtTWzrlasfMsIzatNLMU25wcOHoQ4coOKOZonlVf19QwgQNQvpka+QOyHxYHLJQSgJvVthWG7TI5shS71fB9anOsp6VyYnmKxaA4FMPY/Cxgs/wLRQTXwT0567d/4t6hRjJIslSHg9V3AV93QHjVsOcz2GyEjMxie4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982216; c=relaxed/simple;
	bh=skA7ahdKPFOTdweUO69mRPcseGb5VBfvaOW2mWZiiTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBHG6q50BUn4LGQmwLVRpkTHx+NoLWWDtHGEJFmhUkLmOO12ORocMOBm4AU78ku4BfTfiuzYoxJlBRsjTC2AM9htWEduDSUsC0LyacHgUElKEBypZ1wm917nRK6kDk080apd2Rad9ZWgBUBKDuTpMMWaLmk+wJKItOHXIPN55dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=bAZ3Gy+e; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VPn8J2Qz8zyS9;
	Wed, 24 Apr 2024 21:10:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1713982210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQ6EHsDoPYaKM1giwGjW2IWsbINRSBqdgRKvtgvBX3I=;
	b=bAZ3Gy+efc5xeMEL9Rui0cCc9gM4xKOKEF/gnwgSkxIGCNaIhSLuy5tMzOHYmKpKmoI6Fm
	DLxBdUBr5l4dh4ZamPtJfL4JhlSij9ddEaMGTPBA8mpZXfEOBSwdBMlqjNBb5O/2dQdwzL
	zHauxGhAhzneQJ1Icv4iCjWf/t9l2Zg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1713982210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQ6EHsDoPYaKM1giwGjW2IWsbINRSBqdgRKvtgvBX3I=;
	b=SLqU3XavR6hWucY82Yi3Sjr9Klzvj+0VwMiaV9m/qwsDbpaWrQqatRVdylD5aO2Ye69/lF
	OtpZ7+zBbVM7znOuR2By9nHNfTPCtZSRMJXYNRZdLyRf0oElIDHEWGdAXwcnPncuv9Ujuo
	aubhGADNzIFk2OJIOZGhj0rNnNaHIwk=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1713982210; a=rsa-sha256; cv=none;
	b=SxWm+GEjjq50eUdh//FIwFIZryizApuy+3G785s7hE06BcJroc8SQayis32c8Ggh21Xpz7
	qvYISE6HES673eh69POJxQViUw6TP/xmIUaOQwhSnN4jKksIG1R4NvPgrgEdd+sl2X4ryL
	8aaUCIKTZVdip11LgpbJC2LMDPMN/Dg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id C47B2634C96;
	Wed, 24 Apr 2024 21:10:05 +0300 (EEST)
Date: Wed, 24 Apr 2024 18:10:05 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Tommaso Merciai <tomm.merciai@gmail.com>
Cc: martin.hecht@avnet.eu, michael.roeder@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] media: i2c: alvium: fix alvium_get_fw_version()
Message-ID: <ZilK_XO4C1k7uD_D@valkosipuli.retiisi.eu>
References: <20240416141905.454253-1-tomm.merciai@gmail.com>
 <20240416141905.454253-2-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416141905.454253-2-tomm.merciai@gmail.com>

Hi Tommaso,

On Tue, Apr 16, 2024 at 04:19:01PM +0200, Tommaso Merciai wrote:
> Instead of reading device_fw reg as multiple regs let's read the entire
> 64bit reg using one i2c read and store this info into alvium_fw_version
> union fixing the dev_info formatting output.
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  drivers/media/i2c/alvium-csi2.c | 20 ++++++++------------
>  drivers/media/i2c/alvium-csi2.h | 15 +++++++++++----
>  2 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> index e65702e3f73e..991b3bcc8b80 100644
> --- a/drivers/media/i2c/alvium-csi2.c
> +++ b/drivers/media/i2c/alvium-csi2.c
> @@ -403,21 +403,17 @@ static int alvium_get_bcrm_vers(struct alvium_dev *alvium)
>  static int alvium_get_fw_version(struct alvium_dev *alvium)
>  {
>  	struct device *dev = &alvium->i2c_client->dev;
> -	u64 spec, maj, min, pat;
> +	union alvium_fw_version v;
>  	int ret = 0;
>  
> -	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_SPEC_VERSION_R,
> -			  &spec, &ret);
> -	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_MAJOR_VERSION_R,
> -			  &maj, &ret);
> -	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_MINOR_VERSION_R,
> -			  &min, &ret);
> -	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW_PATCH_VERSION_R,
> -			  &pat, &ret);
> -	if (ret)
> -		return ret;
> +	ret = alvium_read(alvium, REG_BCRM_DEVICE_FW,
> +			  &v.value, &ret);

Doesn't this have the same endianness issues that earlier were resolved by
doing the reads separately?

>  
> -	dev_info(dev, "fw version: %llu.%llu.%llu.%llu\n", spec, maj, min, pat);
> +	dev_info(dev, "fw version: %u.%u.%08x special: %u\n",
> +		 (u32)v.alvium_fw_ver.major,
> +		 (u32)v.alvium_fw_ver.minor,
> +		 v.alvium_fw_ver.patch,
> +		 (u32)v.alvium_fw_ver.special);
>  
>  	return 0;
>  }
> diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> index 9463f8604fbc..9c4cfb35de8e 100644
> --- a/drivers/media/i2c/alvium-csi2.h
> +++ b/drivers/media/i2c/alvium-csi2.h
> @@ -31,10 +31,7 @@
>  #define REG_BCRM_REG_ADDR_R				CCI_REG16(0x0014)
>  
>  #define REG_BCRM_FEATURE_INQUIRY_R			REG_BCRM_V4L2_64BIT(0x0008)
> -#define REG_BCRM_DEVICE_FW_SPEC_VERSION_R		REG_BCRM_V4L2_8BIT(0x0010)
> -#define REG_BCRM_DEVICE_FW_MAJOR_VERSION_R		REG_BCRM_V4L2_8BIT(0x0011)
> -#define REG_BCRM_DEVICE_FW_MINOR_VERSION_R		REG_BCRM_V4L2_16BIT(0x0012)
> -#define REG_BCRM_DEVICE_FW_PATCH_VERSION_R		REG_BCRM_V4L2_32BIT(0x0014)
> +#define REG_BCRM_DEVICE_FW				REG_BCRM_V4L2_64BIT(0x0010)
>  #define REG_BCRM_WRITE_HANDSHAKE_RW			REG_BCRM_V4L2_8BIT(0x0018)
>  
>  /* Streaming Control Registers */
> @@ -276,6 +273,16 @@ enum alvium_av_mipi_bit {
>  	ALVIUM_NUM_SUPP_MIPI_DATA_BIT
>  };
>  
> +union alvium_fw_version {
> +	struct {
> +		u8 special;
> +		u8 major;
> +		u16 minor;
> +		u32 patch;
> +	} alvium_fw_ver;
> +	u64 value;
> +};
> +
>  struct alvium_avail_feat {
>  	u64 rev_x:1;
>  	u64 rev_y:1;

-- 
Kind regards,

Sakari Ailus

