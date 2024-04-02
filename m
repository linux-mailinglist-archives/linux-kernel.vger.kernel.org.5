Return-Path: <linux-kernel+bounces-128197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B3189576C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5ECC2824BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA32134742;
	Tue,  2 Apr 2024 14:46:58 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8212BF1A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069218; cv=none; b=p3G9vH3BxNT+z4IVTVhMPr8lrDHsJfNE39h7zQ0K12xVxp4jxnX9/FbT1Gpx1tihAhvKGXXl6vgB06vtMaZU+1rX+H+g259jzvg+ExpAjahCWJ9cNm6UHDjpEytcW3AQDtBFuhTm9elL4b0NJ4KDEufH9ZLFPCJ57udHVnkkc+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069218; c=relaxed/simple;
	bh=oKKu3NxMzx6TRH5Jx7lZTrA3iGo65a6JmiR728Ctnn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Q3XHp63xx8cnEmEguOra94GmNkm5KOoKtn6o7Mxx9f9hHf1OPmUiVbRQjUP9ZUVw9IQj0V/AAMQmmPN3mxM/UXN2XTWx3KDpoN05AfjRvHkZmy+0SjlbNhDJPkZsHu12QACR/26nUVKZrvgafA67uwymr13LQaqAt9OcJ5qbNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-614ec7ee902so16923137b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712069215; x=1712674015;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpzhQtMCSKF0BPtEK3as9AagHltY0TSjKJDuqvgt8+w=;
        b=vNd7CFjCxMN/cet7VaHdi3vq59CoF3jhAh54yVT0s4iDwPInrwsIbHaEqs8l2zvoT9
         +BWg34M5vmNEDr26spywSVIasIBB9a+Xt8+OKM3uuNyXNey9QWcYVBMWL6GpKUlVjjUG
         ipHENK96xrFJonP4/ezRSdpLqOz6PV0YnemRaG9mnl0DB4luNo5uEQXkrIWSH5K1kuw0
         VUnemmAUQEftvJAzSbFM1zDWD5v7D1mCjE+lN/ndStB9gAUG2dT3JMGLvpvj/Cr8JHpT
         EzU8Oyex85cDqXJkOBX0IQPe5QDJZBLjLlsbc5GOGZim/SsGWMiIkqvj3VozZdn4OA9u
         YVoQ==
X-Gm-Message-State: AOJu0Yzt0eqg9u6hh+xHx1vjMec3XX+Da/+RgGiVhDzebbhibqBzMA6E
	j72n9XE/+b/yQoGAcWLxgWdXveplYDF/96Yx/t2cERiUyeardhrLa79kiBjggwU=
X-Google-Smtp-Source: AGHT+IGjRywoAKLBZeft/E7iAAKRqadSi01PjM4PTntuaPDcLhimbZXRMrp276AF7InGmkdT3F2H7g==
X-Received: by 2002:a05:690c:24a:b0:611:3105:93e5 with SMTP id ba10-20020a05690c024a00b00611310593e5mr12147870ywb.17.1712069215221;
        Tue, 02 Apr 2024 07:46:55 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id z17-20020a81ac51000000b00615081a4bc3sm656590ywj.139.2024.04.02.07.46.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 07:46:55 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6150c1fa3daso14858027b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:46:55 -0700 (PDT)
X-Received: by 2002:a25:140a:0:b0:dbd:4c4d:240d with SMTP id
 10-20020a25140a000000b00dbd4c4d240dmr10401195ybu.59.1712069214708; Tue, 02
 Apr 2024 07:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjf=8JusO9TgkMfNziLjjSHdMOUpes_6f5m9_w+7taeBA@mail.gmail.com>
 <20240402071839.2182215-1-geert@linux-m68k.org>
In-Reply-To: <20240402071839.2182215-1-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Apr 2024 16:46:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWhqKJLFH-HYrir_3jReDH8HOKZT0Lruo05sGSR57xEgA@mail.gmail.com>
Message-ID: <CAMuHMdWhqKJLFH-HYrir_3jReDH8HOKZT0Lruo05sGSR57xEgA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.9-rc2
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 9:19=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
org> wrote:
> JFYI, when comparing v6.9-rc2[1] to v6.9-rc1[3], the summaries are:
>   - build errors: +2/-4

SH ICE crickets.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

