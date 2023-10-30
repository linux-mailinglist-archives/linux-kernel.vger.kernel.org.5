Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03F47DC19C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjJ3VKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3VKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:10:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF921F7;
        Mon, 30 Oct 2023 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698700237;
        bh=is4JBeiI18bzBYV22PqwabroerzhWqb6I32Kgi4a67E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cIzO9JXwydt1F1RZBE3wLfL7pGnEkflVAMDkA6TsjaX32fZHa+Pdl1Hjem/82h2i1
         FME3yw76GwYhTvV2eUrUW3t1v/CaO98iioYnBaL4HRg6+8Y5XLzE4sYhvR23ca6PN4
         LWFJJiNAw3PxiZcwFyFPvR3L2rps+Ie2uA38VC32D0pFY8VqGV9lboo+XeIV9mnSRu
         VxBbw13V4MciCIFvBJp8L8N0dPtK/zJfXHce+fXkMhUZXc/d+YRwZ1waKfvwGwe49n
         hYgWheV8sqaC8BQ3mZn3fBzveEbt3ImtMS68D+AsWnk6SXrB6mXXXItdTGc+gmefI3
         L7FDuAilD4Q2Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SK5XF1MSnz4wdD;
        Tue, 31 Oct 2023 08:10:37 +1100 (AEDT)
Date:   Tue, 31 Oct 2023 08:10:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Ackerley Tng <ackerleytng@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kvm-x86 tree
Message-ID: <20231031081035.7f7d860b@canb.auug.org.au>
In-Reply-To: <ZUAaiA0-FNRNy7wJ@google.com>
References: <20231030134806.24510492@canb.auug.org.au>
        <20231030-ignorant-liebschaft-6d603ab43494@brauner>
        <3ed75fa4-6b49-4fd2-a907-8619ca19a8b8@redhat.com>
        <20231031073705.512dab4b@canb.auug.org.au>
        <ZUAaiA0-FNRNy7wJ@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.ipiPiFX+WGg=/kWFhoCo2W";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.ipiPiFX+WGg=/kWFhoCo2W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Mon, 30 Oct 2023 14:05:12 -0700 Sean Christopherson <seanjc@google.com> =
wrote:
>
> That's my bad, I wanted to get the guest_memfd code exposure asap and jum=
ped the
> gun.  I'll yank the branch out kvm-x86/next.

Thanks.

> I assume -rc1 is when the floodgates "officially" open again?

Yes, indeed.

--=20
Cheers,
Stephen Rothwell

--Sig_/.ipiPiFX+WGg=/kWFhoCo2W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVAG8sACgkQAVBC80lX
0GyPBQf+OfPml3Xi9xrWB/wr4CEt6GQGPDOLIhY5HkKwRTaDM+mN7FDKLkkvO9Qc
PRsB0nMnsbofE8fu8EDrjvPWwaerXsMSYcbEieU3mvD61QhjXpnO9AGI+uV0ayVa
5slatc1y64wnMd9iHWbBqEfdKsBERPAjyGW5DUQun0RM8McA9JbikOPAhg/sncQX
CCYoNiQVHw3tmuJj7gwxl1pPxsyowmqr0TYBSc+NTfY9J6zYLg8cCS9omUc6x1UZ
8H7R738EXk/6WZ43tX4kA+eeO+nTi+UZAvPbi8PLGfqVIs/QQdElHbjxRJdx/kWJ
ExRJX1xVKeQD4s4efNnlezPhuivnLw==
=YCGZ
-----END PGP SIGNATURE-----

--Sig_/.ipiPiFX+WGg=/kWFhoCo2W--
