Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74C769AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjGaPSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjGaPSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6791705;
        Mon, 31 Jul 2023 08:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C35C1611A5;
        Mon, 31 Jul 2023 15:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64906C433C9;
        Mon, 31 Jul 2023 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690816719;
        bh=Q50MzpVmQKShkDddA+wpPlFfKFSboVbPTpXchnb6DeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cw1AN4sEbkCY5xbvYMock2xl3WqJNANZjWb0jPrZu+CbiG7XHSWMEkcafGIpV6voQ
         9AflccHPF6GI0mzn46QhEv4VgwA9JgvNAiCCjROXTR8hVeO2WN+V4ZhXOd4t1aGRE9
         p0wDSChdnpd6Cwipg7tiYWS6YO6JWrHeqznYE+JULoxRdbM5iBY0yqZJuOzAwsxQVF
         ycX59BhKJsNyTR3Vohgsof4L7UJkcFPz5mVApNE6L0JjtJB4+nKzavqI9PYVi8JT64
         3/DSmeCB1K1jRXxbujsX1cjKqsNAWssBtLLw0Fh8z2UHlakAZ3BNUeQz39sqUxzZw3
         I5aiv9NwNQ8Gw==
Date:   Mon, 31 Jul 2023 16:18:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Bin Meng <bmeng@tinylab.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3] riscv: Handle zicsr/zifencei issue between gcc and
 binutils
Message-ID: <20230731-mangy-violation-b388807be1f0@spud>
References: <20230731095936.23397-1-xingmingzheng@iscas.ac.cn>
 <20230731-calzone-gratified-dbc51639beec@wendy>
 <90d97914-9576-42e7-0d7d-c752b5bd6a68@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MYBW3sdjBDT2ibnW"
Content-Disposition: inline
In-Reply-To: <90d97914-9576-42e7-0d7d-c752b5bd6a68@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MYBW3sdjBDT2ibnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 11:16:14PM +0800, Mingzheng Xing wrote:
>=20
> Thanks for your review, I've made the changes and submitted a
> new PATCH but there seems to be an email thread issue,
> hopefully it won't have an effect, sorry about that.

Is there? It seemed fine to me, apart from the missing v4, was about to
take a look.

--MYBW3sdjBDT2ibnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMfQyQAKCRB4tDGHoIJi
0uweAQDTVPr61XcFSC3dLzT5u2GCzcBIT18GT/3MfmaUsXxiQAD/aCvFyVbhmGo+
3/JOuJhaJcuO4Zq8aMt2Vx4QctA8RAE=
=ktAQ
-----END PGP SIGNATURE-----

--MYBW3sdjBDT2ibnW--
