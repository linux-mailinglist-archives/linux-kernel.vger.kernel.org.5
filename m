Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F087B77B284
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjHNHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjHNHbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:31:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3EA18F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BD066150E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87029C433C7;
        Mon, 14 Aug 2023 07:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691998291;
        bh=XytP3I80/0qufxxP+Bp149TyvqLgWEhhNGRMhkFuP8o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lzqPw2AgE4+UGkJStKw9SIJ0h9KJoJx06ku5WLR710wEQlF+qBsw6VLNtMAKiL1fl
         KBlxFLEsJQw+15Lw4m7RgT4xskqKJoR1jjFN2ZtEwTjZUr8qmQBm3ynzs9Fb0X3BrP
         OFHTcjMCjg0g/AMWb83R/ta7GHitcFWnFcDHLx3o+AMsPTkqRUT/6c4LdRCkiINnZW
         j2hShuxqRM0Rw15EaUkpRQGAWjOx8cfyW8wCAxBG6wUF/hRylxx/QsjowN40pq4oY0
         oKLIDi8b2ccFRxyoQr3+4wgrLGEuHZGrTYkSh8zG3JK1bKqScwu+8/X0hNoK/u4nHf
         2knCU6MfrW4zw==
Message-ID: <e3939093-b9f3-d722-d6db-84cd739f9c0c@kernel.org>
Date:   Mon, 14 Aug 2023 09:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Content-Language: en-US
To:     Rohan G Thomas <rohan.g.thomas@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230810150328.19704-1-rohan.g.thomas@intel.com>
 <20230811190032.13391-1-rohan.g.thomas@intel.com>
 <20230811190032.13391-2-rohan.g.thomas@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230811190032.13391-2-rohan.g.thomas@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 21:00, Rohan G Thomas wrote:
> Add dt-bindings for the number of tx queues with coe support. Some
> dwmac IPs support tx queues only for a few initial tx queues,
> starting from tx queue 0.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>

1. Please use scripts/get_maintainers.pl to get a list of necessary
people and lists to CC. It might happen, that command when run on an
older kernel, gives you outdated entries. Therefore please be sure you
base your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

2. Do not attach (thread) your patchsets to some other threads
(unrelated or older versions). This buries them deep in the mailbox and
might interfere with applying entire sets.


Best regards,
Krzysztof

