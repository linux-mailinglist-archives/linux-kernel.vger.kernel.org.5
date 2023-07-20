Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C3175A549
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGTFA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGTFAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:00:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A811FD2;
        Wed, 19 Jul 2023 22:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 419AD60DF8;
        Thu, 20 Jul 2023 05:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8CCC433C8;
        Thu, 20 Jul 2023 05:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689829253;
        bh=gG1PUyDbiv08IroS+c/PuiKcQWGA+npOWsj4A+MBR30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRjr2J9Jbm5gXy0imjOOafgBUGEKS7hokwJrY8lO5jRI9NAAUwVpuFXlUiqtqPgQ3
         zb7+eulB1U6Z4BKFuGkz5E2cZIUYw1gOltuHkWwtYbSY+/KydzJjPBiu3nHzhTJxI6
         3iCRdyB3fZPmTAxmp1A5suhcue+FsWzmxX5U8vRzI0CW02yvNFoeKMP/ZfqwjxzrhI
         /babfP58zZ4Go7UCe7EvI6hNzLeOOkWsgdyDlI+8LPv3zuop/FitTluSPVbIZSmB+F
         3RDXmbuYBcfuXf2NFV8zQirby3K2D3MxUhIWLSG51eTE9rh+PZutvngzqCU+HuPtY4
         JlovMMISBZHWg==
Date:   Thu, 20 Jul 2023 13:00:50 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Barnes <robbarnes@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the chrome-platform tree
Message-ID: <ZLi/gg2HLgwt5JR3@google.com>
References: <20230720124611.45b25256@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720124611.45b25256@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 12:46:11PM +1000, Stephen Rothwell wrote:
> After merging the chrome-platform tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: modpost: "emergency_sync" [drivers/platform/chrome/cros_ec_lpcs.ko] undefined!
> 
> Caused by commit
> 
>   a6edd5f5d9cc ("platform/chrome: cros_ec_lpc: Emergency sync filesystem on EC panic")
> 
> I have used the chrome-platform tree from next-20230719 for today.

Thanks for reporting.  I have dropped the commit from chrome-platform for-next
branch.
