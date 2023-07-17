Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1EC755DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGQIDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGQIDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:03:07 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCC1118
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:03:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so31862835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689580985; x=1692172985;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mdeNKisayMSQ5sRs+4YAy9k9XF+keSCX7tWfhBgjHBA=;
        b=um1dfAWYF83hCHFDWU9q5X16U0ZkvtAllcHfOYPsPJVj4C/XZqrYon4dhclBWO3wCi
         OU8TnrvH1BCSWKz64AQFwd9kkEj/rhGV1pVCS4QtvkSRIgCiFVLMEdJwk7uaao3Q3EP1
         kKbMkCyGitGdz6FaCwZSwCGBBVuPdN/wMEX1mtah8IlPAejb0iQpAlIC1RrlBQdsIij3
         6BV6QydUZdZGWXOpy7zWgl0nx9rFoclww9ntKxptH1m5vLHUvET5KwFqWgvG0Ex6nEcI
         H3MEfjcK2Ra6FSFOYYsLWX8sRpwnFC9+8D+b5AWUbigWk0r23HEc/XHm3k4zPdhrtKDx
         oXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689580985; x=1692172985;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdeNKisayMSQ5sRs+4YAy9k9XF+keSCX7tWfhBgjHBA=;
        b=O+tfAhCxCSndARXTQ6lkzJWPBqCGLm+aYY6W4IqSQroFTQHqXMag2fgg/KQesaueCZ
         E19rQIAHzgatbdkZkYmZQb8lykrQM/E3zN0MuebCyriG3moJoacga7Q3w8RCq79Sp6Vy
         jMS5ecU88FbU+0sCe7NtmgpGCBFfabybZkA5aYxJZLUKKdRonfoTM+JcK6HslcJTXmC3
         iIjueIIwte/+urAtqOGhO3WDq40AdMs3abB4q5jwJFJj/Vhti5MjU7so2APlRrep30xV
         7lpGXFzHdy0ExC4DCNOTfvABXP3EFcyEOLVuwkaLmDvKuWiohXzoRbGBSjjlzmCd5/i5
         fX9Q==
X-Gm-Message-State: ABy/qLauY6N4psh+q7ioVg9hdBHKuCR8lmw05D8oKSct7eiJO7kWziZq
        HO4/itTw/4410A4uFi840lVY3g==
X-Google-Smtp-Source: APBJJlHp2U3lsNaGg3z+QFZ4SFIvM4GFG/+ypv5OlkRYMQGlqT7WeNQn71m1g9Emo2JuD0aRaeXNrg==
X-Received: by 2002:a5d:4389:0:b0:314:11e6:da8a with SMTP id i9-20020a5d4389000000b0031411e6da8amr6847696wrq.1.1689580985136;
        Mon, 17 Jul 2023 01:03:05 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.144.39])
        by smtp.gmail.com with ESMTPSA id x14-20020a5d490e000000b0031423a8f4f7sm18387745wrq.56.2023.07.17.01.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 01:03:04 -0700 (PDT)
Message-ID: <606c6242-3585-0a8d-8257-c185c89e800e@linaro.org>
Date:   Mon, 17 Jul 2023 10:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v6 01/11] KVM: Rename kvm_arch_flush_remote_tlb() to
 kvm_arch_flush_remote_tlbs()
Content-Language: en-US
To:     Raghavendra Rao Ananta <rananta@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Gavin Shan <gshan@redhat.com>
References: <20230715005405.3689586-1-rananta@google.com>
 <20230715005405.3689586-2-rananta@google.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230715005405.3689586-2-rananta@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/7/23 02:53, Raghavendra Rao Ananta wrote:
> From: David Matlack <dmatlack@google.com>
> 
> Rename kvm_arch_flush_remote_tlb() and the associated macro
> __KVM_HAVE_ARCH_FLUSH_REMOTE_TLB to kvm_arch_flush_remote_tlbs() and
> __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS respectively.
> 
> Making the name plural matches kvm_flush_remote_tlbs() and makes it more
> clear that this function can affect more than one remote TLB.
> 
> No functional change intended.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> ---
>   arch/mips/include/asm/kvm_host.h | 4 ++--
>   arch/mips/kvm/mips.c             | 2 +-
>   arch/x86/include/asm/kvm_host.h  | 4 ++--
>   include/linux/kvm_host.h         | 4 ++--
>   virt/kvm/kvm_main.c              | 2 +-
>   5 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

