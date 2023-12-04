Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093108037C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjLDO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbjLDNzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:55:48 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CECD8;
        Mon,  4 Dec 2023 05:55:52 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 36AEE1BF215;
        Mon,  4 Dec 2023 13:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701698151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kRCtstHEKF0Pojy00GltFVIfI9uWZ2LjfoKa32WYfuY=;
        b=LOxvFvht3eA9pfgnVIlTiinjgEWJ/qLzOyOC/LMtV117eJ7zXLfSiZ4jCOxf18Yx51l9wL
        TTpSn7EWmh7/wCSPbn0ualoFVbUO3dgLTLrkG3YhLmIVyIGqkwwwbwlL7PZn0vKDoYPYqz
        izOA8I0jqC5qIU4tFydzdfO2ndA9I2BUT9AiPJvJRtiJeGMNi5wQVKJRhyjqSnwrOC+gyw
        Dh5DuHHZdw1JP4E/9YaQ3MNntKogWLyY5D4oxUqauygoiGor5lVO8E5BzOsp6rIUFv3N6m
        UvcNsnRG97sQqVUPS7FoCH8EozzqeiwZW7CKzeqnt/KtOZQK32SsYLZi8eBMSA==
Date:   Mon, 4 Dec 2023 14:55:48 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
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
        Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 3/8] net: pse-pd: Introduce PSE types
 enumeration
Message-ID: <20231204145548.37f7a06d@kmaincent-XPS-13-7390>
In-Reply-To: <20231204125131.GE981228@pengutronix.de>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
        <20231201-feature_poe-v2-3-56d8cac607fa@bootlin.com>
        <20231204125131.GE981228@pengutronix.de>
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


Thanks for your review!

On Mon, 4 Dec 2023 13:51:31 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Fri, Dec 01, 2023 at 06:10:25PM +0100, Kory Maincent wrote:
> > +u32 pse_get_types(struct pse_control *psec); =20
>=20
> I would add here some helper function. Something like:
> pse_has_podl() or pse_has_c33()

Instead of pse_get_types function? It is indeed maybe cleaner to use such
helper functions instead.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
