Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E81781978
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 14:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjHSMJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 08:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjHSMJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 08:09:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AB327D07
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 05:07:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B333620E7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 12:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5ECC433C7;
        Sat, 19 Aug 2023 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692446850;
        bh=uB0JnHzXiejfv0M4MrNGL8QVzjFt000qSCYzNyLtA08=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=beZilWfshUdc5rrXhqwXQAmWTvuyOeOyyZyl3V703x+K06LL6TaWiiw5VLb5U7L0W
         XwaFr9fjYC+pQchU5eMGAL44CCWupaA8QZQWlxqqTwi475X6s+xYY+QPmXv5J60Wka
         fcpGwnjbRkR2k/MbEvjoTrniLfQJSmA+cASzNUxyNTsPxRaydrKilqz0LyuhfytmwD
         oXW5X+VSXhDbaZwIgge1czglJq8Y67pfcXe3+9CIBYvMEC9yBFOz+MdlBBPkQYsPSR
         8kYeXoW357ZJeERyk+TDU8zTgh/3CsVwGY8zZgENqhJOU0kfncQ3H8aTd1/icyqSrj
         VxounB7TgZbxA==
Message-ID: <18e246df-c82d-7405-be0e-3b9b02bb8494@kernel.org>
Date:   Sat, 19 Aug 2023 14:07:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/7] dt-bindings: nvmem: Add compatible for sharkl3,
 ums512, qogirl6, qogirn6pro, qogirn6lite
Content-Language: en-US
To:     Yanxin Huang <yanxin.huang@unisoc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org,
        huang yanxin <yanxin.huang07@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
References: <20230819055141.29455-1-yanxin.huang@unisoc.com>
 <20230819055141.29455-2-yanxin.huang@unisoc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230819055141.29455-2-yanxin.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2023 07:51, Yanxin Huang wrote:
> Added unisoc sharkl3, ums512, qogirl6, qogirn6pro, qogirn6lite platform
> compatible information.
> 
> Signed-off-by: Yanxin Huang <yanxin.huang@unisoc.com>
> ---

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

