Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC9F7D8799
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjJZReA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZRd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:33:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7348DC1;
        Thu, 26 Oct 2023 10:33:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 05FAD735;
        Thu, 26 Oct 2023 17:33:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 05FAD735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698341636; bh=x58EWngCurg6BZuzfeiK9njHyHbP6dkg4xxTox6g3GQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WjlT0kprjMdxOpD6IYawOkrnRKrDgKM+jKnE9/K2bI4rn5GSNGIbv6P/cSTiOyrWL
         wwrOIf9WRnjLwG++XlBwleUpx1jUwsFzW418Ow+nX1X3bZETJWuTlnfCYc38S4BG3L
         QhEtW22Pra5bRsTel0GAUQvcbn3D9g4RxhbGUsrb0hJqIyyewUP/breSOhDXLdN7iN
         A95OSzvreDaAou1gmrCKjFuAEhKfmBmDrCPPDXJTIa2fMztc3964aDe8sYXtZ4vAHI
         HD3fiYB84yqX3FqNjbc7/TWPTanGLKpeO2kEPjlx0BlEd6C6cxsYF7bbfz3Z0kmRS5
         Lovh4dHr+ijuw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tang Yizhou <yizhou.tang@shopee.com>, houtao1@huawei.com,
        jack@suse.cz, bvanassche@acm.org, kch@nvidia.com
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        yingfu.zhou@shopee.com, yizhou.tang@shopee.com,
        chunguang.xu@shopee.com
Subject: Re: [PATCH v2] doc: blk-ioprio: Bring the doc in line with the
 implementation
In-Reply-To: <20231012024228.2161283-1-yizhou.tang@shopee.com>
References: <20231012024228.2161283-1-yizhou.tang@shopee.com>
Date:   Thu, 26 Oct 2023 11:33:55 -0600
Message-ID: <87jzr970fw.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tang Yizhou <yizhou.tang@shopee.com> writes:

> From: Tang Yizhou <yizhou.tang@shopee.com>
>
> Our system administrator have noted that the names 'rt-to-be' and
> 'all-to-idle' in the I/O priority policies table appeared without
> explanations, leading to confusion. Let's bring these names in line
> with the naming in the 'attribute' section.
>
> Additionally,
> 1. Correct the interface name to 'io.prio.class'.
> 2. Add a table entry of 'promote-to-rt' for consistency.
> 3. Fix a typo of 'priority'.
>
> Suggested-by: Yingfu Zhou <yingfu.zhou@shopee.com>
> Reviewed-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
> v2:
> Accept Bart's suggestion and rename the title of the patch.
> Pick up Tao's Reviewed-by tag.
>
>  Documentation/admin-guide/cgroup-v2.rst | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

I've applied this, thanks.

jon
