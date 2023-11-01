Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E287DDA83
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376924AbjKABHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345068AbjKABHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:07:20 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A041C9;
        Tue, 31 Oct 2023 18:07:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VvIt0M9_1698800833;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VvIt0M9_1698800833)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 09:07:14 +0800
Date:   Wed, 1 Nov 2023 09:07:12 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Gerd Bayer <gbayer@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Jan Karcher <jaka@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix documentation of buffer sizes
Message-ID: <20231101010712.GD92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20231030170343.748097-1-gbayer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030170343.748097-1-gbayer@linux.ibm.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 06:03:43PM +0100, Gerd Bayer wrote:
>Since commit 833bac7ec392 ("net/smc: Fix setsockopt and sysctl to
>specify same buffer size again") the SMC protocol uses its own
>default values for the smc.rmem and smc.wmem sysctl variables
>which are no longer derived from the TCP IPv4 buffer sizes.
>
>Fixup the kernel documentation to reflect this change, too.
>
>Fixes: 833bac7ec392 ("net/smc: Fix setsockopt and sysctl to specify same buffer size again")
>Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

>---
> Documentation/networking/smc-sysctl.rst | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
>index 6d8acdbe9be1..769149d98773 100644
>--- a/Documentation/networking/smc-sysctl.rst
>+++ b/Documentation/networking/smc-sysctl.rst
>@@ -44,18 +44,16 @@ smcr_testlink_time - INTEGER
> 
> wmem - INTEGER
> 	Initial size of send buffer used by SMC sockets.
>-	The default value inherits from net.ipv4.tcp_wmem[1].
> 
> 	The minimum value is 16KiB and there is no hard limit for max value, but
> 	only allowed 512KiB for SMC-R and 1MiB for SMC-D.
> 
>-	Default: 16K
>+	Default: 64KiB
> 
> rmem - INTEGER
> 	Initial size of receive buffer (RMB) used by SMC sockets.
>-	The default value inherits from net.ipv4.tcp_rmem[1].
> 
> 	The minimum value is 16KiB and there is no hard limit for max value, but
> 	only allowed 512KiB for SMC-R and 1MiB for SMC-D.
> 
>-	Default: 128K
>+	Default: 64KiB
>-- 
>2.41.0
