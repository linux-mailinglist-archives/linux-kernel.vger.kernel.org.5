Return-Path: <linux-kernel+bounces-49631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 447CE846D24
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7AE290775
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51A17A71D;
	Fri,  2 Feb 2024 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbkQ76vF"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EA95FEF8;
	Fri,  2 Feb 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867935; cv=none; b=YMDeHHdY+mOxJyo53bsH34R3yLSfDDH01Q9gkeSNzGCaVrr1abScrtWCG7P8rLAq92cIFOIyPTG7HgTf7zp1RNi01Oeu36UobyAFVvmzuRUfhaTeu8liJ2trCqtREWkd141HTd12YOai9HdCmRrkVLvCpJ6lzBoHSQvpInDxuNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867935; c=relaxed/simple;
	bh=DkbWTuDazMKJWZUiAxryy/903EaX7q6q9RefI6eZyfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpFT9m1VK7oRlgN36zt3GaGaAswVKoBNU+r3PA2HAwcJ8TtTBpZ85HTTxb9TY0DwXD8QL3vmZCzUEGGfLmfidG/kK90+6zmFyGFp59raDdmRAMq+NmuO6YR+HFdPYQATJeu0E4PDnLYm65u14ehhNgR0s50jKX3/e/9d9l3cqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbkQ76vF; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-783da8920e5so124096185a.1;
        Fri, 02 Feb 2024 01:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706867931; x=1707472731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6fyBxEnYt0Yb8BWzW2Dkq1yl3Yvo5z3oSE+nBfPAD8=;
        b=lbkQ76vFaOi0PYTlhC66bXWbRwcRapttgdgVG0kWp0hfoRMxLTdP8W9FjslJ0ykGdU
         IoD0oTNOfaZvH2XCjMIWURTV2QfHJYHvHzj0qlz5vVINk8B7eHbCuiheOB1Aa2Pp1T/z
         pmTUptwEP22gxAez8Aya3ynxsxsRibeMicNAJlMu3U4PFZhacgVJODVaDQEg9J4L3I6x
         1fl7t+7Qgw5Qaak5Z4YjK08TzXCgik6CabDsUH1KZ/HM+nXyK9SzAZOLf/d0q8cDHL51
         v6h2hiCheLdereUeB8G1WNIYGP2J6QPmKuw4B3viYt/ZQA+7XvZm9E3DrmdjwrAzJUG1
         q0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867931; x=1707472731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6fyBxEnYt0Yb8BWzW2Dkq1yl3Yvo5z3oSE+nBfPAD8=;
        b=UyBoKMLcHrbLncLEQ4HnGTOFhANRG8IwJyuO3bB/2aTGmvBgzCR76sZ+ovk0mDxG1U
         KMVxYTdkYHv8CSeHVx9h2E48FYP6J6FrKIDLymPTkuxOZ7g8czTDd24FV40Lz+CJf+Wn
         dv7q4pi+A73dH46VKQzNCtU/5Hl4H+5jfr70iCCa/M7WVq+/Vp9d0rgiO7FNd0ODZ5Gw
         bhuzLPKih8HlfYtbTui3/G/bpwkBcqzyNIfJR8bfeTvy533GtaFMoJzmwfHu599NKl61
         bwQo7wHBfLLeRYypEXom82+9IRo81+BtVz+rU1aAEeTU8rHdiBEi3X0L7GW5Ia9KWH12
         E+tA==
X-Gm-Message-State: AOJu0Yz3upWzapqjhYSyzeIPHGMg/iBPvZ4aINxMwSoHj+/UxSYK+qSy
	Bm8h4uDhbAGX8LBm08xKv2Ufqg/0WvDzHqtkae9NlbFkArHQQXCH
X-Google-Smtp-Source: AGHT+IGi9xNvoo0qkunPvcWTLEC1MipJ3N1phvvIyme5M65V1UqM8X/fWswldrRtYf3mmuEu4dItkA==
X-Received: by 2002:ad4:5ce3:0:b0:68c:5e33:dc9 with SMTP id iv3-20020ad45ce3000000b0068c5e330dc9mr1944927qvb.34.1706867931016;
        Fri, 02 Feb 2024 01:58:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV2moWMTAK/wWuRjR7mNQbLtk63x3NEIn+rA95YoOusIf2NgWE2rM56Zxl224DYusrrt5d0lu7FMoPJrbI3XZ2XdOZ3jxwnxQ+Aru74zeR5LYM3W9T+RHjebO66iN2WUHL0VamvvWBlltriJa7rLW6yNeS93nsV7pZ+1vL0HJDnSsQ1oLjrrSvQ8FtTUhf0qQ99BQVCEMoVzhkSqRSHHVDcd9134BBkEV2AAhk4AYwRzwaNSrDNv9rq+Hbpnw41Ue1uJCEgOP49Pu3013c/5IyRxa1yvtBUczdmYuUWi4Ky9RezECguyAM/NBASLCAqK0CWw3jjzVNZ5lD2RvCPGrEfCo8a9czOk1c5bIlgvq3kiBrxzH1queUExT6OLn/LOlyMJOcS7+ab4lhjnfyrE+SKjPbcjOjPstmLz+/RUA1pkLGIjL/LjQ3pNp2reOU34PZTVlf9P5sGJm3NWjrb+w8MNTDCvm5DNM/pjPLSEbKVvQIVfpZaEOJrU9qw+keQh4fDqg57REuOg2YnjiPvBFBWvYXnLdaSUHsUQErK8KWB1rD9oA1U25u94i9Vst1P9j/9UbNOihJvBVlLjcXrf0BnNRocrFZEvig6/sPt5mcoXml4M7JRoCagxGXmWsYqvejwazwbyMWJnq38tUb+AgCfdk4ZiTCeNGYhaLuK6p8pS0sOeA==
Received: from [192.168.178.55] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id t2-20020a0cea22000000b0068c4f1da09csm659978qvp.120.2024.02.02.01.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 01:58:50 -0800 (PST)
Message-ID: <a91c6a28-6762-41cf-bb85-09e79f3d29d4@gmail.com>
Date: Fri, 2 Feb 2024 10:58:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Adjust n_channels usage for __counted_by
To: Kalle Valo <kvalo@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Chi-hsien Lin <chi-hsien.lin@infineon.com>, Ian Lin <ian.lin@infineon.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Wright Feng <wright.feng@cypress.com>, Hector Martin <marcan@marcan.st>,
 linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Jisoo Jang <jisoo.jang@yonsei.ac.kr>, Hans de Goede <hdegoede@redhat.com>,
 Aloka Dixit <quic_alokad@quicinc.com>, John Keeping <john@keeping.me.uk>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240126223150.work.548-kees@kernel.org>
 <170678189299.2736043.11616312910656558919.kvalo@kernel.org>
Content-Language: en-US
From: Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <170678189299.2736043.11616312910656558919.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/2024 11:04 AM, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> wrote:
> 
>> After commit e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
>> cfg80211_scan_request with __counted_by"), the compiler may enforce
>> dynamic array indexing of req->channels to stay below n_channels. As a
>> result, n_channels needs to be increased _before_ accessing the newly
>> added array index. Increment it first, then use "i" for the prior index.
>> Solves this warning in the coming GCC that has __counted_by support:
>>
>> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_internal_escan_add_info':
>> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3783:46: warning: operation on 'req->
>> n_channels' may be undefined [-Wsequence-point]
>>   3783 |                 req->channels[req->n_channels++] = chan;
>>        |                               ~~~~~~~~~~~~~~~^~
>>
>> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
>> Cc: Arend van Spriel <aspriel@gmail.com>
>> Cc: Franky Lin <franky.lin@broadcom.com>
>> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
>> Cc: Kalle Valo <kvalo@kernel.org>
>> Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
>> Cc: Ian Lin <ian.lin@infineon.com>
>> Cc: Johannes Berg <johannes.berg@intel.com>
>> Cc: Wright Feng <wright.feng@cypress.com>
>> Cc: Hector Martin <marcan@marcan.st>
>> Cc: linux-wireless@vger.kernel.org
>> Cc: brcm80211-dev-list.pdl@broadcom.com
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> I'm planning to queue this for wireless tree. Arend, ack?

This slipped past my broadcom email. As the Fixes commit is in 6.7 I 
would say ACK.

Gr. AvS

