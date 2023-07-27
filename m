Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F51764538
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjG0FAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjG0FAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:00:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C01271B;
        Wed, 26 Jul 2023 22:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690434021;
        bh=lOsVq2pOt+is4yt8M1eEq5+blpoBx4LI7bEABT/Rw+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fYgjQGHF1hRAt3QWH6E0SGKpDRxjycr29gkaOGdjlrqMqJ3SNy8N5l6BBSRoKEBVy
         YwNmAyX7ozy6QfBvPeoxQng3+iQdS+SZVyCThBe8oKH8dlsfM6dz6V7Lv7KTQr9oSP
         u+Dpy1g2+XYSe5FpTHiDlQ4Q08KNHlYBVvHMUfPjQ47JYIZnuuCh5c1dkwRI5ajUqD
         Ac7qb0VcV1frYvZ9lMRIRQELMUXoYPs9D4C1kKgncZmiX3zpz/NB2L1uSSOm6N9dk4
         tctwr9J9TT9HzQ6WI5HW502p4KxIFYbJEeGBM85xBZeOhANsDs1wL1A2geCvboArTX
         MY60nefu4mr7g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBJVY4R9vz4wxK;
        Thu, 27 Jul 2023 15:00:21 +1000 (AEST)
Date:   Thu, 27 Jul 2023 15:00:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the mm tree
Message-ID: <20230727150020.6bb5dc51@canb.auug.org.au>
In-Reply-To: <87h6pqvu5g.fsf@linux.ibm.com>
References: <20230727142844.5e00c84d@canb.auug.org.au>
        <87h6pqvu5g.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_oa5bKX6_Lrn4sawQzMTG_K";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_oa5bKX6_Lrn4sawQzMTG_K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Aneesh,

On Thu, 27 Jul 2023 10:16:19 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.i=
bm.com> wrote:
>
> I will send this as a separate patch to linuxppc-dev ? Even though the
> warning started with this series because it is using functions in
> meminit from remove_pte_table, marking remove_pte_table correctly is
> applicable outside series that caused this warning ?

Please just keep it with the patch that exposed this situation i.e. in
Andrew's tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/_oa5bKX6_Lrn4sawQzMTG_K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTB+eQACgkQAVBC80lX
0GyV7Af/QgLHQvVtGxPamAnNUTifpskpdkILJbZwPPRjoTG7/thR/+dTDqeUtDeO
cLEtWAb31ZAVGuxGxPTVotOM/T0XIFlCUmWeyxOymY8mbfnjj/d+G+VRXm6p5paf
vE2x+dG9mOfO9JJg/XtiqR3Vyr2Z9iD1OgsSpQf/yMo4yD00T/R1jmxZntf/R40P
l7Qf+k4VXznAb7e2EuAS+VuejRBVjCYFlKpQ6vtaNgviJosMFpnrm82YGIe9Hqn8
/dt9SYp7c6PYmvOdR0jQXiwiy2wTRgqwZLV0PkqFbPMHbHnFJoeaX5TcZf8G2efJ
AuvMFBSsTyou27+Uq9BpPC3CObQthg==
=CV3O
-----END PGP SIGNATURE-----

--Sig_/_oa5bKX6_Lrn4sawQzMTG_K--
