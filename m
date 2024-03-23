Return-Path: <linux-kernel+bounces-112502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEA1887A97
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79FE1C20D77
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCF05A7AE;
	Sat, 23 Mar 2024 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/nSfZSt"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2D5B1F8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711232386; cv=none; b=pLasTAtmZS8V1GREPkLovQKB0z55q8lMqMGSHHaFQwAAM6B9UlE7gHPClLdOH/S8KvHMwNbyTIBrocZ0ewd2PQNntmEBDLBkwbD40viYXLFPfYu88Hpz7m3P4Vg6cJbxcZg8tV5rU2yvLIZt8Rhi3cJNwvB3MUeAIiEmomPgxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711232386; c=relaxed/simple;
	bh=ZcPsWjlj9lt0IC+KED5LgpuFONybE2L/MdQVVekZhBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XWwVY4MkHkRvpOW752YZvc6UvGUtk8rcz25GPenZ6SACuRR7iyWm6YQOvcf1v0hUhpwBHDbXhhyE8I5fZPXy1DDCPNtSHAIXfOAwikTCvcLGaQQdLK5HNUQ+eo7r0U976Gr83jEpaZBK6iBn1PnDGQnTdeI9Tpph1lbQj/4VjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/nSfZSt; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a469dffbdfeso129779466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711232383; x=1711837183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6IQFi8uGp/8YXnM8wES9GmP5xUToFAwq6+EGNAWXMg=;
        b=U/nSfZStaUrD2QHemtm/CCsR6K/fOeMFl2kt+n1j4VJCxKmFf1INDa5DW2Cbs0lUXu
         QEHjJKrYyQdiJnENdRav+A5bkQcFZivxGDzt2My/EywUKFTE3vigbehAhNP+OTHWx0YJ
         ZIWtLf9GiVQrJkOJVxtV8u2jHfptH21gvHHycCRCNwblApl3HLvP2gkHbFCwISfcxM6n
         JM3RY5JPZMRvfj4PD0w0LJzGwQEdkULaIAYLclI7OnFdW0Na5Hfh4WpYl3kT3BPnHmT3
         1stajuQWrEz+jWla93os/jD+3QKRC66fwNQr05n7qTLcrsILkBLL3fA3JRwv4NlvYShY
         ERVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711232383; x=1711837183;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6IQFi8uGp/8YXnM8wES9GmP5xUToFAwq6+EGNAWXMg=;
        b=FAY/iacZADVEYePY0LIK/a0kx5k2kpvY7Xa9nmG9mo49zFnqREjbeeS8kRryivNx2B
         iyn7sGh03KI4kFJ5u5Ybt8rALAhW4uCsGiX1JMTJ/ELD5lGF2383Sx1Gohiucm+y48sk
         pFzbHjGY41a8+eebSnMz8zLks1khjfruvpe/knmWrlNHb7zDyYaKN3BPN39+K699vs7z
         f9WYHChxs+bE8hpu57ZYi0qD1Tnuu26CR+Z0zW9TyA5OgiUsX+t6jzgbrGT5pqHTZ/kt
         vQYDC4/DlaYwRA4VXR1araZ3Xe/zCVm+i5w/G/js0nLLTF5Xyw43phy0U+JQ09vn4wVO
         xZVw==
X-Forwarded-Encrypted: i=1; AJvYcCWjuRRVoiPaEwOLuFFGd6a4R/eBa1FDxFnzqDsdShlm89nRZEZHSmoS3sGGclev25olKMPtTxBwYFVVKYsS+NXkN9peKinciACpSWon
X-Gm-Message-State: AOJu0Yyl9RezYBEJMSDKYXTiCcPkfIDUkUCk4PnNLB0Evo5hmh+8mIlT
	4N0mF1nADqRYXs3QDs9LN50UFTejvpe1ScLFrVgADXVFhsAxGs+Q
X-Google-Smtp-Source: AGHT+IFBL/IwWGm2h0tjoCYxU+8vfobSfgDoD55AqZ+ab1pEgtMHSeWx08IsCWQHA0DO8ErZZJZXmw==
X-Received: by 2002:a17:906:99d0:b0:a47:4293:944a with SMTP id s16-20020a17090699d000b00a474293944amr2039761ejn.3.1711232382531;
        Sat, 23 Mar 2024 15:19:42 -0700 (PDT)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id jp10-20020a170906f74a00b00a461e206c00sm1331799ejb.20.2024.03.23.15.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 15:19:42 -0700 (PDT)
Message-ID: <c20f03dd-fa66-46ca-ab28-faaa97ae6b60@gmail.com>
Date: Sat, 23 Mar 2024 23:19:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Staging: rtl8712: Removed unnecessary parentheses
Content-Language: en-US
To: Brandon Crain <bcrain1606@gmail.com>, larry.finger@lwfinger.net,
 gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <Zf2fuHV2gmSOSEnx@dev>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <Zf2fuHV2gmSOSEnx@dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 16:11, Brandon Crain wrote:
Please make your "Subject" line more unique. Consider that we may end up
with having dozen of commits like yours, all of them referring to
different removals and all without the necessary information to tell 
what they differ in (except the driver/subsystem). So it would help if 
you add the changed file or function to make it more unique.
> Removed uneccessary parentheses from source file

Please use a full sentences with final dot. Always consider that the why 
is most important to answer. In your case the answer would be "because 
it is unnecessary" My preferred proposal would be:

Remove unnecessary parentheses to increase readability.

> 
> Signed-off-by: Brandon Crain <bcrain1606@gmail.com>
> ---
>   drivers/staging/rtl8712/recv_linux.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/recv_linux.c b/drivers/staging/rtl8712/recv_linux.c
> index 215fca4abb3a..2bf4661432a9 100644
> --- a/drivers/staging/rtl8712/recv_linux.c
> +++ b/drivers/staging/rtl8712/recv_linux.c
> @@ -105,7 +105,7 @@ void r8712_recv_indicatepkt(struct _adapter *adapter,
>   	skb->data = recvframe->u.hdr.rx_data;
>   	skb->len = recvframe->u.hdr.len;
>   	skb_set_tail_pointer(skb, skb->len);
> -	if ((attrib->tcpchk_valid == 1) && (attrib->tcp_chkrpt == 1))
> +	if (attrib->tcpchk_valid == 1 && attrib->tcp_chkrpt == 1)

I am not so happy with this proposal I need to know the exact rules that 
the == has priority over &&. So I like to read it with brackets.

>   		skb->ip_summed = CHECKSUM_UNNECESSARY;
>   	else
>   		skb->ip_summed = CHECKSUM_NONE;

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

