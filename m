Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629CF78E417
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbjHaBAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjHaBAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:00:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AD3C5;
        Wed, 30 Aug 2023 18:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693443616;
        bh=Pjl27ZqZPLywN4nLOqdyLSv79osnXDCxizHApnxkFww=;
        h=Date:From:To:Cc:Subject:From;
        b=jxoSIgWLaroN3JZzWPJxjhIsUD2zvYzSXXyU1cFkUEH66TBhoblIL5inWB98Pzb+M
         nq1xfsZ/d46twqJR48KESZ4ErIY0NO8Hgq1wkn2blqaYPYx67+ebb8sdkfqejfAzOu
         ichL6YBFokGbUtdHrmS4in0KIyFKZftJBihlnuBpwKCUp4ztJGgV+5UIfE3vgOUrTg
         8PEIS3Z2z3jqTZU1/XsjF9WraablNRRF6N40V9vWNWxTtQizsYAk8aQIr/nGCO0Qx1
         B3GGHtbA3nWQR0xdqvL4ifJGFfmVe5VTBItV06s9lOXTLVq6tzfqZT241GWMc1y1oQ
         NCmWERQzItQQQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RbjWN3LSLz4wbP;
        Thu, 31 Aug 2023 11:00:16 +1000 (AEST)
Date:   Thu, 31 Aug 2023 11:00:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mailbox tree
Message-ID: <20230831110014.64ce5510@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2NaCcMwr0TeCE1ahhNf/jQb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2NaCcMwr0TeCE1ahhNf/jQb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mailbox tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "pm_system_irq_wakeup" [drivers/mailbox/imx-mailbox.ko] und=
efined!

Caused by commit

  fd9d6d7ba81c ("mailbox: imx: Add support for identifying SCU wakeup sourc=
e from sysfs")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/2NaCcMwr0TeCE1ahhNf/jQb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTv5h4ACgkQAVBC80lX
0GxGeQf+INzTRkBxOpCGBrJ+nhfnR/OzKvbMZDqC+kGqjd2xzaRPuBF9wiYg5k3m
xRBRBbaHRsB88feFHmPMxM0kRcpmwVV2xQSy+NxdWpOeLQC38ilqpsus3tclY3Mv
JtiZFmDlY79gORF4vzs6YZ424OxJpT3sTLCX9Rg71AJ/l6JcS+B5sAhjVMaxueOl
KZQinel5yscz/xLI7BeoW/U8t17TxdXaCj2LOzTMAd9U3mqecVy9RDCTolASGdNO
ihJ4JQmMRUE9xS9QU/XFuShXnNMasQGlA/dJZKYyZueHnAUviKLuvAQs106qiEFh
CZGVvpmdAdBbo0r89CHag+XejO+L5A==
=EJJK
-----END PGP SIGNATURE-----

--Sig_/2NaCcMwr0TeCE1ahhNf/jQb--
