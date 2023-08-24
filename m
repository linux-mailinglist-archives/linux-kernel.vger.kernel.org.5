Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A73E786765
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbjHXGU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239967AbjHXGUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:20:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3230410F7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:20:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-529fb2c6583so6102069a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1692858005; x=1693462805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZTMp7fSbHFRbvTgphA7lDpRJ/hhLv6otAO2ZJDpDK8=;
        b=OJJGvOM3gwU2+NVLAra05qN3U43KBkg9pxcpRR7+/JhRPxol7coNYQmdghA25qiuH3
         hD6JV16rZCiy4VXBEFpL8Fsu0shAJPEcaMb0TMyyzGC9arVi/lsh8e9UBERAVb0O7sHq
         IYX14B4Ku9CtCQy2zIpXHHGen6D9eGQgcqcomeg6ZmtZw9zh5LuS27yNPl0jk94I8ABb
         u5p7cbZaUBs42ArIZ90LEftzSwTvhnOb9E/DhNptuH7V+IzWgOFBUjpNyFHySBWRT2mb
         E1j03rjv7/QlDXnXnYsYDfAGKkzpCtOFAqKtzPKLbk7W3JuDXWyXxftiPMBsmvONUYtj
         D2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692858005; x=1693462805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZTMp7fSbHFRbvTgphA7lDpRJ/hhLv6otAO2ZJDpDK8=;
        b=iRODVZN5nc+YONQiX8c7oNToRfzbYghxVBrix7MziUy12mHdd21zlKqPa5CqcB+arv
         g2lSCxdfLkXJDkKbTp/HysQiNCq6vQe8oUgYC7UI+P0iyGeBLjK1Lks00H1o7eGozev9
         DEjnCtRxsYLHxMUc88Ub6j3AJtpwICaegPy2KGZog/keUmXGCAPMwulWi2K6JnNTlAr1
         dZY88lgy03zZW6LesTFJv29HBYWyUj/Y16Ls/cHtg/0TL795xjfwgxhMDyFSiCN/1pb2
         d04D8DCmapnlPUxiFLgjaNry9IL7iqKxs4NW4sMA8yo5MrXGypPVEgye6EEijbFpPJFI
         yzcA==
X-Gm-Message-State: AOJu0YwabhqTcC9umail6aMQ/RhZIRuCDwmA1OcryxoEdtokfGtMV9PA
        deQI8hdRQB/qEUSwdWczn5ekQw==
X-Google-Smtp-Source: AGHT+IH6iRI1yyQ2Fh18V+FP5a/x2wOOzbATCEm5kD/EDvAecZIVxBVXcoqA/cTUAQCXsQIx6KENmA==
X-Received: by 2002:aa7:c58f:0:b0:52a:1d6c:3127 with SMTP id g15-20020aa7c58f000000b0052a1d6c3127mr4404263edq.17.1692858005469;
        Wed, 23 Aug 2023 23:20:05 -0700 (PDT)
Received: from ?IPV6:2003:f6:af16:3400:a83f:7d2a:e2bc:49e1? (p200300f6af163400a83f7d2ae2bc49e1.dip0.t-ipconnect.de. [2003:f6:af16:3400:a83f:7d2a:e2bc:49e1])
        by smtp.gmail.com with ESMTPSA id c14-20020aa7d60e000000b0052333e5237esm10051908edr.88.2023.08.23.23.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 23:20:05 -0700 (PDT)
Message-ID: <7f9587ed-36af-4cfe-3699-45ceb63b15c6@grsecurity.net>
Date:   Thu, 24 Aug 2023 08:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15] Revert "KVM: x86: enable TDP MMU by default"
Content-Language: en-US, de-DE
To:     Sean Christopherson <seanjc@google.com>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
References: <20230824010512.2714931-1-seanjc@google.com>
 <ZOavFlKo2/sixUTk@google.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <ZOavFlKo2/sixUTk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.23 03:15, Sean Christopherson wrote:
> +Jeremi and Mathias, my scripts for sending patches to stable don't auto-cc :-/
> 
> On Wed, Aug 23, 2023, Sean Christopherson wrote:
>> Disable the TDP MMU by default in v5.15 kernels to "fix" several severe
>> performance bugs that have since been found and fixed in the TDP MMU, but
>> are unsuitable for backporting to v5.15.
>>
>> The problematic bugs are fixed by upstream commit edbdb43fc96b ("KVM:
>> x86: Preserve TDP MMU roots until they are explicitly invalidated") and
>> commit 01b31714bd90 ("KVM: x86: Do not unload MMU roots when only toggling
>> CR0.WP with TDP enabled").  Both commits fix scenarios where KVM will
>> rebuild all TDP MMU page tables in paths that are frequently hit by
>> certain guest workloads.  While not exactly common, the guest workloads
>> are far from rare.  The fallout of rebuilding TDP MMU page tables can be
>> so severe in some cases that it induces soft lockups in the guest.
>>
>> Commit edbdb43fc96b would require _significant_ effort and churn to
>> backport due it depending on a major rework that was done in v5.18.
>>
>> Commit 01b31714bd90 has far fewer direct conflicts, but has several subtle
>> _known_ dependencies, and it's unclear whether or not there are more
>> unknown dependencies that have been missed.
>>
>> Lastly, disabling the TDP MMU in v5.15 kernels also fixes a lurking train
>> wreck started by upstream commit a955cad84cda ("KVM: x86/mmu: Retry page
>> fault if root is invalidated by memslot update").  That commit was tagged
>> for stable to fix a memory leak, but didn't cherry-pick cleanly and was
>> never backported to v5.15.  Which is extremely fortunate, as it introduced
>> not one but two bugs, one of which was fixed by upstream commit
>> 18c841e1f411 ("KVM: x86: Retry page fault if MMU reload is pending and
>> root has no sp"), while the other was unknowingly fixed by upstream
>> commit ba6e3fe25543 ("KVM: x86/mmu: Grab mmu_invalidate_seq in
>> kvm_faultin_pfn()") in v6.3 (a one-off fix will be made for v6.1 kernels,
>> which did receive a backport for a955cad84cda).  Disabling the TDP MMU
>> by default reduces the probability of breaking v5.15 kernels by
>> backporting only a subset of the fixes.
>>
>> As far as what is lost by disabling the TDP MMU, the main selling point of
>> the TDP MMU is its ability to service page fault VM-Exits in parallel,
>> i.e. the main benefactors of the TDP MMU are deployments of large VMs
>> (hundreds of vCPUs), and in particular delployments that live-migrate such
>> VMs and thus need to fault-in huge amounts of memory on many vCPUs after
>> restarting the VM after migration.
>>
>> Smaller VMs can see performance improvements, but nowhere enough to make
>> up for the TDP MMU (in v5.15) absolutely cratering performance for some
>> workloads.  And practically speaking, anyone that is deploying and
>> migrating VMs with hundreds of vCPUs is likely rolling their own kernel,
>> not using a stock v5.15 series kernel.
>>
>> This reverts commit 71ba3f3189c78f756a659568fb473600fd78f207.
>>
>> Link: https://lore.kernel.org/all/ZDmEGM+CgYpvDLh6@google.com
>> Link: https://lore.kernel.org/all/f023d927-52aa-7e08-2ee5-59a2fbc65953@gameservers.com
>> Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
>> Cc: Mathias Krause <minipli@grsecurity.net>
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> ---
>>  arch/x86/kvm/mmu/tdp_mmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
>> index 6c2bb60ccd88..7a64fb238044 100644
>> --- a/arch/x86/kvm/mmu/tdp_mmu.c
>> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
>> @@ -10,7 +10,7 @@
>>  #include <asm/cmpxchg.h>
>>  #include <trace/events/kvm.h>
>>  
>> -static bool __read_mostly tdp_mmu_enabled = true;
>> +static bool __read_mostly tdp_mmu_enabled = false;
>>  module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0644);
>>  
>>  /* Initializes the TDP MMU for the VM, if enabled. */
>>
>> base-commit: f6f7927ac664ba23447f8dd3c3dfe2f4ee39272f
>> -- 

Acked-by: Mathias Krause <minipli@grsecurity.net>

I guess this means no hope for
https://lore.kernel.org/stable/234e01b6-1b5c-d682-a078-3dd91a62abf4@grsecurity.net/
:/
