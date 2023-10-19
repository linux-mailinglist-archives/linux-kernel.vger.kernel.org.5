Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A689D7CF5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345199AbjJSKyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjJSKyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:54:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F40138;
        Thu, 19 Oct 2023 03:54:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B00F121A98;
        Thu, 19 Oct 2023 10:54:39 +0000 (UTC)
Received: from lion.mk-sys.cz (unknown [10.163.44.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 72A172C425;
        Thu, 19 Oct 2023 10:54:39 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 7E8172016B; Thu, 19 Oct 2023 12:54:37 +0200 (CEST)
Date:   Thu, 19 Oct 2023 12:54:37 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] ethtool: fix clearing of WoL flags
Message-ID: <20231019105437.xvmvfhluowvubp2y@lion.mk-sys.cz>
References: <20231019070904.521718-1-o.rempel@pengutronix.de>
 <20231019090510.bbcmh7stzqqgchdd@lion.mk-sys.cz>
 <20231019095140.l6fffnszraeb6iiw@lion.mk-sys.cz>
 <20231019122114.5b4a13a9@kmaincent-XPS-13-7390>
 <20231019105048.l64jp2nd46fxjewt@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qd7xmcbudbjiafui"
Content-Disposition: inline
In-Reply-To: <20231019105048.l64jp2nd46fxjewt@lion.mk-sys.cz>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of mkubecek@suse.cz) smtp.mailfrom=mkubecek@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-1.09 / 50.00];
         ARC_NA(0.00)[];
         BAYES_HAM(-0.98)[86.89%];
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
         FREEMAIL_CC(0.00)[pengutronix.de,davemloft.net,lunn.ch,google.com,gmail.com,kernel.org,redhat.com,vger.kernel.org];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.09
X-Rspamd-Queue-Id: B00F121A98
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qd7xmcbudbjiafui
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 12:50:48PM +0200, Michal Kubecek wrote:
[...]
> @@ -490,6 +509,8 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned i=
nt nbits,
>  			*mod =3D true;
>  		}
>  	}
> +	if (saved_bitmap)
> +		*mod =3D ethnl_bitmap32_cmp(saved_bitmap, bitmap, nbits);
> =20
>  	ret =3D 0;
>  out:

Oops, this should be

		*mod =3D !ethnl_bitmap32_equal(saved_bitmap, bitmap, nbits);

Michal

--qd7xmcbudbjiafui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmUxCukACgkQ538sG/LR
dpX7Nwf/ZPBVh1GNjiLre1IZ0kaSby9BnLxSYnawYwanefVZKD7AjS64G/BQHCy/
hyJfBJ+/Yxvnr4YLUBXvbBA4tBV3aQhk6lkOnkQ+q/QNsv4NATjy/WB25p2vMCVb
4tAZHja+NYSWwvrec4YQRn3z/3VLb3mETAmpRIF79WGDKsSV/sv5HT7CSRHY2FCt
NRqfdZ8uKNC/GUp5FrRMyuwwjUSA5Izbj35HMUoZKezQZu/fo4+Xil17hbO8QqeF
rWKQsZX4SYf9nmI8zdRR8PhzkK3tXvrdMChU2a+jtPUn9/wFfbiiSyEWKYDO+dHx
nmxGwfkvDmp9bypTFlNxRWIA8EJLlQ==
=kP6F
-----END PGP SIGNATURE-----

--qd7xmcbudbjiafui--
