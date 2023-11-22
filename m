Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145F07F41AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjKVJaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjKVJ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:29:57 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B41BC;
        Wed, 22 Nov 2023 01:29:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332cc1f176bso1534251f8f.2;
        Wed, 22 Nov 2023 01:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700645388; x=1701250188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y7pziT/im3f9dxtYQCJMHC7zXrzbkMaL6w7pi5WdK0=;
        b=gXA9XZLE7XQqIQxgVi4GVH7tXRyNgxW+IHwQHBWJKkVgEsO31wGqBX3Y5aGtp8vDLS
         gOGS33ZCI0cwbTAvgZ9RfYryfaemYECXM0EO8RgnHbN70YosedY9dTclv9Dc6FrZjLmJ
         vjaLI4SnhCGfR8JVf3kpoJ9Qlo/qGsLeX13XOPRZQkC+9NFfwSl1HX8QYzPNPHX75hrT
         AFTMc/PZUfmdGJ2hfFE6JFrddBJl/gn2yCyaBX4ZQcUzfSFcOystgjHZk1nRCvwg005u
         Q2sH8cFAGcnjyBlPQMEE/7s7yQIY8MHzaWGpW3zVpCXos20Pca1S2q4nZ2KUfXkIMH5J
         g7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700645388; x=1701250188;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y7pziT/im3f9dxtYQCJMHC7zXrzbkMaL6w7pi5WdK0=;
        b=qtWyXh8ldX3Gole7RqVKcioFveYXgy84eMNMdajO/AfGDXErEVKhVOVVDXI8HEyuPp
         SlNZf/GetGjSMzvZoxs+XJkCiQshg0yC/mcYmqKASwwjxQBiOm7ZnmiJlxGBb8nVcVEt
         W85dAGX363B+nhT0UCVKWXhgzk7TNRRpoDA6plZAxEHLTURbfk8ll6/KzNIOmWIRAgqV
         kMyeVKSDqO+crMDYlZ5F39W4mpAG0o/+LDmeVicI5HFH8gy234bZcU644QnElBqNiI82
         UMJ6xWcW/gCeYMjZQsl4pi+rkCxNpfUYlCY48CUgNa7/FHIpN1CQylEAumoUpQURnCnd
         0ldA==
X-Gm-Message-State: AOJu0YykFKiQUFx4IF0esdq5T/egZYzI68DUDwx2cCJt+aKzHYRGuhky
        YQyeDFXsFO6BLIua8rFO3Gw=
X-Google-Smtp-Source: AGHT+IFmXzlEZVX0HMLcecziO/y9I+ie+riau/sstICRrqvumuVD83HR2onj79fdwWLIWF25eUhVyg==
X-Received: by 2002:a5d:5c0c:0:b0:32d:9a17:2a72 with SMTP id cc12-20020a5d5c0c000000b0032d9a172a72mr1724308wrb.55.1700645387853;
        Wed, 22 Nov 2023 01:29:47 -0800 (PST)
Received: from [10.95.134.92] (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id m3-20020adffa03000000b00323293bd023sm16628792wrr.6.2023.11.22.01.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 01:29:47 -0800 (PST)
From:   Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <04530097-a3b2-4acf-bf41-fba48143d4e1@xen.org>
Date:   Wed, 22 Nov 2023 09:29:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v8 07/15] KVM: pfncache: include page offset in uhva and
 use it consistently
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231121180223.12484-1-paul@xen.org>
 <20231121180223.12484-8-paul@xen.org>
 <5ffdf3ab49b047cd851289e5dc0697af0ffff45f.camel@infradead.org>
Organization: Xen Project
In-Reply-To: <5ffdf3ab49b047cd851289e5dc0697af0ffff45f.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 22:35, David Woodhouse wrote:
> On Tue, 2023-11-21 at 18:02 +0000, Paul Durrant wrote:
>> @@ -242,8 +242,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
>>          }
>>   
>>          old_pfn = gpc->pfn;
>> -       old_khva = gpc->khva - offset_in_page(gpc->khva);
>> -       old_uhva = gpc->uhva;
>> +       old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
>>   
>>          /* If the userspace HVA is invalid, refresh that first */
>>          if (gpc->gpa != gpa || gpc->generation != slots->generation ||
>> @@ -259,13 +258,25 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
>>                          ret = -EFAULT;
>>                          goto out;
>>                  }
> 
> 
> There's a subtle behaviour change here, isn't there? I'd *really* like
> you do say 'No functional change intended' where that is true, and then
> the absence of that sentence in this one would be meaningful.
> 
> You are now calling hva_to_pfn_retry() even when the uhva page hasn't
> changed. Which is harmless and probably not important, but IIUC fixable
> by the addition of:
> 
>   +              if (gpc->uhva != PAGE_ALIGN_DOWN(old_uhva))

True; I can keep that optimization and then I will indeed add 'no 
functional change'... Didn't seem worth it at the time, but no harm.

>> +               hva_change = true;
>> +       } else {
>> +               /*
>> +                * No need to do any re-mapping if the only thing that has
>> +                * changed is the page offset. Just page align it to allow the
>> +                * new offset to be added in.
>> +                */
>> +               gpc->uhva = PAGE_ALIGN_DOWN(gpc->uhva);
>>          }
>>   
>> +       /* Note: the offset must be correct before calling hva_to_pfn_retry() */
>> +       gpc->uhva += page_offset;
>> +
>>          /*
>>           * If the userspace HVA changed or the PFN was already invalid,
>>           * drop the lock and do the HVA to PFN lookup again.
>>           */
>> -       if (!gpc->valid || old_uhva != gpc->uhva) {
>> +       if (!gpc->valid || hva_change) {
>>                  ret = hva_to_pfn_retry(gpc);
>>          } else {
>>                  /*
>> -- 
> 
> But I don't really think it's that important if you can come up with a
> coherent justification for the change and note it in the commit
> message. So either way:
> 
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

Thanks,

   Paul
