Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08675A53A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 06:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGTEwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 00:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGTEwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 00:52:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750551FD2;
        Wed, 19 Jul 2023 21:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F9BC615B1;
        Thu, 20 Jul 2023 04:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A469FC433C9;
        Thu, 20 Jul 2023 04:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689828721;
        bh=7TbDUsUukO1LpqXo6tscnU+zFqndDe5MtEgKqzBF4wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4N30eizvLE2/YjI53y2ZnV8mWuaafqWheMpSpqMCNhHu2xg99DhNTRM589czEBsI
         Vjfzm0I8dmyWwyWXrWD5vsfgmO3XqYIRmBis6GSQPBK88mLGNHyB15ESXxQc0Z/d5f
         dnA1irvzjEUxvkq/T1zzmEZmPmhBGfEntg8jSwzDv45xaiAL9JKnb0GcbrFVLIcZVk
         CY/MfJ3SYzQ1Z0IKf+6x/Lcao2nj9lsrjX62QFIQgd7i9w7JFy4PpL2REgoCMTJB/l
         ALUh6+qOirJMNvImkHki2hLq6zUMb2O89lcQW7cQPXGyr1ZFFoTIoGuFtBDZ6Fvzgr
         BMNuzioX+Y7Tg==
Date:   Thu, 20 Jul 2023 12:51:58 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Barnes <robbarnes@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the chrome-platform tree
Message-ID: <ZLi9bpof0KwqXD7H@google.com>
References: <20230720124611.45b25256@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720124611.45b25256@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
branch until a fix is seen.
