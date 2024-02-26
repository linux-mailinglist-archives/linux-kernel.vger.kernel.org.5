Return-Path: <linux-kernel+bounces-81814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB3A867A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3661F25709
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EE912BE8B;
	Mon, 26 Feb 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="o+YDuc0N"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C912AAE1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961706; cv=none; b=d/JlRz56rvM1szss+JVd2D2/M5mukyfFyr/Y0/cOtJIdYNtFqFFj9573/w6xM1/vU/cP6mKrXQGVUsnGRLCnC2P0rzkyHra9Q7UKAyAkR/Cuiq0LAmToePMJW99sDEIJkDMzdnM5x2oauOrXTpEDo2EJHxPmNh45h9fpTziOXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961706; c=relaxed/simple;
	bh=4kIS4yD8AD4O1b3VnN1F06SOkEVszDZQI8IfD4Uehgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MewVZtiDzL+0XBi7Hu+bbjD2qtUDlOvpMQnaX/OqvRLl9nlCk/QJBXG3qNhuoL+jgwwnMqqCR6yd5F9aiWG2NQlhA5W44aVY3QmYTyAnmij1OehLu2SpWc/ZULhNUe84oaqTZPW4v4fQYgGYqBt7L8KEifvwrVxD6nY5f72BYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=o+YDuc0N; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-365145ef32fso6335395ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1708961704; x=1709566504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa0RbEC99hetXIlkM1dBM7uoCQu/qj03SQaG2EdJOl8=;
        b=o+YDuc0Ne6bPseUw1FsKMJja17aN0ktBl6nn/2EWv86q+Rf+4xBMe3OB3E6rHc8Bq2
         MTE0umqMHwvqezuZ7hTBHwWwWb9Vg1ExsfwX1OtV0+eQmQGuqCMJMrx8sqoN7noIHZWc
         VH5UxglqFXkQPtQepqYg/bEIabiZPva3UNnMpUaX9wdP7OcPivQVasrNZjXQsjNJCyuT
         zN5Lf4DvXMtMANBCLPa1Nc4FXPMMLkKmWbV5C5fiRBkeWEK+tI8+qNLOaR+dJAT9U8hX
         7/aBdr3uNLKV2aLLzdIXdyJ6aGmpgy+GYlUDAEkdeJ9K9/WBDkBFpREV4KWqYICTnrXz
         SpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708961704; x=1709566504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xa0RbEC99hetXIlkM1dBM7uoCQu/qj03SQaG2EdJOl8=;
        b=vCBFRHDP2coEtckzPDtOOFTXcwG+1C2sPEgdUcOQmL/V++O8CcHQ7lfX2tPhTGZCIw
         WJSY1JEE0ja/x/k2PQ4uVTrMQkP1O/7pSbWgMtJnO9JvXvYqwoX6aT2QL1Aj+nComzx+
         WvIB/81Yiqo+mVpqT6OgemnKh+JpT020HtV3PNBVut6xkg7QOXmey/7BbII8h3z6NV1+
         nuaUUytOwAc1+IkmKwRZghlKgP+Xg8T3BQsBO8T/gQG/V08676suN6g7v4fAf95ftCMR
         hs7xxrINt00u7yD0U5S7eBfnrn+ribx4uotxXRzqFof14cJcOl2+oT7F4Q1H8VnFPHO/
         Dtqg==
X-Forwarded-Encrypted: i=1; AJvYcCVEwvw5fdsiCG+WVwuhhvc03/eqdfiyAjYq0vV463cTy47lfszCffnqA9O1Rw3iIVAqp904OeKFmK3sc9wVM96EyKYW1dvoL2kVnnCo
X-Gm-Message-State: AOJu0YyC0bsME6Y0rSvAal+QmGk5haOAVazIiDIy71AJU/ezBThyWJE1
	rdnvd4ael1oejJZt+Mau3Rsf160Dzh67NlD6tAJtOFMwkPiudWzzVnMwL11Y93onidGbTkpsvaw
	ZE9a4A60qjUikNd2sIjWpLPXx0zxHyHtkX4rmr/X/SysVzzHccXU=
X-Google-Smtp-Source: AGHT+IF9TjRy4O7N4WF2QA0xxbWaFEpVbHdsILnOH+1xQwJc6SUX/exDXTr0QynONQlKKrvr0H8J6FvRFB0LrC01EYA=
X-Received: by 2002:a05:6e02:13cf:b0:365:1737:d78 with SMTP id
 v15-20020a056e0213cf00b0036517370d78mr6817259ilj.17.1708961703934; Mon, 26
 Feb 2024 07:35:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202402261004.1e2e3e3e-oliver.sang@intel.com> <87wmqr9s3u.ffs@tglx>
In-Reply-To: <87wmqr9s3u.ffs@tglx>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 26 Feb 2024 21:04:51 +0530
Message-ID: <CAAhSdy1pGfTLo76QHWj4-1HtUME3+o_83DBwOQcUAr2c5Tr1ow@mail.gmail.com>
Subject: Re: [avpatel:riscv_aia_v15] [genirq/irqdomain] c3842e43d9: kernel_BUG_at_arch/x86/kernel/apic/io_apic.c
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel test robot <oliver.sang@intel.com>, Marc Zyngier <maz@kernel.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 8:42=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Mon, Feb 26 2024 at 12:57, kernel test robot wrote:
> > kernel test robot noticed "kernel_BUG_at_arch/x86/kernel/apic/io_apic.c=
" on:
> >
> > commit: c3842e43d9d6b013a40adaea274b663936b14e32 ("genirq/irqdomain: Do=
n't call ops->select for DOMAIN_BUS_ANY tokens")
> > https://github.com/avpatel/linux.git riscv_aia_v15
>
> Fixed in
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi
>
> with commit c147e1ef59d4 ("x86/apic/msi: Use DOMAIN_BUS_GENERIC_MSI for H=
PET/IO-APIC domain search")
>
> Anup, please update your branch.

Done, I have updated my branch.
(https://github.com/avpatel/linux/commits/riscv_aia_v15/)

Thanks,
Anup

