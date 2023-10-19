Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4837CF681
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbjJSLTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjJSLTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:19:20 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBDA112;
        Thu, 19 Oct 2023 04:19:18 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 795EE100068; Thu, 19 Oct 2023 12:19:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697714355; bh=J+Sc0dS6j12A8ZgfTiTjAS5ZcNj0Wm7WCiB2Bh+oyCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSfOh75zKV7LMfO0/8Rr6+Pg1VS9Q4B8vW+LR88S5V77xS7GAlJRkIRaR5TzuHjKB
         5xRDqygm8CUvihrf7UDO/B52ZGPGLx2w7n0e4ZT0PaaJgddadOeNgEbYSks5wZw73h
         VHHfQT53ZkZsrm7Lwcwi3ASuPkTKYWA2RKqkZ2OmLNZV2IHuvy+lO+hkWgB8vn0wz2
         GBC8WIizSz9CMy1ryLuVj7Tu4RgPr1IiU8oKTN4alNTkHQmBUNH2KCzsnhgMOVRevy
         6yObP1EKk3grMPBfL4iaP928T77L83z5agBBz9ykPWsPKpoP6IVCRom03TBpeNUpRQ
         iXlkKx1rY2yMw==
Date:   Thu, 19 Oct 2023 12:19:15 +0100
From:   Sean Young <sean@mess.org>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] pwm: bcm2835: allow pwm driver to be used in
 atomic context
Message-ID: <ZTEQszOAEybWPrCO@gofer.mess.org>
References: <cover.1697534024.git.sean@mess.org>
 <c826281c0ceab8ce8fcc453a5ce777444349ff9a.1697534024.git.sean@mess.org>
 <53534015-07ab-4d43-8dcb-be3a08ee6339@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53534015-07ab-4d43-8dcb-be3a08ee6339@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 05:00:23PM +0200, Stefan Wahren wrote:
> Hi Sean,
> 
> Am 17.10.23 um 11:17 schrieb Sean Young:
> > clk_get_rate() may do a mutex lock. Since the clock rate cannot change on
> > an rpi, simply fetch it once.
> the driver changes looks good to me, but could you please adapt the
> commit message to your recent changes.

Yes, the commit message needs fixing. Thanks for pointing that out.


Sean
