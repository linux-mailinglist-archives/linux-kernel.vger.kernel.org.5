Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC747CF470
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345074AbjJSJvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJSJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:51:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1F410F;
        Thu, 19 Oct 2023 02:51:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5394E1F88B;
        Thu, 19 Oct 2023 09:51:43 +0000 (UTC)
Received: from lion.mk-sys.cz (unknown [10.163.44.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E79352C4E2;
        Thu, 19 Oct 2023 09:51:42 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id EDAE22016B; Thu, 19 Oct 2023 11:51:40 +0200 (CEST)
Date:   Thu, 19 Oct 2023 11:51:40 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] ethtool: fix clearing of WoL flags
Message-ID: <20231019095140.l6fffnszraeb6iiw@lion.mk-sys.cz>
References: <20231019070904.521718-1-o.rempel@pengutronix.de>
 <20231019090510.bbcmh7stzqqgchdd@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tpdxxlqwiqidmzdl"
Content-Disposition: inline
In-Reply-To: <20231019090510.bbcmh7stzqqgchdd@lion.mk-sys.cz>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of mkubecek@suse.cz) smtp.mailfrom=mkubecek@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-3.11 / 50.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,text/plain];
         DMARC_NA(0.20)[suse.cz];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         R_SPF_SOFTFAIL(0.60)[~all];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         SIGNED_PGP(-2.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         RCVD_COUNT_TWO(0.00)[2];
         FREEMAIL_CC(0.00)[bootlin.com,davemloft.net,lunn.ch,google.com,gmail.com,kernel.org,redhat.com,pengutronix.de,vger.kernel.org];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -3.11
X-Rspamd-Queue-Id: 5394E1F88B
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tpdxxlqwiqidmzdl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 11:05:10AM +0200, Michal Kubecek wrote:
> On Thu, Oct 19, 2023 at 09:09:04AM +0200, Oleksij Rempel wrote:
> > With current kernel it is possible to set flags, but not possible to re=
move
> > existing WoL flags. For example:
> > ~$ ethtool lan2
> > ...
> >         Supports Wake-on: pg
> >         Wake-on: d
> > ...
> > ~$ ethtool -s lan2 wol gp
> > ~$ ethtool lan2
> > ...
> >         Wake-on: pg
> > ...
> > ~$ ethtool -s lan2 wol d
> > ~$ ethtool lan2
> > ...
> >         Wake-on: pg
> > ...
> >=20
>=20
> How recent was the kernel where you encountered the issue? I suspect the
> issue might be related to recent 108a36d07c01 ("ethtool: Fix mod state
> of verbose no_mask bitset"), I'll look into it closer.

The issue was indeed introduced by commit 108a36d07c01 ("ethtool: Fix
mod state of verbose no_mask bitset"). The problem is that a "no mask"
verbose bitset only contains bit attributes for bits to be set. This
worked correctly before this commit because we were always updating
a zero bitmap (since commit 6699170376ab ("ethtool: fix application of
verbose no_mask bitset"), that is) so that the rest was left zero
naturally. But now the 1->0 change (old_val is true, bit not present in
netlink nest) no longer works.

To fix the issue while keeping more precise modification tracking
introduced by commit 108a36d07c01 ("ethtool: Fix mod state of verbose
no_mask bitset"), we would have to either iterate through all possible
bits in "no mask" case or update a temporary zero bitmap and then set
mod by comparing it to the original (and rewrite the target if they
differ). This is exactly what I was trying to avoid from the start but
it wouldn't be more complicated than current code.

As we are rather late in the 6.6 cycle (rc6 out), the safest solution
seems to be reverting commit 108a36d07c01 ("ethtool: Fix mod state of
verbose no_mask bitset") in net tree as sending a notification even on
a request which turns out to be no-op is not a serious problem (after
all, this is what happens for ioctl requests most of the time and IIRC
there are more cases where it happens for netlink requests). Then we can
fix the change detection properly in net-next in the way proposed in
previous paragraph (I would prefer not risking more intrusive changes at
this stage).

Michal

--tpdxxlqwiqidmzdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmUw/CgACgkQ538sG/LR
dpU2pQgAiW+HDx0vS9hgoro2w7gEAC0jlJKSLt6D3D1kHT2A737InqxKzryMB8NM
iyp+2XGVWRQPhMoZVSBZ/vgFQwCxsu1HOPNP5Xh8nIMWA4e2P3U5poqK1nVkg53N
P03gigkrx/bBxijYCwNAWlAiCLHRI3jUihTlXXjku3BogLuWnbMz75ueNwct64Zy
0r6lt28aqYyFAJhkZJG+GBUIxfte0MQt3TqQiarUd5lJjrvhkhyNJMByEtgjnElz
g2sZ+EtxCKTOS7rNCoOkl+2uMKDXCqebfPb+ZMwCXkVJNKn5G6zNPIo88wCFfUgk
CLcFyw33UUda+wg8flEoSO47edwWFQ==
=cRHe
-----END PGP SIGNATURE-----

--tpdxxlqwiqidmzdl--
