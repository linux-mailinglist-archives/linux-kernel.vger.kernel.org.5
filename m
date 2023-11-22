Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B147F44CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343578AbjKVLTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKVLS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:18:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB20B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:18:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8029CC433C8;
        Wed, 22 Nov 2023 11:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700651933;
        bh=MQOyWaD28qGZWRp1OTCZzDWS6KW+slPGyTvC7Pw3pBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubRctM7gadyqCUKoLvHPNiN+FJfnNLEynLUQChmKNSRoYQ20hxlYeiqQaa4BGhYCs
         pmPMyiFoeQciOt7LAau1gQoK3BWyTd/RiZZpF42IqYdCN67EZ5OcummvSVkPgiBPfc
         ELv6GHKsNO95NRL2f5CcBk9krIck8qYiZPsS//HFQ2AGIcN3lb4qdIDPZiCsV43C6p
         ovupTzYwSJnyvHehql98yTQls/M8maoUqWdQhudpF4SZfGy7V1ndK8DUhE4vUAIqGY
         90inD5GVSIQdyU5jze6Iaggm5qwVg7sQ/GNSL7NQMhTx5bOe77Jz5zSpVuYPRWfp06
         sohnRbUst/K5A==
Date:   Wed, 22 Nov 2023 11:18:50 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] riscv: Deduplicate code in setup_smp()
Message-ID: <20231122-scuff-sinner-3a6e70535efa@spud>
References: <20231121234736.3489608-1-samuel.holland@sifive.com>
 <20231121234736.3489608-2-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g4QIhuRDBzcjEDtx"
Content-Disposition: inline
In-Reply-To: <20231121234736.3489608-2-samuel.holland@sifive.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g4QIhuRDBzcjEDtx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 03:47:24PM -0800, Samuel Holland wrote:
> Both the ACPI and DT implementations contain some of the same code.
> Move it to the calling function so it is not duplicated.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--g4QIhuRDBzcjEDtx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV3jmgAKCRB4tDGHoIJi
0gXNAQCzo3O9dInv1Bg0Kw/qx2mGPmeeZHu568mN8CTWSE0R7gD9FNGwy279OHD1
Xp7KTTeA4nI8ghBhuVtNT54zXGHOtgI=
=AC/F
-----END PGP SIGNATURE-----

--g4QIhuRDBzcjEDtx--
