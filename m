Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF9980503A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjLEKcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjLEKcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:32:12 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ED1B0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:32:16 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id ffacd0b85a97d-3333a3a599fso1569082f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1701772334; x=1702377134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DVNqy7YsuIkl8aQ4ZbP26tEAG4Op9jDFwyUj1GfebWM=;
        b=BX5eWpemQctPNkW9QKbDqn1uSpB0Yz+wrSWYBzmLTCrci3ti1moOZfn1qHs0YAHYls
         oTHYETcNHeV6trT29BHS6SuB25uJlREpn6TBO7CXZELsnyrF4DpX96d1jaEVFsLTiYPO
         /uQNlpIe7V+teWvj/kUDHXSUnASkzdVMYe9TdP77xrxciR2jIglit8ChsOb6EYsdOsd4
         WItaTCmUsJ2hb9xv9AZwPiB+WGpGjxCfgxseOngWzn16xjxxRo9TGHGyN6QQ82jDustd
         o/ZjXUYQREdHjI5RcODfXnyX/C4ijbw45XubY/XKJD979dc6o23LkzF8j/I4cKHiEFD+
         MNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772334; x=1702377134;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVNqy7YsuIkl8aQ4ZbP26tEAG4Op9jDFwyUj1GfebWM=;
        b=VcA8v91m9AWjC9Z8A7y/0/iP2UxoBt6TfYaN5rL2/Hi6jFyan2Z6I1r6/YNH6hgyh0
         nqHmlLQe2RXgTEUDv7kpNMH2UH9zyJX2NnSjEx1qjkGL/Yi9foWjfsFo1mhWkH5svXHc
         r8ILEjuSD74le/tnasdyB/8quYpjqjH+vRVT6tfNRji/RUfCBuJbcU44JWyV7eyspD/3
         PuzAPNutEV7oenlEgE5wJp/fbVADLX39LwIBVqRn8jzf8lMjppkqozX/FZCjgJng9hf6
         JOAdFBQQy2Z0srrRXu9n8ZLAPv3gDX9/8QAAvM14Ql5J+kOSQEywflFARSd1xDZcaikY
         s4eQ==
X-Gm-Message-State: AOJu0YxsSQhQ4JwWkYmO6ObsgWaQF/gvq/zvEULV1c+q08kxhn5U9tal
        vHp/FSzrtMY4px+zZbfsOer4
X-Google-Smtp-Source: AGHT+IGUv2+FcEpWRrKS8f75v5tGnUn79eiMPuocryfL3u4IX6/sUBY1Mpx8NL+uvLx34AxvGV5tYA==
X-Received: by 2002:adf:fd48:0:b0:333:2fd7:95f8 with SMTP id h8-20020adffd48000000b003332fd795f8mr614778wrs.51.1701772333985;
        Tue, 05 Dec 2023 02:32:13 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d5101000000b003333521a1cesm10126337wrt.57.2023.12.05.02.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 02:32:13 -0800 (PST)
Message-ID: <15275706-5c31-4e29-aa29-9f5e90526219@suse.com>
Date:   Tue, 5 Dec 2023 11:32:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
Content-Language: en-US
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Jiqian Chen <Jiqian.Chen@amd.com>, Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        Julia Zhang <Julia.Zhang@amd.com>,
        Huang Rui <Ray.Huang@amd.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-3-Jiqian.Chen@amd.com>
 <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop>
 <ZWiyBP4Lzz5lXraP@macbook>
 <alpine.DEB.2.22.394.2311301912350.110490@ubuntu-linux-20-04-desktop>
 <ZWmgJNidFsfkDp7q@macbook>
 <alpine.DEB.2.22.394.2312011857260.110490@ubuntu-linux-20-04-desktop>
 <ZW2ptexPQXrWBiOS@macbook>
 <alpine.DEB.2.22.394.2312041413000.110490@ubuntu-linux-20-04-desktop>
 <ZW7rDjjC0gxEI1cq@macbook>
From:   Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <ZW7rDjjC0gxEI1cq@macbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.2023 10:19, Roger Pau Monné wrote:
> On Mon, Dec 04, 2023 at 02:19:33PM -0800, Stefano Stabellini wrote:
>> On Mon, 4 Dec 2023, Roger Pau Monné wrote:
>>> On Fri, Dec 01, 2023 at 07:37:55PM -0800, Stefano Stabellini wrote:
>>>> On Fri, 1 Dec 2023, Roger Pau Monné wrote:
>>>>> On Thu, Nov 30, 2023 at 07:15:17PM -0800, Stefano Stabellini wrote:
>>>>>> On Thu, 30 Nov 2023, Roger Pau Monné wrote:
>>>>>>> On Wed, Nov 29, 2023 at 07:53:59PM -0800, Stefano Stabellini wrote:
>>>>>>>> On Fri, 24 Nov 2023, Jiqian Chen wrote:
>>>>>>>>> This patch is to solve two problems we encountered when we try to
>>>>>>>>> passthrough a device to hvm domU base on Xen PVH dom0.
>>>>>>>>>
>>>>>>>>> First, hvm guest will alloc a pirq and irq for a passthrough device
>>>>>>>>> by using gsi, before that, the gsi must first has a mapping in dom0,
>>>>>>>>> see Xen code pci_add_dm_done->xc_domain_irq_permission, it will call
>>>>>>>>> into Xen and check whether dom0 has the mapping. See
>>>>>>>>> XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH
>>>>>>>>> dom0 and it return irq is 0, and then return -EPERM.
>>>>>>>>> This is because the passthrough device doesn't do PHYSDEVOP_map_pirq
>>>>>>>>> when thay are enabled.
>>>>>>>>>
>>>>>>>>> Second, in PVH dom0, the gsi of a passthrough device doesn't get
>>>>>>>>> registered, but gsi must be configured for it to be able to be
>>>>>>>>> mapped into a domU.
>>>>>>>>>
>>>>>>>>> After searching codes, we can find map_pirq and register_gsi will be
>>>>>>>>> done in function vioapic_write_redirent->vioapic_hwdom_map_gsi when
>>>>>>>>> the gsi(aka ioapic's pin) is unmasked in PVH dom0. So the problems
>>>>>>>>> can be conclude to that the gsi of a passthrough device doesn't be
>>>>>>>>> unmasked.
>>>>>>>>>
>>>>>>>>> To solve the unmaske problem, this patch call the unmask_irq when we
>>>>>>>>> assign a device to be passthrough. So that the gsi can get registered
>>>>>>>>> and mapped in PVH dom0.
>>>>>>>>
>>>>>>>>
>>>>>>>> Roger, this seems to be more of a Xen issue than a Linux issue. Why do
>>>>>>>> we need the unmask check in Xen? Couldn't we just do:
>>>>>>>>
>>>>>>>>
>>>>>>>> diff --git a/xen/arch/x86/hvm/vioapic.c b/xen/arch/x86/hvm/vioapic.c
>>>>>>>> index 4e40d3609a..df262a4a18 100644
>>>>>>>> --- a/xen/arch/x86/hvm/vioapic.c
>>>>>>>> +++ b/xen/arch/x86/hvm/vioapic.c
>>>>>>>> @@ -287,7 +287,7 @@ static void vioapic_write_redirent(
>>>>>>>>              hvm_dpci_eoi(d, gsi);
>>>>>>>>      }
>>>>>>>>  
>>>>>>>> -    if ( is_hardware_domain(d) && unmasked )
>>>>>>>> +    if ( is_hardware_domain(d) )
>>>>>>>>      {
>>>>>>>>          /*
>>>>>>>>           * NB: don't call vioapic_hwdom_map_gsi while holding hvm.irq_lock
>>>>>>>
>>>>>>> There are some issues with this approach.
>>>>>>>
>>>>>>> mp_register_gsi() will only setup the trigger and polarity of the
>>>>>>> IO-APIC pin once, so we do so once the guest unmask the pin in order
>>>>>>> to assert that the configuration is the intended one.  A guest is
>>>>>>> allowed to write all kind of nonsense stuff to the IO-APIC RTE, but
>>>>>>> that doesn't take effect unless the pin is unmasked.
>>>>>>>
>>>>>>> Overall the question would be whether we have any guarantees that
>>>>>>> the hardware domain has properly configured the pin, even if it's not
>>>>>>> using it itself (as it hasn't been unmasked).
>>>>>>>
>>>>>>> IIRC PCI legacy interrupts are level triggered and low polarity, so we
>>>>>>> could configure any pins that are not setup at bind time?
>>>>>>
>>>>>> That could work.
>>>>>>
>>>>>> Another idea is to move only the call to allocate_and_map_gsi_pirq at
>>>>>> bind time? That might be enough to pass a pirq_access_permitted check.
>>>>>
>>>>> Maybe, albeit that would change the behavior of XEN_DOMCTL_bind_pt_irq
>>>>> just for PT_IRQ_TYPE_PCI and only when called from a PVH dom0 (as the
>>>>> parameter would be a GSI instead of a previously mapped IRQ).  Such
>>>>> difference just for PT_IRQ_TYPE_PCI is slightly weird - if we go that
>>>>> route I would recommend that we instead introduce a new dmop that has
>>>>> this syntax regardless of the domain type it's called from.
>>>>
>>>> Looking at the code it is certainly a bit confusing. My point was that
>>>> we don't need to wait until polarity and trigger are set appropriately
>>>> to allow Dom0 to pass successfully a pirq_access_permitted() check. Xen
>>>> should be able to figure out that Dom0 is permitted pirq access.
>>>
>>> The logic is certainly not straightforward, and it could benefit from
>>> some comments.
>>>
>>> The irq permissions are a bit special, in that they get setup when the
>>> IRQ is mapped.
>>>
>>> The problem however is not so much with IRQ permissions, that we can
>>> indeed sort out internally in Xen.  Such check in dom0 has the side
>>> effect of preventing the IRQ from being assigned to a domU without the
>>> hardware source being properly configured AFAICT.
>>
>> Now I understand why you made a comment previously about Xen having to
>> configure trigger and polarity for these interrupts on its own.
>>
>>
>>>> So the idea was to move the call to allocate_and_map_gsi_pirq() earlier
>>>> somewhere because allocate_and_map_gsi_pirq doesn't require trigger or
>>>> polarity to be configured to work. But the suggestion of doing it a
>>>> "bind time" (meaning: XEN_DOMCTL_bind_pt_irq) was a bad idea.
>>>>
>>>> But maybe we can find another location, maybe within
>>>> xen/arch/x86/hvm/vioapic.c, to call allocate_and_map_gsi_pirq() before
>>>> trigger and polarity are set and before the interrupt is unmasked.
>>>>
>>>> Then we change the implementation of vioapic_hwdom_map_gsi to skip the
>>>> call to allocate_and_map_gsi_pirq, because by the time
>>>> vioapic_hwdom_map_gsi we assume that allocate_and_map_gsi_pirq had
>>>> already been done.
>>>
>>> But then we would end up in a situation where the
>>> pirq_access_permitted() check will pass, but the IO-APIC pin won't be
>>> configured, which I think it's not what we want.
>>>
>>> One option would be to allow mp_register_gsi() to be called multiple
>>> times, and update the IO-APIC pin configuration as long as the pin is
>>> not unmasked.  That would propagate each dom0 RTE update to the
>>> underlying IO-APIC.  However such approach relies on dom0 configuring
>>> all possible IO-APIC pins, even if no device on dom0 is using them, I
>>> think it's not a very reliable option.
>>>
>>> Another option would be to modify the toolstack to setup the GSI
>>> itself using the PHYSDEVOP_setup_gsi hypercall.  As said in a previous
>>> email, since we only care about PCI device passthrough the legacy INTx
>>> should always be level triggered and low polarity.
>>>
>>>> I am not familiar with vioapic.c but to give you an idea of what I was
>>>> thinking:
>>>>
>>>>
>>>> diff --git a/xen/arch/x86/hvm/vioapic.c b/xen/arch/x86/hvm/vioapic.c
>>>> index 4e40d3609a..16d56fe851 100644
>>>> --- a/xen/arch/x86/hvm/vioapic.c
>>>> +++ b/xen/arch/x86/hvm/vioapic.c
>>>> @@ -189,14 +189,6 @@ static int vioapic_hwdom_map_gsi(unsigned int gsi, unsigned int trig,
>>>>          return ret;
>>>>      }
>>>>  
>>>> -    ret = allocate_and_map_gsi_pirq(currd, pirq, &pirq);
>>>> -    if ( ret )
>>>> -    {
>>>> -        gprintk(XENLOG_WARNING, "vioapic: error mapping GSI %u: %d\n",
>>>> -                 gsi, ret);
>>>> -        return ret;
>>>> -    }
>>>> -
>>>>      pcidevs_lock();
>>>>      ret = pt_irq_create_bind(currd, &pt_irq_bind);
>>>>      if ( ret )
>>>> @@ -287,6 +279,17 @@ static void vioapic_write_redirent(
>>>>              hvm_dpci_eoi(d, gsi);
>>>>      }
>>>>  
>>>> +    if ( is_hardware_domain(d) ) 
>>>> +    {
>>>> +        int pirq = gsi, ret;
>>>> +        ret = allocate_and_map_gsi_pirq(currd, pirq, &pirq);
>>>> +        if ( ret )
>>>> +        {
>>>> +            gprintk(XENLOG_WARNING, "vioapic: error mapping GSI %u: %d\n",
>>>> +                    gsi, ret);
>>>> +            return ret;
>>>> +        }
>>>> +    }
>>>>      if ( is_hardware_domain(d) && unmasked )
>>>>      {
>>>>          /*
>>>
>>> As said above, such approach relies on dom0 writing to the IO-APIC RTE
>>> of likely each IO-APIC pin, which is IMO not quite reliable.  In there
>>> are two different issues here that need to be fixed for PVH dom0:
>>>
>>>  - Fix the XEN_DOMCTL_irq_permission pirq_access_permitted() call to
>>>    succeed for a PVH dom0, even if dom0 is not using the GSI itself.
>>
>> Yes makes sense
>>
>>
>>>  - Configure IO-APIC pins for PCI interrupts even if dom0 is not using
>>>    the IO-APIC pin itself.
>>>
>>> First one needs to be fixed internally in Xen, second one will require
>>> the toolstack to issue an extra hypercall in order to ensure the
>>> IO-APIC pin is properly configured.
>>  
>> On ARM, Xen doesn't need to wait for dom0 to configure interrupts
>> correctly. Xen configures them all on its own at boot based on Device
>> Tree information. I guess it is not possible to do the same on x86?
> 
> No, not exactly.  There's some interrupt information in the ACPI MADT,
> but that's just for very specific sources (Interrupt Source Override
> Structures)
> 
> Then on AML devices can have resource descriptors that contain
> information about how interrupts are setup.  However Xen is not able
> to read any of this information on AML.
> 
> Legacy PCI interrupts are (always?) level triggered and low polarity,
> because it's assumed that an interrupt source can be shared between
> multiple devices.

Except that as per what you said just in the earlier paragraph ACPI can
tell us otherwise.

> I'm however not able to find any reference to this in the PCI spec,
> hence I'm reluctant to take this for granted in Xen, and default all
> GSIs >= 16 to such mode.
> 
> OTOH legacy PCI interrupts are not that used anymore, as almost all
> devices will support MSI(-X) (because PCIe mandates it) and OSes
> should prefer the latter.  SR-IOV VF don't even support legacy PCI
> interrupts anymore.
> 
>> If
>> not, then I can see why we would need 1 extra toolstack hypercall for
>> that (or to bundle the operation of configuring IO-APIC pins together
>> with an existing toolstack hypercall).
> 
> One suitable compromise would be to default unconfigured GSIs >= 16 to
> level-triggered and low-polarity, as I would expect that to work in
> almost all cases.  We can always introduce the usage of
> PHYSDEVOP_setup_gsi later if required.
> 
> Maybe Jan has more input here, would you agree to defaulting non-ISA
> GSIs to level-triggered, low-polarity in the absence of a specific
> setup provided by dom0?

Well, such defaulting is an option, but in case it's wrong we might
end up with hard to diagnose issues. Personally I'd prefer if we
didn't take shortcuts here, i.e. if we followed what Dom0 is able
to read from ACPI.

Jan
