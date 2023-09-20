Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554F17A77B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjITJh5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Sep 2023 05:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjITJhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:37:52 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337259E;
        Wed, 20 Sep 2023 02:37:46 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-773e8a62b05so84946785a.0;
        Wed, 20 Sep 2023 02:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695202665; x=1695807465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcKwdyW9PID8T3nWdTHS9gLtWKlKQ0LLCT75T/ZuZuw=;
        b=AkC6DMGnUzgWzgb2VOFpDVphNQTtmyCgY3FeFJvDZbDSghkEst1X2Yg+IOyNyjtsWx
         OGccdTCh0IJRGpk3lt1ub0TzYZtQxctRjWuOVAQwT8slSd80IpA2wnt5HgwcDbzCQDF4
         UlduL59SZwXfpWV2DZDZTOew6TRoRp/cbsvOvi2+ffVzPhTVKmWhyhnWJEFOjhbfuHbO
         ctg47Y5u14rAxzc8H3NW8ZsEpFkY9EhUwt9mPRztBOce+qz/jXVPuQE3FWCEJiNLzH92
         KLRRdcxEKs5JRAkN995I0tYfD8JRA6OdzvbNOJflHQNF4P3GPZFoyAi2jpJIafXt8q7s
         0fYQ==
X-Gm-Message-State: AOJu0YwHPbrC8gegmpsqQdthUA9A7iNLjegXfCqOzhj3qhqxbGQVwC/u
        54ntOOFcyvWZM4PUPbHk8but7LXFkrhofw==
X-Google-Smtp-Source: AGHT+IHAmfPYX0T2pYm4Tposc4SM/FZTjzTsi0LvEINKR7shef7bVnTyYlrZx3ne8+hzrSSbiiHmMw==
X-Received: by 2002:a05:620a:2443:b0:773:b795:c9e9 with SMTP id h3-20020a05620a244300b00773b795c9e9mr2435905qkn.17.1695202665006;
        Wed, 20 Sep 2023 02:37:45 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id i11-20020a37c20b000000b0076e1e2d6496sm4682171qkm.104.2023.09.20.02.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 02:37:44 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-414b0bdea1cso40766741cf.1;
        Wed, 20 Sep 2023 02:37:44 -0700 (PDT)
X-Received: by 2002:a0d:c705:0:b0:59c:1880:18e0 with SMTP id
 j5-20020a0dc705000000b0059c188018e0mr1688724ywd.21.1695202235254; Wed, 20 Sep
 2023 02:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230918175529.19011-1-peter@n8pjl.ca> <20230918234108.GN19790@gate.crashing.org>
 <20230919000026.7409-1-peter@n8pjl.ca> <20230919151630.GO19790@gate.crashing.org>
 <20230919155832.4179-1-peter@n8pjl.ca> <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
 <20230919161535.4774-1-peter@n8pjl.ca>
In-Reply-To: <20230919161535.4774-1-peter@n8pjl.ca>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Sep 2023 11:30:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWQwDzAnbQvBvt3iuL=UPxtufU=TgQM=oKjDvmgmrcy3g@mail.gmail.com>
Message-ID: <CAMuHMdWQwDzAnbQvBvt3iuL=UPxtufU=TgQM=oKjDvmgmrcy3g@mail.gmail.com>
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
To:     Peter Lafreniere <peter@n8pjl.ca>
Cc:     anton.ivanov@cambridgegreys.com, ink@jurassic.park.msu.ru,
        jack@suse.cz, johannes@sipsolutions.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, reiserfs-devel@vger.kernel.org,
        richard.henderson@linaro.org, richard@nod.at,
        segher@kernel.crashing.org, tsbogend@alpha.franken.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Sep 19, 2023 at 6:16 PM Peter Lafreniere <peter@n8pjl.ca> wrote:
> On Tue, Sep 19, 2023 at 12:02, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Sep 19, 2023 at 5:58 PM Peter Lafreniere peter@n8pjl.ca wrote:
> > > 2) Stops building an obsolete and largely-unused filesystem unnecessarily.
> > > Some hobbyist targets like m68k and alpha may prefer to keep all filesystems
> > > available until total removal, but others like arm and UML have no need for
> > > ReiserFS to be built unless specifically configured.
> >
> >
> > As UML is used a lot for testing, isn't it actually counter-productive
> > to remove ReiserFS from the UML defconfig? The less testing it
> > receives, the higher the chance of introducing regressions.
>
> UML is used for testing, but in my view that makes the inclusion of
> ReiserFS in its defconfig even worse. Users of UML are trying to test a

Why?
Because you want to avoid doing any testing at all on deprecated features?

> particular function, and so tend to use ext[2-4], as those are included in
> the defconfig and are well tested and stable. So there is no extra testing
> being done on ReiserFS due to its inclusion in the defconfig.

I'd expect global file system testers to use something along the line of:

    for i in $(grep -v nodev /proc/filesystems ); do
        echo --- Testing $i ---
        dd if=/dev/zero of=testimage bs=1M count=1 seek=10000
        mkfs.$i testimage
        mount testimage /mnt -t $i
        [run xfstests on testimage]
        rm -f testimage
    done

> Keeping UML's defconfig as slim as possible improves build times, which is
> particularly important for kernel testing and development.

Good luck testing all functionality using a "slim" kernel ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
