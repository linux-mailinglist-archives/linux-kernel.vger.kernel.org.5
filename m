Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAC07D1A1E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjJUAxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJUAx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:53:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5760D6A;
        Fri, 20 Oct 2023 17:53:22 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DE7956607354;
        Sat, 21 Oct 2023 01:53:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697849597;
        bh=WQtMmmdfFYxzlLqdJLNkwqz7BRAwlXLZctRc3du2U0k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fvlq2Ap9K9hHaUlhVNXjwcrhWDHHgXpWATJi2ha/KmS1qDYfDPdmsk2jFWUfPFza8
         CsXsMWu3ziYDqHUPetKg1OcEHsc7KpO2l7GYO9/V8/siNCJdaCG8clagnv3Ju+xzKz
         aw1SFb11b6X3BsmP6aJKLamF+vkMiriXz9QQG9EpbDBOaULSoYOBngWhuyZiWIlPOV
         ENtKG4/lMzhl59u/OY9qD4m8h39czyRepi7irKlcSlLENC420AsH6Z+C3L2dTR92lq
         tj4jZWnxAvBZvticqho2WXgOT6Tg72S1J7kV0YnuxP1iR/rF7g0ZZ5Pu4udFwSoSvm
         aMQF2o2nOFNrQ==
Received: by mercury (Postfix, from userid 1000)
        id 3F6481066144; Sat, 21 Oct 2023 02:53:11 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20231020-strncpy-drivers-power-supply-surface_charger-c-v1-1-93ddbf668e10@google.com>
References: <20231020-strncpy-drivers-power-supply-surface_charger-c-v1-1-93ddbf668e10@google.com>
Subject: Re: [PATCH] power: supply: surface-charger: replace deprecated
 strncpy with strscpy
Message-Id: <169784959125.1512524.2877665109633637893.b4-ty@collabora.com>
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


On Fri, 20 Oct 2023 19:46:11 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect ac->name to be NUL-terminated based on its usage with format
> strings:
> 
> [...]

Applied, thanks!

[1/1] power: supply: surface-charger: replace deprecated strncpy with strscpy
      commit: afc88dfda013970bb1e214b331e99adca2f98312

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

