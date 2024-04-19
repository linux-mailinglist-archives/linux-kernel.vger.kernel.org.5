Return-Path: <linux-kernel+bounces-151586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5D08AB0BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5091C2107B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F9F12EBE7;
	Fri, 19 Apr 2024 14:28:18 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9A12DDA7;
	Fri, 19 Apr 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536897; cv=none; b=DdWnF2J9O+2YlXnNK83YMbYAXO5cRanBq6mDaP/iCKBbXoD0s7FBoi8sPk/qWTbfpbqF2nxCZc+4xKeQI1RVqFI3ELGTUbxNXOrdFYUwXnG8D8dcTJJ5fO7CRjgApiBKwJK7A+naMpiNLwWBZ4h9LQpK3LHyLyz6WugjRlkgWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536897; c=relaxed/simple;
	bh=G1+0dblF40saoEUI5t9PSHAuASXQQjX35EyPZNEjYoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAkmyScVStZS7o9MQdqa0bW/z2APCjnbqL4knD5Bu1GM79orYElXoAXlCnODHmzUVq0Z4GRmxexRFxFy82NI3U68YGP7/WZ8984rElbP71Q9QLO94DKyvAK69Hyv+yX3KfrDEV8e7TpaU3X8MHdZegnPD8UpNvQgNEiWAM6gxUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc742543119so2279747276.0;
        Fri, 19 Apr 2024 07:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713536893; x=1714141693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUQip6CY7nE7rS4i9PrpmVcAVNKpvKyKHJ16wLW48xo=;
        b=Aj8ZT1hF1JHdvLU49aZeYQ3N44JCKNqruIaXbjTDLc/Vq0cD5SSKqM3VtR3urBmag2
         MFX5mIBQpds+WIJNeZioEa1PVWPN49q74Vxqoj+pxZOXmrM4exu2QSoRkqgt+DcQujTo
         eUSBxc5P7DqazC+nkcwcaS+gEnmrZItR/hDslaU3Yqjr0Nqvvs4oglIoGXQC54pPixC+
         6pKdF2ca8buLi+D04BKo8/tVWh6BGskZDmLcLFUCq6c2HRTMXhaFf1XwphGDedrSITas
         kTbLQZdiL/LG1FlpQcvc7g5w3b1kXFNLnnadaX1BWNGtm4aw8kLFjvXEcqV/gzNraL3U
         uxLw==
X-Forwarded-Encrypted: i=1; AJvYcCXSi9TXmsHwsbKD5SCLJQ8rssCopgLS2f6LVkYnoXd+3qKn31+/8d4JLdb3JSbBdxjhWmhvCJhQNwsC9kZG9fuNHxj8lludbSQW3hlLBooRoZUvkaiNWyIGFyRYzyMnHFXZVtvBSogU
X-Gm-Message-State: AOJu0YyzmFd27uZ8KX9aHyUMtBCvM9WG4bf+o2eP2QMaFYMCyWNWpCIx
	1HSIxg1rlFwvP700yGRD8v9cFDSBk+ELzcIg135esRsTCXNfDMNUAcEHnJyd
X-Google-Smtp-Source: AGHT+IEXBZ1B4uxtWFhIS3QzFuCVVxW+oRO8VR+gEmxkGxIaerMAXvTTF9v2nCYokVia93g+7Err+g==
X-Received: by 2002:a25:918c:0:b0:dd0:bb34:1e77 with SMTP id w12-20020a25918c000000b00dd0bb341e77mr1953816ybl.53.1713536893546;
        Fri, 19 Apr 2024 07:28:13 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id ck10-20020a05690218ca00b00de4f0ae2a8asm83939ybb.46.2024.04.19.07.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 07:28:12 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc742543119so2279642276.0;
        Fri, 19 Apr 2024 07:28:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIDHK0q4XJrNexl7v1sbDV2KWeQzh/plKaF1py1BSPjwfGrK03sJH8HlqIcphsRqHpOubURb2UZiU3+jqNPgVE5uIzZ4qVeuJ+wvBTyBrPcgCdRpePXmbOf2UxnqBfLTihVj4L6RXW
X-Received: by 2002:a25:acdc:0:b0:dc7:4460:878a with SMTP id
 x28-20020a25acdc000000b00dc74460878amr2207906ybd.3.1713536891068; Fri, 19 Apr
 2024 07:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417001507.2264512-1-seanjc@google.com> <20240417001507.2264512-2-seanjc@google.com>
In-Reply-To: <20240417001507.2264512-2-seanjc@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Apr 2024 16:27:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWdW8sao4MpKyrJ=mMTNdzNJC+AP_4ewd4OUHLW6VzAZg@mail.gmail.com>
Message-ID: <CAMuHMdWdW8sao4MpKyrJ=mMTNdzNJC+AP_4ewd4OUHLW6VzAZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpu: Re-enable CPU mitigations by default for !X86 architectures
To: Sean Christopherson <seanjc@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 2:15=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> Add a generic Kconfig, CPU_MITIGATIONS, to control whether or not CPU
> mitigations are enabled by default, and force it on for all architectures
> except x86.  A recent commit to turn mitigations off by default if
> SPECULATION_MITIGATIONS=3Dn kinda sorta missed that "cpu_mitigations" is
> completely generic, where as SPECULATION_MITIGATIONS is x86 specific.
>
> Alternatively, SPECULATION_MITIGATIONS could simply be defined in common
> code, but that creates weirdness for x86 because SPECULATION_MITIGATIONS
> ends up being defined twice, and the default behavior would likely depend
> on the arbitrary include order (if the two definitions diverged).
>
> Ideally, CPU_MITIGATIONS would be unconditionally on by default for all
> architectures, and manually turned off, but there is no way to unselect a
> Kconfig.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lkml.kernel.org/r/20240413115324.53303a68%40canb.auug.org=
au
> Fixes: f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default f=
or SPECULATION_MITIGATIONS=3Dn")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

