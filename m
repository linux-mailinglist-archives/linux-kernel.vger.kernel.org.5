Return-Path: <linux-kernel+bounces-125823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E6E892CBC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FA2283946
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 19:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE950200D9;
	Sat, 30 Mar 2024 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qmNRCtzQ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8F1FB2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711826202; cv=none; b=jLfrIt7QqZeU8nV4j+L2ocOXgn6b0UsPR8rZAJolOnmdbeN3D8Zm1giSns65DzvXO+oCSH1G3/YEKfAf1XflX567fOifZw52ouC5mYPYovwRb+UmqjcxFYHcRA1DBGpdvpl1K0bCp1IT1npPWJy5FWCqErN8yDtLXUoLBSeFk34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711826202; c=relaxed/simple;
	bh=PQzYSWdGRZ4cP6dDQDh9zJNjx7idEEFn4m16bjTIUgQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcSnppYGQGOWJRBSfLGg5SKX8P99zpK1CGmiowqq6lIUBCzb4EVyT3XNMlqXxcjX+4/F8tXla9oyUrGhqzSQDOsA5VKRDgTTTxPnJ0GsCg84i1Mlfoxikea8Q+9s+/xRykx0K/csZUihZO9ulHQ9FONwJ7NpwSvFg/xbtzKMrNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qmNRCtzQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so36866971fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 12:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711826198; x=1712430998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AzNO0eylLRmxl5CKnUgMEhP824tSUajOLCWbmq5S9Gk=;
        b=qmNRCtzQ4TlZgMH9rV8P4aNkkaD618EiJK30N8EMak4Lvpk5SQ/mzg+5+uVRjm6zAO
         gSseMDaSYsz8oZv+gWq0LBFDCfRjVfW2hyLWfWPKZSrzvCDjLEVrLSq8QO+L+UM96qlf
         RK6nUUInRsM4iky1vMZgnV9z32awsM6/Ihwhnq/pK3zwh2pW7ls8xD54qlKAfnT7jr8F
         xZUGAYo3q5/+kgJHhtnbpOyEFkdeBhjeXqdMeAOQNpoaFl9rT/OUrZzG4VWeyPg0qhfz
         3wnK/LY1/4WK10zlgM2/VvbHFC4I7gjNJ1icrogVIyM497JOfcFLzKXmsmNAFnSaZWSi
         cEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711826198; x=1712430998;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AzNO0eylLRmxl5CKnUgMEhP824tSUajOLCWbmq5S9Gk=;
        b=PaAkxhFcVeGUVuG1hzlB9YRJx3XuWc4JOhpuezn9tTcs2JOI4HvspSstOaxVKgl5iK
         XF9dCVw8bivKVEicglDnN7YIcAp47PvqWDxmaiFg+g7uPJrG3hChNuJc2X9H0XNo7Rxg
         xw4pfXg8zLW3V7X6fmyD49EsLqQoCA8WooiTH3LKg7JwrYvJRDgfdsnKrYPpfDHntz+u
         9u6hHbYJ0Phmv8IWyfhHc/6owXnYt9Tug06KQEkBKPSFSqyTAkBnuycPaC8I/NcrbIbL
         mvxHaS1Noq0UzaslzsGAPMz4YkdvH60woj1bTf2Ev6yDzeJn0V0uqBRAf1bwnB/WYI+F
         cmvg==
X-Forwarded-Encrypted: i=1; AJvYcCWHkdt+EdJpKOjpqLsQnLynybxHVx+q3OYbEWi2IUSxaZsSptUNHjrG3fCzL/VSXmZ948/JcfyZH/UMUAwo8jFaALLJQKFN8O7yLobb
X-Gm-Message-State: AOJu0YwC01Lj/cjrIiP9adz+w46DQHEjodwCt81Frx1y+jLLjRqbreGZ
	TsSq1DZfNPWDKzV+BQMkOQH9y4+p5dLSr5PAWhhQ6lzz79foJt5fu+rfpUKwQM5PrHA3J9vb/QI
	pneibesU+MnctYrGDLglD1Gmf8DnZvu5vH3LHcw==
X-Google-Smtp-Source: AGHT+IGYhkeCNEphM9rgDRQN7Cv6JelN3QFP9e89R69ipGch9sbXM4htepuLkkotAqfGavqXEXQJ+tx9mYuPKfWH56I=
X-Received: by 2002:a05:651c:20c:b0:2d4:5d3e:9650 with SMTP id
 y12-20020a05651c020c00b002d45d3e9650mr3886410ljn.43.1711826198066; Sat, 30
 Mar 2024 12:16:38 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 30 Mar 2024 12:16:37 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <9db0fc7b-f24a-4d76-b8bd-ec577ecba0c6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325100359.17001-1-brgl@bgdev.pl> <56e1c63a-4c09-4d92-9ef2-aad5390879cc@gmail.com>
 <CAMRc=Mf_pvrh2VMfTVE-ZTypyO010p=to-cd8Q745DzSDXLGFw@mail.gmail.com>
 <CAMRc=MfsVWcoMC-dB-fdxy332h-ucUPTfEUMAnCt5L-q3zJxWg@mail.gmail.com>
 <82f94b54-82d1-49b9-badf-63d948b347fc@gmail.com> <97e1f121-9e84-4e63-9c9c-57e2de0b29d7@gmail.com>
 <CAMRc=McLJFGcy-A6PZNmjgDXnvx8z0J4k-Dbak-txvWnycHG2A@mail.gmail.com>
 <2b1dc031-d645-494c-9103-a2bb422ea60b@gmail.com> <CAMRc=MdoSPuedbGhy4toDEkw0vSzESDz2bXGpyt_=R4hqXW+Uw@mail.gmail.com>
 <9b1e5ea0-bb32-4c42-b2e9-204bde31b905@gmail.com> <CACMJSesvM6_PhhR_2sP4JX6bR4ytVVg=MwWBEVrCHf5FNp2JXw@mail.gmail.com>
 <9db0fc7b-f24a-4d76-b8bd-ec577ecba0c6@gmail.com>
Date: Sat, 30 Mar 2024 12:16:37 -0700
Message-ID: <CAMRc=Me9x1OXKXXxyhzZ6mxffmaoq=4QhMXCL6L71_xso2epWA@mail.gmail.com>
Subject: Re: [PATCH v9 00/13] firmware: qcom: qseecom: convert to using the TZ allocator
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Guru Das Srinagesh <quic_gurus@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 20:57:52 +0100, Maximilian Luz
<luzmaximilian@gmail.com> said:
> On 3/29/24 8:46 PM, Bartosz Golaszewski wrote:
>> On Fri, 29 Mar 2024 at 20:39, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>
>>> On 3/29/24 8:26 PM, Bartosz Golaszewski wrote:
>>>> On Fri, 29 Mar 2024 at 20:22, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>>>
>>>>> On 3/29/24 8:07 PM, Bartosz Golaszewski wrote:
>>>>>>
>>>>>> Both with and without SHM bridge?
>>>>>
>>>>> With CONFIG_QCOM_TZMEM_MODE_GENERIC=y (and the upcoming fix) everything
>>>>> works. With CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y things unfortunately
>>>>> still get stuck at boot (regardless of the fix). I think that's
>>>>> happening even before anything efivar related should come up.
>>>>>
>>>>
>>>> This is on X13s? I will get one in 3 weeks. Can you get the bootlog
>>>> somehow? Does the laptop have any serial console?
>>>
>>> Surface Pro X (sc8180x), but it should be similar enough to the X13s in
>>> that regard. At least from what people with access to the X13s told me,
>>> the qseecom stuff seems to behave the same.
>>>
>>> Unfortunately I don't have a direct serial console. Best I have is
>>> USB-serial, but it's not even getting there. I'll have to try and see if
>>> I can get some more info on the screen.
>>>
>>
>> I have access to a sc8180x-primus board, does it make sense to test
>> with this one? If so, could you give me instructions on how to do it?
>
> I guess it's worth a shot.
>
>  From what I can tell, there shouldn't be any patches in my tree that
> would conflict with it. So I guess it should just be building it with
> CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y and booting.
>
> I am currently testing it on top of a patched v6.8 tree though (but that
> should just contain patches to get the Pro X running). You can find the
> full tree at
>
>      https://github.com/linux-surface/kernel/tree/spx/v6.8
>
> The last commit is the fix I mentioned, so you might want to revert
> that, since the shmem issue triggers regardless of that and it prevents
> your series from applying cleanly.
>
> Best regards,
> Max
>

sc8180x-primus' support upstream is quite flaky. The board boots 50% of time.
However it's true that with SHM bridge it gets to:

mount: mounting efivarfs on /sys/firmware/efi/efivars failed:
Operation not supported

and stops 100% of the time. Without SHM bridge I cannot boot it either because
I suppose I need the patch you sent yesterday. I haven't had the time to
rebase it yet, it's quite intrusive to my series.

I can confirm that with that patch the board still boots but still 50% of the
time.

Bart

