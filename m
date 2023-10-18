Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8D37CD3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbjJRFt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJRFt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:49:26 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01329BA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6UsnL94RoCPgeTX9ccivn8yeLwPhEKD4FoOoPKRV430=;
  b=ZU7HGQjbE8tnfSJZSD2Jp1UwDXjoEi8OiEjyY1hZihrJ6bz4RgD7QSk3
   GTFUT1O4HHTuCKKtkWO7KDnWIhBwBFDfUC5cEKCqdiJWu5VuHC5vzVZpO
   HVrJlKGX6u62byQfMcQaL1spy0x5tkSip0IchcY/c5KLk+coPaT4gDTYY
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,234,1694728800"; 
   d="scan'208";a="69015402"
Received: from unknown (HELO hadrien) ([87.129.180.234])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 07:49:23 +0200
Date:   Wed, 18 Oct 2023 07:49:22 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Soumya Negi <soumya.negi97@gmail.com>
cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 0/2] staging: vme_user: Replace printk's & cleanup log
 messages
In-Reply-To: <cover.1697601942.git.soumya.negi97@gmail.com>
Message-ID: <85af8b2d-6246-46c5-c6dc-582807010fa@inria.fr>
References: <cover.1697601942.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Oct 2023, Soumya Negi wrote:

> Staging driver vme_user has a bunch of printk() calls in vme.c which
> triggers checkpatch warnings. Remove all printk's and change them to
> the appropriate logging mechanism i.e pr_err()/pr_warn(), or
> dev_err()/dev_warn().
>
> Also, cleanup the messages further by using __func__ in the string
> instead of function names.

"cleanup" is not actually a verb.  It's a noun.  The verb would be clean
up.

julia

>
> This patchset fixes all checkpatch warnings like:
>
>     WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
>              dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> &
>     WARNING: Prefer using '"%s...", __func__' to using 'vme_lm_get',
>              this function's name, in a string
>
> Patches must be applied in order.
>
> Soumya Negi (2):
>   staging: vme_user: Replace printk() with pr_*(),dev_*()
>   staging: vme_user: Use __func__ instead of function name
>
>  drivers/staging/vme_user/vme.c | 175 ++++++++++++++++++---------------
>  1 file changed, 94 insertions(+), 81 deletions(-)
>
> --
> 2.42.0
>
>
>
