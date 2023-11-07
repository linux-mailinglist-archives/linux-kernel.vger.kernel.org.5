Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0627E32D8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 03:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjKGCP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 21:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKGCP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 21:15:27 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F0610F;
        Mon,  6 Nov 2023 18:15:24 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7788fb06997so361732685a.0;
        Mon, 06 Nov 2023 18:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699323323; x=1699928123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk4C8pGkEaO0aYtx+9DFxGow47hYHSHoEQjYuyisEbA=;
        b=dix+WuV7WEQduGPYlPNqifTplPY8MSlOy5NxoThRP5XJ1gZ8Joho1r3lrNqEd2C4Qe
         l+jQN5cLHIibrxMSWl9JsJ9HKJVUjpgQd3a8Kts+mcCsidWyXn7JPcJQLqzlvLNWB+Tr
         JW7wpvVR+N2yRLXDd37kP94dH760u6PnvKi/QUv965voohrJchnFr83X39gxlPCZ7Z5T
         5VefmRV3C3T4HxpCGG4EzhcCIcmDvUDalJubIGUaBFaErJyPiiMkQZAmoc7tZEDiOrqJ
         +Dc/KpkwROrIWMD8qhwCtRRIRoiM4aFwO/NnoOHwVyoNRMHEwqHquyBKKJDC5GggpiFv
         yVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699323323; x=1699928123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk4C8pGkEaO0aYtx+9DFxGow47hYHSHoEQjYuyisEbA=;
        b=h53jP+XZTRnd815XfUGDsyBnHGsv6mYSAEzNkTN0qQI1ooGTkD9Ghj3LDSCfiSEtgY
         pshvuHBCzSgicqnVJeWmaL38kQyfbYGsyZ5i/bPQnG+M8IfR28I90zOyYjzXUtdsSWf9
         wokeqY8vlUqQ+Zfeiip4R05n0rLt+/efHA3cj5FxiVfYanUFWj0ePPuxXjPqYt7kamry
         YTCDfSFyaLa6mldeVYZUooOk+YnXndC03fZD0UisseD+SmcBSezMZZ7cjanV1HaZluVu
         +TpkxVaiuf/mdMR4rusAP+yPK7whIycnqvB283zak56WlxIXbtQLDpcV8wgCb+dc99I6
         srlw==
X-Gm-Message-State: AOJu0YxDZyOhyvpt2MIdQMMyMgtZ9xeDgv3DZG28L1kuZWy4l6fTmmYc
        AX3JYZnfS3nLhJKhoUCY3M0=
X-Google-Smtp-Source: AGHT+IEsbtgEtm1ThrU0RGNHI2w6rhkc5V3NUgJtzFwqjIS7wWzE7nSayyO4ZlyBcgrFPy4Qz6FqbA==
X-Received: by 2002:a05:620a:40ca:b0:779:f0a1:3128 with SMTP id g10-20020a05620a40ca00b00779f0a13128mr37320412qko.63.1699323323340;
        Mon, 06 Nov 2023 18:15:23 -0800 (PST)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id bs10-20020a05620a470a00b00777611164c6sm3829790qkb.15.2023.11.06.18.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 18:15:23 -0800 (PST)
Date:   Mon, 6 Nov 2023 21:15:21 -0500
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kira <nyakov13@gmail.com>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com, Coiby Xu <coiby.xu@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Sven Joachim <svenjoac@gmx.de>,
        Ian Kent <raven@themaw.net>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: Revert "staging: qlge: Retire the driver"
Message-ID: <ZUmduQ_xKMHF6IY9@d3>
References: <20231030150400.74178-1-benjamin.poirier@gmail.com>
 <2023110655-swarm-parka-177d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023110655-swarm-parka-177d@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-06 07:54 +0100, Greg Kroah-Hartman wrote:
> On Tue, Oct 31, 2023 at 02:04:00AM +1100, Benjamin Poirier wrote:
> > This reverts commit 875be090928d19ff4ae7cbaadb54707abb3befdf.
> > 
> > On All Hallows' Eve, fear and cower for it is the return of the undead
> > driver.
> > 
> > There was a report [1] from a user of a QLE8142 device. They would like for
> > the driver to remain in the kernel. Therefore, revert the removal of the
> > qlge driver.
> > 
> > [1] https://lore.kernel.org/netdev/566c0155-4f80-43ec-be2c-2d1ad631bf25@gmail.com/
> 
> <snip>
> 
> > --- /dev/null
> > +++ b/drivers/staging/qlge/TODO
> > @@ -0,0 +1,28 @@
> > +* commit 7c734359d350 ("qlge: Size RX buffers based on MTU.", v2.6.33-rc1)
> > +  introduced dead code in the receive routines, which should be rewritten
> > +  anyways by the admission of the author himself, see the comment above
> > +  qlge_build_rx_skb(). That function is now used exclusively to handle packets
> > +  that underwent header splitting but it still contains code to handle non
> > +  split cases.
> > +* truesize accounting is incorrect (ex: a 9000B frame has skb->truesize 10280
> > +  while containing two frags of order-1 allocations, ie. >16K)
> > +* while in that area, using two 8k buffers to store one 9k frame is a poor
> > +  choice of buffer size.
> > +* in the "chain of large buffers" case, the driver uses an skb allocated with
> > +  head room but only puts data in the frags.
> > +* rename "rx" queues to "completion" queues. Calling tx completion queues "rx
> > +  queues" is confusing.
> > +* struct rx_ring is used for rx and tx completions, with some members relevant
> > +  to one case only
> > +* the flow control implementation in firmware is buggy (sends a flood of pause
> > +  frames, resets the link, device and driver buffer queues become
> > +  desynchronized), disable it by default
> > +* the driver has a habit of using runtime checks where compile time checks are
> > +  possible (ex. qlge_free_rx_buffers())
> > +* reorder struct members to avoid holes if it doesn't impact performance
> > +* use better-suited apis (ex. use pci_iomap() instead of ioremap())
> > +* remove duplicate and useless comments
> > +* fix weird line wrapping (all over, ex. the qlge_set_routing_reg() calls in
> > +  qlge_set_multicast_list()).
> > +* remove useless casts (ex. memset((void *)mac_iocb_ptr, ...))
> > +* fix checkpatch issues
> 
> In looking at this again, are you sure you all want this in the tree?
> I'm glad to take the revert but ONLY if you are willing to then take a
> "move this to drivers/net/" patch for the code as well, WITH an actual
> maintainer and developer who is willing to do the work for this code.
> 
> In all the years that this has been in the staging tree, the listed
> maintainers have not been active at all from what I can remember, and
> obviously the above list of "things to fix" have not really been worked
> on at all.
> 
> So why should it be added back?  I understand there is at least one
> reported user, but for drivers in the staging tree, that's not a good
> reason to keep them around if there is not an actual maintainer that is
> willing to do the work.
> 
> Which reminds me, we should probably sweep the drivers/staging/ tree
> again to see what we can remove given a lack of real development.
> Normally we do that every other year or so, and this driver would fall
> into the "no one is doing anything with it" category and should be
> dropped.

Thank you for revisiting this topic. I agree with you that it's better
not to add orphaned code back into the kernel. I didn't want users to be
left out in the cold by the removal of the driver, so I just created a
dkms package as a fallback:
https://github.com/gobenji/qlge-dkms

People who want to use qlge with the latest kernel can use that package.
Since the driver code is not mainline quality and there isn't much
willingness to invest in its improvement, I think it's fitting that the
code lives out of tree. Of course, if somebody takes ownership of the
code and substantially improves it, they can submit it back to netdev.
