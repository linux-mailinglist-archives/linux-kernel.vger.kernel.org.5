Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DEA793278
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 01:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbjIEXW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 19:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243012AbjIEXWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:22:53 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B68DA3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 16:22:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A7AE1BF204;
        Tue,  5 Sep 2023 23:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693956164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Z5k5pcEAmV+x04SFylcHWHzG1422bRUlUrcZZqHpFs=;
        b=duTfldYCBRDx3ye6CtIFuo2m+CXefBdkyyozx5RcPYVEHhDjOLtW7WVfnry78hR3lKoO5G
        g4brDe73FyZ5qBp/lTvd8V4AJ1wDYosulJ2poI5NZLmiBXgzw2FcWJ04CPXmBq4xxWlIfh
        Z/YeCVORyvtE2qnxhyxG9EOZblDyJYvN07jiq0My1ftDVRmqIe/Kwi3kapag0+YyB9UaZB
        LWeEk1gPxdosjjK8Cp1fk1yL7eZGKDQPX71sjxLHmSD1yY/RwgCuXgTW2XeTqX3aOsOWav
        BKSbJji2EUudDwImspqAi82ImuGhqtW2IgHL3cQY/UqVxBY1KMCSFLtSaDgmqA==
Date:   Wed, 6 Sep 2023 01:22:43 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     miquel.raynal@bootlin.com, Frank Li <Frank.Li@nxp.com>
Cc:     Frank.li@nxp.com, conor.culhane@silvaco.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] i3c: master: svc: fix probe failure when no i3c
 device exist
Message-ID: <169395611478.302281.14031067702798801687.b4-ty@bootlin.com>
References: <20230831141324.2841525-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831141324.2841525-1-Frank.Li@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Aug 2023 10:13:24 -0400, Frank Li wrote:
> I3C masters are expected to support hot-join. This means at initialization
> time we might not yet discover any device and this should not be treated
> as a fatal error.
> 
> During the DAA procedure which happens at probe time, if no device has
> joined, all CCC will be NACKed (from a bus perspective). This leads to an
> early return with an error code which fails the probe of the master.
> 
> [...]

Applied, thanks!

[1/1] i3c: master: svc: fix probe failure when no i3c device exist
      commit: 6e13d6528be2f7e801af63c8153b87293f25d736

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
