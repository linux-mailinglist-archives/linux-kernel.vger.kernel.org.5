Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184BA7EF705
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346166AbjKQRgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346146AbjKQRga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:36:30 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E89D7E;
        Fri, 17 Nov 2023 09:36:26 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E30E8240008;
        Fri, 17 Nov 2023 17:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700242585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I6bVBs9+UlVN0UI83TPgVQSNAbRu17WJB14lmY0HUcc=;
        b=V6sxxrZ9FJ89mYPVhAz6mQLGwa9riLme0SOt3HQ71JxYLpSUcaYu0gdKl3W9kohV4KuxFI
        Uk5MHuml1f4GY/XYG1fsiIgKHcpvzOEZIDSyvpaFVL+ht1bvWPjY+Z5zx2N2WrcgoDXogV
        XvVR4J5hKr0yGNzVBQ5fwO0XMjgzWnm0whSiA9uBFH7UC4nYhgRoU+khjueFpXMnfvUoCB
        Xtijs1UllHTgppj9FZ+Q7eF1HuynX9A3HZMIHG2ATRdd3B8jX0xrE4gcXnqYefRnPkoD0k
        iG26md8wuM3xJrXfbvWQIHXjjYCujcU5d1k+h75zrjWe0TPlvw8Hn7FBhkg34g==
Date:   Fri, 17 Nov 2023 18:36:24 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        alvin.zhuge@gmail.com, renzhamin@gmail.com, kelvie@kelvie.ca,
        rrangel@google.com
Subject: Re: [PATCH] rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
Message-ID: <170024256921.406260.15395632233007933060.b4-ty@bootlin.com>
References: <20231106162310.85711-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106162310.85711-1-mario.limonciello@amd.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Nov 2023 10:23:10 -0600, Mario Limonciello wrote:
> Intel systems > 2015 have been configured to use ACPI alarm instead
> of HPET to avoid s2idle issues.
> 
> Having HPET programmed for wakeup causes problems on AMD systems with
> s2idle as well.
> 
> One particular case is that the systemd "SuspendThenHibernate" feature
> doesn't work properly on the Framework 13" AMD model. Switching to
> using ACPI alarm fixes the issue.
> 
> [...]

Applied, thanks!

[1/1] rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
      commit: 3d762e21d56370a43478b55e604b4a83dd85aafc

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
