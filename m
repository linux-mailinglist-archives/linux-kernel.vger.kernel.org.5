Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9EE8069B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377150AbjLFIfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376876AbjLFIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:35:12 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AF4112;
        Wed,  6 Dec 2023 00:35:15 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D83840008;
        Wed,  6 Dec 2023 08:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701851714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JkFIxNj8NPk822mRewsy8oS7BhiBkPsoFjDPzgpryg=;
        b=aJNEGg9Z/Z1hk8At6T7xptjbm9FfpsaIX/W36ZUxZuUNKQDNAES8c3SK4LY0B/fiNLQv4Y
        rcLuq5MeYwusid5ahKRvzYGBmdAQ+0owGMQ924oLKyJ/mDRsDKW6w+rzF7hak9c4XhuQpD
        KPM+WHfdJShJr1QPZjv/pK0SEhacoJq6YqoiBixzbI6ACTW9GpHH41SR/1akJ/PDWRiv8n
        +CapeooQBZz+n7I1HgHwytx/drEdrivxmF48c1iiQOr+BCXd/Hv/2YDKVv0w9NGTqTeqTk
        JjhawXR80bK8HkvY5P7wa3Bi0Lq+kAoCE/MHLyDJxqIxPFSRDq/KQK296DoZNA==
Date:   Wed, 6 Dec 2023 09:35:10 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
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
        Oleksij Rempel <o.rempel@pengutronix.de>,
        attreyee-muk <tintinm2017@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux Networking <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Devicetree <devicetree@vger.kernel.org>,
        Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 2/8] ethtool: Expand Ethernet Power
 Equipment with c33 (PoE) alongside PoDL
Message-ID: <20231206093510.68b9179b@kmaincent-XPS-13-7390>
In-Reply-To: <ZW_gWDrlp4ltXIRf@archie.me>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
        <20231201-feature_poe-v2-2-56d8cac607fa@bootlin.com>
        <ZW_gWDrlp4ltXIRf@archie.me>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 09:45:44 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> On Fri, Dec 01, 2023 at 06:10:24PM +0100, Kory Maincent wrote:
> > In the current PSE interface for Ethernet Power Equipment, support is
> > limited to PoDL. This patch extends the interface to accommodate the
> > objects specified in IEEE 802.3-2022 145.2 for Power sourcing
> > Equipment (PSE).
> >=20
> > The following objects are now supported and considered mandatory:
> > - IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus
> > - IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
> > - IEEE 802.3-2022 30.9.1.2.1 aPSEAdminControl
> >=20
> > To avoid confusion between "PoDL PSE" and "PoE PSE", which have similar
> > names but distinct values, we have followed the suggestion of Oleksij
> > Rempel and Andrew Lunn to maintain separate naming schemes for each,
> > using c33 (clause 33) prefix for "PoE PSE".
> > You can find more details in the discussion threads here:
> > https://lore.kernel.org/netdev/20230912110637.GI780075@pengutronix.de/
> > https://lore.kernel.org/netdev/2539b109-72ad-470a-9dae-9f53de4f64ec@lun=
n.ch/
> >=20
> > Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >=20
> > Changes in v2:
> > - Rename all the PoE variables and enum with a c33 prefix.
> > - Add documentation, thanks to Oleksij for having written one.
> > ---

>=20
> I get many htmldocs warnings:

Oops sorry, I forgot to run the documentation build.
Thanks for your reviews!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
