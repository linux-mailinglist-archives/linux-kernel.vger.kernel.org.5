Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CD5780B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376624AbjHRLXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376641AbjHRLWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:22:35 -0400
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBC4449F;
        Fri, 18 Aug 2023 04:22:13 -0700 (PDT)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
        by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 90689427C1;
        Fri, 18 Aug 2023 13:22:11 +0200 (CEST)
Message-ID: <49c2e556-fd75-751e-3b0c-c51c3245f94c@proxmox.com>
Date:   Fri, 18 Aug 2023 13:22:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: "Use slab_build_skb() instead" deprecation warning triggered by
 tg3
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org
Cc:     siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        jdelvare@suse.com, Guenter Roeck <linux@roeck-us.net>,
        netdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
        keescook@chromium.org,
        Linux Regressions <regressions@lists.linux.dev>
References: <1bd4cb9c-4eb8-3bdb-3e05-8689817242d1@proxmox.com>
 <ZN9SId_KNgI3dfVI@debian.me>
From:   Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ZN9SId_KNgI3dfVI@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.08.23 um 13:12 schrieb Bagas Sanjaya:
> On Fri, Aug 18, 2023 at 10:05:11AM +0200, Fiona Ebner wrote:
>> Hi,
>> we've got a user report about the WARN_ONCE introduced by ce098da1497c
>> ("skbuff: Introduce slab_build_skb()") [0]. The stack trace indicates
>> that the call comes from the tg3 module. While this is still kernel 6.2
>> and I can't verify that the issue is still there with newer kernels, I
>> don't see related changes in drivers/net/ethernet/broadcom/tg3.* after
>> ce098da1497c, so I thought I should let you know.
>>
> 
> Thanks for the regression report. I'm adding it to regzbot:
> 
> #regzbot ^introduced: ce098da1497c6d
> #regzbot link: https://forum.proxmox.com/threads/132338/
> 
> PS: The proxmox forum link (except full dmesg log pasted there) is in
> German, so someone fluent in the language can be helpful here.
> 

At the moment, there is not much other text: The user says that they got
the trace after a recent upgrade, but cannot notice any real problems
and I'm telling them that it's a deprecation warning and that I reported
it upstream. If I should ask for some specific information, please let
me know :) But not sure if more information from the user is even
required here or if the fix will just be similar to the one in
8c495270845d ("bnx2x: use the right build_skb() helper").

Best Regards,
Fiona

