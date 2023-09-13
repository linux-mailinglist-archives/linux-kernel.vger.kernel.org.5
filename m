Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186D079E02D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbjIMGnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjIMGnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:43:10 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E77EDA;
        Tue, 12 Sep 2023 23:43:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C8A52E0005;
        Wed, 13 Sep 2023 06:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694587385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ea7k9WOLK3tR/MQAggc+PLYXhMIIJtMQ+lzPVjE+cg0=;
        b=HgfplnX22m1hVcMaY8EbaIfiFFjikEywwY94FdmPmRVtwjvHOEgfgxiwFOS6Gpo1Cz52bA
        2f1hPn9xwdZLPv4+94PB8i9u1dTdE9i36jJ7gFbZGQA3hWX+HOY8FFYSW6j6FKenU/3o9u
        5u7OBQiLYVjyoBSZt1wAwY2ysvbiSuGwSO0fM5NOI5cUXXQTTvAS2Pe4W0imz8pg5+RKFz
        ux7Ja2fQAdTxQfagMZl7oyOFHRCM1TB35c9AZp/mLHALOrLS129j7Vu3MO/OwmrqQ/pYV9
        gYhxhfXKNeYA3XJoVYi0MDzei1yKwTisSlXeups9APKxU36hXbhDdOcnjdyJwQ==
Date:   Wed, 13 Sep 2023 08:43:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Joshua Yeong <joshua.yeong@starfivetech.com>
Cc:     <pgaj@cadence.com>, <alexandre.belloni@bootlin.com>,
        <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] i3c: master: cdns: Fix reading status register
Message-ID: <20230913084301.6b2191c2@xps-13>
In-Reply-To: <20230913031743.11439-2-joshua.yeong@starfivetech.com>
References: <20230913031743.11439-1-joshua.yeong@starfivetech.com>
        <20230913031743.11439-2-joshua.yeong@starfivetech.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joshua,

joshua.yeong@starfivetech.com wrote on Wed, 13 Sep 2023 11:17:45 +0800:

> IBIR_DEPTH and CMDR_DEPTH should read from status0 instead of status1.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 603f2bee2c54 ("i3c: master: Add driver for Cadence IP")
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
