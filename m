Return-Path: <linux-kernel+bounces-88122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F2F86DD98
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D6F1C20AFC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FD169E1F;
	Fri,  1 Mar 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oBLkycnD"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7F2B9A1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283119; cv=none; b=DlpW5+dbOn6cm1SsPRPGqJgX670hhm7AP9tf18B0rzIlV94NZVNshKhQur0SXM155Tgnc86Rd7370coONEvVFGn0HBDwbDqpjNrixxraw/pZNUjIyxpLtDFho3fd69kD9JFalfL/IG22udU8IfxY7qGrlPTBqX+WNfz1p9EXi0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283119; c=relaxed/simple;
	bh=sA8TqOeeNAJ4uP3DUjKIY2dPzNdzR82tgob5RgeK4f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAecDorZ8YY67S/oADqGh9AGLPpo2C1kM7mjvqunnutFulTXuyNKF0bRceEdtf8+6XoE77CpYxrckjrhdAg6tyyZWrAw1lAvZkXO9vGO1+/pQrZokAmY+HMW2z3iVyYdonPJaPpkm/0j50tuKsgm5gNAsUF9sMKjtqzLlxMQW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oBLkycnD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709283116;
	bh=sA8TqOeeNAJ4uP3DUjKIY2dPzNdzR82tgob5RgeK4f8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oBLkycnDM6dnmGifrnnyJu/SaFFDWHpI+SvGrZM+Szcm4Ji9fqd1xFL1TtarN/m+U
	 BldGhnDZNOZea8UpG27gECWjhKY2LHHYzCa0fsS+dbaDnCeLGixrdDJ18XFxpHklgB
	 KZfOxYIxkqL5KJ+T819U/GffuHyw1BYZsSInhTMHW4MoELuBUfWYLjp7ci0tJyJ+Ca
	 pB14aEHMgPX2i8VB1XwaneJPlkQBvd307zLbC6iIrYF/wA7l3iYrSyjK6a9XyEEpFQ
	 mRiFUn5jiJO6j1lDf71A4Dq4OpLpiefZLepiYtSfzJfJ/4Zglu36HXD3Wlj3M+tzKr
	 7dAHbetqLW4Wg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9DC273782017;
	Fri,  1 Mar 2024 08:51:55 +0000 (UTC)
Message-ID: <8142145e-c31a-43f9-a656-1389525f251f@collabora.com>
Date: Fri, 1 Mar 2024 09:51:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: mediatek: cmdq: Don't log an error when
 gce-client-reg is not found
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240229-gce-client-reg-log-dbg-v2-1-4975077173d0@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240229-gce-client-reg-log-dbg-v2-1-4975077173d0@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 29/02/24 20:51, Nícolas F. R. A. Prado ha scritto:
> Most of the callers to this function do not require CMDQ support, it is
> optional, so the missing property shouldn't cause an error message.
> However, it could result on degraded performance, so the fact that it's
> missing should still be alerted. Furthermore, the callers that do
> require CMDQ support already log at the error level when an error is
> returned.
> 
> Change the log message in this helper to be printed at the warning level
> instead.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Ok, this is good now.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Changes in v2:
> - Changed from debug to warning level
> - Tweaked commit message to mention performance penalty of not having
>    GCE
> - Link to v1: https://lore.kernel.org/r/20240226-gce-client-reg-log-dbg-v1-1-f0fff97c30c7@collabora.com
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index b0cd071c4719..943e9055dd1f 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -55,7 +55,7 @@ int cmdq_dev_get_client_reg(struct device *dev,
>   					       "mediatek,gce-client-reg",
>   					       3, idx, &spec);
>   	if (err < 0) {
> -		dev_err(dev,
> +		dev_warn(dev,
>   			"error %d can't parse gce-client-reg property (%d)",
>   			err, idx);
>   
> 
> ---
> base-commit: 41913bcddc83b131649ee8ff0d9ff29e01731398
> change-id: 20240226-gce-client-reg-log-dbg-5ae9637a08ed
> 
> Best regards,



