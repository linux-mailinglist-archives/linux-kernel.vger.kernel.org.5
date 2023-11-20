Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55F97F0FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjKTKJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjKTKJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:09:52 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011E794;
        Mon, 20 Nov 2023 02:09:47 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E2DB2000D;
        Mon, 20 Nov 2023 10:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700474986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwpNNNLmUEdlAV7YRR3v1NKd/qp4dY+yMavuDYSXmwI=;
        b=VgQrxdeSTbCnuH15lof1JX82UZTIKsJA/mcYec4Y57kHWqIikYGBk/gkk5oMa+dnxC5uTj
        jsEKkaooB9EufqeBsn+vMn47NUN06/wvh5BUJitJnAclyzTch794V1MqWNkNeyj4tJsVbt
        aKZWT0j6adb23riAIzSKMDr7U7EuIB6qQ5V0rfg4rDWPT2AAa3CbIpVMddHsTioOlcTl2f
        AqgugCkets/megXLxtVTmor+R6x/GgL1emYZVJcFctXNjL6KwQtkQkhdsI5hgPWQG66rF8
        A6RS1mVisS2BemRPonuv3VTZqsbK7Z+cTXXJR4Y52G2jn+wwkDUERhLVnPTfmw==
Date:   Mon, 20 Nov 2023 11:09:44 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 2/9] ethtool: Expand Ethernet Power Equipment
 with PoE alongside PoDL
Message-ID: <20231120110944.66938859@kmaincent-XPS-13-7390>
In-Reply-To: <04cb7d87-bb6b-4997-878d-490c17bfdfd0@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
        <20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
        <04cb7d87-bb6b-4997-878d-490c17bfdfd0@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Oleksij

Sorry forgot to CC you the series.
Maybe you should add yourself to the MAINTAINERS of pse-pd drivers subsyste=
m?

On Sat, 18 Nov 2023 18:38:43 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Nov 16, 2023 at 03:01:34PM +0100, Kory Maincent wrote:
> > In the current PSE interface for Ethernet Power Equipment, support is
> > limited to PoDL. This patch extends the interface to accommodate the
> > objects specified in IEEE 802.3-2022 145.2 for Power sourcing
> > Equipment (PSE). =20
>=20
> Sorry for taking a while getting to these patches. Plumbers and other
> patches have been keeping me busy.

Don't worry you are doing a great job as a net maintainer and I won't raise=
 any
remarks on delay considering how you are doing your job.
Thanks again for your review!!

> I'm trying to get my head around naming... Is there some sort of
> hierarchy? Is PSE the generic concept for putting power down the
> cable? Then you have the sub-type PoDL, and the sub-type PoE?

In fact as we discussed with Oleksij I decided to keep the naming as close =
as
possible to the IEEE 802.3 standard.
On the standard the PODL is naming like this aPoDLPSE* (ex: aPoDLPSEAdminSt=
ate)
and the PSE is naming like this aPSE* (ex: aPSEAdminState) without any PoE
prefix. Maybe it is due to PoE being supported before PoDL and they didn't
expect the PoDL part.

> >  struct pse_control_config {
> >  	enum ethtool_podl_pse_admin_state podl_admin_control;
> > +	enum ethtool_pse_admin_state admin_control; =20
>=20
> When i look at this, it seems to me admin_control should be generic
> across all schemes which put power down the cable, and
> podl_admin_control is specific to how PoDL puts power down the cable.
>
> Since you appear to be adding support for a second way to put power
> down the cable, i would expect something like poe_admin_control being
> added here. But maybe that is in a later patch?

No as said above admin_control is for PoE and podl_admin_control is for PoD=
L.
Maybe you prefer to use poe_admin_control, and add poe prefix in the poe
variables. It will differ a bit from the IEEE standard naming but I agreed =
that
it would be more understandable in the development part.

I am open to the change.
Oleksij do you agree?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
