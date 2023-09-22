Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FE37AAE5F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjIVJjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjIVJi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:38:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E7197
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:38:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D5BC433C7;
        Fri, 22 Sep 2023 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695375533;
        bh=6x7OVLHHQ75Pnr2xNF7AcbI629MqB8424pBLt1b4zJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AE2G41lCD8oy6p9WUm4ci2i1unJemR9tqF7c5SAXFqBtaQ25hWiz7CEG+VQ7BxK6a
         FxC26RZC9Hvhz02QHpQDjipk2/5ZuU94M17DYRxnjPan7auMzmiyT0Sk0DAlB4Wyb5
         vMjvxrH8T9vvNDyuq8ommbMoxVfdI4R55Z9tlWLhARthdUxT0Y/tn2lvqOU5ARWq9k
         91lN9S39OLfMsoMOFwMuB0fw7Fe+NRQrTLpFTK4yKpJKNJzu+eZTvbGSP5xnMZ3L6T
         EJ4WNdInIf5L15hPsonKHqR6nTPGtGeBOTN7SA0Za6NAblIfH72MCcTxy30Ce5BIyL
         C6iD0ME3hoAYA==
Date:   Fri, 22 Sep 2023 10:38:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        greentime.hu@sifive.com, vincent.chen@sifive.com, tjytimi@163.com,
        alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        wchen <waylingii@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        David Hildenbrand <david@redhat.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] RISC-V: Detect and Enable Svadu Extension Support
Message-ID: <20230922-italics-pursuit-424b1ad71ef1@spud>
References: <20230922085701.3164-1-yongxuan.wang@sifive.com>
 <20230922085701.3164-2-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="utwYTRBgGxs2RSTx"
Content-Disposition: inline
In-Reply-To: <20230922085701.3164-2-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--utwYTRBgGxs2RSTx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 08:56:47AM +0000, Yong-Xuan Wang wrote:
> We detect Svadu extension support from DTB and add arch_has_hw_pte_young()
> to enable optimization in MGLRU and __wp_page_copy_user() if Svadu
> extension is available.
>=20
> Co-developed-by: Jinyu Tang <tjytimi@163.com>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--utwYTRBgGxs2RSTx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ1gpQAKCRB4tDGHoIJi
0m5MAQCRz8PBnOE4Bp1PoLmi9u02FVUOL0CJOkyE2NVDSwChwAD9HVYje5mmlwS7
mUCfIPG0oUVn8wjDaQ1qsoHh6UPyHgA=
=9y+/
-----END PGP SIGNATURE-----

--utwYTRBgGxs2RSTx--
