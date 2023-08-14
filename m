Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0300777B590
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbjHNJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbjHNJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:35:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1637EE73;
        Mon, 14 Aug 2023 02:35:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c0cb7285fso507003666b.0;
        Mon, 14 Aug 2023 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692005733; x=1692610533;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ok2cJvAUHZddldJ3JsCYpov+MTfcukuPErzr7klFhrc=;
        b=BNBR1vKYCmVu8qtQ7PjusJIEKCyCeNvXIAMdzNu46pmbXTEcCH7YII5ZHhdlD5CoQN
         lvWE9nTSD6EU/POZX0amQ1yAAjDzsMMlsFagY5jdpJg4ej7k2LS3LzK+FwPB069ZVtdM
         /UkkDzbhilOQXpXnkYLAZ13gK/1Fsv3DZGVVWf89b+7SAcQ+0AVknozX3qr0npt43kXt
         P27rGWgcH6HHxUlO0vIyJg8M0BI7Nm5ltuadtpfXo+NrejWowhvWg+xxrTvc0Qgu5Szw
         F8Fsm96j52r30isoeAqt8QRuwzPKL7zGCVln3lveUHcDqOTRQVdtrnNis3NyDpom0P31
         hv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692005733; x=1692610533;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ok2cJvAUHZddldJ3JsCYpov+MTfcukuPErzr7klFhrc=;
        b=H3NiofCkAuBobRkmUBtf1G4mIvuZ7oObkns0icVQFuU7qz7j64N7lkgaCPmZcqCKZk
         sqrDir+JqHqIFZ32qvAym7qATKI5gfQPWGp9PY7p58L0K3NYhr3bgFMqlO2guFdBsANO
         EEmwfCH8x8SlxUxWioFOXkLoche6C2x8P6JpXgGI9Ygd/j1McyZe02q/JGrtSMk+PM6e
         RdT/ZDb4DdCZ/BqyFLsr+LXjXLY6LOtk228A4HeW8wfWYOJDjwz2xB9laEj2zSn6RBzd
         mWFaqRK/efiaqS7IWbjm5D4vd6BhrMKoJJc8ek63HjQb+Cto3zEPk+nxuEbcMWtu/TEm
         Q1lA==
X-Gm-Message-State: AOJu0YzDamRyrPCuAXAZ2oXIH7qkbkaPnbgD7ioSSOkyBO3vYUiXnvD8
        jHY3EB3+8ebxPcTeCUQ+Khc=
X-Google-Smtp-Source: AGHT+IFxdTqGp1dYCy5T4zyxfHW872eJrCGdRHWTmx/nCyGma+pUlv+FBn/cmsSp09XDq92ZvmL5vw==
X-Received: by 2002:a17:906:73cf:b0:99b:b3a1:437b with SMTP id n15-20020a17090673cf00b0099bb3a1437bmr7736730ejl.40.1692005732596;
        Mon, 14 Aug 2023 02:35:32 -0700 (PDT)
Received: from ?IPV6:2a01:c22:6e61:c500:187a:28da:f540:aa2? (dynamic-2a01-0c22-6e61-c500-187a-28da-f540-0aa2.c22.pool.telefonica.de. [2a01:c22:6e61:c500:187a:28da:f540:aa2])
        by smtp.googlemail.com with ESMTPSA id e27-20020a170906375b00b0099caf5bed64sm5482207ejc.57.2023.08.14.02.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 02:35:31 -0700 (PDT)
Message-ID: <8f202abf-e84d-28f8-af6f-9232a6696ac9@gmail.com>
Date:   Mon, 14 Aug 2023 11:35:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To:     Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20230810062915.252881-1-justinlai0215@realtek.com>
 <20230810062915.252881-2-justinlai0215@realtek.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
In-Reply-To: <20230810062915.252881-2-justinlai0215@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.2023 08:29, Justin Lai wrote:
> This patch is to add the ethernet device driver for the PCIe interface of Realtek Automotive Ethernet Switch,
> applicable to RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.
> 
Patch is missing a change log. A see few review comments addressed,
several others not (e.g. remove function forward declarations).
Also PHY handling is still missing (even if typical use case
is direct switch connection, see DSA documentation).

> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/Kconfig          |   17 +
>  drivers/net/ethernet/realtek/Makefile         |    1 +
>  drivers/net/ethernet/realtek/rtase/Makefile   |   10 +
>  drivers/net/ethernet/realtek/rtase/rtase.h    |  540 +++
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 2884 +++++++++++++++++
>  .../net/ethernet/realtek/rtase/rtase_sriov.c  |  318 ++
>  .../net/ethernet/realtek/rtase/rtase_sriov.h  |   20 +
>  7 files changed, 3790 insertions(+)
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
> index 000000000000..a662401e5438
> --- /dev/null
> +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> @@ -0,0 +1,540 @@
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
> +#define NETIF_F_ALL_CSUM NETIF_F_CSUM_MASK
> +
> +#define NETIF_F_HW_VLAN_RX NETIF_F_HW_VLAN_CTAG_RX
> +#define NETIF_F_HW_VLAN_TX NETIF_F_HW_VLAN_CTAG_TX
> +
> +#define CONFIG_SRIOV 1
> +
> +#ifndef NETIF_F_RXALL
> +#define NETIF_F_RXALL 0u
> +#endif
> +
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
> +#define NAPI_SUFFIX "-NAPI"
> +#define PFX         KBUILD_MODNAME ": "
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
> +#define RTASE_REGS_SIZE   (256u)
> +#define RTASE_NAPI_WEIGHT (64)
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
> +enum rtase_registers {
> +	MAC0 = 0x0000u,
> +	MAC4 = 0x0004u,
> +	MAR0 = 0x0008u,
> +	MAR1 = 0x000Cu,
> +	DTCCR0 = 0x0010u,
> +	DTCCR4 = 0x0014u,
> +	FCR = 0x0018u,
> +	LBK_CTRL = 0x001Au,
> +	TX_DESC_START_ADDR0 = 0x0020u,
> +	TX_DESC_START_ADDR4 = 0x0024u,
> +	TX_DESC_COMMAND = 0x0028u,
> +	CHIP_CMD = 0x0037u,
> +	IMR0 = 0x0038u,
> +	ISR0 = 0x003Cu,
> +	IMR1 = 0x0800u,
> +	ISR1 = 0x0802u,
> +	TX_CONFIG_0 = 0x0040u,
> +	RX_CONFIG_0 = 0x0044u,
> +	RX_CONFIG_1 = 0x0046u,
> +	EEM = 0x0050u,
> +	TDFNR = 0x0057u,
> +	TPPOLL = 0x0090u,
> +	PDR = 0x00B0u,
> +	FIFOR = 0x00D3u,
> +	PCPR = 0x00D8u,
> +	RMS = 0x00DAu,
> +	CPLUS_CMD = 0x00DAu,
> +	Q0_RX_DESC_ADDR0 = 0x00E4u,
> +	Q0_RX_DESC_ADDR4 = 0x00E8u,
> +	Q1_RX_DESC_ADDR0 = 0x4000u,
> +	Q1_RX_DESC_ADDR4 = 0x4004u,
> +	MTPS = 0x00ECu,
> +	MISC = 0x00F2u,
> +
> +	TFUN_CTRL = 0x0400u,
> +	TX_CONFIG_1 = 0x203Eu,
> +	TOKSEL = 0x2046u,
> +	TXQCRDT_0 = 0x2500u,
> +	RFIFONFULL = 0x4406u,
> +	VQCTRL = 0x4800u,
> +	INT_MITI_TX = 0x0A00u,
> +	INT_MITI_RX = 0x0A80u,
> +
> +	VFMSGDATA_0 = 0x7100u,
> +	VFMSGDATA_2 = 0x7104u,
> +	PFMSGICRREQ = 0x7140u,
> +	PFMSGIMR = 0x7148u,
> +	PFMSGVF1 = 0x7200u,
> +
> +	VF_MAC_0 = 0x7294u,
> +	VF_MAC_2 = 0x7296u,
> +	VF_MAC_4 = 0x7298u,
> +
> +	VLAN_ENTRY_MEM_0 = 0x7234u,
> +	VLAN_ENTRY_0 = 0xAC80u,
> +};
> +
> +enum rtase_register_content {
> +	/* InterruptStatusBits 0 */
> +	TOK7 = BIT(30),
> +	TOK6 = BIT(28),
> +	TOK5 = BIT(26),
> +	TOK4 = BIT(24),
> +	MBX = BIT(16),
> +	TIMEOUT0 = BIT(14),
> +	FOVW = BIT(6),
> +	RDU = BIT(4),
> +	TOK = BIT(2),
> +	ROK = BIT(0),
> +
> +	/* InterruptStatusBits 1~3 */
> +	Q_TOK = BIT(4),
> +	Q_RDU = BIT(1),
> +	Q_ROK = BIT(0),
> +
> +	/* ChipCmdRegBits */
> +	STOP_REQ = BIT(7),
> +	STOP_REQ_DONE = BIT(6),
> +	RE = BIT(3),
> +	TE = BIT(2),
> +
> +	/* Cfg9346Bits */
> +	EEM_UNLOCK = 0xC0u,
> +
> +	/* Receive Configuration 0 */
> +	RX_SINGLE_FETCH = BIT(14),
> +	RX_SINGLE_TAG = BIT(13),
> +	RX_MX_DMA_MASK = 0x7,
> +	RX_MX_DMA_SHIFT = 8u,
> +	ACPT_FLOW = BIT(7),
> +	ACCEPT_ERR = BIT(5),
> +	ACCEPT_RUNT = BIT(4),
> +	ACCEPT_BROADCAST = BIT(3),
> +	ACCEPT_MULTICAST = BIT(2),
> +	ACCEPT_MYPHYS = BIT(1),
> +	ACCEPT_ALLPHYS = BIT(0),
> +	ACCEPT_MASK = (ACPT_FLOW | ACCEPT_ERR | ACCEPT_RUNT | ACCEPT_BROADCAST | ACCEPT_MULTICAST
> +		       | ACCEPT_MYPHYS | ACCEPT_ALLPHYS),
> +
> +	/* Receive Configuration 1 */
> +	RX_MAX_FETCH_DESC_MASK = 0x1F,
> +	RX_MAX_FETCH_DESC_SHIFT = 11u,
> +	RX_NEW_DESC_FORMAT_EN = BIT(8),
> +	OUTER_VLAN_DETAG_EN = BIT(7),
> +	INNER_VLAN_DETAG_EN = BIT(6),
> +	PCIE_NEW_FLOW = BIT(2),
> +	PCIE_RELOAD_En = BIT(0),
> +
> +	/* TxConfigBits */
> +	TX_INTER_FRAME_GAP_MASK = 0x3u,
> +	TX_INTER_FRAME_GAP_SHIFT = 24u,
> +	TX_DMA_MASK = 0x7u,
> +	/* DMA burst value (0-7) is shift this many bits */
> +	TX_DMA_SHIFT = 8u,
> +
> +	/* TFunCtrl */
> +	TX_NEW_DESC_FORMAT_EN = BIT(0),
> +
> +	/* TxDescCommand */
> +	TX_DESC_CMD_CS = BIT(15),
> +	TX_DESC_CMD_WE = BIT(14),
> +
> +	/* CPlusCmd */
> +	FORCE_RXFLOW_EN = BIT(11),
> +	FORCE_TXFLOW_EN = BIT(10),
> +	RX_CHKSUM = BIT(5),
> +
> +	/* MISC */
> +	RX_DV_GATE_EN = BIT(3),
> +
> +	/* ResetCounterCommand */
> +	COUNTER_RESET = BIT(0),
> +	/* DumpCounterCommand */
> +	COUNTER_DUMP = BIT(3),
> +
> +	/* OCP access */
> +	OCPR_WRITE = 0x80000000u,
> +	OCPR_ADDR_REG_SHIFT = 16u,
> +
> +	/* MCU Command */
> +	TX_FIFO_EMPTY = BIT(5),
> +	RX_FIFO_EMPTY = BIT(4),
> +
> +	/* Function Control Register */
> +	FCR_TX_LOOPBACK_EN = BIT(9),
> +	FCR_TE = BIT(8),
> +	FCR_RXQ_MASK = 0x3u,
> +	FCR_RXQ_SHIFT = 4u,
> +	FCR_MAR_EN = BIT(3),
> +	FCR_BAR_EN = BIT(2),
> +	FCR_VLAN_FTR_EN = BIT(1),
> +	FCR_RE = BIT(0),
> +
> +	/* Loopback Control */
> +	LBK_ATLD = BIT(1),
> +	LBK_CLR = BIT(0),
> +
> +	/* PCP Register */
> +	PCPR_VLAN_FTR_EN = BIT(6),
> +};
> +
> +enum desc_status_bit {
> +	DESC_OWN = BIT(31), /* Descriptor is owned by NIC */
> +	RING_END = BIT(30), /* End of descriptor ring */
> +
> +	/* Tx private */
> +	/*------ offset 0 of tx descriptor ------*/
> +	TX_FIRST_FRAG = BIT(29), /* Tx First segment of a packet */
> +	TX_LAST_FRAG = BIT(28),  /* Tx Final segment of a packet */
> +	GIANT_SEND_V4 = BIT(26), /* TCP Giant Send Offload V4 (GSOv4) */
> +	GIANT_SEND_V6 = BIT(25), /* TCP Giant Send Offload V6 (GSOv6) */
> +	TX_VLAN_TAG = BIT(17),   /* Add VLAN tag */
> +
> +	/*------ offset 4 of tx descriptor ------*/
> +	TX_UDPCS_C = BIT(31), /* Calculate UDP/IP checksum */
> +	TX_TCPCS_C = BIT(30), /* Calculate TCP/IP checksum */
> +	TX_IPCS_C = BIT(29),  /* Calculate IP checksum */
> +	TX_IPV6F_C = BIT(28), /* Indicate it is an IPv6 packet */
> +
> +	/* Rx private */
> +	/*------ offset 28 of rx descriptor ------*/
> +	RX_FIRST_FRAG = BIT(25), /* Rx First segment of a packet */
> +	RX_LAST_FRAG = BIT(24),  /* Rx Final segment of a packet */
> +	RX_RES = BIT(20),
> +	RX_RUNT = BIT(19),
> +	RX_RWT = BIT(18),
> +	RX_CRC = BIT(16),
> +
> +	RX_V6F = BIT(31),
> +	RX_V4F = BIT(30),
> +	RX_UDPT = BIT(29),
> +	RX_TCPT = BIT(28),
> +	RX_IPF = BIT(26),           /* IP checksum failed */
> +	RX_UDPF = BIT(25),          /* UDP/IP checksum failed */
> +	RX_TCPF = BIT(24),          /* TCP/IP checksum failed */
> +	RX_LBK_FIFO_FULL = BIT(17), /* Loopback FIFO Full */
> +	RX_VLAN_TAG = BIT(16),      /* VLAN tag available */
> +};
> +
> +enum sw_flag_content {
> +	SWF_SRIOV_ENABLED = BIT(0),
> +	SWF_MSI_ENABLED = BIT(1),
> +	SWF_MSIX_ENABLED = BIT(2),
> +};
> +
> +#define RSVD_MASK 0x3FFFC000u
> +
> +typedef struct {
> +	u32 opts1;
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
> +} rx_desc;
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
> +	u32 sw_flag;
> +	struct work_struct msg_work;
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
> +	u8 org_mac_addr[ETH_ALEN];
> +#ifdef CONFIG_SRIOV
> +	struct vf_info *vf_info;
> +	u16 num_vfs;
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
> +};
> +
> +enum mcfg {
> +	CFG_METHOD_1 = (0u),
> +	CFG_METHOD_DEFAULT = (1u),
> +};
> +
> +#define LSO_64K 64000
> +
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
> index 000000000000..2279f69ab7f1
> --- /dev/null
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -0,0 +1,2884 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  rtase is the Linux device driver released for Realtek Automotive Switch
> + *  controllers with PCI-Express interface.
> + *
> + *  Copyright(c) 2023 Realtek Semiconductor Corp.
> + */
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
> +MODULE_AUTHOR("Realtek ARD Software Team");
> +MODULE_DESCRIPTION("Realtek Automotive Switch Ethernet and Network PCIe Driver");
> +MODULE_LICENSE("GPL");
> +
> +/******************************************************************************
> + * Module Parameters
> + ******************************************************************************/
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
> +static int rtase_poll(struct napi_struct *napi, int budget);
> +static void rtase_sw_reset(struct net_device *dev);
> +static void rtase_dump_tally_counter(const struct rtase_private *tp, dma_addr_t paddr);
> +static void mac_ocp_write(const struct rtase_private *tp, u16 reg_addr, u16 value);
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
> +static void rtase_dump_tally_counter(const struct rtase_private *tp, dma_addr_t paddr)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 wait_cnt;
> +	u32 cmd;
> +
> +	RTL_W32(DTCCR4, (paddr >> 32));
> +	cmd = paddr & DMA_BIT_MASK(32);
> +	RTL_W32(DTCCR0, cmd);
> +	RTL_W32(DTCCR0, (cmd | COUNTER_DUMP));
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
> +static void mac_ocp_write(const struct rtase_private *tp, u16 reg_addr, u16 value)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 data32;
> +
> +	WARN_ON_ONCE(reg_addr % 2u);
> +
> +	data32 = reg_addr / 2u;
> +	data32 <<= OCPR_ADDR_REG_SHIFT;
> +	data32 += value;
> +	data32 |= OCPR_WRITE;
> +
> +	RTL_W32(PDR, data32);
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
> +		RTL_W16(ivec->imr_addr, ivec->imr);
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
> +	u16 rx_config;
> +	u16 i = 0;
> +
> +	rx_config = RTL_R16(RX_CONFIG_0);
> +	RTL_W16(RX_CONFIG_0, (rx_config & ~ACCEPT_MASK));
> +
> +	/* rxdv_gated_en - mask rxdv in PHYIO */
> +	RTL_W8(MISC, (RTL_R8(MISC) | RX_DV_GATE_EN));
> +	/* stop any TLP request from PCIe */
> +	RTL_W8(CHIP_CMD, (RTL_R8(CHIP_CMD) | STOP_REQ));
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
> +	RTL_W8(CHIP_CMD, (RTL_R8(CHIP_CMD) & ~(TE | RE)));
> +
> +	RTL_W8(CHIP_CMD, (RTL_R8(CHIP_CMD) & ~STOP_REQ));
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
> +	RTL_W16(RX_CONFIG_1, (rcr & ~PCIE_RELOAD_En));
> +	RTL_W16(RX_CONFIG_1, (rcr | PCIE_RELOAD_En));
> +
> +	/* Set PCIe TE & RE */
> +	RTL_W8(CHIP_CMD, (RTL_R8(CHIP_CMD) | (TE | RE)));
> +
> +	/* Clear rxdv_gated_en */
> +	RTL_W8(MISC, (RTL_R8(MISC) & ~RX_DV_GATE_EN));
> +}
> +
> +void rtase_func_enable(const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 cr = 0u;
> +	u16 i = 0u;
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
> +	cr |= (FCR_TE | FCR_RE);
> +	RTL_W16(FCR, cr);
> +}
> +
> +void rtase_func_disable(const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 i = 0;
> +
> +	/* Clear function TE & RE */
> +	RTL_W16(FCR, (RTL_R16(FCR) & ~(FCR_TE | FCR_RE)));
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
> +	RTL_W8(EEM, (RTL_R8(EEM) | EEM_UNLOCK));
> +}
> +
> +static void rtase_disable_EEM_write(const struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +
> +	RTL_W8(EEM, (RTL_R8(EEM) & ~EEM_UNLOCK));
> +}
> +
> +static inline u32 rtase_tx_vlan_tag(const struct rtase_private *tp, const struct sk_buff *skb)
> +{
> +	u32 tag;
> +
> +	tag = (skb_vlan_tag_present(skb) != 0u) ? (TX_VLAN_TAG | swab16(skb_vlan_tag_get(skb)))
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
> +	if (dev->mtu > ETH_DATA_LEN) {
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
> +		rx_config |= (ACCEPT_ERR | ACCEPT_RUNT);
> +	else
> +		rx_config &= ~(ACCEPT_ERR | ACCEPT_RUNT);
> +
> +	RTL_W16(RX_CONFIG_0, rx_config);
> +
> +	rx_config = RTL_R16(RX_CONFIG_1);
> +	if ((dev->features & NETIF_F_HW_VLAN_RX) != 0u)
> +		rx_config |= (INNER_VLAN_DETAG_EN | OUTER_VLAN_DETAG_EN);
> +	else
> +		rx_config &= ~(INNER_VLAN_DETAG_EN | OUTER_VLAN_DETAG_EN);
> +
> +	RTL_W16(RX_CONFIG_1, rx_config);
> +
> +	if ((features & NETIF_F_RXCSUM) != 0u)
> +		RTL_W16(CPLUS_CMD, (RTL_R16(CPLUS_CMD) | RX_CHKSUM));
> +	else
> +		RTL_W16(CPLUS_CMD, (RTL_R16(CPLUS_CMD) & ~RX_CHKSUM));
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
> +	case 0x04000000:
> +	case 0x04800000:
> +		tp->mcfg = CFG_METHOD_1;
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
> +	bool flag = false;
> +	s16 i;
> +
> +	for (i = ARRAY_SIZE(rtl_chip_info) - 1u; i >= 0; i--) {
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
> +	rtase_interrupt(pdev->irq, dev);
> +	enable_irq(pdev->irq);
> +}
> +#endif
> +
> +static void rtase_mbx_set_vfmc(const struct rtase_private *tp, u8 vfn)
> +{
> +	const void __iomem *ioaddr = tp->mmio_addr;
> +
> +	tp->vf_info[vfn].mc_filter[0] = RTL_R32(VFMSGDATA_0 + (vfn * 8u));
> +	tp->vf_info[vfn].mc_filter[1] = RTL_R32(VFMSGDATA_2 + (vfn * 8u));
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
> +				RTL_W8(PFMSGVF1 + (i * 4u), (RTL_R8(PFMSGVF1 + (i * 4u)) | BIT(1)));
> +			}
> +		}
> +		rtase_set_mar(tp);
> +	}
> +
> +	RTL_W8(PFMSGICRREQ, status);
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
> +	tp->int_vector[0].imr = ROK | RDU | TOK | MBX | TOK4 | TOK5 | TOK6 | TOK7;
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
> +		tp->int_vector[i].imr = Q_ROK | Q_RDU | Q_TOK;
> +		INIT_LIST_HEAD(&tp->int_vector[i].ring_list);
> +		tp->int_vector[i].weight = RTASE_NAPI_WEIGHT;
> +		tp->int_vector[i].poll = rtase_poll;
> +		netif_napi_add(tp->dev, &tp->int_vector[i].napi, tp->int_vector[i].poll,
> +			       tp->int_vector[i].weight);
> +		napi_enable(&tp->int_vector[i].napi);
> +	}
> +}
> +
> +static void rtase_init_software_variable(struct rtase_private *tp)
> +{
> +	spin_lock_init(&tp->lock);
> +
> +	/* assign module parameters */
> +	tp->tx_queue_ctrl = txq_ctrl;
> +	tp->func_tx_queue_num = func_txq_num;
> +	tp->func_rx_queue_num = func_rxq_num;
> +	tp->int_nums = interrupt_num;
> +	tp->tx_int_mit = TX_INT_MITIGATION;
> +	tp->rx_int_mit = RX_INT_MITIGATION;
> +
> +	tp->sw_flag = 0;
> +	tp->num_vfs = 0;
> +
> +	/* new, interrutp variables init */
> +	rtase_init_int_vector(tp);
> +
> +	tp->max_jumbo_frame_size = rtl_chip_info[tp->mcfg].jumbo_frame_sz;
> +	/* MTU range: 60 - hw-specific max */
> +	tp->dev->min_mtu = ETH_ZLEN;
> +	tp->dev->max_mtu = tp->max_jumbo_frame_size;
> +
> +	INIT_WORK(&tp->msg_work, rtase_msg_work);
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
> +static void rtase_hw_address_set(struct net_device *dev, const u8 mac_addr[ETH_ALEN])
> +{
> +	eth_hw_addr_set(dev, mac_addr);
> +}
> +
> +static void rtase_get_mac_address(struct net_device *dev)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	const void __iomem *ioaddr = tp->mmio_addr;
> +	u8 mac_addr[ETH_ALEN];
> +	u32 i;
> +
> +	for (i = 0; i < ETH_ALEN; i++)
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
> +	memcpy(tp->org_mac_addr, dev->dev_addr, ETH_ALEN);
> +	memcpy(dev->perm_addr, dev->dev_addr, dev->addr_len);
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
> +	u32 rar_high = 0;
> +	u32 rar_low = 0;
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
> +	RTL_W16(LBK_CTRL, (LBK_ATLD | LBK_CLR));
> +}
> +
> +/******************************************************************************
> + * Ethtool Operations
> + ******************************************************************************/
> +static void rtase_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *drvinfo)
> +{
> +	const struct rtase_private *tp = netdev_priv(dev);
> +
> +	strscpy(drvinfo->driver, KBUILD_MODNAME, 32);
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
> +	u32 advertising = 0;
> +	u32 supported = 0;
> +	u32 speed = 0;
> +	u16 value = 0;
> +
> +	supported |= SUPPORTED_MII | SUPPORTED_Pause;
> +
> +	advertising |= ADVERTISED_MII;
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
> +		advertising |= ADVERTISED_Pause;
> +	else if ((value & FORCE_TXFLOW_EN) != 0u)
> +		advertising |= ADVERTISED_Asym_Pause;
> +	else if ((value & FORCE_RXFLOW_EN) != 0u)
> +		advertising |= (ADVERTISED_Pause | ADVERTISED_Asym_Pause);
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
> +	value &= ~(FORCE_TXFLOW_EN | FORCE_RXFLOW_EN);
> +
> +	if (pause->tx_pause == 1u)
> +		value |= FORCE_TXFLOW_EN;
> +
> +	if (pause->rx_pause == 1u)
> +		value |= FORCE_RXFLOW_EN;
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
> +	switch (stringset) {
> +	case ETH_SS_STATS:
> +		memcpy(data, *rtase_gstrings, sizeof(rtase_gstrings));
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
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		ret = ARRAY_SIZE(rtase_gstrings);
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
> +	unsigned long flags;
> +	dma_addr_t paddr;
> +
> +	ASSERT_RTNL();
> +
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
> +static s32 rtase_alloc_msix(struct pci_dev *pdev, struct rtase_private *tp)
> +{
> +	s32 rc = 0;
> +	u16 i = 0;
> +
> +	memset(tp->msix_entry, 0x0, NUM_MSIX * sizeof(struct msix_entry));
> +	for (i = 0u; i < NUM_MSIX; i++)
> +		tp->msix_entry[i].entry = i;
> +
> +	rc = pci_enable_msix_range(pdev, tp->msix_entry, tp->int_nums, tp->int_nums);
> +
> +	if (rc == tp->int_nums) {
> +		for (i = 0u; i < tp->int_nums; i++) {
> +			tp->int_vector[i].irq = pci_irq_vector(pdev, i);
> +			tp->int_vector[i].status = 1;
> +		}
> +	}
> +
> +	return rc;
> +}
> +
> +static s32 rtase_alloc_interrupt(struct pci_dev *pdev, struct rtase_private *tp)
> +{
> +	s32 rc = 0;
> +
> +	rc = rtase_alloc_msix(pdev, tp);
> +	if (rc != tp->int_nums) {
> +		rc = pci_enable_msi(pdev);
> +		if (rc != 0)
> +			dev_err(&pdev->dev, "unable to alloc interrupt.(MSI)\n");
> +		else
> +			tp->sw_flag |= SWF_MSI_ENABLED;
> +	} else {
> +		tp->sw_flag |= SWF_MSIX_ENABLED;
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
> +	struct rtase_private *tp;
> +	struct net_device *dev;
> +	void __iomem *ioaddr;
> +	int rc = -ENOMEM;
> +
> +	assert(ioaddr_out);
> +
> +	/* dev zeroed in alloc_etherdev */
> +	dev = alloc_etherdev_mq(sizeof(struct rtase_private), func_txq_num);
> +	if (!dev)
> +		goto err_out;
> +
> +	SET_NETDEV_DEV(dev, &pdev->dev);
> +	tp = netdev_priv(dev);
> +	tp->dev = dev;
> +
> +	/* enable device (incl. PCI PM wakeup and hotplug setup) */
> +	rc = pci_enable_device(pdev);
> +	if (rc < 0)
> +		goto err_out_free_dev;
> +
> +	/* make sure PCI base addr 1 is MMIO */
> +	if ((pci_resource_flags(pdev, 2) & IORESOURCE_MEM) == 0u) {
> +		rc = -ENODEV;
> +		goto err_out_disable;
> +	}
> +
> +	/* check for weird/broken PCI region reporting */
> +	if (pci_resource_len(pdev, 2) < RTASE_REGS_SIZE) {
> +		rc = -ENODEV;
> +		goto err_out_disable;
> +	}
> +
> +	rc = pci_request_regions(pdev, KBUILD_MODNAME);
> +	if (rc < 0)
> +		goto err_out_disable;
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
> +	void __iomem *ioaddr = NULL;
> +	struct rtase_private *tp;
> +	int rc;
> +
> +	if ((pdev->is_physfn == 0u) && (pdev->is_virtfn != 0u)) {
> +		pr_info("This module does not support a virtual function.");
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	pr_info("Automotive Switch Ethernet driver loaded\n");
> +
> +	rc = rtase_init_board(pdev, &dev, &ioaddr);
> +	if (rc != 0)
> +		goto out;
> +
> +	tp = netdev_priv(dev);
> +	tp->mmio_addr = ioaddr;
> +	tp->pdev = pdev;
> +	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
> +	if (!dev->tstats)
> +		goto err_out_1;
> +
> +	rtase_init_software_variable(tp);
> +	rtase_init_hardware(tp);
> +
> +	rc = rtase_alloc_interrupt(pdev, tp);
> +	if (rc < 0)
> +		pr_err("unable to alloc MSIX/MSI\n");
> +
> +	rtase_init_netdev_ops(dev);
> +
> +	dev->watchdog_timeo = RTASE_TX_TIMEOUT;
> +	dev->irq = pdev->irq;
> +	dev->base_addr = (unsigned long)ioaddr;
> +
> +	dev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
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
> +	rtase_get_mac_address(dev);
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
> +	netdev_info(dev, "%s, %pM, IRQ %d\n", dev->name, dev->dev_addr, dev->irq);
> +
> +	netif_carrier_off(dev);
> +
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
> +	tp->rx_buf_sz = (mtu > ETH_DATA_LEN) ? (mtu + ETH_HLEN + 8u + 1u) : RX_BUF_SIZE;
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
> +	s32 retval = 0;
> +	u32 i = 0;
> +
> +	/* Rx and Tx descriptors needs 256 bytes alignment.
> +	 * dma_alloc_coherent provides more.
> +	 */
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
> +	struct rtase_int_vector *ivec = &tp->int_vector[0];
> +	const struct pci_dev *pdev = tp->pdev;
> +	int retval;
> +	u16 i;
> +
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
> +	netdev_info(dev, PFX "%s: link up\n", dev->name);
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
> +	static const s32 multicast_filter_limit = 32;
> +	struct rtase_private *tp = netdev_priv(dev);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 mc_filter[2];
> +	u16 rx_mode;
> +
> +	rx_mode = (RTL_R16(RX_CONFIG_0) & ~ACCEPT_MASK);
> +
> +	if ((dev->flags & IFF_PROMISC) != 0u) {
> +		rx_mode |= ACCEPT_BROADCAST | ACCEPT_MULTICAST | ACCEPT_MYPHYS | ACCEPT_ALLPHYS;
> +		mc_filter[0] = 0xFFFFFFFFu;
> +		mc_filter[1] = 0xFFFFFFFFu;
> +	} else if ((netdev_mc_count(dev) > multicast_filter_limit)
> +		   || ((dev->flags & IFF_ALLMULTI) != 0u)) {
> +		/* Too many to filter perfectly -- accept all multicasts. */
> +		rx_mode |= ACCEPT_BROADCAST | ACCEPT_MULTICAST | ACCEPT_MYPHYS;
> +		mc_filter[0] = 0xFFFFFFFFu;
> +		mc_filter[1] = 0xFFFFFFFFu;
> +	} else {
> +		const struct netdev_hw_addr *ha;
> +
> +		rx_mode |= ACCEPT_BROADCAST | ACCEPT_MYPHYS;
> +		mc_filter[0] = 0u;
> +		mc_filter[1] = 0u;
> +
> +		/* clang-format off */
> +		netdev_for_each_mc_addr(ha, dev) {
> +			u32 bit_nr = (ether_crc(ETH_ALEN, ha->addr) >> 26);
> +
> +			mc_filter[bit_nr >> 5] |= (1u << (bit_nr & 31u));
> +			rx_mode |= ACCEPT_MULTICAST;
> +		}
> +		/* clang-format on */
> +	}
> +
> +	if ((dev->features & NETIF_F_RXALL) != 0u)
> +		rx_mode |= (ACCEPT_ERR | ACCEPT_RUNT);
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
> +	reg_data &= ~(RX_SINGLE_TAG | RX_SINGLE_FETCH);
> +	reg_data &= ~(RX_MX_DMA_MASK << RX_MX_DMA_SHIFT);
> +	reg_data |= (RX_DMA_BURST_256 << RX_MX_DMA_SHIFT);
> +	RTL_W16(RX_CONFIG_0, reg_data);
> +
> +	/* New Rx Descritpor */
> +	reg_data = RTL_R16(RX_CONFIG_1);
> +	reg_data |= RX_NEW_DESC_FORMAT_EN;
> +	reg_data |= PCIE_NEW_FLOW;
> +	/* Rx Fetch Desc Number */
> +	reg_data &= ~(RX_MAX_FETCH_DESC_MASK << RX_MAX_FETCH_DESC_SHIFT);
> +	reg_data |= (0xF << RX_MAX_FETCH_DESC_SHIFT);
> +	RTL_W16(RX_CONFIG_1, reg_data);
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
> +	RTL_W16(FCR, reg_data);
> +
> +	/* interrupt mitigation */
> +	rtase_interrupt_mitigation(tp);
> +
> +	/* Set Tx DMA burst size and Interframe Gap Time */
> +	reg_data = RTL_R32(TX_CONFIG_0);
> +	reg_data &= ~((TX_DMA_MASK << TX_DMA_SHIFT)
> +		      | (TX_INTER_FRAME_GAP_MASK << TX_INTER_FRAME_GAP_SHIFT));
> +	reg_data |= ((TX_DMA_BURST_UNLIMITED << TX_DMA_SHIFT)
> +		     | (INTERFRAMEGAP << TX_INTER_FRAME_GAP_SHIFT));
> +	RTL_W32(TX_CONFIG_0, reg_data);
> +
> +	/* New Tx Descriptor */
> +	RTL_W16(TFUN_CTRL, (RTL_R16(TFUN_CTRL) | TX_NEW_DESC_FORMAT_EN));
> +
> +	/* Tx Fetch Desc Number */
> +	RTL_W8(TDFNR, 0x10);
> +
> +	/* tag num select */
> +	reg_data = RTL_R16(MTPS);
> +	reg_data &= ~(0x7u << 8);
> +	reg_data |= (0x4u << 8);
> +	RTL_W16(MTPS, reg_data);
> +
> +	/* Tx queue numbers */
> +	reg_data = RTL_R16(TX_CONFIG_1);
> +	reg_data &= ~(0x3u << 10);
> +	switch (tp->tx_queue_ctrl) {
> +	case 1:
> +		break;
> +	case 2:
> +		reg_data |= (0x1u << 10);
> +		break;
> +	case 3:
> +	case 4:
> +		reg_data |= (0x2u << 10);
> +		break;
> +	default:
> +		reg_data |= (0x3u << 10);
> +		break;
> +	}
> +	RTL_W16(TX_CONFIG_1, reg_data);
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
> +	reg_data |= (FORCE_TXFLOW_EN | FORCE_RXFLOW_EN);
> +	RTL_W16(CPLUS_CMD, reg_data);
> +	/* Set Near FIFO Threshold - rx missed issue. */
> +	RTL_W16(RFIFONFULL, 0x190);
> +
> +	RTL_W16(RMS, tp->rx_buf_sz);
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
> +
> +	rtase_nic_enable(dev);
> +	rtase_enable_hw_interrupt(tp);
> +}
> +
> +static int rtase_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if ((tp->sw_flag & SWF_SRIOV_ENABLED) != 0u) {
> +		ret = -EPERM;
> +		goto err_out;
> +	}
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +	dev->mtu = new_mtu;
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
> +	u32 eor = le32_to_cpu(desc->desc_cmd.opts1) & RING_END;
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
> +	skb_reserve(skb, RTK_RX_ALIGN);
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
> +	const struct rtase_private *tp = ring->ivec->tp;
> +	rx_desc *desc;
> +	u32 i;
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
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	const struct rtase_ring *ring;
> +	u16 cmd = 0;
> +	u16 i = 0;
> +
> +	for (i = 0u; i < tp->func_tx_queue_num; i++) {
> +		ring = &tp->tx_ring[i];
> +
> +		RTL_W32(TX_DESC_START_ADDR0, (u32)(ring->phy_addr & DMA_BIT_MASK(32)));
> +		RTL_W32(TX_DESC_START_ADDR4, (u32)(ring->phy_addr >> 32));
> +		cmd = i | TX_DESC_CMD_WE | TX_DESC_CMD_CS;
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
> +	struct rtase_ring *ring = &tp->tx_ring[idx];
> +	tx_desc *desc;
> +	u32 i = 0;
> +
> +	memset(ring->desc, 0x0, RTASE_TX_RING_DESC_SIZE);
> +	memset(ring->skbuff, 0x0, (NUM_DESC * sizeof(struct sk_buff *)));
> +	ring->cur_idx = 0;
> +	ring->dirty_idx = 0;
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
> +	struct rtase_ring *ring = &tp->rx_ring[idx];
> +	u16 i = 0;
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
> +	s32 rc = 0;
> +	u16 i = 0;
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
> +	const struct rtase_private *tp = ring->ivec->tp;
> +	struct net_device *dev = tp->dev;
> +	u32 i;
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
> +	struct rtase_ring *ring;
> +	u16 i;
> +
> +	for (i = 0u; i < tp->func_tx_queue_num; i++) {
> +		ring = &tp->tx_ring[i];
> +		rtase_tx_clear_range(ring, ring->dirty_idx, NUM_DESC);
> +		ring->cur_idx = 0;
> +		ring->dirty_idx = 0;
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
> +}
> +
> +static void rtase_tx_timeout(struct net_device *dev, unsigned int txqueue)
> +{
> +	rtase_sw_reset(dev);
> +}
> +
> +static s32 rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *skb, u32 opts1, u32 opts2)
> +{
> +	const struct skb_shared_info *info = skb_shinfo(skb);
> +	const struct rtase_private *tp = ring->ivec->tp;
> +	const u8 nr_frags = info->nr_frags;
> +	u32 cur_frag, entry;
> +	tx_desc *txd = NULL;
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
> +			status = (opts1 | len | RING_END);
> +		else
> +			status = opts1 | len;
> +
> +		if (cur_frag == (nr_frags - 1u)) {
> +			ring->skbuff[entry] = skb;
> +			status |= TX_LAST_FRAG;
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
> +	rc = cur_frag;
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
> +	u8 ip_protocol;
> +
> +	switch (vlan_get_protocol(skb)) {
> +	case htons(ETH_P_IP):
> +		csum_cmd = TX_IPCS_C;
> +		ip_protocol = ip_hdr(skb)->protocol;
> +		break;
> +
> +	case htons(ETH_P_IPV6):
> +		csum_cmd = TX_IPV6F_C;
> +		ip_protocol = ipv6_hdr(skb)->nexthdr;
> +		break;
> +
> +	default:
> +		ip_protocol = IPPROTO_RAW;
> +		break;
> +	}
> +
> +	if (ip_protocol == IPPROTO_TCP)
> +		csum_cmd |= TX_TCPCS_C;
> +	else if (ip_protocol == IPPROTO_UDP)
> +		csum_cmd |= TX_UDPCS_C;
> +	else
> +		WARN_ON_ONCE(1);
> +
> +	csum_cmd |= skb_transport_offset(skb) << TCPHO_SHIFT;
> +
> +	return csum_cmd;
> +}
> +
> +static unsigned int rtase_tx_avail(struct rtase_ring *ring)
> +{
> +	return READ_ONCE(ring->dirty_idx) + NUM_DESC - READ_ONCE(ring->cur_idx) - 1;
> +}
> +
> +static netdev_tx_t rtase_start_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct skb_shared_info *shinfo = skb_shinfo(skb);
> +	struct rtase_private *tp = netdev_priv(dev);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 q_idx, entry, len, opts1, opts2;
> +	u32 mss = shinfo->gso_size;
> +	struct rtase_ring *ring;
> +	unsigned long flags;
> +	dma_addr_t mapping;
> +	tx_desc *txd;
> +	s32 frags;
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +
> +	/* multiqueues */
> +	q_idx = skb_get_queue_mapping(skb);
> +	ring = &tp->tx_ring[q_idx];
> +
> +	if (unlikely(rtase_tx_avail(ring) < shinfo->nr_frags)) {
> +		if (net_ratelimit())
> +			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
> +		goto err_stop;
> +	}
> +
> +	entry = ring->cur_idx % NUM_DESC;
> +	txd = ring->desc + (sizeof(tx_desc) * entry);
> +
> +	opts1 = DESC_OWN;
> +	opts2 = rtase_tx_vlan_tag(tp, skb);
> +
> +	/* TCP Segmentation Offload (or TCP Large Send) */
> +	if (mss) {
> +		if (shinfo->gso_type & SKB_GSO_TCPV4) {
> +			opts1 |= GIANT_SEND_V4;
> +		} else if (shinfo->gso_type & SKB_GSO_TCPV6) {
> +			if (skb_cow_head(skb, 0))
> +				goto err_dma_0;
> +
> +			tcp_v6_gso_csum_prep(skb);
> +			opts1 |= GIANT_SEND_V6;
> +		} else {
> +			WARN_ON_ONCE(1);
> +		}
> +
> +		opts1 |= skb_transport_offset(skb) << GTTCPHO_SHIFT;
> +		opts2 |= mss << 18;
> +	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		opts2 |= rtase_tx_csum(skb, dev);
> +	}
> +
> +	frags = rtase_xmit_frags(ring, skb, opts1, opts2);
> +	if (unlikely(frags < 0))
> +		goto err_dma_0;
> +
> +	if (frags) {
> +		len = skb_headlen(skb);
> +		opts1 |= TX_FIRST_FRAG;
> +	} else {
> +		len = skb->len;
> +		ring->skbuff[entry] = skb;
> +		opts1 |= (TX_FIRST_FRAG | TX_LAST_FRAG);
> +	}
> +
> +	if ((((entry + 1u) % NUM_DESC) == 0u))
> +		opts1 |= (len | RING_END);
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
> +	WRITE_ONCE(ring->cur_idx, ring->cur_idx + frags + 1u);
> +
> +	/* set polling bit */
> +	RTL_W8(TPPOLL, BIT(ring->index));
> +
> +	if (rtase_tx_avail(ring) < MAX_SKB_FRAGS) {
> +		netif_stop_queue(dev);
> +		/* make sure cur_idx and dirty_idx have been updated */
> +		smp_rmb();
> +		if (rtase_tx_avail(ring) >= MAX_SKB_FRAGS)
> +			netif_wake_queue(dev);
> +	}
> +
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +	return NETDEV_TX_OK;
> +
> +err_dma_1:
> +	ring->skbuff[entry] = NULL;
> +	rtase_tx_clear_range(ring, ring->cur_idx + 1u, frags);
> +
> +err_dma_0:
> +	dev->stats.tx_dropped++;
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +	dev_kfree_skb_any(skb);
> +	return NETDEV_TX_OK;
> +
> +err_stop:
> +	netif_stop_queue(dev);
> +	dev->stats.tx_dropped++;
> +	spin_unlock_irqrestore(&tp->lock, flags);
> +	return NETDEV_TX_BUSY;
> +}
> +
> +static s32 tx_handler(struct rtase_ring *ring, s32 budget)
> +{
> +	const struct rtase_private *tp = ring->ivec->tp;
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	struct net_device *dev = tp->dev;
> +	s32 workdone = 0;
> +	u32 dirty_tx;
> +	u32 tx_left;
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
> +		if (netif_queue_stopped(dev) && (rtase_tx_avail(ring) >= MAX_SKB_FRAGS))
> +			netif_wake_queue(dev);
> +
> +		/* make sure the index has been updated */
> +		smp_rmb();
> +		if (ring->cur_idx != dirty_tx)
> +			RTL_W8(TPPOLL, BIT(ring->index));
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
> +	if (pkt_size < rx_copybreak) {
> +		struct sk_buff *skb;
> +
> +		skb = RTL_ALLOC_SKB_INTR(ivec->napi, (pkt_size + RTK_RX_ALIGN));
> +		if (skb) {
> +			const u8 *p_sk_buff_data;
> +
> +			p_sk_buff_data = p_sk_buff[0]->data;
> +			skb_reserve(skb, RTK_RX_ALIGN);
> +			prefetch(p_sk_buff_data - RTK_RX_ALIGN);
> +			memcpy(skb->data, p_sk_buff_data, pkt_size);
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
> +	u32 pkt_size, cur_rx, delta, entry, status;
> +	struct net_device *dev = tp->dev;
> +	struct sk_buff *skb;
> +	s32 workdone = 0;
> +	rx_desc *desc;
> +
> +	if (!ring->desc)
> +		goto rx_out;
> +
> +	cur_rx = ring->cur_idx;
> +	entry = cur_rx % NUM_DESC;
> +	desc = ring->desc + (sizeof(rx_desc) * entry);
> +
> +	do {
> +		/* make sure discriptor has been updated */
> +		rmb();
> +		status = le32_to_cpu(desc->desc_status.opts1);
> +
> +		if (status & DESC_OWN)
> +			break;
> +
> +		if (unlikely(status & RX_RES)) {
> +			if (net_ratelimit())
> +				netdev_warn(dev, "Rx ERROR. status = %08x\n", status);
> +
> +			dev->stats.rx_errors++;
> +
> +			if (status & (RX_RWT | RX_RUNT))
> +				dev->stats.rx_length_errors++;
> +
> +			if (status & RX_CRC)
> +				dev->stats.rx_crc_errors++;
> +
> +			if (dev->features & NETIF_F_RXALL)
> +				goto process_pkt;
> +
> +			rtase_mark_to_asic(desc, tp->rx_buf_sz);
> +			goto out;
> +		}
> +
> +process_pkt:
> +		pkt_size = status & GENMASK(13, 0);
> +		if (likely(!(dev->features & NETIF_F_RXFCS)))
> +			pkt_size -= ETH_FCS_LEN;
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
> +		if (skb->pkt_type == PACKET_MULTICAST)
> +			dev->stats.multicast++;
> +
> +		if (rtase_rx_vlan_skb(desc, skb) < 0)
> +			rtase_rx_skb(ring, skb);
> +
> +		dev->stats.rx_bytes += pkt_size;
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
> +	if ((delta == 0u) && (workdone != 0))
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
> +	if (((ring->dirty_idx + NUM_DESC) == ring->cur_idx))
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
> +	s32 handled = 0;
> +	u32 status;
> +
> +	do {
> +		status = RTL_R32(ivec->isr_addr);
> +
> +		if ((status & MBX) != 0u)
> +			queue_work(work_queue, &tp->msg_work);
> +
> +#ifdef RTLDBG
> +		if (status & RDU)
> +			netdev_info(dev, "PF receive RDU !!!!!!!!!");
> +
> +#endif
> +
> +		handled = 1;
> +		RTL_W32(ivec->imr_addr, 0x0);
> +		RTL_W32(ivec->isr_addr, (status & ~FOVW));
> +
> +		status &= ~MBX;
> +		if ((status & ivec->imr) != 0u) {
> +			if (likely(RTL_NETIF_RX_SCHEDULE_PREP(dev, &ivec->napi)))
> +				__RTL_NETIF_RX_SCHEDULE(dev, &ivec->napi);
> +		} else {
> +			RTL_W32(ivec->imr_addr, (ivec->imr & ~MBX));
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
> +	int handled = 0;
> +	u16 status;
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
> +	s32 clean_flag = 1;
> +	s32 workdone = 0;
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
> +				RTL_W16(ivec->imr_addr, ivec->imr);
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
> +			RTL_W16(FCR, (tmp | FCR_VLAN_FTR_EN));
> +
> +		/* PCPR */
> +		tmp = RTL_R16(PCPR);
> +		if ((tmp & PCPR_VLAN_FTR_EN) == 0u)
> +			RTL_W16(PCPR, (tmp | PCPR_VLAN_FTR_EN));
> +
> +	} else {
> +		/* PFCR */
> +		tmp = RTL_R16(FCR);
> +		if ((tmp & FCR_VLAN_FTR_EN) != 0u)
> +			RTL_W16(FCR, (tmp & ~FCR_VLAN_FTR_EN));
> +
> +		/* PCPR */
> +		tmp = RTL_R16(PCPR);
> +		if ((tmp & PCPR_VLAN_FTR_EN) == 0u)
> +			RTL_W16(PCPR, (tmp & ~PCPR_VLAN_FTR_EN));
> +	}
> +}
> +
> +static int rtase_vlan_rx_add_vid(struct net_device *dev, __be16 protocol, u16 vid)
> +{
> +	struct rtase_private *tp = netdev_priv(dev);
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 tmp_mem = 0;
> +	int ret = 0;
> +	u16 i = 0u;
> +
> +	if (be16_to_cpu(protocol) != ETH_P_8021Q) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* vlan filter table */
> +	for (i = 0u; i < VLAN_FILTER_ENTRY_NUM; i++) {
> +		if ((tp->vlan_filter_ctrl & BIT(i)) == 0u) {
> +			tp->vlan_filter_ctrl |= BIT(i);
> +			tp->vlan_filter_vid[i] = vid;
> +			RTL_W32((VLAN_ENTRY_0 + (i * 4u)), (vid | VLAN_ENTRY_CAREBIT));
> +
> +			tmp_mem = RTL_R16((VLAN_ENTRY_MEM_0 + ((i / 2u) * 2u)));
> +			tmp_mem |= (0x1u << ((i % 2u) * 8u));
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
> +	u16 tmp_mem = 0u;
> +	u16 i = 0u;
> +	s32 rc = 0;
> +
> +	if (be16_to_cpu(protocol) != ETH_P_8021Q) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* vlan filter table */
> +	for (i = 0u; i < VLAN_FILTER_ENTRY_NUM; i++) {
> +		if (tp->vlan_filter_vid[i] == vid) {
> +			tp->vlan_filter_ctrl &= ~BIT(i);
> +			tp->vlan_filter_vid[i] = 0;
> +			RTL_W32((VLAN_ENTRY_0 + (i * 4u)), 0);
> +
> +			tmp_mem = RTL_R16((VLAN_ENTRY_MEM_0 + ((i / 2u) * 2u)));
> +			tmp_mem &= (~(0x1u << ((i % 2u) * 8u)));
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
> +	u32 idle = tp->tx_qos[queue].idleslope * RTASE_1T_CLOCK;
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u32 regV = 0;
> +	u32 i = 0;
> +
> +	regV = idle / RTASE_1T_POWER;
> +	regV <<= RTASE_IDLESLOPE_INT_SHIFT;
> +	idle %= RTASE_1T_POWER;
> +	for (i = 0; i < RTASE_IDLESLOPE_INT_SHIFT; i++) {
> +		idle *= 2u;
> +		if ((idle / RTASE_1T_POWER) == 1u)
> +			regV |= (0x1u << (RTASE_IDLESLOPE_INT_SHIFT - i - 1u));
> +
> +		idle %= RTASE_1T_POWER;
> +	}
> +	RTL_W32((TXQCRDT_0 + (queue * 4u)), regV);
> +}
> +
> +static int rtase_setup_tc_cbs(struct rtase_private *tp, const struct tc_cbs_qopt_offload *qopt)
> +{
> +	u32 queue = qopt->queue;
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
> +	.name = KBUILD_MODNAME,
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
> +static int __init rtase_init_module(void)
> +{
> +	int ret = 0;
> +
> +	work_queue = create_singlethread_workqueue("rtase_work_queue");
> +	if (!work_queue) {
> +		ret = -ENOMEM;
> +	} else {
> +		ret = pci_register_driver(&rtase_pci_driver);
> +		if (ret != 0) {
> +			destroy_workqueue(work_queue);
> +			pr_alert("rtase_pci_driver register failed.");
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void __exit rtase_cleanup_module(void)
> +{
> +	pci_unregister_driver(&rtase_pci_driver);
> +	destroy_workqueue(work_queue);
> +}
> +
> +module_init(rtase_init_module);
> +module_exit(rtase_cleanup_module);
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_sriov.c b/drivers/net/ethernet/realtek/rtase/rtase_sriov.c
> new file mode 100644
> index 000000000000..420c15cddbc3
> --- /dev/null
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_sriov.c
> @@ -0,0 +1,318 @@
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
> +	tp->vf_info = kcalloc(num_vfs, sizeof(struct vf_info), GFP_KERNEL);
> +	if (!tp->vf_info)
> +		ret = -ENOMEM;
> +	else
> +		tp->num_vfs = num_vfs;
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
> +	sriov_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
> +
> +	if (sriov_pos == 0) {
> +		netdev_warn(tp->dev, "\tcan't find sriov position.");
> +	} else {
> +		pci_read_config_word(pdev, sriov_pos + PCI_SRIOV_VF_DID, &vf_id);
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
> +			if (++index >= tp->num_vfs)
> +				break;
> +		}
> +	}
> +}
> +
> +static void rtase_sriov_hw_settings(struct rtase_private *tp)
> +{
> +	void __iomem *ioaddr = tp->mmio_addr;
> +	u16 tmp_reg = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tp->lock, flags);
> +	if (tp->num_vfs != 0u) {
> +		/* select rxq number */
> +		tmp_reg = RTL_R16(VQCTRL);
> +		tmp_reg &= ~(0x7u << 2u);
> +		if (tp->num_vfs == 1u)
> +			tmp_reg |= (0x3u << 2u);
> +		else if (tp->num_vfs <= 3u)
> +			tmp_reg |= (0x4u << 2u);
> +		else
> +			tmp_reg |= (0x5u << 2u);
> +
> +		RTL_W16(VQCTRL, tmp_reg);
> +		netdev_info(tp->dev, "VQCTRL = %04x", RTL_R16(VQCTRL));
> +
> +		/* Mailbox interrupt mask */
> +		RTL_W8(PFMSGIMR, 0x7F);
> +
> +		tp->sw_flag |= SWF_SRIOV_ENABLED;
> +	} else {
> +		/* restore rxq number TBD: restore PF rxq */
> +		tmp_reg = RTL_R16(VQCTRL);
> +		tmp_reg &= ~(0x7u << 2u);
> +		tmp_reg |= (0x2u << 2u);
> +		RTL_W16(VQCTRL, tmp_reg);
> +		netdev_info(tp->dev, "VQCTRL = %04x", RTL_R16(VQCTRL));
> +
> +		/* Mailbox interrupt mask */
> +		RTL_W8(PFMSGIMR, 0x0);
> +
> +		tp->sw_flag &= ~SWF_SRIOV_ENABLED;
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
> +		netdev_warn(tp->dev, "VFs are assigned !");
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
> +	u16 existed_vfs = pci_num_vf(pdev);
> +	int ret = 0;
> +
> +	if (tp->num_vfs == num_vfs)
> +		ret = -EINVAL;
> +
> +	if ((existed_vfs != 0u) && (existed_vfs != num_vfs)) {
> +		err = rtase_disable_sriov(tp);
> +		if (err != 0) {
> +			ret = err;
> +			goto out;
> +		}
> +	} else if ((existed_vfs != 0u) && (existed_vfs == num_vfs)) {
> +		ret = num_vfs;
> +		goto out;
> +	} else {
> +		netdev_warn(dev, "existed_vfs = 0\n");
> +	}
> +
> +	err = rtase_allocate_vf_data(tp, num_vfs);
> +	if (err != 0) {
> +		netdev_warn(dev, "allocate vf data failed.");
> +		ret = err;
> +		goto out;
> +	}
> +
> +	err = pci_enable_sriov(pdev, num_vfs);
> +	if (err != 0) {
> +		netdev_warn(dev, "pci_enable_sriov failed: %d\n", err);
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
> +	cr |= (FCR_BAR_EN | FCR_MAR_EN | FCR_TX_LOOPBACK_EN);
> +	RTL_W16(FCR, cr);
> +
> +	RTL_W16(LBK_CTRL, (LBK_ATLD | LBK_CLR));
> +}
> +
> +int rtase_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
> +{
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	struct rtase_private *tp = netdev_priv(dev);
> +	int ret = 0;
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
> +		netdev_warn(tp->dev, "unable to init ring\n");
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
> +	tmp = (mac[0] << 8) | mac[1];
> +	RTL_W16((VF_MAC_0 + (vf * 8)), tmp);
> +	tmp = (mac[2] << 8) | mac[3];
> +	RTL_W16((VF_MAC_2 + (vf * 8)), tmp);
> +	tmp = (mac[4] << 8) | mac[5];
> +	RTL_W16((VF_MAC_4 + (vf * 8)), tmp);
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
> +	if (vf >= tp->num_vfs) {
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
> +	if (vf >= tp->num_vfs) {
> +		netdev_warn(tp->dev, "%s...%i EINVAL", __func__, vf);
> +		ret = -EINVAL;
> +	} else {
> +		vf_info = &tp->vf_info[vf];
> +		ivi->vf = vf;
> +		memcpy(ivi->mac, vf_info->vf_mac, ETH_ALEN);
> +	}
> +
> +	return ret;
> +}
> +#endif
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_sriov.h b/drivers/net/ethernet/realtek/rtase/rtase_sriov.h
> new file mode 100644
> index 000000000000..8d1b4a49105f
> --- /dev/null
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_sriov.h
> @@ -0,0 +1,20 @@
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

