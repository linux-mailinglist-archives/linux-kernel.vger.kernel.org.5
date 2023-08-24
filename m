Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133FB78646C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbjHXBE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbjHXBEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:04:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BCA101;
        Wed, 23 Aug 2023 18:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C51363BBA;
        Thu, 24 Aug 2023 01:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88F3C433C8;
        Thu, 24 Aug 2023 01:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692839089;
        bh=7irFKvrUWbJgoOVMhkGNrs8wK7fU9Q7/eAW1MtLZD04=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L/lXJxXVeDNTcbKQBh4sv4dkc3q1Z24uD5UlD/Q5z7FtGdyuIfP0/BVrP0kWAaspT
         bJoi+y+eO8HzqWepPd1aEyORf82sOEBnLqz3TVwIOILb0+wT1SphTiwzCTI3E+TJwo
         7Z8bokSCtQTkCtNt1+/JlVAIjSHJOtT/gG6gMGPu0+WwQGe0SUuFp7CV6gzHpkFw4z
         Xi+GdTjYNBJ4ny0jc95SHUdMiyaKUofgn4NoSpcdhLM4+xmaLES1koXDT1zJ7Hfj2w
         k7pFxEChrsYUvv9hAvqKNC7OYHXIm6+J5n4rG81xHGMxjKDpYNTyelWfNCt+HF4nty
         CsAoDizZDem2w==
Message-ID: <e304f322-bda7-a28a-1c4d-86480fcc606a@kernel.org>
Date:   Wed, 23 Aug 2023 18:04:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arc: Explicitly include correct DT includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230714173949.4038981-1-robh@kernel.org>
 <20230823170025.GA2470216-robh@kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20230823170025.GA2470216-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/23 10:00, Rob Herring wrote:
> On Fri, Jul 14, 2023 at 11:39:49AM -0600, Rob Herring wrote:
>> The DT of_device.h and of_platform.h date back to the separate
>> of_platform_bus_type before it as merged into the regular platform bus.
>> As part of that merge prepping Arm DT support 13 years ago, they
>> "temporarily" include each other. They also include platform_device.h
>> and of.h. As a result, there's a pretty much random mix of those include
>> files used throughout the tree. In order to detangle these headers and
>> replace the implicit includes with struct declarations, users need to
>> explicitly include the correct includes.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>   arch/arc/plat-axs10x/axs10x.c | 1 -
>>   1 file changed, 1 deletion(-)
> Ping!

Sorry this fell through cracks, added to for-curr now !

Thx,
-Vineet
