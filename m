Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D236C7F65C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbjKWRwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWRwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:52:30 -0500
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [IPv6:2001:41d0:203:375::b2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B68211F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:52:35 -0800 (PST)
Message-ID: <10c4ae94-525f-4ac1-9d59-80bb4f7d362e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700761953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xOb7IjDCHemslGdU76yEhf/PgAy4hmseLlpzuv6m1Uk=;
        b=rvDAMlYFJTRFccWgNKvskgLlDUt2EAgJ4/69cFY/PQwIb4RbG+p4JSMlgU56VNnRzt7Ej/
        XGTJwyXbrBl07dUi7GAgFTfAovsKn7cIWeKdVhlgQVsEFKFnEjGl2fuWQSpgeGHofR1A+m
        PZ13xFlJRMw+z7THsKTVSDQc9Bh/pyY=
Date:   Fri, 24 Nov 2023 01:52:26 +0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <CAA8EJpoiehS2wS3ri_DggzxeEfLY4yK7X6c+bCFKvkwSce6r+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/11/23 16:08, Dmitry Baryshkov wrote:
>> I'm agree with the idea that drm bridges drivers involved toward to a direction
>> that support more complex design, but I think we should also leave a way for the
>> most frequent use case. Make it straight-forward as a canonical design.
> Not having anything connector-related in the drm_bridge driver is a
> canonical design.

What you said is just for the more complex uses case. I can't agree, sorry.

By choosing the word "canonical design", I means that the most frequently used
cases in practice are the canonical design, 95+% motherboards I have seen has
only one *onboard* display bridges chip. For my driver, I abstract the internal
(inside of the chip) encoder as drm_encoder and abstract the external TX chip as
drm_bridge, this design still works very well.


Originally, I means that this is a concept of the hardware design.
You are wrong even through in the software design context, the
transparent simple drm bridge drivers(simple-bridge.c) also *allow*
to create drm connector manually. I don't think I need to emulate
more example, please read the code by youself.

Canonical or not canonical is not a question to argue, if other programmers
are allowed to do such kind of abstraction, I should also allowed too. Thanks.


