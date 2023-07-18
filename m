Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D20F757E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjGRNps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjGRNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:45:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C221A5;
        Tue, 18 Jul 2023 06:45:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3F9EA218F8;
        Tue, 18 Jul 2023 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689687914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQo/Mhmxixg5Bb6s5QcDWthWwMTu5gcyPygXHu8XstQ=;
        b=Le6XpUoQwDvom8ZXV6HYvrddqdBrD10ugGQMKacFaTodBuPqFp1Z3/5I9Pslr0xhh5IUqv
        03rAJ2mcn7wCuUJtlTkITKG8vSvm/6p9OFO20KjUz9x6H1AvUKfk4YR3T3TlUSZQmzA6/K
        qZetjpGuksMqF6YX3MOaazODWmDVNVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689687914;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQo/Mhmxixg5Bb6s5QcDWthWwMTu5gcyPygXHu8XstQ=;
        b=20G+al1hEi9L1uunpt//at+QCvxuncUqhTK3Pel+CtRHzAw8xdvdqeseuZ/I2IqFccdAS0
        Yx3OqS1Wc6Er0sAQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 118DB2C142;
        Tue, 18 Jul 2023 13:45:13 +0000 (UTC)
Date:   Tue, 18 Jul 2023 15:45:11 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v4 4/4] libkmod, depmod, modprobe: Make directory
 for kernel modules configurable
Message-ID: <20230718134511.GY9196@kitsune.suse.cz>
References: <20230711153126.28876-1-msuchanek@suse.de>
 <cover.1689589902.git.msuchanek@suse.de>
 <cc04472084dc016679598fcffafc788bbb6d9c0f.1689589902.git.msuchanek@suse.de>
 <76o21q7n-8qo8-37p6-oqno-q08nqpos471@vanv.qr>
 <20230718084300.GU9196@kitsune.suse.cz>
 <81n281ns-s8on-rsrn-pp61-q28pn42ns531@vanv.qr>
 <20230718102958.GW9196@kitsune.suse.cz>
 <pq42o77-73np-66r-rrn9-ns24o907n59@vanv.qr>
 <20230718122731.GX9196@kitsune.suse.cz>
 <7848n6p3-or5-38r3-rp14-3r5p24n43928@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7848n6p3-or5-38r3-rp14-3r5p24n43928@vanv.qr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 02:42:42PM +0200, Jan Engelhardt wrote:
> 
> On Tuesday 2023-07-18 14:27, Michal Suchánek wrote:
> >> >
> >> >That breaks kmod for the usrmerged distributions, though.
> >> 
> >> Does it though?
> >> The *distro* has /lib -> /usr/lib,
> >> the *staging area* for installation does not.
> >
> >Yes, currently the fully installed distribution has the symlink, at
> >least openSUSE does.
> >
> >However, there is a goal to remove it eventually, and even now it is not
> >present at all times.
> 
> The ELF interpreter /lib/ld-linux.so.2 is hardcoded everywhere.

Sure, there are other problems.

I will leave that for others that are familiar with that part of the
system.

Thanks

Michal
