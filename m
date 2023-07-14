Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2043E7543C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbjGNUbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGNUbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:31:33 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49FE21995
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:31:30 -0700 (PDT)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id AE682280007;
        Fri, 14 Jul 2023 22:31:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1689366689;
        bh=UstBmk5rKvMol5Pxu8bwFwKMgx6VP0tpjTBggG4Y89w=;
        h=Date:From:To:Cc:Subject:From;
        b=Pvnm1X8wstiDPxLbj8KBnqc8DL3eT36JsRUVOT9O1R4uO7AkXQ9Tx1+1+M/ECmOXf
         ppts2TUTp0ZX/VaF994sAphzgogX8jnBiZ5MfciNQfkYucVCbs6zvm3Zh1y3F0bZgs
         J0RqO4uEo5pQWU4wUWQJWTZnr0fxGooerRl1yATIJls7PC7EW16vQFyv0dSoND6/WJ
         0ILO60d0RvMi1Ck67cWe4MTWbJrUynfV0NVjQLqwerrqvmKK616AQWx9TXfH/Rc6DX
         NmiY/2EZmb2mdgoRW2Dh8hcZfsc1dQbw93m3Da+mOYWP6gi/zbGz8qKIkjzekbOe9e
         8UStkJbpkhT8w==
Date:   Fri, 14 Jul 2023 22:31:28 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.5-rc1
Message-ID: <ZLGwoGoJNAG6Db4v@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KrWtInSE6k/GcJsT"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KrWtInSE6k/GcJsT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-fixes-v6.5-rc1

for you to fetch changes up to c20ecf7bb6153149b81a9277eda23398957656f2:

  iommu/sva: Fix signedness bug in iommu_sva_alloc_pasid() (2023-07-14 14:53:19 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.5-rc1

Including:

	- Fix a regression causing a crash on sysfs access of iommu-group
	  specific files

	- Fix signedness bug in SVA code

----------------------------------------------------------------
Dan Carpenter (1):
      iommu/sva: Fix signedness bug in iommu_sva_alloc_pasid()

Jason Gunthorpe (1):
      iommu: Fix crash during syfs iommu_groups/N/type

 drivers/iommu/iommu-sva.c |  3 ++-
 drivers/iommu/iommu.c     | 27 ++++++++++++++-------------
 2 files changed, 16 insertions(+), 14 deletions(-)

Please pull.

Thanks,

	Joerg

--KrWtInSE6k/GcJsT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmSxsKAACgkQK/BELZcB
GuO3MQ//fIVGc+krTT5CVG13NcVKRZ2btwJn/EZTCga5WE7C2UPFonNaiw2IyH59
9WjSAGRgIqtLNFSFoucyuf8G3VblVukl73H3KXWKwwong4IeHgAWawubBYIakG2U
I35edS/OdMIMW/jBolSIBKG0Sn6pr41UScPwuWJWSkN7FXHd/pGK4Pfurm2/lbN1
koWK1qJAqcq+JLKn/ZBoQlP4wVqvGVx7QrA2p5wSZZ3Mp8JBGUq966a3FPWIm/6h
D29M6EdjdbOz24lRHg5t+d2rpC7qk2bETBE121bvuIt6IieBij5kbHuc0ajuIsAA
K6NsYdPznFw6+Xmo05XkbGuvNMsF1U6Rcsfb+9wpBapPQXdrMSRt2hfGPaxF9Ybw
MqfZJV4q0Qk5oQzn4SoSCJpHilO26YMx1oqi/xyco+ASWa9O9REb2g0rb1GUgQsy
ahZ8jQ3xm8MaruHZTDuIrTZYxFMPv6Up2QGIEyzuoqvwZPqw5ITq0/WZ7ZzMvM/1
9IUfRCgUvQ9cbA+js+KRn5SkI+ZD25fuBSawVqi3bhA/xieOmSgKaqeuvpu14qZZ
L4u9DfRRNro1xHCivhukFmn9hJz19m6wGf+rawlKEOgreFcC1qWaH1J2kE2GBuGZ
uGo9G+zVJLLcFcbfeY1Hs8QpdibQ9uQ6J7qJJNM9dlp29s3/YjE=
=PKrL
-----END PGP SIGNATURE-----

--KrWtInSE6k/GcJsT--
