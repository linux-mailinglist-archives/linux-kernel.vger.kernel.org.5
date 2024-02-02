Return-Path: <linux-kernel+bounces-50297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9A84771A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC301C26962
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DDB14C5B8;
	Fri,  2 Feb 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuvLGtRz"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F51D149012;
	Fri,  2 Feb 2024 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897332; cv=none; b=XpsdlpCBXMGkP/bdybTwscIKZ/uJHK5LGz0FsQEA3SZh2q/4SLxR0qmVjzOOzYBaYxYRHh0XH2dEcSKzAW9ru5kVqOw8UNxUyaes2rC23lZpBCcfpChcF2t7U1QwkaYz3NfRtMX94gwPlzWnO7zbW4Id27I4VNXTXglbtjlM5Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897332; c=relaxed/simple;
	bh=QDFPSRUTTIxcUcZpwGxYxehEIqReHy4CI55yrtFRzQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3VSnzauB7+EajVq0rr25Pi3rnV0e+UPegQy3A4yQXcxOXmnWz5NTrV3zJZ9pW/VppYR7aQVeciOpyAPOMcMmuC+QP+2BHyZPzqp4Rg3Vgp0rYCneL0QTumDUzOybC8gauXNDUMkogE4FU/w4Ud7MwYUGgD7h7XTWvbyRGi1zCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuvLGtRz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a271a28aeb4so353527966b.2;
        Fri, 02 Feb 2024 10:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706897328; x=1707502128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6k6f7aElP7VLNFd5TSd36D2rwgbRDtNHJQ2BO+8c1Y=;
        b=HuvLGtRz2w13j6OTHfutKvCWVC89LjFa//WG2hynen1EMN20yhwGv3peUtPUbkT50l
         T6CiQyiIug2foCBsJ+MY0ltfGErFc+smI9f3ysjJhWdDFOGolKNY7PHZ4N/KOCDB4cBf
         MGYORdta0vVwauk8qFMUF0sZavFmrPg4/RLfOznmfZ22bGBmlZvSTfevLOJy+B5+wBTz
         klBwecwWXB8cgCxfudmK7RrkA+jgfpn2/jqKVFCahI9DUDD6efQu7Ugreyifdz34dWtR
         UG5S+WxrW+A+9j+un6/DGXjPZF27FNUD/atw+nihnCjvllzOcH2mVL372EXUnEWUD4pV
         SQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706897328; x=1707502128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6k6f7aElP7VLNFd5TSd36D2rwgbRDtNHJQ2BO+8c1Y=;
        b=OEemnNF+NJ/qheUXgedPrZgqhstrmChWWFhg5pcedIEgYtd8ye3On+/CpjXKbi1Nph
         EinFJ2nWcR4HeGHdg/3ZxniDEt8cuRmAGGgqE1nHxf2htZG5XgOPAKSviZBHugtx783Y
         3933tDRVW2vkVudCpJ4RP3dkmRavlBVRbbvFrsZV1/dQKElx5im0ssCExEGXRrBHFSOg
         1HzP1JLKhpUPjHFalf/hFKh6EbIFlXcOhAR8U4g46rdvEj1AEreXhBnAdXuLcnSI2oJS
         INyLu4/bpSpqNAwCUioemQfTsO/djFcgYp+fF+Wl+WKG9PfwvRKmigxRAYPP9dFsRV2j
         Yfrw==
X-Gm-Message-State: AOJu0YxFGr1ewcw7r9TsQq6gO0FluTxybMiGbOKF6OQw4LrUJ1AmkoYS
	2nV99muVWJ6CzrCqi0koW9ExRwH9M0exngNZBRMR9JzzeMFiakqjSkNX6CLlFfsTNSJ5
X-Google-Smtp-Source: AGHT+IE0UxXVvWC/7IgNu90xj6SLY7jPWaNIyYv7/BDsvh+924m/IfR2Deg730aOeeaF+74WWyIS7w==
X-Received: by 2002:a17:906:258f:b0:a32:b376:489d with SMTP id m15-20020a170906258f00b00a32b376489dmr1963359ejb.21.1706897328170;
        Fri, 02 Feb 2024 10:08:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWaLAI5Nm8BH0Rzod9H0hrG29E6FsNst7vpQBztE5rDa7BDm5XUmBrBZkyo2NbtACO/IHlAEk+ux5b/aQbm4FAr7+0lhnTwpNBZKDnyMNtHoFsaIvpWKIKaWm2dYks6ALOm4xyzEf1dCDnc9ebWSqSgmYOvtHtUlaxx8u3PXfWIjyWvXBUYtyPV/zLueKhLjNh4cAcop+fOkRd3b1Fc/cLqDU5URos9FMlOAkg4LHGYqUXXdnUBPmapHoP9PpU6CtEUDL1J3urfx+DMcJ5Vrb3fXWJREZdZAEdqKy6zI0/UZbOTn/JZ8ikQtR7Ly5elOdDCpPZ8F1NENw8ZLpaE7IyQJeLaJh1sc0VQPgCAESf93ffOZ/psBKylSNSO+luIsNJZxKKSVwSi4Newey4i9+m2aWGkj43hu6Yo+pXv+xb5J05cE3stMOaeGDowt30OdvnM98Ivvav+Jfp1OqjRT6jdwIgzJ/KgUvMRl0Oqu0SQva1FOmAZem6QT/hfoCON2Zrp2DlrgSgwwbk30GLR7qGl9PJBPsuEt5AZDhswGFmQTVz58M26Q7mbCh30NOrcuoO87evxmmRBNR1Q+HfpT2X5N0OMDVrKl1ITZ3LCCQ8BIz3wuf4HI1uYBTpfo4BstwRsohafUJsk4p5fhIGz7psagTZ9BaeEt98jzloTRZrGcigGdoy1
Received: from [192.168.178.138] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906595500b00a3109a492d4sm1093613ejr.20.2024.02.02.10.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 10:08:47 -0800 (PST)
Message-ID: <6f92d882-f0c3-4345-878a-bc09b2f24fae@gmail.com>
Date: Fri, 2 Feb 2024 19:08:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Adjust n_channels usage for __counted_by
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Franky Lin <franky.lin@broadcom.com>,
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
 <a91c6a28-6762-41cf-bb85-09e79f3d29d4@gmail.com>
 <d4855223-4323-43f1-9a29-e279e2cb128c@gmail.com> <87v877tar5.fsf@kernel.org>
From: Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <87v877tar5.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/2/2024 11:34 AM, Kalle Valo wrote:
> Arend Van Spriel <aspriel@gmail.com> writes:
> 
>> On 2/2/2024 10:58 AM, Arend Van Spriel wrote:
>>
>>> On 2/1/2024 11:04 AM, Kalle Valo wrote:
>>>> Kees Cook <keescook@chromium.org> wrote:
>>>>
>>>>> After commit e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
>>>>> cfg80211_scan_request with __counted_by"), the compiler may enforce
>>>>> dynamic array indexing of req->channels to stay below n_channels. As a
>>>>> result, n_channels needs to be increased _before_ accessing the newly
>>>>> added array index. Increment it first, then use "i" for the prior index.
>>>>> Solves this warning in the coming GCC that has __counted_by support:
>>>>>
>>>>> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In
>>>>> function 'brcmf_internal_escan_add_info':
>>>>> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3783:46: warning: operation on 'req->
>>>>> n_channels' may be undefined [-Wsequence-point]
>>>>>    3783 |                 req->channels[req->n_channels++] = chan;
>>>>>         |                               ~~~~~~~~~~~~~~~^~
>>>>>
>>>>> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
>>>>> cfg80211_scan_request with __counted_by")
>>>>> Cc: Arend van Spriel <aspriel@gmail.com>
>>>>> Cc: Franky Lin <franky.lin@broadcom.com>
>>>>> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
>>>>> Cc: Kalle Valo <kvalo@kernel.org>
>>>>> Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
>>>>> Cc: Ian Lin <ian.lin@infineon.com>
>>>>> Cc: Johannes Berg <johannes.berg@intel.com>
>>>>> Cc: Wright Feng <wright.feng@cypress.com>
>>>>> Cc: Hector Martin <marcan@marcan.st>
>>>>> Cc: linux-wireless@vger.kernel.org
>>>>> Cc: brcm80211-dev-list.pdl@broadcom.com
>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>>> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>>
>>>> I'm planning to queue this for wireless tree. Arend, ack?
>>> This slipped past my broadcom email. As the Fixes commit is in 6.7 I
>>> would say ACK.
> 
> Thanks.
> 
>> Cc: to stable?
> 
> Is commit e3eac9f32ec0 in stable releases? (I don't follow stable and
> don't know what commits they take.) I propose that as we have Fixes tag
> let's not add cc but instead let stable maintainers to decide.

I confirmed the commit was in 6.7 and the latest released kernel is 
always handled by stable kernel team. kernel.org main page always shows 
the active stable/longterm releases. That said I have no problem with 
your proposal.

Gr. AvS

