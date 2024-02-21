Return-Path: <linux-kernel+bounces-74277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E8485D1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB751F272E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106E93BB25;
	Wed, 21 Feb 2024 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFZe0RjD"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FC3B787
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502553; cv=none; b=blEwcRJpBtriz3rCQv9rrYOKk1q4LC0J0WiLH1na9/8HdjPcCp2AsmjVEhv1SxiGmNQJLvsjFf4bTJhof5ILE6EnyFXfUAixEmKPapAQqZ3IDIxXPaV4/OCeJ09JWrfTGghgTCjg/iT6PTq6BCx6r1L4CBRDQV8UIP6pZ8bSL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502553; c=relaxed/simple;
	bh=aXXA5wE26iTBRgLyo53Ck7qjjGy0Lh1LoQcMiP5/WfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hb023m95VvS7CN/4ydd1VM4JniER5jmRI9TgqDw3++j47wybNnlSY965BftkBlBG9jhT2d4/+ik1UkVGRCGBnkkxtZ0MAkgthcM/M6H2t2M0bjHfm77LFtfwvqE2Gp6fLGCt6I80hRbSwSZi+Y6BeC1P0IpkvPE/7CoZEpmBhu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iFZe0RjD; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed0710c74so4299289276.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708502551; x=1709107351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXXA5wE26iTBRgLyo53Ck7qjjGy0Lh1LoQcMiP5/WfU=;
        b=iFZe0RjDQq4TVfAohbPAfQ75xKk89Jd/kVLBFE7te7L16Ntf8eeYOZci3MFBzHkPEk
         RewbvvZvEy6GymdjNtoFf9egfZzYwtZ3S7eGyu8PIovtd/Kqn0Kt6zAnz2EYpbB5Pxbd
         Jln1HbYCaWPVYdGirv/DX696ROtg1c1R3dtVvJ1lZsvxiVRh3wnVByJpS/u4IPOTP4mk
         RFdlxfTbLSUmmbTxO+MCNk6CbK5bR5CBynkcdylldOOA3u0zrkg3IRIET4VUK6rMFG4B
         qTdCyHViyy0W/+6YDJ45d8+HgvfkSI9xq2oS8ObuFZkdr3bgBreSEY2XpG+pLYoKx+XT
         +raA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708502551; x=1709107351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXXA5wE26iTBRgLyo53Ck7qjjGy0Lh1LoQcMiP5/WfU=;
        b=ARpuXy6N0Dp13HudGxcKkBWsujt9eVzXuu3CJTxxU0hvg778uglZnzURsGwJ0qHjAx
         cKuS1tKEaQfku68bYgCnd0RXzMPTpcneLm7pw9WWsLa+nlmbjczurFS+aPzyO9RFtbpX
         pIIVugBaBRLOpWQxalOdDv01XqDcwsHJlvPOAc7mmbG3oT7FFbqE0WFJFnKOK8hbcldA
         ffV5qgiMvVpiIP65usmGiU8xB2I90Y5d80a7BnYrs5wMWRJKdl+1c+HgsB39ti8C6T9I
         xSd47Tc6sL6aVUX8OH8YhOw2As/I7Rb23BjkWhU9fs9dyZzYL57/gyZoHLSX4WbueHP9
         hUbg==
X-Forwarded-Encrypted: i=1; AJvYcCVZAflKMpWLvzfmbwK1dpsEVkuSzfZCQH9QKmTu6Csr2wV8xtjnmjjvL7QDIEAitCjubwDyOSaM5b8v4NQcoLXmau+tdq5q/ONUfM4n
X-Gm-Message-State: AOJu0YwKSpU1HDAKM4sHBr2uR+/oLsrSUAhZ8UDMJVm0eyLe/sZ5KSS3
	V29ASRYxNfChRk+hWtCxzv5GWEfsq7swcogpz0eLbOpEePhuV+/6PXSQuijWgns757pBQDUE0N8
	w8K10hg2i/zzH9O9DaSGDOsw0UCqfVPO7ZxBcRQ==
X-Google-Smtp-Source: AGHT+IHOu+lEk3QXT3JPTa9WAsERKwUgQjv1LIaXMHSgtFqbEMujQEjxOsq8X15+TTcbYj3Qf/+ogQASWM3tqrhXQ7E=
X-Received: by 2002:a25:d08e:0:b0:dcb:d94e:be49 with SMTP id
 h136-20020a25d08e000000b00dcbd94ebe49mr16023927ybg.57.1708502550856; Wed, 21
 Feb 2024 00:02:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220232328.1881707-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240220232328.1881707-1-andy.shevchenko@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 09:02:19 +0100
Message-ID: <CACRpkdb6PSe=nJU+MFq28UX2qMiDGOGGZEJAP4QDFAteorwmGA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: mmio: Support 64-bit BE access
To: andy.shevchenko@gmail.com
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 12:23=E2=80=AFAM <andy.shevchenko@gmail.com> wrote:

> Use ioread64be()/iowrite64be() for 64-bit BE access.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Obviously correct, thanks for fixing this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

