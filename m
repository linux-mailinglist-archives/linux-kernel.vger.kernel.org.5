Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E6978555D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjHWK2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjHWK2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:28:49 -0400
X-Greylist: delayed 459 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Aug 2023 03:28:43 PDT
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824DBFB;
        Wed, 23 Aug 2023 03:28:43 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5faf:0:640:dd1b:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 92D6B5EEEA;
        Wed, 23 Aug 2023 13:20:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uKHTnk0WkCg0-TTafOwS9;
        Wed, 23 Aug 2023 13:20:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1692786057;
        bh=8Pq1lYC71AwHsxprgP4hPusQdlFzoJPLVzm11dwsZXE=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=MhbTZ5GkTkPCr14ls4Y+5+AWU4kpAwJZDepqY9cBeixBCwUQvEvlyqhfUB7ADMh4u
         XWq1ewFgBbldNKuWczJKxNRCqiy7JWIpZvq4oJbwpOEuck8OmKe+snhbZvRENUCS1B
         /1Ybgg6ySyBQfQ2AVgf9/Quf51IpECSjerOOfDlc=
Authentication-Results: mail-nwsmtp-smtp-production-main-29.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <c39b9281fa599d523591b3a3b34db6a05362cdbf.camel@maquefel.me>
Subject: Re: [PATCH 2/2] rtc: m48t86: add DT support for m48t86
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Aug 2023 13:20:59 +0300
In-Reply-To: <19f09a5e-c420-f209-ebef-cfa36ffa8467@linaro.org>
References: <20230823-m48t86_device_tree-v1-0-240023b435ac@maquefel.me>
         <20230823-m48t86_device_tree-v1-2-240023b435ac@maquefel.me>
         <19f09a5e-c420-f209-ebef-cfa36ffa8467@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof!

On Wed, 2023-08-23 at 12:14 +0200, Krzysztof Kozlowski wrote:
> On 23/08/2023 11:03, Nikita Shubin via B4 Relay wrote:
> > From: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > Add OF ID match table.
> >=20
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> How did these appear? It's v1, so it is a bit confusing.

Indeed this is from "ep93xx device tree conversion" series, you asked
to submit these part as a separate.

I don't know the rules for tags in such cases, sorry. It's discouraged
to use tags given elsewhere ?

>=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> >=20
>=20
> Best regards,
> Krzysztof
>=20

