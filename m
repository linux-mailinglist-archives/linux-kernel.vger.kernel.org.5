Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E4F813327
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573486AbjLNObW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjLNObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:31:21 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0C485;
        Thu, 14 Dec 2023 06:31:26 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35E1CE0013;
        Thu, 14 Dec 2023 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702564285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fIKB/u0MwMXc68VORzrHfiOCkFzYFHAP6fqFR+4r6Ug=;
        b=OkoMNqoi80SZDHZtuNk44+7+YekGVFzt+vnyeT0QLxrHrOoQ5foP4cFqa6MjMy/tnW5AaJ
        D8DLL1Z5ybHoa8zMQh0oTzAmNwohE/UuKnZ1Jq4fpcAaSwFxkeVedjwvoS2TLDMnHUYm05
        Lmc075id4Ybj4Uqe18OWz4efvF1Zb5EgnrgsMUkhaw7aLwIVKwI0KhfgDsFWmj5qO/ZDVn
        cpPQEPi17JAuMnRzLQLpfyOOyp+z+sQSRttuzR7RiAEZa5vnMMSsRI0Dtw8gaJ9GhSCoAq
        geJcwz7vaIT7yAbX5UuKyfH7Q1J4gy7JpcLt5Z8pYMidWfXoHSci+idho1zxAw==
Date:   Thu, 14 Dec 2023 15:31:22 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
Message-ID: <20231214153122.07e99a5a@bootlin.com>
In-Reply-To: <20231208094840.01d74fec@bootlin.com>
References: <20231130165700.685764-1-herve.codina@bootlin.com>
        <CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
        <20231204134335.3ded3d46@bootlin.com>
        <CAL_JsqLtCS3otZ1sfiPEWwrWB4dyNpu4e0xANWJriCEUYr+4Og@mail.gmail.com>
        <20231204163014.4da383f2@bootlin.com>
        <CAL_JsqJJ64513pyQggU71agTzawNWPpm6ZpWMB6e0zu-tWL8yw@mail.gmail.com>
        <20231205090452.7c601eb5@bootlin.com>
        <CAL_Jsq+je7+9ATR=B6jXHjEJHjn24vQFs4Tvi9=vhDeK9n42Aw@mail.gmail.com>
        <20231208094840.01d74fec@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 8 Dec 2023 09:48:40 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> > 
> > But you don't. The logic to find the interrupt parent is walk up the
> > parent nodes until you find 'interrupt-parent' or
> > '#interrupt-controller' (and interrupt-map always has
> > #interrupt-controller). So your overlay just needs 'interrupts = <1>'
> > for INTA and it should all just work.  
> 
> Yes, I tried some stuffs in that way...
> > 
> > That of course implies that we need interrupt properties in all the
> > bridges which I was hoping to avoid. In the ACPI case, for DT
> > interrupt parsing to work, we're going to need to end up in an
> > 'interrupt-controller' node somewhere. I think the options are either  
> 
> ... and I went up to that point.
> Further more with that way, we need to update the addr value retrieved
> from the device requesting the interrupt.
>   https://elixir.bootlin.com/linux/latest/source/drivers/of/irq.c#L343
> Indeed, with the current 'interrupt-map' at bridges level, a addr value
> update is needed at the PCI device level if the interrupt is requested
> from some PCI device children.
> This is were my (not so good) interrupt-ranges property could play a
> role.
> 
> > we walk interrupt-map properties up to the host bridge which then
> > points to something or the PCI device is the interrupt controller. I
> > think the PCI device is the right place. How the downstream interrupts  
> 
> Agree, the PCI device seems to be the best candidate.
> 
> > are routed to PCI interrupts are defined by the device. That would
> > work the same way for both DT and ACPI. If you are concerned about
> > implementing in each driver needing this, some library functions can
> > mitigate that.
> > 
> > I'm trying to play around with the IRQ domains and get this to work,
> > but not having any luck yet.  
> 

Got some piece of code creating an interrupt controller at PCI device level.
To have it working, '#interrupt-cell = <1>' and 'interrupt-controller'
properties need to be set in the PCI device DT node.

I can set them when the PCI device DT node is created (add them in
of_pci_add_properties()) but as this interrupt controller is specific to the
PCI device driver (it needs to be created after the pci_enable_device() call
and will probably be device specific with MSI), it would make sense to have
these properties set by the PCI device driver itself or in the overlay it
applies.

But these properties creation done by the device driver itself (or the
overlay) lead to memory leaks.
Indeed, we cannot add properties to an existing node without memory
leaks. When a property is removed, the property is not freed but moved
to the node->deadprops list (of_remove_property()).
The properties present in the list will be free once the node itself is
removed.
In our use-case, the node (PCI device node) is not removed when the driver
is removed and probe again (rmmod/insmod).

Do you have any opinion about the '#interrupt-cell' and
'interrupt-controller' properties creation:

- Created by of_pci_add_properties():
  No mem leak but done outside the specific device driver itself and done for
  all PCI devices.
  Maybe the driver will not create the interrupt controller, maybe it will
  prefer an other value for '#interrupt-cell', maybe it will handle MSI and
  will need to set other properties, ... All of these are device specific.

- Created by the device driver itself (or the overlay it applies):
  The mem leak is present. Any idea about a way to fix that or at least having
  a fix for some properties ?
  I was thinking about avoiding to export properties (of_find_property()) and
  so avoid references properties or introducing refcount on properties but
  these modifications touch a lot of drivers and subsystems and are subject
  to errors.
  That's said, checking a property presence based on its name can be done without
  exporting the property, as well as getting a single value. Iterating over array
  values need some more complicated code.


Best regards,
Hervé
