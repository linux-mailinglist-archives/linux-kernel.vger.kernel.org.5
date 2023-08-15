Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FCD77C73D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjHOFuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjHOFsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7441BF9;
        Mon, 14 Aug 2023 22:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 111FE62054;
        Tue, 15 Aug 2023 05:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF60C433C7;
        Tue, 15 Aug 2023 05:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692078079;
        bh=VPRHeVBgvZf02se9MrMMfU0xdugo14fh/UuUylChyjI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XYhqjQo4YExjQf8+myKGsDnUTCDESm5Iyt118d0ZJKCn8Z8NaL0kvIfHJjO4o2xSs
         QUYjw5J6eL7xb//qSd2tiKB4BWJLEE1Ub4TbXR42Z/CYAp5aAHIVxXuFeUN4DJG46k
         4DAnmokfwt3l8nv5B+kWel9WUkDBPbW4LU6DXBF70OBDsC0x4ung3mx3CL7CsFO6NB
         Lwtv4BIHlW/wyF+mM5oHu5rgME3YY2bMsEj/nXiVLPP+yIDa2IPzS8YoQ8YOirxt4U
         UcFvgTrdd2PIrQz2lRV+1l343N2o/v01i/8M9/0kGNtI2UW2EecrJ5ZkI1NPt1XcX4
         cJRMVdTgIJqVQ==
Message-ID: <7bb37b57-70c2-b752-64fc-fa60bea180e2@kernel.org>
Date:   Tue, 15 Aug 2023 07:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 8/8] spi: add sprd ADI for UMS9620
To:     Jiansheng Wu <jiansheng.wu@unisoc.com>,
        Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yongzhi.chen@unisoc.com, xiaoqing.wu@unisoc.com,
        jianshengwu16@gmail.com
References: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
 <20230815023426.15076-8-jiansheng.wu@unisoc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230815023426.15076-8-jiansheng.wu@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 04:34, Jiansheng Wu wrote:
> This patch adds support for UMS9620.
> 
> Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>

2. Please use scripts/get_maintainers.pl to get a list of necessary
people and lists to CC. It might happen, that command when run on an
older kernel, gives you outdated entries. Therefore please be sure you
base your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

1. Please use subject prefixes matching the subsystem. You can get them
for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
directory your patch is touching.

> ---
>  Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
Best regards,
Krzysztof

