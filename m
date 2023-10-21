Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590767D1A18
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjJUAxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjJUAxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:53:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC65E10C0;
        Fri, 20 Oct 2023 17:53:15 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 74700660734F;
        Sat, 21 Oct 2023 01:53:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697849594;
        bh=J/N/iVD+wc6dz/BxIvLp1pOeheB2VoCW51rXkqVrKC8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MgZ/nAglAtJ2LQRiwqmxOW/44PcfTLKLCHOuVB7m/dF8rplrAYqK4qE+SSh6tukrT
         OjVh3V/M4G5Z53yjI8lYIZPqr6Aca0TByZEOlOr9C8Zc7VLYemiUa15F52qWEXKVXW
         awdPI8XUhE56tUrxQwYxTXwsYKhY/iKg1BSnLNi6EUpT8rusLdhc1Q0vBmgHErT1W+
         cCy/rEYRGQCVf0QJtn4jXVOEnOl6Iq5CPyV7iXdz55E9loU1q9Ub9u+20o/YolzDf+
         GcyMeMTZzPV4/yPgrgqKFQ3tVIOGx1jlCsxIFOOkVpJkccp2uVtwQzOx/C0FKeunhr
         3dCcC+6JYvEtA==
Received: by mercury (Postfix, from userid 1000)
        id 386CA1066142; Sat, 21 Oct 2023 02:53:11 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20231020-strncpy-drivers-power-supply-charger-manager-c-v1-1-698f73bcad2a@google.com>
References: <20231020-strncpy-drivers-power-supply-charger-manager-c-v1-1-698f73bcad2a@google.com>
Subject: Re: [PATCH] power: supply: charger-manager: replace deprecated
 strncpy with strscpy
Message-Id: <169784959122.1512524.17275327804996893357.b4-ty@collabora.com>
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


On Fri, 20 Oct 2023 19:21:46 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect cm->psy_name_buf to be NUL-terminated based on its usage with
> format strings:
> 1522: cm->charger_psy_desc.name = cm->psy_name_buf;
> ...
> 1587: dev_err(&pdev->dev, "Cannot register charger-manager with name \"%s\"\n",
> 1587:   cm->charger_psy_desc.name);
> 
> [...]

Applied, thanks!

[1/1] power: supply: charger-manager: replace deprecated strncpy with strscpy
      commit: e1402bd297a3477c16eca4c1e4094372237f40a7

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

