Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32787F2B94
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjKULUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKULUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:20:49 -0500
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [IPv6:2001:41d0:203:375::b6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF6AA2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:20:45 -0800 (PST)
Message-ID: <34cb7d4b-58f8-446e-9259-0a234380213c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700565641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHtu2kRGZ0LH/N1X/PWWwv28B3GR8jL1BL7Ou5Resek=;
        b=E4cYMZzxGTT+jZuSXOCoi6zxlnj9qBGTVtIOSMsTXn360AHqjKYPwfZKL2zlb4b0riYh+e
        +RoFh7jo2nNMUZQ5R+Um4UO4WeKvyIeaavqHdRgsyFp3WZN5U1E3QWSHIKTGE6l9zdND5i
        GVBme3DO7/FqpqE+2p8TnktcHUfUA+Y=
Date:   Tue, 21 Nov 2023 11:20:38 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v2] dpll: Fix potential msg memleak when genlmsg_put_reply
 failed
Content-Language: en-US
To:     Hao Ge <gehao@kylinos.cn>, arkadiusz.kubalewski@intel.com
Cc:     jiri@resnulli.us, michal.michalik@intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <0c6e0cd5-d975-41cc-824e-10b5e28251a2@linux.dev>
 <20231121013709.73323-1-gehao@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231121013709.73323-1-gehao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 20:37, Hao Ge wrote:
> We should clean the skb resource if genlmsg_put_reply failed.
> 
> Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
> v1 -> v2: change title due to add some similar fix for some similar cases
> ---
>   drivers/dpll/dpll_netlink.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)

Thanks!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

