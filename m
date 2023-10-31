Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC337DCBD7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbjJaLas convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 07:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjJaLaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:30:46 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC3F91;
        Tue, 31 Oct 2023 04:30:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7396563437BD;
        Tue, 31 Oct 2023 12:30:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3_L6L093YCFA; Tue, 31 Oct 2023 12:30:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0DDB9622F591;
        Tue, 31 Oct 2023 12:30:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TrchRbFCCrbk; Tue, 31 Oct 2023 12:30:40 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id DF65E6342D5C;
        Tue, 31 Oct 2023 12:30:40 +0100 (CET)
Date:   Tue, 31 Oct 2023 12:30:40 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Message-ID: <2131754563.27779.1698751840800.JavaMail.zimbra@nod.at>
In-Reply-To: <20231031-laienhaft-weshalb-bc27f8dacd9e@brauner>
References: <20231030103415.401ce804@canb.auug.org.au> <20231030173228.691620ca@xps-13> <1541110626.24818.1698696696387.JavaMail.zimbra@nod.at> <20231031085158.o4ilb5d47sxcqm3o@quack3> <1419418117.26823.1698742930275.JavaMail.zimbra@nod.at> <20231031-laienhaft-weshalb-bc27f8dacd9e@brauner>
Subject: Re: linux-next: manual merge of the mtd tree with the vfs-brauner
 tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: linux-next: manual merge of the mtd tree with the vfs-brauner tree
Thread-Index: bbfZssUFZurWsTJgEhG6VF4CPYrWUA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian,

----- Ursprüngliche Mail -----
> Von: "Christian Brauner" <brauner@kernel.org>
>> >> A side effect of 1bcded92d938 ("mtd: block2mtd: Convert to
>> >> bdev_open_by_dev/path()")
>> >> is that it fixes the problem too. That's a good thing.
>> >> 
>> >> I'm a bit puzzled how to fix the problem for 6.5.y and 6.6.y stable releases.
>> >> Back porting 1bcded92d938 seems risky to me since the commit is large.
>> >> On the other hand, ff6abbe85634 will not make it into Linus' tree and therefore
>> >> is not suitable for stable either.
>> > 
>> > Yes, that's one of the cases where stable rules make life harder for actual
>> > fixes... You can try pushing ff6abbe85634 to stable even if it is not
>> > upstream since it fixes a real bug and taking the upstream solution is
>> > indeed IMO too intrusive. Sometimes stable maintainers accept such fixes.
>> 
>> Yep, let's try this route. :-)
> 
> Is there anything for me to do? IOW, do I need to grab that patch or
> not? :)

No, just keep Jan's patch. (-:

Miquel, we could also keep ff6abbe85634 in the mtd tree and explain Linus the
conflict, what do you think? That would help with back porting to stable.

Thanks,
//richard
