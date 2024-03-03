Return-Path: <linux-kernel+bounces-89680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA83D86F418
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F3728291D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA494AD22;
	Sun,  3 Mar 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ub0UnWT3"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90410E6
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709455457; cv=none; b=pyFQ5EFRh5B099hn19ZvLqI814ni1kM/GAW9pkGjxRmYjUm5qHoO1/8MAtJ2OHMyTdycGuAkNYQezRcNqgZ3RonbqtCavmzcplvKxaLATvPS5/2BvAYmY6+82AOX3HdyD8C+crkEZFzAl//5rtctes0uF7sZXXB5YNnUbKtuxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709455457; c=relaxed/simple;
	bh=3yzzCWNwkQ+PniCKvcwlV8Ttrp62iS99i0D3bBQSZj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGfl+BdHZLUyFIo9m8FGsrKQYHZSY3ngfLOaYXoi+OcpzlxDyydjRREyEwJ3NHI6IQQHr89QD2CO554gdDW0O7kICHyvVlcw8Rw69qlGKchF9YoBLuFpOwUuSx0gGMzfE4ibc8rA+lpojlGGOFsanPMz3NPh/nzZ5CEVREOT95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ub0UnWT3; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a11ed428c5so484534eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 00:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709455454; x=1710060254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yzzCWNwkQ+PniCKvcwlV8Ttrp62iS99i0D3bBQSZj8=;
        b=Ub0UnWT3EqRW5Ej4N/19dR28Edl9i8CynI5NiMKLWJVzJnVnDfs7TFIpk4Ced0HTxe
         akDj86mmE1jtifKtLARViB7CfpGyK9dH6hdI5XuH9jLw6FC5gEemCb7v/rAOlE6p1Y6c
         DKsfUC36P/hzB+ekpKnLzjknP9jIX4uBSaERJpwneH2Z4pHyoubNynOVG9YGbA83NRbV
         Iw0QwIOm/HL3/6w3qB+dFjhISwyE3P/8AJMQBqi+mFGzkUmrclKObPqwjSDQBpzj6kl+
         Z6Nt/GOsuEFZnhSP64DVEDsaPNC69CbMjni7eZJ4+dyWXNAdPbCD6C1g0O3S6dt3EA5c
         CJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709455454; x=1710060254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yzzCWNwkQ+PniCKvcwlV8Ttrp62iS99i0D3bBQSZj8=;
        b=fLi/8oxImjRcWt48isSgfictFV6EIOqQaLjcSZwhaLic9TSZc7gO07q1rqfBcQh0Ox
         wkHCX7S5FVHN6roiYzoS2auek7VePjvZSrNOvLKbqBYFus/CFlLnA1MiiJXpo91TZsTz
         bL8lQ4SzUCuaPQEgVie85clhqvzBfZvGmufO4qXjONV7ogpbRMPv3ppvg/vdahhVKbR/
         13N7DGmBd5nDgTX20ZxOpYyevkvkJJZ3APnhz4JgQpQbUvvsM/Cb5e8L2yt6VE+bhGZX
         QYCj4sNXXnfpHmYbs6gljyXFncLaYAoQSWItvArqAMsJkyUiVXYevTKSkKwe2WBIhuXv
         KRcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCv9eV3myGKSsvzbY8v7WzpYLSi+e2rpAvIFIzeKMdsv5taHOeUBNxrn+6Us/PnUOYm/Ic6PPl4azxrlWUj53lY7JOVEcFS+1dBNNa
X-Gm-Message-State: AOJu0YzQ/PPpr/7mCmdKvUTcQkL77FNp+zAmRCJGSQl1veZJUGa22pEg
	oj7Qb0qABRxlXA0cXQ8WL3sjaqwYa+VuDMoOGQadD1FzhvKcM8s/eHYlh7WoDIIyDhil6ePrdCp
	QwEToqyraJF4icF8Ey/b3X0XXU/6KudGHAzEmUQ==
X-Google-Smtp-Source: AGHT+IF/dQlPk++sgIBUAh6KZr1jdP3M7z8/D2mPagrcdDnYOfOmJGfLqoi4HUnG9kuc8icpltFeH/cOzsvpfHAMFvc=
X-Received: by 2002:a05:6358:8a0:b0:17b:6453:d696 with SMTP id
 m32-20020a05635808a000b0017b6453d696mr6269462rwj.0.1709455454495; Sun, 03 Mar
 2024 00:44:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302173401.217830-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240302173401.217830-1-andy.shevchenko@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 3 Mar 2024 09:44:03 +0100
Message-ID: <CACRpkdZudHHkFcdmHB9mWGriV0EtvZrjiGUHF+b7W2L=t6xmwA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] gpio: nomadik: Finish conversion to use firmware
 node APIs
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	=?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 6:34=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Previously driver got a few updates in order to replace OF APIs by
> respective firmware node, however it was not finished to the logical
> end, e.g., some APIs that has been used are still require OF node
> to be passed. Finish that job by converting leftovers to use firmware
> node APIs.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> v3: used correct types for fwnode (LKP)

OK took out v2 and put in v3 instead :)

Thanks!

Yours,
Linus Walleij

