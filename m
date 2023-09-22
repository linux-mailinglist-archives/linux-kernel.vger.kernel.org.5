Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61097AAAA9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjIVHpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjIVHo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:44:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E14E75;
        Fri, 22 Sep 2023 00:43:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3F9C433C9;
        Fri, 22 Sep 2023 07:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695368615;
        bh=6tDdJhC5FZTkZ44FitxejpeH8ROnFdmLxtwON7CZxos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHCcR7uevrEt/tblgFyS8s6RWTN+evtBWD9f41ZMQtTiZRu+rMDyhF69JZWibazdb
         JVJg2Pju6Hn948H42DNwQO14rVloH63//0+P2JkiaRRSgS/hiZ1ncTjS+mtqm5IvQl
         cdTRq9/bW6t+skQeZZBWqL38+eppuIKtbmaL5DK+nQBBt6NPc60y4NPh5nyyV/3CGw
         o4jKhBXlLPzhYw+O1geUbIltuM+Z/06YBO9nIS90CBKbpFBOEGSgNRyKHsAf+rzc09
         HsuclSjEKPPaIk2mtSaPJTCkOOUahz3IsQMFjD/1jNhSHnAkXd1bFEFYG8UfoRaM9x
         BryNMs7nbBblw==
Date:   Fri, 22 Sep 2023 08:43:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Message-ID: <20230922-thumb-galvanize-bef393a1bda4@spud>
References: <20230920-992a56b66366f3c0591a6a94@fedora>
 <IA1PR20MB4953D983915AD8E35FD3E51FBBFFA@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WhczGDiSuZFNERlK"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953D983915AD8E35FD3E51FBBFFA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WhczGDiSuZFNERlK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 01:16:35PM +0800, Inochi Amaoto wrote:

> >> The SiFive CLINT has flexibility related limitations which makes it
> >> not useful for multi-socket and mult-die systems. The SiFive CLINT
> >> is also not useful for systems with AIA because with AIA M-mode has
> >> a new way of doing M-mode IPIs. Due to this reasons, the RISC-V
> >> ACLINT spec breaks down traditional SiFive CLINT into two separate
> >> devices namely mtimer and mswi. This allows platforms to implement
> >> only the required set of devices. The mtimer as defined by the ACLINT
> >> specifications also allows platforms to place mtime and mtimecmp
> >> registers at different locations.
> >>
> >> Refer, https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.ad=
oc
> >>
> >> We need a separate DT bindings document for ACLINT MTIMER
> >> and ACLINT MSWI because these are separate devices. The
> >> Sophgo sg2042 SoC should add their implementation specific
> >> compatible strings in this document.
> >
> >If the spec isn't frozen, I'm not accepting a binding for the "generic"
> >version of it. Bindings for this specific implemtnation are okay.
> >For sure though, squeezing this into the sifive,plic binding isn't
> >appropriate.
> >
>=20
> It seems I have missed a point. I wonder whether it is better to add a
> "aclint" binding firstly and then add sg2042 to it, or just use sg2042
> specific binding?

sg2042 specific, being frozen is a requirement for merging patches
related to RVI specifications.

> If use "aclint" binding, I wonder it is OK to add
> thead quirks as compatible specific properties, or left this to the SBI to
> handle? e.g. T-HEAD timer is not 64bit timer, and we should identify this.

The compatible string alone should be sufficient to identify the width
of the timer etc.

Thanks,
Conor.

--WhczGDiSuZFNERlK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ1FoQAKCRB4tDGHoIJi
0iryAP9MnKwWi0NmDf7v8Kg2LJZpGsuhw2tAXlM69r9GgbrWZAD/aO3LLbNs7KmQ
32cKVwtSC7/7GIBcbTW9a81enmp4VQ8=
=mBQ0
-----END PGP SIGNATURE-----

--WhczGDiSuZFNERlK--
