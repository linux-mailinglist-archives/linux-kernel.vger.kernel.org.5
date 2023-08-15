Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A4D77CA81
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbjHOJd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbjHOJcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:32:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483082128
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D242F61AC0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD28C433C8;
        Tue, 15 Aug 2023 09:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692091887;
        bh=u1EKdogOX8EJIbbIY8n7utH2neOMOPbqocDafa59wvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bs/UTXoNq3dIn97bNF2+IQr6POInk3+KcZkWMVSWKfRbqkMn8rT8epQWe4VbfQ3du
         sf1o5LRAsnMa1p5TbBEnc1MZlym6H2FAVT56XnRMQCjZpY09aJbIGc32cXVa6tZ6Vw
         M+wfY727A8Vra6uy9KOplz6z2P7nrxtkz56v3lVfGdpbV2S2cueawKvH46NAYBuBvH
         wDbgFQduWtQUsAqmNWWMcAH4ZGzcsq5asYsPQyIVR/noSr0ie4+eyaJPI36N65aGLv
         0dicKI47MlbE8w2cIqlU4S82qDCNCdm7MVBzki+TGZTcwuLgYALp4b/tN58U2KvIxt
         hXYDrM/tL0UrA==
Date:   Tue, 15 Aug 2023 11:31:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking: remove spin_lock_prefetch
Message-ID: <20230815-befallen-unsitte-56c112077690@brauner>
References: <20230812161554.1676652-1-mjguzik@gmail.com>
 <20230815-abklatsch-naschen-651453779dca@brauner>
 <CAGudoHHKpAH4DJvbSRMTfo4+HHBBBx7JF56UUGQtj-JPt+zimQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHHKpAH4DJvbSRMTfo4+HHBBBx7JF56UUGQtj-JPt+zimQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:05:00AM +0200, Mateusz Guzik wrote:
> On 8/15/23, Christian Brauner <brauner@kernel.org> wrote:
> > On Sat, 12 Aug 2023 18:15:54 +0200, Mateusz Guzik wrote:
> >> The only remaining consumer is new_inode, where it showed up in 2001 in
> >> the following commit in a historical repo [1]:
> >>
> >> commit c37fa164f793735b32aa3f53154ff1a7659e6442
> >> Author: linus1 <torvalds@athlon.transmeta.com>
> >> Date:   Thu Aug 16 11:00:00 2001 -0800
> >>
> >> [...]
> >
> > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > Patches in the vfs.misc branch should appear in linux-next soon.
> >
> 
> this already landed in master, see c8afaa1b0f8bc93d013ab2ea6b9649958af3f1d3
> 
> so please drop :)

Ah, I didn't see Linus reply here so I assumed he didn't pick it up.
Thanks.
