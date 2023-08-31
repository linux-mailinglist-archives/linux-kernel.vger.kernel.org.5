Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB69B78F0AD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbjHaPyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345659AbjHaPyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB57E63;
        Thu, 31 Aug 2023 08:54:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 792A96303F;
        Thu, 31 Aug 2023 15:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F603C433C7;
        Thu, 31 Aug 2023 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693497274;
        bh=utWCl4di2E0c8+B6XfoLjlyezr54F2TWyx2lJDu8LXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLMox02tzT/Xf8O7Qmf2whCC4gzNsHKPTaJ8DsfveT8E8rIc5pxtRZkGHeA88ls41
         jWo+ID4K+My6+Yk6Txj9s1IMQ4pQ37a5eNCQlYVNoXBR9FdLRj5ur6TIZBnNg+C9nV
         QEK7Za8T5ZfB/P40InQ14RXGEuj3KLwrU21cHt/gNeW2dmIpHy118mkKh8xqCUoKI7
         pbDLVNYWWHFs2qNNijIfhuK/7o2sRbf60hiGTiQ2cprKsPcOOyzCe1NqIWKdylNaCY
         je0Fmk4jGSnIpDG4lcU31G1Ts1Ci/ILGnkZlHCHTplN2zeeMMz4X2U3zrx6pEcO9vh
         g76zaP9GNO3YA==
Date:   Thu, 31 Aug 2023 16:54:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Message-ID: <20230831-defrost-rebalance-5efda5e5ff5c@spud>
References: <20230830103620.3611761-1-Naresh.Solanki@9elements.com>
 <20230830-waving-stinky-d510fefbbf82@spud>
 <CABqG17hvSYbsnYYGOQxVsiXsqLXFnovXvkhgc=pYR9osgF0-1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O1fh9UNgJ3s4p8a/"
Content-Disposition: inline
In-Reply-To: <CABqG17hvSYbsnYYGOQxVsiXsqLXFnovXvkhgc=pYR9osgF0-1g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O1fh9UNgJ3s4p8a/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 12:49:32AM +0530, Naresh Solanki wrote:
> Hi
>=20
> On Wed, 30 Aug 2023 at 21:02, Conor Dooley <conor@kernel.org> wrote:
> > On Wed, Aug 30, 2023 at 12:36:16PM +0200, Naresh Solanki wrote:

> > > +      Indicates that the chip ENABLE pin is at fixed level or left
> > > +      unconnected(has internal pull-down).
> >
> > Maybe you've already been over this, but if the pin is called "enable"
> > why not use the same wording in the property?
> EN & ENABLE is used interchangeably in the datasheet.

Maybe we can go 1 for 2 in terms of consistency then, rather than 0 for
2.

> Just to keep property name short I use EN.

Consistency & readability trump brevity. Please pick one term, or point
out that this is called two things in the datasheet.


--O1fh9UNgJ3s4p8a/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPC3tgAKCRB4tDGHoIJi
0vXlAP0RUs5Q+UPtuiUUIIYh8V3uiABYhs8EIOVx51t+Sc2UpgEA30+M0Z1uzNoF
VoEdVvlU2zzYPyg3LvNdK79mokJJsgw=
=wh5+
-----END PGP SIGNATURE-----

--O1fh9UNgJ3s4p8a/--
