Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D420177EDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347133AbjHPXEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347134AbjHPXDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:03:44 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A6C2705;
        Wed, 16 Aug 2023 16:03:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3077C0002;
        Wed, 16 Aug 2023 23:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692227008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wdw4rxYQOSoWap4Dy/YjhgEEkk3/DkKeHRVnfH7gppk=;
        b=EDrGyXX68UQeJXymOb5/35ck+eLxKEiD2I/kqiiwmPo9E4atpO6ksjZqMYmqo8CJYKxmCI
        inpcVjYvBrZmfVYWh7YMMkLz3PMB1GFfhSxAbL3zi8IxuKS/OkGWkd3/dQmb1hYZ+HBkVL
        7568hdUkTidfJSrUP/uYXrjJZnhWrttDsuYUnwJlbBISNFxMlLN9uO98Zo8MhvfzwFNvXO
        f974ZKe7Z5hegeiUG7aOundzor5PQzJMzJabL6wUmpamOJX51iGz+37ZfGM6ABxmSnDrDV
        bVANs+LvZGRejjuIUikolON7k2gcs77aqlDHVVFO38jJBiEASpXILKgwJoVgNw==
Date:   Thu, 17 Aug 2023 01:03:24 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hugo@hugovil.com>
Cc:     Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] rtc: pcf2127: add error checking when
 disabling POR0
Message-ID: <169222693690.116276.11657105955678173166.b4-ty@bootlin.com>
References: <20230728171211.3016019-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728171211.3016019-1-hugo@hugovil.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Jul 2023 13:12:12 -0400, Hugo Villeneuve wrote:
> If PCF2127 device is absent from the I2C bus, or if there is a
> communication problem, disabling POR0 may fail silently and we
> still continue with probing the device. In that case, abort probe
> operation.
> 
> 

Applied, thanks!

[1/1] rtc: pcf2127: add error checking when disabling POR0
      commit: e4163fc59d088caf3250cc9c9862239a954d85b5

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
