Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63CF7F6333
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346140AbjKWPlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjKWPlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:41:46 -0500
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C585CD72
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:41:49 -0800 (PST)
Message-ID: <963d7722-738f-4e46-bfb7-131027ca5341@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700754107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JJ0ck28jqIOzp4io8XWiyXgfc4nf53TOe/9aEXVvNlk=;
        b=mEmshErGxbeMN3PnifUtMAG67QbYoD/OqlFLbIrsdBZszXAocZezFo8494X99/DPlGgwyP
        BvJj3uy9TyND4lQr6ztv6M+PUaVHKziTaA4NVbhRijdUOCkSMGHS+Lj+h3xVeEG0DAiAZu
        ABBhil9/iv2jUUdmWVaY6GjDuuwQTzw=
Date:   Thu, 23 Nov 2023 23:41:35 +0800
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/11/23 16:08, Dmitry Baryshkov wrote:
>> The semantics of DRM_BRIDGE_ATTACH_NO_CONNECTOR flag are implement-defined,
> No, they are not. Semantics are pretty simple: do not create the
> drm_connector instance. Pass the flag to the next bridge in the chain.


Then, my problem is that do we allow create a drm_connector instance in drm bridge
driver nowadays?

