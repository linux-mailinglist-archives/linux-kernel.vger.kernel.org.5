Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E1D770957
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjHDUFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjHDUFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:05:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BAFE6F;
        Fri,  4 Aug 2023 13:05:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe2bc2701bso22940195e9.2;
        Fri, 04 Aug 2023 13:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691179509; x=1691784309;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rvWT2sQ7N9U9Zb6KVsithcYj38CQbZTky74QGRmoRY=;
        b=BvGOobWVWf4ysT+wnQ1PW2ZpYAXt1DNbQcvfBsizwE0WVWNRvMAt4OetoKzywLCSwD
         IPdfZC+ytWh6PkNmfb+2Wuobj2/miWhEKnpljE+pNEpOusVVzEpCziuxiLXmVjVEj0tP
         OBlRLWz0DwdpKCWbLODbwbadRvLt1lyo37pv7RlqU20VWsWOhRuXIQNFE1K+1M8voFfG
         ZUS7NlVP86Z/17H4eNf2JDOF7w2HEH+S6+kpmbutvawsn4xeCSynU2Y5J57sN2XiykuR
         ZYikvYFVT5vOd3OGdMV/wJYxvp920/I1diUauIJaWDETsqfK71FMqzPuiAmNHEr0ECO5
         AWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691179509; x=1691784309;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rvWT2sQ7N9U9Zb6KVsithcYj38CQbZTky74QGRmoRY=;
        b=KoX2RIdXB2UCTeJdAJcOlftbHFfqyvRF52xBTAjAKpQuLJ/+sMwgSuX//kX25Bk9gd
         TCeXT08lFZSkSEcMwG5y1zp5XXvMLj6v2USg3/3RXZB2js/GaC40Q/GeEwncbmINiRKQ
         mBtMrrJbmyw1jR3302u1LAD3hI7JNtf93kECm0r9sRdbkzWSyeIV0c2cXDpheXiizzjX
         SuKv0z0WvpFiSg6q9bApRPaZHizV4j7NPi29qaAIRrKTl2BOJBfmUVK5PFX98RXaSUO5
         B5j3/fgl9AfcAcU1QMM4DUM9HWVZXXctpshfBgJC9e2ZdYYyocBQMRlaiKN3V8GLlgT1
         P4yg==
X-Gm-Message-State: AOJu0YwtDIN6coa3Lzm9Ft2pfILWftr9NJa8p8ULmHqucAZfPaf3oSA6
        /KB3vlc+RK5kTVkkZou3Upg=
X-Google-Smtp-Source: AGHT+IFNubeAsIek+KXlNBA/0Cu5BtBzQYHOuwZpHJuCh1134zjShzjDT0pCQt+D7F6I+gC6LD6eEQ==
X-Received: by 2002:a05:600c:2105:b0:3fc:27:7e46 with SMTP id u5-20020a05600c210500b003fc00277e46mr2280571wml.3.1691179508096;
        Fri, 04 Aug 2023 13:05:08 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c519:e700:cd4e:df88:446:27f3? (dynamic-2a01-0c23-c519-e700-cd4e-df88-0446-27f3.c23.pool.telefonica.de. [2a01:c23:c519:e700:cd4e:df88:446:27f3])
        by smtp.googlemail.com with ESMTPSA id 25-20020a05600c021900b003fe4ca8decdsm1277200wmi.31.2023.08.04.13.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 13:05:07 -0700 (PDT)
Message-ID: <f4ba8384-7155-0396-e89f-e8f8c5b25f19@gmail.com>
Date:   Fri, 4 Aug 2023 22:05:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     justinlai0215 <justinlai0215@realtek.com>, kuba@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20230803082513.6523-1-justinlai0215@realtek.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] net/ethernet/realtek: Add Realtek automotive PCIe driver
In-Reply-To: <20230803082513.6523-1-justinlai0215@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.2023 10:25, justinlai0215 wrote:
> This patch is to add the ethernet device driver for the PCIe interface of Realtek Automotive Ethernet Switch,
> applicable to RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.
> 
- A real author's name would be nice.
- A link to the chip data sheets would be helpful.
- Read the netdev code rules.
  - The net-next patch annotation is missing.
  - Reverse christmas tree
  - ..
- Not adding a MAINTAINERS entry?

In general the code quality doesn't meet mainline requirements, e.g. there's
a lot of unnecessary casting.

And no PHY handling at all in the driver?

> Signed-off-by: justinlai0215 <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/Kconfig          |   17 +
>  drivers/net/ethernet/realtek/Makefile         |    1 +
>  drivers/net/ethernet/realtek/rtase/Makefile   |   10 +
>  drivers/net/ethernet/realtek/rtase/rtase.h    |  654 +++
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 4797 +++++++++++++++++
>  .../net/ethernet/realtek/rtase/rtase_sriov.c  |  328 ++
>  .../net/ethernet/realtek/rtase/rtase_sriov.h  |   30 +
>  7 files changed, 5837 insertions(+)
>  create mode 100644 drivers/net/ethernet/realtek/rtase/Makefile
>  create mode 100644 drivers/net/ethernet/realtek/rtase/rtase.h
>  create mode 100644 drivers/net/ethernet/realtek/rtase/rtase_main.c
>  create mode 100644 drivers/net/ethernet/realtek/rtase/rtase_sriov.c
>  create mode 100644 drivers/net/ethernet/realtek/rtase/rtase_sriov.h
> 
> diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
> index 93d9df55b361..0250d1c3874b 100644
> --- a/drivers/net/ethernet/realtek/Kconfig
> +++ b/drivers/net/ethernet/realtek/Kconfig
> @@ -113,4 +113,21 @@ config R8169
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called r8169.  This is recommended.
>  
> +config RTASE
> +	tristate "Realtek Automotive Switch 9054/9068/9072/9075/9068/9071 PCIe Interface support"
> +	depends on PCI
> +	select CRC32
> +	help
> +	  Say Y here if you have a Realtek Ethernet adapter belonging to
> +	  the following families:
> +	  RTL9054 5GBit Ethernet
> +	  RTL9068 5GBit Ethernet
> +	  RTL9072 5GBit Ethernet
> +	  RTL9075 5GBit Ethernet
> +	  RTL9068 5GBit Ethernet
> +	  RTL9071 5GBit Ethernet
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called rtase.  This is recommended.
> +
>  endif # NET_VENDOR_REALTEK
> diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
> index 2e1d78b106b0..0c1c16f63e9a 100644
> --- a/drivers/net/ethernet/realtek/Makefile
> +++ b/drivers/net/ethernet/realtek/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_8139TOO) += 8139too.o
>  obj-$(CONFIG_ATP) += atp.o
>  r8169-objs += r8169_main.o r8169_firmware.o r8169_phy_config.o
>  obj-$(CONFIG_R8169) += r8169.o
> +obj-$(CONFIG_RTASE) += rtase/
> diff --git a/drivers/net/ethernet/realtek/rtase/Makefile b/drivers/net/ethernet/realtek/rtase/Makefile
> new file mode 100644
> index 000000000000..61fe2f9e0344
> --- /dev/null
> +++ b/drivers/net/ethernet/realtek/rtase/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright(c) 2023 Realtek Semiconductor Corp. All rights reserved.
> +
> +#
> +# Makefile for the Realtek PCIe driver
> +#
> +
> +obj-$(CONFIG_RTASE) += rtase.o
> +
> +rtase-objs := rtase_main.o rtase_sriov.o
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
> new file mode 100644
> index 000000000000..766193914373
> --- /dev/null
> +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> @@ -0,0 +1,654 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  rtase is the Linux device driver released for Realtek Automotive Switch
> + *  controllers with PCI-Express interface.
> + *
> + *  Copyright(c) 2023 Realtek Semiconductor Corp. All rights reserved.
> + *
> + *  Author:
> + *  Realtek ARD software team
> + *  No. 2, Innovation Road II, Hsinchu Science Park, Hsinchu 300, Taiwan
> + *
> + */
> +
> +/******************************************************************************
> + *  This product is covered by one or more of the following patents:
> + *  US6,570,884, US6,115,776, and US6,327,625.
> + ******************************************************************************/
> +
> +#ifndef RTASE_H_
> +#define RTASE_H_
> +
> +#include <linux/version.h>
> +#include <linux/ethtool.h>
> +
> +#define RTL_ALLOC_SKB_INTR(napi, length) napi_alloc_skb(&(napi), length)
> +
What's the benefit of this?

> +#define NETIF_F_ALL_CSUM NETIF_F_CSUM_MASK
> +
Dito

> +#define ENABLE_RTASE_PROCFS
> +
Use standard kernel means instead of adding proprietary procsfs stuff.

> +#define NETIF_F_HW_VLAN_RX NETIF_F_HW_VLAN_CTAG_RX
> +#define NETIF_F_HW_VLAN_TX NETIF_F_HW_VLAN_CTAG_TX
> +
> +#define CONFIG_SRIOV 1
> +
Why not always enable it?

> +#ifndef NETIF_F_RXALL
> +#define NETIF_F_RXALL 0u
> +#endif
> +
All this stuff seems to come from a vendor driver that has to support
multiple kernel versions. Thi scan be simplified now.

> +#ifndef NETIF_F_RXFCS
> +#define NETIF_F_RXFCS 0u
> +#endif
> +
> +#ifndef SET_NETDEV_DEV
> +#define SET_NETDEV_DEV(net, pdev)
> +#endif
> +
> +#ifndef SET_MODULE_OWNER
> +#define SET_MODULE_OWNER(dev)
> +#endif
> +
> +#ifndef SA_SHIRQ
> +#define SA_SHIRQ IRQF_SHARED
> +#endif
> +
> +#ifndef NETIF_F_GSO
> +#define gso_size tso_size
> +#define gso_segs tso_segs
> +#endif
> +
> +#ifndef dma_mapping_error
> +#define dma_mapping_error(a, b) 0
> +#endif
> +
> +#ifndef netif_err
> +#define netif_err(a, b, c, d)
> +#endif
> +
> +#ifndef FALSE
> +#define FALSE 0
> +#endif
> +
> +#ifndef TRUE
> +#define TRUE 1
> +#endif
> +
> +#ifndef false
> +#define false 0
> +#endif
> +
> +#ifndef true
> +#define true 1
> +#endif
> +
> +/* the low 32 bit address of receive buffer must be 8-byte alignment. */
> +#define RTK_RX_ALIGN (8u)
> +
> +#define NAPI_SUFFIX   "-NAPI"
> +#define RTASE_VERSION "1.002.06" NAPI_SUFFIXRemove this

> +#define MODULENAME    "rtase"
> +#define PFX           MODULENAME ": "
> +
> +#define GPL_CLAIM \
> +	"rtase  Copyright (C) 2021  Realtek ARD software team\n\
> +	This program comes with ABSOLUTELY NO WARRANTY;\n\
> +	for details, please see <http://www.gnu.org/licenses/>.\n\
> +	This is free software, and you are welcome to redistribute it under certain conditions; \n \
> +	see <http://www.gnu.org/licenses/>.\n"
> +
> +#ifdef RTASE_DEBUG
> +#define assert(expr)                                                                               \
> +	do {                                                                                       \
> +		if (!(expr)) {                                                                     \
> +			pr_info("Assertion failed! %s,%s,%s,line=%d\n", #expr, __FILE__, __func__, \
> +				__LINE__);                                                         \
> +		}                                                                                  \
> +	} while (0)
> +#define dprintk(fmt, args...) pr_info(PFX fmt, ##args)
> +#else
> +#define assert(expr)
> +#define dprintk(fmt, args...)
> +#endif /* RTASE_DEBUG */
> +
> +#define RTASE_MSG_DEFAULT (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_IFUP | NETIF_MSG_IFDOWN)
> +
> +#define TX_BUFFS_AVAIL(ring) ((ring)->dirty_idx + NUM_DESC - (ring)->cur_idx - 1)
> +
> +/* MAC address length */
> +#ifndef MAC_ADDR_LEN
> +#define MAC_ADDR_LEN 6u
> +#endif
> +
> +#ifndef NETIF_F_TSO6
> +#define NETIF_F_TSO6 0u
> +#endif
> +
> +#define RX_DMA_BURST_256       4u
> +#define TX_DMA_BURST_UNLIMITED 7u
> +#define JUMBO_FRAME_1K         (ETH_DATA_LEN)
> +#define JUMBO_FRAME_9K         ((9 * 1024) - ETH_HLEN - VLAN_HLEN - ETH_FCS_LEN)
> +
> +/* 3 means InterFrameGap = the shortest one */
> +#define INTERFRAMEGAP 0x03u
> +
> +#define RTASE_REGS_SIZE     (256u)
> +#define RTASE_PCI_REGS_SIZE (0x100)
> +#define RTASE_NAPI_WEIGHT   (64)
> +
> +#define RTASE_TX_TIMEOUT (6 * HZ)
> +
> +#define TX_DUPLICATE_DIRTYIDX_COUNT 3u
> +/* Set timeout to 1s (0x7735940 = 1s / 8ns) */
> +#define TIMEOUT_SET_TIME 0x7735940u
> +
> +#define VLAN_FILTER_ENTRY_NUM 32u
> +/* Number of Tx queues */
> +#define NUM_TX_QUEUE 8u
> +/* Number of Rx queues */
> +#define NUM_RX_QUEUE 4u
> +/* Number of Tx descriptor registers */
> +#define NUM_TX_DESC 1024u
> +
> +/* default tx interrupt mitigation, num = 64, time = 131.072us */
> +#define TX_INT_MITIGATION 0x3448u
> +/* default rx interrupt mitigation, num = 64, time = 131.072us */
> +#define RX_INT_MITIGATION 0x3448u
> +
> +#define NUM_MSIX 4u
> +
> +/* 0x05F3 = 1522bye + 1 */
> +#define RX_BUF_SIZE 0x05F3u
> +
> +/* write/read MMIO register */
> +#define RTL_W8(reg, val8)   writeb((val8), ioaddr + (reg))
> +#define RTL_W16(reg, val16) writew((val16), ioaddr + (reg))
> +#define RTL_W32(reg, val32) writel((val32), ioaddr + (reg))
> +#define RTL_R8(reg)         readb(ioaddr + (reg))
> +#define RTL_R16(reg)        readw(ioaddr + (reg))
> +#define RTL_R32(reg)        readl(ioaddr + (reg))
> +
> +#ifndef DMA_64BIT_MASK
> +#define DMA_64BIT_MASK 0xFFFFFFFFFFFFFFFFuLL
> +#endif
> +
> +#ifndef DMA_32BIT_MASK
> +#define DMA_32BIT_MASK 0x00000000FFFFFFFFuLL
> +#endif
> +
> +/*****************************************************************************/
> +#define RTL_NETIF_RX_SCHEDULE_PREP(dev, napi) napi_schedule_prep(napi)
> +#define __RTL_NETIF_RX_SCHEDULE(dev, napi)    __napi_schedule(napi)
> +
> +/*****************************************************************************/
> +#ifndef module_param
> +#define module_param(v, t, p) MODULE_PARM(v, "i")
> +#endif
> +
> +#ifndef PCI_DEVICE
> +#define PCI_DEVICE(vend, dev) \
> +	.vendor = (vend), .device = (dev), .subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
> +#endif
> +
> +/*****************************************************************************/
> +/* RTASE_registers */
> +#define MAC0                0x0000u
> +#define MAC4                0x0004u
> +#define MAR0                0x0008u
> +#define MAR1                0x000Cu
> +#define DTCCR0              0x0010u
> +#define DTCCR4              0x0014u
> +#define FCR                 0x0018u
> +#define LBK_CTRL            0x001Au
> +#define TX_DESC_START_ADDR0 0x0020u
> +#define TX_DESC_START_ADDR4 0x0024u
> +#define TX_DESC_COMMAND     0x0028u
> +#define CHIP_CMD            0x0037u
> +#define IMR0                0x0038u
> +#define ISR0                0x003Cu
> +#define IMR1                0x0800u
> +#define ISR1                0x0802u
> +#define TX_CONFIG_0         0x0040u
> +#define RX_CONFIG_0         0x0044u
> +#define RX_CONFIG_1         0x0046u
> +#define EEM                 0x0050u
> +#define TDFNR               0x0057u
> +#define TPPOLL              0x0090u
> +#define PDR                 0x00B0u
> +#define FIFOR               0x00D3u
> +#define PCPR                0x00D8u
> +#define RMS                 0x00DAu
> +#define CPLUS_CMD           0x00DAu
> +#define Q0_RX_DESC_ADDR0    0x00E4u
> +#define Q0_RX_DESC_ADDR4    0x00E8u
> +#define Q1_RX_DESC_ADDR0    0x4000u
> +#define Q1_RX_DESC_ADDR4    0x4004u
> +#define MTPS                0x00ECu
> +#define MISC                0x00F2u
> +#define TCTR0               0x0048u
> +#define TIMEOUT0_ADDR       0x0058u
> +
> +#define TFUN_CTRL   0x0400u
> +#define TX_CONFIG_1 0x203Eu
> +#define TOKSEL      0x2046u
> +#define TXQCRDT_0   0x2500u
> +#define RFIFONFULL  0x4406u
> +#define VQCTRL      0x4800u
> +#define INT_MITI_TX 0x0A00u
> +#define INT_MITI_RX 0x0A80u
> +
> +#define VFMSGDATA_0 0x7100u
> +#define VFMSGDATA_2 0x7104u
> +#define PFMSGICRREQ 0x7140u
> +#define PFMSGIMR    0x7148u
> +#define PFMSGVF1    0x7200u
> +
> +#define VF_MAC_0 0x7294u
> +#define VF_MAC_2 0x7296u
> +#define VF_MAC_4 0x7298u
> +
> +#define RX_PCP_TABLE     0x72D4u
> +#define VLAN_ENTRY_MEM_0 0x7234u
> +#define VLAN_ENTRY_0     0xAC80u
> +
> +/* RTASE_register_content */
> +/* InterruptStatusBits 0 */
> +#define TOK7     BIT(30)
> +#define TOK6     BIT(28)
> +#define TOK5     BIT(26)
> +#define TOK4     BIT(24)
> +#define MBX      BIT(16)
> +#define TIMEOUT0 BIT(14)
> +#define FOVW     BIT(6)
> +#define RDU      BIT(4)
> +#define TOK      BIT(2)
> +#define ROK      BIT(0)
> +
> +/* InterruptStatusBits 1~3 */
> +#define Q_TOK BIT(4)
> +#define Q_RDU BIT(1)
> +#define Q_ROK BIT(0)
> +
> +/* ChipCmdRegBits */
> +#define STOP_REQ      BIT(7)
> +#define STOP_REQ_DONE BIT(6)
> +#define RE            BIT(3)
> +#define TE            BIT(2)
> +
> +/* Cfg9346Bits */
> +#define EEM_Unlock 0xC0u
> +
> +/* Receive Configuration 0 */
> +#define RX_SINGLE_FETCH  BIT(14)
> +#define RX_SINGLE_TAG    BIT(13)
> +#define RX_MX_DMA_MASK   0x7
> +#define RX_MX_DMA_SHIFT  8u
> +#define ACPT_FLOW        BIT(7)
> +#define ACCEPT_ERR       BIT(5)
> +#define ACCEPT_RUNT      BIT(4)
> +#define ACCEPT_BROADCAST BIT(3)
> +#define ACCEPT_MULTICAST BIT(2)
> +#define ACCEPT_MYPHYS    BIT(1)
> +#define ACCEPT_ALLPHYS   BIT(0)
> +#define ACCEPT_MASK                                                                 \
> +	(ACPT_FLOW | ACCEPT_ERR | ACCEPT_RUNT | ACCEPT_BROADCAST | ACCEPT_MULTICAST \
> +	 | ACCEPT_MYPHYS | ACCEPT_ALLPHYS)
> +
> +/* Receive Configuration 1 */
> +#define RX_MAX_FETCH_DESC_MASK  0x1F
> +#define RX_MAX_FETCH_DESC_SHIFT 11u
> +#define RX_NEW_DESC_FORMAT_EN   BIT(8)
> +#define OUTER_VLAN_DETAG_EN     BIT(7)
> +#define INNER_VLAN_DETAG_EN     BIT(6)
> +#define PCIE_NEW_FLOW           BIT(2)
> +#define PCIE_RELOAD_En          BIT(0)
> +
> +/* TxConfigBits */
> +#define TX_INTER_FRAME_GAP_MASK  0x3u
> +#define TX_INTER_FRAME_GAP_SHIFT 24u
> +#define TX_DMA_MASK              0x7u
> +/* DMA burst value (0-7) is shift this many bits */
> +#define TX_DMA_SHIFT 8u
> +
> +/* TFunCtrl */
> +#define TX_NEW_DESC_FORMAT_EN BIT(0)
> +
> +/* TxDescCommand */
> +#define TX_DESC_CMD_CS BIT(15)
> +#define TX_DESC_CMD_WE BIT(14)
> +
> +/* CPlusCmd */
> +#define FORCE_RXFLOW_EN BIT(11)
> +#define FORCE_TXFLOW_EN BIT(10)
> +#define RX_CHKSUM       BIT(5)
> +
> +/* MISC */
> +#define RX_DV_GATE_EN BIT(3)
> +
> +/* ResetCounterCommand */
> +#define COUNTER_RESET BIT(0)
> +/* DumpCounterCommand */
> +#define COUNTER_DUMP BIT(3)
> +
> +/* OCP access */
> +#define OCPR_WRITE          0x80000000u
> +#define OCPR_ADDR_REG_SHIFT 16u
> +
> +/* MCU Command */
> +#define TX_FIFO_EMPTY BIT(5)
> +#define RX_FIFO_EMPTY BIT(4)
> +
> +/* Function Control Register */
> +#define FCR_TX_LOOPBACK_EN BIT(9)
> +#define FCR_TE             BIT(8)
> +#define FCR_RXQ_MASK       0x3u
> +#define FCR_RXQ_SHIFT      4u
> +#define FCR_MAR_EN         BIT(3)
> +#define FCR_BAR_EN         BIT(2)
> +#define FCR_VLAN_FTR_EN    BIT(1)
> +#define FCR_RE             BIT(0)
> +
> +/* Loopback Control */
> +#define LBK_ATLD BIT(1)
> +#define LBK_CLR  BIT(0)
> +
> +/* PCP Register */
> +#define PCPR_VLAN_FTR_EN BIT(6)
> +
> +/*RTASE_register_content END */
> +
> +/* _DescStatusBit */
> +#define DESC_OWN BIT(31) /* Descriptor is owned by NIC */
> +#define RING_END BIT(30) /* End of descriptor ring */
> +
> +/* Tx private */
> +/*------ offset 0 of tx descriptor ------*/
> +#define TX_FIRST_FRAG BIT(29) /* Tx First segment of a packet */
> +#define TX_LAST_FRAG  BIT(28) /* Tx Final segment of a packet */
> +#define GIANT_SEND_V4 BIT(26) /* TCP Giant Send Offload V4 (GSOv4) */
> +#define GIANT_SEND_V6 BIT(25) /* TCP Giant Send Offload V6 (GSOv6) */
> +#define TX_VLAN_TAG   BIT(17) /* Add VLAN tag */
> +
> +/*------ offset 4 of tx descriptor ------*/
> +#define TX_UDPCS_C BIT(31) /* Calculate UDP/IP checksum */
> +#define TX_TCPCS_C BIT(30) /* Calculate TCP/IP checksum */
> +#define TX_IPCS_C  BIT(29) /* Calculate IP checksum */
> +#define TX_IPV6F_C BIT(28) /* Indicate it is an IPv6 packet */
> +
> +/* Rx private */
> +/*------ offset 28 of rx descriptor ------*/
> +#define RX_FIRST_FRAG BIT(25) /* Rx First segment of a packet */
> +#define RX_LAST_FRAG  BIT(24) /* Rx Final segment of a packet */
> +#define RX_RES        BIT(20)
> +#define RX_RUNT       BIT(19)
> +#define RX_RWT        BIT(18)
> +#define RX_CRC        BIT(16)
> +
> +#define RX_V6F           BIT(31)
> +#define RX_V4F           BIT(30)
> +#define RX_UDPT          BIT(29)
> +#define RX_TCPT          BIT(28)
> +#define RX_IPF           BIT(26) /* IP checksum failed */
> +#define RX_UDPF          BIT(25) /* UDP/IP checksum failed */
> +#define RX_TCPF          BIT(24) /* TCP/IP checksum failed */
> +#define RX_LBK_FIFO_FULL BIT(17) /* Loopback FIFO Full */
> +#define RX_VLAN_TAG      BIT(16) /* VLAN tag available */
> +/* _DescStatusBit END */
> +
> +/* sw_flag_content */
> +#define SWF_SRIOV_ENABLED BIT(0)
> +#define SWF_MSI_ENABLED   BIT(1)
> +#define SWF_MSIX_ENABLED  BIT(2)
> +
> +#define RSVD_MASK 0x3FFFC000u
> +
> +typedef struct {
> +	u32 opts1;
Most likely this should be __le32.
Similar for the other descriptor fields.

> +	u32 opts2;
> +	u64 addr;
> +	u32 opts3;
> +	u32 reserved1;
> +	u32 reserved2;
> +	u32 reserved3;
> +} tx_desc;
> +
> +typedef union {
> +	struct {
> +		u64 header_buf_addr;
> +		u32 reserved1;
> +		u32 opts_header_len;
> +		u64 addr;
> +		u32 reserved2;
> +		u32 opts1;
> +	} desc_cmd;
> +
> +	struct {
> +		u32 reserved1;
> +		u32 reserved2;
> +		u32 rss;
> +		u32 opts4;
> +		u32 reserved3;
> +		u32 opts3;
> +		u32 opts2;
> +		u32 opts1;
> +	} desc_status;
> +
> +	struct {
> +		u32 reserved1;
> +		u32 reserved2;
> +		u32 reserved3;
> +		u32 reserved4;
> +		u32 time_stamp_0_31;
> +		u32 time_stamp_32_63;
> +		u32 time_stamp_64_79;
> +		u32 opts1;
> +	} desc_ptp;
> +
> +	struct {
> +		u32 rsvd1;
> +		u32 rsvd2;
> +		u32 rsvd3;
> +		u32 rsvd4;
> +		u32 rsvd5;
> +		u32 rsvd6;
> +		u32 opts2;
> +		u32 opts1;
> +	} desc_rsc;
> +} rx_desc;
> +
> +#define CMD_DBG_READ        1u
> +#define CMD_DBG_WRITE       2u
> +#define CMD_REG_READ16      3u
> +#define CMD_REG_WRITE16     4u
> +#define CMD_REG_READ32      5u
> +#define CMD_REG_WRITE32     6u
> +#define CMD_GET_RXQOS       7u
> +#define CMD_SET_RXQOS       8u
> +#define CMD_GET_TIMSIG      9u
> +#define CMD_SET_TIMSIG      10u
> +#define SIO_PRIV_RTK_REG    (SIOCDEVPRIVATE + 6)
> +#define SIO_PRIV_RTK_RXQOS  (SIOCDEVPRIVATE + 7)
> +#define SIO_TIMEOUT_SIG_SET (SIOCDEVPRIVATE + 8)
> +#define SIO_PRIV_RTK_PTM    (SIOCDEVPRIVATE + 9)
> +#define SIO_PRIV_RTK_INFO   (SIOCDEVPRIVATE + 10)
> +#define TIMEOUT_INIT        0
> +#define TIMEOUT_ERROR       99
> +#define DWORD_MOD           16
> +
> +struct rtase_ptm_cmd_t {
> +	/* disable:0, enable:1 */
> +	u8 enable;
> +	u8 type;
> +	u8 bits;
> +	u32 reg_addr;
> +	u32 ptm_addr;
> +	u32 reg_value;
> +	u64 ptp_second;
> +	u32 ptp_nano_second;
> +	u64 ptm_time;
> +};
> +
> +struct reg_rw {
> +	u16 cmd;
> +	u16 addr;
> +	u32 val;
> +};
> +
> +struct rtk_qos {
> +	u16 cmd;
> +	u8 pcp;
> +	u8 tc;
> +};
> +
> +struct rtk_timeout_sig {
> +	u16 cmd;
> +	u16 state;
> +};
> +
> +#ifdef CONFIG_SRIOV
> +struct vf_info {
> +	struct pci_dev *vf_pci_dev;
> +	u8 status;
> +	u8 vf_mac[ETH_ALEN];
> +	u32 mc_filter[2];
> +};
> +#endif
> +
> +#define NUM_DESC                1024u
> +#define RTASE_TX_RING_DESC_SIZE (NUM_DESC * sizeof(tx_desc))
> +#define RTASE_RX_RING_DESC_SIZE (NUM_DESC * sizeof(rx_desc))
> +#define VLAN_ENTRY_CAREBIT      0xF0000000u
> +
> +/* txqos hardware definitions */
> +#define RTASE_1T_CLOCK            64u
> +#define RTASE_1T_POWER            10000000u
> +#define RTASE_IDLESLOPE_INT_SHIFT 25u
> +
> +struct rtase_int_vector {
> +	struct rtase_private *tp;
> +	unsigned int irq;
> +	u8 status;
> +	u8 name[20];
> +	u16 index;
> +	u16 imr_addr;
> +	u16 isr_addr;
> +	u32 imr;
> +	struct list_head ring_list;
> +	struct napi_struct napi;
> +	int weight;
> +	int (*poll)(struct napi_struct *napi, int budget);
> +};
> +
> +struct rtase_ring {
> +	struct rtase_int_vector *ivec;
> +	void *desc;
> +	dma_addr_t phy_addr;
> +	u32 cur_idx;
> +	u32 dirty_idx;
> +	u32 priv_dirty_idx;
> +	u8 duplicate_dirty_count;
> +	u16 index;
> +
> +	struct sk_buff *skbuff[NUM_DESC];
> +	union {
> +		u32 len[NUM_DESC];
> +		dma_addr_t data_phy_addr[NUM_DESC];
> +	} mis;
> +
> +	struct list_head ring_entry;
> +	s32 (*ring_handler)(struct rtase_ring *ring, s32 budget);
> +};
> +
> +struct rtase_txqos {
> +	s32 hicredit;
> +	s32 locredit;
> +	s32 idleslope;
> +	s32 sendslope;
> +};
> +
> +struct rtase_private {
> +	void __iomem *mmio_addr; /* memory map physical address */
> +
> +#ifdef RDBG_MSIX
> +	u8 __iomem *msix_addr;
> +#endif
> +
> +	u32 sw_flag;
> +	struct work_struct msg_work;
> +	struct work_struct watchdog_work;
> +	u32 mc_filter[2];
> +
> +	struct pci_dev *pdev; /* Index of PCI device */
> +	struct net_device *dev;
> +	spinlock_t lock;      /* spin lock flag */
> +	u32 msg_enable;
> +	u16 max_jumbo_frame_size;
> +	u8 mcfg;
> +	u32 rx_buf_sz;
> +
> +	struct rtase_ring tx_ring[NUM_TX_QUEUE];
> +	struct rtase_txqos tx_qos[NUM_TX_QUEUE];
> +	struct rtase_ring rx_ring[NUM_RX_QUEUE];
> +	struct rtase_counters *tally_vaddr;
> +	dma_addr_t tally_paddr;
> +
> +	u32 vlan_filter_ctrl;
> +	u16 vlan_filter_vid[VLAN_FILTER_ENTRY_NUM];
> +
> +	struct delayed_work task;
> +	u8 hw_ic_ver_unknown;
> +	u8 random_mac;
> +	u8 org_mac_addr[MAC_ADDR_LEN];
> +
> +#ifdef ENABLE_RTASE_PROCFS
> +	/* Procfs support */
> +	struct proc_dir_entry *proc_dir;
> +#endif
> +#ifdef CONFIG_SRIOV
> +	struct vf_info *vf_info;
> +	u16 num_vfs;
> +	u16 total_vfs;
> +#endif
> +	struct msix_entry msix_entry[NUM_MSIX];
> +	struct rtase_int_vector int_vector[NUM_MSIX];
> +
> +	u16 tx_queue_ctrl;
> +	u16 func_tx_queue_num;
> +	u16 func_rx_queue_num;
> +	u16 int_nums;
> +	u16 tx_int_mit;
> +	u16 rx_int_mit;
> +
> +	/* timeout state */
> +	u16 timeout_state;
> +
> +	/* ptm */
> +	u8 ptm_support;
> +};
> +
> +/* mcfg */
> +#define CFG_METHOD_1       (0u)
> +#define CFG_METHOD_DEFAULT (1u)
> +
> +#define LSO_64K 64000
> +
> +#define NIC_MIN_PHYS_BUF_COUNT      (2)
> +#define NIC_MAX_PHYS_BUF_COUNT_LSO2 (16 * 4)
> +
> +#define GTTCPHO_SHIFT 18
> +
> +#define TCPHO_SHIFT 18u
> +#define TCPHO_MAX   0x3FFu
> +
> +#define MSS_MAX 0x07FFu /* MSS value */
> +
> +void rtase_hw_reset(const struct net_device *dev);
> +void rtase_tx_clear(struct rtase_private *tp);
> +void rtase_rx_clear(struct rtase_private *tp);
> +s32 rtase_init_ring(const struct net_device *dev);
> +void rtase_hw_start(const struct net_device *dev);
> +void rtase_hw_set_rx_packet_filter(struct net_device *dev);
> +void rtase_func_enable(const struct rtase_private *tp);
> +void rtase_func_disable(const struct rtase_private *tp);
> +
> +#endif /* RTASE_H_ */
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> new file mode 100644
> index 000000000000..96744bd7f6ac
> --- /dev/null
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -0,0 +1,4797 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  rtase is the Linux device driver released for Realtek Automotive Switch
> + *  controllers with PCI-Express interface.
> + *
> + *  Copyright(c) 2023 Realtek Semiconductor Corp. All rights reserved.
> + *
> + *  Author:
> + *  Realtek ARD software team
> + *  No. 2, Innovation Road II, Hsinchu Science Park, Hsinchu 300, Taiwan
> + *
> + */
> +
> +/******************************************************************************
> + *  This product is covered by one or more of the following patents:
> + *  US6,570,884, US6,115,776, and US6,327,625.
> + ******************************************************************************/
> +
> +#include <linux/module.h>
> +#include <linux/version.h>
> +#include <linux/cdev.h>
> +#include <linux/pci.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/delay.h>
> +#include <linux/if_vlan.h>
> +#include <linux/crc32.h>
> +#include <linux/interrupt.h>
> +#include <linux/in.h>
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
> +#include <linux/tcp.h>
> +#include <linux/init.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/prefetch.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mdio.h>
> +#include <net/ip6_checksum.h>
> +#include <net/pkt_cls.h>
> +
> +#include <linux/io.h>
> +#include <asm/irq.h>
> +
> +#include "rtase.h"
> +#ifdef CONFIG_SRIOV
> +#include "rtase_sriov.h"
> +#endif
> +
> +#ifdef ENABLE_RTASE_PROCFS
> +#include <linux/proc_fs.h>
> +#include <linux/seq_file.h>
> +#endif
> +
> +/* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
> + * The RTL chips use a 64 element hash table based on the Ethernet CRC.
> + */
> +static struct workqueue_struct *work_queue;
> +
> +#define _R(NAME, MAC, JUM_FRAME_SZ)                                       \
> +	{                                                                 \
> +		.name = NAME, .mcfg = MAC, .jumbo_frame_sz = JUM_FRAME_SZ \
> +	}
> +
> +static const struct {
> +	const char *name;
> +	u8 mcfg;
> +	u16 jumbo_frame_sz;
> +} rtl_chip_info[] = {_R("RTL9072", CFG_METHOD_1, JUMBO_FRAME_9K),
> +
> +		     _R("Unknown", CFG_METHOD_DEFAULT, JUMBO_FRAME_1K)};
> +#undef _R
> +
> +static struct pci_device_id rtase_pci_tbl[] = {
> +	{
> +		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x906A),
> +	},
> +	{
> +		0,
> +	},
> +};
> +
> +MODULE_DEVICE_TABLE(pci, rtase_pci_tbl);
> +MODULE_AUTHOR("Realtek ARD Software Team");
> +MODULE_DESCRIPTION("Realtek Automotive Switch Ethernet and Network PCIe Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(RTASE_VERSION);
> +
> +static struct {
> +	u32 msg_enable;
> +} debug = {-1};
> +
> +/******************************************************************************
> + * Module Parameters
> + ******************************************************************************/

Module parameters are discouraged. Use ethtool ops as far as possible.

> +static unsigned int txq_ctrl = 1;
> +static unsigned int func_txq_num = 1;
> +static unsigned int func_rxq_num = 1;
> +static unsigned int interrupt_num = 1;
> +static int rx_copybreak;
> +
> +module_param(txq_ctrl, uint, 0);
> +MODULE_PARM_DESC(txq_ctrl, "The maximum number of TX queues for PF and VFs.");
> +
> +module_param(func_txq_num, uint, 0);
> +MODULE_PARM_DESC(func_txq_num, "TX queue number for this function.");
> +
> +module_param(func_rxq_num, uint, 0);
> +MODULE_PARM_DESC(func_rxq_num, "RX queue number for this function.");
> +
> +module_param(interrupt_num, uint, 0);
> +MODULE_PARM_DESC(interrupt_num, "Interrupt Vector number for this function.");
> +
> +module_param(rx_copybreak, int, 0);
> +MODULE_PARM_DESC(rx_copybreak, "Copy breakpoint for copy-only-tiny-frames");
> +
> +/******************************************************************************
> + * Function Prototype
> + ******************************************************************************/

No forward declarations please.

> +static int rtase_open(struct net_device *dev);
> +static netdev_tx_t rtase_start_xmit(struct sk_buff *skb, struct net_device *dev);
> +static void rtase_set_rx_mode(struct net_device *dev);
> +static int rtase_set_mac_address(struct net_device *dev, void *p);
> +static int rtase_change_mtu(struct net_device *dev, int new_mtu);
> +static void rtase_tx_timeout(struct net_device *dev, unsigned int txqueue);
> +static void rtase_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats);
> +static int rtase_vlan_rx_add_vid(struct net_device *dev, __be16 protocol, u16 vid);
> +static int rtase_vlan_rx_kill_vid(struct net_device *dev, __be16 protocol, u16 vid);
> +static int rtase_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data);
> +
> +static irqreturn_t rtase_interrupt(int irq, void *dev_instance);
> +static irqreturn_t rtase_q_interrupt(int irq, void *dev_instance);
> +static void rtase_hw_config(struct net_device *dev);
> +static int rtase_close(struct net_device *dev);
> +static void rtase_down(struct net_device *dev);
> +static void rtase_init_netdev_ops(struct net_device *dev);
> +static void rtase_rar_set(const struct rtase_private *tp, const uint8_t *addr);
> +static void rtase_desc_addr_fill(const struct rtase_private *tp);
> +static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx);
> +static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx);
> +static void rtase_set_mar(const struct rtase_private *tp);
> +static s32 tx_handler(struct rtase_ring *ring, s32 budget);
> +static s32 rx_handler(struct rtase_ring *ring, s32 budget);
> +static s32 rtase_rxqos(const struct ifreq *ifr, const struct rtase_private *tp);
> +static int rtase_poll(struct napi_struct *napi, int budget);
> +static void rtase_sw_reset(struct net_device *dev);
> +static void rtase_dump_tally_counter(const struct rtase_private *tp, dma_addr_t paddr);
> +static s32 rtase_ptm(const struct ifreq *ifr, const struct rtase_private *tp);
> +static s32 rtase_ptm_function(const struct ifreq *ifr, const struct rtase_private *tp);
> +static s32 rtase_ptm_get_clock(const struct ifreq *ifr, const struct rtase_private *tp);
> +static s32 rtase_ptm_swc_set(const struct ifreq *ifr, const struct rtase_private *tp);
> +static s32 rtase_ptm_swc_get(const struct ifreq *ifr, const struct rtase_private *tp);
> +static s32 rtase_ptm_reg_get(const struct ifreq *ifr, const struct rtase_private *tp);
> +static s32 rtase_ptm_reg_set(const struct ifreq *ifr, const struct rtase_private *tp);
> +static s32 rtase_ptm_auto_update(const struct ifreq *ifr, const struct rtase_private *tp);
> +static void dump_tx_desc(const struct rtase_ring *ring);
> +static s32 rtase_debug_msg(const struct ifreq *ifr, const struct rtase_private *tp);
> +static void mac_ocp_write(const struct rtase_private *tp, u16 reg_addr, u16 value);
> +static u16 mac_ocp_read(const struct rtase_private *tp, u16 reg_addr);
> +static s32 reg_fun(const struct ifreq *ifr, const struct rtase_private *tp);
> +static s32 timeout_sig(const struct ifreq *ifr, struct rtase_private *tp);
> +
> +/******************************************************************************
> + * Function
> + ******************************************************************************/
> +#ifndef SET_ETHTOOL_OPS
> +#define SET_ETHTOOL_OPS(netdev, ops) ((netdev)->ethtool_ops = (ops))
> +#endif /* SET_ETHTOOL_OPS */
> +
> +struct rtase_counters {
> +	u64 tx_packets;
Also here most likely this should be __le64.

> +	u64 rx_packets;
> +	u64 tx_errors;
> +	u32 rx_errors;
> +	u16 rx_missed;
> +	u16 align_errors;
> +	u32 tx_one_collision;
> +	u32 tx_multi_collision;
> +	u64 rx_unicast;
> +	u64 rx_broadcast;
> +	u32 rx_multicast;
> +	u16 tx_aborted;
> +	u16 tx_underun;
> +};
> +
> +#ifdef ENABLE_RTASE_PROCFS
> +/******************************************************************************
> + * PROCFS STUFF
> + ******************************************************************************/
> +static struct proc_dir_entry *rtase_proc;
> +static s32 proc_init_num;
> +
> +static void rtase_dump_tally_counter(const struct rtase_private *tp, dma_addr_t paddr)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 cmd;
> +	u32 wait_cnt;
> +
> +	RTL_W32(DTCCR4, (u32)(paddr >> 32));
> +	cmd = (u32)(paddr & DMA_BIT_MASK(32));
> +	RTL_W32(DTCCR0, cmd);
> +	RTL_W32(DTCCR0, (u32)(cmd | COUNTER_DUMP));
> +
> +	wait_cnt = 0;
> +	while ((RTL_R32(DTCCR0) & COUNTER_DUMP) != 0u) {
> +		usleep_range(10, 20);
> +
> +		wait_cnt++;
> +		if (wait_cnt > 20u)
> +			break;
> +	}
> +}
> +
> +static int proc_get_tally_counter(struct seq_file *m, void *v)
> +{
> +	const struct net_device *dev = m->private;
> +	struct rtase_private *tp = netdev_priv(dev);
> +	const struct rtase_counters *counters = NULL;
> +	dma_addr_t paddr;
> +	unsigned long flags;
> +
> +	(void)v;
> +	seq_puts(m, "\nDump Tally Counter\n");
> +
> +	counters = tp->tally_vaddr;
> +	paddr = tp->tally_paddr;
> +	if (!counters) {
> +		seq_puts(m, "\nDump Tally Counter Fail\n");
> +		goto out;
> +	}
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +	rtase_dump_tally_counter(tp, paddr);
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +
> +	seq_puts(m, "Statistics\tValue\n----------\t-----\n");
> +	seq_printf(m, "tx_packets\t%lld\n", le64_to_cpu(counters->tx_packets));
> +	seq_printf(m, "rx_packets\t%lld\n", le64_to_cpu(counters->rx_packets));
> +	seq_printf(m, "tx_errors\t%lld\n", le64_to_cpu(counters->tx_errors));
> +	seq_printf(m, "rx_missed\t%lld\n", le64_to_cpu(counters->rx_missed));
> +	seq_printf(m, "align_errors\t%lld\n", le64_to_cpu(counters->align_errors));
> +	seq_printf(m, "tx_one_collision\t%lld\n", le64_to_cpu(counters->tx_one_collision));
> +	seq_printf(m, "tx_multi_collision\t%lld\n", le64_to_cpu(counters->tx_multi_collision));
> +	seq_printf(m, "rx_unicast\t%lld\n", le64_to_cpu(counters->rx_unicast));
> +	seq_printf(m, "rx_broadcast\t%lld\n", le64_to_cpu(counters->rx_broadcast));
> +	seq_printf(m, "rx_multicast\t%lld\n", le64_to_cpu(counters->rx_multicast));
> +	seq_printf(m, "tx_aborted\t%lld\n", le64_to_cpu(counters->tx_aborted));
> +	seq_printf(m, "tx_underun\t%lld\n", le64_to_cpu(counters->tx_underun));
> +
> +	seq_putc(m, '\n');
> +
> +out:
> +	return 0;
> +}
> +
> +static int proc_get_pci_registers(struct seq_file *m, void *v)
> +{
> +	const struct net_device *dev = m->private;
> +	s32 n = 0;
> +	s32 max_reg_size = RTASE_PCI_REGS_SIZE;
> +	u32 dword_rd;
> +	struct rtase_private *tp = netdev_priv(dev);
> +	unsigned long flags;
> +
> +	(void)v;
> +	seq_puts(m, "\nDump PCI Registers\n");
> +	seq_puts(m, "\nOffset\tValue\n------\t-----\n ");
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +
> +	while (n < max_reg_size) {
> +		if ((n % DWORD_MOD) == 0)
> +			seq_printf(m, "\n0x%03x:\t", n);
> +
> +		pci_read_config_dword(tp->pdev, n, &dword_rd);
> +		seq_printf(m, "%08x ", dword_rd);
> +		n += 4;
> +	}
> +
> +	n = 0x110;
> +	pci_read_config_dword(tp->pdev, n, &dword_rd);
> +	seq_printf(m, "\n0x%03x:\t%08x ", n, dword_rd);
> +	n = 0x70C;
> +	pci_read_config_dword(tp->pdev, n, &dword_rd);
> +	seq_printf(m, "\n0x%03x:\t%08x ", n, dword_rd);
> +
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +
> +	seq_putc(m, '\n');
> +	return 0;
> +}
> +
> +static void rtase_proc_module_init(void)
> +{
> +	/* create /proc/net/rtase */
> +	rtase_proc = proc_mkdir(MODULENAME, init_net.proc_net);
> +
> +	if (!rtase_proc)
> +		dprintk("cannot create %s proc entry\n", MODULENAME);
> +}
> +
> +/* seq_file wrappers for procfile show routines.
> + */
> +static int rtase_proc_open(struct inode *p_inode, struct file *p_file)
> +{
> +	struct net_device *dev = proc_get_parent_data(p_inode);
> +	int (*show)(struct seq_file *seq, void *v) = pde_data(p_inode);
> +
> +	return single_open(p_file, show, dev);
> +}
> +
> +static const struct proc_ops rtase_proc_fops = {
> +	.proc_open = rtase_proc_open,
> +	.proc_read = seq_read,
> +	.proc_lseek = seq_lseek,
> +	.proc_release = single_release,
> +};
> +
> +/* Table of proc files we need to create.
> + */
> +struct rtase_proc_file {
> +	char name[12];
> +	int (*show)(struct seq_file *seq, void *v);
> +};
> +
> +static const struct rtase_proc_file rtase_proc_files[] = {
> +	{"tally", &proc_get_tally_counter}, {"pci_regs", &proc_get_pci_registers}, {""}};
> +
> +static void rtase_proc_init(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	const struct rtase_proc_file *f;
> +	struct proc_dir_entry *dir = NULL;
> +
> +	if (rtase_proc && !tp->proc_dir) {
> +		dir = proc_mkdir_data(dev->name, 0, rtase_proc, dev);
> +		if (!dir) {
> +			netdev_info(dev, "Unable to initialize /proc/net/%s/%s\n", MODULENAME,
> +				    dev->name);
> +			goto out;
> +		}
> +
> +		tp->proc_dir = dir;
> +		proc_init_num++;
> +
> +		for (f = rtase_proc_files; f->name[0] != '\0'; f++) {
> +			if (proc_create_data(f->name, S_IFREG | S_IRUGO, dir, &rtase_proc_fops,
> +					     f->show)
> +			    == NULL) {
> +				netdev_info(dev, "Unable to initialize /proc/net/%s/%s/%s\n",
> +					    MODULENAME, dev->name, f->name);
> +				goto out;
> +			}
> +		}
> +	}
> +
> +out:
> +	return;
> +}
> +
> +static void rtase_proc_remove(const struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +
> +	if (tp->proc_dir) {
> +		remove_proc_subtree(dev->name, rtase_proc);
> +		proc_init_num--;
> +		tp->proc_dir = NULL;
> +	}
> +}
> +
> +#endif /* ENABLE_RTASE_PROCFS */
> +
> +static void mac_ocp_write(const struct rtase_private *tp, u16 reg_addr, u16 value)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 data32;
> +
> +	WARN_ON_ONCE(reg_addr % 2u);
> +
> +	data32 = ((u32)reg_addr / 2u);
> +	data32 <<= OCPR_ADDR_REG_SHIFT;
> +	data32 += value;
> +	data32 |= OCPR_WRITE;
> +
> +	RTL_W32(PDR, data32);
> +}
> +
> +static u16 mac_ocp_read(const struct rtase_private *tp, u16 reg_addr)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 data32;
> +	u16 data16 = 0;
> +
> +	WARN_ON_ONCE(reg_addr % 2u);
> +
> +	data32 = ((u32)reg_addr / 2u);
> +	data32 <<= OCPR_ADDR_REG_SHIFT;
> +
> +	RTL_W32(PDR, data32);
> +	data16 = (u16)RTL_R32(PDR);
> +
> +	return data16;
> +}
> +
> +static void rtase_interrupt_mitigation(const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 i = 0;
> +
> +	/* tx interrupt mitigation */
> +	for (i = 0u; i < tp->func_tx_queue_num; i++)
> +		RTL_W16((INT_MITI_TX + (i * 2u)), tp->tx_int_mit);
> +
> +	/* rx interrupt mitigation */
> +	for (i = 0u; i < tp->func_rx_queue_num; i++)
> +		RTL_W16((INT_MITI_RX + (i * 2u)), tp->rx_int_mit);
> +}
> +
> +static inline void rtase_enable_hw_interrupt(const struct rtase_private *tp)
> +{
> +	const struct rtase_int_vector *ivec = &tp->int_vector[0];
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 i = 0;
> +
> +	RTL_W32(ivec->imr_addr, ivec->imr);
> +
> +	for (i = 1; i < tp->int_nums; i++) {
> +		ivec = &tp->int_vector[i];
> +		RTL_W16(ivec->imr_addr, (u16)ivec->imr);
> +	}
> +}
> +
> +static void rtase_irq_mask_and_ack(const struct rtase_private *tp)
> +{
> +	const struct rtase_int_vector *ivec = &tp->int_vector[0];
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u8 i = 0;
> +
> +	RTL_W32(ivec->imr_addr, 0);
> +	RTL_W32(ivec->isr_addr, RTL_R32(ivec->isr_addr));
> +
> +	for (i = 1; i < tp->int_nums; i++) {
> +		ivec = &tp->int_vector[i];
> +		RTL_W16(ivec->imr_addr, 0);
> +		RTL_W16(ivec->isr_addr, RTL_R16(ivec->isr_addr));
> +	}
> +}
> +
> +static void rtase_nic_reset(const struct net_device *dev)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 i = 0;
> +	u16 rx_config;
> +
> +	rx_config = RTL_R16(RX_CONFIG_0);
> +	RTL_W16(RX_CONFIG_0, (u16)(rx_config & ~ACCEPT_MASK));
> +
> +	/* rxdv_gated_en - mask rxdv in PHYIO */
> +	RTL_W8(MISC, (u8)(RTL_R8(MISC) | RX_DV_GATE_EN));
> +	/* stop any TLP request from PCIe */
> +	RTL_W8(CHIP_CMD, (u8)(RTL_R8(CHIP_CMD) | STOP_REQ));
> +	mdelay(2);
> +
> +	/* wait TLP request done */
> +	for (i = 0u; i < 1500u; i++) {
> +		if ((RTL_R8(CHIP_CMD) & STOP_REQ_DONE) != 0u)
> +			break;
> +
> +		usleep_range(100, 110);
> +	}
> +
> +	/* wait FIFO empty */
> +	for (i = 0u; i < 1000u; i++) {
> +		if ((RTL_R8(FIFOR) & (TX_FIFO_EMPTY | RX_FIFO_EMPTY))
> +		    == (TX_FIFO_EMPTY | RX_FIFO_EMPTY))
> +			break;
> +
> +		usleep_range(100, 110);
> +	}
> +
> +	RTL_W8(CHIP_CMD, (u8)(RTL_R8(CHIP_CMD) & ~(TE | RE)));
> +
> +	RTL_W8(CHIP_CMD, (u8)(RTL_R8(CHIP_CMD) & ~STOP_REQ));
> +
> +	RTL_W16(RX_CONFIG_0, rx_config);
> +}
> +
> +static void rtase_nic_enable(const struct net_device *dev)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 rcr = RTL_R16(RX_CONFIG_1);
> +
> +	/* PCIe PLA reload */
> +	RTL_W16(RX_CONFIG_1, (u16)(rcr & ~PCIE_RELOAD_En));
> +	RTL_W16(RX_CONFIG_1, (u16)(rcr | PCIE_RELOAD_En));
> +
> +	/* Set PCIe TE & RE */
> +	RTL_W8(CHIP_CMD, (u8)(RTL_R8(CHIP_CMD) | (TE | RE)));
> +
> +	/* Clear rxdv_gated_en */
> +	RTL_W8(MISC, (u8)(RTL_R8(MISC) & ~RX_DV_GATE_EN));
> +}
> +
> +void rtase_func_enable(const struct rtase_private *tp)
> +{
> +	u16 i = 0u;
> +	u16 cr = 0u;
> +	void __iomem *ioaddr = tp->mmio_addr;
> +
> +	/* Polling function TE & RE */
> +	for (i = 0u; i < 1500u; i++) {
> +		if ((RTL_R16(FCR) & (FCR_TE | FCR_RE)) == 0u)
> +			break;
> +
> +		usleep_range(100, 110);
> +	}
> +
> +	/* Set function TE & RE */
> +	cr = RTL_R16(FCR);
> +	cr |= (u16)(FCR_TE | FCR_RE);
> +	RTL_W16(FCR, cr);
> +}
> +
> +void rtase_func_disable(const struct rtase_private *tp)
> +{
> +	u16 i = 0;
> +	void __iomem *ioaddr = tp->mmio_addr;
> +
> +	/* Clear function TE & RE */
> +	RTL_W16(FCR, (u16)(RTL_R16(FCR) & ~(FCR_TE | FCR_RE)));
> +
> +	/* Polling function TE & RE */
> +	for (i = 0u; i < 1500u; i++) {
> +		if ((RTL_R16(FCR) & (FCR_TE | FCR_RE)) == 0u)
> +			break;
> +
> +		usleep_range(100, 110);
> +	}
> +}
> +
> +void rtase_hw_reset(const struct net_device *dev)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +
> +	/* disable & clear interrupts */
> +	rtase_irq_mask_and_ack(tp);
> +
> +	/* nic reset */
> +	rtase_nic_reset(dev);
> +}
> +
> +static void rtase_enable_EEM_write(const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +
> +	RTL_W8(EEM, (RTL_R8(EEM) | EEM_Unlock));
> +}
> +
> +static void rtase_disable_EEM_write(const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +
> +	RTL_W8(EEM, (RTL_R8(EEM) & (u8)(~EEM_Unlock)));
> +}
> +
> +static inline u32 rtase_tx_vlan_tag(const struct rtase_private *tp, const struct sk_buff *skb)
> +{
> +	u32 tag;
> +
> +	(void)tp;
> +
> +	tag = (skb_vlan_tag_present(skb) != 0u) ? (u32)(TX_VLAN_TAG | swab16(skb_vlan_tag_get(skb)))
> +						: 0x00u;
> +
> +	return tag;
> +}
> +
> +static s32 rtase_rx_vlan_skb(rx_desc *desc, struct sk_buff *skb)
> +{
> +	u32 opts2 = le32_to_cpu(desc->desc_status.opts2);
> +	s32 ret = -1;
> +
> +#ifdef RTASE_DEBUG
> +	if (opts2 & RX_LBK_FIFO_FULL)
> +		pr_alert("PF receive loopback fifo full...");
> +
> +#endif
> +
> +	if ((opts2 & RX_VLAN_TAG) != 0u)
> +		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & 0xFFFFu));
> +
> +	desc->desc_status.opts2 = 0;
> +	return ret;
> +}
> +
> +static netdev_features_t rtase_fix_features(struct net_device *dev, netdev_features_t features)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	netdev_features_t features_fix = features;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +	if (dev->mtu > MSS_MAX)
> +		features_fix &= ~NETIF_F_ALL_TSO;
> +
> +	if (dev->mtu > (u32)ETH_DATA_LEN) {
> +		features_fix &= ~NETIF_F_ALL_TSO;
> +		features_fix &= ~NETIF_F_ALL_CSUM;
> +	}
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +
> +	return features_fix;
> +}
> +
> +static s32 rtase_hw_set_features(const struct net_device *dev, netdev_features_t features)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 rx_config;
> +
> +	rx_config = RTL_R16(RX_CONFIG_0);
> +	if ((features & NETIF_F_RXALL) != 0u)
> +		rx_config |= (u16)(ACCEPT_ERR | ACCEPT_RUNT);
> +	else
> +		rx_config &= (u16)(~(ACCEPT_ERR | ACCEPT_RUNT));
> +
> +	RTL_W16(RX_CONFIG_0, rx_config);
> +
> +	rx_config = RTL_R16(RX_CONFIG_1);
> +	if ((dev->features & NETIF_F_HW_VLAN_RX) != 0u)
> +		rx_config |= (u16)(INNER_VLAN_DETAG_EN | OUTER_VLAN_DETAG_EN);
> +	else
> +		rx_config &= (u16)(~(INNER_VLAN_DETAG_EN | OUTER_VLAN_DETAG_EN));
> +
> +	RTL_W16(RX_CONFIG_1, rx_config);
> +
> +	if ((features & NETIF_F_RXCSUM) != 0u)
> +		RTL_W16(CPLUS_CMD, (u16)(RTL_R16(CPLUS_CMD) | RX_CHKSUM));
> +	else
> +		RTL_W16(CPLUS_CMD, (u16)(RTL_R16(CPLUS_CMD) & ~RX_CHKSUM));
> +
> +	return 0;
> +}
> +
> +static int rtase_set_features(struct net_device *dev, netdev_features_t features)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	netdev_features_t features_set = features;
> +	unsigned long flags;
> +
> +	features_set &= NETIF_F_RXALL | NETIF_F_RXCSUM | NETIF_F_HW_VLAN_RX;
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +	if ((features_set ^ dev->features) != 0u) {
> +		if (rtase_hw_set_features(dev, features_set) != 0)
> +			netdev_alert(dev, "unable to set hw feature\n");
> +	}
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const char rtase_gstrings[][ETH_GSTRING_LEN] = {
> +	"tx_packets",   "rx_packets",           "tx_errors",           "rx_errors", "rx_missed",
> +	"align_errors", "tx_single_collisions", "tx_multi_collisions", "unicast",   "broadcast",
> +	"multicast",    "tx_aborted",           "tx_underrun",
> +};
> +
> +static void rtase_get_mac_version(struct rtase_private *tp, const void __iomem *ioaddr)
> +{
> +	u32 reg_val, hw_ver;
> +
> +	reg_val = RTL_R32(TX_CONFIG_0);
> +	hw_ver = reg_val & 0x7C800000u;
> +
> +	switch (hw_ver) {
> +	case 0x00800000:
> +		tp->mcfg = CFG_METHOD_1;
> +		break;
> +	case 0x04000000:
> +	case 0x04800000:
> +		tp->mcfg = CFG_METHOD_1;
> +		tp->ptm_support = 1;
> +		break;
> +
> +	default:
> +		netdev_info(tp->dev, "unknown chip version (%x)\n", hw_ver);
> +		tp->mcfg = CFG_METHOD_DEFAULT;
> +		tp->hw_ic_ver_unknown = TRUE;
> +		break;
> +	}
> +}
> +
> +static void rtase_print_mac_version(const struct rtase_private *tp)
> +{
> +	s16 i;
> +	bool flag = false;
> +
> +	for (i = (s16)(ARRAY_SIZE(rtl_chip_info) - 1u); i >= 0; i--) {
> +		if (tp->mcfg == rtl_chip_info[i].mcfg) {
> +			dprintk("Realtek PCIe Family Controller mcfg = %04d\n",
> +				rtl_chip_info[i].mcfg);
> +			flag = true;
> +			break;
> +		}
> +	}
> +
> +	if (!flag)
> +		dprintk("mac_version == Unknown\n");
> +}
> +
> +static void rtase_tally_counter_addr_fill(const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +
> +	if (tp->tally_paddr != 0u) {
> +		RTL_W32(DTCCR4, (u32)(tp->tally_paddr >> 32));
> +		RTL_W32(DTCCR0, (u32)(tp->tally_paddr & (DMA_BIT_MASK(32))));
> +	}
> +}
> +
> +static void rtase_tally_counter_clear(const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +
> +	if (tp->tally_paddr != 0u) {
> +		RTL_W32(DTCCR4, (u32)(tp->tally_paddr >> 32));
> +		RTL_W32(DTCCR0, (u32)((tp->tally_paddr & (DMA_BIT_MASK(32))) | COUNTER_RESET));
> +	}
> +}
> +
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +
> +/* Polling 'interrupt' - used by things like netconsole to send skbs
> + * without having to re-enable interrupts. It's not called while
> + * the interrupt routine is executing.
> + */
> +static void rtase_netpoll(struct net_device *dev)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	const struct pci_dev *pdev = tp->pdev;
> +
> +	disable_irq(pdev->irq);
> +	rtase_interrupt((s32)pdev->irq, dev);
> +	enable_irq(pdev->irq);
> +}
> +#endif
> +
> +static void rtase_mbx_set_vfmc(const struct rtase_private *tp, u8 vfn)
> +{
> +	const void __iomem *ioaddr = tp->mmio_addr;
> +
> +	tp->vf_info[vfn].mc_filter[0] = RTL_R32(VFMSGDATA_0 + ((u32)vfn * 8u));
> +	tp->vf_info[vfn].mc_filter[1] = RTL_R32(VFMSGDATA_2 + ((u32)vfn * 8u));
> +}
> +
> +static void rtase_msg_work(struct work_struct *work)
> +{
> +	static void (*const rtase_mbx_func[])(const struct rtase_private *tp, u8 vfn) = {
> +		rtase_mbx_set_vfmc,
> +	};
> +	const struct rtase_private *tp = container_of(work, struct rtase_private, msg_work);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u8 status = 0;
> +
> +	status = RTL_R8(PFMSGICRREQ);
> +	if (status != 0u) {
> +		u16 i = 0u;
> +
> +		for (i = 0u; i < tp->num_vfs; i++) {
> +			if ((status & BIT(i)) != 0u) {
> +				rtase_mbx_func[0](tp, i);
> +				RTL_W8(PFMSGVF1 + (i * 4u),
> +				       (u8)(RTL_R8(PFMSGVF1 + ((u32)i * 4u)) | BIT(1)));
> +			}
> +		}
> +		rtase_set_mar(tp);
> +	}
> +
> +	RTL_W8(PFMSGICRREQ, status);
> +}
> +
> +static void rtase_watchdog_work(struct work_struct *work)
> +{
> +	struct rtase_private *tp = container_of(work, struct rtase_private, watchdog_work);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	struct rtase_ring *ring = &tp->tx_ring[0];
> +
> +	/* Check if there is a packet to transmit. */
> +	if (ring->cur_idx != ring->dirty_idx) {
> +		/* Determine if dirty_idx has changed. */
> +		if (ring->dirty_idx == ring->priv_dirty_idx) {
> +			/* Determine whether the Txfifo is empty. */
> +			if ((RTL_R8(FIFOR) & TX_FIFO_EMPTY) == TX_FIFO_EMPTY) {
> +				/* If it is repeatedly checked that the dirty_idx has not changed 3
> +				 * times, the software will be reset.
> +				 */
> +				if (ring->duplicate_dirty_count >= TX_DUPLICATE_DIRTYIDX_COUNT)
> +					rtase_sw_reset(tp->dev);
> +				else
> +					ring->duplicate_dirty_count++;
> +			} else {
> +				ring->duplicate_dirty_count = 0;
> +			}
> +		} else {
> +			ring->duplicate_dirty_count = 0;
> +			ring->priv_dirty_idx = ring->dirty_idx;
> +		}
> +	} else {
> +		ring->duplicate_dirty_count = 0;
> +	}
> +
> +	/* reset timer */
> +	RTL_W32(TCTR0, 0x0);
> +}
> +
> +static void rtase_init_int_vector(struct rtase_private *tp)
> +{
> +	u16 i = 0u;
> +
> +	/* interrupt vector 0 */
> +	tp->int_vector[0].tp = tp;
> +	memset(tp->int_vector[0].name, 0x0, 20);
> +	tp->int_vector[0].index = 0;
> +	tp->int_vector[0].imr_addr = IMR0;
> +	tp->int_vector[0].isr_addr = ISR0;
> +	tp->int_vector[0].imr = (u32)(ROK | RDU | TOK | MBX | TOK4 | TOK5 | TOK6 | TOK7 | TIMEOUT0);
> +	INIT_LIST_HEAD(&tp->int_vector[0].ring_list);
> +	tp->int_vector[0].weight = RTASE_NAPI_WEIGHT;
> +	tp->int_vector[0].poll = rtase_poll;
> +	netif_napi_add(tp->dev, &tp->int_vector[0].napi, tp->int_vector[0].poll,
> +		       tp->int_vector[0].weight);
> +	napi_enable(&tp->int_vector[0].napi);
> +
> +	/* interrupt vector 1 ~ 3 */
> +	for (i = 1; i < tp->int_nums; i++) {
> +		tp->int_vector[i].tp = tp;
> +		memset(tp->int_vector[i].name, 0x0, 20);
> +		tp->int_vector[i].index = i;
> +		tp->int_vector[i].imr_addr = (IMR1 + ((i - 1u) * 4u));
> +		tp->int_vector[i].isr_addr = (ISR1 + ((i - 1u) * 4u));
> +		tp->int_vector[i].imr = (u32)(Q_ROK | Q_RDU | Q_TOK);
> +		INIT_LIST_HEAD(&tp->int_vector[i].ring_list);
> +		tp->int_vector[i].weight = RTASE_NAPI_WEIGHT;
> +		tp->int_vector[i].poll = rtase_poll;
> +		netif_napi_add(tp->dev, &tp->int_vector[i].napi, tp->int_vector[i].poll,
> +			       tp->int_vector[i].weight);
> +		napi_enable(&tp->int_vector[i].napi);
> +	}
> +}
> +
> +static void rtase_init_software_variable(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +
> +	spin_lock_init(&tp->lock);
> +
> +	/* assign module parameters */
> +	tp->tx_queue_ctrl = (u16)txq_ctrl;
> +	tp->func_tx_queue_num = (u16)func_txq_num;
> +	tp->func_rx_queue_num = (u16)func_rxq_num;
> +	tp->int_nums = (u16)interrupt_num;
> +	tp->tx_int_mit = TX_INT_MITIGATION;
> +	tp->rx_int_mit = RX_INT_MITIGATION;
> +
> +	tp->sw_flag = 0;
> +	tp->num_vfs = 0;
> +
> +	/* initial timeout state */
> +	tp->timeout_state = TIMEOUT_INIT;
> +
> +	/* new, interrutp variables init */
> +	rtase_init_int_vector(tp);
> +
> +	tp->max_jumbo_frame_size = rtl_chip_info[tp->mcfg].jumbo_frame_sz;
> +	/* MTU range: 60 - hw-specific max */
> +	dev->min_mtu = ETH_ZLEN;
> +	dev->max_mtu = tp->max_jumbo_frame_size;
> +
> +	INIT_WORK(&tp->msg_work, rtase_msg_work);
> +	INIT_WORK(&tp->watchdog_work, rtase_watchdog_work);
> +}
> +
> +static void rtase_init_hardware(const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 i;
> +
> +	/* vlan filter table */
> +	for (i = 0u; i < VLAN_FILTER_ENTRY_NUM; i++)
> +		RTL_W32((VLAN_ENTRY_0 + (i * 4u)), 0);
> +}
> +
> +static void rtase_release_board(struct pci_dev *pdev, struct net_device *dev, void __iomem *ioaddr)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +
> +	rtase_rar_set(tp, tp->org_mac_addr);
> +	iounmap(ioaddr);
> +	if ((tp->sw_flag & SWF_MSIX_ENABLED) != 0u)
> +		pci_disable_msix(pdev);
> +	else
> +		pci_disable_msi(pdev);
> +
> +	pci_release_regions(pdev);
> +	pci_disable_device(pdev);
> +	free_netdev(dev);
> +}
> +
> +static void rtase_hw_address_set(struct net_device *dev, const u8 mac_addr[MAC_ADDR_LEN])
> +{
> +	eth_hw_addr_set(dev, mac_addr);
> +}
> +
> +static s32 rtase_get_mac_address(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	const void __iomem *ioaddr = tp->mmio_addr;
> +	u32 i;
> +	u8 mac_addr[MAC_ADDR_LEN];
> +
> +	for (i = 0; i < MAC_ADDR_LEN; i++)
> +		mac_addr[i] = RTL_R8(MAC0 + i);
> +
> +	if (!is_valid_ether_addr(mac_addr)) {
> +		netif_err(tp, probe, dev, "Invalid ether addr %pM\n", mac_addr);
> +		eth_hw_addr_random(dev);
> +		ether_addr_copy(mac_addr, dev->dev_addr);
> +		netif_info(tp, probe, dev, "Random ether addr %pM\n", mac_addr);
> +		tp->random_mac = 1;
> +	}
> +
> +	rtase_hw_address_set(dev, mac_addr);
> +	rtase_rar_set(tp, mac_addr);
> +
> +	/* keep the original MAC address */
> +	memcpy(tp->org_mac_addr, dev->dev_addr, MAC_ADDR_LEN);
> +	memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
> +
> +	return 0;
> +}
> +
> +/* rtase_set_mac_address - Change the Ethernet Address of the NIC
> + * @dev: network interface device structure
> + * @p:   pointer to an address structure
> + *
> + * Return 0 on success, negative on failure
> + */
> +static int rtase_set_mac_address(struct net_device *dev, void *p)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	const struct sockaddr *addr = p;
> +	unsigned long flags;
> +	s32 rc = 0;
> +
> +	if (!is_valid_ether_addr((u8 *)&addr->sa_data)) {
> +		rc = -EADDRNOTAVAIL;
> +	} else {
> +		spin_lock_irqsave(&tp->lock, flags);
> +		rtase_hw_address_set(dev, (u8 *)&addr->sa_data);
> +		rtase_rar_set(tp, dev->dev_addr);
> +		spin_unlock_irqrestore(&tp->lock, flags);
> +	}
> +
> +	return rc;
> +}
> +
> +/* rtase_rar_set - Puts an ethernet address into a receive address register.
> + *
> + * tp - The private data structure for driver
> + * addr - Address to put into receive address register
> + */
> +static void rtase_rar_set(const struct rtase_private *tp, const uint8_t *addr)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 rar_low = 0;
> +	u32 rar_high = 0;
> +
> +	rar_low = ((uint32_t)addr[0] | ((uint32_t)addr[1] << 8) | ((uint32_t)addr[2] << 16)
> +		   | ((uint32_t)addr[3] << 24));
> +
> +	rar_high = ((uint32_t)addr[4] | ((uint32_t)addr[5] << 8));
> +
> +	rtase_enable_EEM_write(tp);
> +	RTL_W32(MAC0, rar_low);
> +	RTL_W32(MAC4, rar_high);
> +	rtase_disable_EEM_write(tp);
> +	RTL_W16(LBK_CTRL, (u16)(LBK_ATLD | LBK_CLR));
> +}
> +
> +static s32 reg_fun(const struct ifreq *ifr, const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	void *useraddr = (void *)ifr->ifr_data;
> +	struct reg_rw reg;
> +	s32 rc = 0;
> +
> +	if (copy_from_user(&reg, useraddr, sizeof(struct reg_rw)) != 0u) {
> +		rc = -EFAULT;
> +		goto out;
> +	}
> +
> +	/* debug channel read */
> +	if (reg.cmd == CMD_DBG_READ) {
> +		reg.val = mac_ocp_read(tp, reg.addr);
> +		if (copy_to_user(useraddr, &reg, sizeof(struct reg_rw)) != 0u) {
> +			rc = -EFAULT;
> +			goto out;
> +		}
> +		netdev_info(tp->dev, "\tread reg 0x%04x = 0x%04x", reg.addr, reg.val);
> +	}
> +	/* debug channel write */
> +	else if (reg.cmd == CMD_DBG_WRITE) {
> +		mac_ocp_write(tp, reg.addr, (u16)reg.val);
> +		netdev_info(tp->dev, "\twrite reg 0x%04x = 0x%04x", reg.addr,
> +			    mac_ocp_read(tp, reg.addr));
> +	}
> +	/* mmio read16 */
> +	else if (reg.cmd == CMD_REG_READ16) {
> +		reg.val = RTL_R16(reg.addr);
> +		if (copy_to_user(useraddr, &reg, sizeof(struct reg_rw)) != 0u) {
> +			rc = -EFAULT;
> +			goto out;
> +		}
> +		netdev_info(tp->dev, "\tread MMIO 0x%04x = 0x%04x", reg.addr, reg.val);
> +	}
> +	/* mmio write16 */
> +	else if (reg.cmd == CMD_REG_WRITE16) {
> +		RTL_W16(reg.addr, (u16)reg.val);
> +		netdev_info(tp->dev, "\twrite MMIO 0x%04x = 0x%04x", reg.addr, RTL_R16(reg.addr));
> +	}
> +	/* mmio read32 */
> +	else if (reg.cmd == CMD_REG_READ32) {
> +		reg.val = RTL_R32(reg.addr);
> +		if (copy_to_user(useraddr, &reg, sizeof(struct reg_rw)) != 0u) {
> +			rc = -EFAULT;
> +			goto out;
> +		}
> +		netdev_info(tp->dev, "\tread MMIO 0x%04x = 0x%08x", reg.addr, reg.val);
> +	}
> +	/* mmio write32 */
> +	else if (reg.cmd == CMD_REG_WRITE32) {
> +		RTL_W32(reg.addr, reg.val);
> +		netdev_info(tp->dev, "\twrite MMIO 0x%04x = 0x%08x", reg.addr, RTL_R16(reg.addr));
> +	} else {
> +		netdev_info(tp->dev, "reg command error.\n");
> +	}
> +	pr_info("\t\n");
> +
> +out:
> +	return rc;
> +}
> +
> +static s32 rtase_rxqos(const struct ifreq *ifr, const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	void *useraddr = (void *)ifr->ifr_data;
> +	struct rtk_qos qos_config;
> +	u16 offset = 0;
> +	u32 regV = 0;
> +	s32 rc = 0;
> +
> +	if (copy_from_user(&qos_config, useraddr, sizeof(struct rtk_qos)) != 0u) {
> +		rc = -EFAULT;
> +		goto out;
> +	}
> +
> +	if (qos_config.pcp < 4u)
> +		offset = ((u16)qos_config.pcp * 3u);
> +	else if (qos_config.pcp < 8u)
> +		offset = ((((u16)qos_config.pcp - 4u) * 3u) + 16u);
> +	else
> +		offset = 28;
> +
> +	if (qos_config.cmd == CMD_GET_RXQOS) {
> +		regV = RTL_R32(RX_PCP_TABLE);
> +		qos_config.tc = (u8)((regV >> offset) & 0x7u);
> +		if (copy_to_user(useraddr, &qos_config, sizeof(struct rtk_qos)) != 0u) {
> +			rc = -EFAULT;
> +			goto out;
> +		}
> +	} else if (qos_config.cmd == CMD_SET_RXQOS) {
> +		regV = RTL_R32(RX_PCP_TABLE);
> +		regV &= ~((u32)0x7u << offset);
> +		regV |= ((u32)qos_config.tc << offset);
> +		RTL_W32(RX_PCP_TABLE, regV);
> +	} else {
> +		netdev_info(tp->dev, "rxqos command error.\n");
> +	}
> +	pr_info("\t\n");
> +
> +out:
> +	return rc;
> +}
> +
> +static s32 timeout_sig(const struct ifreq *ifr, struct rtase_private *tp)
> +{
> +	void *useraddr = (void *)ifr->ifr_data;
> +	struct rtk_timeout_sig rtk_timeout_sig;
> +	s32 rc = 0;
> +
> +	if (copy_from_user(&rtk_timeout_sig, useraddr, sizeof(struct rtk_timeout_sig)) != 0u) {
> +		rc = -EFAULT;
> +	} else {
> +		if (rtk_timeout_sig.cmd == CMD_GET_TIMSIG) {
> +			rtk_timeout_sig.state = tp->timeout_state;
> +
> +			if (copy_to_user(useraddr, &rtk_timeout_sig, sizeof(struct rtk_timeout_sig))
> +			    != 0u)
> +				rc = -EFAULT;
> +		} else if (rtk_timeout_sig.cmd == CMD_SET_TIMSIG) {
> +			tp->timeout_state = rtk_timeout_sig.state;
> +		} else {
> +			netdev_info(tp->dev, "%s command error.\n", __func__);
> +		}
> +	}
> +
> +	return rc;
> +}
> +
> +static s32 rtase_ptm(const struct ifreq *ifr, const struct rtase_private *tp)
> +{
> +	const void *useraddr = (void *)ifr->ifr_data;
> +	struct rtase_ptm_cmd_t cmd;
> +	s32 ret;
> +	u32 size;
> +
> +	static s32 (*const ptm_cmd_info[])(const struct ifreq *ifr,
> +					   const struct rtase_private *tp) = {
> +		rtase_ptm_function, rtase_ptm_get_clock, rtase_ptm_swc_get,     rtase_ptm_reg_get,
> +		rtase_ptm_swc_set,  rtase_ptm_reg_set,   rtase_ptm_auto_update,
> +	};
> +
> +	if (copy_from_user(&cmd, useraddr, sizeof(struct rtase_ptm_cmd_t)) != 0u) {
> +		ret = -EFAULT;
> +	} else {
> +		size = (u32)ARRAY_SIZE(ptm_cmd_info);
> +
> +		if (cmd.type >= size)
> +			ret = -EFAULT;
> +		else
> +			ret = ptm_cmd_info[cmd.type](ifr, tp);
> +	}
> +
> +	return ret;
> +}
> +
> +static s32 rtase_ptm_function(const struct ifreq *ifr, const struct rtase_private *tp)
> +{
> +	const void *useraddr = (void *)ifr->ifr_data;
> +	struct rtase_ptm_cmd_t cmd;
> +	struct pci_dev *pdev = tp->pdev;
> +	s32 ptm_pos = 0;
> +	s32 ret = 0;
> +
> +	if (copy_from_user(&cmd, useraddr, sizeof(struct rtase_ptm_cmd_t)) != 0u) {
> +		ret = -EFAULT;
> +	} else {
> +		ptm_pos = (s32)(pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PTM));
> +
> +		if (ptm_pos == 0) {
> +			netdev_info(tp->dev, "can't find ptm position.");
> +			ret = -EFAULT;
> +		} else {
> +			if (cmd.enable == 1u) {
> +				/* ptm enable */
> +				pci_write_config_byte(pdev, ptm_pos + 8, 0x1u);
> +			} else if (cmd.enable == 0u) {
> +				/* ptm disable */
> +				pci_write_config_byte(pdev, ptm_pos + 8, 0x0u);
> +			} else {
> +				netdev_info(tp->dev, "%s command error.\n", __func__);
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static s32 rtase_ptm_reg_get(const struct ifreq *ifr, const struct rtase_private *tp)
> +{
> +	const void __iomem *ioaddr = tp->mmio_addr;
> +	void *useraddr = (void *)ifr->ifr_data;
> +	struct rtase_ptm_cmd_t cmd;
> +	s32 ret = 0;
> +
> +	if (copy_from_user(&cmd, useraddr, sizeof(struct rtase_ptm_cmd_t)) != 0u) {
> +		ret = -EFAULT;
> +	} else {
> +		cmd.reg_value = RTL_R16(cmd.reg_addr);
> +		if (copy_to_user(useraddr, &cmd, sizeof(struct rtase_ptm_cmd_t)) != 0u)
> +			ret = -EFAULT;
> +	}
> +
> +	return ret;
> +}
> +
> +static s32 rtase_ptm_reg_set(const struct ifreq *ifr, const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	const void *useraddr = (void *)ifr->ifr_data;
> +	struct rtase_ptm_cmd_t cmd;
> +	s32 ret = 0;
> +
> +	if (copy_from_user(&cmd, useraddr, sizeof(struct rtase_ptm_cmd_t)) != 0u) {
> +		ret = -EFAULT;
> +	} else {
> +		if (cmd.bits == 16u)
> +			RTL_W16(cmd.reg_addr, (u16)cmd.reg_value);
> +		else if (cmd.bits == 32u)
> +			RTL_W32(cmd.reg_addr, cmd.reg_value);
> +		else
> +			netdev_info(tp->dev, "%s command error.\n", __func__);
> +	}
> +
> +	return ret;
> +}
> +
> +static s32 rtase_ptm_auto_update(const struct ifreq *ifr, const struct rtase_private *tp)
> +{
> +	const void *useraddr = (void *)ifr->ifr_data;
> +	struct pci_dev *pdev = tp->pdev;
> +	struct rtase_ptm_cmd_t cmd;
> +	s32 ptm_pos = 0;
> +	s32 ret = 0;
> +
> +	ptm_pos = (s32)(pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PTM));
> +
> +	if (copy_from_user(&cmd, useraddr, sizeof(struct rtase_ptm_cmd_t)) != 0u) {
> +		ret = -EFAULT;
> +	} else {
> +		if (ptm_pos == 0) {
> +			netdev_warn(tp->dev, "can't find ptm position.");
> +			ret = -EFAULT;
> +		} else {
> +			if (cmd.enable == 1u)
> +				pci_write_config_byte(pdev, ptm_pos + 20, 0x1u);
> +			else
> +				pci_write_config_byte(pdev, ptm_pos + 20, 0x0u);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +/******************************************************************************
> + * Ethtool Operations
> + ******************************************************************************/
> +static void rtase_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *drvinfo)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +
> +	strscpy(drvinfo->driver, MODULENAME, 32);
> +	strscpy(drvinfo->version, RTASE_VERSION, 32);
> +	strscpy(drvinfo->bus_info, pci_name(tp->pdev), 32);
> +}
> +
> +#undef ethtool_op_get_link
> +#define ethtool_op_get_link _kc_ethtool_op_get_link
> +static u32 _kc_ethtool_op_get_link(struct net_device *dev)
> +{
> +	return netif_carrier_ok(dev) ? 1u : 0u;
> +}
> +
> +static int rtase_get_settings(struct net_device *dev, struct ethtool_link_ksettings *cmd)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	const void __iomem *ioaddr = tp->mmio_addr;
> +	u32 supported = 0;
> +	u32 advertising = 0;
> +	u32 speed = 0;
> +	u16 value = 0;
> +
> +	supported |= (u32)(SUPPORTED_MII | SUPPORTED_Pause);
> +
> +	advertising |= (u32)ADVERTISED_MII;
> +
> +	/* speed */
> +	switch (tp->pdev->bus->cur_bus_speed) {
> +	case PCIE_SPEED_2_5GT:
> +		speed = SPEED_1000;
> +		break;
> +	case PCIE_SPEED_5_0GT:
> +		speed = SPEED_2500;
> +		break;
> +	case PCIE_SPEED_8_0GT:
> +		speed = SPEED_5000;
> +		break;
> +	default:
> +		/* nothing to do. */
> +		break;
> +	}
> +
> +	/* pause */
> +	value = RTL_R16(CPLUS_CMD);
> +	if ((value & (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) == (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN))
> +		advertising |= (u32)ADVERTISED_Pause;
> +	else if ((value & FORCE_TXFLOW_EN) != 0u)
> +		advertising |= (u32)ADVERTISED_Asym_Pause;
> +	else if ((value & FORCE_RXFLOW_EN) != 0u)
> +		advertising |= (u32)(ADVERTISED_Pause | ADVERTISED_Asym_Pause);
> +	else
> +		netdev_info(dev, "pause is disable\n");
> +
> +	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported, supported);
> +	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising, advertising);
> +	cmd->base.speed = speed;
> +	cmd->base.duplex = DUPLEX_FULL;
> +	cmd->base.port = PORT_MII;
> +
> +	return 0;
> +}
> +
> +static void rtase_get_pauseparam(struct net_device *dev, struct ethtool_pauseparam *pause)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	const void __iomem *ioaddr = tp->mmio_addr;
> +	u16 value = RTL_R16(CPLUS_CMD);
> +
> +	if ((value & (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) == (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN)) {
> +		pause->rx_pause = 1;
> +		pause->tx_pause = 1;
> +	} else if ((value & FORCE_TXFLOW_EN) != 0u) {
> +		pause->tx_pause = 1;
> +	} else if ((value & FORCE_RXFLOW_EN) != 0u) {
> +		pause->rx_pause = 1;
> +	} else {
> +		/* not enable pause */
> +	}
> +}
> +
> +static int rtase_set_pauseparam(struct net_device *dev, struct ethtool_pauseparam *pause)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 value = RTL_R16(CPLUS_CMD);
> +
> +	value &= (u16)(~(FORCE_TXFLOW_EN | FORCE_RXFLOW_EN));
> +
> +	if (pause->tx_pause == 1u)
> +		value |= (u16)FORCE_TXFLOW_EN;
> +
> +	if (pause->rx_pause == 1u)
> +		value |= (u16)FORCE_RXFLOW_EN;
> +
> +	RTL_W16(CPLUS_CMD, value);
> +	return 0;
> +}
> +
> +static u32 rtase_get_msglevel(struct net_device *dev)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +
> +	return tp->msg_enable;
> +}
> +
> +static void rtase_set_msglevel(struct net_device *dev, u32 value)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +
> +	tp->msg_enable = value;
> +}
> +
> +static void rtase_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> +{
> +	(void)dev;
> +
> +	switch (stringset) {
> +	case ETH_SS_STATS:
> +		memcpy(data, (u8 *)&rtase_gstrings, sizeof(rtase_gstrings));
> +		break;
> +	default:
> +		/* nothing to do. */
> +		break;
> +	}
> +}
> +
> +static int rtase_get_sset_count(struct net_device *dev, int sset)
> +{
> +	int ret = 0;
> +
> +	(void)dev;
> +
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		ret = (int)(ARRAY_SIZE(rtase_gstrings));
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void rtase_get_ethtool_stats(struct net_device *dev, struct ethtool_stats *stats, u64 *data)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	const struct rtase_counters *counters;
> +	dma_addr_t paddr;
> +	unsigned long flags;
> +
> +	ASSERT_RTNL();
> +
> +	(void)stats;
> +	counters = tp->tally_vaddr;
> +	paddr = tp->tally_paddr;
> +	if (!counters)
> +		goto out;
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +	rtase_dump_tally_counter(tp, paddr);
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +
> +	data[0] = le64_to_cpu(counters->tx_packets);
> +	data[1] = le64_to_cpu(counters->rx_packets);
> +	data[2] = le64_to_cpu(counters->tx_errors);
> +	data[3] = le32_to_cpu(counters->rx_errors);
> +	data[4] = le16_to_cpu(counters->rx_missed);
> +	data[5] = le16_to_cpu(counters->align_errors);
> +	data[6] = le32_to_cpu(counters->tx_one_collision);
> +	data[7] = le32_to_cpu(counters->tx_multi_collision);
> +	data[8] = le64_to_cpu(counters->rx_unicast);
> +	data[9] = le64_to_cpu(counters->rx_broadcast);
> +	data[10] = le32_to_cpu(counters->rx_multicast);
> +	data[11] = le16_to_cpu(counters->tx_aborted);
> +	data[12] = le16_to_cpu(counters->tx_underun);
> +
> +out:
> +	return;
> +}
> +
> +static const struct ethtool_ops rtase_ethtool_ops = {
> +	.get_drvinfo = rtase_get_drvinfo,
> +	.get_link = ethtool_op_get_link,
> +	.get_link_ksettings = rtase_get_settings,
> +	.get_pauseparam = rtase_get_pauseparam,
> +	.set_pauseparam = rtase_set_pauseparam,
> +	.get_msglevel = rtase_get_msglevel,
> +	.set_msglevel = rtase_set_msglevel,
> +	.get_strings = rtase_get_strings,
> +	.get_sset_count = rtase_get_sset_count,
> +	.get_ethtool_stats = rtase_get_ethtool_stats,
> +	.get_ts_info = ethtool_op_get_ts_info,
> +};
> +
> +/******************************************************************************
> + * Ethtool Compatibility
> + ******************************************************************************/
> +#ifdef ETHTOOL_OPS_COMPAT
> +static int ethtool_get_settings(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_cmd cmd = {ETHTOOL_GSET};
> +	int err;
> +
> +	if (!ethtool_ops->get_settings)
> +		return -EOPNOTSUPP;
> +
> +	err = ethtool_ops->get_settings(dev, &cmd);
> +	if (err < 0)
> +		return err;
> +
> +	if (copy_to_user(useraddr, &cmd, sizeof(cmd)) != 0u)
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int ethtool_set_settings(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_cmd cmd;
> +
> +	if (!ethtool_ops->set_settings)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&cmd, useraddr, sizeof(cmd)) != 0u)
> +		return -EFAULT;
> +
> +	return ethtool_ops->set_settings(dev, &cmd);
> +}
> +
> +static int ethtool_get_drvinfo(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_drvinfo info;
> +	const struct ethtool_ops *ops = ethtool_ops;
> +
> +	if (!ops->get_drvinfo)
> +		return -EOPNOTSUPP;
> +
> +	memset(&info, 0, sizeof(info));
> +	info.cmd = ETHTOOL_GDRVINFO;
> +	ops->get_drvinfo(dev, &info);
> +
> +	if (ops->self_test_count)
> +		info.testinfo_len = ops->self_test_count(dev);
> +	if (ops->get_stats_count)
> +		info.n_stats = ops->get_stats_count(dev);
> +	if (ops->get_regs_len)
> +		info.regdump_len = ops->get_regs_len(dev);
> +	if (ops->get_eeprom_len)
> +		info.eedump_len = ops->get_eeprom_len(dev);
> +
> +	if (copy_to_user(useraddr, &info, sizeof(info)) != 0u)
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int ethtool_get_regs(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_regs regs;
> +	const struct ethtool_ops *ops = ethtool_ops;
> +	void *regbuf;
> +	int reglen, ret;
> +
> +	if (!ops->get_regs || !ops->get_regs_len)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&regs, useraddr, sizeof(regs)) != 0u)
> +		return -EFAULT;
> +
> +	reglen = ops->get_regs_len(dev);
> +	if (regs.len > reglen)
> +		regs.len = reglen;
> +
> +	regbuf = kmalloc(reglen, GFP_USER);
> +	if (!regbuf)
> +		return -ENOMEM;
> +
> +	ops->get_regs(dev, &regs, regbuf);
> +
> +	ret = -EFAULT;
> +	if (copy_to_user(useraddr, &regs, sizeof(regs)) != 0u)
> +		goto out;
> +	useraddr += offsetof(struct ethtool_regs, data);
> +	if (copy_to_user(useraddr, regbuf, reglen) != 0u)
> +		goto out;
> +	ret = 0;
> +
> +out:
> +	kfree(regbuf);
> +	return ret;
> +}
> +
> +static int ethtool_get_wol(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_wolinfo wol = {ETHTOOL_GWOL};
> +
> +	if (!ethtool_ops->get_wol)
> +		return -EOPNOTSUPP;
> +
> +	ethtool_ops->get_wol(dev, &wol);
> +
> +	if (copy_to_user(useraddr, &wol, sizeof(wol)) != 0u)
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int ethtool_set_wol(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_wolinfo wol;
> +
> +	if (!ethtool_ops->set_wol)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&wol, useraddr, sizeof(wol)) != 0u)
> +		return -EFAULT;
> +
> +	return ethtool_ops->set_wol(dev, &wol);
> +}
> +
> +static int ethtool_get_msglevel(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_value edata = {ETHTOOL_GMSGLVL};
> +
> +	if (!ethtool_ops->get_msglevel)
> +		return -EOPNOTSUPP;
> +
> +	edata.data = ethtool_ops->get_msglevel(dev);
> +
> +	if (copy_to_user(useraddr, &edata, sizeof(edata)) != 0u)
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int ethtool_set_msglevel(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_value edata;
> +
> +	if (!ethtool_ops->set_msglevel)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&edata, useraddr, sizeof(edata)) != 0u)
> +		return -EFAULT;
> +
> +	ethtool_ops->set_msglevel(dev, edata.data);
> +	return 0;
> +}
> +
> +static int ethtool_nway_reset(struct net_device *dev)
> +{
> +	if (!ethtool_ops->nway_reset)
> +		return -EOPNOTSUPP;
> +

This is checked by the core already. Same applies to other ethtool ops as well.

> +	return ethtool_ops->nway_reset(dev);
> +}
> +
> +static int ethtool_get_link(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_value edata = {ETHTOOL_GLINK};
> +
> +	if (!ethtool_ops->get_link)
> +		return -EOPNOTSUPP;
> +
> +	edata.data = ethtool_ops->get_link(dev);
> +
> +	if (copy_to_user(useraddr, &edata, sizeof(edata)) != 0u)
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int ethtool_get_eeprom(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_eeprom eeprom;
> +	const struct ethtool_ops *ops = ethtool_ops;
> +	u8 *data;
> +	int ret;
> +
> +	if (!ops->get_eeprom || !ops->get_eeprom_len)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&eeprom, useraddr, sizeof(eeprom)) != 0u)
> +		return -EFAULT;
> +
> +	/* Check for wrap and zero */
> +	if (eeprom.offset + eeprom.len <= eeprom.offset)
> +		return -EINVAL;
> +
> +	/* Check for exceeding total eeprom len */
> +	if (eeprom.offset + eeprom.len > ops->get_eeprom_len(dev))
> +		return -EINVAL;
> +
> +	data = kmalloc(eeprom.len, GFP_USER);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ret = -EFAULT;
> +	if (copy_from_user(data, useraddr + sizeof(eeprom), eeprom.len) != 0u)
> +		goto out;
> +
> +	ret = ops->get_eeprom(dev, &eeprom, data);
> +	if (ret)
> +		goto out;
> +
> +	ret = -EFAULT;
> +	if (copy_to_user(useraddr, &eeprom, sizeof(eeprom)) != 0u)
> +		goto out;
> +	if (copy_to_user(useraddr + sizeof(eeprom), data, eeprom.len) != 0u)
> +		goto out;
> +	ret = 0;
> +
> +out:
> +	kfree(data);
> +	return ret;
> +}
> +
> +static int ethtool_set_eeprom(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_eeprom eeprom;
> +	const struct ethtool_ops *ops = ethtool_ops;
> +	u8 *data;
> +	int ret;
> +
> +	if (!ops->set_eeprom || !ops->get_eeprom_len)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&eeprom, useraddr, sizeof(eeprom)) != 0u)
> +		return -EFAULT;
> +
> +	/* Check for wrap and zero */
> +	if (eeprom.offset + eeprom.len <= eeprom.offset)
> +		return -EINVAL;
> +
> +	/* Check for exceeding total eeprom len */
> +	if (eeprom.offset + eeprom.len > ops->get_eeprom_len(dev))
> +		return -EINVAL;
> +
> +	data = kmalloc(eeprom.len, GFP_USER);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ret = -EFAULT;
> +	if (copy_from_user(data, useraddr + sizeof(eeprom), eeprom.len) != 0u)
> +		goto out;
> +
> +	ret = ops->set_eeprom(dev, &eeprom, data);
> +	if (ret)
> +		goto out;
> +
> +	if (copy_to_user(useraddr + sizeof(eeprom), data, eeprom.len) != 0u)
> +		ret = -EFAULT;
> +
> +out:
> +	kfree(data);
> +	return ret;
> +}
> +
> +static int ethtool_get_coalesce(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_coalesce coalesce = {ETHTOOL_GCOALESCE};
> +
> +	if (!ethtool_ops->get_coalesce)
> +		return -EOPNOTSUPP;
> +
> +	ethtool_ops->get_coalesce(dev, &coalesce);
> +
> +	if (copy_to_user(useraddr, &coalesce, sizeof(coalesce)) != 0u)
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int ethtool_set_coalesce(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_coalesce coalesce;
> +
> +	if (!ethtool_ops->get_coalesce)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&coalesce, useraddr, sizeof(coalesce)) != 0u)
> +		return -EFAULT;
> +
> +	return ethtool_ops->set_coalesce(dev, &coalesce);
> +}
> +
> +static int ethtool_get_ringparam(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_ringparam ringparam = {ETHTOOL_GRINGPARAM};
> +
> +	if (!ethtool_ops->get_ringparam)
> +		return -EOPNOTSUPP;
> +
> +	ethtool_ops->get_ringparam(dev, &ringparam);
> +
> +	if (copy_to_user(useraddr, &ringparam, sizeof(ringparam)) != 0u)
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int ethtool_set_ringparam(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_ringparam ringparam;
> +
> +	if (!ethtool_ops->get_ringparam)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&ringparam, useraddr, sizeof(ringparam)) != 0u)
> +		return -EFAULT;
> +
> +	return ethtool_ops->set_ringparam(dev, &ringparam);
> +}
> +
> +static int ethtool_get_pauseparam(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_pauseparam pauseparam = {ETHTOOL_GPAUSEPARAM};
> +
> +	if (!ethtool_ops->get_pauseparam)
> +		return -EOPNOTSUPP;
> +
> +	ethtool_ops->get_pauseparam(dev, &pauseparam);
> +
> +	if (copy_to_user(useraddr, &pauseparam, sizeof(pauseparam)) != 0u)
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int ethtool_set_pauseparam(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_pauseparam pauseparam;
> +
> +	if (!ethtool_ops->get_pauseparam)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&pauseparam, useraddr, sizeof(pauseparam)) != 0u)
> +		return -EFAULT;
> +
> +	return ethtool_ops->set_pauseparam(dev, &pauseparam);
> +}
> +
> +static int ethtool_get_rx_csum(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_value edata = {ETHTOOL_GRXCSUM};
> +
> +	if (!ethtool_ops->get_rx_csum)
> +		return -EOPNOTSUPP;
> +
> +	edata.data = ethtool_ops->get_rx_csum(dev);
> +
> +	if (copy_to_user(useraddr, &edata, sizeof(edata)) != 0u)
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int ethtool_set_rx_csum(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_value edata;
> +
> +	if (!ethtool_ops->set_rx_csum)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&edata, useraddr, sizeof(edata)) != 0u)
> +		return -EFAULT;
> +
> +	ethtool_ops->set_rx_csum(dev, edata.data);
> +	return 0;
> +}
> +
> +static int ethtool_get_tx_csum(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_value edata = {ETHTOOL_GTXCSUM};
> +
> +	if (!ethtool_ops->get_tx_csum)
> +		return -EOPNOTSUPP;
> +
> +	edata.data = ethtool_ops->get_tx_csum(dev);
> +
> +	if (copy_to_user(useraddr, &edata, sizeof(edata)) != 0u)
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int ethtool_set_tx_csum(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_value edata;
> +
> +	if (!ethtool_ops->set_tx_csum)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&edata, useraddr, sizeof(edata)) != 0u)
> +		return -EFAULT;
> +
> +	return ethtool_ops->set_tx_csum(dev, edata.data);
> +}
> +
> +static int ethtool_get_sg(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_value edata = {ETHTOOL_GSG};
> +
> +	if (!ethtool_ops->get_sg)
> +		return -EOPNOTSUPP;
> +
> +	edata.data = ethtool_ops->get_sg(dev);
> +
> +	if (copy_to_user(useraddr, &edata, sizeof(edata)) != 0u)
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int ethtool_set_sg(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_value edata;
> +
> +	if (!ethtool_ops->set_sg)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&edata, useraddr, sizeof(edata)) != 0u)
> +		return -EFAULT;
> +
> +	return ethtool_ops->set_sg(dev, edata.data);
> +}
> +
> +static int ethtool_get_tso(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_value edata = {ETHTOOL_GTSO};
> +
> +	if (!ethtool_ops->get_tso)
> +		return -EOPNOTSUPP;
> +
> +	edata.data = ethtool_ops->get_tso(dev);
> +
> +	if (copy_to_user(useraddr, &edata, sizeof(edata)) != 0u)
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int ethtool_set_tso(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_value edata;
> +
> +	if (!ethtool_ops->set_tso)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&edata, useraddr, sizeof(edata)) != 0u)
> +		return -EFAULT;
> +
> +	return ethtool_ops->set_tso(dev, edata.data);
> +}
> +
> +static int ethtool_self_test(struct net_device *dev, char *useraddr)
> +{
> +	struct ethtool_test test;
> +	const struct ethtool_ops *ops = ethtool_ops;
> +	u64 *data;
> +	int ret;
> +
> +	if (!ops->self_test || !ops->self_test_count)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&test, useraddr, sizeof(test)) != 0u)
> +		return -EFAULT;
> +
> +	test.len = ops->self_test_count(dev);
> +	data = kmalloc(test.len * sizeof(u64), GFP_USER);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ops->self_test(dev, &test, data);
> +
> +	ret = -EFAULT;
> +	if (copy_to_user(useraddr, &test, sizeof(test)) != 0u)
> +		goto out;
> +	useraddr += sizeof(test);
> +	if (copy_to_user(useraddr, data, test.len * sizeof(u64)) != 0u)
> +		goto out;
> +	ret = 0;
> +
> +out:
> +	kfree(data);
> +	return ret;
> +}
> +
> +static int ethtool_get_strings(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_gstrings gstrings;
> +	const struct ethtool_ops *ops = ethtool_ops;
> +	u8 *data;
> +	int ret;
> +
> +	if (!ops->get_strings)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&gstrings, useraddr, sizeof(gstrings)) != 0u)
> +		return -EFAULT;
> +
> +	switch (gstrings.string_set) {
> +	case ETH_SS_TEST:
> +		if (!ops->self_test_count)
> +			return -EOPNOTSUPP;
> +		gstrings.len = ops->self_test_count(dev);
> +		break;
> +	case ETH_SS_STATS:
> +		if (!ops->get_stats_count)
> +			return -EOPNOTSUPP;
> +		gstrings.len = ops->get_stats_count(dev);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	data = kmalloc(gstrings.len * ETH_GSTRING_LEN, GFP_USER);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ops->get_strings(dev, gstrings.string_set, data);
> +
> +	ret = -EFAULT;
> +	if (copy_to_user(useraddr, &gstrings, sizeof(gstrings)) != 0u)
> +		goto out;
> +	useraddr += sizeof(gstrings);
> +	if (copy_to_user(useraddr, data, gstrings.len * ETH_GSTRING_LEN) != 0u)
> +		goto out;
> +	ret = 0;
> +
> +out:
> +	kfree(data);
> +	return ret;
> +}
> +
> +static int ethtool_phys_id(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_value id;
> +
> +	if (!ethtool_ops->phys_id)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&id, useraddr, sizeof(id)) != 0u)
> +		return -EFAULT;
> +
> +	return ethtool_ops->phys_id(dev, id.data);
> +}
> +
> +static int ethtool_get_stats(struct net_device *dev, void *useraddr)
> +{
> +	struct ethtool_stats stats;
> +	const struct ethtool_ops *ops = ethtool_ops;
> +	u64 *data;
> +	int ret;
> +
> +	if (!ops->get_ethtool_stats || !ops->get_stats_count)
> +		return -EOPNOTSUPP;
> +
> +	if (copy_from_user(&stats, useraddr, sizeof(stats)) != 0u)
> +		return -EFAULT;
> +
> +	stats.n_stats = ops->get_stats_count(dev);
> +	data = kmalloc(stats.n_stats * sizeof(u64), GFP_USER);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ops->get_ethtool_stats(dev, &stats, data);
> +
> +	ret = -EFAULT;
> +	if (copy_to_user(useraddr, &stats, sizeof(stats)) != 0u)
> +		goto out;
> +	useraddr += sizeof(stats);
> +	if (copy_to_user(useraddr, data, stats.n_stats * sizeof(u64)) != 0u)
> +		goto out;
> +	ret = 0;
> +
> +out:
> +	kfree(data);
> +	return ret;
> +}
> +
> +static int ethtool_ioctl(struct ifreq *ifr)
> +{
> +	struct net_device *dev = __dev_get_by_name(ifr->ifr_name);
> +	void *useraddr = (void *)ifr->ifr_data;
> +	u32 ethcmd;
> +
> +	/* XXX: This can be pushed down into the ethtool_* handlers that
> +	 * need it.  Keep existing behavior for the moment.
> +	 */
> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;
> +
> +	if (!dev || !netif_device_present(dev))
> +		return -ENODEV;
> +
> +	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)) != 0u)
> +		return -EFAULT;
> +
> +	switch (ethcmd) {
> +	case ETHTOOL_GSET:
> +		return ethtool_get_settings(dev, useraddr);
> +	case ETHTOOL_SSET:
> +		return ethtool_set_settings(dev, useraddr);
> +	case ETHTOOL_GDRVINFO:
> +		return ethtool_get_drvinfo(dev, useraddr);
> +	case ETHTOOL_GREGS:
> +		return ethtool_get_regs(dev, useraddr);
> +	case ETHTOOL_GWOL:
> +		return ethtool_get_wol(dev, useraddr);
> +	case ETHTOOL_SWOL:
> +		return ethtool_set_wol(dev, useraddr);
> +	case ETHTOOL_GMSGLVL:
> +		return ethtool_get_msglevel(dev, useraddr);
> +	case ETHTOOL_SMSGLVL:
> +		return ethtool_set_msglevel(dev, useraddr);
> +	case ETHTOOL_NWAY_RST:
> +		return ethtool_nway_reset(dev);
> +	case ETHTOOL_GLINK:
> +		return ethtool_get_link(dev, useraddr);
> +	case ETHTOOL_GEEPROM:
> +		return ethtool_get_eeprom(dev, useraddr);
> +	case ETHTOOL_SEEPROM:
> +		return ethtool_set_eeprom(dev, useraddr);
> +	case ETHTOOL_GCOALESCE:
> +		return ethtool_get_coalesce(dev, useraddr);
> +	case ETHTOOL_SCOALESCE:
> +		return ethtool_set_coalesce(dev, useraddr);
> +	case ETHTOOL_GRINGPARAM:
> +		return ethtool_get_ringparam(dev, useraddr);
> +	case ETHTOOL_SRINGPARAM:
> +		return ethtool_set_ringparam(dev, useraddr);
> +	case ETHTOOL_GPAUSEPARAM:
> +		return ethtool_get_pauseparam(dev, useraddr);
> +	case ETHTOOL_SPAUSEPARAM:
> +		return ethtool_set_pauseparam(dev, useraddr);
> +	case ETHTOOL_GRXCSUM:
> +		return ethtool_get_rx_csum(dev, useraddr);
> +	case ETHTOOL_SRXCSUM:
> +		return ethtool_set_rx_csum(dev, useraddr);
> +	case ETHTOOL_GTXCSUM:
> +		return ethtool_get_tx_csum(dev, useraddr);
> +	case ETHTOOL_STXCSUM:
> +		return ethtool_set_tx_csum(dev, useraddr);
> +	case ETHTOOL_GSG:
> +		return ethtool_get_sg(dev, useraddr);
> +	case ETHTOOL_SSG:
> +		return ethtool_set_sg(dev, useraddr);
> +	case ETHTOOL_GTSO:
> +		return ethtool_get_tso(dev, useraddr);
> +	case ETHTOOL_STSO:
> +		return ethtool_set_tso(dev, useraddr);
> +	case ETHTOOL_TEST:
> +		return ethtool_self_test(dev, useraddr);
> +	case ETHTOOL_GSTRINGS:
> +		return ethtool_get_strings(dev, useraddr);
> +	case ETHTOOL_PHYS_ID:
> +		return ethtool_phys_id(dev, useraddr);
> +	case ETHTOOL_GSTATS:
> +		return ethtool_get_stats(dev, useraddr);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +#endif /* ETHTOOL_OPS_COMPAT */
> +
> +static int rtase_siocdevprivate(struct net_device *dev, struct ifreq *ifr, void __user *data,
> +				int cmd)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	int ret = 0;
> +
> +	(void)data;
> +
> +	if ((tp->ptm_support == 0u) && (cmd == SIO_PRIV_RTK_PTM)) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	switch (cmd) {
> +	case SIO_PRIV_RTK_REG:
> +		ret = reg_fun(ifr, tp);
> +		break;
> +	case SIO_PRIV_RTK_RXQOS:
> +		ret = rtase_rxqos(ifr, tp);
> +		break;
> +	case SIO_TIMEOUT_SIG_SET:
> +		ret = timeout_sig(ifr, tp);
> +		break;
> +	case SIO_PRIV_RTK_PTM:
> +		ret = rtase_ptm(ifr, tp);
> +		break;
> +	case SIO_PRIV_RTK_INFO:
> +		ret = rtase_debug_msg(ifr, tp);
> +		break;
> +
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +static int rtase_do_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	int ret = 0;
> +
> +	(void)ifr;
> +
> +	if ((tp->ptm_support == 0u) && (cmd == SIO_PRIV_RTK_PTM)) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	switch (cmd) {
> +#ifdef ETHTOOL_OPS_COMPAT
> +	case SIOCETHTOOL:
> +		ret = ethtool_ioctl(ifr);
> +		break;
> +#endif
> +
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +static s32 rtase_alloc_msix(struct pci_dev *pdev, struct rtase_private *tp)
> +{
> +	u16 i = 0;
> +	s32 rc = 0;
> +
> +	memset(tp->msix_entry, 0x0, NUM_MSIX * sizeof(struct msix_entry));
> +	for (i = 0u; i < NUM_MSIX; i++)
> +		tp->msix_entry[i].entry = (u16)i;
> +
> +	rc = pci_enable_msix_range(pdev, tp->msix_entry, (s32)tp->int_nums, (s32)tp->int_nums);
> +
> +	if ((u16)rc == tp->int_nums) {
> +		for (i = 0u; i < tp->int_nums; i++) {
> +			tp->int_vector[i].irq = (u32)(pci_irq_vector(pdev, (u32)i));
> +			tp->int_vector[i].status = 1;
> +		}
> +	}
> +
> +	return rc;
> +}
> +
> +static s32 rtase_alloc_interrupt(struct pci_dev *pdev, struct rtase_private *tp)

By using pci_alloc_irq_vectors() a lot if this stuff here shouldn't be needed.

> +{
> +	s32 rc = 0;
> +
> +	rc = rtase_alloc_msix(pdev, tp);
> +	if ((u16)rc != tp->int_nums) {
> +		rc = pci_enable_msi(pdev);
> +		if (rc != 0)
> +			dev_err(&pdev->dev, "unable to alloc interrupt.(MSI)\n");
> +		else
> +			tp->sw_flag |= (u32)SWF_MSI_ENABLED;
> +	} else {
> +		tp->sw_flag |= (u32)SWF_MSIX_ENABLED;
> +	}
> +
> +	return rc;
> +}
> +
> +static void rtase_reset_interrupt(struct pci_dev *pdev, const struct rtase_private *tp)
> +{
> +	if ((tp->sw_flag & SWF_MSIX_ENABLED) != 0u)
> +		pci_disable_msix(pdev);
> +	else if ((tp->sw_flag & SWF_MSI_ENABLED) != 0u)
> +		pci_disable_msi(pdev);
> +	else
> +		netdev_info(tp->dev, "interrupt is never enabled\n");
> +}
> +
> +/* rtase_init_board -
> + * @pdev: PCI device struct
> + * @dev_out:
> + * @ioaddr_out:
> + *
> + * Return 0 on success, negative on failure
> + */
> +static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
> +			    void __iomem **ioaddr_out)
> +{
> +	void __iomem *ioaddr;
> +	struct net_device *dev;
> +	struct rtase_private *tp;
> +	int rc = -ENOMEM;
> +
> +	assert(ioaddr_out);
> +
> +	/* dev zeroed in alloc_etherdev */
> +	dev = alloc_etherdev_mq((s32)(sizeof(struct rtase_private)), func_txq_num);
> +	if (!dev) {
> +		if (netif_msg_drv(&debug) != 0u)
> +			dev_err(&pdev->dev, "unable to alloc new ethernet\n");
> +
> +		goto err_out;
> +	}
> +
> +	SET_MODULE_OWNER(dev);
> +	SET_NETDEV_DEV(dev, &pdev->dev);
> +	tp = netdev_priv(dev);
> +	tp->dev = dev;
> +	tp->msg_enable = netif_msg_init((s32)debug.msg_enable, (s32)RTASE_MSG_DEFAULT);
> +
> +	/* enable device (incl. PCI PM wakeup and hotplug setup) */
> +	rc = pci_enable_device(pdev);
> +	if (rc < 0) {
> +		if (netif_msg_probe(tp) != 0u)
> +			dev_err(&pdev->dev, "enable failure\n");
> +
> +		goto err_out_free_dev;
> +	}
> +
> +	/* make sure PCI base addr 1 is MMIO */
> +	if ((pci_resource_flags(pdev, 2) & (u64)IORESOURCE_MEM) == 0u) {
> +		if (netif_msg_probe(tp) != 0u)
> +			dev_err(&pdev->dev, "region #1 not an MMIO resource, aborting\n");
> +
> +		rc = -ENODEV;
> +		goto err_out_disable;
> +	}
> +
> +	/* check for weird/broken PCI region reporting */
> +	if (pci_resource_len(pdev, 2) < RTASE_REGS_SIZE) {
> +		if (netif_msg_probe(tp) != 0u)
> +			dev_err(&pdev->dev, "Invalid PCI region size(s), aborting\n");
> +
> +		rc = -ENODEV;
> +		goto err_out_disable;
> +	}
> +
> +	rc = pci_request_regions(pdev, MODULENAME);
> +	if (rc < 0) {
> +		if (netif_msg_probe(tp) != 0u)
> +			dev_err(&pdev->dev, "could not request regions.\n");
> +
> +		goto err_out_disable;
> +	}
> +
> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) == 0)
> +		dev->features |= NETIF_F_HIGHDMA;
> +	else if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0)
> +		goto err_out_free_res;
> +	else
> +		pr_info("DMA_BIT_MASK: 32\n");
> +
> +	pci_set_master(pdev);
> +
> +	/* ioremap MMIO region */
> +	ioaddr = ioremap(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2));
> +	if (!ioaddr) {
> +		if (netif_msg_probe(tp) != 0u)
> +			dev_err(&pdev->dev, "cannot remap MMIO, aborting\n");
> +
> +		rc = -EIO;
> +		goto err_out_free_res;
> +	}
> +
> +	/* Identify chip attached to board */
> +	rtase_get_mac_version(tp, ioaddr);
> +	rtase_print_mac_version(tp);
> +
> +	*ioaddr_out = ioaddr;
> +	*dev_out = dev;
> +	goto out;
> +
> +err_out_free_res:
> +	pci_release_regions(pdev);
> +
> +err_out_disable:
> +	pci_disable_device(pdev);
> +
> +err_out_free_dev:
> +	free_netdev(dev);
> +
> +err_out:
> +	*ioaddr_out = NULL;
> +	*dev_out = NULL;
> +
> +out:
> +	return rc;
> +}
> +
> +static const struct net_device_ops rtase_netdev_ops = {
> +	.ndo_open = rtase_open,
> +	.ndo_stop = rtase_close,
> +	.ndo_start_xmit = rtase_start_xmit,
> +	.ndo_set_rx_mode = rtase_set_rx_mode,
> +	.ndo_set_mac_address = rtase_set_mac_address,
> +	.ndo_siocdevprivate = rtase_siocdevprivate,
> +	.ndo_eth_ioctl = rtase_do_ioctl,
> +	.ndo_change_mtu = rtase_change_mtu,
> +	.ndo_tx_timeout = rtase_tx_timeout,
> +	.ndo_get_stats64 = rtase_get_stats64,
> +	.ndo_vlan_rx_add_vid = rtase_vlan_rx_add_vid,
> +	.ndo_vlan_rx_kill_vid = rtase_vlan_rx_kill_vid,
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +	.ndo_poll_controller = rtase_netpoll,
> +#endif
> +#ifdef IFLA_VF_MAX
> +	.ndo_set_vf_mac = rtase_set_vf_mac,
> +	.ndo_get_vf_config = rtase_get_vf_config,
> +#endif /* IFLA_VF_MAX */
> +	.ndo_setup_tc = rtase_setup_tc,
> +	.ndo_fix_features = rtase_fix_features,
> +	.ndo_set_features = rtase_set_features,
> +};
> +
> +static void rtase_init_netdev_ops(struct net_device *dev)
> +{
> +	dev->netdev_ops = &rtase_netdev_ops;
> +
> +	SET_ETHTOOL_OPS(dev, &rtase_ethtool_ops);
> +}
> +
> +/* rtase_init_one - PCI Device Initialization
> + * @pdev: PCI device struct
> + * @ent: entry in rtlxxx_pci_tbl
> + *
> + * Return 0 on success, negative on failure
> + */
> +static int rtase_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	struct net_device *dev = NULL;
> +	struct rtase_private *tp;
> +	void __iomem *ioaddr = NULL;
> +	int rc;
> +
> +	(void)ent;
Don't do this.

> +	assert(pdev);
> +	assert(ent);
> +
> +	if ((pdev->is_physfn == 0u) && (pdev->is_virtfn != 0u)) {
> +		pr_info("%s This module does not support a virtual function.", MODULENAME);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (netif_msg_drv(&debug) != 0u)
> +		pr_info("%s Automotive Switch Ethernet driver %s loaded\n", MODULENAME,
> +			RTASE_VERSION);
> +
> +	rc = rtase_init_board(pdev, &dev, &ioaddr);
> +	if (rc != 0)
> +		goto out;
> +
> +	tp = netdev_priv(dev);
> +	assert(ioaddr);
> +	tp->mmio_addr = ioaddr;
> +	tp->pdev = pdev;
> +	dev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev, struct pcpu_sw_netstats);
> +	if (!dev->tstats)
> +		goto err_out_1;
> +
> +	rtase_init_software_variable(dev);
> +	rtase_init_hardware(tp);
> +
> +	rc = rtase_alloc_interrupt(pdev, tp);
> +	if (rc < 0)
> +		pr_err("unable to alloc MSIX/MSI\n");
> +
> +	rtase_init_netdev_ops(dev);
> +
> +	dev->watchdog_timeo = RTASE_TX_TIMEOUT;
> +	dev->irq = (s32)pdev->irq;
> +	dev->base_addr = (unsigned long)ioaddr;
> +
> +	dev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
> +#ifdef RTL_HW_VLAN_FILTER
> +	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
> +#endif
> +
> +	if (tp->mcfg != CFG_METHOD_DEFAULT) {
> +		dev->features |= NETIF_F_IP_CSUM;
> +		dev->features |= NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_TSO;
> +		dev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO | NETIF_F_RXCSUM
> +				   | NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
> +		dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO | NETIF_F_HIGHDMA;
> +		dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> +		dev->hw_features |= NETIF_F_RXALL;
> +		dev->hw_features |= NETIF_F_RXFCS;
> +		dev->hw_features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
> +		dev->features |= NETIF_F_IPV6_CSUM | NETIF_F_TSO6;
> +		netif_set_tso_max_size(dev, LSO_64K);
> +		netif_set_tso_max_segs(dev, NIC_MAX_PHYS_BUF_COUNT_LSO2);
> +	}
> +
> +	if (rtase_get_mac_address(dev) != 0)
> +		pr_alert("unable to get mac address\n");
> +
> +	tp->tally_vaddr = dma_alloc_coherent(&pdev->dev, sizeof(*tp->tally_vaddr), &tp->tally_paddr,
> +					     GFP_KERNEL);
> +	if (!tp->tally_vaddr) {
> +		rc = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	rtase_tally_counter_clear(tp);
> +
> +	pci_set_drvdata(pdev, dev);
> +
> +	rc = register_netdev(dev);
> +	if (rc != 0)
> +		goto err_out;
> +
> +	pr_info("%s: This product is covered by one or more of the following patents: US6,570,884, US6,115,776, and US6,327,625.\n",
> +		MODULENAME);
> +
> +	netif_carrier_off(dev);
> +
> +	pr_info("%s", GPL_CLAIM);
> +	goto out;
> +
> +err_out:
> +	if (tp->tally_vaddr) {
> +		dma_free_coherent(&pdev->dev, sizeof(*tp->tally_vaddr), tp->tally_vaddr,
> +				  tp->tally_paddr);
> +
> +		tp->tally_vaddr = NULL;
> +	}
> +
> +err_out_1:
> +	rtase_release_board(pdev, dev, ioaddr);
> +
> +out:
> +	return rc;
> +}
> +
> +static void rtase_remove_one(struct pci_dev *pdev)
> +{
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	struct rtase_private *tp = netdev_priv(dev);
> +	struct rtase_int_vector *ivec;
> +	u32 i = 0u;
> +
> +	assert(dev);
> +	assert(tp);
> +
> +	for (i = 0u; i < tp->int_nums; i++) {
> +		ivec = &tp->int_vector[i];
> +		netif_napi_del(&ivec->napi);
> +	}
> +
> +#ifdef CONFIG_SRIOV
> +	if (tp->num_vfs != 0u) {
> +		if (rtase_disable_sriov(tp) != 0)
> +			pr_alert("unable to disable sriov\n");
> +	}
> +#endif
> +
> +	unregister_netdev(dev);
> +	rtase_reset_interrupt(pdev, tp);
> +#ifdef ENABLE_RTASE_PROCFS
> +	rtase_proc_remove(dev);
> +#endif
> +	if (tp->tally_vaddr) {
> +		dma_free_coherent(&pdev->dev, sizeof(*tp->tally_vaddr), tp->tally_vaddr,
> +				  tp->tally_paddr);
> +		tp->tally_vaddr = NULL;
> +	}
> +
> +	rtase_release_board(pdev, dev, tp->mmio_addr);
> +	pci_set_drvdata(pdev, NULL);
> +}
> +
> +static void rtase_set_rxbufsize(struct rtase_private *tp, const struct net_device *dev)
> +{
> +	u32 mtu = dev->mtu;
> +
> +	tp->rx_buf_sz = (mtu > (u32)ETH_DATA_LEN) ? (mtu + (u32)ETH_HLEN + 8u + 1u) : RX_BUF_SIZE;
> +}
> +
> +static void rtase_free_desc(struct rtase_private *tp)
> +{
> +	struct pci_dev *pdev = tp->pdev;
> +	u32 i = 0;
> +
> +	for (i = 0u; i < tp->func_tx_queue_num; i++) {
> +		if (tp->tx_ring[i].desc) {
> +			dma_free_coherent(&pdev->dev, RTASE_TX_RING_DESC_SIZE, tp->tx_ring[i].desc,
> +					  tp->tx_ring[i].phy_addr);
> +			tp->tx_ring[i].desc = NULL;
> +		}
> +	}
> +
> +	for (i = 0u; i < tp->func_rx_queue_num; i++) {
> +		if (tp->rx_ring[i].desc) {
> +			dma_free_coherent(&pdev->dev, RTASE_RX_RING_DESC_SIZE, tp->rx_ring[i].desc,
> +					  tp->rx_ring[i].phy_addr);
> +			tp->rx_ring[i].desc = NULL;
> +		}
> +	}
> +}
> +
> +static s32 rtase_alloc_desc(struct rtase_private *tp)
> +{
> +	struct pci_dev *pdev = tp->pdev;
> +	u32 i = 0;
> +	s32 retval = 0;
> +
> +	/* allocate tx descriptor rings */
> +	for (i = 0u; i < tp->func_tx_queue_num; i++) {
> +		tp->tx_ring[i].desc = dma_alloc_coherent(&pdev->dev, RTASE_TX_RING_DESC_SIZE,
> +							 &tp->tx_ring[i].phy_addr, GFP_KERNEL);
> +		if (!tp->tx_ring[i].desc) {
> +			retval = -ENOMEM;
> +			break;
> +		}
> +	}
> +
> +	if (retval == 0) {
> +		/* allocate rx descriptor rings */
> +		for (i = 0u; i < tp->func_rx_queue_num; i++) {
> +			tp->rx_ring[i].desc =
> +				dma_alloc_coherent(&pdev->dev, RTASE_RX_RING_DESC_SIZE,
> +						   &tp->rx_ring[i].phy_addr, GFP_KERNEL);
> +			if (!tp->rx_ring[i].desc) {
> +				retval = -ENOMEM;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return retval;
> +}
> +
> +static int rtase_open(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	const struct pci_dev *pdev = tp->pdev;
> +	struct rtase_int_vector *ivec = &tp->int_vector[0];
> +	int retval;
> +	u16 i;
> +
> +#ifdef ENABLE_RTASE_PROCFS
> +	rtase_proc_init(dev);
> +#endif
> +	rtase_set_rxbufsize(tp, dev);
> +
> +	retval = rtase_alloc_desc(tp);
> +	if (retval < 0)
> +		goto err_free_all_allocated_mem;
> +
> +	retval = rtase_init_ring(dev);
> +	if (retval < 0)
> +		goto err_free_all_allocated_mem;
> +
> +	if (netif_msg_probe(tp) != 0u) {
> +		netdev_info(dev, "%s: 0x%lx, %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x, IRQ %d\n",
> +			    dev->name, dev->base_addr, dev->dev_addr[0], dev->dev_addr[1],
> +			    dev->dev_addr[2], dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5],
> +			    dev->irq);
> +	}
> +
> +	INIT_DELAYED_WORK(&tp->task, NULL);
> +
> +	rtase_hw_config(dev);
> +
> +	if ((tp->sw_flag & SWF_MSIX_ENABLED) != 0u) {
> +		retval = request_irq(ivec->irq, rtase_interrupt, 0, dev->name, dev);
> +
> +		/* request other interrupts to handle multiqueue */
> +		for (i = 1; i < tp->int_nums; i++) {
> +			if (retval == 0) {
> +				ivec = &tp->int_vector[i];
> +				if (ivec->status == 1u) {
> +					sprintf((char *)&ivec->name, "%s_int%i", dev->name, i);
> +					retval = request_irq(ivec->irq, rtase_q_interrupt, 0,
> +							     (char *)&ivec->name, ivec);
> +				}
> +			}
> +		}
> +	} else if ((tp->sw_flag & SWF_MSI_ENABLED) != 0u) {
> +		retval = request_irq(pdev->irq, rtase_interrupt, 0, dev->name, dev);
> +	} else {
> +		retval = request_irq(pdev->irq, rtase_interrupt, SA_SHIRQ, dev->name, dev);
> +	}
> +
> +	if (retval != 0) {
> +		netdev_err(dev, "%s: can't request MSIX interrupt. Error: %d", dev->name, retval);
> +		goto err_free_all_allocated_mem;
> +	}
> +
> +	/* always link, so start to transmit & receive */
> +	if ((tp->sw_flag & SWF_SRIOV_ENABLED) != 0u) {
> +		rtase_func_enable(tp);
> +		rtase_enable_hw_interrupt(tp);
> +	} else {
> +		rtase_hw_start(dev);
> +	}
> +	netif_carrier_on(dev);
> +	netif_wake_queue(dev);
> +	if (netif_msg_ifup(tp) != 0u)
> +		netdev_info(dev, PFX "%s: link up\n", dev->name);
> +
> +	goto out;
> +
> +err_free_all_allocated_mem:
> +	rtase_free_desc(tp);
> +
> +out:
> +	return retval;
> +}
> +
> +static void rtase_set_mar(const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 mc_filter[2];
> +
> +	mc_filter[0] = tp->mc_filter[0];
> +	mc_filter[1] = tp->mc_filter[1];
> +
> +	if ((tp->sw_flag & SWF_SRIOV_ENABLED) != 0u) {
> +		u8 i = 0u;
> +
> +		for (i = 0u; i < tp->num_vfs; i++) {
> +			mc_filter[0] |= tp->vf_info[i].mc_filter[0];
> +			mc_filter[1] |= tp->vf_info[i].mc_filter[1];
> +		}
> +	}
> +
> +	RTL_W32(MAR0, mc_filter[0]);
> +	RTL_W32(MAR1, mc_filter[1]);
> +}
> +
> +void rtase_hw_set_rx_packet_filter(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	static const s32 multicast_filter_limit = 32;
> +	u32 mc_filter[2]; /* Multicast hash filter */
> +	u16 rx_mode = (u16)(RTL_R16(RX_CONFIG_0) & ~ACCEPT_MASK);
> +
> +	if ((dev->flags & IFF_PROMISC) != 0u) {
> +		/* Unconditionally log net taps. */
> +		if (netif_msg_link(tp) != 0u)
> +			netdev_notice(dev, "%s: Promiscuous mode enabled.\n", dev->name);
> +
> +		rx_mode |=
> +			(u16)(ACCEPT_BROADCAST | ACCEPT_MULTICAST | ACCEPT_MYPHYS | ACCEPT_ALLPHYS);
> +		mc_filter[0] = 0xFFFFFFFFu;
> +		mc_filter[1] = 0xFFFFFFFFu;
> +	} else if ((netdev_mc_count(dev) > multicast_filter_limit)
> +		   || ((dev->flags & IFF_ALLMULTI) != 0u)) {
> +		/* Too many to filter perfectly -- accept all multicasts. */
> +		rx_mode |= (u16)(ACCEPT_BROADCAST | ACCEPT_MULTICAST | ACCEPT_MYPHYS);
> +		mc_filter[0] = 0xFFFFFFFFu;
> +		mc_filter[1] = 0xFFFFFFFFu;
> +	} else {
> +		const struct netdev_hw_addr *ha;
> +
> +		rx_mode |= (u16)(ACCEPT_BROADCAST | ACCEPT_MYPHYS);
> +		mc_filter[0] = 0u;
> +		mc_filter[1] = 0u;
> +
> +		/* clang-format off */
> +		netdev_for_each_mc_addr(ha, dev) {
> +			u32 bit_nr = (ether_crc(ETH_ALEN, ha->addr) >> 26);
> +
> +			mc_filter[bit_nr >> 5] |= ((u32)1u << (bit_nr & 31u));
> +			rx_mode |= (u16)ACCEPT_MULTICAST;
> +		}
> +		/* clang-format on */
> +	}
> +
> +	if ((dev->features & NETIF_F_RXALL) != 0u)
> +		rx_mode |= (u16)(ACCEPT_ERR | ACCEPT_RUNT);
> +
> +	tp->mc_filter[0] = swab32(mc_filter[1]);
> +	tp->mc_filter[1] = swab32(mc_filter[0]);
> +
> +	rtase_set_mar(tp);
> +	RTL_W16(RX_CONFIG_0, rx_mode);
> +}
> +
> +static void rtase_set_rx_mode(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +
> +	rtase_hw_set_rx_packet_filter(dev);
> +
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +}
> +
> +static void rtase_hw_config(struct net_device *dev)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 reg_data = 0;
> +
> +	if ((tp->sw_flag & SWF_SRIOV_ENABLED) == 0u)
> +		rtase_hw_reset(dev);
> +
> +	/* Set Rx DMA burst */
> +	reg_data = RTL_R16(RX_CONFIG_0);
> +	reg_data &= (u32)(~(RX_SINGLE_TAG | RX_SINGLE_FETCH));
> +	reg_data &= ~((u32)RX_MX_DMA_MASK << RX_MX_DMA_SHIFT);
> +	reg_data |= ((u32)RX_DMA_BURST_256 << RX_MX_DMA_SHIFT);
> +	RTL_W16(RX_CONFIG_0, (u16)reg_data);
> +
> +	/* New Rx Descritpor */
> +	reg_data = RTL_R16(RX_CONFIG_1);
> +	reg_data |= (u32)RX_NEW_DESC_FORMAT_EN;
> +	reg_data |= (u32)PCIE_NEW_FLOW;
> +	/* Rx Fetch Desc Number */
> +	reg_data &= ~((u32)RX_MAX_FETCH_DESC_MASK << RX_MAX_FETCH_DESC_SHIFT);
> +	reg_data |= ((u32)0xF << RX_MAX_FETCH_DESC_SHIFT);
> +	RTL_W16(RX_CONFIG_1, (u16)reg_data);
> +
> +	/* Rx queue numbers */
> +	reg_data = RTL_R16(FCR);
> +	reg_data &= ~(FCR_RXQ_MASK << FCR_RXQ_SHIFT);
> +	switch (tp->func_rx_queue_num) {
> +	case 1:
> +		reg_data |= (0x1u << FCR_RXQ_SHIFT);
> +		break;
> +	case 2:
> +		reg_data |= (0x2u << FCR_RXQ_SHIFT);
> +		break;
> +	case 4:
> +		reg_data |= (0x3u << FCR_RXQ_SHIFT);
> +		break;
> +	default:
> +		/* nothing to do. */
> +		break;
> +	}
> +	RTL_W16(FCR, (u16)reg_data);
> +
> +	/* interrupt mitigation */
> +	rtase_interrupt_mitigation(tp);
> +
> +	/* Set Tx DMA burst size and Interframe Gap Time */
> +	reg_data = RTL_R32(TX_CONFIG_0);
> +	reg_data &= ~(((u32)TX_DMA_MASK << TX_DMA_SHIFT)
> +		      | ((u32)TX_INTER_FRAME_GAP_MASK << TX_INTER_FRAME_GAP_SHIFT));
> +	reg_data |= (((u32)TX_DMA_BURST_UNLIMITED << TX_DMA_SHIFT)
> +		     | ((u32)INTERFRAMEGAP << TX_INTER_FRAME_GAP_SHIFT));
> +	RTL_W32(TX_CONFIG_0, reg_data);
> +
> +	/* New Tx Descriptor */
> +	RTL_W16(TFUN_CTRL, (u16)(RTL_R16(TFUN_CTRL) | TX_NEW_DESC_FORMAT_EN));
> +
> +	/* Tx Fetch Desc Number */
> +	RTL_W8(TDFNR, 0x10);
> +
> +	/* tag num select */
> +	reg_data = RTL_R16(MTPS);
> +	reg_data &= ~((u32)0x7u << 8);
> +	reg_data |= ((u32)0x4u << 8);
> +	RTL_W16(MTPS, (u16)reg_data);
> +
> +	/* Tx queue numbers */
> +	reg_data = RTL_R16(TX_CONFIG_1);
> +	reg_data &= ~((u32)0x3u << 10);
> +	switch (tp->tx_queue_ctrl) {
> +	case 1:
> +		break;
> +	case 2:
> +		reg_data |= ((u32)0x1u << 10);
> +		break;
> +	case 3:
> +	case 4:
> +		reg_data |= ((u32)0x2u << 10);
> +		break;
> +	default:
> +		reg_data |= ((u32)0x3u << 10);
> +		break;
> +	}
> +	RTL_W16(TX_CONFIG_1, (u16)reg_data);
> +
> +	/* TOK condition */
> +	RTL_W16(TOKSEL, 0x5555);
> +
> +	rtase_tally_counter_addr_fill(tp);
> +	rtase_desc_addr_fill(tp);
> +
> +	if (rtase_hw_set_features(dev, dev->features) != 0)
> +		netdev_alert(dev, "unable to set hw features\n");
> +
> +	/* TBD: enable flow control */
> +	reg_data = RTL_R16(CPLUS_CMD);
> +	reg_data |= (u32)(FORCE_TXFLOW_EN | FORCE_RXFLOW_EN);
> +	RTL_W16(CPLUS_CMD, (u16)reg_data);
> +	/* Set Near FIFO Threshold - rx missed issue. */
> +	RTL_W16(RFIFONFULL, 0x190);
> +
> +	RTL_W16(RMS, (u16)tp->rx_buf_sz);
> +
> +	/* Set Rx packet filter */
> +	rtase_hw_set_rx_packet_filter(dev);
> +
> +	/* enable ephy interrupt */
> +	mac_ocp_write(tp, 0xEAD0, 0xFF07);
> +}
> +
> +void rtase_hw_start(const struct net_device *dev)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +
> +	/* set watchdog time */
> +	RTL_W32(TIMEOUT0_ADDR, TIMEOUT_SET_TIME);
> +	/* reset timer */
> +	RTL_W32(TCTR0, 0x0);
> +
> +	rtase_nic_enable(dev);
> +	rtase_enable_hw_interrupt(tp);
> +}
> +
> +static int rtase_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	int ret = 0;
> +	unsigned long flags;
> +
> +	if ((tp->sw_flag & SWF_SRIOV_ENABLED) != 0u) {
> +		ret = -EPERM;
> +		goto err_out;
> +	}
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +	dev->mtu = (u32)new_mtu;
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +
> +	if (!netif_running(dev))
> +		goto out;
> +
> +	rtase_down(dev);
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +
> +	rtase_set_rxbufsize(tp, dev);
> +
> +	ret = rtase_init_ring(dev);
> +
> +	if (ret < 0) {
> +		spin_unlock_irqrestore(&tp->lock, flags);
> +		goto err_out;
> +	}
> +
> +	netif_stop_queue(dev);
> +	netif_carrier_off(dev);
> +	rtase_hw_config(dev);
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +
> +	/* always link, so start to transmit & receive */
> +	rtase_hw_start(dev);
> +	netif_carrier_on(dev);
> +	netif_wake_queue(dev);
> +
> +out:
> +	netdev_update_features(dev);
> +
> +err_out:
> +	return ret;
> +}
> +
> +static inline void rtase_make_unusable_by_asic(rx_desc *desc)
> +{
> +	desc->desc_cmd.addr = 0x0BADBADBADBADBADuLL;
> +	desc->desc_cmd.opts1 &= ~cpu_to_le32(DESC_OWN | RSVD_MASK);
> +}
> +
> +static inline void rtase_mark_to_asic(rx_desc *desc, u32 rx_buf_sz)
> +{
> +	u32 eor = (u32)(le32_to_cpu(desc->desc_cmd.opts1) & RING_END);
> +
> +	desc->desc_cmd.opts1 = cpu_to_le32(DESC_OWN | eor | rx_buf_sz);
> +}
> +
> +static inline void rtase_map_to_asic(rx_desc *desc, dma_addr_t mapping, u32 rx_buf_sz)
> +{
> +	desc->desc_cmd.addr = cpu_to_le64(mapping);
> +	/* make sure the physical address has been updated */
> +	wmb();
> +	rtase_mark_to_asic(desc, rx_buf_sz);
> +}
> +
> +static s32 rtase_alloc_rx_skb(const struct rtase_ring *ring, struct sk_buff **p_sk_buff,
> +			      rx_desc *desc, dma_addr_t *rx_phy_addr, u32 rx_buf_sz, u8 in_intr)
> +{
> +	struct rtase_int_vector *ivec = ring->ivec;
> +	const struct rtase_private *tp = ivec->tp;
> +	struct sk_buff *skb = NULL;
> +	dma_addr_t mapping;
> +	s32 ret = 0;
> +
> +	if (in_intr != 0u)
> +		skb = RTL_ALLOC_SKB_INTR(ivec->napi, (rx_buf_sz + RTK_RX_ALIGN));
> +	else
> +		skb = dev_alloc_skb((rx_buf_sz + RTK_RX_ALIGN));
> +
> +	if (unlikely(!skb))
> +		goto err_out;
> +
> +	skb_reserve(skb, (s32)RTK_RX_ALIGN);
> +
> +	mapping = dma_map_single(&tp->pdev->dev, skb->data, rx_buf_sz, DMA_FROM_DEVICE);
> +	if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
> +		if (unlikely(net_ratelimit()))
> +			netif_err(tp, drv, tp->dev, "Failed to map RX DMA!\n");
> +
> +		goto err_out;
> +	}
> +
> +	*p_sk_buff = skb;
> +	*rx_phy_addr = mapping;
> +	rtase_map_to_asic(desc, mapping, rx_buf_sz);
> +	goto out;
> +
> +err_out:
> +	if (skb)
> +		dev_kfree_skb(skb);
> +
> +	ret = -ENOMEM;
> +	rtase_make_unusable_by_asic(desc);
> +
> +out:
> +	return ret;
> +}
> +
> +static void rtase_rx_ring_clear(struct rtase_ring *ring)
> +{
> +	u32 i;
> +	rx_desc *desc;
> +	const struct rtase_private *tp = ring->ivec->tp;
> +
> +	for (i = 0u; i < NUM_DESC; i++) {
> +		desc = ring->desc + (sizeof(rx_desc) * i);
> +
> +		if (ring->skbuff[i]) {
> +			dma_unmap_single(&tp->pdev->dev, ring->mis.data_phy_addr[i], tp->rx_buf_sz,
> +					 DMA_FROM_DEVICE);
> +
> +			dev_kfree_skb(ring->skbuff[i]);
> +
> +			ring->skbuff[i] = NULL;
> +
> +			rtase_make_unusable_by_asic(desc);
> +		}
> +	}
> +}
> +
> +void rtase_rx_clear(struct rtase_private *tp)
> +{
> +	u32 i;
> +
> +	for (i = 0u; i < tp->func_rx_queue_num; i++)
> +		rtase_rx_ring_clear(&tp->rx_ring[i]);
> +}
> +
> +static u32 rtase_rx_ring_fill(struct rtase_ring *ring, u32 ring_start, u32 ring_end, u8 in_intr)
> +{
> +	const struct rtase_private *tp = ring->ivec->tp;
> +	u32 cur;
> +
> +	for (cur = ring_start; (ring_end - cur) > 0u; cur++) {
> +		s32 ret = 0;
> +		u32 i = cur % NUM_DESC;
> +		rx_desc *desc = ring->desc + (sizeof(rx_desc) * i);
> +
> +		if (ring->skbuff[i])
> +			continue;
> +
> +		ret = rtase_alloc_rx_skb(ring, &ring->skbuff[i], desc, &ring->mis.data_phy_addr[i],
> +					 tp->rx_buf_sz, in_intr);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	return (cur - ring_start);
> +}
> +
> +static inline void rtase_mark_as_last_descriptor(rx_desc *desc)
> +{
> +	desc->desc_cmd.opts1 |= cpu_to_le32(RING_END);
> +}
> +
> +static void rtase_desc_addr_fill(const struct rtase_private *tp)
> +{
> +	u16 i = 0;
> +	u16 cmd = 0;
> +	const struct rtase_ring *ring;
> +	void __iomem *ioaddr = tp->mmio_addr;
> +
> +	for (i = 0u; i < tp->func_tx_queue_num; i++) {
> +		ring = &tp->tx_ring[i];
> +
> +		RTL_W32(TX_DESC_START_ADDR0, (u32)(ring->phy_addr & DMA_BIT_MASK(32)));
> +		RTL_W32(TX_DESC_START_ADDR4, (u32)(ring->phy_addr >> 32));
> +		cmd = i | (u16)TX_DESC_CMD_WE | (u16)TX_DESC_CMD_CS;
> +		RTL_W16(TX_DESC_COMMAND, cmd);
> +		usleep_range(100, 110);
> +	}
> +
> +	for (i = 0u; i < tp->func_rx_queue_num; i++) {
> +		ring = &tp->rx_ring[i];
> +
> +		if (i == 0u) {
> +			RTL_W32(Q0_RX_DESC_ADDR0, (u32)((ring->phy_addr & DMA_BIT_MASK(32))));
> +			RTL_W32(Q0_RX_DESC_ADDR4, (u32)(ring->phy_addr >> 32));
> +		} else {
> +			RTL_W32((Q1_RX_DESC_ADDR0 + ((i - 1u) * 8u)),
> +				(u32)(ring->phy_addr & DMA_BIT_MASK(32)));
> +			RTL_W32((Q1_RX_DESC_ADDR4 + ((i - 1u) * 8u)), (u32)(ring->phy_addr >> 32));
> +		}
> +	}
> +}
> +
> +static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)
> +{
> +	u32 i = 0;
> +	struct rtase_ring *ring = &tp->tx_ring[idx];
> +	tx_desc *desc;
> +
> +	memset(ring->desc, 0x0, RTASE_TX_RING_DESC_SIZE);
> +	memset(ring->skbuff, 0x0, (NUM_DESC * sizeof(struct sk_buff *)));
> +	ring->cur_idx = 0;
> +	ring->dirty_idx = 0;
> +	ring->priv_dirty_idx = 0;
> +	ring->duplicate_dirty_count = 0;
> +	ring->index = idx;
> +
> +	for (i = 0u; i < NUM_DESC; i++) {
> +		ring->mis.len[i] = 0;
> +		if ((NUM_DESC - 1u) == i) {
> +			desc = ring->desc + (sizeof(tx_desc) * i);
> +			desc->opts1 = cpu_to_le32(RING_END);
> +		}
> +	}
> +
> +	ring->ring_handler = tx_handler;
> +	if (idx < 4u) {
> +		ring->ivec = &tp->int_vector[idx];
> +		list_add_tail(&ring->ring_entry, &tp->int_vector[idx].ring_list);
> +	} else {
> +		ring->ivec = &tp->int_vector[0];
> +		list_add_tail(&ring->ring_entry, &tp->int_vector[0].ring_list);
> +	}
> +}
> +
> +static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
> +{
> +	u16 i = 0;
> +	struct rtase_ring *ring = &tp->rx_ring[idx];
> +
> +	memset(ring->desc, 0x0, RTASE_RX_RING_DESC_SIZE);
> +	memset(ring->skbuff, 0x0, (NUM_DESC * sizeof(struct sk_buff *)));
> +	ring->cur_idx = 0;
> +	ring->dirty_idx = 0;
> +	ring->index = idx;
> +
> +	for (i = 0u; i < NUM_DESC; i++)
> +		ring->mis.data_phy_addr[i] = 0;
> +
> +	ring->ring_handler = rx_handler;
> +	ring->ivec = &tp->int_vector[idx];
> +	list_add_tail(&ring->ring_entry, &tp->int_vector[idx].ring_list);
> +}
> +
> +s32 rtase_init_ring(const struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	u16 i = 0;
> +	s32 rc = 0;
> +
> +	for (i = 0u; i < tp->func_tx_queue_num; i++)
> +		rtase_tx_desc_init(tp, i);
> +
> +	for (i = 0u; i < tp->func_rx_queue_num; i++) {
> +		rtase_rx_desc_init(tp, i);
> +		if (rtase_rx_ring_fill(&tp->rx_ring[i], 0, NUM_DESC, 0) != NUM_DESC)
> +			goto err_out;
> +
> +		rtase_mark_as_last_descriptor(tp->rx_ring[i].desc
> +					      + (sizeof(rx_desc) * (NUM_DESC - 1u)));
> +	}
> +
> +	goto out;
> +
> +err_out:
> +	rtase_rx_clear(tp);
> +	rc = -ENOMEM;
> +out:
> +	return rc;
> +}
> +
> +#define RTK_OPTS1_DEBUG_VALUE 0x0BADBEEF
> +#define RTK_MAGIC_NUMBER      0x0BADBADBADBADBADuLL
> +static void rtase_unmap_tx_skb(struct pci_dev *pdev, u32 len, tx_desc *desc)
> +{
> +	dma_unmap_single(&pdev->dev, le64_to_cpu(desc->addr), len, DMA_TO_DEVICE);
> +	desc->opts1 = cpu_to_le32(RTK_OPTS1_DEBUG_VALUE);
> +	desc->opts2 = 0x00;
> +	desc->addr = RTK_MAGIC_NUMBER;
> +}
> +
> +static void rtase_tx_clear_range(struct rtase_ring *ring, u32 start, u32 n)
> +{
> +	u32 i;
> +	const struct rtase_private *tp = ring->ivec->tp;
> +	struct net_device *dev = tp->dev;
> +
> +	for (i = 0u; i < n; i++) {
> +		u32 entry = (start + i) % NUM_DESC;
> +		u32 len = ring->mis.len[entry];
> +
> +		if (len != 0u) {
> +			struct sk_buff *skb = ring->skbuff[entry];
> +
> +			rtase_unmap_tx_skb(tp->pdev, len, ring->desc + (sizeof(tx_desc) * entry));
> +			ring->mis.len[entry] = 0;
> +			if (skb) {
> +				dev->stats.tx_dropped++;
> +				dev_kfree_skb_any(skb);
> +				ring->skbuff[entry] = NULL;
> +			}
> +		}
> +	}
> +}
> +
> +void rtase_tx_clear(struct rtase_private *tp)
> +{
> +	u16 i;
> +	struct rtase_ring *ring;
> +
> +	for (i = 0u; i < tp->func_tx_queue_num; i++) {
> +		ring = &tp->tx_ring[i];
> +		rtase_tx_clear_range(ring, ring->dirty_idx, NUM_DESC);
> +		ring->cur_idx = 0;
> +		ring->dirty_idx = 0;
> +		ring->priv_dirty_idx = 0;
> +		ring->duplicate_dirty_count = 0;
> +	}
> +}
> +
> +static void rtase_wait_for_quiescence(const struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	struct rtase_int_vector *ivec;
> +	u32 i;
> +
> +	for (i = 0; i < tp->int_nums; i++) {
> +		ivec = &tp->int_vector[i];
> +		synchronize_irq(ivec->irq);
> +		/* Wait for any pending NAPI task to complete */
> +		napi_disable(&ivec->napi);
> +	}
> +
> +	rtase_irq_mask_and_ack(tp);
> +
> +	for (i = 0; i < tp->int_nums; i++) {
> +		ivec = &tp->int_vector[i];
> +		napi_enable(&ivec->napi);
> +	}
> +}
> +
> +static void dump_tx_desc(const struct rtase_ring *ring)
> +{
> +	const tx_desc *desc;
> +	u16 i = 0u;
> +
> +	pr_info("%s:%d", __func__, __LINE__);
> +	for (i = 0u; i < NUM_TX_DESC; i++) {
> +		desc = ring->desc + (sizeof(tx_desc) * i);
> +
> +		pr_info("opts1 = 0x%x", desc->opts1);
> +		pr_info("opts2 = 0x%x", desc->opts2);
> +		pr_info("addr  = 0x%llx", desc->addr);
> +	}
> +}
> +
> +static s32 rtase_debug_msg(const struct ifreq *ifr, const struct rtase_private *tp)
> +{
> +	const struct rtase_ring *ring;
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	s32 n = 0;
> +	s32 max_reg_size = RTASE_PCI_REGS_SIZE;
> +	u32 dword_rd;
> +	const struct rtase_counters *counters;
> +	dma_addr_t paddr;
> +	u32 cmd;
> +	u32 wait_cnt;
> +
> +	pr_info("Driver Info:");
> +	pr_info("int vector irq = %i", tp->int_vector[0].irq);
> +
> +	ring = &tp->tx_ring[0];
> +	pr_info("Tx descriptor info:");
> +	pr_info("Tx cur_idx = 0x%x", ring->cur_idx);
> +	pr_info("Tx dirty_idx = 0x%x", ring->dirty_idx);
> +	pr_info("Tx phy_addr = 0x%llx", ring->phy_addr);
> +	dump_tx_desc(ring);
> +
> +	ring = &tp->rx_ring[0];
> +	pr_info("Rx descriptor info:");
> +	pr_info("Rx cur_idx = 0x%x", ring->cur_idx);
> +	pr_info("Rx dirty_idx = 0x%x", ring->dirty_idx);
> +	pr_info("Rx phy_addr = 0x%llx", ring->phy_addr);
> +
> +	pr_info("Device Registers:");
> +	pr_info("Chip Command = 0x%02x", RTL_R8(CHIP_CMD));
> +	pr_info("IMR = %08x", RTL_R32(IMR0));
> +	pr_info("ISR = %08x", RTL_R32(ISR0));
> +	pr_info("Boot Ctrl Reg(0xE004) = %04x", RTL_R16(0x6004));
> +	pr_info("EPHY ISR(0xE014) = %04x", RTL_R16(0x6014));
> +	pr_info("EPHY IMR(0xE016) = %04x", RTL_R16(0x6016));
> +	pr_info("CLKSW SET REG(0xE018) = %04x", RTL_R16(0x6018));
> +
> +	pr_info("Dump PCI Registers:");
> +
> +	while (n < max_reg_size) {
> +		if ((n % DWORD_MOD) == 0)
> +			pr_info("\n0x%03x:\t", n);
> +
> +		pci_read_config_dword(tp->pdev, n, &dword_rd);
> +		pr_info("%08x ", dword_rd);
> +		n += 4;
> +	}
> +
> +	pr_info("Dump Tally Counter:");
> +	counters = tp->tally_vaddr;
> +	paddr = tp->tally_paddr;
> +	RTL_W32(DTCCR4, (u32)(paddr >> 32));
> +	cmd = (u32)(paddr & DMA_BIT_MASK(32));
> +	RTL_W32(DTCCR0, cmd);
> +	RTL_W32(DTCCR0, (u32)(cmd | COUNTER_DUMP));
> +	wait_cnt = 0;
> +	while ((RTL_R32(DTCCR0) & COUNTER_DUMP) != 0u) {
> +		usleep_range(10, 20);
> +
> +		wait_cnt++;
> +		if (wait_cnt > 20u)
> +			break;
> +	}
> +	pr_info("tx_packets\t%lld\n", le64_to_cpu(counters->tx_packets));
> +	pr_info("rx_packets\t%lld\n", le64_to_cpu(counters->rx_packets));
> +	pr_info("tx_errors\t%lld\n", le64_to_cpu(counters->tx_errors));
> +	pr_info("rx_missed\t%lld\n", le64_to_cpu(counters->rx_missed));
> +	pr_info("align_errors\t%lld\n", le64_to_cpu(counters->align_errors));
> +	pr_info("tx_one_collision\t%lld\n", le64_to_cpu(counters->tx_one_collision));
> +	pr_info("tx_multi_collision\t%lld\n", le64_to_cpu(counters->tx_multi_collision));
> +	pr_info("rx_unicast\t%lld\n", le64_to_cpu(counters->rx_unicast));
> +	pr_info("rx_broadcast\t%lld\n", le64_to_cpu(counters->rx_broadcast));
> +	pr_info("rx_multicast\t%lld\n", le64_to_cpu(counters->rx_multicast));
> +	pr_info("tx_aborted\t%lld\n", le64_to_cpu(counters->tx_aborted));
> +	pr_info("tx_underun\t%lld\n", le64_to_cpu(counters->tx_underun));
> +
> +	return 0;
> +}
> +
> +static void rtase_sw_reset(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	unsigned long flags;
> +
> +	netdev_info(dev, "%s is triggered.", __func__);
> +	spin_lock_irqsave(&tp->lock, flags);
> +	netif_stop_queue(dev);
> +	netif_carrier_off(dev);
> +	if ((tp->sw_flag & SWF_SRIOV_ENABLED) != 0u) {
> +		rtase_irq_mask_and_ack(tp);
> +		rtase_func_disable(tp);
> +	} else {
> +		rtase_hw_reset(dev);
> +	}
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +
> +	/* Let's wait a bit while any (async) irq lands on */
> +	rtase_wait_for_quiescence(dev);
> +	rtase_tx_clear(tp);
> +	rtase_rx_clear(tp);
> +
> +	if (rtase_init_ring(dev) != 0)
> +		netdev_alert(dev, "unable to init ring\n");
> +
> +	if ((tp->sw_flag & SWF_SRIOV_ENABLED) != 0u) {
> +		rtase_func_enable(tp);
> +		rtase_enable_hw_interrupt(tp);
> +	} else {
> +		rtase_hw_config(dev);
> +		/* always link, so start to transmit & receive */
> +		rtase_hw_start(dev);
> +	}
> +	netif_carrier_on(dev);
> +	netif_wake_queue(dev);
> +
> +	/* Set timeout_state */
> +	tp->timeout_state = TIMEOUT_ERROR;
> +}
> +
> +static void rtase_tx_timeout(struct net_device *dev, unsigned int txqueue)
> +{
> +	(void)txqueue;
> +	rtase_sw_reset(dev);
> +}
> +
> +static s32 rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *skb, u32 opts1, u32 opts2)
> +{
> +	const struct rtase_private *tp = ring->ivec->tp;
> +	const struct skb_shared_info *info = skb_shinfo(skb);
> +	u32 cur_frag, entry;
> +	tx_desc *txd = NULL;
> +	const u8 nr_frags = info->nr_frags;
> +	u64 pkt_len_cnt = 0;
> +	s32 rc = 0;
> +
> +	entry = ring->cur_idx;
> +	for (cur_frag = 0; cur_frag < nr_frags; cur_frag++) {
> +		const skb_frag_t *frag = &info->frags[cur_frag];
> +		dma_addr_t mapping;
> +		u32 status, len;
> +		void *addr;
> +
> +		entry = (entry + 1u) % NUM_DESC;
> +
> +		txd = ring->desc + (sizeof(tx_desc) * entry);
> +		len = skb_frag_size(frag);
> +		addr = skb_frag_address(frag);
> +		mapping = dma_map_single(&tp->pdev->dev, addr, len, DMA_TO_DEVICE);
> +
> +		if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
> +			if (unlikely(net_ratelimit()))
> +				netif_err(tp, drv, tp->dev, "Failed to map TX fragments DMA!\n");
> +
> +			goto err_out;
> +		}
> +
> +		if (((entry + 1u) % NUM_DESC) == 0u)
> +			status = (opts1 | len | (u32)RING_END);
> +		else
> +			status = opts1 | len;
> +
> +		if (cur_frag == ((u32)nr_frags - 1u)) {
> +			ring->skbuff[entry] = skb;
> +			status |= (u32)TX_LAST_FRAG;
> +		}
> +
> +		txd->addr = cpu_to_le64(mapping);
> +		ring->mis.len[entry] = len;
> +		txd->opts2 = cpu_to_le32(opts2);
> +		/* make sure the operating fields have been updated */
> +		wmb();
> +		txd->opts1 = cpu_to_le32(status);
> +		pkt_len_cnt += len;
> +	}
> +
> +	rc = (s32)cur_frag;
> +	goto out;
> +
> +err_out:
> +	rtase_tx_clear_range(ring, ring->cur_idx + 1u, cur_frag);
> +	rc = -EIO;
> +out:
> +	return rc;
> +}
> +
> +static inline __be16 get_protocol(const struct sk_buff *skb)
> +{
> +	__be16 protocol;
> +
> +	if (skb->protocol == htons(ETH_P_8021Q))
> +		protocol = vlan_eth_hdr(skb)->h_vlan_encapsulated_proto;
> +	else
> +		protocol = skb->protocol;
> +
> +	return protocol;
> +}
> +
> +static inline u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
> +{
> +	u32 csum_cmd = 0;
> +	u8 sw_calc_csum = FALSE;
> +
> +	if (skb->ip_summed == (u8)CHECKSUM_PARTIAL) {
> +		u8 ip_protocol = IPPROTO_RAW;
> +
> +		switch (get_protocol(skb)) {
> +		case htons(ETH_P_IP):
> +			if ((dev->features & NETIF_F_IP_CSUM) != 0u) {
> +				ip_protocol = ip_hdr(skb)->protocol;
> +				csum_cmd = (u32)TX_IPCS_C;
> +			}
> +			break;
> +		case htons(ETH_P_IPV6):
> +			if ((dev->features & NETIF_F_IPV6_CSUM) != 0u) {
> +				u32 transport_offset = (u32)skb_transport_offset(skb);
> +
> +				if ((transport_offset > 0u) && (transport_offset <= TCPHO_MAX)) {
> +					ip_protocol = ipv6_hdr(skb)->nexthdr;
> +					csum_cmd = (u32)TX_IPV6F_C;
> +					csum_cmd |= transport_offset << TCPHO_SHIFT;
> +				}
> +			}
> +			break;
> +		default:
> +			if (unlikely(net_ratelimit()))
> +				dprintk("checksum_partial proto=%x!\n", skb->protocol);
> +
> +			break;
> +		}
> +
> +		if (ip_protocol == (u8)IPPROTO_TCP)
> +			csum_cmd |= (u32)TX_TCPCS_C;
> +		else if (ip_protocol == (u8)IPPROTO_UDP)
> +			csum_cmd |= (u32)TX_UDPCS_C;
> +		else
> +			netdev_info(dev, "%s command error.\n", __func__);
> +
> +		if (csum_cmd == 0u) {
> +			sw_calc_csum = TRUE;
> +			WARN_ON(1); /* we need a WARN() */
> +		}
> +	}
> +
> +	if (sw_calc_csum != 0u) {
> +		skb_checksum_help(skb);
> +		csum_cmd = 0;
> +	}
> +
> +	return csum_cmd;
> +}
> +
> +/* rtase_csum_workaround()
> + * The hw limites the value the transport offset. When the offset is out of the
> + * range, calculate the checksum by sw.
> + */
> +static void rtase_csum_workaround(const struct rtase_private *tp, struct sk_buff *skb)
> +{
> +	struct net_device_stats *stats;
> +
> +	if (skb_shinfo(skb)->gso_size != 0u) {
> +		netdev_features_t features = tp->dev->features;
> +		struct sk_buff *segs = NULL;
> +		struct sk_buff *nskb;
> +
> +		features &= ~(NETIF_F_SG | NETIF_F_IPV6_CSUM | NETIF_F_TSO6);
> +		segs = skb_gso_segment(skb, features);
> +		if (IS_ERR(segs) || (!segs))
> +			goto drop;
> +
> +		do {
> +			nskb = segs;
> +			segs = segs->next;
> +			nskb->next = NULL;
> +			rtase_start_xmit(nskb, tp->dev);
> +		} while (segs);
> +
> +		dev_consume_skb_any(skb);
> +		goto out;
> +	} else if (skb->ip_summed == (u8)CHECKSUM_PARTIAL) {
> +		if (skb_checksum_help(skb) < 0)
> +			goto drop;
> +
> +		rtase_start_xmit(skb, tp->dev);
> +		goto out;
> +	} else {
> +		goto drop;
> +	}
> +
> +drop:
> +	stats = &tp->dev->stats;
> +	stats->tx_dropped++;
> +	dev_kfree_skb_any(skb);
> +
> +out:
> +	return;
> +}
> +
> +/* msdn_giant_send_check()
> + * According to the document of microsoft, the TCP Pseudo Header excludes the
> + * packet length for IPv6 TCP large packets.
> + */
> +static s32 msdn_giant_send_check(struct sk_buff *skb)
> +{
> +	const struct ipv6hdr *ipv6h;
> +	struct tcphdr *th;
> +	s32 ret;
> +
> +	ret = skb_cow_head(skb, 0);
> +
> +	if (ret == 0) {
> +		ipv6h = ipv6_hdr(skb);
> +		th = tcp_hdr(skb);
> +
> +		th->check = 0;
> +		th->check = ~tcp_v6_check(0, &ipv6h->saddr, &ipv6h->daddr, 0);
> +	}
> +
> +	return ret;
> +}
> +
> +static netdev_tx_t rtase_start_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	struct rtase_ring *ring;
> +	u32 q_idx;
> +	u32 entry;
> +	tx_desc *txd;
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	dma_addr_t mapping;
> +	u32 len;
> +	u32 opts1;
> +	u32 opts2;
> +	netdev_tx_t ret = NETDEV_TX_OK;
> +	unsigned long flags;
> +	u64 large_send_en;
> +	s32 frags;
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +
> +	/* multiqueues */
> +	q_idx = skb_get_queue_mapping(skb);
> +	ring = &tp->tx_ring[q_idx];
> +
> +	if (unlikely(TX_BUFFS_AVAIL(ring) < skb_shinfo(skb)->nr_frags)) {
> +		if (netif_msg_drv(tp) != 0u)
> +			netdev_err(dev, "%s: BUG! Tx Ring full when queue awake!\n", dev->name);
> +
> +		goto err_stop;
> +	}
> +
> +	entry = ring->cur_idx % NUM_DESC;
> +	txd = ring->desc + (sizeof(tx_desc) * entry);
> +
> +	if (unlikely(le32_to_cpu(txd->opts1) & DESC_OWN))
> +		goto err_stop;
> +
> +	opts1 = (u32)DESC_OWN;
> +	opts2 = rtase_tx_vlan_tag(tp, skb);
> +	large_send_en = 0;
> +
> +	if ((dev->features & (NETIF_F_TSO | NETIF_F_TSO6)) != 0u) {
> +		u32 mss = skb_shinfo(skb)->gso_size;
> +
> +		/* TCP Segmentation Offload (or TCP Large Send) */
> +		if (mss != 0u) {
> +			u32 transport_offset = (u32)skb_transport_offset(skb);
> +
> +			assert((transport_offset % 2) == 0);
> +			switch (get_protocol(skb)) {
> +			case htons(ETH_P_IP):
> +				if (transport_offset <= 128u) {
> +					opts1 |= (u32)GIANT_SEND_V4;
> +					opts1 |= transport_offset << GTTCPHO_SHIFT;
> +					opts2 |= min(mss, MSS_MAX) << 18;
> +					large_send_en = 1;
> +				}
> +				break;
> +			case htons(ETH_P_IPV6):
> +				if (msdn_giant_send_check(skb) != 0) {
> +					spin_unlock_irqrestore(&tp->lock, flags);
> +					rtase_csum_workaround(tp, skb);
> +					goto out;
> +				}
> +
> +				if (transport_offset <= 128u) {
> +					opts1 |= (u32)GIANT_SEND_V6;
> +					opts1 |= transport_offset << GTTCPHO_SHIFT;
> +					opts2 |= min(mss, MSS_MAX) << 18;
> +					large_send_en = 1;
> +				}
> +				break;
> +			default:
> +				if (unlikely(net_ratelimit()))
> +					dprintk("tso proto=%x!\n", skb->protocol);
> +
> +				break;
> +			}
> +
> +			if (large_send_en == 0u)
> +				goto err_dma_0;
> +		}
> +	}
> +
> +	if (large_send_en == 0u) {
> +		if (skb->ip_summed == (u8)CHECKSUM_PARTIAL)
> +			opts2 |= rtase_tx_csum(skb, dev);
> +	}
> +
> +	frags = rtase_xmit_frags(ring, skb, opts1, opts2);
> +	if (unlikely(frags < 0))
> +		goto err_dma_0;
> +
> +	if (frags != 0) {
> +		len = skb_headlen(skb);
> +		opts1 |= (u32)TX_FIRST_FRAG;
> +	} else {
> +		len = skb->len;
> +		ring->skbuff[entry] = skb;
> +		opts1 |= (u32)(TX_FIRST_FRAG | TX_LAST_FRAG);
> +	}
> +
> +	if ((((entry + 1u) % NUM_DESC) == 0u))
> +		opts1 |= (len | (u32)RING_END);
> +	else
> +		opts1 |= len;
> +
> +	mapping = dma_map_single(&tp->pdev->dev, skb->data, len, DMA_TO_DEVICE);
> +
> +	if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
> +		if (unlikely(net_ratelimit()))
> +			netif_err(tp, drv, dev, "Failed to map TX DMA!\n");
> +
> +		goto err_dma_1;
> +	}
> +
> +	ring->mis.len[entry] = len;
> +	txd->addr = cpu_to_le64(mapping);
> +	txd->opts2 = cpu_to_le32(opts2);
> +	txd->opts1 = cpu_to_le32(opts1 & ~DESC_OWN);
> +	/* make sure the operating fields have been updated */
> +	wmb();
> +	txd->opts1 = cpu_to_le32(opts1);
> +	skb_tx_timestamp(skb);
> +
> +	/* tx needs to see descriptor changes before updated cur_idx */
> +	smp_wmb();
> +	ring->cur_idx += (u32)frags + 1u;
> +
> +	/* make sure discriptor has been updated before hardware polling */
> +	wmb();
> +	/* set polling bit */
> +	RTL_W8(TPPOLL, (u8)(BIT(ring->index)));
> +
> +	if (TX_BUFFS_AVAIL(ring) < MAX_SKB_FRAGS) {
> +		netif_stop_queue(dev);
> +		/* make sure cur_idx and dirty_idx have been updated */
> +		smp_rmb();
> +		if (TX_BUFFS_AVAIL(ring) >= MAX_SKB_FRAGS)
> +			netif_wake_queue(dev);
> +	}
> +
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +	goto out;
> +
> +err_dma_1:
> +	ring->skbuff[entry] = NULL;
> +	rtase_tx_clear_range(ring, ring->cur_idx + 1u, (u32)frags);
> +
> +err_dma_0:
> +	dev->stats.tx_dropped++;
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +	dev_kfree_skb_any(skb);
> +	ret = NETDEV_TX_OK;
> +	goto out;
> +
> +err_stop:
> +	netif_stop_queue(dev);
> +	ret = NETDEV_TX_BUSY;
> +	dev->stats.tx_dropped++;
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +
> +out:
> +	return ret;
> +}
> +
> +static s32 tx_handler(struct rtase_ring *ring, s32 budget)
> +{
> +	const struct rtase_private *tp = ring->ivec->tp;
> +	struct net_device *dev = tp->dev;
> +	u32 dirty_tx;
> +	u32 tx_left;
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	s32 workdone = 0;
> +
> +	dirty_tx = ring->dirty_idx;
> +	/* make sure the index has been updated */
> +	smp_rmb();
> +	tx_left = ring->cur_idx - dirty_tx;
> +
> +	while (tx_left > 0u) {
> +		u32 entry = dirty_tx % NUM_DESC;
> +		tx_desc *desc = ring->desc + (sizeof(tx_desc) * entry);
> +		u32 len = ring->mis.len[entry];
> +		u32 status;
> +
> +		/* make sure discriptor has been updated */
> +		rmb();
> +		status = le32_to_cpu(desc->opts1);
> +
> +		if ((status & DESC_OWN) != 0u) {
> +			tx_left = 0;
> +			continue;
> +		}
> +
> +		dev->stats.tx_bytes += len;
> +		dev->stats.tx_packets++;
> +		rtase_unmap_tx_skb(tp->pdev, len, desc);
> +		ring->mis.len[entry] = 0;
> +		if (ring->skbuff[entry]) {
> +			dev_consume_skb_any(ring->skbuff[entry]);
> +			ring->skbuff[entry] = NULL;
> +		}
> +		dirty_tx++;
> +		tx_left--;
> +		workdone++;
> +
> +		if (workdone == budget) {
> +			tx_left = 0;
> +			continue;
> +		}
> +	}
> +
> +	if (ring->dirty_idx != dirty_tx) {
> +		ring->dirty_idx = dirty_tx;
> +		/* make sure the index has been updated */
> +		smp_wmb();
> +
> +		if (netif_queue_stopped(dev) && (TX_BUFFS_AVAIL(ring) >= MAX_SKB_FRAGS))
> +			netif_wake_queue(dev);
> +
> +		/* make sure the index has been updated */
> +		smp_rmb();
> +		if (ring->cur_idx != dirty_tx)
> +			RTL_W8(TPPOLL, (u8)(BIT(ring->index)));
> +	}
> +
> +	return workdone;
> +}
> +
> +static inline s32 rtase_fragmented_frame(u32 status)
> +{
> +	s32 ret;
> +
> +	if ((status & (RX_FIRST_FRAG | RX_LAST_FRAG)) != (RX_FIRST_FRAG | RX_LAST_FRAG))
> +		ret = 1;
> +	else
> +		ret = 0;
> +
> +	return ret;
> +}
> +
> +static inline void rtase_rx_csum(const struct rtase_private *tp, struct sk_buff *skb,
> +				 const rx_desc *desc)
> +{
> +	u32 opts2 = le32_to_cpu(desc->desc_status.opts2);
> +
> +	(void)tp;
> +
> +	/* rx csum offload */
> +	if ((((opts2 & RX_V4F) != 0u) && ((opts2 & RX_IPF) == 0u)) || ((opts2 & RX_V6F) != 0u)) {
> +		if ((((opts2 & RX_TCPT) != 0u) && ((opts2 & RX_TCPF) == 0u))
> +		    || (((opts2 & RX_UDPT) != 0u) && ((opts2 & RX_UDPF) == 0u))) {
> +			skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		} else {
> +			skb->ip_summed = CHECKSUM_NONE;
> +		}
> +	} else {
> +		skb->ip_summed = CHECKSUM_NONE;
> +	}
> +}
> +
> +static inline s32 rtase_try_rx_copy(const struct rtase_ring *ring, struct sk_buff **p_sk_buff,
> +				    u32 pkt_size, rx_desc *desc, u32 rx_buf_sz)
> +{
> +	struct rtase_int_vector *ivec = ring->ivec;
> +	s32 ret = -1;
> +
> +	if ((s32)pkt_size < rx_copybreak) {
> +		struct sk_buff *skb;
> +
> +		skb = RTL_ALLOC_SKB_INTR(ivec->napi, ((u32)pkt_size + (u32)RTK_RX_ALIGN));
> +		if (skb) {
> +			const u8 *p_sk_buff_data;
> +
> +			p_sk_buff_data = p_sk_buff[0]->data;
> +			skb_reserve(skb, (s32)RTK_RX_ALIGN);
> +			prefetch(p_sk_buff_data - RTK_RX_ALIGN);
> +			memcpy(skb->data, p_sk_buff_data, (u64)pkt_size);
> +			*p_sk_buff = skb;
> +			rtase_mark_to_asic(desc, rx_buf_sz);
> +			ret = 0;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static inline void rtase_rx_skb(const struct rtase_ring *ring, struct sk_buff *skb)
> +{
> +	struct rtase_int_vector *ivec = ring->ivec;
> +
> +	napi_gro_receive(&ivec->napi, skb);
> +}
> +
> +static s32 rx_handler(struct rtase_ring *ring, s32 budget)
> +{
> +	const struct rtase_private *tp = ring->ivec->tp;
> +	struct net_device *dev = tp->dev;
> +	u32 cur_rx;
> +	u32 delta;
> +	u32 entry;
> +	s32 workdone = 0;
> +	rx_desc *desc;
> +	u32 status;
> +	struct sk_buff *skb;
> +	u32 pkt_size;
> +
> +	if (!ring->desc)
> +		goto rx_out;
> +
> +	cur_rx = ring->cur_idx;
> +	entry = cur_rx % (u32)NUM_DESC;
> +	desc = ring->desc + (sizeof(rx_desc) * entry);
> +
> +	do {
> +		/* make sure discriptor has been updated */
> +		rmb();
> +		status = le32_to_cpu(desc->desc_status.opts1);
> +
> +		if ((status & DESC_OWN) != 0u)
> +			break;
> +
> +		if (unlikely(status & RX_RES)) {
> +			if (netif_msg_rx_err(tp) != 0u)
> +				netdev_info(dev, "%s: Rx ERROR. status = %08x\n", dev->name,
> +					    status);
> +
> +			dev->stats.rx_errors++;
> +
> +			if ((status & (RX_RWT | RX_RUNT)) != 0u)
> +				dev->stats.rx_length_errors++;
> +
> +			if ((status & RX_CRC) != 0u)
> +				dev->stats.rx_crc_errors++;
> +
> +			if ((dev->features & NETIF_F_RXALL) != 0u)
> +				goto process_pkt;
> +
> +			rtase_mark_to_asic(desc, tp->rx_buf_sz);
> +			goto out;
> +		}
> +
> +process_pkt:
> +		if (likely((dev->features & NETIF_F_RXFCS) == 0u))
> +			pkt_size = (status & 0x00003FFFu) - 4u;
> +		else
> +			pkt_size = (status & 0x00003FFFu);
> +
> +		/* The driver does not support incoming fragmented
> +		 * frames. They are seen as a symptom of over-mtu
> +		 * sized frames.
> +		 */
> +		if (unlikely(rtase_fragmented_frame(status))) {
> +			dev->stats.rx_dropped++;
> +			dev->stats.rx_length_errors++;
> +			rtase_mark_to_asic(desc, tp->rx_buf_sz);
> +			continue;
> +		}
> +
> +		skb = ring->skbuff[entry];
> +		dma_sync_single_for_cpu(&tp->pdev->dev, ring->mis.data_phy_addr[entry],
> +					tp->rx_buf_sz, DMA_FROM_DEVICE);
> +
> +		if (rtase_try_rx_copy(ring, &skb, pkt_size, desc, tp->rx_buf_sz) != 0) {
> +			dma_unmap_single(&tp->pdev->dev, ring->mis.data_phy_addr[entry],
> +					 tp->rx_buf_sz, DMA_FROM_DEVICE);
> +			ring->skbuff[entry] = NULL;
> +		} else {
> +			dma_sync_single_for_device(&tp->pdev->dev, ring->mis.data_phy_addr[entry],
> +						   tp->rx_buf_sz, DMA_FROM_DEVICE);
> +		}
> +
> +		if ((dev->features & NETIF_F_RXCSUM) != 0u)
> +			rtase_rx_csum(tp, skb, desc);
> +
> +		skb->dev = dev;
> +		skb_put(skb, pkt_size);
> +		skb->protocol = eth_type_trans(skb, dev);
> +
> +		if (skb->pkt_type == (u8)PACKET_MULTICAST)
> +			dev->stats.multicast++;
> +
> +		if (rtase_rx_vlan_skb(desc, skb) < 0)
> +			rtase_rx_skb(ring, skb);
> +
> +		dev->stats.rx_bytes += (u64)pkt_size;
> +		dev->stats.rx_packets++;
> +out:
> +		workdone++;
> +		cur_rx++;
> +		entry = cur_rx % NUM_DESC;
> +		desc = ring->desc + (sizeof(rx_desc) * entry);
> +		prefetch(desc);
> +
> +	} while (workdone != budget);
> +
> +	ring->cur_idx = cur_rx;
> +	delta = rtase_rx_ring_fill(ring, ring->dirty_idx, ring->cur_idx, 1);
> +
> +	if ((delta == 0u) && (workdone != 0) && netif_msg_intr(tp))
> +		netdev_info(dev, "%s: no Rx buffer allocated\n", dev->name);
> +
> +	ring->dirty_idx += delta;
> +
> +	/* FIXME: until there is periodic timer to try and refill the ring,
> +	 * a temporary shortage may definitely kill the Rx process.
> +	 * - disable the asic to try and avoid an overflow and kick it again
> +	 *   after refill ?
> +	 * - how do others driver handle this condition (Uh oh...).
> +	 */
> +	if (((ring->dirty_idx + NUM_DESC) == ring->cur_idx) && netif_msg_intr(tp))
> +		netdev_emerg(dev, "%s: Rx buffers exhausted\n", dev->name);
> +
> +rx_out:
> +	return workdone;
> +}
> +
> +/*  The interrupt handler does RXQ0 and TXQ0, TXQ4~7 interrutp status.
> + */
> +static irqreturn_t rtase_interrupt(int irq, void *dev_instance)
> +{
> +	struct net_device *dev = (struct net_device *)dev_instance;
> +	struct rtase_private *tp = netdev_priv(dev);
> +	struct rtase_int_vector *ivec = &tp->int_vector[0];
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 status;
> +	s32 handled = 0;
> +
> +	(void)irq;
> +
> +	do {
> +		status = RTL_R32(ivec->isr_addr);
> +
> +		if ((status & MBX) != 0u)
> +			queue_work(work_queue, &tp->msg_work);
> +
> +		if ((status & TIMEOUT0) != 0u)
> +			queue_work(work_queue, &tp->watchdog_work);
> +
> +#ifdef RTLDBG
> +		if (status & RDU)
> +			netdev_info(dev, "PF receive RDU !!!!!!!!!");
> +
> +#endif
> +
> +		handled = 1;
> +		RTL_W32(ivec->imr_addr, 0x0);
> +		RTL_W32(ivec->isr_addr, (u32)(status & ~FOVW));
> +
> +		status &= (u32)(~MBX);
> +		if ((status & ivec->imr) != 0u) {
> +			if (likely(RTL_NETIF_RX_SCHEDULE_PREP(dev, &ivec->napi)))
> +				__RTL_NETIF_RX_SCHEDULE(dev, &ivec->napi);
> +			else if (netif_msg_intr(tp) != 0u)
> +				netdev_info(dev, "%s: interrupt %08x in poll\n", dev->name, status);
> +
> +		} else {
> +			RTL_W32(ivec->imr_addr, (u32)(ivec->imr & ~MBX));
> +		}
> +
> +	} while (false);
> +
> +	return IRQ_RETVAL(handled);
> +}
> +
> +/*  The interrupt handler does RXQ1&TXQ1 or RXQ2&TXQ2 or RXQ3&TXQ3 interrutp
> + *  status according to interrupt vector.
> + */
> +static irqreturn_t rtase_q_interrupt(int irq, void *dev_instance)
> +{
> +	struct rtase_int_vector *ivec = (struct rtase_int_vector *)dev_instance;
> +	const struct rtase_private *tp = ivec->tp;
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 status;
> +	int handled = 0;
> +
> +	(void)irq;
> +
> +	do {
> +		status = RTL_R16(ivec->isr_addr);
> +
> +		handled = 1;
> +		RTL_W16(ivec->imr_addr, 0x0);
> +		RTL_W16(ivec->isr_addr, status);
> +
> +		/* don't support without NAPI */
> +		if (likely(RTL_NETIF_RX_SCHEDULE_PREP(dev, &ivec->napi)))
> +			__RTL_NETIF_RX_SCHEDULE(dev, &ivec->napi);
> +		else
> +			netdev_info(tp->dev, "%s: interrupt %04x in poll\n", ivec->name, status);
> +
> +	} while (false);
> +
> +	return IRQ_RETVAL(handled);
> +}
> +
> +static int rtase_poll(struct napi_struct *napi, int budget)
> +{
> +	const struct rtase_int_vector *ivec = container_of(napi, struct rtase_int_vector, napi);
> +	const struct rtase_private *tp = ivec->tp;
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	struct rtase_ring *ring;
> +	int total_workdone = 0;
> +	s32 workdone = 0;
> +	s32 clean_flag = 1;
> +
> +	/* clang-format off */
> +	list_for_each_entry(ring, &ivec->ring_list, ring_entry) {
> +		workdone = ring->ring_handler(ring, budget);
> +		total_workdone += workdone;
> +		if (workdone == budget)
> +			clean_flag = 0;
> +	}
> +	/* clang-format on */
> +
> +	if (clean_flag != 0) {
> +		total_workdone = min(total_workdone, budget - 1);
> +		if (likely(napi_complete_done(napi, total_workdone))) {
> +			if (ivec->index == 0u)
> +				RTL_W32(ivec->imr_addr, ivec->imr);
> +			else
> +				RTL_W16(ivec->imr_addr, (u16)ivec->imr);
> +		}
> +	} else {
> +		/* still need to poll */
> +		total_workdone = budget;
> +	}
> +
> +	return total_workdone;
> +}
> +
> +static void rtase_down(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	unsigned long flags;
> +	u32 i = 0u;
> +
> +	netif_stop_queue(dev);
> +
> +	/* Give a racing hard_start_xmit a few cycles to complete. */
> +	synchronize_rcu();
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +
> +	netif_carrier_off(dev);
> +
> +	if ((tp->sw_flag & SWF_SRIOV_ENABLED) != 0u) {
> +		rtase_irq_mask_and_ack(tp);
> +		rtase_func_disable(tp);
> +	} else {
> +		rtase_hw_reset(dev);
> +	}
> +
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +
> +	for (i = 0u; i < tp->int_nums; i++)
> +		synchronize_irq(tp->int_vector[i].irq);
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +
> +	rtase_tx_clear(tp);
> +
> +	rtase_rx_clear(tp);
> +
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +}
> +
> +static int rtase_close(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	const struct pci_dev *pdev = tp->pdev;
> +	u32 i = 0;
> +
> +	rtase_down(dev);
> +
> +	if ((tp->sw_flag & SWF_MSIX_ENABLED) != 0u) {
> +		free_irq(tp->int_vector[i].irq, dev);
> +		for (i = 1; i < tp->int_nums; i++)
> +			free_irq(tp->int_vector[i].irq, &tp->int_vector[i]);
> +
> +	} else {
> +		free_irq(pdev->irq, dev);
> +	}
> +
> +	rtase_free_desc(tp);
> +
> +	return 0;
> +}
> +
> +static void rtase_shutdown(struct pci_dev *pdev)
> +{
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	const struct rtase_private *tp = netdev_priv(dev);
> +
> +	if (netif_running(dev)) {
> +		if (rtase_close(dev) != 0)
> +			netdev_alert(dev, "unable to close\n");
> +	}
> +	rtase_reset_interrupt(pdev, tp);
> +}
> +
> +static void rtase_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +	const struct rtase_counters *counters = tp->tally_vaddr;
> +	dma_addr_t paddr = tp->tally_paddr;
> +
> +	if (counters) {
> +		netdev_stats_to_stats64(stats, &dev->stats);
> +		dev_fetch_sw_netstats(stats, dev->tstats);
> +
> +		/* Fetch additional counter values missing in stats collected by driver from tally
> +		 * counter
> +		 */
> +		rtase_dump_tally_counter(tp, paddr);
> +
> +		stats->tx_errors = le64_to_cpu(counters->tx_errors);
> +		stats->collisions = le64_to_cpu(counters->tx_multi_collision);
> +		stats->tx_aborted_errors = le64_to_cpu(counters->tx_aborted);
> +		stats->rx_missed_errors = le64_to_cpu(counters->rx_missed);
> +	}
> +}
> +
> +static void rtase_vlan_filter(const struct rtase_private *tp, u8 enabled)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 tmp = 0;
> +
> +	if (enabled == 1u) {
> +		/* PFCR */
> +		tmp = RTL_R16(FCR);
> +		if ((tmp & FCR_VLAN_FTR_EN) == 0u)
> +			RTL_W16(FCR, (u16)(tmp | FCR_VLAN_FTR_EN));
> +
> +		/* PCPR */
> +		tmp = RTL_R16(PCPR);
> +		if ((tmp & PCPR_VLAN_FTR_EN) == 0u)
> +			RTL_W16(PCPR, (u16)(tmp | PCPR_VLAN_FTR_EN));
> +
> +	} else {
> +		/* PFCR */
> +		tmp = RTL_R16(FCR);
> +		if ((tmp & FCR_VLAN_FTR_EN) != 0u)
> +			RTL_W16(FCR, (u16)(tmp & ~FCR_VLAN_FTR_EN));
> +
> +		/* PCPR */
> +		tmp = RTL_R16(PCPR);
> +		if ((tmp & PCPR_VLAN_FTR_EN) == 0u)
> +			RTL_W16(PCPR, (u16)(tmp & ~PCPR_VLAN_FTR_EN));
> +	}
> +}
> +
> +static int rtase_vlan_rx_add_vid(struct net_device *dev, __be16 protocol, u16 vid)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 i = 0u;
> +	u16 tmp_mem = 0;
> +	int ret = 0;
> +
> +	if (be16_to_cpu(protocol) != (u16)ETH_P_8021Q) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* vlan filter table */
> +	for (i = 0u; i < VLAN_FILTER_ENTRY_NUM; i++) {
> +		if ((tp->vlan_filter_ctrl & BIT(i)) == 0u) {
> +			tp->vlan_filter_ctrl |= (u32)BIT(i);
> +			tp->vlan_filter_vid[i] = vid;
> +			RTL_W32((VLAN_ENTRY_0 + (i * 4u)), (vid | VLAN_ENTRY_CAREBIT));
> +
> +			tmp_mem = RTL_R16((VLAN_ENTRY_MEM_0 + ((i / 2u) * 2u)));
> +			tmp_mem |= ((u16)0x1u << ((i % 2u) * 8u));
> +			RTL_W16((VLAN_ENTRY_MEM_0 + ((i / 2u) * 2u)), tmp_mem);
> +			break;
> +		}
> +	}
> +
> +	if (i == VLAN_FILTER_ENTRY_NUM) {
> +		ret = -ENOMEM;
> +	} else {
> +		/* check vlan filter enabled */
> +		rtase_vlan_filter(tp, 1u);
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +static int rtase_vlan_rx_kill_vid(struct net_device *dev, __be16 protocol, u16 vid)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 i = 0u;
> +	u16 tmp_mem = 0;
> +	s32 rc = 0;
> +
> +	if (be16_to_cpu(protocol) != (u16)ETH_P_8021Q) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* vlan filter table */
> +	for (i = 0u; i < VLAN_FILTER_ENTRY_NUM; i++) {
> +		if (tp->vlan_filter_vid[i] == vid) {
> +			tp->vlan_filter_ctrl &= (u32)(~BIT(i));
> +			tp->vlan_filter_vid[i] = 0;
> +			RTL_W32((VLAN_ENTRY_0 + (i * 4u)), 0);
> +
> +			tmp_mem = RTL_R16((VLAN_ENTRY_MEM_0 + ((i / 2u) * 2u)));
> +			tmp_mem &= (~((u16)0x1u << ((i % 2u) * 8u)));
> +			RTL_W16((VLAN_ENTRY_MEM_0 + ((i / 2u) * 2u)), tmp_mem);
> +			break;
> +		}
> +	}
> +
> +	/* check vlan filter enabled */
> +	if (tp->vlan_filter_ctrl == 0u) {
> +		/* disable vlan filter */
> +		rtase_vlan_filter(tp, 0u);
> +	}
> +
> +out:
> +	return rc;
> +}
> +
> +static void rtase_set_hw_cbs(const struct rtase_private *tp, u32 queue)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 i = 0;
> +	u32 idle = (u32)tp->tx_qos[queue].idleslope * RTASE_1T_CLOCK;
> +	u32 regV = 0;
> +
> +	regV = idle / RTASE_1T_POWER;
> +	regV <<= RTASE_IDLESLOPE_INT_SHIFT;
> +	idle %= RTASE_1T_POWER;
> +	for (i = 0; i < RTASE_IDLESLOPE_INT_SHIFT; i++) {
> +		idle *= 2u;
> +		if ((idle / RTASE_1T_POWER) == 1u)
> +			regV |= ((u32)0x1u << (RTASE_IDLESLOPE_INT_SHIFT - i - 1u));
> +
> +		idle %= RTASE_1T_POWER;
> +	}
> +	RTL_W32((TXQCRDT_0 + (queue * 4u)), regV);
> +}
> +
> +static int rtase_setup_tc_cbs(struct rtase_private *tp, const struct tc_cbs_qopt_offload *qopt)
> +{
> +	u32 queue = (u32)qopt->queue;
> +
> +	/* record settings */
> +	tp->tx_qos[queue].hicredit = qopt->hicredit;
> +	tp->tx_qos[queue].locredit = qopt->locredit;
> +	tp->tx_qos[queue].idleslope = qopt->idleslope;
> +	tp->tx_qos[queue].sendslope = qopt->sendslope;
> +
> +	/* set hardware cbs */
> +	rtase_set_hw_cbs(tp, queue);
> +
> +	return 0;
> +}
> +
> +static int rtase_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	int ret = 0;
> +
> +	switch (type) {
> +	case TC_SETUP_QDISC_MQPRIO:
> +		break;
> +	case TC_SETUP_BLOCK:
> +		break;
> +	case TC_SETUP_QDISC_CBS:
> +		ret = rtase_setup_tc_cbs(tp, type_data);
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +#ifdef CONFIG_PM
> +
> +static int rtase_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	struct rtase_private *tp = netdev_priv(dev);
> +	unsigned long flags;
> +
> +	(void)state;
> +
> +	if (!netif_running(dev))
> +		goto out;
> +
> +	netif_stop_queue(dev);
> +
> +	netif_carrier_off(dev);
> +
> +	netif_device_detach(dev);
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +
> +	if ((tp->sw_flag & SWF_SRIOV_ENABLED) != 0u) {
> +		rtase_irq_mask_and_ack(tp);
> +		rtase_func_disable(tp);
> +	} else {
> +		rtase_hw_reset(dev);
> +	}
> +
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +
> +out:
> +	pci_save_state(pdev);
> +
> +	return 0;
> +}
> +
> +static int rtase_resume(struct pci_dev *pdev)
> +{
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	struct rtase_private *tp = netdev_priv(dev);
> +
> +	pci_set_power_state(pdev, PCI_D0);
> +	pci_restore_state(pdev);
> +	pci_enable_wake(pdev, PCI_D0, 0);
> +
> +	/* restore last modified mac address */
> +	rtase_rar_set(tp, dev->dev_addr);
> +
> +	if (!netif_running(dev))
> +		goto out;
> +
> +	rtase_wait_for_quiescence(dev);
> +	netif_device_attach(dev);
> +
> +	rtase_tx_clear(tp);
> +	rtase_rx_clear(tp);
> +
> +	if (rtase_init_ring(dev) != 0)
> +		netdev_alert(dev, "unable to init ring\n");
> +
> +	if ((tp->sw_flag & SWF_SRIOV_ENABLED) != 0u) {
> +		rtase_func_enable(tp);
> +		rtase_enable_hw_interrupt(tp);
> +	} else {
> +		rtase_hw_config(dev);
> +		/* always link, so start to transmit & receive */
> +		rtase_hw_start(dev);
> +	}
> +	netif_carrier_on(dev);
> +	netif_wake_queue(dev);
> +
> +out:
> +	return 0;
> +}
> +
> +#endif /* CONFIG_PM */
> +
> +static struct pci_driver rtase_pci_driver = {
> +	.name = MODULENAME,
> +	.id_table = rtase_pci_tbl,
> +	.probe = rtase_init_one,
> +	.remove = rtase_remove_one,
> +	.shutdown = rtase_shutdown,
> +#ifdef CONFIG_PM
> +	.suspend = rtase_suspend,
> +	.resume = rtase_resume,
> +#endif
> +#ifdef CONFIG_SRIOV
> +	.sriov_configure = rtase_pci_sriov_configure,
> +#endif
> +};
> +
> +/*  rtase switch control function
> + */

Please use standard kernel means instead of proprietary interfaces.

> +#define SWC_DRIVER_NAME  "rtase_swc"
> +#define SWC_DRIVER_MAJOR 200
> +#define SWC_CMD_REG_GET  70
> +#define SWC_CMD_REG_SET  71
> +#define SWC_CMD_TYPE_8   0
> +#define SWC_CMD_TYPE_16  1
> +#define SWC_CMD_TYPE_32  2
> +#define SWC_PAGE_ADDR    0x8000
> +#define SWC_PAGE_MASK    0xFFFF8000u
> +#define SWC_ADDR_MASK    0x00007FFFu
> +
> +#ifdef SWC_DRIVER_DBG
> +#define SWC_DRIVER_INFO(fmt, arg...) pr_info("%s:%d " fmt, __func__, __LINE__, ##arg)
> +#else
> +#define SWC_DRIVER_INFO(fmt, arg...)
> +#endif
> +
> +struct rtase_swc_cmd_t {
> +	u8 type;
> +	u32 reg_addr;
> +	u32 reg_value;
> +};
> +
> +struct rtase_swc_dev_t {
> +	struct cdev swc_cdev;
> +	void __iomem *swc_ioaddr;
> +	u16 init_flag;
> +};
> +
> +static struct rtase_swc_dev_t rtase_swc_device;
> +static struct pci_device_id rtase_swc_pci_table[] = {
> +	{
> +		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x906F),
> +	},
> +	{
> +		0,
> +	},
> +};
> +
> +static int rtase_swc_open(struct inode *p_inode, struct file *p_file)
> +{
> +	struct rtase_swc_dev_t *swc_dev =
> +		container_of(p_inode->i_cdev, struct rtase_swc_dev_t, swc_cdev);
> +
> +	p_file->private_data = swc_dev;
> +
> +	return 0;
> +}
> +
> +static int rtase_swc_release(struct inode *p_inode, struct file *p_file)
> +{
> +	(void)p_inode;
> +	(void)p_file;
> +
> +	return 0;
> +}
> +
> +static void rtase_swc_get_from_ptm(struct rtase_ptm_cmd_t *cmd)
> +{
> +	const void __iomem *ioaddr = rtase_swc_device.swc_ioaddr;
> +	u32 addr = cmd->reg_addr & (u32)SWC_ADDR_MASK;
> +
> +	cmd->reg_value = RTL_R32(addr);
> +}
> +
> +static s32 rtase_ptm_get_clock(const struct ifreq *ifr, const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = rtase_swc_device.swc_ioaddr;
> +	void *useraddr = (void *)ifr->ifr_data;
> +	struct rtase_ptm_cmd_t cmd;
> +	s32 i;
> +	u32 page_addr;
> +	u64 tmp = 0;
> +	s32 ret = 0;
> +
> +	memset(&cmd, 0, sizeof(struct rtase_ptm_cmd_t));
> +
> +	if (copy_from_user(&cmd, useraddr, sizeof(struct rtase_ptm_cmd_t)) != 0u) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	page_addr = cmd.reg_addr & SWC_PAGE_MASK;
> +	RTL_W32(SWC_PAGE_ADDR, page_addr);
> +
> +	cmd.ptp_second = 0;
> +	cmd.ptp_nano_second = 0;
> +
> +	for (i = 0; i < 3; i++) {
> +		rtase_swc_get_from_ptm(&cmd);
> +		cmd.reg_addr += 4u;
> +		if (i == 0) {
> +			cmd.ptp_nano_second = cmd.reg_value;
> +		} else {
> +			tmp = ((u64)cmd.reg_value << (32u * ((u64)i - 1u)));
> +			cmd.ptp_second += tmp;
> +		}
> +	}
> +
> +	ioaddr = tp->mmio_addr;
> +	cmd.ptm_time = 0;
> +
> +	for (i = 1; i < 3; i++) {
> +		cmd.ptm_time += ((u64)RTL_R32(cmd.ptm_addr) << (32u * ((u64)i - 1u)));
> +		cmd.ptm_addr += 4u;
> +	}
> +
> +	if (copy_to_user(useraddr, &cmd, sizeof(struct rtase_ptm_cmd_t)) != 0u)
> +		ret = -EFAULT;
> +
> +out:
> +	return ret;
> +}
> +
> +static s32 rtase_ptm_swc_get(const struct ifreq *ifr, const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = rtase_swc_device.swc_ioaddr;
> +	void *useraddr = (void *)ifr->ifr_data;
> +	struct rtase_ptm_cmd_t cmd;
> +	u32 page_addr;
> +	s32 ret = 0;
> +
> +	(void)tp;
> +
> +	if (copy_from_user(&cmd, useraddr, sizeof(struct rtase_ptm_cmd_t)) != 0u) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	page_addr = cmd.reg_addr & SWC_PAGE_MASK;
> +	RTL_W32(SWC_PAGE_ADDR, page_addr);
> +	rtase_swc_get_from_ptm(&cmd);
> +
> +	if (copy_to_user(useraddr, &cmd, sizeof(struct rtase_ptm_cmd_t)) != 0u) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +static s32 rtase_ptm_swc_set(const struct ifreq *ifr, const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = rtase_swc_device.swc_ioaddr;
> +	const void *useraddr = (void *)ifr->ifr_data;
> +	struct rtase_ptm_cmd_t cmd;
> +	u32 page_addr;
> +	u32 addr;
> +	s32 ret = 0;
> +
> +	(void)tp;
> +
> +	if (copy_from_user(&cmd, useraddr, sizeof(struct rtase_ptm_cmd_t)) != 0u) {
> +		ret = -EFAULT;
> +	} else {
> +		page_addr = cmd.reg_addr & SWC_PAGE_MASK;
> +		addr = cmd.reg_addr & SWC_ADDR_MASK;
> +		RTL_W32(SWC_PAGE_ADDR, page_addr);
> +		RTL_W32(addr, cmd.reg_value);
> +	}
> +
> +	return ret;
> +}
> +
> +static void rtase_swc_reg_get(struct rtase_swc_cmd_t *cmd)
> +{
> +	void __iomem *ioaddr = rtase_swc_device.swc_ioaddr;
> +	u32 page_addr = cmd->reg_addr & SWC_PAGE_MASK;
> +	u32 addr = cmd->reg_addr & SWC_ADDR_MASK;
> +
> +	RTL_W32(SWC_PAGE_ADDR, page_addr);
> +	switch (cmd->type) {
> +	case SWC_CMD_TYPE_8:
> +		cmd->reg_value = RTL_R8(addr);
> +		break;
> +	case SWC_CMD_TYPE_16:
> +		cmd->reg_value = RTL_R16(addr);
> +		break;
> +	case SWC_CMD_TYPE_32:
> +	default:
> +		cmd->reg_value = RTL_R32(addr);
> +		break;
> +	}
> +}
> +
> +static void rtase_swc_reg_set(const struct rtase_swc_cmd_t *cmd)
> +{
> +	void __iomem *ioaddr = rtase_swc_device.swc_ioaddr;
> +	u32 page_addr = cmd->reg_addr & SWC_PAGE_MASK;
> +	u32 addr = cmd->reg_addr & SWC_ADDR_MASK;
> +
> +	RTL_W32(SWC_PAGE_ADDR, page_addr);
> +	switch (cmd->type) {
> +	case SWC_CMD_TYPE_8:
> +		RTL_W8(addr, (u8)cmd->reg_value);
> +		break;
> +	case SWC_CMD_TYPE_16:
> +		RTL_W16(addr, (u16)cmd->reg_value);
> +		break;
> +	case SWC_CMD_TYPE_32:
> +	default:
> +		RTL_W32(addr, cmd->reg_value);
> +		break;
> +	}
> +}
> +
> +static long rtase_swc_ioctl(struct file *p_file, unsigned int cmd, unsigned long arg)
> +{
> +	long rc = 0;
> +	struct rtase_swc_cmd_t sw_cmd;
> +
> +	(void)p_file;
> +
> +	if (rtase_swc_device.init_flag == 1u) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
> +	rc = (s64)(copy_from_user(&sw_cmd, (void *)arg, sizeof(struct rtase_swc_cmd_t)));
> +
> +	if (rc != 0) {
> +		SWC_DRIVER_INFO("rtase_swc copy_from_user failed.");
> +	} else {
> +		switch (cmd) {
> +		case SWC_CMD_REG_GET:
> +			rtase_swc_reg_get(&sw_cmd);
> +			rc = (s64)(copy_to_user((void *)arg, &sw_cmd,
> +						sizeof(struct rtase_swc_cmd_t)));
> +			break;
> +
> +		case SWC_CMD_REG_SET:
> +			rtase_swc_reg_set(&sw_cmd);
> +			rc = (s64)(copy_to_user((void *)arg, &sw_cmd,
> +						sizeof(struct rtase_swc_cmd_t)));
> +			break;
> +
> +		default:
> +			rc = -ENOTTY;
> +			break;
> +		}
> +	}
> +
> +out:
> +	return rc;
> +}
> +
> +static const struct file_operations rtase_swc_fops = {
> +	.owner = THIS_MODULE,
> +	.open = rtase_swc_open,
> +	.release = rtase_swc_release,
> +	.unlocked_ioctl = rtase_swc_ioctl,
> +};
> +
> +static int rtase_swc_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	int rc;
> +	void __iomem *ioaddr = NULL;
> +	dev_t devno = MKDEV(SWC_DRIVER_MAJOR, 0);
> +
> +	(void)ent;
> +
> +	rtase_swc_device.init_flag = 1;
> +	rc = pci_enable_device(pdev);
> +
> +	if (rc != 0)
> +		SWC_DRIVER_INFO("rtase_swc enable device failed.");
> +	else
> +		rc = pci_request_regions(pdev, SWC_DRIVER_NAME);
> +
> +	if (rc == 0) {
> +		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +		if (rc != 0)
> +			rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +	}
> +
> +	if (rc != 0) {
> +		SWC_DRIVER_INFO("rtase_swc request regions failed.");
> +		pci_disable_device(pdev);
> +	} else {
> +		pci_set_master(pdev);
> +		ioaddr = ioremap(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
> +	}
> +
> +	if (!ioaddr) {
> +		SWC_DRIVER_INFO("rtase_swc ioremap failed.");
> +		pci_release_regions(pdev);
> +		pci_disable_device(pdev);
> +	} else {
> +		rc = register_chrdev_region(devno, 1, SWC_DRIVER_NAME);
> +	}
> +
> +	if (rc != 0) {
> +		SWC_DRIVER_INFO("rtase_swc register character device failed.");
> +		iounmap(ioaddr);
> +		pci_release_regions(pdev);
> +		pci_disable_device(pdev);
> +	} else {
> +		rtase_swc_device.swc_ioaddr = ioaddr;
> +		cdev_init(&rtase_swc_device.swc_cdev, &rtase_swc_fops);
> +		rtase_swc_device.swc_cdev.owner = THIS_MODULE;
> +		cdev_add(&rtase_swc_device.swc_cdev, devno, 1);
> +		rtase_swc_device.init_flag = 0;
> +	}
> +
> +	return rc;
> +}
> +
> +static void rtase_swc_remove_one(struct pci_dev *pdev)
> +{
> +	iounmap(rtase_swc_device.swc_ioaddr);
> +	pci_release_regions(pdev);
> +	pci_disable_device(pdev);
> +	cdev_del(&rtase_swc_device.swc_cdev);
> +	unregister_chrdev_region(MKDEV(SWC_DRIVER_MAJOR, 0), 1);
> +	rtase_swc_device.init_flag = 1;
> +}
> +
> +static struct pci_driver rtase_swc_pci_driver = {
> +	.name = SWC_DRIVER_NAME,
> +	.id_table = rtase_swc_pci_table,
> +	.probe = rtase_swc_init_one,
> +	.remove = rtase_swc_remove_one,
> +};
> +
> +static int __init rtase_init_module(void)
> +{
> +	int ret = 0;
> +
> +	work_queue = create_singlethread_workqueue("rtase_work_queue");

Why don't you use one of the system workqueues?

> +	if (!work_queue) {
> +		ret = -ENOMEM;
> +	} else {
> +#ifdef ENABLE_RTASE_PROCFS
> +		rtase_proc_module_init();
> +#endif
> +		ret = pci_register_driver(&rtase_pci_driver);
> +		if (ret != 0) {
> +			destroy_workqueue(work_queue);
> +			pr_alert("rtase_pci_driver register failed.");
> +		} else {
> +			ret = pci_register_driver(&rtase_swc_pci_driver);
> +		}
> +
> +		if (ret != 0) {
> +			pci_unregister_driver(&rtase_pci_driver);
> +			destroy_workqueue(work_queue);
> +			pr_alert("rtase_swc_pci_driver register failed.");
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void __exit rtase_cleanup_module(void)
> +{
> +	pci_unregister_driver(&rtase_swc_pci_driver);
> +
> +	pci_unregister_driver(&rtase_pci_driver);
> +#ifdef ENABLE_RTASE_PROCFS
> +	if (rtase_proc) {
> +		remove_proc_subtree(MODULENAME, init_net.proc_net);
> +		rtase_proc = NULL;
> +	}
> +#endif
> +	destroy_workqueue(work_queue);
> +}
> +
> +module_init(rtase_init_module);
> +module_exit(rtase_cleanup_module);
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_sriov.c b/drivers/net/ethernet/realtek/rtase/rtase_sriov.c
> new file mode 100644
> index 000000000000..9441d59a3271
> --- /dev/null
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_sriov.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright(c) 2023 Realtek Semiconductor Corp. All rights reserved.
> + *
> + *  Author:
> + *  Realtek ARD1 software team
> + */
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/rtnetlink.h>
> +
> +#include "rtase.h"
> +#include "rtase_sriov.h"
> +
> +/******************************************************************************
> + *  Function
> + ******************************************************************************/
> +static int rtase_allocate_vf_data(struct rtase_private *tp, int num_vfs)
> +{
> +	int ret = 0;
> +
> +	tp->vf_info = kcalloc((u64)num_vfs, sizeof(struct vf_info), GFP_KERNEL);
> +	if (!tp->vf_info)
> +		ret = -ENOMEM;
> +	else
> +		tp->num_vfs = (u16)num_vfs;
> +
> +	return ret;
> +}
> +
> +static void rtase_get_vfs(const struct rtase_private *tp)
> +{
> +	struct pci_dev *pdev = tp->pdev;
> +	struct pci_dev *vf_pdev = NULL;
> +	u16 vendor = pdev->vendor;
> +	int index = 0;
> +	u16 vf_id = 0;
> +	int sriov_pos = 0;
> +
> +	sriov_pos = (s32)pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
> +
> +	if (sriov_pos == 0) {
> +		sriov_warn("\tcan't find sriov position.");
> +	} else {
> +		pci_read_config_word(pdev, sriov_pos + PCI_SRIOV_VF_DID, &vf_id);
> +		sriov_info("rtase VF Device ID = %04x", vf_id);
> +
> +		vf_pdev = pci_get_device(vendor, vf_id, NULL);
> +
> +		for (; vf_pdev != NULL; vf_pdev = pci_get_device(vendor, vf_id, vf_pdev)) {
> +			if (vf_pdev->is_virtfn == 0u)
> +				continue;
> +
> +#ifdef CONFIG_PCI_IOV
> +			if (vf_pdev->physfn != pdev)
> +				continue;
> +
> +#endif
> +
> +			pci_dev_get(vf_pdev);
> +			tp->vf_info[index].vf_pci_dev = vf_pdev;
> +
> +			if (++index >= (s32)tp->num_vfs)
> +				break;
> +		}
> +		sriov_info("%s...index = %i", __func__, index);
> +	}
> +}
> +
> +static void rtase_sriov_hw_settings(struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 tmp_reg = 0;
> +	unsigned long flags;
> +
> +	sriov_info("%s...vf_num = %i", __func__, tp->num_vfs);
> +	spin_lock_irqsave(&tp->lock, flags);
> +	if (tp->num_vfs != 0u) {
> +		/* select rxq number */
> +		tmp_reg = RTL_R16(VQCTRL);
> +		tmp_reg &= (u16)(~(0x7u << 2u));
> +		if (tp->num_vfs == 1u)
> +			tmp_reg |= (0x3u << 2u);
> +		else if (tp->num_vfs <= 3u)
> +			tmp_reg |= (0x4u << 2u);
> +		else
> +			tmp_reg |= (0x5u << 2u);
> +
> +		RTL_W16(VQCTRL, tmp_reg);
> +		sriov_info("VQCTRL = %04x", RTL_R16(VQCTRL));
> +
> +		/* Mailbox interrupt mask */
> +		RTL_W8(PFMSGIMR, 0x7F);
> +
> +		tp->sw_flag |= (u32)SWF_SRIOV_ENABLED;
> +	} else {
> +		/* restore rxq number TBD: restore PF rxq */
> +		tmp_reg = RTL_R16(VQCTRL);
> +		tmp_reg &= (u16)(~(0x7u << 2u));
> +		tmp_reg |= (0x2u << 2u);
> +		RTL_W16(VQCTRL, tmp_reg);
> +		sriov_info("VQCTRL = %04x", RTL_R16(VQCTRL));
> +
> +		/* Mailbox interrupt mask */
> +		RTL_W8(PFMSGIMR, 0x0);
> +
> +		tp->sw_flag &= (u32)(~SWF_SRIOV_ENABLED);
> +	}
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +}
> +
> +s32 rtase_disable_sriov(struct rtase_private *tp)
> +{
> +	u16 num_vfs = tp->num_vfs;
> +	u16 index = 0;
> +	s32 ret = 0;
> +
> +	tp->num_vfs = 0;
> +	for (index = 0; index < num_vfs; index++) {
> +		struct pci_dev *vf_pdev = tp->vf_info[index].vf_pci_dev;
> +
> +		if (vf_pdev) {
> +			pci_dev_put(vf_pdev);
> +			tp->vf_info[index].vf_pci_dev = NULL;
> +		}
> +	}
> +
> +	/* free vf_info */
> +	kfree(tp->vf_info);
> +	tp->vf_info = NULL;
> +
> +	/* pci disabe sriov*/
> +	if (pci_vfs_assigned(tp->pdev) != 0) {
> +		sriov_warn("VFs are assigned !");
> +		ret = -EPERM;
> +	} else {
> +		pci_disable_sriov(tp->pdev);
> +
> +		/* sriov hardware settings */
> +		rtase_sriov_hw_settings(tp);
> +	}
> +
> +	return ret;
> +}
> +
> +static int rtase_pci_sriov_enable(struct pci_dev *pdev, int num_vfs)
> +{
> +	const struct net_device *dev = pci_get_drvdata(pdev);
> +	struct rtase_private *tp = netdev_priv(dev);
> +	int err = 0;
> +	u16 existed_vfs = (u16)pci_num_vf(pdev);
> +	int ret = 0;
> +
> +	if (tp->num_vfs == (u32)num_vfs)
> +		ret = -EINVAL;
> +
> +	if ((existed_vfs != 0u) && (existed_vfs != (u32)num_vfs)) {
> +		err = rtase_disable_sriov(tp);
> +		if (err != 0) {
> +			ret = err;
> +			goto out;
> +		}
> +	} else if ((existed_vfs != 0u) && (existed_vfs == (u32)num_vfs)) {
> +		ret = num_vfs;
> +		goto out;
> +	} else {
> +		sriov_warn("existed_vfs = 0\n");
> +	}
> +
> +	err = rtase_allocate_vf_data(tp, num_vfs);
> +	if (err != 0) {
> +		sriov_warn("allocate vf data failed.");
> +		ret = err;
> +		goto out;
> +	}
> +
> +	err = pci_enable_sriov(pdev, num_vfs);
> +	if (err != 0) {
> +		sriov_warn("pci_enable_sriov failed: %d\n", err);
> +		ret = err;
> +		goto out;
> +	}
> +
> +	/* sriov hardware settings */
> +	rtase_sriov_hw_settings(tp);
> +
> +	rtase_get_vfs(tp);
> +
> +out:
> +	return ret;
> +}
> +
> +static int rtase_pci_sriov_disable(struct pci_dev *pdev)
> +{
> +	const struct net_device *dev = pci_get_drvdata(pdev);
> +	struct rtase_private *tp = netdev_priv(dev);
> +	int err;
> +
> +	if ((tp->num_vfs == 0u) && (pci_num_vf(pdev) == 0))
> +		err = -EINVAL;
> +	else
> +		err = rtase_disable_sriov(tp);
> +
> +	return err;
> +}
> +
> +/* TBD: need to modify, now all enable */
> +static void rtase_sriov_cr(const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 cr = RTL_R16(FCR);
> +
> +	cr |= (u16)(FCR_BAR_EN | FCR_MAR_EN | FCR_TX_LOOPBACK_EN);
> +	RTL_W16(FCR, cr);
> +
> +	RTL_W16(LBK_CTRL, (u16)(LBK_ATLD | LBK_CLR));
> +}
> +
> +int rtase_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
> +{
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	struct rtase_private *tp = netdev_priv(dev);
> +	int ret = 0;
> +
> +	sriov_info("%s...%i", __func__, num_vfs);
> +
> +	netif_stop_queue(dev);
> +	if ((tp->sw_flag & SWF_SRIOV_ENABLED) != 0u)
> +		rtase_func_disable(tp);
> +
> +	rtase_hw_reset(dev);
> +	rtase_tx_clear(tp);
> +	rtase_rx_clear(tp);
> +
> +	if (rtase_init_ring(dev) != 0)
> +		netdev_info(tp->dev, "unable to init ring\n");
> +
> +	if (num_vfs == 0)
> +		ret = rtase_pci_sriov_disable(pdev);
> +	else
> +		ret = rtase_pci_sriov_enable(pdev, num_vfs);
> +
> +	if (ret != -EINVAL) {
> +		mdelay(10);
> +
> +		rtase_hw_set_rx_packet_filter(dev);
> +		rtase_hw_start(dev);
> +		if ((tp->sw_flag & SWF_SRIOV_ENABLED) != 0u) {
> +			rtase_func_enable(tp);
> +			rtase_sriov_cr(tp);
> +		}
> +
> +		netif_wake_queue(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static void rtl_set_vf_mac(struct rtase_private *tp, int vf, const u8 *mac)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	unsigned long flags;
> +	u16 tmp;
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +
> +	tmp = ((u16)mac[0] << 8) | (u16)mac[1];
> +	RTL_W16(((s32)VF_MAC_0 + (vf * 8)), tmp);
> +	tmp = ((u16)mac[2] << 8) | (u16)mac[3];
> +	RTL_W16(((s32)VF_MAC_2 + (vf * 8)), tmp);
> +	tmp = ((u16)mac[4] << 8) | (u16)mac[5];
> +	RTL_W16(((s32)VF_MAC_4 + (vf * 8)), tmp);
> +
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +}
> +
> +#ifdef IFLA_VF_MAX
> +int rtase_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
> +{
> +	struct rtase_private *tp = netdev_priv(netdev);
> +	struct vf_info *vf_info = NULL;
> +	int ret = 0;
> +
> +	sriov_info("%s:vf = %i, MAC:%02x:%02x:%02x:%02x:%02x:%02x", __func__, vf, mac[0], mac[1],
> +		   mac[2], mac[3], mac[4], mac[5]);
> +
> +	if (vf >= (s16)tp->num_vfs) {
> +		ret = -EINVAL;
> +	} else {
> +		vf_info = &tp->vf_info[vf];
> +
> +		if (is_valid_ether_addr(mac)) {
> +			rtl_set_vf_mac(tp, vf, mac);
> +			memcpy(vf_info->vf_mac, mac, ETH_ALEN);
> +		} else if (is_zero_ether_addr(mac)) {
> +			rtl_set_vf_mac(tp, vf, mac);
> +			memcpy(vf_info->vf_mac, mac, ETH_ALEN);
> +		} else {
> +			ret = -EINVAL;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +int rtase_get_vf_config(struct net_device *netdev, int vf, struct ifla_vf_info *ivi)
> +{
> +	const struct rtase_private *tp = netdev_priv(netdev);
> +	const struct vf_info *vf_info = NULL;
> +	int ret = 0;
> +
> +	sriov_info("%s...%i", __func__, vf);
> +
> +	if (vf >= (s16)tp->num_vfs) {
> +		sriov_info("%s...%i EINVAL", __func__, vf);
> +		ret = -EINVAL;
> +	} else {
> +		vf_info = &tp->vf_info[vf];
> +		ivi->vf = (u32)vf;
> +		memcpy(ivi->mac, vf_info->vf_mac, ETH_ALEN);
> +	}
> +
> +	return ret;
> +}
> +#endif
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_sriov.h b/drivers/net/ethernet/realtek/rtase/rtase_sriov.h
> new file mode 100644
> index 000000000000..62dafbd18f9a
> --- /dev/null
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_sriov.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright(c) 2023 Realtek Semiconductor Corp. All rights reserved.
> + *
> + *  Author:
> + *  Realtek ARD software team
> + */
> +#ifndef RTASE_SRIOV_H_
> +#define RTASE_SRIOV_H_
> +
> +/*  Defines
> + */
> +#ifdef SRIOV_DEBUG
> +#define sriov_warn(format, args...) pr_warning(format, ##args)
> +#define sriov_info(format, args...) pr_info(format, ##args)
> +#else
> +#define sriov_warn(format, args...)
> +#define sriov_info(format, args...)
> +#endif
> +
> +/*  Function Prototype
> + */
> +s32 rtase_disable_sriov(struct rtase_private *tp);
> +int rtase_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
> +#ifdef IFLA_VF_MAX
> +int rtase_set_vf_mac(struct net_device *netdev, int vf, u8 *mac);
> +int rtase_get_vf_config(struct net_device *netdev, int vf, struct ifla_vf_info *ivi);
> +#endif
> +
> +#endif /* RTASE_SRIOV_H_ */

