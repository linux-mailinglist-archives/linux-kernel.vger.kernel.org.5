Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBBB7C7B49
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 03:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjJMBlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 21:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJMBlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 21:41:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F442CC;
        Thu, 12 Oct 2023 18:41:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1414AC433C8;
        Fri, 13 Oct 2023 01:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697161303;
        bh=0eP9bM63G4AlO+Lb818oeTVI6ScZaR0KFSsQLoTquiQ=;
        h=Date:From:To:Cc:Subject:From;
        b=G7IOrHmHZPkCkJODLIlA+lqGfmh9v1+G4YS30Iu1XNoTgBImM8MSZffDov1j1HFxF
         en/1DnZqWKwhnl+hZzwLnOtvsg/TwdfvDKumXWk1DQ7Ltq+4Ipdk6DJAMED20MpYMw
         TgLDVmwHOmq7W3GYwjUuIKJMH3Qp8Hnlhj1CuHWLK3AG3mj3fjTjLGnplv06vXWMw5
         m5YZ7KFev1eEJ/En1eotfwt8PEUxvSprbw/gSUR2Z2a0B6szO1V6gcPSlU6VKRlVT0
         LdMuzHP+titDT61rq9mCT4rutLHBNct+sDNDxvRXapcajEfQ3WAs0TcmJUxhxf4Z4q
         2j5n7P9Nqi+hg==
Received: by mercury (Postfix, from userid 1000)
        id B2CEB1062B50; Fri, 13 Oct 2023 03:41:39 +0200 (CEST)
Date:   Fri, 13 Oct 2023 03:41:39 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.6-rc2
Message-ID: <20231013014139.yhfw45mur7lbyxfm@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4iewwebo3qbpta2l"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4iewwebo3qbpta2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 488ef44c068e79752dba8eda0b75f524f111a695:

  power: supply: rk817: Fix node refcount leak (2023-09-20 19:37:15 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.6-rc2

for you to fetch changes up to 8894b432548851f705f72ff135d3dcbd442a18d1:

  power: supply: qcom_battmgr: fix enable request endianness (2023-09-30 21:00:20 +0200)

----------------------------------------------------------------
Power Supply Fixes for 6.6 cycle

 * qcom_battmgr: endianness fixes

----------------------------------------------------------------
Johan Hovold (1):
      power: supply: qcom_battmgr: fix enable request endianness

Sebastian Reichel (1):
      power: supply: qcom_battmgr: fix battery_id type

 drivers/power/supply/qcom_battmgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--4iewwebo3qbpta2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUooFMACgkQ2O7X88g7
+ppeSQ//ceC/JG9+EbKMLafb210MiZ1ufeoSr7exDYBkztfygRgCO/zrUHp+hnzf
TrdzFUD2u77ZYmoWgMUVx8fh4NBuEsjJr2ZcKDyO2JRvBqyc8vdLO+5MDRgKh4EV
V0PKzzpa3yZ66KHuNcp4mbqk8ZLAFKwJtW5h/d7sR7x1pslBsnCaJA0rqu+MLWO3
4SnQ58l9Gt62XxjlHUqHjYUpXBEugvyZeNqKStNPC8lRNWB3jNW2loVFKLP+J0ys
O9DyLEPwsW+3+vK3p3+wsik2ylDI96NDD39swojz+1WKdILK0/RclDlJTi2JsGn/
rOy2zIOqkdLx64hEZRQgjzvRqLLh4eGyU+g+ZHsOmQZFG/bQut4EoDe4oWRhUvrC
m0FtCY5wRqaJ+iuccy+TG6kb6g6aTw6UfsRSau0Qsk2qIFmoXEB1m0mFhbFZlK2i
moTL6SLQJYWXFZy4lit0/yN1Kwkb92Cu6fMPk4hnva80n68/D0PPbrPqrsLTKKUo
nCntAZGs7WjdD6wKtxSKNqwL7WWXQrpm+o4m1mBP1nN/NTnZ+lHo6GYRLkWdssmt
uyM3E/M+sSjna2DO1Y43jMJCyBir6l9LvdaSksVxS3iK8sE14SFJOVgWVrLC/vmJ
U6Cjx+qJ6S7Rx25SXHiXPcUHQqtLNkQEwROL19LtpB9pvYvJ85A=
=bIix
-----END PGP SIGNATURE-----

--4iewwebo3qbpta2l--
