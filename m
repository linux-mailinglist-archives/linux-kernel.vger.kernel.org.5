Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495F079D7DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbjILRpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjILRpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:45:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B56B10D3;
        Tue, 12 Sep 2023 10:45:49 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 90B5A66057B6;
        Tue, 12 Sep 2023 18:45:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694540747;
        bh=tBS6eK6DfENO3AYG+VbwBlZdVrrirFqHKspcMth63oM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=h+1Pw9ESLCBiVN/u/RCJROWnd/J862oc9zgQAcw7CmLr/qQuu7JvKSCpLDc+cx5kw
         6PqgK+1UVHkHWoiZdIW8uVXM1ihT2OWli8h3z6Bq/FD1Iv+jZnwkPnngqLl2umM+wi
         ZiVORujQ8FfR+1oYeAwPTc9lie/1rXWuw8GCgmhjAP0WsXv5/xpJNvhzB8FORxt/aP
         6QJILPmgTlKcFor+M0DPvtGAfjYS+H8+Na6oisIB92hQ44k1Ywru9udyeY+BJPCnl5
         gVa/iAN7mKFb6ZAiAGtfESmefZQ3SkwoFkThEkoVDviQlvZJQbmSfp7rUtcZtOvJ9L
         7kqAeBzSnTiRQ==
Received: by mercury (Postfix, from userid 1000)
        id 98794106098A; Tue, 12 Sep 2023 19:45:44 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-pm@vger.kernel.org
In-Reply-To: <20230828224201.26823-1-rdunlap@infradead.org>
References: <20230828224201.26823-1-rdunlap@infradead.org>
Subject: Re: [PATCH] power: supply: rt5033_charger: recognize EXTCON
 setting
Message-Id: <169454074457.472024.2491267273794133491.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 19:45:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Aug 2023 15:42:01 -0700, Randy Dunlap wrote:
> CHARGER_RT5033 should honor the EXTCON setting to prevent these
> build errors:
> 
> riscv64-linux-ld: drivers/power/supply/rt5033_charger.o: in function `.L33':
> rt5033_charger.c:(.text.rt5033_charger_probe+0x578): undefined reference to `extcon_find_edev_by_node'
> riscv64-linux-ld: drivers/power/supply/rt5033_charger.o: in function `.L0 ':
> rt5033_charger.c:(.text.rt5033_charger_probe+0x64e): undefined reference to `devm_extcon_register_notifier_all'
> riscv64-linux-ld: drivers/power/supply/rt5033_charger.o: in function `.L96':
> rt5033_charger.c:(.text.rt5033_charger_extcon_work+0x32): undefined reference to `extcon_get_state'
> 
> [...]

Applied, thanks!

[1/1] power: supply: rt5033_charger: recognize EXTCON setting
      commit: 37d1a624cb7934687dd9775f7fea771ae5aadd29

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

