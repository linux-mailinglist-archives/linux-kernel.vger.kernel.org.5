Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1493479C72D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjILGuO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 02:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjILGuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:50:12 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D768AF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:50:09 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-58cbdf3eecaso50769857b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694501408; x=1695106208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2jmL2QJQ6yvyRkvFzK/bM+xKMlObl6Dh8fWe3NMsS0=;
        b=vKanynbY0P9viva6ev/DaDD6c0HfinAypeOiYz4Z61zozSZ+jIEGZV+GsOOm8dGaTX
         aO2pl9Y7N4eF6etY8Bs8FDB6KhNVMaAlgE30EL3IM5jWZwpwPIweszfoRrVECr45WNMD
         WTt3imvQVlhkAVmEG0XCbLjito6n8+cz4Doa2UcHbxVk4Dw3eSpAYXn+nVIwJ2Qd8UNy
         0z2UWP15N0uXD05aEXJZmlWJGjQCoXl5ofWVVbHVd4hqnOlMx6YYKaZ59pzeXQGTPF6S
         QUhCGLLUkOY6Ae4d1TANSXlgVbYVv+twGMoi8ZgRC+HDWbFDPlvvowL6KSHroWmOVyJy
         4uxg==
X-Gm-Message-State: AOJu0YxB2VOUeI5dBZWb5rafl/MmTCYymyOOQpqlfe+tbL8HhSnduVKu
        VcMxSDN07jZJis9EPAPXcvtpOhYx+zrXfA==
X-Google-Smtp-Source: AGHT+IF28+k8qHmVL9mIePDpLHKBEhZJajLT38eJnHmC5kyDWQj0EobAwKnqoN9TqfA6g7ZJHJ8KJg==
X-Received: by 2002:a25:768f:0:b0:d7b:9f03:20c9 with SMTP id r137-20020a25768f000000b00d7b9f0320c9mr11719112ybc.10.1694501408086;
        Mon, 11 Sep 2023 23:50:08 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id m64-20020a252643000000b00d800eb5ac2asm2062503ybm.65.2023.09.11.23.50.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 23:50:07 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d7ecdb99b7aso4734937276.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:50:07 -0700 (PDT)
X-Received: by 2002:a5b:743:0:b0:d05:bf5b:918f with SMTP id
 s3-20020a5b0743000000b00d05bf5b918fmr9727248ybq.28.1694501407315; Mon, 11 Sep
 2023 23:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com>
 <20230911083848.1027669-1-geert@linux-m68k.org> <8b5d0d32-4413-4c70-4ecb-ee44542f4dd5@infradead.org>
In-Reply-To: <8b5d0d32-4413-4c70-4ecb-ee44542f4dd5@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Sep 2023 08:49:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUaXjDJ3=rPoUj3XD-fVXyfqQvohfn5FX=_21hOgGqeEg@mail.gmail.com>
Message-ID: <CAMuHMdUaXjDJ3=rPoUj3XD-fVXyfqQvohfn5FX=_21hOgGqeEg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.6-rc1
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, Sep 12, 2023 at 1:08 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/11/23 01:38, Geert Uytterhoeven wrote:
> > 4 warning regressions:
> []
> >   + modpost: WARNING: modpost: vmlinux: section mismatch in reference: ioremap_prot+0x88 (section: .text) -> ioremap_fixed (section: .init.text):  => N/A
>
> I would consider trying to fix this one but I can't fathom trying to search thru 237 build logs with a web browser
> to find which arch/config it is.
>
> I did start on that but I'm giving up.
>
> If possible, please add the arch/config info to the Build regressions/improvements reports
> in the future.

I always reply with more details after my analysis (which is a manual
process).  Unfortunately, due to hick-ups with vger and lore, none of
the emails I sent out yesterday using git-send-email made it to the
lists before last night, so I didn't have anything to reply to until
this morning...

Today, the email issues seem to have been fixed (although I still
haven't received the report myself, but at least lore now has it),
so the analysis is there.

And FTR, I sent out a fix for the section mismatch yesterday, and
Andrew has already picked it up.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
