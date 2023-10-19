Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15217CFFE2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345139AbjJSQqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjJSQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:45:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDC711B;
        Thu, 19 Oct 2023 09:45:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5A9611FD76;
        Thu, 19 Oct 2023 16:45:55 +0000 (UTC)
Received: from lion.mk-sys.cz (unknown [10.163.44.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EB5502C5BB;
        Thu, 19 Oct 2023 16:45:54 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 0C5632016B; Thu, 19 Oct 2023 18:45:53 +0200 (CEST)
Date:   Thu, 19 Oct 2023 18:45:53 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] ethtool: fix clearing of WoL flags
Message-ID: <20231019164553.zcc6d2vbxzw4m4c2@lion.mk-sys.cz>
References: <20231019070904.521718-1-o.rempel@pengutronix.de>
 <20231019090510.bbcmh7stzqqgchdd@lion.mk-sys.cz>
 <20231019095140.l6fffnszraeb6iiw@lion.mk-sys.cz>
 <20231019122114.5b4a13a9@kmaincent-XPS-13-7390>
 <20231019105048.l64jp2nd46fxjewt@lion.mk-sys.cz>
 <20231019152743.09b28ef4@kmaincent-XPS-13-7390>
 <c0f98227-459f-43c6-9c0e-db0a7ea07c9e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="esat6ae76hdj6xm2"
Content-Disposition: inline
In-Reply-To: <c0f98227-459f-43c6-9c0e-db0a7ea07c9e@gmail.com>
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
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+,1:+,2:~];
         RCVD_COUNT_TWO(0.00)[2];
         FREEMAIL_CC(0.00)[bootlin.com,pengutronix.de,davemloft.net,lunn.ch,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -3.11
X-Rspamd-Queue-Id: 5A9611FD76
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--esat6ae76hdj6xm2
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 09:20:31AM -0700, Florian Fainelli wrote:
> On 10/19/23 06:27, K=F6ry Maincent wrote:
> > On Thu, 19 Oct 2023 12:50:48 +0200
> > Michal Kubecek <mkubecek@suse.cz> wrote:
> >=20
> > > On Thu, Oct 19, 2023 at 12:21:14PM +0200, K=F6ry Maincent wrote:
> > > > On Thu, 19 Oct 2023 11:51:40 +0200 > Michal Kubecek <mkubecek@suse.=
cz>
> > > > wrote:
> > > > >=20
> > > > > The issue was indeed introduced by commit 108a36d07c01 ("ethtool:=
 Fix
> > > > > mod state of verbose no_mask bitset"). The problem is that a "no =
mask"
> > > > > verbose bitset only contains bit attributes for bits to be set. T=
his
> > > > > worked correctly before this commit because we were always updati=
ng
> > > > > a zero bitmap (since commit 6699170376ab ("ethtool: fix applicati=
on of
> > > > > verbose no_mask bitset"), that is) so that the rest was left zero
> > > > > naturally. But now the 1->0 change (old_val is true, bit not pres=
ent in
> > > > > netlink nest) no longer works.
> > > >=20
> > > > Doh I had not seen this issue! Thanks you for reporting it.
> > > > I will send the revert then and will update the fix for next merge-=
window.
> > >=20
> > > Something like the diff below (against current mainline) might do the
> > > trick but it's just an idea, not even build tested.
> >=20
> > Seems a good idea without adding too much complexity to the code.
> > Will try that and send it in next merge window.
>=20
> Not sure what you mean by next merge window, we need a fix for right now,=
 or
> we need to revert 6699170376ab ("ethtool: fix application of verbose no_m=
ask
> bitset").

Not that one, that's an old commit that was correct from functional
point of view (the only problem was that it sometimes triggered
a notification even when the value was not changed but that also happens
in other places).

A revert of commit 108a36d07c01 ("ethtool: Fix mod state of verbose
no_mask bitset") is already in net tree as commit 524515020f25 ("Revert
"ethtool: Fix mod state of verbose no_mask bitset"").

Michal

--esat6ae76hdj6xm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmUxXT0ACgkQ538sG/LR
dpXp0gf/bEEu3zB+iSkVxzX/WV0Xxd6xXvSYXcnqG9J80GINiRxy4sBkPLrRt/Ui
VGEBESwLL8hgo60xyejU0GLthr2HQtgXiDxzh+cEisaJVx5wOu4CWkZgw/M/amvN
UkEDGLn+NTYNUFuvlmE1MNX+OKK1gd/WeqW1ZskPW8ZwsmxMyGab1r9Q6ViienSZ
1tPwEGnm+pMu1LLDw4x21U18Bd05sHqz7LyUc6CwD3JVnYYjZKAyLwhy7MvgTYfC
Dfl18XL+OwtfqoQYd2ChqLxsCOGjwJb9WlCBzOeTo8dgxGv9FRb3zIaJ8UVomMOH
E77QtxWJtK0FzrJfgmS0XCgiT36mLA==
=WWBP
-----END PGP SIGNATURE-----

--esat6ae76hdj6xm2--
