Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE3E7A55E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjIRWqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIRWqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:46:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E909A4;
        Mon, 18 Sep 2023 15:45:42 -0700 (PDT)
Received: from mercury (dyndsl-091-248-188-252.ewe-ip-backbone.de [91.248.188.252])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 50E09660716C;
        Mon, 18 Sep 2023 23:45:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695077140;
        bh=mOg55t4zvHvyfb/la24WLWBUuXyIqC8RacSuosSLqRk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RN8gevYLEnooD2ecaVFFm9ejemdynVjNDsaVQN3x3v56we/uhVJJhu1iyX5hBGOdX
         QUpHh9E3HGALgRVVOCuENmriEgXbH73cfnISBr7L/m7jT0N2zlnXp1XH0HMKKJrKEt
         o5KiZc8E5u9QALJVyn5MoidGAQNuSmYykmWNYLDjGvU5huMtVtgkFjCQrTC31wiZDO
         YE/mSKmVzy0avcx9ZcNA0++tpGYHbtOoMgzv0ZN1W7DtitbdB3fREIpH8H2DmZ20Zr
         XPWihbl8KvXHef+KQy1QJwPGHidNwR0OFwTC3IDSxFfxhScV4qaqJfnNLMdwrcwzpL
         Z/dfefqFrgMnw==
Received: by mercury (Postfix, from userid 1000)
        id AFBFB106098F; Tue, 19 Sep 2023 00:45:37 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Nikita Travkin <nikita@trvn.ru>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
In-Reply-To: <20230918205825.25864-1-rdunlap@infradead.org>
References: <20230918205825.25864-1-rdunlap@infradead.org>
Subject: Re: [PATCH] power: supply: pm8916_lbc: observe EXTCON config
 setting
Message-Id: <169507713770.1098783.11759491213013567471.b4-ty@collabora.com>
Date:   Tue, 19 Sep 2023 00:45:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Sep 2023 13:58:25 -0700, Randy Dunlap wrote:
> When CONFIG_EXTCON=m and CONFIG_CHARGER_PM8916_LBC=y, there are
> build errors. Fix them by having CHARGER_PM8916_LBC depend on the
> setting of EXTCON.
> 
> aarch64-linux-ld: drivers/power/supply/pm8916_lbc.o: in function `pm8916_lbc_charger_state_changed_irq':
> pm8916_lbc.c:(.text+0xe8): undefined reference to `extcon_set_state_sync'
> aarch64-linux-ld: drivers/power/supply/pm8916_lbc.o: in function `pm8916_lbc_charger_probe':
> pm8916_lbc.c:(.text+0x638): undefined reference to `devm_extcon_dev_allocate'
> aarch64-linux-ld: pm8916_lbc.c:(.text+0x650): undefined reference to `devm_extcon_dev_register'
> aarch64-linux-ld: pm8916_lbc.c:(.text+0x688): undefined reference to `extcon_set_state_sync'
> 
> [...]

Applied, thanks!

[1/1] power: supply: pm8916_lbc: observe EXTCON config setting
      commit: a6c6a5fe2a08172c2e045588531f0e05a6c296cf

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

