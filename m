Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36A47D4EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjJXLd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjJXLdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:33:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8052D7F;
        Tue, 24 Oct 2023 04:33:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC51DC433CA;
        Tue, 24 Oct 2023 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698147233;
        bh=X62QOZGcCHvGfKNC+rsSFzoHU54y9RQXxs/RK89NVxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HU+aus46hGm70PmcX4/IPTBrSiVnbOW7VUGjUOqZ5+CMIrLFoQqsrbqqQPK85QxF4
         zb0vKN1OSZmiC3D/LcvRMIvBIaU6RnNPtAx/alRNdBOzKFy2prZkc94niKFcXAw1v5
         gtpmTH2teO3ZTPS3FU3N4fyQV7HZjN2imszkmNyBoNxemjbSon3jfFKLH1h6Q5ZmPz
         knhMCXgM+/CxKf0C/lmuG2vVODN5asV/qM90vhqqlCeJVbGM7lTlSxF8FBoJ6FRgYR
         PGtsHTHcnd4T529vg8Pe2YZ6MyOdXwlTisMAxvHu5bm5IzK+7CLHBm4xavjyoRzGwM
         AZw4EEEG3hecQ==
Date:   Tue, 24 Oct 2023 13:33:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Yikebaer Aizezi <yikebaer61@gmail.com>,
        reiserfs-devel@vger.kernel.org,
        "dchinner@redhat.com" <dchinner@redhat.com>, jlayton@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: KASAN use-after-free Read in search_by_entry_key
Message-ID: <20231024-unmotiviert-bezog-0580682e4772@brauner>
References: <CALcu4raE3hoh7pLNJBjxWeWv18QOR1XPt4E=XWmdg_b9CN-5Cg@mail.gmail.com>
 <20231024100834.aqwedigye4qa3wfv@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024100834.aqwedigye4qa3wfv@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 12:08:34PM +0200, Jan Kara wrote:
> Hello!
> 
> On Tue 24-10-23 10:30:46, Yikebaer Aizezi wrote:
> > When using Healer to fuzz the  Linux 6.6-rc7 Linux kernel,  the following crash
> > was triggered.
> 
> Thanks for report but I don't think there's a big interest in fixing
> reiserfs errors found by a fuzzer. Reiserfs is scheduled for removal from
> the kernel so it would be mostly a wasted effort.

Agreed, but also note that this is from a private syzkaller instance
with google drive links which makes me shy away from this tbh.

I don't think we should encourage private syzbot reports as that will
end up a nightmare for us all.
