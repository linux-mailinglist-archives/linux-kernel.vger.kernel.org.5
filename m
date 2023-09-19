Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88AF7A667D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjISOVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjISOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:21:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E31ABC;
        Tue, 19 Sep 2023 07:21:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E5AC433CA;
        Tue, 19 Sep 2023 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695133305;
        bh=OLGKg2iMG9dTfJrkzQ0h2s08cPlYG/WKcUNh8bwvzmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n2j0iOKxNtUkqLvfzDXhvYimWUm8r+S8EBHfqaAGSlAWope2jGcd6faUDZBwC49if
         TcPqvbMhk2vsqLC8vCB944/K3k8RoGLic9rgiuqk/9WmfJANhTDHZr9DmlmG5fLH8q
         nUnA6og0rqNTrKjuq8tfZGxCWZV1NE9B6tusxEUF70r2ZSOWVgc4dvybsNcb3c7hJS
         um9ze8RmQN1oKsPMXxgUBjHsCP9xndy/jHp8J6Ngiize8EWQqdPYiXwsdUsx6j/u6E
         iTzwc5fAwlk3lq0zNGAGZMB7i4wik8TpWeKPg/sm5SBKa6OJbvA48jVQryuC1pKUo8
         Iscv9W81Sqa+g==
Date:   Tue, 19 Sep 2023 15:21:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Subject: Re: linux-next: Tree for Sep 15 (drivers/mfd/cs42l43.o)
Message-ID: <20230919142140.GW13143@google.com>
References: <20230915120127.1bc03420@canb.auug.org.au>
 <fb3f00ab-178c-45cf-ba39-baf61bb3f117@infradead.org>
 <20230918144033.GQ13143@google.com>
 <5baf9fcb-1c53-48b3-8742-ca3c98d82ebc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5baf9fcb-1c53-48b3-8742-ca3c98d82ebc@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023, Randy Dunlap wrote:

> 
> 
> On 9/18/23 07:40, Lee Jones wrote:
> > On Fri, 15 Sep 2023, Randy Dunlap wrote:
> > 
> >>
> >>
> >> On 9/14/23 19:01, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> Changes since 20230914:
> >>>
> >>> The btrfs tree gained a conflist against the mm tree.
> >>>
> >>> The device-mapper tree gained a build failure so I used the version
> >>> from next-20230914.
> >>>
> >>> The kspp tree lost its build failure.
> >>>
> >>> Non-merge commits (relative to Linus' tree): 5026
> >>>  2501 files changed, 391711 insertions(+), 34318 deletions(-)
> >>>
> >>> ----------------------------------------------------------------------------
> >>>
> >>
> >> on arm64:
> >>
> >> aarch64-linux-ld: drivers/mfd/cs42l43.o: in function `cs42l43_boot_work':
> >> cs42l43.c:(.text+0x19d4): undefined reference to `devm_regmap_add_irq_chip'
> >>
> >> Using GCC 13.2.0 from kernel.org crosstools.
> >>
> >> Full randconfig file is attached.
> > 
> > Who is the intended consumer of this report?
> > 
> 
> I Cc-ed the driver maintainers and the subsystem maintainer.
> However, I missed Cc-ing the person who git blame identifies
> for this patch. (added now)
> 
> > Are you planning on following up with a patch?
> 
> Sure, I will do that.

Thanks for considering it.  Thanks again for actually doing it.

And sorry that a fix (that I hadn't yet seen) was already on the list.

-- 
Lee Jones [李琼斯]
