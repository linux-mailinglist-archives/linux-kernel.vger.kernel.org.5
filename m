Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DED0782142
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjHUBzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjHUBzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:55:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BF59C;
        Sun, 20 Aug 2023 18:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692582912;
        bh=HJHpAU4TOqgsXc8aAw5uUHKj7ztHJJkFw+FKTmxvlPc=;
        h=Date:From:To:Cc:Subject:From;
        b=dlsSRtZQ7IfJu9WdIvTaUWwt/qHj7Zm+oSBi/gQlw36VyhUyP14+Qw3OYSRp5EWx0
         TY4kG9c/4uRC4uIAL8FDNoXDWzwlwiozFEQ8R1ssZQxCg5wERgci6eNUEMRyK7DhPD
         IJQjYPvcK9937jvDETgHj18ZSM5YESy2oJPB7H+UzPJy94W3zvI2mAnWoIME79dFqu
         7t33Y/DmyOakns2CYLkCbWuk+TTtphxfQVCYud95YfNW5Yi1gPLOt2NYQ30rzNpEDh
         Vt2CV2dPaqztKlsQSs+ZVx/2NmjQY9+dSWlR+ly9B6YGF/bO2JGKUdze5dhjI66vBl
         hxtFlRdEFWxDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RTbCM5MzXz4wZn;
        Mon, 21 Aug 2023 11:55:11 +1000 (AEST)
Date:   Mon, 21 Aug 2023 11:55:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the nand tree with the mtd tree
Message-ID: <20230821115507.229d85fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ibY=EqU_E1ZfvQJV5L0WHbk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ibY=EqU_E1ZfvQJV5L0WHbk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nand tree got a conflict in:

  drivers/mtd/nand/raw/qcom_nandc.c

between commit:

  c2fc6b694790 ("mtd: Explicitly include correct DT includes")

from the mtd tree and commit:

  93ca966b4a20 ("mtd: rawnand: qcom: Sort includes alphabetically")

from the nand tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/mtd/nand/raw/qcom_nandc.c
index df245353b12b,997710779fe1..000000000000
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@@ -2,19 -2,19 +2,19 @@@
  /*
   * Copyright (c) 2016, The Linux Foundation. All rights reserved.
   */
+ #include <linux/bitops.h>
  #include <linux/clk.h>
+ #include <linux/delay.h>
+ #include <linux/dmaengine.h>
+ #include <linux/dma-mapping.h>
+ #include <linux/dma/qcom_adm.h>
+ #include <linux/dma/qcom_bam_dma.h>
+ #include <linux/module.h>
+ #include <linux/mtd/partitions.h>
+ #include <linux/mtd/rawnand.h>
+ #include <linux/of.h>
 -#include <linux/of_device.h>
 +#include <linux/platform_device.h>
  #include <linux/slab.h>
- #include <linux/bitops.h>
- #include <linux/dma/qcom_adm.h>
- #include <linux/dma-mapping.h>
- #include <linux/dmaengine.h>
- #include <linux/module.h>
- #include <linux/mtd/rawnand.h>
- #include <linux/mtd/partitions.h>
- #include <linux/of.h>
- #include <linux/delay.h>
- #include <linux/dma/qcom_bam_dma.h>
 =20
  /* NANDc reg offsets */
  #define	NAND_FLASH_CMD			0x00

--Sig_/ibY=EqU_E1ZfvQJV5L0WHbk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTiw/wACgkQAVBC80lX
0GxnlAf/WDSQ7MDNnI/anwLFhkQBn/Q4f/ocKRlOSRQEPH6uaT53CNfTwj+k6jN+
aGVdLO2ibcMt8FAYPTXXzNbFuTXh3HZKrNti3fl6jftfYfK8Q+Fr6ZHyY6CWnule
IDCv76HeepwlML7n2redwLzd9B5RnCSZtNwKZdpKiX1jIrS8fasyKuEwBYH8V3aA
P4CmF5P6z6vP7EfhrURP8lXwrFX0jpsmLHbzjbH4GvjenDF2xozE39ch59G4O1FZ
K4ZFtRZozrKZhr/5QKzDlQtAwUaqSGdoQ4qT9VUVL6gjojuvlToJwwggTc8d4XnZ
b9hruqMFoxYsypaqnYLCyzJBHBpsVQ==
=D4eU
-----END PGP SIGNATURE-----

--Sig_/ibY=EqU_E1ZfvQJV5L0WHbk--
