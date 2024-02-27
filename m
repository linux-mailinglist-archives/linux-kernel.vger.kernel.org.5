Return-Path: <linux-kernel+bounces-82676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAD4868825
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C30D1C21574
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F85C4D59F;
	Tue, 27 Feb 2024 04:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuWVq1NY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478923717F;
	Tue, 27 Feb 2024 04:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709007211; cv=none; b=VGcArlmqmJuLlias40X6pFVIfau8F+4XAqZwYa87TtiiQCh3N7ITq4po/CKjLF7h7Zjf/YaiB62YClaogSjOGcvq9oBx9mqr2dpWMR519kYMGmBU6QibJFhAEcgAi2wdcMriLXPvraLsMGDu+vX6yPVA3TlJCSXDfxYTRWnGlkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709007211; c=relaxed/simple;
	bh=pOd3rIhxeDttRE/w4jf0a5fXJ8XRG2AEH9g9YoyWxw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbK81S0uYlfZ9pwgA1kMH7OsrM/2vgTR2wOcvSlMV5erpZ0HkF33H3kEsA3Ms+NQng8S6AMBF4Y+5FzjfBrcIvBPMQSNIPr9uUULWxug85qACUGbeOtxtO+AOQch4j0O1EsnvTJR1qGyiT8YvAeJ8lb97c1fATdN5Y7Jn/23b7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuWVq1NY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D361CC433F1;
	Tue, 27 Feb 2024 04:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709007210;
	bh=pOd3rIhxeDttRE/w4jf0a5fXJ8XRG2AEH9g9YoyWxw4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FuWVq1NYHYibDwvv1R+4dBRw3ekHb7gkOCyNO+hQhzDkjGzeZ2VS2F4pjCHYhGccC
	 aF3JKUzNvg2TX6QJQ1vMWVu6VE7i/LeS8gKvrnlkN2e/nuX1CNT9eoOgW6H+JGRb2C
	 cGrDPsTwq2OLY9uz/64wjRr9bUk2R8bmxln3zCQLgf7RRxDBYJC1SqkeXE0wV7etRH
	 I9qcJY9Y9tQL0afXuCQLIC8MyoXbkboBG3uESwOY1hCnWrB4jqdwDBAgpnp6kZyksl
	 eXypStlbqekN0rBQqbsKGO+7iocd0pC+bOxRv1SXEpCeBDCLSW1+0kcE402bkVVrhd
	 O/REvrpn/L6IA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513031ce058so759647e87.1;
        Mon, 26 Feb 2024 20:13:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUa4cIciXdfWuIsQg2iu9hQ1gyYw3xxIA0oaDN7E642ZQC29zLPh3Rl2IV3YQzv5mdIdTRPUKI8grGVkDYm+rfbhwM2IjhgP6mtHeDVjE/uzzw7TjqdrxiTdzMTvHZLsRYaZXwCgvIvPTXRZ6pcHuRBrNBsO+PnQsBgTl1s+Hjsl4p/bJGrNQ==
X-Gm-Message-State: AOJu0YyT6wRGVMrD3ZNp5VyHzvACrhk0C9MfGSkciaeCxmT7ALmnofu/
	7cEY4j4jOo6/eMUHnp0y/Tl5dmf3Wul3p5gu7iYZgbpHPANU2FL3NlO1nYXsfTLWIuullKriBvK
	JpwPoi162kumogbZh1hkFzE1hMA==
X-Google-Smtp-Source: AGHT+IHEaZhlxSyD/TFbQsUwc1WxHtT4YLPC4GzPIHqVUejLCCC1a87PP2YrbmNNBxDfqRX0V7bJ0TFYqF2XYfq7ra4=
X-Received: by 2002:ac2:4a6d:0:b0:512:eef0:3e60 with SMTP id
 q13-20020ac24a6d000000b00512eef03e60mr4619033lfp.16.1709007209058; Mon, 26
 Feb 2024 20:13:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225151209.343160-1-alexander.stein@mailbox.org> <CAK7LNARxfhYm9WyDH-S0PT7Mb5Tj5tmbqGLs9NzNxzsi1_4OQw@mail.gmail.com>
In-Reply-To: <CAK7LNARxfhYm9WyDH-S0PT7Mb5Tj5tmbqGLs9NzNxzsi1_4OQw@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 26 Feb 2024 22:13:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJp5aHJiibQ6=dcBPKQ8k=sK2Nbgter7Y7hczJP1AO0yg@mail.gmail.com>
Message-ID: <CAL_JsqJp5aHJiibQ6=dcBPKQ8k=sK2Nbgter7Y7hczJP1AO0yg@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: Add DT schema check also when applying DT overlays
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Alexander Stein <alexander.stein@mailbox.org>, DTML <devicetree@vger.kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 1:03=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> + Rob Herring, DT List
>
>
> On Mon, Feb 26, 2024 at 12:12=E2=80=AFAM Alexander Stein
> <alexander.stein@mailbox.org> wrote:
> >
> > Add a similar mechanism as for regular DT files to call the DT checker
> > after applying DT overlays to base DT files.

I suspect this needs more work than just enabling checking. Otherwise,
I would have done just that. Depending on the split with an overlay,
we could see strange results.

The requirement in the kernel is overlays be applied to a base tree at
build time (though that is not checked ATM. When we check that result,
we're checking the overlay anyways. Obviously, that's a bit harder to
trace the source of errors, but it is otherwise redundant to check
overlays in addition.

Rob

