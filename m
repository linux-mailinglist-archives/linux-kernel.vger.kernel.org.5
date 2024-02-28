Return-Path: <linux-kernel+bounces-84785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808C586AB82
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22AF1C21A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE37339BD;
	Wed, 28 Feb 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="u0FaIgGj"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C8A219FD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113281; cv=none; b=BVzByDGFLhFK0nHcHCobua9Vm6C4w4p5tJ1Sc1udIlsWxGCP/EvFl2AwPdrMPojCpsRdSIDB7MG2jaWYwv1EJVCE0XzRQF981yZ18Eh0oyGFoBu6BBoBCRyRgy3uHkGMGAsPCl0X43lc8bv9OUOIExX/tT5GvOFBxcxDSqEhV84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113281; c=relaxed/simple;
	bh=ea/qP8lceQObB4VFfj13TaUrQWQXFF34TOPECYoDbjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxPZAr307AaOQ1u/f8fCVxBBorsdgHlPburb3Gktwibt9wRI6UeWVN2Hz155vCzmO2/bL2yKDNqqlcFu+9ddjFKIxcX1MDFcAHSXVxWrTlJBRqBTiaVDqNI37fT1dz9dHi6+wJ/teeOGoDElsxK3goQkcdo/9k8RitWXToocP8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=u0FaIgGj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709113276;
	bh=ea/qP8lceQObB4VFfj13TaUrQWQXFF34TOPECYoDbjc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u0FaIgGjtWn77xSxsMdY7Ah7fN6y8vAVkMqFAT2IWrS1T+235RFKhCM0cijnDPWxt
	 E6vcuSp4/A0vd2CcChADwEtGX3V8x36vDQJ2mtPAIJn/wQCxr7pM1OKs6+z9pSYiPk
	 yNAn97gtlMyGfATz13onnIYLSsy5u+QMKoE8H8iAXouQbXDzkFeYi2DQ9NtFZxA/IH
	 8hroDEY842dmV2ViuFxDfAliGElxrzrS636j5odIIkNipeO3tG0GT7LPxqv246h7UE
	 iBFIctQhaDwiJ6ubBDEcxYwDJ/2RX6Gxu2cJP08Hv5Zlim3j8pFycKuxxUAkeEp0C9
	 moGZv+eLV0HSg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 724F53780029;
	Wed, 28 Feb 2024 09:41:16 +0000 (UTC)
Message-ID: <6389f1e3-57b2-453a-af6f-6bc7f725ad31@collabora.com>
Date: Wed, 28 Feb 2024 10:41:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: mediatek: cmdq: Don't log an error when
 gce-client-reg is not found
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240226-gce-client-reg-log-dbg-v1-1-f0fff97c30c7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240226-gce-client-reg-log-dbg-v1-1-f0fff97c30c7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 26/02/24 22:31, Nícolas F. R. A. Prado ha scritto:
> Most of the callers to this function do not require CMDQ support, it is
> optional, so the missing property shouldn't cause an error message.
> Furthermore, the callers that do require CMDQ support already log at the
> error level when an error is returned.
> 
> Change the log message in this helper to be printed at the debug level
> instead.

CMDQ is optional, yes. At least, for some devices it is.

Full story, though, wants that if you use the CPU for register manipulation
instead of programming the GCE (even with threading, fantastic!) you will
trigger various performance issues.

In the end, you *don't want* to use the CPU if GCE is available!

The reasons why the CMDQ/GCE is optional are:
  - You can check register-by-register r/w for debugging scenarios by using
    the CPU to manipulate them instead of having something magically doing
    that for you at a certain (pre-set, yes, but still!) point;
  - Not all SoCs have the same amount of GCE threads and channels, some may
    support writing to IP block X through the GCE, some may not, but both
    may support writing for IP block Y through this mailbox;
  - MediaTek chose to support both ways, enabling means to debug stuff upstream,
    the other choice would've been to never support CPU register R/W on some IPs

    ... and btw - about the last part: Kudos, MediaTek.

Now, I also get why you're raising this, but we have to find an agreement here
on a different way to proceed that satisfies all of us.

First of all..

Which device on which SoC is missing the GCE client register DT property?
Do said SoC really not have a GCE client register for that device?

Is any upstream supported SoC really lacking a GCE register for the upstream
supported IPs?

I'm not sure.... :-)

P.S.: I guess that the alternative (that I somewhat dislike, and you can probably
       understand why after reading the reasons above) would be to turn that into a
       dev_info() instead...

P.P.S.: Having no GCE usually means that there's a performance issue! In that case,
         it's ... a mistake, so, an error, kind-of.... :-)

Cheers,
Angelo

> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index b0cd071c4719..2130ff3aac9e 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -55,7 +55,7 @@ int cmdq_dev_get_client_reg(struct device *dev,
>   					       "mediatek,gce-client-reg",
>   					       3, idx, &spec);
>   	if (err < 0) {
> -		dev_err(dev,
> +		dev_dbg(dev,
>   			"error %d can't parse gce-client-reg property (%d)",
>   			err, idx);
>   
> 
> ---
> base-commit: 41913bcddc83b131649ee8ff0d9ff29e01731398
> change-id: 20240226-gce-client-reg-log-dbg-5ae9637a08ed
> 
> Best regards,



