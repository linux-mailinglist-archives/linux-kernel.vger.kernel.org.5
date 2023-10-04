Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CA17B97B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjJDWP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjJDWPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:15:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D59DC;
        Wed,  4 Oct 2023 15:15:50 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 01BD56603102;
        Wed,  4 Oct 2023 23:15:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696457749;
        bh=UIpsvEZ26qfWuenvkEOeVfrU00xtr6/HMv6lQKe0Mic=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PXre0MckpV+HAmptOUwnBmxJSdurI3//2iT7HZWpYd7fkmRskOynW4x6f6YQ5oodG
         tY5TIo4qq8Z6txW5cXpCzozl90egr6N00tJ5MO83VVpriZrYFlDm0SCsZnxgD5Px/6
         fdRT2WIwv1gh2VP6d/BnlTPwekhDCPy1VnaD9ihGfu9tSk6UOEss6TcS3yigTdb8ae
         v1RURMHpsgSj2lvHIoM6zgxn+8RzBu+tu3PfB2JfRuYuG67BihMvL0ZCwUNBwtgg1i
         53x1p3E1Qn/y3uJy3udG6Y4+nADl2SQs8ZJOEXiNuRFcXXybRpktZm5moqMugqfgx4
         BY6WfT5C1CxsQ==
Received: by mercury (Postfix, from userid 1000)
        id 2EF8C106052D; Thu,  5 Oct 2023 00:15:46 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Jakob Hauser <jahau@rocketmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <cover.1695844349.git.jahau@rocketmail.com>
References: <cover.1695844349.git.jahau.ref@rocketmail.com>
 <cover.1695844349.git.jahau@rocketmail.com>
Subject: Re: (subset) [PATCH 0/5] Remaining patches for RT5033 charger
Message-Id: <169645774615.491546.6765395659132862212.b4-ty@collabora.com>
Date:   Thu, 05 Oct 2023 00:15:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Sep 2023 22:25:57 +0200, Jakob Hauser wrote:
> This series collects remaining patches for the RT5033 charger driver.
> 
> The patches are based on 6.6-rc1.
> 
> Mailing list links where the patches were taken from:
>  - Patch 1
>    https://lore.kernel.org/linux-next/20230821125741.3a2474d7@canb.auug.org.au
>  - Patch 2
>    https://lore.kernel.org/linux-pm/cover.1684182964.git.jahau@rocketmail.com/T/#m27164a05bbe2ec649be1fc32157b34ba814ff31f
>  - Patch 3
>    https://lore.kernel.org/linux-pm/20230822030207.644738-1-yangyingliang@huawei.com/T/#u
>  - Patches 4 & 5
>    https://lore.kernel.org/linux-pm/cover.1686948074.git.jahau@rocketmail.com/T/#u
> 
> [...]

Applied, thanks!

[4/5] power: supply: rt5033_charger: Simplify initialization of rt5033_charger_data
      commit: 1c6877f1768a34c04e3a82f9f950f78488a1753b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

