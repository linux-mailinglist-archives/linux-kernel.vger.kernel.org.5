Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9799D765740
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjG0PSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbjG0PR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:17:57 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2391BC3;
        Thu, 27 Jul 2023 08:17:54 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23F0FE0004;
        Thu, 27 Jul 2023 15:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690471073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jTWow8XZc1V1a7KC/LzFlJrnEWAhzW/wrrkH2swn2S8=;
        b=XMl/tBrbHfXa8vnxmWSXGcQUMH7v9E48yQOV82dOI0+RP4bIv8m30JmXdM7sjmBs71Rz05
        JnvUCnofD7U+Tmuaw1Xc7o4BeMjqdF6XWiPLIqRDy2BAJ+jNitwFDLEajRamnZnh1Zcfe1
        963PsxOfgiS6SEPTV2DdrVYLtDUEgyIX9V4vW9Rt1GbgkArGFjEB8pSShEw/hwPjuYMRot
        6chrU8KFiaKj7bVCxKUpjXEYKww8LF+o8aMmhKhTX/MO6OdA27/JKnxcalMT0x5Ht47h1m
        lpODmtca/GrCwidxcSTUhWSFFC81RvQcKNSnUSthzWBA0pOIIF7tsEVFE8noWQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtdblock: make warning messages ratelimited
Date:   Thu, 27 Jul 2023 17:17:49 +0200
Message-Id: <20230727151749.586400-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719103354.2829366-1-colin.i.king@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd2236f6219fac62ee22d971e06a04148f4eb8cca'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-19 at 10:33:54 UTC, Colin Ian King wrote:
> When exercising various dev interfaces with stress-ng the mtdblock drivers
> can be (ab)used to generate a lot of warning messages. Make these rate
> limited to reduce the kernel log from being spammed with the same messages.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
