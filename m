Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2796767456
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjG1SQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjG1SQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:16:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD882682;
        Fri, 28 Jul 2023 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=4l2OKOCTBkocwwwCry0x9wCe/bQtbkKGE/ozzQ6Bh2w=; b=2a+wQBD5x3seY3ue4o1ZH5Z7OF
        P4MGyE9a9WMqTlf+nWuqEsENti7EnedpkT6l2qa8Rkr5fnkRcYlxmKBrtKCHyskUPIFZFSrcBNqBD
        2ujAu4SBWkdFSDJbDI27XpuxjVGNvDZxDK/lj9Di8oFhxGrB4sNaTLBVXsxWg91VLPQl4fYJCY10J
        O/wSW8O0iHiln698K8a35vWZnqHP0FWLsvIW1QbdykoGkTAUaBdM1agJBPmSmliakDuy9qttbSpoi
        HHng6Bmt/oLBPjkEvOrKZzfmTzG/AVWtgx+S/I3FCrSfBfRVh0+rV87QaDaFY+esYW8xGbL9FO76P
        RW/bXx6g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qPS0U-004SVu-0N;
        Fri, 28 Jul 2023 18:16:06 +0000
Date:   Fri, 28 Jul 2023 11:16:06 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Joerg Reuter <jreuter@yaina.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, willy@infradead.org,
        keescook@chromium.org, josh@joshtriplett.org,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] ax.25: Update to register_net_sysctl_sz
Message-ID: <ZMQF5mN7wWN2eax3@bombadil.infradead.org>
References: <20230726140635.2059334-1-j.granados@samsung.com>
 <CGME20230726140703eucas1p2786577bcc67d5ae434671dac11870c60@eucas1p2.samsung.com>
 <20230726140635.2059334-10-j.granados@samsung.com>
 <ZMFfRR3PftnLHPlT@bombadil.infradead.org>
 <20230727123112.yhgbxrhznrp6r3jt@localhost>
 <ZMKQ2OuFy1deZktP@bombadil.infradead.org>
 <20230728073536.egpe6to3s3pndi6r@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230728073536.egpe6to3s3pndi6r@localhost>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:35:36AM +0200, Joel Granados wrote:
> On Thu, Jul 27, 2023 at 08:44:24AM -0700, Luis Chamberlain wrote:
> > On Thu, Jul 27, 2023 at 02:31:12PM +0200, Joel Granados wrote:
> > > There are no deltas in this patch set. We start seeing the deltas when
> > > we start removing with the next 6 chunks. I'll try to make that more
> > > clear in the commit message.
> >=20
> > Indeed, even if no deltas are created it is importan then to say that.
> > If there are no deltas the "why" becomes more important. If the why is
> > to make it easier to apply subsequent patches, that must be said. When
> yes. The why for this patch set in particular is to make it easier to
> apply the sentinel removal patches.
>=20
> I think the difficulty for me comes from having two whys: 1. The one for
> this patch set which is to make it easier to apply sentinel removal patch=
es. And 2.
> The one for the "big" patch (that actually removes the sentinels) which i=
s to
> reduce build time size and run time memory bloat.

The 2) is part of the real why, 1) is more of how to do 2) cleanly. But
the real why is the savings in memory because we are moving arrays out
of kernel/sysctl.c so we don't want to incur a size penalty. The
collateral to avoid increasing size in the moves also proves to save us
more memory overall, on the ballpark of about 64 bytes per array in the
kernel both at runtime and build time. The build time gain is mostly
on the __init stuff and so gets freed right away, but since sysctl
code always kzallocs the arrays passed we also save 64 bytes per array
in the end at runtime.

  Luis
