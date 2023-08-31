Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2E378F150
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244577AbjHaQae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjHaQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:30:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F75DCC5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C355EB8215C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 16:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA047C433C8;
        Thu, 31 Aug 2023 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693499386;
        bh=9Pr9fegNoNUn//WzmCMU1Histd8f9wgBhE+pRfO0JRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AuPs3RaYJA/9emJHcwCOySVCskILTl6kosxIZvHqkUtS3d4eylDKQknnFeQGEuMk/
         bDUFH28qqwkrlKsh19PS6GBfVNTFVuUV41Tk51hAkeiATEEJlKdeCkTQAdWDw31DXk
         u3E8hos4Qn3n0GQNALOvmIzjpgdeeDdU4B2e4YoenkyV46esTgKFUlYE7ixJHfW7lZ
         uTC9Spt4h5wSrUJSM0eqlaR1wCkQYlXdjdE2HgDZ+vf73GJNNPgkrbDMiv2f9rP9rz
         b2SgNof35GV+eWEp/mvsFFc3ydeNnS86dgPW/DYdTXq+G3KsGSIlWbKyJmwOEelR/P
         Qzz73QAPDzP6w==
Date:   Thu, 31 Aug 2023 17:29:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        bjorn@kernel.org
Subject: Re: [PATCH] riscv: provide riscv-specific is_trap_insn()
Message-ID: <20230831-untidy-geologic-8c8232eb3cac@spud>
References: <20230827205641.46836-1-namcaov@gmail.com>
 <CAJF2gTQysBBSbtFcx1uY_ztTnzN5jRWpG2OD4O3aJ0u9Ekwsag@mail.gmail.com>
 <20230829-unbridle-condense-2fc45a442bb6@wendy>
 <ZO2p1tScBT1UFMh1@nam-dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pX1jrx4hiKgkc+Cg"
Content-Disposition: inline
In-Reply-To: <ZO2p1tScBT1UFMh1@nam-dell>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pX1jrx4hiKgkc+Cg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 29, 2023 at 10:18:30AM +0200, Nam Cao wrote:

> Now I'm not sure what you mean. But I agree with Guo Ren here, users can use
> compressed instructions but kernel does not have it enabled. So we should
> always check c.ebreak regardless of RISCV_ISA_C.

I think I was just being dumb, apologies for the noise.

--pX1jrx4hiKgkc+Cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPC/9gAKCRB4tDGHoIJi
0iNIAQDlFOLhVRwewDs3RynOY+M19AyVbnv6fuCWrcIVf6rtpQEAuxuaR9YxMsh/
J1iTji590xUIscZGwQx0MV/Mn6UZTgA=
=Oo6H
-----END PGP SIGNATURE-----

--pX1jrx4hiKgkc+Cg--
