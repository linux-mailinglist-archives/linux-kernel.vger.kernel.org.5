Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15847B7A3A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbjJDIis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241728AbjJDIiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:38:46 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6E2D8
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:38:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D38C91C000C;
        Wed,  4 Oct 2023 08:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696408718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g6vgCBkt7rW6blUu1BRqn5QGF+LC8IbkSHwOstsKy8w=;
        b=LWZkD/RBtnwEywsU/t8tZrcz14kV0e12XCLbqEmjuXpkSc2LgIeIK4diCZURxdXwmcbaW1
        M1HahH1WKOInNglBAmEDeg+QKBNPzUdPyNI/RShOu0CVNH91L+EOmZ6OtaoaFYNQlzlB1m
        UHiEFhlSAxEFy6UBeFToqs4DB1gHbQFWfFwvL0SNSYJQj93PSgBrZBB+jn4aWZ9zdBJXOz
        2MNN8Rt+KbC2xBwRBV2iWNaiidV15XYpsmbO6f7O07VM0FuIkyRtbLwaEQ7ixGeAIvg8Yk
        YGMXplJoT9/QWmKbaupUVZnmsPSekjA/v98uXKIrHGfCjeGQv3lTo3Srwkcpfg==
Date:   Wed, 4 Oct 2023 10:38:35 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH v2] mtd: nand: add support for ts72xx
Message-ID: <20231004103835.55cccdc6@xps-13>
In-Reply-To: <20231004082223.12762-1-nikita.shubin@maquefel.me>
References: <20231004082223.12762-1-nikita.shubin@maquefel.me>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

nikita.shubin@maquefel.me wrote on Wed,  4 Oct 2023 11:22:23 +0300:

> Technologic Systems has it's own nand controller implementation in CPLD.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> Changelog v2:
> - dropped check for READCACHE
> - reordered Makefile
>=20
> Link: https://lore.kernel.org/linux-mtd/20230926132725.5d570e1b@xps-13/T/=
#md7e5e944a6a08e24f4f1e20068a49f94794ab945
> ---

[...]

> +static int ts72xx_nand_exec_op(struct nand_chip *chip,
> +			       const struct nand_operation *op, bool check_only)
> +{
> +	unsigned int i;
> +	int ret;
> +

Missing:

	if (check_only)
		return 0;

LGTM otherwise.

Thanks,
Miqu=C3=A8l
