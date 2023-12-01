Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A0080164F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjLAW1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjLAW1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:27:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33021BE8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:26:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06812C433CA;
        Fri,  1 Dec 2023 22:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701469619;
        bh=sXzWevrTmFEZUP1GjYu+eWjRhWPfbGw0G7P/NwqYxcs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mzYWVxI02WJPUypFGMvBAIJHVKWjsofkMH50162ajTM4uoW48JXcJqUqqzKRZh4Od
         X0W3naiHw5TIbIMjzygGx9kCbP/xMb/7AovCGqL5i7fjRnlycfrrJgPQ44gmXMoAEH
         OzfVShXaeA1WvbNcVulxbjrfm6pZW+ry4/rN9SNSCGj0mVNRcdwXXn+AiAqm3fHKMa
         W2h9G4elUNMuR8XNU6drZG0b3ApuwvEU3I4tzC32fssfYvba0ujWxSg+VeDTNBXKbn
         Jk+pfIgVWLKG5ZIMZxFuimK2ruad9L/IYdn+e+Htypiwv8qmcmRvmrdsnb+gMYxMQ6
         JSCB8kBJ8yiCw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50abbb23122so3788612e87.3;
        Fri, 01 Dec 2023 14:26:58 -0800 (PST)
X-Gm-Message-State: AOJu0YxWq7CpgEK/5FX1rDPjqQbJ/3ErlPIdN5tw2zFsAAIv6NXH1GV4
        g9zZXrae7MczU7/2IPlvjUBGYlu6o8CV4XQwDQ==
X-Google-Smtp-Source: AGHT+IFYQcq9rNStRsUKCcoXAXJOUjqDHbZ1z6vR1WPUs0Nnj8At+JXXc+IVMGmu5UwZw3jKCWJMlo1mo+u2Dyp2jtY=
X-Received: by 2002:a05:6512:203b:b0:50b:d1af:8ce6 with SMTP id
 s27-20020a056512203b00b0050bd1af8ce6mr1096529lfs.60.1701469617211; Fri, 01
 Dec 2023 14:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20231130165700.685764-1-herve.codina@bootlin.com>
In-Reply-To: <20231130165700.685764-1-herve.codina@bootlin.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 1 Dec 2023 16:26:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
Message-ID: <CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
To:     Herve Codina <herve.codina@bootlin.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 10:57=E2=80=AFAM Herve Codina <herve.codina@bootlin=
.com> wrote:
>
> Hi,
>
> The commit 407d1a51921e ("PCI: Create device tree node for bridge")
> creates of_node for PCI devices.
> During the insertion handling of these new DT nodes done by of_platform,
> new devices (struct device) are created.
> For each PCI devices a struct device is already present (created and
> handled by the PCI core).
> Creating a new device from a DT node leads to some kind of wrong struct
> device duplication to represent the exact same PCI device.
>
> This patch series first introduces device_{add,remove}_of_node() in
> order to add or remove a newly created of_node to an already existing
> device.
> Then it fixes the DT node creation for PCI devices to add or remove the
> created node to the existing PCI device without any new device creation.

I think the simpler solution is to get the DT node created earlier. We
are just asking for pain if the DT node is set for the device at
different times compared to static DT nodes.

The following fixes the lack of of_node link. The DT unittest fails
with the change though and I don't see why.

Also, no idea if the bridge part works because my qemu setup doesn't
create bridges (anyone got a magic cmdline to create them?).

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 9c2137dae429..46b252bbe500 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -342,8 +342,6 @@ void pci_bus_add_device(struct pci_dev *dev)
         */
        pcibios_bus_add_device(dev);
        pci_fixup_device(pci_fixup_final, dev);
-       if (pci_is_bridge(dev))
-               of_pci_make_dev_node(dev);
        pci_create_sysfs_dev_files(dev);
        pci_proc_attach_device(dev);
        pci_bridge_d3_update(dev);
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 51e3dd0ea5ab..e15eaf0127fc 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -31,6 +31,8 @@ int pci_set_of_node(struct pci_dev *dev)
                return 0;

        node =3D of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn=
);
+       if (!node && pci_is_bridge(dev))
+               of_pci_make_dev_node(dev);
        if (!node)
                return 0;

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ea476252280a..e50b07fe5a63 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6208,9 +6208,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
0x9a31, dpc_log_size);
  * before driver probing, it might need to add a device tree node as the f=
inal
  * fixup.
  */
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node=
);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node=
);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node=
);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node=
);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node=
);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node=
);

 /*
  * Devices known to require a longer delay before first config space acces=
s
