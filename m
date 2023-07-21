Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4A575C417
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGUKLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGUKLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C682171A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C11ED60C6D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD37CC433C7;
        Fri, 21 Jul 2023 10:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689934272;
        bh=Og6dYNFo6r+p40Vl2/CzNSsEFtjuUHHzY564GTompQY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=otyAwT+2Krh0ZKKvuVWmoB3cUAxYd687ztyhGeY+sW7VKv6tqDWNFK+mC0SZhWcoW
         O08eM2Ao9kD5RruBvgiaYE60ltVXVKTUABV2w9Pm+uluM/YQ64oJUHQZXx59sN5wXH
         FXSGvIAXcjHXRi4+eQ3023Mk5fodqrSz0iVaT3PINkm43MBcloQHn3WplT4dfVAssc
         YgZTYJPP9BqE9Oa2ZAnH0l5OWCVb1ZxTo1RU/kLcY8qxTqQviC2u3Vu9o+VRZ5ME3K
         s9i+bwY+nQkgM7UxjVg2vGZeGGVWUhNcfoOaprxvBZxDoZhpfu/ixOcex5kkNP8o/O
         AR3o4zSeA+6xQ==
Message-ID: <e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org>
Date:   Fri, 21 Jul 2023 12:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2] dt-bindings:
 net: snps,dwmac: Add description for rx-vlan-offload
Content-Language: en-US
To:     Boon@ecsmtp.png.intel.com, Khai@ecsmtp.png.intel.com,
        "Ng <boon.khai.ng"@intel.com,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Boon Khai Ng <boon.khai.ng@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@intel.com>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Leong Ching Swee <leong.ching.swee@intel.com>,
        G Thomas Rohan <rohan.g.thomas@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-2-boon.khai.ng@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230721062617.9810-2-boon.khai.ng@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 08:26, Boon@ecsmtp.png.intel.com wrote:
> From: Boon Khai Ng <boon.khai.ng@intel.com>
> 
> This patch is to add the dts setting for the MAC controller on
> synopsys 10G Ethernet MAC which allow the 10G MAC to turn on
> hardware accelerated VLAN stripping. Once the hardware accelerated
> VLAN stripping is turn on, the VLAN tag will be stripped by the

Subject prefix is totally bogus.


> 10G Ethernet MAC.
> 
> Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
> Reviewed-by: Shevchenko Andriy <andriy.shevchenko@linux.intel.com>

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

