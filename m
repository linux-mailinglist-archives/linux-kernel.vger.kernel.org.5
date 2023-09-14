Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBA37A0986
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbjINPmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240961AbjINPmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:42:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A5D99;
        Thu, 14 Sep 2023 08:42:14 -0700 (PDT)
Received: from mercury (dyndsl-091-248-132-131.ewe-ip-backbone.de [91.248.132.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E7DCB660727E;
        Thu, 14 Sep 2023 16:42:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694706133;
        bh=b3WOb1uGDFt0IdxghELoF5bLCGKcPAe4bvnXM/jp+U0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AnVdVV8c/DNZKuwHpmVv/IlLfRbeoXn0jdKN3Nx9cIHwKcuznyBC7jKjG/1bDQFsx
         OkfsWn2Zr/w3NxcxCcYGdnexKaV+vg/z3Ci3K17Cj16NTGr0LAHsQJNCPE+DzTNcBl
         u37D/ehG67JV8Szz8lLzJcBgBZyX5abn4Isb4GbppNZ6CGCzRMoszYfJ8UEGuYnGVW
         0le7WeBXio9FOxL1a9JxVf23FFiguDQqwQya4ebAWQ0Z7rpUVRNdfiw7tj084++Xt8
         trXvhwCggdpv9rj6S7vLFwk0W1J6Wv138qPQ9bLowRHkqLHmC30FkScOEQIi1PuPz/
         xtZbiXFbVmnJA==
Received: by mercury (Postfix, from userid 1000)
        id 0D6DE106098B; Thu, 14 Sep 2023 17:42:11 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stefan Hansson <newbie13xd@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
In-Reply-To: <20230731073613.10394-1-clamor95@gmail.com>
References: <20230731073613.10394-1-clamor95@gmail.com>
Subject: Re: (subset) [PATCH v3 0/4] Add optional properties to MAX17040
Message-Id: <169470613104.705505.7085807512019934835.b4-ty@collabora.com>
Date:   Thu, 14 Sep 2023 17:42:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 10:36:09 +0300, Svyatoslav Ryhel wrote:
> Extend properties supported by max17040 fuel gauge if it is accompanied
> by different devices.
> 
> If max17040 is coupled with a charger, pass charger status since it should
> match and max17040 has no dedicated status detection ability.
> 
> max17040_get_online can be reused for PRESENT property since if it is
> online it must be present.
> 
> [...]

Applied, thanks!

[3/4] power: max17040: get thermal data from adc if available
      commit: 814755c48f8b2c3e83b3c11535c48ab416128978

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

