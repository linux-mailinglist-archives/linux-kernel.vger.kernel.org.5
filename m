Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809807F1029
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjKTKTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjKTKT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:19:26 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F94F0;
        Mon, 20 Nov 2023 02:19:19 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C94360004;
        Mon, 20 Nov 2023 10:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700475556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHbDL7jNMUasqa9ByFpwzciJ29lMyQNOMOBeNCichXs=;
        b=c5lbXLbWW9YP7AUdRp7KzfsQ7reh4eDpvr30itwwIJuhSSkz3VoX0dpgZYVUZYzRer1FKM
        C5300PSVwLYbkajYcKl/W2dMDaYaGQjrRYdfNvThjARyRj7sOD6o+6FVJeJkbf7nqT1iNQ
        pv7E9QkuaWYKlqkun9+xc+p+x3ERS+lDYIcMp07LKbpbvWRNrPc0jjCdHuTHQq1u52JABC
        6ZfXvT3gkTmqL/H0RYIqESlcv+/SK+Sk1upeCvjqUSWaarvqKGxSgf1Ew5oMrxSwvYz4JJ
        hfPRo13Z1CgjcZrhJIaLn0I+vZ/9rbjxQk0SmHtHDkBef6fI7Wz0jbBWVuJuUA==
Date:   Mon, 20 Nov 2023 11:19:14 +0100
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
Subject: Re: [PATCH net-next 5/9] netlink: specs: Modify pse attribute
 prefix
Message-ID: <20231120111914.36a5ca73@kmaincent-XPS-13-7390>
In-Reply-To: <20231118155702.57dcf53d@kernel.org>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
        <20231116-feature_poe-v1-5-be48044bf249@bootlin.com>
        <20231118155702.57dcf53d@kernel.org>
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

On Sat, 18 Nov 2023 15:57:02 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 16 Nov 2023 15:01:37 +0100 Kory Maincent wrote:
> > Remove podl from the attribute prefix to prepare the support of PoE pse
> > netlink spec. =20
>=20
> You need to run ./tools/net/ynl/ynl-regen.sh

Ok, should I also send a patch with the newly generated files? Or is it
something done by the maintainers?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
