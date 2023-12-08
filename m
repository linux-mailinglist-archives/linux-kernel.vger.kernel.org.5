Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9000C80AF8F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574904AbjLHWQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjLHWQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:16:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEEA118
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 14:16:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9862C433C7;
        Fri,  8 Dec 2023 22:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702073780;
        bh=4jtOxyTXC1Zhc3BU449OCvozRrSno/0pGK9xBwiWzj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Dp9eSxukWivDGnnqLm5p/1dy7Fycj/b4VPi99MUlFRCHlyGjLCzShqX4wOwgNVjXc
         0nMkD//n2AOPmDzWG8i+ROc6PpEmWarre208FQsWrYdE9Br1tyPS7kT3ACy66f4ssG
         jmcj1F8opaDg0xM6/C7SxCDgEC0Fxo1zfeMpFWfsVzxpNdzglEoeS74stneAFvEKg7
         1z/btf3sNG6a8MCKSLPMdY6zTZU+66yq4s+Zdr5zidA8aR0ZozKZ6kYtupqqIt4SHl
         6slbDKkyVoQM8etCnOSEvxtI90E0+p8EiO/Bu1pO6eOuYaGF9MQbcRwGzBeBUjngkR
         lnP40GBp5HXNA==
Date:   Fri, 8 Dec 2023 16:16:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        chenhuacai@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6] pci: loongson: Workaround MIPS firmware MRRS settings
Message-ID: <20231208221618.GA834006@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201115028.84351-1-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 11:50:28AM +0000, Jiaxun Yang wrote:
> ...

> +		{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },

P.S. I notice most of these Device IDs are not in the lspci database
at https://admin.pci-ids.ucw.cz/read/PC/0014.  It's easy to add them;
there's a link at the bottom of that page.

Some, e.g., 0x7a09 (DEV_LS7A_PCIE_PORT0), are described as "PCI-to-PCI
Bridge".  I had the impression these were Root Ports.  If so, the
description could be more specific.

Bjorn
