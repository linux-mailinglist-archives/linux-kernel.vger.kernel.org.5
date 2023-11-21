Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF657F37C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjKUUzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUUzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:55:22 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EBC19E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:55:17 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so8621963a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700600116; x=1701204916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAXHno8+c8gqgkWr62xW0IQIaSMEQfDVytD9MPG+ruo=;
        b=UegfZh+pbtWa7wEzbQEbxm/rvSTZhnGyjYIZCMmtk3dL81R0znbugRjVEtWJyjTKMv
         TmFwkNcqPwMJoexeCD/ukcWAoMJ3ohmIQKuQQ/w54N8tTp/5VplqQ1ByqTXnJgJTdDW9
         6NeIy2uxYhFKlSYyz8OsfGv5Hj3bguumDn/r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700600116; x=1701204916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAXHno8+c8gqgkWr62xW0IQIaSMEQfDVytD9MPG+ruo=;
        b=eC3pg5SHajVxtkQ/1mge20EicogdPvCaBLFHk49Wt//Mmh/Z84oy2ZwWLMcLF5GRce
         75un2HjRFfcabBjdiJMZrW7ADai9TLItGmd/o8Tl5rNn6GULeQLJcXDwlWlI4xDx9Jk3
         IkA2xiiuilZ8JOl8LBWh5p4oJrpoqunteh2Z0tXaFaKebzLpnwXbW1hfLBdSCv+GwwLY
         2BPhxmFW3KpplfIVwmA1s3/Jb5Pbna0L50NuvGo1B/EJ3VQ5ttx1X77seO4oUfZPkqDC
         JH6sBn+2KDcaBviWHxIbQg7IxCokFmvVoKUKH4r9Z0cI7x3n8jspUKux3a7exqnitIPJ
         UElw==
X-Gm-Message-State: AOJu0YzBZj6wh5oUkGrH3m+34ugC6fj2+/HcybF01OsB0MOaxgjZZgTu
        4hYDRlgVonA2KapQm30/JB0jKjmJjpBiYCFdTuFlfA==
X-Google-Smtp-Source: AGHT+IGovfLhMdd/OpOFaioDL2WbqWiIBsUvdLan6eYz3+DcvFA64Gsbw57fdZRgs1t0KfKjg4iIpg==
X-Received: by 2002:a17:907:1a54:b0:9bf:889e:32a4 with SMTP id mf20-20020a1709071a5400b009bf889e32a4mr47896ejc.54.1700600115917;
        Tue, 21 Nov 2023 12:55:15 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id dv8-20020a170906b80800b009fdc15b5304sm3173177ejb.102.2023.11.21.12.55.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 12:55:15 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a011e9bf336so223837466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:55:15 -0800 (PST)
X-Received: by 2002:a17:906:1185:b0:9e5:ee70:5da1 with SMTP id
 n5-20020a170906118500b009e5ee705da1mr51591eja.53.1700600114697; Tue, 21 Nov
 2023 12:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20231121010318.524570-1-nickrterrell@gmail.com>
 <20231121010318.524570-3-nickrterrell@gmail.com> <CAHk-=whL+1xR_LJwJ7DRhFo2gkDv0jrRMX5PJoULoSBXppEV8A@mail.gmail.com>
 <D42705E6-94D3-4E3B-9BA8-AFFCE4B8E4E4@meta.com> <CAHk-=wjcft4VEVBwSeaczuonUAGyT4BKt5PimekDpL9ygHC5cg@mail.gmail.com>
 <41F084AA-F027-4288-9F26-E33337E1516A@meta.com>
In-Reply-To: <41F084AA-F027-4288-9F26-E33337E1516A@meta.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Nov 2023 12:54:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgF4ooJa18rYNZZQucn4YvVv+f1PCzm35_WHysyeEL+ng@mail.gmail.com>
Message-ID: <CAHk-=wgF4ooJa18rYNZZQucn4YvVv+f1PCzm35_WHysyeEL+ng@mail.gmail.com>
Subject: Re: [PATCH 2/2] zstd: Backport Huffman speed improvement from upstream
To:     Nick Terrell <terrelln@meta.com>
Cc:     Nick Terrell <nickrterrell@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yann Collet <cyan@meta.com>,
        Kernel Team <kernel-team@meta.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 at 12:35, Nick Terrell <terrelln@meta.com> wrote:
> >
> > Honestly, any coding rule that includes "don't use the do-while-zero
> > construct" is actively broken shit.
> >
> > Please just fix your upstream rules. Because they are incredible garbag=
e.
>
> Yeah, that=E2=80=99s the plan. Visual Studios fixed that compiler bug in =
VS2015 [0],
> so we should be safe to migrate to safer macros.

I don't even use MSVS, but a minute of googling shows that you should
never have done that silly "avoid sane C", and you should always just
have done

  #pragma warning (disable: 4127)

for MSVC.

Honestly, the fact that the result was instead to disable that
standard - and required - construct in the project makes me worry
about the whole zstd thing. WTF?

The do-while-zero construct is _so_ important that there are (sane)
projects that literally *require* the use of it. See for example MISRA
code safety rules.

The kernel rules aren't quite that strict, but yes, do-while-zero is
very much "you should *absolutely* do this" along with all the usual
"make sure you have parentheses around macro arguments" rules.

We had some RFC patches for this area:

   https://lore.kernel.org/all/20230511152951.1970870-1-mathieu.desnoyers@e=
fficios.com/

And on that note, when I googled for the solution to the MSVC brain
damage, I was distressed by how many hits I saw where people thought
the do-while-zero pattern was some "legacy pattern".

That just shows that there are lots of incompetent people simply do
not understand why it's actually *required* for reliable parsing of
macros.  This is not some "historical stylistic" issue, it's literally
a correctness issue for generic macro usage.

           Linus
