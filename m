Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CBA76E6AE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjHCLUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjHCLUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:20:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1695C127;
        Thu,  3 Aug 2023 04:20:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A294261D3A;
        Thu,  3 Aug 2023 11:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D68C433C8;
        Thu,  3 Aug 2023 11:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691061601;
        bh=+3V8C5BQdIdgwVUKpiLRTY0NHNKdE8QV8AYMJx7EgrI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N4SGXLXrL5rK7usEapdpQYnO2z2godCFTseipW+0m4nPOast0y94w58iFLkZA6CZX
         rnHwXPft3U4+gDwqvSoNlJ+1mYrP+oE72O4j3nlW9tOX6KqDRJSzhpwrkxjKSJFEQI
         w1CBg5jtIaePxsSyF+aybRMd4kcoLQWCg4P7gK3tqC1phoOT2D21LRDBhAyVVG+3Oj
         bo9DMeWXckw0oYlHBcNeuJMgHqOnQBneXXTL5cfKV3ouJ8DO53TgYQ3TugS0yzNPzK
         Su07rngVRS1wIE3t1Y495OGXabf/EqFbdv36d7VmIG1uI1F6AfEwml7Y1XRe//ZrrL
         3If7XqFvxjxOw==
Message-ID: <579c3ab0-8595-10f4-e257-d4c67c11dbb3@kernel.org>
Date:   Thu, 3 Aug 2023 13:19:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v4 1/3] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
Content-Language: en-US
To:     Hari Nagalla <hnagalla@ti.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, p.zabel@pengutronix.de,
        martyn.welch@collabora.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230801141117.2559-1-hnagalla@ti.com>
 <20230801141117.2559-2-hnagalla@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230801141117.2559-2-hnagalla@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 16:11, Hari Nagalla wrote:
> K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
> The remote processor's life cycle management and IPC mechanisms are
> similar across the R5F and M4F cores from remote processor driver
> point of view. However, there are subtle differences in image loading
> and starting the M4F subsystems.
> 
> The YAML binding document provides the various node properties to be
> configured by the consumers of the M4F subsystem.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
> 
> Changes since v1:
>  - Spelling corrections
>  - Corrected to pass DT checks

I don't think so.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Best regards,
Krzysztof

