Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36407D1A12
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJUAx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjJUAxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:53:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB867D7F;
        Fri, 20 Oct 2023 17:53:15 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 593116607332;
        Sat, 21 Oct 2023 01:53:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697849594;
        bh=n+cp6ATKcN+tRvhf+29E1cAWuHZDFud0FRdhecmVEyc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RrxEtuH3C4f6Vch/+SimF3XL4qNqVaVQVY++iL8EDB+zvWHlOxoIxHQvJSrFCHetc
         lF364MHWTdFYSPAgAF2cvy9sKkdOGWTMmD1y9+4FNySwCs6AGC+Fl8WMYN/eAZcKAc
         3UPI/eXYpAr/HR3p/+SlXTPnqclFQ7bvAz8R1/Bp+7yc0l6agFmLJrlwza7qGSgCaW
         UBV5+o6sk5N27Dx300e8GjbQhMaXTWVxKKy5tVgbLpvqZhOd/u21AoXmO7ZNSmWH6z
         vA9vs35uS5eiXWYrzbosDa57sBtMFD2RbAsspoOq0JSsIt2HXrjL5eTDpYjXdbaHlb
         lk0goFfEfWMmg==
Received: by mercury (Postfix, from userid 1000)
        id 2DC55106061E; Sat, 21 Oct 2023 02:53:11 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20231020-strncpy-drivers-power-supply-bq24190_charger-c-v1-1-e896223cb795@google.com>
References: <20231020-strncpy-drivers-power-supply-bq24190_charger-c-v1-1-e896223cb795@google.com>
Subject: Re: [PATCH] power: supply: bq24190_charger: replace deprecated
 strncpy with strscpy
Message-Id: <169784959113.1512524.17628671686184916927.b4-ty@collabora.com>
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


On Fri, 20 Oct 2023 18:14:47 +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect bdi->model_name to be NUL-terminated based on its usage with
> sysfs_emit and format strings:
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq24190_charger: replace deprecated strncpy with strscpy
      commit: b0009b8bed98bd5d59449af48781703df261c247

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

