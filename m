Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A631680E841
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346078AbjLLJyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjLLJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:54:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B74F9B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:54:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57EDC433C7;
        Tue, 12 Dec 2023 09:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702374881;
        bh=g44so0aXENb1ZbYVlFiZWeI/HIvhAHxzBBi5p4XGpb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFs0VsbjwcxWVEkl3pXaSvyYM4X2Whkvb6oF9daOqpon9n89n7CCqsti8gUebdR2R
         +clPMLnHbXFu+jQwf8uQvDs/tq+mKSCExqEkGkjpIROV45xBnjwYIh5V0qlIfRkyq5
         bx6Ythe77BYpy+bOer+3uX6ncBG4HON8uowwMv5zNo6O2J5PwNjmk85saMFDiez1o8
         4S1rKVJcYFWQ99fbKhm4DQgjhg2+U0ShImfMsXbYl+PZ6fq7zAxmg489KMVIr+m9DO
         o3s0GpVg9aia5ugwjeKG33JFwAKTK+j0i5mIPiwMhmqIk8reskp5bMzQA7zDFmjEJW
         iucHoZIM+mC+w==
Date:   Tue, 12 Dec 2023 09:54:35 +0000
From:   Simon Horman <horms@kernel.org>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Josua Mayer <josua@solid-run.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pza@pengutronix.de,
        stable@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] net: rfkill: gpio: set GPIO direction
Message-ID: <20231212095435.GT5817@kernel.org>
References: <20231206131336.3099727-1-r.czerwinski@pengutronix.de>
 <20231207075835.3091694-1-r.czerwinski@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207075835.3091694-1-r.czerwinski@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 08:58:36AM +0100, Rouven Czerwinski wrote:
> Fix the undefined usage of the GPIO consumer API after retrieving the
> GPIO description with GPIO_ASIS. The API documentation mentions that
> GPIO_ASIS won't set a GPIO direction and requires the user to set a
> direction before using the GPIO.
> 
> This can be confirmed on i.MX6 hardware, where rfkill-gpio is no longer
> able to enabled/disable a device, presumably because the GPIO controller
> was never configured for the output direction.
> 
> Fixes: b2f750c3a80b ("net: rfkill: gpio: prevent value glitch during probe")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>
