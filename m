Return-Path: <linux-kernel+bounces-18791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D202826314
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2AE1F21CD5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 05:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20828125AF;
	Sun,  7 Jan 2024 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EIMy6tOx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80465125AD
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50ea98440a7so766863e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 21:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704606864; x=1705211664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2+WLp3U3zZ/tGPOXpKoB0JjWL2Gl79ktP3vftiqjZGc=;
        b=EIMy6tOx0aGMh7pHaFi6EdHD3pwnqSpp3NgNCIviXZsiyUR1ZqSw3DtGPX+h0yCEdE
         loPrdC3bjAiu6K1+GkM3uYmKXC8IkxTu7CqCFfCH5tUgNx5Bw78LNrjiLvqS9yqMqJc9
         G9h67KLt/eGQJG/9OYYFI/RQekZc13zxSSgm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704606864; x=1705211664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+WLp3U3zZ/tGPOXpKoB0JjWL2Gl79ktP3vftiqjZGc=;
        b=ABDq4Sf46YwTsaw/rrKgTynNxY/NLLyQNhx4mWlYM31DHbdG7PKq6PvOxysxDmd2rw
         MtPVEgTZTAlxY1p7T6UOWJX+AtYTcCVg93V3YaoGMBfFuL3C2990b8XBDQt5oYAIvg/t
         JX49zpm6PcDvAWuYfCs+8TkxHp5CGak4P0vNbr5NCDF/l8KL/nEW8Z+okBkFhg/Ddtox
         dEn1PG5lV0pmh3gqIwBC5buBlwJlVMmZoBHSwcn98tr/dILSq0z1bBndANRxVQmRzWf5
         hFBnasS+I3mrJrTW6amGSKuFORd2thSO8p4veyQtvcE9PsqHvgfmj6nURzriP/JMXP4n
         hzCA==
X-Gm-Message-State: AOJu0Yx0oIE7E3VoLnr+wTZvf+J1E2VHY1TSP9TKz8zCuIYOg2Y4E0Iq
	3HJzbxs7bRnwRE7n8nVmlZDFNbNEMQqBLJhe5lsYy7egGJzHjOe7
X-Google-Smtp-Source: AGHT+IEegqjF78FAZt/w7XA4bIrBi7yUAJgYNq+tF9HgPiISc63afduJcVSBeKRAEVxMYL73AC5AwQ==
X-Received: by 2002:a19:914d:0:b0:50e:ab9b:c1d with SMTP id y13-20020a19914d000000b0050eab9b0c1dmr503235lfj.37.1704606864045;
        Sat, 06 Jan 2024 21:54:24 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id q20-20020ac246f4000000b0050cc8bda3a6sm713477lfo.238.2024.01.06.21.54.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 21:54:23 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e835800adso775684e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 21:54:23 -0800 (PST)
X-Received: by 2002:a05:6512:98b:b0:50e:6e7b:1acc with SMTP id
 w11-20020a056512098b00b0050e6e7b1accmr424707lft.129.1704606862788; Sat, 06
 Jan 2024 21:54:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401070147.gqwVulOn-lkp@intel.com> <ZZnzd3s2L-ZwGOlz@google.com>
In-Reply-To: <ZZnzd3s2L-ZwGOlz@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 6 Jan 2024 21:54:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjLaBe3Y_H5WArWdQ6d36+UOQ7NSbga1w+esGYJZaVfVg@mail.gmail.com>
Message-ID: <CAHk-=wjLaBe3Y_H5WArWdQ6d36+UOQ7NSbga1w+esGYJZaVfVg@mail.gmail.com>
Subject: Re: include/asm-generic/unaligned.h:119:16: sparse: sparse: cast
 truncates bits from constant value (aa01a0 becomes a0)
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-sparse@vger.kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 6 Jan 2024 at 16:42, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> This is not really a kernel/driver bug, just sparse being over-eager
> with truncation detection. I wonder if we could make sparse skip this
> check on forced casts like this:

No, please don't.

Just face the fact that using integer casts to mask bits off is a bad idea.

Yes, we could say "explicit casting is ok", since it's really the
hidden implicit casts changing values that sparse complains about, but
your solution is really ugly:

>  static inline void __put_unaligned_be24(const u32 val, u8 *p)
>  {
> -       *p++ = val >> 16;
> -       *p++ = val >> 8;
> -       *p++ = val;
> +       *p++ = (__force u8)(val >> 16);
> +       *p++ = (__force u8)(val >> 8);
> +       *p++ = (__force u8)val;
>  }

That's just disgusting.

The *natural* thing to do is to simply make the masking itself be
explicit - not the cast. IOW, just write it as

        *p++ = (val >> 16) & 0xff;
        *p++ = (val >> 8) & 0xff;
        *p++ = val & 0xff;

and doesn't that look much more natural?

Sure, the compiler will then just notice "you're assigning to a char,
to I don't actually need to do any masking at all", but now sparse
won't complain because there's no "cast silently drops bits" issue any
more.

And while the code is a bit more to read, I think it is actually to
some degree more obvious to a human too what is going on.

No?

              Linus

