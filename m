Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A0D7D1A1A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjJUAxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjJUAx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:53:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BEAD69;
        Fri, 20 Oct 2023 17:53:22 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DE8546607355;
        Sat, 21 Oct 2023 01:53:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697849597;
        bh=95P2EWFUKRCbCZzx5BnicmzGP6FSI+AsQsx9+1qnEVo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WoVUZj7Ab9vIsbbb/vgpCdm//2z2FvhRZHBzt+0paEKhVmgfsj1YHwvc8JCK9rWLA
         lWuah8qoeJiNPoLMkq9jpztZiYECDfkb+uF4vSqu/30DeDx9819ZYUVuGqefClWfEM
         yMqb6TU3AYYcIQhk81T3w2ke9OydOGRhvNsRz0BtfOpW7ThsNEFK6jLsapWffbTezI
         TMXXzDSxpxo6u2KA5wtpB7sXvCNbeXTRpv970fi3SCSAcn4g4EC5PUoTPMdD6eCDyV
         xEZj4GCmB3B56W3X7rwQQ3l1hrodYgpL/xqBZPUycRmoqJ5A8ptUX6IlXzx18Mrq5L
         A3c8PBPqFt0Rw==
Received: by mercury (Postfix, from userid 1000)
        id 3C9C11066143; Sat, 21 Oct 2023 02:53:11 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20231020-strncpy-drivers-power-supply-surface_battery-c-v2-1-29ed16b2caf1@google.com>
References: <20231020-strncpy-drivers-power-supply-surface_battery-c-v2-1-29ed16b2caf1@google.com>
Subject: Re: [PATCH v2] power: supply: surface_battery: replace deprecated
 strncpy with strscpy
Message-Id: <169784959123.1512524.16039657676124942354.b4-ty@collabora.com>
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


On Fri, 20 Oct 2023 19:39:02 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect bat->name to be NUL-terminated based on its usage with
> strcmp():
> 
> [...]

Applied, thanks!

[1/1] power: supply: surface_battery: replace deprecated strncpy with strscpy
      commit: 81f07d2b0c4db3b6e53d90419db915c75beb6326

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

