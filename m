Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFDD7F1553
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjKTOJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjKTOJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:09:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74482F3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:09:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A142C433C9;
        Mon, 20 Nov 2023 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700489371;
        bh=hoIhA8+0yRB+8xKNhUqRCTi4Cj0Q9PRSELx11+Gdf9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r45lYZBBqyt2qIC3VTWvXeFOLpp7CslcoudAqZHo3c3ToiD3advJLwF+LCeQTSM4V
         ian9GJtKKF/6WQNbnSlPU6HPsyneu0ZkHaso51fhQyb5HfooUycrugoOjqW3AvaFvH
         JbSyG7Q6aiUwYwnG9OQSQDRK4H2FDhgaP+yGZfOW9mvm9hc6UiF2csU75mRMpuJsB/
         u1dCYBO9SVZu1FuLumVUvtcx32ALSNqXSMdsp9G0IufrXorcmRf7kCkpyLAOe7IGza
         CZVtn9hq2ML7D6TA2ZoEM+IA98iwR0d/sA7ltvFzg0zveh92v1bjHGQjv6XIUZ6hjb
         x08JifS0gmx4Q==
Date:   Mon, 20 Nov 2023 14:09:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anish Moorthy <amoorthy@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Matlack <dmatlack@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 34/34] KVM: selftests: Add a memory region subtest to
 validate invalid flags
Message-ID: <13677ced-e464-4cdb-82ae-4236536e169c@sirena.org.uk>
References: <20231105163040.14904-1-pbonzini@redhat.com>
 <20231105163040.14904-35-pbonzini@redhat.com>
 <CAF7b7mpmuYLTY6OQfRRoOryfO-2e1ZumQ6SCQDHHPD5XFyhFTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="61dY8WQ8Ox8wOW0h"
Content-Disposition: inline
In-Reply-To: <CAF7b7mpmuYLTY6OQfRRoOryfO-2e1ZumQ6SCQDHHPD5XFyhFTQ@mail.gmail.com>
X-Cookie: Happiness is twin floppies.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--61dY8WQ8Ox8wOW0h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 05:08:01PM -0800, Anish Moorthy wrote:
> Applying [1] and [2] reveals that this also breaks non-x86 builds- the
> MEM_REGION_GPA/SLOT definitions are guarded behind an #ifdef
> __x86_64__, while the usages introduced here aren't.
>=20
> Should
>=20
> On Sun, Nov 5, 2023 at 8:35=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> >
> > +       test_invalid_memory_region_flags();
>=20
> be #ifdef'd, perhaps? I'm not quite sure what the intent is.

This has been broken in -next for a week now, do we have any progress
on a fix or should we just revert the patch?

--61dY8WQ8Ox8wOW0h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbaI0ACgkQJNaLcl1U
h9Aj2Qf9EbUUwOLmAwUa3Jl4QMfiLrKntsPjxIsD9MYRWpqfdGr2gZb7wNXozUgD
A1SOrSPxLG5lvE3dOdXD1O/mzrxVwLcfAssVQ6KjXu13pJtZDIQHAUpYQBJL28QR
KIeV8OVDMKeFryWnyt+y92xYK+7d4TocCuAq2Ph3jQj/OIXp4bI5quuTV58jmIG4
1QuJFi73b7JIL4Ksmg32pp3aWaoP7BqMqnDxx92GwdngF0Jrg1NBhgHoMkh/J28y
zT6Vui1HZF2pSrrxexqXFLJKhveYmLyg3kaoEyvYeRwj/WjZSB3U/9LJrhBDctTJ
2Y23Hu9kFWuPdJxy0l8BV7AiIxSr4Q==
=GWvB
-----END PGP SIGNATURE-----

--61dY8WQ8Ox8wOW0h--
