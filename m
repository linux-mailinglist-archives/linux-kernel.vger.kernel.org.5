Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9307AEDCD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjIZNMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjIZNMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:12:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE453116
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:12:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4DEC433C9;
        Tue, 26 Sep 2023 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695733944;
        bh=tEmZVsFUr9fSaZxXK1gcCt5lsfnZ60ZguEkk/NvJJxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2RcjHgPcFiwFH9WhaEbhXTLOq4VkH7CkU3VQEIBi6TtifRCupmiu0HTxaXfCzovh
         lAnH3tSDOYn3UYUoBFT+87G8wySGZdNFzSraedTFruedakoBNeqW060wJEiE1F/KKV
         XGzJlUTt5bAIPV2C8IpdB5U9rr4eNH9afPldmQhNFig5UMwiN1Au5kNExSaEH8TrRo
         V9qGpV7IFDaDevLdJg9m6q0tnu/ulRwvHK5MB6mDbppcCo7+UyVD3xCkLPUhtwq7QI
         xyhgsV9T/o/kHfjvKlFvZ3BocQFi1VPBp8+ZrZqa08e7z80c8pfm8GpuZvbKdnkq/0
         ihrKVuUXHZt4w==
Date:   Tue, 26 Sep 2023 14:12:19 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: arm,coresight-cti: Add missing
 additionalProperties on child nodes
Message-ID: <20230926-trivial-landed-4c291e73394a@spud>
References: <20230925220511.2026514-1-robh@kernel.org>
 <20230925220511.2026514-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7MqFRIBkMyePXi20"
Content-Disposition: inline
In-Reply-To: <20230925220511.2026514-2-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7MqFRIBkMyePXi20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 05:05:06PM -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
>=20
> Adding additionalProperties constraint on 'trig-conns' nodes results in
> warnings that 'cpu' and 'arm,cs-dev-assoc' are not allowed. These are
> already defined for the parent node, but need to be duplicated for the
> child node. Drop the free form description that the properties also apply
> to the child nodes.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--7MqFRIBkMyePXi20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRLYswAKCRB4tDGHoIJi
0iCuAQC1dso8YQQh1/a5gG2GO+uzI0OQQiGYQ/5LL0PEfLq4xgEApA1wEWP2ns83
H/f6nHaNEjQCzK7gcxzwD8j77ugYIgM=
=mHxD
-----END PGP SIGNATURE-----

--7MqFRIBkMyePXi20--
