Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180D87F10BB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjKTKql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjKTKqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:46:40 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F529C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:46:35 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 532FB6000C;
        Mon, 20 Nov 2023 10:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700477194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riWKqnHwmmCAfQ9aq9A27h5PgZAbzaHajFTcCAZAdzU=;
        b=d0pzteUyP+wl0OT0DVXIPrwH0cXU/NkGKnVXIUWykOx2r9nxJfl+2sWDZi6Vxjj6v+GZSD
        3VJnXgMEVMQLcOeTyAU3BbnmkPpjI8hqIzoApI02DpQyA8SJhgGpOvKy0sxRqiBq2TnPql
        EImn/3TdQ00ZHDLZI7Guf9IUBkw1zO+ayHhnijyz4isVLfRntQRyup4MSkoZ7oIis786CI
        HWHAyRbzFMBz/FvVovfJkMFz5Kks+IpAUiwDNlEg4UnoV+WhiJLA8973zQIY8L9gQuNXUl
        5IDxyCyodc7dIxkSN4nroyF2eLLMqj+CpaRXD//XpKwLaCvhbniJkRonx06/Sw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: meson: initialize clock register
Date:   Mon, 20 Nov 2023 11:46:30 +0100
Message-Id: <20231120104630.3524940-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120064239.3304108-1-avkrasnov@salutedevices.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'acb1fd579efbcac26ce8f9c4fc8bd82f7eaa56e9'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-20 at 06:42:39 UTC, Arseniy Krasnov wrote:
> Clock register must be also initialized during controller probing. If
> this is not performed (for example by bootloader before) - controller
> will not work.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
