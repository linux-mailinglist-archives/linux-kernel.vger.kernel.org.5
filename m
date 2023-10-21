Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8517D1A1C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjJUAxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjJUAxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:53:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB45D7E;
        Fri, 20 Oct 2023 17:53:15 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 64E616607337;
        Sat, 21 Oct 2023 01:53:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697849594;
        bh=YoZOTGL/RGBwXV8TmpGCsyQF9OtErh2EOHQgUYwMmLA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=j2jRoGlLqCWCVt1rry/ZH+gUKllDXDsx4+RP/tV0dQlNbfra2TiXpHX9vYutbq4za
         1+3PSnOyrUSjaJXhFezPy0T/f9OVnSA7xw0r4ASgfPJLqp3kzf1tMj5LZ32T5q5p1Y
         Ij1idS0XEqfsv3ivHsWNuNdDjmZadtFM8/kypcCZaeEGTeMSN7+/Y8jW934vwBKxDI
         tmj3N6JSmVaJtLqdrYN6TsFfn3M8SDk2pwQZQeBe7DZbpqCwxJDHPp2XdUGWAjwQ+Y
         A0aFfEONU9IHkMhjtTnXkNMdXpbalzNp/0rhRgXdiw6uB9bZzIJQ7ZvsWWk0yjkkj+
         0A4BzarBoLKkg==
Received: by mercury (Postfix, from userid 1000)
        id 3323D1066140; Sat, 21 Oct 2023 02:53:11 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20231020-strncpy-drivers-power-supply-bq256xx_charger-c-v1-1-2fad856124f9@google.com>
References: <20231020-strncpy-drivers-power-supply-bq256xx_charger-c-v1-1-2fad856124f9@google.com>
Subject: Re: [PATCH] power: supply: bq256xx: replace deprecated strncpy
 with strscpy
Message-Id: <169784959119.1512524.17254965326687207581.b4-ty@collabora.com>
Date:   Sat, 21 Oct 2023 02:53:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Oct 2023 19:05:25 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect bq->model_name to be NUL-terminated based on its usage with
> sysfs_emit and format strings:
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq256xx: replace deprecated strncpy with strscpy
      commit: 056a75599f5e676d497bbf9b29157877f542e56b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

