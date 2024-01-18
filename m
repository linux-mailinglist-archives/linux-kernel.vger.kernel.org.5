Return-Path: <linux-kernel+bounces-30188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 586BB831B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC6BDB21E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4E82576A;
	Thu, 18 Jan 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZIzGa0T"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20525759
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705587300; cv=none; b=aAcwaFSwIBgApLDA3788v8jpM0XYrKA2enTGDYHijeGja6+sQYudFKou6KWJffQgEPkGs7KclC5iKV+bYEIhN47W4Lw05KbTXf5zEI7NWNyhqzkHs9gCtDlaUdjjkukZqv/79z++lyIWZ3ZCW90KnHIX/TgqpLYDk3axcWffxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705587300; c=relaxed/simple;
	bh=9xvmJE0htP/uWURUWOqFs+gbJDnfmHDjeswpyr/OtiI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=AwjSQkDx3V9ou46byAfbJTnwTzot3ddhKE5KRS/vihtzzJ0KMl3oj7ZCuypQeV7AzOqo5Utwvh55/m7Xs5ofWf1ZdKyJuNt76ij1RhV0SEXfC9yen9jzAUS7ZYo0jAmXi5oeKwfPyiSp1rBldZYyTKNUqoyUNgzSFL8WtxsCOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZIzGa0T; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-429de32dad9so30607941cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705587297; x=1706192097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9xvmJE0htP/uWURUWOqFs+gbJDnfmHDjeswpyr/OtiI=;
        b=hZIzGa0TODfDh3nIprNUnM+8dPeAM2IWn9S91+IzjAYbArrVQCErSY6qih1KFU9gbG
         E3+vkCNlx7kB0aw59KIW+jNz2/pn/NY4j1HMJoFHVY4aHk0wEWF9cdZ2OP1CmIR0PxIK
         Q7yEiWRuvJhm2haxeElYGkKd08vfMpH0SPEHGQ9nkovY4BVY79+ggKKJM9ZduqKEPHfR
         DS3m95/US1w6TSb6FNuVNlhLFFurBVXRVpUybF0ythIdRxRALl1QFocH6HmEBo0SIDdX
         uNH4ZAMB5bjog7gma7Q0rA9uoHtUQoEUZPfIsF32xZikK89ktCAuto1LObmHhbYqzL7Q
         /JpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705587297; x=1706192097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xvmJE0htP/uWURUWOqFs+gbJDnfmHDjeswpyr/OtiI=;
        b=qR2fS8L+diVOUtbOSOSixuk3sKPDcVKv9B4iUjZEeDitsozSCKKvCoKKWFS6AbfS0O
         ttQP1b4HxcLpDZnjyosQf2Qr8mhRLQC+3zPOhacKuaCluNmEOjdy8Z2i+/3uU8c7aaIE
         /3o/LWXtIfyDpQdHLI3S6rQpSIzo1TvKa4QZfku+b1VBMFN8zJss7kY4UkA7+E6U695G
         hpIeos+8XPu933FktWnqXVKcYImBC9DDwfP/wmO6QsXpAEcvaBn0p9VycCD4USsgYuXT
         57lpAyi/mAwGf4Y5+/m7JrM/QCtuE81U8v4SOjz3rLEDXKyPtFuzRtaj8af34LbUKCjr
         iN/g==
X-Gm-Message-State: AOJu0YwOwGhiibWs92v96tgB0tCwo+8Kh0slptUwgh5w/ZvLIEABJ1TR
	21vkBtyTWtnJX/9ilaslHfqYJaJozhPThAnv846EHxEHCVinWHtyuZBRJhAa2a0OYMoNNgxu/on
	LBPc/tOpkZZ1snNDt91t4I6lJ1AGk8WqU
X-Google-Smtp-Source: AGHT+IFO4M30hPG9uOoEKUA2BlvLEIuWKZLXXe20J/9Vt1dZU9mcko1aXB4sKOdTvpI82E9JV1cqRaNbU4ZC6DmixDk=
X-Received: by 2002:ac8:7d88:0:b0:42a:1c88:41d7 with SMTP id
 c8-20020ac87d88000000b0042a1c8841d7mr764877qtd.109.1705587297481; Thu, 18 Jan
 2024 06:14:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110090107.26323-1-ppbuk5246@gmail.com> <21e77238-4884-40ca-bc01-b7e4774b9239@arm.com>
 <29a13c04-f669-a6c3-4693-af7e44469ad2@arm.com> <CAM7-yPRSY7rz-GCWAS1yY75kD1FUjJTF=_AdCd0LtEhQa9dssg@mail.gmail.com>
In-Reply-To: <CAM7-yPRSY7rz-GCWAS1yY75kD1FUjJTF=_AdCd0LtEhQa9dssg@mail.gmail.com>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Thu, 18 Jan 2024 14:14:46 +0000
Message-ID: <CAM7-yPRfEZnYoZQQophrdQUrAi5=UVfxZ=SVZs=U4MTC6Nyg4w@mail.gmail.com>
Subject: Re: [PATCH] firmware/arm_sdei: Fix invalid argument to unregister
 private events.
To: James Morse <james.morse@arm.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> But, I think it should be checked on sdei_reboot_notifier.
> otherwise, In the situation sdei device was freezed, when
> sdei_reboot_notifier is called,
> It would fail on cpuhp_cb_check too.
>
> Should I add a sanity check on sdei_reboot_notifier in the next patch?
>

Sorry to make a noise. Maybe there's no case for this.

