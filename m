Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0281073D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378056AbjLMBEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbjLMBEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:04:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ADDCD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:04:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDBCC433C7;
        Wed, 13 Dec 2023 01:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1702429451;
        bh=jRcmunZdqVBmgZMSHxQNvJLJyp5lE+HoxqkjQbHila0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YzLp10HiNGQQh48rlwTPWhlzYHA6aJfjJ4OHqBKS9Faq932M0p81NqelJe7ebmO2c
         7gl1qZjDGQ856AONb2cJrM/yJlW4O/izBup9U8UbpTRT3+cxHnbcCQ31ncdd2vJ2qG
         sDAZhde3WHFYxsu9JVmfg/QZMPN7jzhNpvI5TONg=
Date:   Tue, 12 Dec 2023 17:04:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
Message-Id: <20231212170410.aa6972217ef0478f1dc9ae57@linux-foundation.org>
In-Reply-To: <20231213075919.311c962b@canb.auug.org.au>
References: <20231213075919.311c962b@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 07:59:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> In commit
> 
>   fa28adea6a65 ("mm: thp: Fix build warning when CONFIG_SYSFS is disabled")
> 
> Fixes tag
> 
>   Fixes: fe2c9313a8c0 ("mm: thp: Introduce multi-size THP sysfs interface")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 17e9a3099850 ("mm: thp: introduce multi-size THP sysfs interface")

Yes, but the base patch is in mm-unstable so its hash changes every day.

I'll just remove the hash:

Fixes: ("mm: thp: Introduce multi-size THP sysfs interface")

which I expect will generate another hello-from-Stephen.  
