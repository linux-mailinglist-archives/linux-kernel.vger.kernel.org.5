Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F0D75E169
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjGWKc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWKcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D60AB;
        Sun, 23 Jul 2023 03:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8228160C82;
        Sun, 23 Jul 2023 10:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BEBC433C7;
        Sun, 23 Jul 2023 10:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690108342;
        bh=ARam13QTWA3O3nkOowtbpN3JJUB9tpWKoRXDn3NbSyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAHkxQK1dv4LyfRDLNHTgSvV+D0up3guCN+24ju5BK37E89QyqpoclXadVYWg5yz/
         8D/dmCq4yfdl8WUcSdbn/LCvHfp7+9b3vXhSnxB5eoJiD/2RiJi5Wf8gPwjALmV7sR
         BCNlNFUehR5cJGZ0upY/7yIUDILUJEMRj2jpDPJee0HR+pdxKojZSRShk0C0n2vb6B
         nKD9k6Pvtem9Nn897hVOSRVVUj/BCNfknkeSqwd+ogi4HX/vbdtgLe/C4H93V33Iy1
         urgnMDth+1jb32Hr7Fx4p2G0uJ5EXTwHKCBRRqY/VRvWwuUzEGgHz8lGMvw9+YB2yn
         8CUJtEUXdVV4Q==
Date:   Sun, 23 Jul 2023 11:32:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH 1/3] riscv: dts: thead: add BeagleV Ahead board device
 tree
Message-ID: <20230723-savor-trolling-e35ed4a7a751@spud>
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
 <20230722-upstream-beaglev-ahead-dts-v1-1-ccda511357f4@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hbyyzIRWlWHR+2MJ"
Content-Disposition: inline
In-Reply-To: <20230722-upstream-beaglev-ahead-dts-v1-1-ccda511357f4@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hbyyzIRWlWHR+2MJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 22, 2023 at 02:55:39PM -0700, Drew Fustini wrote:

> +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0

Hmm, should this not be dual licensed?
I notice the other th1520 stuff isn't either..


> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0  0x00000000  0x1 0x00000000>;

There's some extra spaces in here for some reason.

--hbyyzIRWlWHR+2MJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL0BsQAKCRB4tDGHoIJi
0uLsAQCAtRC/rwHAZothQ3rTcnBrTdJmoEKJWLdHlvr2QtMyWwEAyrDpBULbR4aa
8Qzk3mMexAB5OcMcQabshMB2TxvIUAI=
=GPK4
-----END PGP SIGNATURE-----

--hbyyzIRWlWHR+2MJ--
