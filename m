Return-Path: <linux-kernel+bounces-49636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E41AE846D34
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5040E1F23385
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF77CF00;
	Fri,  2 Feb 2024 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTb8mLHu"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548587C084;
	Fri,  2 Feb 2024 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868057; cv=none; b=kgfiS/R6Oya0JsdS+hlp+9oTrFLQqRKl8usaugddDYFXuoHxS5mWAeLPR7n783xDWnYtc6xoaa8p/qVYC3KAT27yk+jikcQ85/MIp4M7mVZBAFdbUbL0gnEqkziI7O2hEUWMpnSRLd9yQC+fff4BgCoRyRJ8ugE7vbbVdxFJlcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868057; c=relaxed/simple;
	bh=9+Lj2EmpVoW3SexRfepzUDlGcwoDBetKy73F3EbDagA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TA265SMcboIkKQulHXK2G4aRVGz07fpH9VJfl/vrJSlz0EZva/I6r1E92/vDYjxjd29evn6v9maiz4cncCA2xjPda5IiVzwZ6/E55dDnfwTVIetEf8fNIWUJomfCygKE6McJa2cd2G4NsTUspeLcsgy6KjGOxqGIfPqjrcnQc64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTb8mLHu; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a0ba5098bso10546221cf.0;
        Fri, 02 Feb 2024 02:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706868055; x=1707472855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PaTKCXkjzVrJJOZgvzI+IQZUbVjwGuyWO0oQJMYNm4=;
        b=nTb8mLHu0FRIKDYHMNFeHf1vwgmGbVSymCJApweNYx4iWCzPa9t3rqKaOSGHToQd5o
         DlO6QbuAEyQ8VsnP0FEFpS4NpRZcBMTx4KiMFwIcvipXw9UnxjN6LtLdaYTd3IAm1Ylf
         jOUJ+Zf8OAgnIqP73z8wftcTeRlVQ5mOKsEyXiI1htauifLjVfbEaPKWjowPYaHSmoOm
         iyY0yi14h/D6lTub/cuyyY/Js6Kfqcf6yMSS3BCUn3ws/kb1FG1FRCmYGu1knvuQTBMC
         6pW1qGFjzf+C1CczA5w1egxF/5vnKkzQPrrptGqpcncYzZcWY7HmPXuCu6qKAXOJj70z
         6Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706868055; x=1707472855;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PaTKCXkjzVrJJOZgvzI+IQZUbVjwGuyWO0oQJMYNm4=;
        b=KIm1APQBlY303uVtYIzy5HHoIeeD9xNTkJqfDfmjE5hw95WjLdr9HuNhLZUl3luNCf
         S3Ogl2bh5+PxjaK2fF9Nox6JBmHUfYB1C7QLKtioYVCUNEaWIistwN9EQQSmhrReGno6
         AxsP3uurnNqPVrEoaVdacgqSJ7dqWuB5/t0mzz3sqrVURg1+BwKlgRVxs0D27pcgccLN
         nGAXzMLTcF/oGzxK60qqiaCEigGyX2vUgecJ5a7/+pDfKsxheA89Y8SxeQWpo4ejY+KM
         jv4C6uNk+ir9XLyoJRIX3zGgZaCbrtnpodUbWeFX2aa/82sUrvUDP1ZmppFVokm4wuwq
         u/0Q==
X-Gm-Message-State: AOJu0YwwJYqIoq0+YdhjsunnJ2IFM4fj6q/OGG5uL+32LH51IVN5pWx6
	ptSzuiQQAbi/U/KxZ3rfGsaJJTC/OjCvApx1s8KFpmzmgzMGxrlp
X-Google-Smtp-Source: AGHT+IEYNlUKm7mfRnbGk6njjpfW3hEVDvBF0bF5R5gXazcJa4f5UU076+PpYeeK2iZVkEspOClYTw==
X-Received: by 2002:a0c:e407:0:b0:68c:87c9:a02e with SMTP id o7-20020a0ce407000000b0068c87c9a02emr912598qvl.41.1706868055111;
        Fri, 02 Feb 2024 02:00:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWg4QkcdPzJeghdlk7cZ1IVtrhsVvsVst+74ZsRw612vN6XPb4nqpIT4v9cyrzZBGXLUFL49ZEIqcdQOaOBJN+YxAhcMY/MzJN/wgbMqG+FZVNX7V2vMR0sRzUWsSh9EXMTV9Bd7kwJA3aenUgmLdioIReUbMi2MRoUGNwc8JYuX7Wktp7zXlAkXxZLR9eT1i9UnApXfZ0pTOp6QJV5yLQDSvsPgcKI2SZaL/Cz30ChJVv0FZpTP1sFaWRBiLX+YTy9G+V2fD9w/4TcEr0qg3s7uOdjlKN6doIL+FlyvLyTgpElNRIuqdauYxqGTwRrR+J2mEAs4WIUrRcqHXUG9CN2MflWIDUzSRmQRGufeR51cH3V8ZlovM+wLTumpuXOiRqZBfEbYqq9CJ3AQTDBXCdkua9KhOrD/AHqc1nWJ43eC+mNQ0nelaU9Y21w7CcELM3I9k9Dm8kFMPnsNiWUFnVWrJDJAS9WOfB2wl+siJLc8ZsBDUPxB/W8q3po5cKPpjtmWmi7sGe/+qEBF8SBrIRKGOpxDX/Bto2CU+SYnzr6gYNYf1mMPbu39Y4EADS0dwHSprx7FGfbreJSoiZeQ2bqMckwOVFQge1ing6mAZ+k4Gi+clL3QUjqHxhcorXJ4DLbn9S4a3zzNYXR5l3D1gi6iucV7cZItkI6tQuFQicaLplTJQ==
Received: from [192.168.178.55] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id dr10-20020a05621408ea00b00686ac3c9db4sm659095qvb.98.2024.02.02.02.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 02:00:54 -0800 (PST)
Message-ID: <d4855223-4323-43f1-9a29-e279e2cb128c@gmail.com>
Date: Fri, 2 Feb 2024 11:00:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: Adjust n_channels usage for __counted_by
Content-Language: en-US
From: Arend Van Spriel <aspriel@gmail.com>
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
 <a91c6a28-6762-41cf-bb85-09e79f3d29d4@gmail.com>
In-Reply-To: <a91c6a28-6762-41cf-bb85-09e79f3d29d4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/2/2024 10:58 AM, Arend Van Spriel wrote:
> On 2/1/2024 11:04 AM, Kalle Valo wrote:
>> Kees Cook <keescook@chromium.org> wrote:
>>
>>> After commit e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
>>> cfg80211_scan_request with __counted_by"), the compiler may enforce
>>> dynamic array indexing of req->channels to stay below n_channels. As a
>>> result, n_channels needs to be increased _before_ accessing the newly
>>> added array index. Increment it first, then use "i" for the prior index.
>>> Solves this warning in the coming GCC that has __counted_by support:
>>>
>>> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In 
>>> function 'brcmf_internal_escan_add_info':
>>> ../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3783:46: warning: operation on 'req->
>>> n_channels' may be undefined [-Wsequence-point]
>>>   3783 |                 req->channels[req->n_channels++] = chan;
>>>        |                               ~~~~~~~~~~~~~~~^~
>>>
>>> Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct 
>>> cfg80211_scan_request with __counted_by")
>>> Cc: Arend van Spriel <aspriel@gmail.com>
>>> Cc: Franky Lin <franky.lin@broadcom.com>
>>> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
>>> Cc: Kalle Valo <kvalo@kernel.org>
>>> Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
>>> Cc: Ian Lin <ian.lin@infineon.com>
>>> Cc: Johannes Berg <johannes.berg@intel.com>
>>> Cc: Wright Feng <wright.feng@cypress.com>
>>> Cc: Hector Martin <marcan@marcan.st>
>>> Cc: linux-wireless@vger.kernel.org
>>> Cc: brcm80211-dev-list.pdl@broadcom.com
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>
>> I'm planning to queue this for wireless tree. Arend, ack?
> 
> This slipped past my broadcom email. As the Fixes commit is in 6.7 I 
> would say ACK.

Cc: to stable?

Gr. AvS


