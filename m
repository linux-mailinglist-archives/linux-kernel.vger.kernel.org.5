Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB47F63F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjKWQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjKWQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:29:51 -0500
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A7310D5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:29:57 -0800 (PST)
Message-ID: <d3a6e1df-cb2c-4d8c-a4ad-c9df6f68dd6e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700756995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OvZq7up+PPvAW4sGoG6+g/5iaMGk3fIhaBZ9sHchUQc=;
        b=Q6vOvRswfZc7dJeYZkIP0jS8oUTNG3/pt6Sq/97jrBqjIVRqHFSUZqptOfPyzwIi5cc9Dc
        tClFVBPLfMQ+YV1hZdb9+vpSwfE5nqjGezk5hJaDJMIZDsWv5oxMMrGMrn9x/9JLthu0M/
        FbXZQRTGhgNX7mtSjcAtZsBc4HeyXpw=
Date:   Fri, 24 Nov 2023 00:29:49 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 8/8] drm/bridge: it66121: Allow link this driver as a lib
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev>
 <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <79301d04-c0cb-4740-8a6d-27a889b65daf@linux.dev>
 <CAA8EJpom5kAbDkacOdqp6BR7YPfmCSXaQfDYRVcLf9eGmi64CQ@mail.gmail.com>
 <121163c9-0d56-47ad-a12e-e67390fef2b4@linux.dev>
 <CAA8EJpowjhX=LL-9cnQL4pfCei63zNkCGW5wGOeeFxcnFpNCVA@mail.gmail.com>
 <00ba2245-0e48-4b21-bcd4-29dfb728e408@linux.dev>
 <CAA8EJpoiehS2wS3ri_DggzxeEfLY4yK7X6c+bCFKvkwSce6r+A@mail.gmail.com>
 <963d7722-738f-4e46-bfb7-131027ca5341@linux.dev>
 <CAA8EJpoTWoSYjyZL7ARQiAeWabcXymy6f-tAzPM3YO=C_GOOZw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJpoTWoSYjyZL7ARQiAeWabcXymy6f-tAzPM3YO=C_GOOZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/11/24 00:06, Dmitry Baryshkov wrote:
> On Thu, 23 Nov 2023 at 17:41, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>> Hi,
>>
>>
>> On 2023/11/23 16:08, Dmitry Baryshkov wrote:
>>>> The semantics of DRM_BRIDGE_ATTACH_NO_CONNECTOR flag are implement-defined,
>>> No, they are not. Semantics are pretty simple: do not create the
>>> drm_connector instance. Pass the flag to the next bridge in the chain.
>>
>> Then, my problem is that do we allow create a drm_connector instance in drm bridge
>> driver nowadays?
> Yes, if there is no DRM_BRIDGE_ATTACH_NO_CONNECTOR. But that's deprecated IMO.

Then can you read the code in bridge/ti-tfp410.c please?
The tfp410_attach() function will create drm_connector instance manually
if the conditional (flags == 0) is true.

