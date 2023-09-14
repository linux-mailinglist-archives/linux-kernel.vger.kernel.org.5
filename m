Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875F17A0796
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240268AbjINOnC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 10:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjINOnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:43:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 603071BE1;
        Thu, 14 Sep 2023 07:42:56 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38EEgPfY51324145, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38EEgPfY51324145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 22:42:25 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 14 Sep 2023 22:42:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 14 Sep 2023 22:42:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Thu, 14 Sep 2023 22:42:23 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v7 01/13] net:ethernet:realtek:rtase: Add pci table supported in this module
Thread-Topic: [PATCH net-next v7 01/13] net:ethernet:realtek:rtase: Add pci
 table supported in this module
Thread-Index: AQHZ5Vod6KPsJrX8j0u27fA5whG9T7AYwrUAgAGlWXA=
Date:   Thu, 14 Sep 2023 14:42:23 +0000
Message-ID: <edbc001d331944f69017af67f71990ef@realtek.com>
References: <20230912091830.338164-1-justinlai0215@realtek.com>
 <20230912091830.338164-2-justinlai0215@realtek.com>
 <b655f427-0c45-4df6-be7f-6adf743ea0d4@lunn.ch>
In-Reply-To: <b655f427-0c45-4df6-be7f-6adf743ea0d4@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > +/* the table of time unit
> > + * 4b'0000: 1.024us,    4b'0001: 2.048us,    4b'0010: 4.096us,
> > + * 4b'0011: 8.192us,    4b'0100: 16.384us,   4b'0101: 32.768us,
> > + * 4b'0110: 65.536us,   4b'0111: 131.072us,  4b'1000: 252.144us,
> > + * 4b'1001: 524.288us,  4b'1010: 1048.576us, 4b'1011: 2097.152us,
> > + * 4b'1100: 4194.304us, 4b'1101: 8388.608us, 4b'1110: 16777.216us,
> > + * 4b'1111: 33554.432us
> 
> This seems to be all comment. Where is the table?
> 
> > + *
> > + * the table of packet number unit
> > + * 2b'00: 1,
> > + * 2b'01: 2,
> > + * 2b'10: 4,
> > + * 2b'11: 16
> 
> Again, what use is this?
> 
> > + *
> > + * interrupt mitigation = count * unit
> > + * example: If want to set packet number mitigation be 64
> > + *          the number unit is set 3,
> > + *          and the number count is set 4
> > + *          If want to set time be 131.072us
> > + *          the time unit is set 4,
> > + *          and the time count is set 8
> > + */
> 
> Rather than a comment, how about a little function which does the calculation.
> Code can be just as good at explaining something as English text.

Hi, Andrew

This calculation is a bit complicated. We will rewrite this part as a fixed-unit calculation mitigation function in the next version. The time unit will be set to 16u, and the packet number unit will be set to 16.

> 
> > +     if (!dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)))
> > +             dev->features |= NETIF_F_HIGHDMA;
> > +     else if (dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(32)))
> > +             goto err_out_free_res;
> > +     else
> > +             pr_info("DMA_BIT_MASK: 32\n");
> 
> dev_info(). Don't use pr_ functions if you have a struct device.
> 
> > +static int rtase_init_one(struct pci_dev *pdev,
> > +                       const struct pci_device_id *ent) {
> > +     struct net_device *dev = NULL;
> > +     void __iomem *ioaddr = NULL;
> > +     struct rtase_private *tp;
> > +     int ret;
> > +
> > +     if (!pdev->is_physfn && pdev->is_virtfn) {
> > +             pr_info("This module does not support a virtual function.");
> > +             return -EINVAL;
> > +     }
> > +
> > +     pr_info("Automotive Switch Ethernet driver loaded\n");
> 
> dev_dbg(), or nothing at all.
> 
> > +
> > +     ret = rtase_init_board(pdev, &dev, &ioaddr);
> > +     if (ret != 0)
> > +             return ret;
> > +
> > +     tp = netdev_priv(dev);
> > +     tp->mmio_addr = ioaddr;
> > +     tp->dev = dev;
> > +     tp->pdev = pdev;
> > +
> > +     /* identify chip attached to board */
> > +     if (!rtase_check_mac_version_valid(tp)) {
> > +             return dev_err_probe(&pdev->dev, -ENODEV,
> > +                                  "unknown chip version, contact
> rtase maintainers (see MAINTAINERS file)\n");
> > +     }
> > +
> > +     dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
> > +     if (!dev->tstats)
> > +             goto err_out_1;
> > +
> > +     rtase_init_software_variable(tp);
> > +     rtase_init_hardware(tp);
> > +
> > +     ret = rtase_alloc_interrupt(pdev, tp);
> > +     if (ret < 0) {
> > +             pr_err("unable to alloc MSIX/MSI\n");
> > +             goto err_out_1;
> > +     }
> > +
> > +     rtase_init_netdev_ops(dev);
> > +
> > +     dev->features |= NETIF_F_HW_VLAN_CTAG_TX |
> > + NETIF_F_HW_VLAN_CTAG_RX;
> > +
> > +     dev->features |= NETIF_F_IP_CSUM;
> > +     dev->features |= NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_TSO;
> > +     dev->features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
> > +     dev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO
> |
> > +                        NETIF_F_RXCSUM |
> NETIF_F_HW_VLAN_CTAG_TX |
> > +                        NETIF_F_HW_VLAN_CTAG_RX;
> > +     dev->hw_features |= NETIF_F_RXALL;
> > +     dev->hw_features |= NETIF_F_RXFCS;
> > +     dev->hw_features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
> > +     dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO
> |
> > +                          NETIF_F_HIGHDMA;
> > +     dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> > +     netif_set_tso_max_size(dev, LSO_64K);
> > +     netif_set_tso_max_segs(dev, NIC_MAX_PHYS_BUF_COUNT_LSO2);
> > +
> > +     rtase_get_mac_address(dev);
> > +
> > +     tp->tally_vaddr = dma_alloc_coherent(&pdev->dev,
> > +
> sizeof(*tp->tally_vaddr),
> > +                                          &tp->tally_paddr,
> > +                                          GFP_KERNEL);
> > +     if (!tp->tally_vaddr) {
> > +             ret = -ENOMEM;
> > +             goto err_out;
> > +     }
> > +
> > +     rtase_tally_counter_clear(tp);
> > +
> > +     pci_set_drvdata(pdev, dev);
> > +
> > +     ret = register_netdev(dev);
> > +     if (ret != 0)
> > +             goto err_out;
> > +
> > +     netdev_info(dev, "%pM, IRQ %d\n", dev->dev_addr, dev->irq);
> 
> netdev_dbg(), or nothing at all.
> 
>         Andrew

Thank you for your suggestion, I will correct it.
