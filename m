Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD9F778220
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjHJUZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbjHJUZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:25:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEB12D6D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:24:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bba48b0bd2so10113895ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691699097; x=1692303897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xy0ZzzcwPkDGoYyfp8G52RWYy9ra1kyCRMs7iLe6dOM=;
        b=WVn7sjVdqUXJGmbRG17ELCWUvCBq6PaDsFvR/3vAawRgPj35EebnPSDrmbfE8JvFfw
         rcCxwxkNg4e36yNnWnTJ91RoiGMGYb+wm+5hhqSi4t91tpm593Y36YA7CLh6EDJsUCSw
         jKThFXGXVNhIIyy1Wf768qsgPR3ZOXAw7YCzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699097; x=1692303897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xy0ZzzcwPkDGoYyfp8G52RWYy9ra1kyCRMs7iLe6dOM=;
        b=QFFJCaMBomitpxZ1qQLvERG0NcwhWzroKbHEnW92594IZYNE6VjOiXnguSeQ1gIQEo
         3nJkArDHH7+yTvgxK6KgPrPyCj+8B/knBIlLRi2YXXYa8Qpc4XMDbd4JTS7Vb+VcJr3H
         MHDu65YcQbyGPYWVtSp7L8i0k2BReBGR7no5Xq0pNq72wJZFLcaWH/hyM9UX4yyk4UFf
         t1LY1yh0Pd8y+oWF0NznI2XCHgWM3BEeBe7OGxmiWQeP3kW97dSQomhHiagMFnRFczWu
         /hl6F5tXLngbrWRWgl3RShUZWLP58wt5VEb179wilMIk5ktxXvdMigamg9So/hHoMlD0
         z+Yw==
X-Gm-Message-State: AOJu0YwCOHQo30eWSZf9NgxOjNBBUdlcI9APIVrk7J5yBPAolb4aUDVW
        +BG8yvSOKVDq09GNoYiLLwhztA==
X-Google-Smtp-Source: AGHT+IGSDGQbaaRP58KsSs6NslB0II9aNb+59mDIfWR0dtapfFh0VJmGfPV7n6lF8qWKKUYcP3g4FA==
X-Received: by 2002:a17:903:2444:b0:1b5:edd:e3c7 with SMTP id l4-20020a170903244400b001b50edde3c7mr3406756pls.16.1691699096740;
        Thu, 10 Aug 2023 13:24:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c18-20020a170903235200b001b8b07bc600sm2183878plh.186.2023.08.10.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:24:56 -0700 (PDT)
Date:   Thu, 10 Aug 2023 13:24:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Kees Cook <kees@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: binfmt_misc & different PE binaries
Message-ID: <202308101323.F17474FEB6@keescook>
References: <20230706115550.sqyh3k26e2glz2lu@pali>
 <20230806162346.v7gjoev2nepxlcox@pali>
 <C636CC6D-9504-4B81-8B47-2734C70F20C2@kernel.org>
 <20230807170852.yefmkcqwum6gdao6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230807170852.yefmkcqwum6gdao6@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 07:08:52PM +0200, Pali Rohár wrote:
> On Monday 07 August 2023 07:45:08 Kees Cook wrote:
> > On August 6, 2023 9:23:46 AM PDT, "Pali Rohár" <pali@kernel.org> wrote:
> > >Hello, I would like to remind this email about binfmt_misc for PE.
> > >
> > >On Thursday 06 July 2023 13:55:50 Pali Rohár wrote:
> > >> Hello,
> > >> 
> > >> I would like to ask how to properly register binfmt_misc for different
> > >> PE binaries, so kernel could execute the correct loader for them.
> > >> 
> > >> I mean, how to register support for Win32 (console/gui) PE binaries and
> > >> also for CLR PE binaries (dotnet). Win32 needs to be executed under wine
> > >> and CLR ideally under dotnet core (or mono).
> > >> 
> > >> I have read kernel documentation files admin-guide/binfmt-misc.rst
> > >> and admin-guide/mono.rst. But seems that they are in conflicts as both
> > >> wants to registers its own handler for the same magic:
> > >> 
> > >>   echo ':DOSWin:M::MZ::/usr/local/bin/wine:' > register
> > >> 
> > >>   echo ':CLR:M::MZ::/usr/bin/mono:' > /proc/sys/fs/binfmt_misc/register
> > >> 
> > >> Not mentioning the fact that they register DOS MZ handler, which matches
> > >> not only all PE binaries (including EFI, libraries, other processors),
> > >> but also all kind of other NE/LE/LX binaries and different DOS extenders.
> > >> 
> > >> From documentation it looks like that even registering PE binaries is
> > >> impossible by binfmt_misc as PE is detected by checking that indirect
> > >> reference from 0x3C is PE\0\0. And distinguish between Win32 and CLR
> > >> needs to parse PE COM descriptor directory.
> > >> 
> > >> Or it is possible to write binfmt_misc pattern match based on indirect
> > >> offset?
> > 
> > Normally a single userspace program will be registered and it can do whatever it needs to do to further distinguish the binary and hand it off to the appropriate loader.
> 
> Ok, so you are saying that there should be one userspace program which
> distinguish between DOS, CLR and Win32 and then exec the correct
> "runtime" loader? Is there such one? Also it would be nice to mention it
> in the documentation.

I've not spent much time with it, but I think Wine can be set up to
do this?

Anyway, I'm happy to apply Documentation patches, if you want to send
changes that would make things more clear. :)

-Kees

-- 
Kees Cook
