Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D684C8110C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjLMMMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjLMMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:12:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C71CF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:12:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3331752d2b9so4518198f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1702469530; x=1703074330; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1+N4toHCJ10eN7beh/9j8TkfnPseGcXj+HseAP1tdBY=;
        b=l1M0w1Aw5OhVxpzkfqCNOdZdayqytpT4jHHl44iOBHtj0sow0Jed5aGOhUYpSdoU1b
         mdbLND4MaPnkbcxMVhepl6AdmC9Q69gbaaHu2++VG8gtb6A8XB83cpNWPwvNPmjtUFKo
         6Y0fPC7UMLgkDsWXiJTX4ghVIvehEISGdm4+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702469530; x=1703074330;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+N4toHCJ10eN7beh/9j8TkfnPseGcXj+HseAP1tdBY=;
        b=L0OR56cyBz88W7tQl2NIg27ZXZzmlINcajZs6kFP5EQMwQ/85kmRoojN8DaA63Ymnt
         QnuAhU1l6O48qbjbf9EcHJ6nxiA6K7Eq9YXmLMINzCvS1ryqUMYli0tjmYpOSKKHqdM4
         lX7B/qJwt7+XHlKxmWs69sOrr9Sqo1lpei+F9Jfg/OoyMJjJi9fVgLqICfiHh82R1wT8
         PGbX7OQYVXLZsWmBOYkCZqvnSZWSlpVrsfyuMEoivW0VdDaLVScWHSb151agGUTvKIHT
         no1lgKiJODLRhSIohoMF8v+64dEVX0IULeKDgHm8jDcnGBVVeiFmfiJHohO2y5IRxxKn
         g0og==
X-Gm-Message-State: AOJu0YzhTmSx5TQYpQN20xdqFgqFJq0kcrffoFsPjXWq0xBuKju0B+vx
        Dy2xHenxdVzr+XDCpHmUjNuC/g==
X-Google-Smtp-Source: AGHT+IEXQImdxtidsySE8Dvo4Qp275qPuasc4MbJLcUoaLv3rryHkHfFfLlFqk21Zhh1xtU9nWcpFQ==
X-Received: by 2002:adf:fd08:0:b0:333:43a2:2caf with SMTP id e8-20020adffd08000000b0033343a22cafmr4973429wrr.14.1702469530209;
        Wed, 13 Dec 2023 04:12:10 -0800 (PST)
Received: from localhost ([213.195.127.70])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6282000000b003363432c0ffsm3429132wru.113.2023.12.13.04.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:12:09 -0800 (PST)
Date:   Wed, 13 Dec 2023 13:12:09 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v3 3/3] PCI/sysfs: Add gsi sysfs for pci_dev
Message-ID: <ZXmfmbb4S8Iuy7si@macbook>
References: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
 <20231210161519.1550860-4-Jiqian.Chen@amd.com>
 <ZXdNf0HWs4nAVPeF@macbook>
 <BL1PR12MB584910C2E370BBCC8A312733E78EA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <ZXglU0EtBrRNiWVp@macbook>
 <BL1PR12MB584973D751EB57C3DE766AEEE78DA@BL1PR12MB5849.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR12MB584973D751EB57C3DE766AEEE78DA@BL1PR12MB5849.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 03:31:21AM +0000, Chen, Jiqian wrote:
> On 2023/12/12 17:18, Roger Pau Monné wrote:
> > On Tue, Dec 12, 2023 at 06:34:27AM +0000, Chen, Jiqian wrote:
> >>
> >> On 2023/12/12 01:57, Roger Pau Monné wrote:
> >>> On Mon, Dec 11, 2023 at 12:15:19AM +0800, Jiqian Chen wrote:
> >>>> There is a need for some scenarios to use gsi sysfs.
> >>>> For example, when xen passthrough a device to dumU, it will
> >>>> use gsi to map pirq, but currently userspace can't get gsi
> >>>> number.
> >>>> So, add gsi sysfs for that and for other potential scenarios.
> >>>>
> >>>> Co-developed-by: Huang Rui <ray.huang@amd.com>
> >>>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >>>> ---
> >>>>  drivers/acpi/pci_irq.c  |  1 +
> >>>>  drivers/pci/pci-sysfs.c | 11 +++++++++++
> >>>>  include/linux/pci.h     |  2 ++
> >>>>  3 files changed, 14 insertions(+)
> >>>>
> >>>> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> >>>> index 630fe0a34bc6..739a58755df2 100644
> >>>> --- a/drivers/acpi/pci_irq.c
> >>>> +++ b/drivers/acpi/pci_irq.c
> >>>> @@ -449,6 +449,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> >>>>  		kfree(entry);
> >>>>  		return 0;
> >>>>  	}
> >>>> +	dev->gsi = gsi;
> >>>
> >>> It would be better if the gsi if fetched without requiring calling
> >>> acpi_pci_irq_enable(), as the gsi doesn't require the interrupt to be
> >>> enabled.  The gsi is known at boot time and won't change for the
> >>> lifetime of the device.
> >> Do you have any suggest places to do this?
> > 
> > I'm not an expert on this, but drivers/pci/pci-sysfs.c would seem like
> > a better place, together with the rest of the resources.
> I'm not familiar with this too. But it seems pci-sysfs.c only creates sysfs node and supports the read/write method without initializing the values.
> If want to initialize the value of gsi here. An approach to initialize it is to call acpi_pci_irq_lookup to get gsi number when the first time it is read?

Hm, maybe, I don't really have much experience with sysfs, so don't
know how nodes are usually initialized.

> > 
> > Maybe my understanding is incorrect, but given the suggested placement
> > in acpi_pci_irq_enable() I think the device would need to bind the
> > interrupt in order for the gsi node to appear on sysfs?
> No, gsi sysfs has existed there, in acpi_pci_irq_enable is to initialize the value of gsi.
> 
> > 
> > Would the current approach work if the device is assigned to pciback
> > on the kernel command line, and thus never owned by any driver in
> > dom0?
> If assigned to pciback, I think pciback will enable the device, and then acpi_pci_irq_enable will be called, and then the gsi will be initialized. So, current can work.

This needs checking to be sure, I'm certainly not that familiar.  You
would need to at least test that it works properly when the device is
hidden using xen-pciback.hide=(SBDF) in the Linux kernel command line.

Thanks, Roger.
