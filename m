Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75FE7AEFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbjIZPl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjIZPlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:41:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1424511D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:41:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AD3C433C7;
        Tue, 26 Sep 2023 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695742877;
        bh=+MUfMhGucwoTdGhh7kaHa7LAydp1xTUnaUmYpp/LxEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yk3JRkxsuGk0kfHJhUA0L7fAzP+qTls4FB9bICdrV2USkgAkZHNdvU+Kv+i6FC4dJ
         sgiYhlxoRurOs3wi1XpshubJCbqZ+qeQqWp5Cn7XHybCTo5BIAlgyWov7uZu46xHWK
         M4b3B2BZvfV3u4GY7WpJFoXcOOGGywtRowX6TqUmJciPy21n+e7pzyEBYCZ113Mhv/
         uDKq0mBGr5LQLJEXKFj1D+xqq+VsnUe51KanRchPIuhT9wLD6bCZqlYRNqqMhghmbX
         THJ9leVe9jVygUgBjDxHu2LJNb6OC/hMB//Tzi0sWBda5dYNdsPupPe711FJo077Ki
         YnBn1Tza1BWYg==
Date:   Tue, 26 Sep 2023 17:41:15 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v3] regulator: max20086: Drop ID table
Message-ID: <ZRL7m4AGkmYywAEE@finisterre.sirena.org.uk>
References: <20230910065444.25906-1-biju.das.jz@bp.renesas.com>
 <ZRL5ahsXZ5u3brDB@finisterre.sirena.org.uk>
 <OS0PR01MB59227E269E915E313109524686C3A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ye3BITfTfJOrmKXR"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59227E269E915E313109524686C3A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ye3BITfTfJOrmKXR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 26, 2023 at 03:36:04PM +0000, Biju Das wrote:

> V2 version is accepted and is in next [1]. So I would like to
> drop this patch as there is no harm in supporting both OF/ID
> tables. Please let me know if you think otherwise.

Ah, that's good - I'd just not expired v1 when I applied that.
Supporting ID based matches does seem better.

--ye3BITfTfJOrmKXR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUS+5oACgkQJNaLcl1U
h9C4Ngf+NCKGEDKzLhzyN58vIEvvagCqHYU2dBT4h0W/Tmir8xGFOpkcTyyRTLJX
owETA5kzG1bY5wk5nmoNJJbZQ2GoMcUfmtCyeaTwDS3F79EdW1/o9UCdRxZX4ykS
g0L8g6iyLZ9SaXn1lKGvzX8e9ugK4fOPfKXluN4KpS6xzvr+fXWi8YODwb9aViw7
Sezg4A1/cQkuGP7IZ3XjhBOVXsNUIhxAq/oM81gLUpU1pOpfl6dCKrUzpqF+gaNE
g46oOTsyRRHAK7ohiObZwLnu32vMwxGKvtvtiRdyYvkpDgv0gkYIcUHTOYHHRXf/
uql45jinFuVQrmH8H+96BajAtDnXig==
=Vd1L
-----END PGP SIGNATURE-----

--ye3BITfTfJOrmKXR--
