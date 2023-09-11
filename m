Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8E779AED8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbjIKUwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242579AbjIKPwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:52:45 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64630193
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:52:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06016E0005;
        Mon, 11 Sep 2023 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694447559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8nIczPiFsqVxkWM9qeLl1vaCZnfIjagPpomfaOAgj2w=;
        b=Tt1iexBr9Kgu3zHZwCf+vi3jtB1z8LwFFO0cz8SM4KHYnGgzYIJnhjjikMZeUupdqgSiUI
        uoGnAyfuAZwB8PuuGNeAODFm8uev/2Vwb52UTBONFpq68/cQ9ydDv0uELBvMbtAKbnxUIK
        6CwK4HXnx57QqWkJSrbIvjLSwf2dIb9+qkdkU5gYuWr9mE2Ph9THHD9GRIZ0NBQcN4P0Zn
        IKZOx/UisCEppM92GdNfz690Z5b5Y0uKh1EFi8LcbOoovP8igG5ZK03jdqaMiJOAHozB1T
        R3q/BrTCh196vpuJWx+IHmLWVWpM4t2j3mdhHw6Tq67eeYA/KX5rsDKHm1rpYQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        kernel@sberdevices.ru,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v3] mtd: spinand: micron: correct bitmask for ecc status
Date:   Mon, 11 Sep 2023 17:51:43 +0200
Message-Id: <20230911155143.610920-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905145637.139068-1-mmkurbanov@sberdevices.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9836a987860e33943945d4b257729a4f94eae576'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-05 at 14:56:37 UTC, Martin Kurbanov wrote:
> Valid bitmask is 0x70 in the status register.
> 
> Fixes: a508e8875e13 ("mtd: spinand: Add initial support for Micron MT29F2G01ABAGD")
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
