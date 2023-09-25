Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2647AE0D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjIYVgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjIYVgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:36:48 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21627194;
        Mon, 25 Sep 2023 14:36:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2ACB260007;
        Mon, 25 Sep 2023 21:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695677798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zK2AYyS5AOi31YK4qNe9+ZL3iMbHjy0qxHStfnnY9To=;
        b=IpVwMo/jZcA6bL0LNhouiA7axhgCG84NHJcLXJZ1fg9WcoiobYjsiiUzODnbiZpggMlRRd
        3Z2moSnXvdUwfpbNLhakYZXW57LpE6Zc8F9tKLDW3CF9vhVmE+2K0fErfemjE6HBPAiFgh
        YvoKpte6cdLIV9hs4Y4hx73PCLaAwTZnCa0Po/cHDNFROdlPKGZeERHRYJ/+544Mn6GCHS
        31X642Feh7Jos4sFAGHVx1oN10p/NHq9CuHlxPDiqlaf6XsG9o99yHHwUxCeGdYW9EqXIg
        9FNxToeP0Y6Gz9sIN1BrZejtN3PbNcx99Qv+PirZ/RNCy72wpIl0FwrZVLM2Uw==
Date:   Mon, 25 Sep 2023 23:36:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i3c: replace deprecated strncpy
Message-ID: <169567773733.243402.3288813289063152469.b4-ty@bootlin.com>
References: <20230921-strncpy-drivers-i3c-master-c-v1-1-9fdb8d8169e1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921-strncpy-drivers-i3c-master-c-v1-1-9fdb8d8169e1@google.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Sep 2023 03:51:04 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> We expect adap->name to be NUL-terminated based on i2c_adapter name use:
> | dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
> 
> [...]

Applied, thanks!

[1/1] i3c: replace deprecated strncpy
      commit: fa7726a4d9b91e0a8fb6fbbd819cd20f116f6c21

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
