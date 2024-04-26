Return-Path: <linux-kernel+bounces-160232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842818B3AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389AD1F26EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168BD16130A;
	Fri, 26 Apr 2024 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0PQW8Kz"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DBB14901E;
	Fri, 26 Apr 2024 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144199; cv=none; b=E+TNw3iSSHsnDmPNiNeiGNyVrKqc5g3bY3Z2Ijras2Vqr6Kf0uBsLIOrK/7VDWvadBbmiorTcQxY3aqsAixK+trkVK0kRWBzP4BSXuLTJbm3VLClo5GQKD6jHvCTT0d0M8vWbnTGBMZtc6tY6ufezCTVk36VXvzKCTmLRPqwBK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144199; c=relaxed/simple;
	bh=xAg1rEdSJo2cPRDE/hmbrMFOFTdNt/KfxhhHxARRQXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m27ajSenVRLeMUGqi7zFdFqbG6IuGdmpLh25NWAWtn1xXV+sTpuV/RMdB2O47Ts9Icy1qT+bjAjad2SRNlj6TtS9W2n4uXAkgxQ030nTRRM3jbV++Xkzb9bzma+9BSzRJjY165wq7lrtR0wV/XxkOjFUaO02qPw7Xhe8tFpJB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0PQW8Kz; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so28085961fa.1;
        Fri, 26 Apr 2024 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714144196; x=1714748996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM5g5oluFXmlj44Ib9JNWX1cNnZgigxMRLezmSbkjDU=;
        b=V0PQW8KzuH3bhahxtIJpqGgqKFxTf2LLGDy82CcnHFNm6wgI/NHCh6TY+4vH0+A6NC
         8t3MbBJl2bHZJIGewqO2VxbeuCoVg5FGdO/MT+DRN1R22qjE7lJ69EH9L1yv4Qy2+aOo
         I5a96emB2Fl2Akq6kJkXLp/JCH8AEvMZMPFd3KZtsJKti7+28KKUZbhv9S75BRrlXXji
         RnCtQchVdjhRs8HYZImMLwFNWWIec1dfI2LejMlZ2YKkHj8IVcqc3cgJ/JAhLC2VTLT4
         lykmqgvIAchF0d9yRzoVcDEw/Hpwx1ZzPUuSctbpcFAQxzi69EISAj45y1JzI0e805nM
         uc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714144196; x=1714748996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QM5g5oluFXmlj44Ib9JNWX1cNnZgigxMRLezmSbkjDU=;
        b=JQXm571hLnwHCGN0fjdMGinCKMYKn+RVoy9AcqL7yCtCqIllMI7BTtDQ9W2oJGsTXl
         yFkD0pd4/cC4uREvm18lcpqiscjzYATdRpUxTdgOSkNC9xb2uH3/ejSY/EznINFUmXHV
         02uyCjYmb1JbPx5npVrJT7U5Z5ZqCPiQj/6Ow2yFwlU/tKAJ7bYfyNUUGNeNVN+p5+De
         YFGjljykCD7FfkBX0lrLriGQO7zqZTK7NdeBl8oqxgAvvcB3FEDw3RIh4SYcv8NjpZEd
         19fOTbLl7SyW6LxunO35Sn5RPlqAStOIrI/hntK1D4Ha6c4Cj0q5OdYHMdqdH36k048H
         FZLA==
X-Forwarded-Encrypted: i=1; AJvYcCWgBlkLKwHKsFc+zDp6YtKEhUyUiDQHL+3/WDK+TbusxLQTnhAJS/9xwXjawBl/JGyelPnTX6mCDeZGzJvXMssz+V7mXbCCVo5Gl9k7GenQsM0SFMwe8d0AofvoZx/nXZt2IUknWkX7t6nRViRJ
X-Gm-Message-State: AOJu0YzbUcHZ7lJNKFgsZy6erjbpiw1qLMA6/xvx6kQ2/xpk26LvjGfw
	cIyp+gNzXKB0upyXzCyL7B8831ZjLTF3r2G8T4UH97uzmVeRVG/bNp87S1BjAJbYZP70T1/5GIO
	EpEqP252UKdleiaB+LXlZprKpIHg=
X-Google-Smtp-Source: AGHT+IHjGA+8BSpP9IX601ErZtEjqToo4NRZRL8kUVVAJvuSuM4qoyqiqfzKsueRULrcpzPd8ls4usMH1P6ggmAVLcM=
X-Received: by 2002:a2e:9684:0:b0:2d6:d351:78ae with SMTP id
 q4-20020a2e9684000000b002d6d35178aemr58304lji.29.1714144195629; Fri, 26 Apr
 2024 08:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424122932.79120-1-brgl@bgdev.pl> <171397322792.12898.8815870206676100532.git-patchwork-notify@kernel.org>
 <CAMRc=McMMtRid6OaYsc0PO0qsS6z+Ny127YxwNcjbo7R2Mze2Q@mail.gmail.com>
In-Reply-To: <CAMRc=McMMtRid6OaYsc0PO0qsS6z+Ny127YxwNcjbo7R2Mze2Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 26 Apr 2024 11:09:42 -0400
Message-ID: <CABBYNZJOdccb4HKVBnuqK=_xVzViJ2D2+QJPSyyFGE2_Y1VXCg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: marcel@holtmann.org, krzysztof.kozlowski@linaro.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bartosz.golaszewski@linaro.org, wt@penguintechs.org, quic_zijuhu@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Fri, Apr 26, 2024 at 10:37=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> On Wed, 24 Apr 2024 17:40:27 +0200, patchwork-bot+bluetooth@kernel.org sa=
id:
> > Hello:
> >
> > This patch was applied to bluetooth/bluetooth-next.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >
> > On Wed, 24 Apr 2024 14:29:32 +0200 you wrote:
> >> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>
> >> Any return value from gpiod_get_optional() other than a pointer to a
> >> GPIO descriptor or a NULL-pointer is an error and the driver should
> >> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_q=
ca:
> >> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
> >> power_ctrl_enabled on NULL-pointer returned by
> >> devm_gpiod_get_optional(). Restore this behavior but bail-out on error=
s.
> >> While at it: also bail-out on error returned when trying to get the
> >> "swctrl" GPIO.
> >>
> >> [...]
> >
> > Here is the summary with links:
> >   - [v2] Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpi=
od_get_optional()
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/48a9e64a533b
> >
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> >
> >
>
> Luiz,
>
> I think patchwork borked when picking up this one, here's what the commit
> trailer looks like in next:
>
>     Reported-by: Wren Turkal <wt@penguintechs.org>
>     Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
>     Closes: https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-gi=
t-send-email-quic_zijuhu@quicinc.com/
>     Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use
> IS_ERR_OR_NULL() with gpiod_get_optional()")
>     Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>     Tested-by: Wren Turkal" <wt@penguintechs.org>
>     Reported-by: Wren Turkal <wt@penguintechs.org>
>     Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
>     Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
>     Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Reported-by and Reviewed-by tags are duplicated. One of the RB tags is mi=
ssing
> a space.

Oh crap, should probably not trust patchwork would pick up the tags
properly, that said the pull-request was already merged, not sure if
we can do something about it now?

--=20
Luiz Augusto von Dentz

