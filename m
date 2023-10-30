Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18617DB520
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjJ3I36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3I35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:29:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8CBAF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:29:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FA1C433C7;
        Mon, 30 Oct 2023 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698654595;
        bh=iddVwOpjBeNoZqOUu3zqkxBTA3ogXICvytlUFVA9R28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VdvzEUQQw5mXkPiYTJRlRZByxvrlMzTqUbby84cLBjHlliKT4weKqcGAqfr9EamLu
         cvAs+pA3QVHsLR2Mj+yjT1D2gSPluQQSEIuLaoMgGR6VGiZruuDjx3UbyBgiHDdInM
         CCe0pcJ107lokyFeIzxUxjAd+AbzHOT3tly8YI7dMZiQ0972qv+T0ABLfvKpzn6yTY
         ogRoTN+4PkNIzMP75hekUEm+YaZYkm2a9/FEisjbLCLt0JE6ahSW0J5e8sWmyG4Svh
         4gJdhs2LtpUinokMMmX+WNyl14V3v3nsHp6wWwJWQa/2KuEl6c8HqgoApGeFPCmCsk
         eL0Gwxa5vc1LA==
Date:   Mon, 30 Oct 2023 09:29:51 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL for v6.7] vfs super updates
Message-ID: <20231030-anbelangt-droht-3f4947871874@brauner>
References: <20231027-vfs-super-aa4b9ecfd803@brauner>
 <20231030092009.0880e5f3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030092009.0880e5f3@canb.auug.org.au>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 09:20:09AM +1100, Stephen Rothwell wrote:
> Hi Christian,
> 
> On Sat, 28 Oct 2023 16:02:33 +0200 Christian Brauner <brauner@kernel.org> wrote:
> >
> > The vfs.super tree originally contained a good chunk of the btrfs tree
> > as a merge - as mentioned elsewhere - since we had intended to depend on
> > work that Christoph did a few months ago. We had allowed btrfs to carry
> > the patches themselves.
> > 
> > But it since became clear that btrfs/for-next likely does not contain
> > any of the patches there's zero reason for the original merge. So the
> > merge is dropped. It's not great because it's a late change but it's
> > better than bringing in a completely pointless merge.
> 
> Can you please update what you are including in linux-next to match
> what you are asking Linus to merge.

I pushed it out right when I got up. Sorry for the slight delay. I hope
the reason for this late change are not unreasonable. Let me know in
case there's a better solution I didn't think of for such a change.
