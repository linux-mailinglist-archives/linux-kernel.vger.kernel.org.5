Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7193880EA3A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346316AbjLLLTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346201AbjLLLTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:19:47 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB2CD3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:19:53 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3332efd75c9so4967994f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702379992; x=1702984792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwEjDc2CrhhCQ4rSnFOIHTRLclNv351PRw1yqQ6gOvc=;
        b=PPbWdpnTsTIFgpHDHabpET4rPB4/PsPcM8tpxXMuQftJnzB4ogeNQSbHQIpX4izyGn
         s01KTJtMzWKxO2xjFwHXVi5ZFQvbEZjpaZgTznQ3kZwi9ix6muYZnxGr5RHiYyjSbqrq
         zoW0Iu7lNzpcSmc+c35mtIMRcrJHfdEYthQ6uM1soZQ4KztMibYgN/M/4gzh2kSFJb+h
         7SPCON6fWgKxgYIS/H2Uq9w/2Lh2b0zmh33OT7dRYoh2vZ+ZtygKiu50PaJ3Nw/SBmLM
         GqYWkJTm3MnubDxp5JB4qOl1Sl/ThHQr3nYOiw3yfktGLIxiyEnRdHQ2SjIk0qHIIewu
         gyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702379992; x=1702984792;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwEjDc2CrhhCQ4rSnFOIHTRLclNv351PRw1yqQ6gOvc=;
        b=RkRg+Xg+sNBb8bzqwyVbajPCdgj98LK1Gb7Yvsm6JoGS+qPgwfQG6HaP3iPrCgEu7F
         cqfUyihNMnJ7KWWLMA/bt623Hgsc8SB3oOBWEL3ei3cUXdLUaEQ7siX+SOre37QUd2QP
         AFQoELftFvsJtfpCp3eNRQbrfxI9YGUdVTsNLEa01Xciteru4b7SjBpXQvZ+YqikoiwI
         1C9tiffOU0z5Pt70NJNoanqmaI5MK0v8CuJK+mkL803pe8Tx6wIsPYRYW+4Pt77PSKGv
         aLPGEkgbfMAWWrThbMBn+CyuOSsrBrEi3thPxVXHGZIj+hyJusLTlMco4ZSk0lkgBB9c
         PdOw==
X-Gm-Message-State: AOJu0YxjHutDu5eNO+zNKWVBR6/xbIk4oeDoCWSMU0kFJ+svqxyjyZoP
        iw96XdyJKdY3ZxIIy1f9/FZt
X-Google-Smtp-Source: AGHT+IGYmuHnHHwZdgS8cmc2M4RXLx4xGGviD6ncm+9+pbUeRvBRME7rh/XWp4ufVM9oE0BOeHwGZQ==
X-Received: by 2002:a05:6000:931:b0:333:3117:c48e with SMTP id cx17-20020a056000093100b003333117c48emr1212743wrb.287.1702379992016;
        Tue, 12 Dec 2023 03:19:52 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id w12-20020adfcd0c000000b003334010a849sm10541037wrm.109.2023.12.12.03.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 03:19:51 -0800 (PST)
Message-ID: <c5d4e8a4-b286-4352-bf96-a67cb132b452@suse.com>
Date:   Tue, 12 Dec 2023 12:19:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
Content-Language: en-US
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     "Chen, Jiqian" <Jiqian.Chen@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Stabellini, Stefano" <stefano.stabellini@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
References: <alpine.DEB.2.22.394.2312011857260.110490@ubuntu-linux-20-04-desktop>
 <ZW2ptexPQXrWBiOS@macbook>
 <alpine.DEB.2.22.394.2312041413000.110490@ubuntu-linux-20-04-desktop>
 <ZW7rDjjC0gxEI1cq@macbook> <15275706-5c31-4e29-aa29-9f5e90526219@suse.com>
 <BL1PR12MB5849C871B0B9577D1E0BF576E784A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXculMdLgwGaRC7i@macbook>
 <BL1PR12MB584997DDE6839F2340022976E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXgeieg4E8UN0KoN@macbook> <50ca26a1-38e3-45fb-9c39-56e4d04de3e0@suse.com>
 <ZXhBb0Vt6gDuprHa@macbook>
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
In-Reply-To: <ZXhBb0Vt6gDuprHa@macbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.2023 12:18, Roger Pau Monné wrote:
> On Tue, Dec 12, 2023 at 10:38:08AM +0100, Jan Beulich wrote:
>> (I think the Cc list is too long here, but then I don't know who to
>> keep and who to possibly drop.)
>>
>> On 12.12.2023 09:49, Roger Pau Monné wrote:
>>> On Tue, Dec 12, 2023 at 06:16:43AM +0000, Chen, Jiqian wrote:
>>>> On 2023/12/11 23:45, Roger Pau Monné wrote:
>>>>> On Wed, Dec 06, 2023 at 06:07:26AM +0000, Chen, Jiqian wrote:
>>>>>> +static int xen_pvh_setup_gsi(gsi_info_t *gsi_info)
>>>>>> +{
>>>>>> +       struct physdev_setup_gsi setup_gsi;
>>>>>> +
>>>>>> +       setup_gsi.gsi = gsi_info->gsi;
>>>>>> +       setup_gsi.triggering = (gsi_info->trigger == ACPI_EDGE_SENSITIVE ? 0 : 1);
>>>>>> +       setup_gsi.polarity = (gsi_info->polarity == ACPI_ACTIVE_HIGH ? 0 : 1);
>>>>>> +
>>>>>> +       return HYPERVISOR_physdev_op(PHYSDEVOP_setup_gsi, &setup_gsi);
>>>>>> +}
>>>>>
>>>>> Hm, why not simply call pcibios_enable_device() from pciback?  What
>>>> pcibios_enable_device had been called when using cmd "xl pci-assignable-add sbdf" from pciback. But it didn't do map_pirq and setup_gsi.
>>>> Because pcibios_enable_device-> pcibios_enable_irq-> __acpi_register_gsi(acpi_register_gsi_ioapic PVH specific)
>>>>> you are doing here using the hypercalls is a backdoor into what's done
>>>>> automatically by Xen on IO-APIC accesses by a PVH dom0.
>>>> But the gsi didn't be unmasked, and vioapic_hwdom_map_gsi is never called.
>>>> So, I think in pciback, if we can do what vioapic_hwdom_map_gsi does.
>>>>
>>>
>>> I see, it does setup the IO-APIC pin but doesn't unmask it, that's
>>> what I feared.
>>>
>>>>> It will be much more natural for the PVH dom0 model to simply use the
>>>>> native way to configure and unmask the IO-APIC pin, and that would
>>>>> correctly setup the triggering/polarity and bind it to dom0 without
>>>>> requiring the usage of any hypercalls.
>>>> Do you still prefer that I called unmask_irq in pcistub_init_device, as this v2 patch do?
>>>> But Thomas Gleixner think it is not suitable to export unmask_irq.
>>>
>>> Yeah, that wasn't good.
>>>
>>>>>
>>>>> Is that an issue since in that case the gsi will get mapped and bound
>>>>> to dom0?
>>>> Dom0 do map_pirq is to pass the check xc_domain_irq_permission()-> pirq_access_permitted(), 
>>>
>>> Can we see about finding another way to fix this check?
>>>
>>> One option would be granting permissions over the IRQ in
>>> PHYSDEVOP_setup_gsi?
>>
>> There's no domain available there, and imo it's also the wrong interface to
>> possibly grant any permissions.
> 
> Well, the domain is the caller.

Granting permission to itself?

Jan
