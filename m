Return-Path: <linux-kernel+bounces-82280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093B38681B8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A2CB242FC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81031130E27;
	Mon, 26 Feb 2024 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gojY79tj"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A37130AF9;
	Mon, 26 Feb 2024 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708978091; cv=none; b=dBj/+2cPxDYRwUI6Yxa9tmQEiCCuaCoUWWNzfMoIEKEIZJ1fxv4gUqeRzL98MLgDqoGN9Dvm0hOimlpSoKwpyp+jTBGR8nRa28n2ZzMd2RnV4WuD51f+PknzlJ0+iXIwJRqpqASbX6eID1CqTEbp8OteeK/InLXDbdAOwLKbOJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708978091; c=relaxed/simple;
	bh=P8qiXwV5MVkQofH+MaxU2bpzvzo39pZRh7erGITANy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmiyH3zJbqFjcMNHkVtcQxSTnGg/FOIAIMBOwaKWdMEzmSicizGnrsW3gk1QsrsNBdKQuXv1cn1N9IGQLpVDQBnIc7EFaD9UpuOLQG4M/LSw/GiZRgiwRudAsLMMMSRlWPQN7PJiGOE4h44JhPaAJ5mLizYD2KfPGMYAhM9bELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gojY79tj; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513031ce058so347463e87.1;
        Mon, 26 Feb 2024 12:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708978088; x=1709582888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8qiXwV5MVkQofH+MaxU2bpzvzo39pZRh7erGITANy8=;
        b=gojY79tjAm2te8csrQvul2HLJ3Cm4IbcT6r4O8ttRYYEjoSkMQ8tHMslEw2aUpziW7
         qbs3q0czftfq/Ip345C2RtmrH+yQY+d6BMQ8TrCzPxQf2qZpaHUacnBtKZMVqVgPRb0a
         VAW1pB6D6j4nF7ATFJm4DtWlsB5FhiGKhTjTeATrXGBM3H7aWJg/xmvJDktXWPMka/AN
         +txUEdsp6ppJN/vmG0UnjpQj4XD4XCsCWl1/w+NqZBbXHLUSvKij+Fd64u3LrhcT8VEk
         vtwnSMMRo96kbeND8RhmC/BrczRnQKrGRS56t9S1IuskQbKsAguHfYEvrr+5LK14Cx5M
         5o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708978088; x=1709582888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8qiXwV5MVkQofH+MaxU2bpzvzo39pZRh7erGITANy8=;
        b=YMx2v07RVzP6yql/RCFnVA7bc7FUowrKd2MZZMG6f9KsIdM+G3gxp4E07kIKCc5fr6
         eHwsV5aE9UDbYNvigvE9+VdvgomAWCoCDHQTxHZWfnbhu8W+AbJ4Z+FooyN5qx+FYvPc
         reKXgvcUn8V4tjhikCdbTaQP0lnaLHHVy2ulrU8QfiSBYFhQdj5Ov4dUyQlLN4jxafLt
         1FRkP3WYzRS+I6BfUrufJ+azt3fkHh34B5XhXhFqk3wjgTEc19+vv0o090fbVq2RQvHh
         XONTzwGkFS5CVnXHuMszavWZf2r75ureBLCsqH+k9so26Aeufmi/rpkLKvoViO7qJ7A9
         EQGg==
X-Forwarded-Encrypted: i=1; AJvYcCUGUKv6ZB5s4BtHSKk1zdiSq/oaaEXtW0MekYYddzyTQpULd39TttRpOSh6l1I7LtsyhEUwg1aktfBbW/yRE1P3nrDlqGnC6KINuckkf0Ua4DrJKmCxFC3nV3Pt0BwfcEFiHbkozjgZ/q9kajDZ1FrNwQKvQgAEAQjo5HdCmZUu8FUZpw==
X-Gm-Message-State: AOJu0YySsDqlJnXeagRpipxo0kkCo1F612qfMTd/UCdmSd9ZA9agI7mo
	a43ureMskD9gf7J76GzcDYpNsLqJmf3ItUWAOyyk1T9GCzblSMdlwFmgAg+iXSaXIvJEfmeFaaF
	g0sTcmY1Yg9FzjG7JY6irRFQLSpE=
X-Google-Smtp-Source: AGHT+IFpmJYBm2bJLEhvPMIHTu7tdzlLyLLX59ipQuXs0/4omd7yWBrPgt5GQRSg5HsFGvCU9oJ/g+VP5Bvtf6W0Osw=
X-Received: by 2002:a05:6512:3087:b0:512:e1c3:5ab with SMTP id
 z7-20020a056512308700b00512e1c305abmr5473467lfd.45.1708978088002; Mon, 26 Feb
 2024 12:08:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <87r0h8n64g.fsf@oltmanns.dev> <875xybr93t.fsf@oltmanns.dev> <3546609.iIbC2pHGDl@jernej-laptop>
In-Reply-To: <3546609.iIbC2pHGDl@jernej-laptop>
From: Erico Nunes <nunes.erico@gmail.com>
Date: Mon, 26 Feb 2024 21:07:55 +0100
Message-ID: <CAK4VdL0oHE72_fJpoL1oQs4y=xP=8MPQq_6DHsARWVZUdQ3qCw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Pinephone video out fixes (flipping between two frames)
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
	Maxime Ripard <mripard@kernel.org>, Frank Oltmanns <frank@oltmanns.dev>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
	Purism Kernel Team <kernel@puri.sm>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Feb 26, 2024 at 6:29=E2=80=AFPM Jernej =C5=A0krabec <jernej.skrabec=
@gmail.com> wrote:
>
> Dne ponedeljek, 26. februar 2024 ob 08:13:42 CET je Frank Oltmanns napisa=
l(a):
> > It seems to me that all options for changing the GPU's rate in a stable
> > manner have been exhausted. There seems to be no common interpretation
> > what the phrase "Clock output of PLL_GPU can be used for GPU;and dynami=
c
> > frequency scaling is not supported" in the Allwinner A64 manual (chapte=
r
> > 3.3.3) means.
> >
> > The BSP uses a fixed rate of 432 MHz. Unless one of you has a clever
> > idea, I suggest to remove the OPPs from the device tree and set the GPU
> > to 432 MHz.
> >
> > What are your thoughts on that?
>
> I can't find original source of these points. So I'm good with removing
> them. But instead of fully removing table, you can just leave one point a=
nd
> it should work.

I had posted in
https://gitlab.freedesktop.org/mesa/mesa/-/issues/8410#note_2216628
that I also noticed the A64 datasheet specifically claims that except
for PLL_CPUX and PLL_DDR1, other PLLs don't support frequency scaling.
I was never able to find any evidence that it is actually supposed to
work anyway (perhaps it was hope?). Since you also looked in the BSP
and there is still no evidence that it is supported, I support that we
should likely just remove the OPPs.

Also, I wanted to point out that my series
https://patchwork.freedesktop.org/series/128856/#rev2 was merged to
lima recently. That was the root cause of the "flipping between two
frames" issue that people most probably hit. I highly recommend that
people using the Pinephone update their kernel to include those fixes
to fix that issue. As you mentioned about that symptom here, I just
wanted to point out that it wouldn't be possible to fix the "flipping
frames" issue with just fixes to A64 clock, it does need lima driver
fixes.

Thanks

Erico

