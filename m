Return-Path: <linux-kernel+bounces-51892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20AF849075
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673F51F227FB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ED13399C;
	Sun,  4 Feb 2024 20:48:11 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FFA33997
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707079691; cv=none; b=ZzNVsSGqixZeLUM4LS/kRJpw9T2B3lCMFxn9k/2Srzb8f4Haj6Las1XeZHGx2YK8wf+3Bx181wdYjVRpAzuLXdiAP/HL9cowh/MRHnPeHoCvumkthcBEtJf7CVxXUSOrim8uFIB67cYFYKyG8Kf58uu2XKGxL8s1zZDyme1aY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707079691; c=relaxed/simple;
	bh=R/I7dk8sqQgMHMTdsGzqQK7XxNsAJud+1AIwiPgLJwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DF/uObRbQiC99PxrGc96W1b+GCTho3BbjFj5DS9Qno5Tx43QGVACeoAIXfztgVC84IBesA/8/K1FLGApx9Ml3hLSlTwLXhxbKZf4wvlBXW6PAoFxN+f8mRU0+BGsNWv0cPuF7xLkGt0SR4CKzqWQnzfVdKucEWb4En4ETm4hSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60406da718aso38135217b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 12:48:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707079688; x=1707684488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuZCS9y13xUQN18d8Gu/e8RowOQI4ytQlPYFh0yEfC8=;
        b=JVrC2/q66PA8WY4jCTUFQl9tyT1RDyJwFtJ0oES0rY+MncpwK9c4z3hsI9HUNtHxIC
         +eJN+DJOlsEaPxlc4i96kn6jxb5fWdBu+GzySkeqIYKo+E2fKokPVwb0fSZAiA5Mwui8
         LnyL12/1PhzXhDAlbstyD72pxJpJcDhgv7UZNFXcNF3y/WfJAvMtxBcldZgnpsy+cGsT
         quINhHOBGs9axEh5mNRe5IRcpFWcDG2nHtQj6Kc1uWp9ktyRfRa+43ykQDiM6F4htUUN
         hxGnzr1zqfS0DFzNFmZJ4HcyeJZCUbHvWMOJ+abkeJ8uP6W78MvswgLURSBQxafQ97ye
         kMFA==
X-Gm-Message-State: AOJu0Yy7/GVu57nIvbm7JTewBlqwrafTUXYOl9f5nwq4qL9vOYLh5+sw
	9ZIb3PoQNmjKRKWMPJ6bV7oMR05deBNjEGDCX9LVYAOynanfQolMOHJhLuLdr9U=
X-Google-Smtp-Source: AGHT+IGB1GFjAFsXU7aufGDQDxAovjLso5yym24xc/CcfK1188ZyBD8xY9+cx1c9Ie7pB9QIqgjTXg==
X-Received: by 2002:a81:5258:0:b0:5ff:d4c1:48f9 with SMTP id g85-20020a815258000000b005ffd4c148f9mr7471685ywb.0.1707079687980;
        Sun, 04 Feb 2024 12:48:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVJMCYt1xzIxbNMTOT9GbJQicIND754JzTnG8lvsNMgwidETUhuILWUnMKjoi97npZMF1sAmCCNTJBrsfBZIFtwD3/30jC2WUXSy32o
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id k125-20020a816f83000000b005ff9b3e6dd4sm1638162ywc.116.2024.02.04.12.48.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 12:48:07 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60412866c36so37161367b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 12:48:07 -0800 (PST)
X-Received: by 2002:a81:f205:0:b0:604:3ee2:f258 with SMTP id
 i5-20020a81f205000000b006043ee2f258mr4071749ywm.45.1707079687488; Sun, 04 Feb
 2024 12:48:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net> <20240204-bus_cleanup-powerpc-v1-2-c763f0e142e9@marliere.net>
In-Reply-To: <20240204-bus_cleanup-powerpc-v1-2-c763f0e142e9@marliere.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 4 Feb 2024 21:47:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWmFZjWK483JhAuq1GTk0GOH_urRdWdxSB9EwR+YNaqww@mail.gmail.com>
Message-ID: <CAMuHMdWmFZjWK483JhAuq1GTk0GOH_urRdWdxSB9EwR+YNaqww@mail.gmail.com>
Subject: Re: [PATCH 2/4] powerpc: ps3: make ps3_system_bus_type const
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 3:23=E2=80=AFPM Ricardo B. Marliere <ricardo@marlier=
e.net> wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the ps3_system_bus_type variable to be a constant structure as
> well, placing it into read-only memory which can not be modified at
> runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

