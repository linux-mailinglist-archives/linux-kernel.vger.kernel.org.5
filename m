Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2087377E2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245686AbjHPNnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343497AbjHPNnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2142D6A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692193274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jN9TOD4A/0Qw8dNB02SZeeOMSlTj43nwfdVrkfW3Nrw=;
        b=EdefF9cxNksDJhAU7fQ3Z6KgTlgmZlMp4oM5+qxaTYQ87z19/Ky6Z5XmrTH0TVxI8yb1ua
        nEPKYBLQs30Hpsua2GeD9fJ/0cSTTharjxnJS98rnkmA8eDNgx3z8DHpS2V8pkPs90+Zk/
        v01mf2IqlihuxjvgTPUw7G4dwRAcac4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-jZxhNr4JOS6fKUkOCC-9RQ-1; Wed, 16 Aug 2023 09:41:12 -0400
X-MC-Unique: jZxhNr4JOS6fKUkOCC-9RQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76ce59841d5so912706085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193272; x=1692798072;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jN9TOD4A/0Qw8dNB02SZeeOMSlTj43nwfdVrkfW3Nrw=;
        b=ZH1sLdRvrjo1F9RrVa1xqLgsbwL7+EshXIm/UZVasCJ1v9i7gJHwFAqPaUv3Ix39m8
         lqBog/Y6F+rpFsCIIDD5esDZnn9u6sPZ6yu3bFrniH9hVLPWBrHaCZUXLMaekkwvp0Cp
         zfLlT9eSe6StzelYGEVpy/MttqLxgNkElPVoAYOBYXdahYTGxy6GaOO1nl6COPP/aXUv
         /8j9PVzEDabxCVltmlI1D89lgDJi6WsuNQ1egKPYSWsTGYUAjCGVsHRLZ8yM6dGGCtY5
         yeHVsG/muyziwrFm+KFaem/2ZmeeY9fSyidgdPq93CiaQnzkZ/wqCJ58WmaoPnsmHXMH
         ifgQ==
X-Gm-Message-State: AOJu0Yz69k6mZJ6HpgvG8NYnEHNY8JyrouOxKXUATsvI3ixqaat0a6Ke
        cnXBTOMmsCuze2sTzUfeHYOHh0R963xG9AtaW6kljNC1ZltrRFq8mnQFa5Fi6X8wgbYPGWiwUSR
        brWkIS4Z+uGTguLQ5/HT5YRTa
X-Received: by 2002:a0c:f5c8:0:b0:635:fb19:2ebd with SMTP id q8-20020a0cf5c8000000b00635fb192ebdmr2093301qvm.13.1692193272093;
        Wed, 16 Aug 2023 06:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaHYffXAFhTd9CZKBPQvUZnBh/Jw60Onr4ZL78JsygR0WcnheSxJMVeodMGwp8PDoLFTRlaw==
X-Received: by 2002:a0c:f5c8:0:b0:635:fb19:2ebd with SMTP id q8-20020a0cf5c8000000b00635fb192ebdmr2093286qvm.13.1692193271857;
        Wed, 16 Aug 2023 06:41:11 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id y3-20020a0cd983000000b0062ffbf23c22sm4844318qvj.131.2023.08.16.06.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:41:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Roman Mamedov <rm+bko@romanrm.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux KVM <kvm@vger.kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: Fwd: kvm: Windows Server 2003 VM fails to work on 6.1.44 (works
 fine on 6.1.43)
In-Reply-To: <87il9f5eg1.fsf@redhat.com>
References: <8cc000d5-9445-d6f1-f02e-4629a4a59e0e@gmail.com>
 <87o7j75g0g.fsf@redhat.com> <87il9f5eg1.fsf@redhat.com>
Date:   Wed, 16 Aug 2023 15:41:08 +0200
Message-ID: <87cyzn5cln.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>>
>>> Hi,
>>>
>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>
>>>> Hello,
>>>> 
>>>> I have a virtual machine running the old Windows Server 2003. On kernels 6.1.44 and 6.1.45, the QEMU VNC window stays dark, not switching to any of the guest's video modes and the VM process uses only ~64 MB of RAM of the assigned 2 GB, indefinitely. It's like the VM is paused/halted/stuck before even starting. The process can be killed successfully and then restarted again (with the same result), so it is not deadlocked in kernel or the like.
>>>> 
>>>> Kernel 6.1.43 works fine.
>>>> 
>>>> I have also tried downgrading CPU microcode from 20230808 to 20230719, but that did not help.
>>>> 
>>>> The CPU is AMD Ryzen 5900. I suspect some of the newly added mitigations may be the culprit?
>>>
>>> See Bugzilla for the full thread.
>>>
>>> Anyway, I'm adding it to regzbot as stable-specific regression:
>>>
>>> #regzbot introduced: v6.1.43..v6.1.44 https://bugzilla.kernel.org/show_bug.cgi?id=217799
>>> #regzbot title: Windows Server 2003 VM boot hang (only 64MB RAM allocated)
>>>
>>> Thanks.
>>>
>>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217799
>>
>> From KVM's PoV, I don't see any KVM/x86 patches v6.1.44..v6.1.45 
>
> Oh, sorry, my bad, in the description of the BZ it is said that 6.1.44
> is already broken, so it's most likely srso stuff then:
>
> dd5f2ef16e3c x86: fix backwards merge of GDS/SRSO bit
> 4f25355540ad x86/srso: Tie SBPB bit setting to microcode patch detection
> 77cf32d0dbfb x86/srso: Add a forgotten NOENDBR annotation
> c7f2cd045542 x86/srso: Fix return thunks in generated code
> c9ae63d773ca x86/srso: Add IBPB on VMEXIT
> 79c8091888ef x86/srso: Add IBPB
> 98f62883e751 x86/srso: Add SRSO_NO support
> 9139f4b6dd4f x86/srso: Add IBPB_BRTYPE support
> ac41e90d8daa x86/srso: Add a Speculative RAS Overflow mitigation

Sean's https://lore.kernel.org/all/20230811155255.250835-1-seanjc@google.com/
(alteady in 'tip') can actually be related and I see it was already
tagged for stable@. Can anyone check if it really helps?

> dec3b91f2c4b x86/cpu, kvm: Add support for CPUID_80000021_EAX
>
> it would still be great to try to bisect to the particular patch causing
> the issue.

-- 
Vitaly

