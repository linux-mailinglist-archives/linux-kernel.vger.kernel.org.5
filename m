Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA07637CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjGZNjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjGZNjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7201739
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15FE461AC3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 13:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B370C433C8;
        Wed, 26 Jul 2023 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690378770;
        bh=6GBJtmUypkdS/Ca5ddXll226wYiHkTQifYI+0BRaeao=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=poX8rfcmEq3YT6H6OcTJPN8qCKy+aiR+yKfH95wry/bDsmiFZy0MoydfV7ZBBjOsQ
         VD0Y3ztk1KMnkyzUT9C+jG/D/AZCwyMFhWGcPscbw7hFDXIcTLS7A3dIuG6eoS0Ch3
         KVfeef05K5Cu49DsKK5VUV9+KEWIxrd5sYo1r36tto6sLv5twIeoN3WJO+GAYuXqFL
         ObR+vtKB/sr76q3dpV0jdui/e/p2ZCf2VE0lHQS8nmYJjr6P4wdQpw0zvD1kVaKKM+
         2ReULNXvdJ31LXTARMds7U24XHYGFIbygGPmlWUPgipEezM72VC2qbg5jZxyVPAHlu
         G4qdEXKjR7gLg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Roger Quadros <rogerq@kernel.org>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <12097f6107a18e2f7cfb80f47ac7b27808e062c4.1690300076.git.geert+renesas@glider.be>
References: <12097f6107a18e2f7cfb80f47ac7b27808e062c4.1690300076.git.geert+renesas@glider.be>
Subject: Re: [PATCH] phy: starfive: StarFive PHYs should depend on
 ARCH_STARFIVE
Message-Id: <169037876811.26143.7183354703555625191.b4-ty@kernel.org>
Date:   Wed, 26 Jul 2023 19:09:28 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Jul 2023 17:49:27 +0200, Geert Uytterhoeven wrote:
> The various StarFive PHYs are only present on StarFive SoCs.  Hence add
> a dependency on ARCH_STARFIVE, to prevent asking the user about these
> drivers when configuring a kernel without StarFive SoC support.
> 
> 

Applied, thanks!

[1/1] phy: starfive: StarFive PHYs should depend on ARCH_STARFIVE
      commit: e7379477f4478c290be47cde3ad8a39d5ff561d2

Best regards,
-- 
~Vinod


