Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587727B975A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjJDWQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjJDWPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:15:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E44DD;
        Wed,  4 Oct 2023 15:15:50 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 01C596607298;
        Wed,  4 Oct 2023 23:15:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696457749;
        bh=ErJEinqA3Yd4mjr/MKIR5qSX9umwYJo+OcjxmI6xLeQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TX7g40FaCchftuZpT3aeuStoLp9otzFjElulHO+x4fHY4+aQ7goDLaSywzQZ8o5Gu
         Av56B9cQpw3AqQhMpZSyYJ7HmH6WzS8sOMnbsYxvUjM0r7UJLh8CDLKHRBN0Kq0n+j
         O2Kfq9F7DwZBK/nU0MaMnCZIgII5ScS/t05e1DT7XKUTX+oCivYAxtTGOQVUSXjAj4
         HLhHm4QXFzIzWKvzt5+4MEU73Zls1Az3Kzu9+8xIJizJ+ZoJwpUdl3SvuVcWBsmz6t
         ikBoxzSOWjbGxiwKiLh3vdL+cwFN2jsPsXut9GvQBgw7HVgiyvj0osbRQ5Ii7v6pTp
         54N1KN+lllYzg==
Received: by mercury (Postfix, from userid 1000)
        id 32355106052C; Thu,  5 Oct 2023 00:15:46 +0200 (CEST)
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
In-Reply-To: <cover.1696165240.git.jahau@rocketmail.com>
References: <cover.1696165240.git.jahau.ref@rocketmail.com>
 <cover.1696165240.git.jahau@rocketmail.com>
Subject: Re: [PATCH v2 0/3] Remaining patches for RT5033 charger
Message-Id: <169645774618.491546.6491124646485805371.b4-ty@collabora.com>
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


On Sun, 01 Oct 2023 15:17:41 +0200, Jakob Hauser wrote:
> This series adds the missing patch "Add cable detection and USB OTG supply"
> to the RT5033 charger driver. The patch didn't make it with the initial
> series [1].
> 
> In the meantime, two fixes patches [2][3] were squashed into that patch.
> Additionally there are two clean-up patches, which are patches No. 2 & 3
> in this series.
> 
> [...]

Applied, thanks!

[1/3] power: supply: rt5033_charger: Add cable detection and USB OTG supply
      commit: 8242336dc8a8009b93fb7c4506d79a8c894b3583
[2/3] power: supply: rt5033_charger: Simplify initialization of rt5033_charger_data
      commit: 1c6877f1768a34c04e3a82f9f950f78488a1753b
[3/3] power: supply: rt5033_charger: Replace "&pdev->dev" by "charger->dev" in probe
      commit: 3f26d8b6d1cbd41c5fa663c9ea48a2b832cfb58f

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

