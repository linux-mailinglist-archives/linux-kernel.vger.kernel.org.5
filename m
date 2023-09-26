Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6687AE5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjIZGWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjIZGWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:22:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B9EDF;
        Mon, 25 Sep 2023 23:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dbA4XIa80uhS+6cVPVfXoPxR8wxTGccwNsz8u6wWmI4=;
        t=1695709314; x=1696918914; b=S1nt4WadIgst3bpXk5qs+pbRmFCrutsPtFMJuKTbKCCgkeO
        CCDqA883I5L64rBir8NueneHl+9hO3FU093cc0FBqjxi6VEO+m0w1Rmmu3GP9/A7J0sLY+iVnUFq1
        JpJl+NW9GlwkHRfP9nbicqAZMt+PMCVupyq4t4OVthCNwXgHouGofPpqV1PeYWq2bvIbErQt7GsAm
        rVzNorzunLjF2DBtmYl2s8yx4oDGSU3ErsqHlCMaa91pwEgC9w71KDnSsjWO+KFkLWY4Za1kA5N89
        IF6WJDw2QLYTe802Ro1wOyYXdHg2hSttMTuOl1V2LuoObCMHHn0OiFhzEZw7v8MA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ql1S4-005EdU-2V;
        Tue, 26 Sep 2023 08:21:45 +0200
Message-ID: <de13abae1708985a88a702e1690cfb883ae11dfa.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kalle Valo <kvalo@kernel.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Tue, 26 Sep 2023 08:21:43 +0200
In-Reply-To: <20230926124111.29103070@canb.auug.org.au>
References: <20230926120253.4f1e5730@canb.auug.org.au>
         <20230926124111.29103070@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-26 at 12:41 +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> On Tue, 26 Sep 2023 12:02:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >=20
> > Today's linux-next merge of the wireless-next tree got conflicts in:
> >=20
> >   net/mac80211/cfg.c
> >=20
> > between commit:
> >=20
> >   31db78a4923e ("wifi: mac80211: fix potential key use-after-free")
> >=20
> > from the wireless tree and commit:
> >=20
> >   4d3acf4311a0 ("wifi: mac80211: remove sta_mtx")
> >=20
> > from the wireless-next tree.
> >=20
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tre=
e
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularl=
y
> > complex conflicts.
>=20
> That wasn't quite right.  The final resolution is below.

Thanks Stephen, also for the other one!

I knew about the new ones as well but forgot to give you a heads-up, my
bad, I'm sorry.

I'm planning to submit a wireless pull request today or tomorrow, and
then merge back into wireless-next once it settles in, so this should
hopefully be resolved by the end of the week or so.

Thanks,
johannes
