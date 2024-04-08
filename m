Return-Path: <linux-kernel+bounces-135026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342E389BA20
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648A71C21EF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFDB3A1A2;
	Mon,  8 Apr 2024 08:23:40 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5E39FC1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564619; cv=none; b=oPSdrvW1E7sG8XMSHKsoNFsCjNFBeaHYwH/DVHWofWIRhgzFqz1RcNgGd/y1fA+vTFQcWIDY4LAJBJ44eeRBWJ22p5idc1g14AXC1/sagkNDY4lj0RX8Bd0u7PEXLNLrxqA9R9j0RnE2OJQA7xM1dOvmfOhVqFkRaisgSG7nP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564619; c=relaxed/simple;
	bh=9BucTodjQZA0C+PXetagehbEC3XeicZcpxm1poATaVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMtzKclM9yjDe29LijS9wWjjeHntWfKb6/XlfkPjL8ADQg9CqRoRq/SpGdr/6pm8YE8h5Obom0VKOTlWsuRKRU34lA9gKdB4URTGOr1ApTtWdofR6CHFSYRnH/T97/8FhKtmWIMwyDC5v/JJxt6opzq9pf+9W+rMo1E5OGlhRH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso4060863276.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712564617; x=1713169417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDWiWLcu7csgHD8oiwim7vv9Jne5blOZ8xlpqmcE10I=;
        b=OntSz4jYkzzVrkBhLInZCFkNGYN61JIUG0cEbUKK+IOfbtJhPAFMYxOiflXrw8vY/a
         FHvwy4H/Ct+YWTkn13mlDPnUxDxwBfUh//VbDtOdSX5QdEvqvpq5wCYQwWdhdGUHJbnz
         nVmdjfVCeBnvbhLz0RQArHOwlkfJaX/SqhCcYw+IYRN2ZfLTY+8ICbx0HsEF2YEQUJ6r
         fqLbpHgTUILNA0nhqNsgojw7CF3XKkYl6bC0Ih7lrrFcxECnZ+qzdZmZfcsIMGp1OV5o
         aYDZ0Y7i8iGEsWY0ONl/tzawFecpQ3DJH4HQ9wcZ50dLDxod3Kl5AaEugeRAX4t7t+h2
         6iYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdIEjPxqJFWMphtNBmtFBFlxYLGZ8RHu43CykFWYMUubjOX6zuUNFlKbAdPseSj2m3OSa79m4T8rPsHOZPhRxA1JMmv6psUIHf8dqy
X-Gm-Message-State: AOJu0YwTxuqt7XJzjHmH3k4LbUN58roSlRag5Uoblo5KpTpTvCfXQUMW
	31a2upT5zUeHYtN3dBftHoQz0Oh+SzGSQXID+GyMPwIv9hLPzswPLMt9ZymMCt4=
X-Google-Smtp-Source: AGHT+IGSnxgdYBFrjmK7b9kn9QPsilYlj2YCIcM1HxVTT4DfHFTGANJUemMME1cetT190IrE1wdr1Q==
X-Received: by 2002:a25:ac8c:0:b0:dcc:cadf:3376 with SMTP id x12-20020a25ac8c000000b00dcccadf3376mr6311571ybi.18.1712564617145;
        Mon, 08 Apr 2024 01:23:37 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 185-20020a2508c2000000b00ddd74925633sm1341501ybi.49.2024.04.08.01.23.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 01:23:37 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so4066109276.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:23:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcdVPCCv7dVN3mC8oH32RN5bszyPUz+B9kr2p8ZVRI4rrtsYaAKX0+5fpDIoQEy99yfl+1TzTBcRgfRyNJh/Wvh9hpaCBQgnau6M3A
X-Received: by 2002:a25:2610:0:b0:dbd:553d:9d6a with SMTP id
 m16-20020a252610000000b00dbd553d9d6amr5403540ybm.40.1712564616812; Mon, 08
 Apr 2024 01:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403122851.38808-1-schnelle@linux.ibm.com>
 <dd55afa6-8cb6-4e25-b720-d2df62dbb5e6@gmail.com> <bf276f98-2712-4fcf-a119-f984a1aedbf2@app.fastmail.com>
 <CAMuHMdX+M1VuhDVnC9n4hCBDjHywwsByNK1w8ibazc+-8_C53A@mail.gmail.com> <11fdef9b-413d-4f88-b3d3-e5b27a88cf6f@app.fastmail.com>
In-Reply-To: <11fdef9b-413d-4f88-b3d3-e5b27a88cf6f@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 8 Apr 2024 10:23:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX026rLnJP2K-MhBjzVnmu8EReYe3PJc595Vjp4GoBK7w@mail.gmail.com>
Message-ID: <CAMuHMdX026rLnJP2K-MhBjzVnmu8EReYe3PJc595Vjp4GoBK7w@mail.gmail.com>
Subject: Re: [PATCH 0/1] m68k: Handle HAS_IOPORT dependencies
To: Arnd Bergmann <arnd@kernel.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	linux-m68k@lists.linux-m68k.org, Heiko Carstens <hca@linux.ibm.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Fri, Apr 5, 2024 at 1:26=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
> On Fri, Apr 5, 2024, at 12:16, Geert Uytterhoeven wrote:
> > On Wed, Apr 3, 2024 at 8:35=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> =
wrote:
> > Michael is worried about non-ISA drivers using inb() and friends.
> > At some point in time (i.e. eons ago), we were told it was better to
> > use in[bwl]()/read[bwl]() instead of directly dereferencing volatile
> > pointers...
>
> It's definitely still better to use an abstraction layer for MMIO
> accesses using inline asm instructions than open-coding the
> volatile pointer dereferences. Over time we have gotten better
> at defining which of the available abstractions should be used
> for a given bus, so inb()/outb() is now only really used for
> things derived from ISA in some form, including e.g. PCI and LPC.

Indeed. Nowadays the consensus is that readl() and friends should
always perform little-endian accesses, thus implying byte-swapping on
big-endian platforms, but most of the m68k drivers were written long
before that enlightenment...

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

