Return-Path: <linux-kernel+bounces-42008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2383FAEA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43161F22E2D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D278A446DC;
	Sun, 28 Jan 2024 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4a4FcSrr"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63862446C5;
	Sun, 28 Jan 2024 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706484073; cv=none; b=PPDMvw3HPp40i/riqEMq1qpBP/nid5rhV/bM2F1lqLsu/ZkaPyWoor3nRCtzFacY7KnGy38iGuh1XD9X4lHw3o26Claj4tIcxxdMwvIwa8Bwe3MgfS+QqUICGWh0JfpxHqt1N7bONlo2flOB9V/Y+h6ATHzTPu8fIroZuW38P7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706484073; c=relaxed/simple;
	bh=FhSTrVH5zrmp01WnNuro1Rqyjl2zO1fLnyrlz07saWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbhUOw2e5ko5rOvRyC63DnNEMWBzzKWs9NiV/UdcVOCuibNYUszuxFNrlYHTjYI8//tkl0dZNmj3m5CdQZTACCKX23Sd+4ErgKP6jGshs/XNkZYRliEI1KKeewt8dn+oHyEovWBAF/8EnDy/7TkJ/jmaJApQ9Dl/1thKwLA491s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4a4FcSrr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3pgIaJ7MkTtY//7CcCezghloHGWFY713Or2R1yaWIm4=; b=4a4FcSrrklo1A7he8JHnJGqUki
	9mKoWKFz4miOUi7DEygXN/OmgNQviNVJ5b0P64D9n+DH3Ui4EWb4/0SYuT8SPXk5EfFb01VDnLmVk
	sJIZeM6rehxUUJ+LkCSR6E6MxCHX7PTF7gfhZ+ECEDHW3V8L/drpE/AZvCbuUKt1tUarRUIxBeOkh
	cfHfG870F8WLjJSDB8RpOW6/s6rA4Hp79AjnVFt9pv8Xd9Fg7CGl/A5fLCvBYwQMdJrML/ZnVHW8r
	r3Upz4YvDQwtTxszFqUGEkyyRsInvJraBb73kRbCfTPCjNjqV4v9NGnr4uEKokMI3O8abnPXItDxA
	a4z84hxQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUESU-0000000AjkV-3qtf;
	Sun, 28 Jan 2024 23:21:03 +0000
Message-ID: <621fe651-8538-43d5-a797-c1e66436b2dc@infradead.org>
Date: Sun, 28 Jan 2024 15:21:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: ipu3: Fix UAPI header doc warnings
Content-Language: en-US
To: Kohshi Yamaguchi <kohshi54.yam@gmail.com>, sakari.ailus@linux.intel.com,
 bingbu.cao@intel.com, tian.shu.qiu@intel.com
Cc: mchehab@kernel.org, gregkh@linuxfoundation.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20240128225258.50375-1-kohshi54.yam@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240128225258.50375-1-kohshi54.yam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/28/24 14:52, Kohshi Yamaguchi wrote:
> The ipu3_uapi_acc_param struct in the IPU3 UAPI header mentioned
> reserved1 and reserved2 fields, which are absent in the actual
> structure definition. This mismatch led to Sphinx build warnings
> due to inconsistencies between the documentation and the code.
> 
> This patch removes these non-existent reserved field references
> from the documentation, resolving the Sphinx build warnings and
> ensuring the UAPI header is accurately documented.
> 
> Signed-off-by: Kohshi Yamaguchi <kohshi54.yam@gmail.com>
> ---
>  drivers/staging/media/ipu3/include/uapi/intel-ipu3.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
> index caa358e0bae4..926fcf84e33c 100644
> --- a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
> +++ b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
> @@ -2485,11 +2485,9 @@ struct ipu3_uapi_anr_config {
>   *		&ipu3_uapi_yuvp1_y_ee_nr_config
>   * @yds:	y down scaler config. See &ipu3_uapi_yuvp1_yds_config
>   * @chnr:	chroma noise reduction config. See &ipu3_uapi_yuvp1_chnr_config
> - * @reserved1: reserved
>   * @yds2:	y channel down scaler config. See &ipu3_uapi_yuvp1_yds_config
>   * @tcc:	total color correction config as defined in struct
>   *		&ipu3_uapi_yuvp2_tcc_static_config
> - * @reserved2: reserved
>   * @anr:	advanced noise reduction config.See &ipu3_uapi_anr_config
>   * @awb_fr:	AWB filter response config. See ipu3_uapi_awb_fr_config
>   * @ae:	auto exposure config  As specified by &ipu3_uapi_ae_config

posted 2 days ago:

https://lore.kernel.org/linux-media/eed7560f-cd7d-4e07-9b38-038ca65445bf@infradead.org/T/#mda377078e30cb5d784f23de95d8d7cca13265562

Thanks.

-- 
#Randy

