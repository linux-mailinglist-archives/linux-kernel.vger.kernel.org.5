Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5254880113D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjLAQ1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjLAQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:27:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50BB95
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:27:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A783DC433C9;
        Fri,  1 Dec 2023 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701448058;
        bh=njXVksqgpE1XeclAX3UMkcIW+TVRAqYLZ+gVVzqrnbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkZ/J/sbsMCfgSaZ2qbNVoy9pRtzAQUwewg5iqJLNBjvYUwr9aBD685a+74w1LyU7
         IwvL5riWnox7sdV7wlbcmdBzAlT8G5RCwW6eN6jnNeVxXIi6QrLvyE95azDn5lGf25
         IAuvkbfRnCMyBR/LEjLsyQBOPtUWw8zHE75fIKOxJcUyoWKx6mFvMKVUKExEwr5Ch6
         7EdQTm7UrcyRFqOLLNfSWwiqkfQD97eGR/ymDR/Njcscx1iC0FmXvU5WnvhFVGWwIc
         xoV3nhGcOB7wr1wP/COiDojfZjTZN0nXeTndkFDdu1pZUZYnAfYZKpTehCIHohTzmB
         PrSHvuh+M74GQ==
Date:   Fri, 1 Dec 2023 16:27:33 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: qcom-pm8xxx: fix inconsistent example
Message-ID: <20231201-pursuable-endocrine-1318f4843597@spud>
References: <20231130173223.12794-1-johan+linaro@kernel.org>
 <ad96b95a-5f4f-4333-b767-762936932061@linaro.org>
 <ZWmn6uicNIqqSwoE@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1Rvoo8TjijJDXryr"
Content-Disposition: inline
In-Reply-To: <ZWmn6uicNIqqSwoE@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1Rvoo8TjijJDXryr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 10:31:22AM +0100, Johan Hovold wrote:
> On Fri, Dec 01, 2023 at 09:32:46AM +0100, Krzysztof Kozlowski wrote:
> > On 30/11/2023 18:32, Johan Hovold wrote:
> > > The PM8921 is an SSBI PMIC but in the binding example it is described
> > > as being part of an SPMI PMIC while using an SSBI address.
> > >=20
> > > Make the example consistent by using the sibling PM8941 SPMI PMIC
> > > instead.
> > >=20
> > > Fixes: 8138c5f0318c ("dt-bindings: rtc: qcom-pm8xxx-rtc: Add qcom pm8=
xxx rtc bindings")
> >=20
> > Similarly to your thermal patch - this is just an example, not a
> > binding. No bugs are fixed here, no need for backports.
>=20
> A Fixes tag does not in itself imply that something should be
> backported, we have CC-stable tags for that.

IDK, I think at this point every highly active kernel developer should
be aware that the stable maintainers backport way more than just what
gets explicitly CCed to stable.

--1Rvoo8TjijJDXryr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWoJdQAKCRB4tDGHoIJi
0kcpAPwOBPDbYEHIiIG5ZgnuEYXaQxnncECWz71C4cPI0PFljgD/RllSKhlIYHPQ
GqC2jbpH54ZYcJgNTHRgB5Ukpd91GQ4=
=ZTcF
-----END PGP SIGNATURE-----

--1Rvoo8TjijJDXryr--
