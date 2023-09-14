Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986BA7A0A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbjINQDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241718AbjINQDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:03:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D51BDD;
        Thu, 14 Sep 2023 09:03:12 -0700 (PDT)
Received: from mercury (dyndsl-091-248-132-131.ewe-ip-backbone.de [91.248.132.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 246C0660734C;
        Thu, 14 Sep 2023 17:03:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694707391;
        bh=Lpo0D5uC86cqxCrdA6YYcvZKX2y1l4IotVy9sVD5T/I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fD6F73IQ9Q7/RyvDWXsECQ4MTFg4+R1Gp7rA5B8bfbOfTsrATd53jT7h99w4VXRGA
         wXthMaAOQ8M6NwD64yiK5g/o4nJeZZwnv8AuUqPaHBhLJ0UBfujxOX1kiJHnBjs1sK
         loLXb24hpyHy1Cn9T/Q7UYB69K6RmSH0ZrG+iaxSE8UeWhF58o4y3+HFvSiKb9FcPM
         gvKaWojS6OXvR+s9UMOexS4E4RkGzDYl6Ur1VOjthX9ATXTkDOE/Lg9DXI1ZPwm7QX
         Yqf3VVNZZXlDL1E/H2QiVH9Tj8bafsMly0M+EZEbg5wiwMy1TMzYK3uhQ5Pr+EGRbq
         9SxbUvjF+w9Ug==
Received: by mercury (Postfix, from userid 1000)
        id 920D6106098B; Thu, 14 Sep 2023 18:03:08 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, stable@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230612143651.959646-2-frattaroli.nicolas@gmail.com>
References: <20230612143651.959646-2-frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH] power: supply: rk817: Add missing module alias
Message-Id: <169470738858.752995.6010965090137450989.b4-ty@collabora.com>
Date:   Thu, 14 Sep 2023 18:03:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Jun 2023 16:36:52 +0200, Nicolas Frattaroli wrote:
> Similar to the rk817 codec alias that was missing, the rk817 charger
> driver is missing a module alias as well. This absence prevents the
> driver from autoprobing on OF systems when it is built as a module.
> 
> Add the right MODULE_ALIAS to fix this.
> 
> 
> [...]

Applied, thanks!

[1/1] power: supply: rk817: Add missing module alias
      commit: cbcdfbf5a6cd66e47e5ee5d49c4c5a27a07ba082

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

