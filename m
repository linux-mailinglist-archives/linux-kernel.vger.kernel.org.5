Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E380117A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjLAQgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLAQgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:36:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971F3CF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:36:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF63C433C7;
        Fri,  1 Dec 2023 16:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701448618;
        bh=RnPR+XBq6lWymlucGaXH1Q9fUC0o3QSRY7BPPDl2A/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olZ1DBNJRs1J10iZqvaOwhTBn1G+4W9E1qnGdgYAYiLfukGO13d8GVYduyw5j6ACQ
         6WeBCrXycQeMWLa/BuVYKdHaSwubOuB13inZWSqmEvtLr3WSJjsfhInatrFjnDUrBE
         ajP3Mw6AUuh3YqU2haz/WbsWPcyiUM+YHTMMpGBtKwf++YKREoS3E+HmiNccP77HQt
         PMj2vda64ICsGf3k1xTl3dQjKjKJS4I4JByohsoRJXhmDQtqloq7ByMfm3mNNzsWeW
         m53cVJ4+jm9bKy3E9GmjFG9mv4hMEuGZus6/kOBxYxqc7IHLS/GakCTxBH0FW+iNn5
         RLY4jh5xt/CqQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r96WD-0003Dg-3C;
        Fri, 01 Dec 2023 17:37:34 +0100
Date:   Fri, 1 Dec 2023 17:37:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Conor Dooley <conor@kernel.org>
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
Message-ID: <ZWoLzTX0zmCOxsVm@hovoldconsulting.com>
References: <20231130173223.12794-1-johan+linaro@kernel.org>
 <ad96b95a-5f4f-4333-b767-762936932061@linaro.org>
 <ZWmn6uicNIqqSwoE@hovoldconsulting.com>
 <20231201-pursuable-endocrine-1318f4843597@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ry05RoAL5d6Ievs5"
Content-Disposition: inline
In-Reply-To: <20231201-pursuable-endocrine-1318f4843597@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ry05RoAL5d6Ievs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 04:27:33PM +0000, Conor Dooley wrote:
> On Fri, Dec 01, 2023 at 10:31:22AM +0100, Johan Hovold wrote:

> > A Fixes tag does not in itself imply that something should be
> > backported, we have CC-stable tags for that.
>=20
> IDK, I think at this point every highly active kernel developer should
> be aware that the stable maintainers backport way more than just what
> gets explicitly CCed to stable.

I'm quite aware of that, and if one of my patches with a Fixes tag is
picked up for backporting when it should not I complain loudly.

For this patch, I would not necessarily complain however as the current
example is misleading.

Johan

--ry05RoAL5d6Ievs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZWoLyQAKCRALxc3C7H1l
CGwAAQD4pdhkL7tYkLWSHzoZle5G4pVsi5t0oj4r8gD7HUcCwQD/cP5hu7Utw+ZG
WSjEUNMapd6fy9dBqslr8+BX+/g39wY=
=YNXt
-----END PGP SIGNATURE-----

--ry05RoAL5d6Ievs5--
