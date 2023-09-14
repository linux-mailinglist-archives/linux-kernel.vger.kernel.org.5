Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068437A0A92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbjINQOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbjINQOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:14:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C951FD4;
        Thu, 14 Sep 2023 09:14:40 -0700 (PDT)
Received: from mercury (dyndsl-091-248-132-131.ewe-ip-backbone.de [91.248.132.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE219660734E;
        Thu, 14 Sep 2023 17:14:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694708078;
        bh=oyyTUlng1CRgvxzHHU6jfImAju9hov629yE8WpGHUR8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DCEx0y9HA+cnD0vTGca6Rs/F4GslJ7aY7Q1iwoFjHJL0jKL90bdbafecEbZAVZZzZ
         L7vlrv8bHODHLkRxGEuDtnkg/3/+f/JfABsEU9hD5qnhy4FzlHsrfyZCJbNHcarq/I
         5yRy/he4/FuBvnaRri4lqxS/QAaPDYEHWzfDfUIHh8fh6XIuYNBWV2EXRQ8D3MaquQ
         tKGyjbs7v/TStPngFWxe7cZY3WoLdotC3fKK52hKeIdwa03hJEqeYMrI20lTeegmwU
         3AB7yLg4S55aHu4VKpZibbKLvEx0JmQ3JhJfQbmOzpbkSYZBqZejaXo/9Ylk7c9aHB
         h/11jrTnlDhaQ==
Received: by mercury (Postfix, from userid 1000)
        id E20A6106098B; Thu, 14 Sep 2023 18:14:36 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org
In-Reply-To: <2ed01020fa8a135c36dbaa871095ded47d926507.1676464968.git.christophe.jaillet@wanadoo.fr>
References: <2ed01020fa8a135c36dbaa871095ded47d926507.1676464968.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] power: supply: rt9467: Fix rt9467_run_aicl()
Message-Id: <169470807687.776693.745016394505207164.b4-ty@collabora.com>
Date:   Thu, 14 Sep 2023 18:14:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Feb 2023 13:43:04 +0100, Christophe JAILLET wrote:
> It is spurious to bail-out on a wait_for_completion_timeout() call that
> does NOT timeout.
> 
> Reverse the logic to return -ETIMEDOUT instead, in case of tiemout.
> 
> 

Applied, thanks!

[1/1] power: supply: rt9467: Fix rt9467_run_aicl()
      commit: cba320408d631422fef0ad8407954fb9d6f8f650

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

