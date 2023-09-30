Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC47B4384
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 22:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjI3U2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 16:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjI3U2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 16:28:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE667E6;
        Sat, 30 Sep 2023 13:28:18 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F81466072A4;
        Sat, 30 Sep 2023 21:28:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696105697;
        bh=gp02ydvSAYoJwU1pztBoDmdfx1Rdol+wtGtkHuTzNdY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PCrzBNG77u7f359Eg3YFqM4uAUhZcNZr9t/zYn70ofsJeyT0WpM0KkmSvrRnBdaGH
         u9F085IWI1qEfen7bo4B6JFqD0HshUYAkntxFERxjbqrfLPa8NvnhIUjILNnh4Db85
         wkc2Yoe4ZsF2BnyIrK+ez9KMri+gbKxw9+t8Gjy7Tlq/Qp6x8dbqJ7HAecboV/TqcO
         ESTaUtZnfVXcghG9VfyDw07xexe6p70oBGdEgS3yNYow4UbKcO5nrwl87lx/S4hzIe
         0ALvvP1K47N+PtoH4YudrwkzrSmVudy5PX8mniz4cLO3zBdrI3aHJH08HbunrF2GIZ
         7ep1AhT2HroYA==
Received: by mercury (Postfix, from userid 1000)
        id 29DD910605D9; Sat, 30 Sep 2023 22:28:15 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230929-power_supply-string_lower-v1-1-3141a2634d53@weissschuh.net>
References: <20230929-power_supply-string_lower-v1-1-3141a2634d53@weissschuh.net>
Subject: Re: [PATCH] power: supply: core: remove opencoded string_lower()
Message-Id: <169610569516.214910.6033808058669103520.b4-ty@collabora.com>
Date:   Sat, 30 Sep 2023 22:28:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 29 Sep 2023 19:39:00 +0200, Thomas Weißschuh wrote:
> string_lower from string_helpers.h can be used to modify the string
> in-place.
> Use it to get rid of the custom str_to_lower().
> 
> 

Applied, thanks!

[1/1] power: supply: core: remove opencoded string_lower()
      commit: 0ce51459c8353b2b18ad3a430dbebf29af8b579c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

