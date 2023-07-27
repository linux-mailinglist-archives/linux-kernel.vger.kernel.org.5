Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754F9765DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjG0VNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjG0VNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:13:48 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB68D30E3;
        Thu, 27 Jul 2023 14:13:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D74C61BF209;
        Thu, 27 Jul 2023 21:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690492425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ICP7QruovvJZMT9MsB6asg3zuA+Hv+TdzoNUmf2wZsg=;
        b=eZif2qUy/f1CP77FP0RTtPDZyfjoH0dj1+FcrJ54ZJ2MPulbzN6nLXBCAgxhzJzpEwOe7o
        IxIrdMUfBwXWodUagm+/8eE7O11v3fgCzrRNQOWFVKcGphzU2kcPmPtM1+JmvQ4xG8fpp2
        4o28xO0h2nCkzKiUGUDf8exAWGNtaf8ztybdbWwA8O4WXXu06axwJ/c31c9x+3ZMK+SvT5
        ygSsG0qYQaYE0DVa5D8DyyQuepwtA5FHRceHsCc0TrG44lb51c/uDzYvLTL/SieCXf9UGe
        F3O360Og7WZ8zMgDuM3HuJwCQZbvyLTW0IsQUjhxVIVRIgRFhNSnTJYlLAc7Tg==
Date:   Thu, 27 Jul 2023 23:13:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, Andrej Picej <andrej.picej@norik.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@phytec.de
Subject: Re: [PATCH v3] rtc: rv3028: Add support for "aux-voltage-chargeable"
 property
Message-ID: <169049240059.468125.18081485399820108743.b4-ty@bootlin.com>
References: <20230623081533.76334-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623081533.76334-1-andrej.picej@norik.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Jun 2023 10:15:33 +0200, Andrej Picej wrote:
> Property "trickle-resistor-ohms" allows us to set trickle charger
> resistor. However there is no possibility to disable it afterwards.
> 
> Add support for "aux-voltage-chargeable" property which can be used to
> enable/disable the trickle charger circuit explicitly. The default
> behavior of the code is kept as it is!
> 
> [...]

Applied, thanks!

[1/1] rtc: rv3028: Add support for "aux-voltage-chargeable" property
      commit: 3c87b351809f220294aec3c0df7b078ff5c5b15b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
