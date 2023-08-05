Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BF477130B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 01:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjHEXsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 19:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHEXsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 19:48:11 -0400
X-Greylist: delayed 135 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Aug 2023 16:48:10 PDT
Received: from p3plsmtpa12-09.prod.phx3.secureserver.net (p3plsmtpa12-09.prod.phx3.secureserver.net [68.178.252.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B280138
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 16:48:10 -0700 (PDT)
Received: from localhost ([82.27.99.45])
        by :SMTPAUTH: with ESMTPA
        id SQy1qnynsZmOZSQy2qqIFq; Sat, 05 Aug 2023 16:45:54 -0700
X-CMAE-Analysis: v=2.4 cv=IqXYMpzg c=1 sm=1 tr=0 ts=64cedf32
 a=YwMIiW7BGddQzL8MrqPWMg==:117 a=YwMIiW7BGddQzL8MrqPWMg==:17
 a=HnRLSJNhp8-NwZYesygA:9 a=zgiPjhLxNE0A:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     tj@kernel.org
Cc:     atomlin@atomlin.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Date:   Sun,  6 Aug 2023 00:45:52 +0100
Message-Id: <20230805234552.2556114-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <ZMwPZ7jRUrq6MjLn@slm.duckdns.org>
References: <ZMwPZ7jRUrq6MjLn@slm.duckdns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAkRaHrhRP8xW5Bcul32+ZgpRA7YcgchZIFNzzk8yLiUiMSSE7Hn+i5miErHP7MB49ykr76NXVtkgOICVTFexHQCIJ8UK2uOH8gMLUnxkJFYeIA5dW5c
 Ynoak9S8PpRpXjvZHJ08TiRQQ0UbyK7AyFDy6mcKQ5Y2mcy2eFUlWiHvAOpnkh5hu/swVrsIfYiBXejoVe4o9ztxwSuKh7z85zmOJtaGX157WSrx8uN+IQ1d
 vTds+4SE+6zOS5LZh6Ebmun72geDJToMx2c0X2+1wkzUD7pmxr6dOyM8kxmNI7O7HykC5cu4pSiOaWT2KGcn3w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that the name changes to the work item the worker is currently
> executing. It won't stay that way. Workers are shared across the
> workqueues, so I'm not sure "identify and account all kernel threads" is
> working as well as you think it is.

Hi Tejun,

Indeed. The point is that these kworker kthreads are easily identifiable.

> We can certainly rename them to indicate that they are rescuers - e.g.
> maybe krescuer? But, at the moment, the proposed reason seems rather
> dubious.

Personally, I would prefer "kworker/r-%s" and then include the specified
workqueue's name e.g. "kworker/r-ext4-rsv-conver". So the rescuer task's
name is more consistent with the current naming scheme.
I will send a follow up patch.


Kind regards,

-- 
Aaron Tomlin
