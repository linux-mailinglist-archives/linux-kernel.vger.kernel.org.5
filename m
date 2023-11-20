Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1797F1000
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjKTKNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjKTKNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:13:53 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5BDBA;
        Mon, 20 Nov 2023 02:13:48 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 704F21BF215;
        Mon, 20 Nov 2023 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700475227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cmUGH3YuoMjyTyRQ6pJiUJgPb2L/5jsBh4vmboUNNnY=;
        b=Q8ErNCtaXnZs5qZYQUDMJbWRAD/Jy/F3Vv3Vj3ZQEQ4nyuJQyw6q1BNJhz1bze05MEkXgO
        eVvuiHZLXRdQtFpD6kVPZqpHXivAeFRekC2ixepAQqok/6gwVtIhbXEMPl7E6+HmtcdjQu
        LfixvgdAFoNyI6OwAv/KIquB6SW/xc49HY0E/QU+Nb/QOYHY0T2JfHP7SmOFLWW/crwv1Q
        5bCsckNXqP5gPUZLxU4V/lGOCMIUU8rGbWdAk9PcWi7SQhyKd0NZO8/nSvDkimNwA1o168
        8ZNQcvrO3mCBcNTlr8qqbR9asKBGLBSKOXolaMnlxxmQMJPjKzbzpgA0vfqW/g==
Date:   Mon, 20 Nov 2023 11:13:45 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
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
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 6/9] netlink: specs: Expand the pse netlink
 command with PoE interface
Message-ID: <20231120111345.0ad15ea5@kmaincent-XPS-13-7390>
In-Reply-To: <20231118160131.207b7e57@kernel.org>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
        <20231116-feature_poe-v1-6-be48044bf249@bootlin.com>
        <20231118160131.207b7e57@kernel.org>
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

On Sat, 18 Nov 2023 16:01:31 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 16 Nov 2023 15:01:38 +0100 Kory Maincent wrote:
> > +        name: pse-admin-state
> > +        type: u32
> > +        name-prefix: ethtool-a-
> > +      -
> > +        name: pse-admin-control
> > +        type: u32
> > +        name-prefix: ethtool-a-
> > +      -
> > +        name: pse-pw-d-status
> > +        type: u32
> > +        name-prefix: ethtool-a- =20
>=20
> The default prefix is ethtool-a-pse-
> Why don't you leave that be and drop the pse- from the names?

Oh right, thanks, I copied blindly the PoDL lines.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
