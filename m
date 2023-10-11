Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594DA7C5D83
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346890AbjJKTQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbjJKTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:16:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6579E;
        Wed, 11 Oct 2023 12:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=2Iixwz74n+/qQuHm7XfuTlwxoPxN37yWlbh01O/lYPc=; b=jYcNObovx67rauhlwiCkVBwfUS
        uuaHyOfyGv+YmYa+pyQW/bOPGRtXKAVEz+U9Tc1FY5r3vqvZYAcrAeaGLg0aFmQDZ9HGePFHOy5Ir
        X9hJubkOl9+HbnYuxvpCvQ/ITgTNYzVXrNqGxJmqT29MK6fP7P/ynHmj9kxiuz2ZRJmJyhSNTVfmo
        yVYsaT2hQKDCAUMirvWFCbU2bVXAhUE/XtBVr7kSp+KVxMLwMBHROikAbcbJ/Tn4v1VWKrYo10Mya
        +iaX8qlzJ3YCTeaJbXhnBMm/74E+xNqYkfe54iMySjy7KbSMSYSglm0GeNn0ZgZbS4z8ue1pBVfaM
        jRcnYAqg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqehN-00GXKx-1R;
        Wed, 11 Oct 2023 19:16:49 +0000
Date:   Wed, 11 Oct 2023 12:16:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>,
        Phillip Potter <phil@philpotter.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the sysctl tree
Message-ID: <ZSb0oRABk03KOTKU@bombadil.infradead.org>
References: <CGME20231011052057eucas1p2876288636c2eaaf61a36985cffb29f8e@eucas1p2.samsung.com>
 <20231011162050.773ebb15@canb.auug.org.au>
 <20231011083612.4hymwsvc43hrwm6h@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231011083612.4hymwsvc43hrwm6h@localhost>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:36:12AM +0200, Joel Granados wrote:
> On Wed, Oct 11, 2023 at 04:20:50PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > The following commit is also in the block tree as a different commit
> > (but the same patch):
> >=20
> >   80f3c6cfab37 ("cdrom: Remove now superfluous sentinel element from ct=
l_table array")
> >=20
> > This is commit
> >=20
> >   114b0ff62a65 ("cdrom: Remove now superfluous sentinel element from ct=
l_table array")
> >=20
> > in the block tree.
> Is this a warning on the merge? or did it actually error out? if it is a
> wraning and one of the two was skipped, it can be safely ignored as they
> are the same. I can also remove that commit from my set and send another
> version. @luis: How do you want to handle it?

I just removed the cdrom patch from my tree.

  Luis
