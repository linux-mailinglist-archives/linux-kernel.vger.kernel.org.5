Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67E279E200
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbjIMIZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbjIMIZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:25:57 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B33B5E73;
        Wed, 13 Sep 2023 01:25:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EE9418088;
        Wed, 13 Sep 2023 08:25:52 +0000 (UTC)
Date:   Wed, 13 Sep 2023 11:25:51 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-omap@vger.kernel.org, aford@beaconembedded.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] bus: ti-sysc: Fix missing AM35xx SoC matching
Message-ID: <20230913082551.GF5285@atomide.com>
References: <20230906233442.270835-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906233442.270835-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Adam Ford <aford173@gmail.com> [230907 02:34]:
> Commit feaa8baee82a ("bus: ti-sysc: Implement SoC revision handling")
> created a list of SoC types searching for strings based on names
> and wildcards which associates the SoC to different families.
> 
> The OMAP34xx and OMAP35xx are treated as SOC_3430 while
> OMAP36xx and OMAP37xx are treated as SOC_3630, but the AM35xx
> isn't listed.
> 
> The AM35xx is mostly an OMAP3430, and a later commit a12315d6d270
> ("bus: ti-sysc: Make omap3 gpt12 quirk handling SoC specific") looks
> for the SOC type and behaves in a certain way if it's SOC_3430.
> 
> This caused a regression on the AM3517 causing it to return two
> errors:
> 
>  ti-sysc: probe of 48318000.target-module failed with error -16
>  ti-sysc: probe of 49032000.target-module failed with error -16
> 
> Fix this by treating the creating SOC_AM35 and inserting it between
> the SOC_3430 and SOC_3630.  If it is treaed the same way as the
> SOC_3430 when checking the status of sysc_check_active_timer,
> the error conditions will disappear.
> 
> Fixes: a12315d6d270 ("bus: ti-sysc: Make omap3 gpt12 quirk handling SoC specific")
> Fixes: feaa8baee82a ("bus: ti-sysc: Implement SoC revision handling")

Applied into fixes now, thanks

Tony
