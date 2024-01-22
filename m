Return-Path: <linux-kernel+bounces-32491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A7835C51
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6772827F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1C918C38;
	Mon, 22 Jan 2024 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsyE6qUe"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7FD18AFB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910908; cv=none; b=ofPXDiQskKP8fw7Bq5wQ/1RtTCnH5t48vV7ukGjFIBHwaHO4MOGjYnX2PdQnYXtXzJCyOG9rpRtHD8UyqF6ak+YPyQyaBsOTVLY0EA9Ik2zKQIR0ZzwVyIeMPyL8H4PHQ2WUr7W2XoRhg/8tR2O+IyM70Ay3RU+bE6+YLRV+LnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910908; c=relaxed/simple;
	bh=JJ1inQIP5uiqCQ2ktxCodtSUjm7NkRAfTdl5UMOjwFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qC6PWks+bppOJh5ZKoMlhvWwga6q63qqCNs2BnzpNC4XAI5QgCyBA5ykYhyYU/77VDPOXJhehms7J81PaKRDEN82YzBTVU2l2T9iYbH+SY1JOWB9AsKGkEedhgm9n+Es7hrr3WwXFQufagkW+AbTb59QirkYhsC1VdZS/TZ+ji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NsyE6qUe; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40eaf3528c8so3163525e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705910905; x=1706515705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljxRrYk3P84s9G/mrheKlxc/t+X1N0QJvAOyGscIczc=;
        b=NsyE6qUeq23jqVAFh43pmQ0uQ/qKRHIjFfq39/49uVyZppgkt0k3JohgCq/Z3PSu4l
         wBtv4L6Kt6ofxllCuVN++ze+lETHPZqgVglySBUDFiRsRShTzW5Q3TTqokR9s35hZZyk
         CPcg5e1SuJcumJpAZT6pIZdNT3VFbOkWeaTCOlWUtnlcSaUiQzZIGPfyj2fxrJjhsNls
         RgZYpbXi4Fa9HLYkWp0fyxUF98dS43zCP4LpQGDV8pr+1/IwKojMyjXn3m2lNykj7SRJ
         POxsE8wKMVG2yIWPRwNITBpUtuzIecHXSHRKhP6jaBYbgeoAGVCpmjuRYOPAMfad9tOI
         ebqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705910905; x=1706515705;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljxRrYk3P84s9G/mrheKlxc/t+X1N0QJvAOyGscIczc=;
        b=WEiY4i9xqM1v4737/GAAoZjF1VIo9IsGbIpm9/vb3hQFP5pvvJDx4Pu93+C6ZjULCc
         9qjbKtFLgKP4TIS+GHKPiwfmhXEdsOxI4P1l9ABiryvve1Fr4KFgnEllntIeZ2+PNnm9
         BlBfN2F7xDh5WDJm9GPnatIQWyGgmxJdjB1yAygh/z4ANqcpUB2YetZRXNH9yPZgq/3p
         qCUsnhJc8K7LyKrEUDBMRyoAthsObLoHf2kpZ67usZZE2AaghqywQ4UisbP/UTdlnjG6
         g/e/Kl0DQA3Uv28U9/duDZRlx7YwYLpI6vzuNJcj52999Jfu5RO8m5sJ1RN0ZNJEq6dQ
         WYaA==
X-Gm-Message-State: AOJu0YxgyzYqKTI+QYTZrQR+ByDgXsb9sWhe/4DQE8eKDKFpxlCv7N8j
	UyUSLkXFnvlgjd5/UV2TabkJhW5JpRGcSTUkzdVCPZaxnmJuZt6IIjHpD8HXrOM=
X-Google-Smtp-Source: AGHT+IHUaQRzlvIdl9RygGOemyjUeJK+jz3LnrAoFb9NTzVpbM1JlXQ7Uo3ldRvnYWuQc97RiIadPg==
X-Received: by 2002:a05:600c:332a:b0:40e:5aa7:769d with SMTP id q42-20020a05600c332a00b0040e5aa7769dmr1981343wmp.143.1705910905064;
        Mon, 22 Jan 2024 00:08:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c501300b0040e813f1f31sm22576287wmr.25.2024.01.22.00.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 00:08:24 -0800 (PST)
Message-ID: <5a2f292d-efdf-4647-89ce-e4f5d28c7192@linaro.org>
Date: Mon, 22 Jan 2024 09:08:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] HID: touchscreen: add himax hid-over-spi driver
Content-Language: en-US
To: Tomasz Figa <tfiga@chromium.org>
Cc: Tylor Yang <tylor_yang@himax.corp-partner.google.com>,
 Doug Anderson <dianders@chromium.org>, jingyliang@chromium.org,
 poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org,
 jikos@kernel.org, wuxy23@lenovo.com, conor+dt@kernel.org, luolm1@lenovo.com,
 robh+dt@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, poyu_hung@himax.corp-partner.google.com,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 benjamin.tissoires@redhat.com
References: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com>
 <6c7d9c92-7616-4fad-806e-44302c33b63c@linaro.org>
 <CAAFQd5AN-1FTHZcE1Eja0Jd4iqpDocZSz19F44RxqtvKs6ikeQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAAFQd5AN-1FTHZcE1Eja0Jd4iqpDocZSz19F44RxqtvKs6ikeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/01/2024 05:57, Tomasz Figa wrote:
> Hi Krzysztof,
> 
> On Wed, Oct 18, 2023 at 2:08 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 17/10/2023 11:18, Tylor Yang wrote:
>>> Hello,
>>>
>>> This patch series adds the driver for Himax HID-over-SPI touchscreen ICs.
>>> This driver takes a position in [1], it intends to take advantage of SPI
>>> transfer speed and HID interface.
>>>
>>
>> Dear Google/Chromium folks,
>>
>> As a multi-billion company I am sure you can spare some small amount of
>> time/effort/money for internal review before using community for this
>> purpose. I mean reviewing trivial issues, like coding style, or just
>> running checkpatch. You know, the obvious things.
>>
>> There is no need to use expensive time of community reviewers to review
>> very simple mistakes, the ones which we fixed in Linux kernel years ago
>> (also with automated tools). You can and you should do it, before
>> submitting drivers for community review.
>>
>> Thanks in advance.
> 
> First of all, I can understand your sentiment towards some of the
> patches being in a very rough shape. As a community we have large
> volumes of patches to review and it would be really helpful if new
> contributors followed some basic simple steps, as described in our
> "Submitting patches" page...

I don't really understand why responding to something which is three
months old. Anyway, I talked with Doug on Plumbers about it so things
are more or less clarified, however since two Google folks responded,
let me continue.

> 
> That said, it's not a fair assumption that there are no steps taken to
> offload the upstream reviewers community by the corporate
> contributors. We usually do have basic internal pre-reviews for
> patches coming from partners and even a pre-review bot (CoP) that can

Good to know.

> automate some of the checks such as checkpatch or bisectability. But
> as others said in this thread, we don't control our partners and they
> are free to send the patches just directly to the mailing lists if
> they want to do so. In a similar way, not everyone in ChromeOS is
> super experienced with upstream submissions, so sometimes they may not
> be aware of the best practices, etc.
> 
> I haven't seen the patch in question, but I'd assume it's more like an
> exception rather than a usual pattern, so I'd appreciate it if we

Unfortunately that's the pattern. I was complaining few times about very
poor quality of some patches from some partners before writing that email.

Just to clarify: all the complains are about missing basic stuff, like
running basic tools. They don't even require internal review by humans.

> could avoid aggressive responses like that and try to solve the
> problems in a more productive way. Just a simple response with a link
> to https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> wouldn't really cost you much, or actually even less than the entire
> litany in this email.

Simple response to docs don't work. Docs are quite long and contributors
questioned here just don't read them in details.

Best regards,
Krzysztof


