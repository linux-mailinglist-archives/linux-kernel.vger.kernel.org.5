Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C51779677
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbjHKRtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbjHKRtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06335F5;
        Fri, 11 Aug 2023 10:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9797C67887;
        Fri, 11 Aug 2023 17:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0096C433C8;
        Fri, 11 Aug 2023 17:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691776162;
        bh=+iQXHItDODUlFfOTI2OyFGjt3MA8HTMz94UVE6ry1Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJ5MPwpgSeCgnue+FA4fUi8f6Nd4tIntpi24Lc8Iui60IMe90YlMqiU591zHqBRjA
         Qwa+QJ+nHbrSFZkVbWsmdQ4rtS9I9Zqp/h5/MhS2Fm2/dZO0wwm7mA96yaN0hBITQS
         6N8q5lh8nZ7taaJ790HDknnLrE3ghFa565eqNXlAdyresUTlak4Qcm1ISpLj9e1SV6
         SOaVgk7H1l2W2m4uVt70bMjdiKdV1ZU3yU/zrOgt/YwJJYIWk2Go/0kvZQHGOkABh0
         nAhpdA7UCf6sy5CtsGcQShaJtmMXz9ea8y7lLOpymydX2VPeC1pccFJIQrii+MySdh
         o75ENHqAe7PBA==
Date:   Fri, 11 Aug 2023 18:49:16 +0100
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
        Jason Kridner <jkridner@beagleboard.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/3] riscv: Add BeagleV Ahead board support
Message-ID: <20230811-unashamed-county-a3f662479f46@spud>
References: <20230722-upstream-beaglev-ahead-dts-v2-0-a470ab8fe806@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GAKQfoOYysCMruvI"
Content-Disposition: inline
In-Reply-To: <20230722-upstream-beaglev-ahead-dts-v2-0-a470ab8fe806@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GAKQfoOYysCMruvI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey,

On Mon, Jul 24, 2023 at 10:20:37AM -0700, Drew Fustini wrote:
> The BeagleV Ahead single board computer [1] features the T-Head TH1520
> SoC. Similar to the Lichee Pi 4A series from Jisheng [2], this adds a
> minimal device tree file to support booting to a basic shell [3].

What is the status of this series?
Does Drew need to repost with the MAINTAINERS patch removed?
Do you want me to queue this with the MAINTAIERS patch removed Jisheng?
If so, I'd like to do so soon so I can get my PRs into Arnd a reasonable
amount of time before the merge window opens.

Thanks,
Conor.

--GAKQfoOYysCMruvI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNZ0nAAKCRB4tDGHoIJi
0rHFAQDuq66qhwdVKxSwdgf+z+Q235mkVHPAJ/QzdCSuC1+dGwEAv7tD84MghMKJ
HLqO8TqgPQyKJNHgyAgBBBBWWquwDAo=
=sj9+
-----END PGP SIGNATURE-----

--GAKQfoOYysCMruvI--
