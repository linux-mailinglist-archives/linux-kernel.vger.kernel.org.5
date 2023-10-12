Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549747C6826
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjJLIVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbjJLIVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:21:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F2B91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:21:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25227C433C7;
        Thu, 12 Oct 2023 08:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697098896;
        bh=Gbx9yfCnmX9XPEWtA3eMET7ED2JBqtacGUNnM+M3sUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSTyKbjJSfkctBl/8rEzb6uSsYNnvHThaeZ65b1J2phjEEUdXBs63FfwoR4/T7ZgL
         nyhJ6Upa6VjXMs2ucaqDRAUUepXE5tQAqAdlkyTpVTfx4T18BXHj5sEn/zsbNRLDLH
         ZYbfqcntJd1n+Z4/oh5mgR0zje/yOS0K28y1LMqiX2EWMacsEZn1exsst57byvHu8u
         vB3nTH9XTuwVbTRMuIkd+9WLqQIODGAWcnVISTavrfVCaVf7QK2T0m90Mv/Hy7b5Y7
         zfokr+XUcLMDqy21mccRs902ed7naf1G7q/SJh8Rj8BKH64i6uWFQ/yYDw61ZM7aIq
         A+Uz8ZoPF4wvw==
Date:   Thu, 12 Oct 2023 09:21:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>
Subject: Re: [PATCH v1 00/13] riscv: report more ISA extensions through
 hwprobe
Message-ID: <20231012-clanking-imagines-150a7c05f3f8@spud>
References: <20231011111438.909552-1-cleger@rivosinc.com>
 <11d6a463-4e00-4407-9d93-2f9d190c4be3@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aGJy53Fkev1PgtWs"
Content-Disposition: inline
In-Reply-To: <11d6a463-4e00-4407-9d93-2f9d190c4be3@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aGJy53Fkev1PgtWs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 09:15:46AM +0200, Cl=E9ment L=E9ger wrote:
> On second thought, maybe it would make more sense to squash all logical
> commits together (dt-bindings, hwporobe, etc) with all the ISA
> extensions in each. Tell me if you think it would be better.

I don't think there's anything wrong with the current approach.

--aGJy53Fkev1PgtWs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSesiwAKCRB4tDGHoIJi
0laUAPwI/1+B1oBExxGb6yOySNlV+rOwyauBbfAYtcc8BdmIfgD/SyUb8fpdpCva
Svh9QuookDdoT6A+W0p/GzyEYZwIUAI=
=rZ0m
-----END PGP SIGNATURE-----

--aGJy53Fkev1PgtWs--
