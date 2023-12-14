Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03921813558
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573937AbjLNPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573919AbjLNPzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:55:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4602E8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:55:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E15FC433C7;
        Thu, 14 Dec 2023 15:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702569316;
        bh=WYeqYCErkROHKuIRZn/pMD0415jC0WdcK3S4UMGNdjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bF/zNNVUDSEC8MIkmwGiaywCrvo0qBDa6seF/LBNNQJIDSDx1RDK7kxhJWpS+eXjH
         KyA2SubRXyuRShSKDkvPIh6mtdQEFOUGSr2XkGeFSFcreOkFb04oBl8Vo4Gcd5Pson
         M8aZ52nzmMYIyC9zInCOSB1BSsFKrl2X21HSy+FhoGwtqCFz/ycU2xxzkGxGBwnOCc
         q4M/rbJNSdPYF9pORujaImibLYrA4nahCHvrkxMjiw7ZKktj9XfUN0ycrcFSPnyh60
         c20tCQxtRw/iPhp5mSqEGCNq+P8BZrgu9gSYbyYJ01TPkdvzEH7QofS4lyLDx/4OxH
         7EmugigJSrS1Q==
Date:   Thu, 14 Dec 2023 15:55:11 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 01/16] dt-bindings: phy: qmp-ufs: Fix PHY clocks
Message-ID: <20231214-aqueduct-occupy-53b9d650dfc4@spud>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
 <20231214091101.45713-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="65gDSZnx9nzEjrit"
Content-Disposition: inline
In-Reply-To: <20231214091101.45713-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--65gDSZnx9nzEjrit
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 02:40:46PM +0530, Manivannan Sadhasivam wrote:
> All QMP UFS PHYs except MSM8996 require 3 clocks:
>=20
> * ref - 19.2MHz reference clock from RPMh
> * ref_aux - Auxiliary reference clock from GCC
> * qref - QREF clock from GCC or TCSR (since SM8550)
>=20
> MSM8996 only requires 'ref' and 'qref' clocks. Hence, fix the binding to
> reflect the actual clock topology.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--65gDSZnx9nzEjrit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXslXwAKCRB4tDGHoIJi
0l7YAQCxHh+VuMFNf8M6bIbeG5yD+E8OPm4XNyqEpRK3LhhWoQEA54PMCR8Cq5ds
Zn5wnvBY4oYT5Rw7lm6D9DShWy+npgI=
=u2wx
-----END PGP SIGNATURE-----

--65gDSZnx9nzEjrit--
