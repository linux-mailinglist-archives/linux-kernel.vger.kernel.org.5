Return-Path: <linux-kernel+bounces-17661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C32F58250DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0054EB23322
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2969B2420A;
	Fri,  5 Jan 2024 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EnNc/L5X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1CC24B27
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e3ab65709so94435e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 01:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704447194; x=1705051994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BhmvSYxR6vhCtCvCbfCNBTtIn15G9VEThG3ZBQZie7k=;
        b=EnNc/L5XW6EE5jmNpV01pMYJXJzB6Z4syaJcPJMJC0dWZoo+aOvKZNMtCF0peg+NTk
         hYs5r9s18bs/05d49T7pIF7+OghQGH/yjmQ3uB2b3+deE8iaeG1tTjMtSyceJcaqUkBH
         nQ7KVtmMaE67lciXPLFpjEySEoSbtR8W7N6EKIQy2KYKvHeI01YYk/3HaV8EUNqeHKyd
         9X5FQkTEma0iwwA8uLPvu9q5BFyu1hmU86DQcVv3HnKXMCK6F8HTOOq0kQ0NATnBrdUe
         N9qBiHT7jno9hXC6qJwZ2CS9llABgWktFbseNcISjtd3BMzEhpap6rLR9aF2HKV3KP9T
         CJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704447194; x=1705051994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhmvSYxR6vhCtCvCbfCNBTtIn15G9VEThG3ZBQZie7k=;
        b=I6UzbL3z0UoyA/2StSKW0rINz9HLfvljQXaICLfx1JrRUt25JtpTMMeHv4WrmNM7Jr
         faXC1y48eU/eUwLTXbnSSlZjJv4SLkFoE3a+9hcPrpERmaLCnRby0rtEDuYwBxLA/QCw
         JD+qq6lVmaL5QSGuvPoVnHN8iH7ieyFzH1cLE0pmRupsBUqukWEIA4u/JNitpTn6I53o
         3th9pr757HpfSbuyPdYdtM478b6V0CCiAxHTx1OZ2lfbhB96Ra7UpCp8zd6AbVUtanwE
         6x15UmBtVp4kzZUrux3uzaQCNc9p2HX3UmlZISAixUwMV2A/a1+HoZCwMfMvZa4FbbU+
         3pjg==
X-Gm-Message-State: AOJu0YzWaeyBY0/0BQEhPPOaRZUuGj/ZKIzB77Rgz49T7Jp+XzZ5OLNO
	lQA7B02wrjNtBok/2jxUdMoH4uXiuFinmA==
X-Google-Smtp-Source: AGHT+IHQwJaq9NCzpZ6NxR6UPTsdM/n3is2hCptxwXE3AKsDNWqH4kTnlWGbmfHt0lfZOsguAQC1gQ==
X-Received: by 2002:a05:600c:a0a:b0:40d:8726:100a with SMTP id z10-20020a05600c0a0a00b0040d8726100amr1076235wmp.22.1704447193740;
        Fri, 05 Jan 2024 01:33:13 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b0040d4e1393dcsm981833wmo.20.2024.01.05.01.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 01:33:13 -0800 (PST)
Date: Fri, 5 Jan 2024 10:33:11 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v15 01/13] rtase: Add pci table supported in
 this module
Message-ID: <ZZfM1yKMIpSgGWGZ@nanopsycho>
References: <20240105085737.376885-1-justinlai0215@realtek.com>
 <20240105085737.376885-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105085737.376885-2-justinlai0215@realtek.com>

Fri, Jan 05, 2024 at 09:57:25AM CET, justinlai0215@realtek.com wrote:
>Add pci table supported in this module, and implement pci_driver function
>to initialize this driver, remove this driver, or shutdown this driver.
>
>Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>---
> drivers/net/ethernet/realtek/rtase/rtase.h    | 336 ++++++++++
> .../net/ethernet/realtek/rtase/rtase_main.c   | 617 ++++++++++++++++++
> 2 files changed, 953 insertions(+)
> create mode 100644 drivers/net/ethernet/realtek/rtase/rtase.h
> create mode 100644 drivers/net/ethernet/realtek/rtase/rtase_main.c
>
>diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
>new file mode 100644
>index 000000000000..9874be9cd153
>--- /dev/null
>+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
>@@ -0,0 +1,336 @@
>+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>+/*
>+ *  rtase is the Linux device driver released for Realtek Automotive Switch
>+ *  controllers with PCI-Express interface.
>+ *
>+ *  Copyright(c) 2023 Realtek Semiconductor Corp.
>+ */
>+
>+#ifndef _RTASE_H_
>+#define _RTASE_H_
>+
>+/* the low 32 bit address of receive buffer must be 8-byte alignment. */
>+#define RTK_RX_ALIGN 8
>+
>+#define HW_VER_MASK 0x7C800000
>+
>+#define RX_DMA_BURST_256       4
>+#define TX_DMA_BURST_UNLIMITED 7
>+#define RX_BUF_SIZE            (PAGE_SIZE - \
>+				SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
>+#define MAX_JUMBO_SIZE         (RX_BUF_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN)
>+
>+/* 3 means InterFrameGap = the shortest one */
>+#define INTERFRAMEGAP 0x03
>+
>+#define RTASE_REGS_SIZE     256
>+#define RTASE_PCI_REGS_SIZE 0x100
>+
>+#define MULTICAST_FILTER_MASK  GENMASK(30, 26)
>+#define MULTICAST_FILTER_LIMIT 32
>+
>+#define RTASE_VLAN_FILTER_ENTRY_NUM 32
>+#define RTASE_NUM_TX_QUEUE 8
>+#define RTASE_NUM_RX_QUEUE 4
>+
>+#define RTASE_TXQ_CTRL      1
>+#define RTASE_FUNC_TXQ_NUM  1
>+#define RTASE_FUNC_RXQ_NUM  1
>+#define RTASE_INTERRUPT_NUM 1
>+
>+#define MITI_TIME_COUNT_MASK     GENMASK(3, 0)
>+#define MITI_TIME_UNIT_MASK      GENMASK(7, 4)
>+#define MITI_DEFAULT_TIME        128
>+#define MITI_MAX_TIME            491520
>+#define MITI_PKT_NUM_COUNT_MASK  GENMASK(11, 8)
>+#define MITI_PKT_NUM_UNIT_MASK   GENMASK(13, 12)
>+#define MITI_DEFAULT_PKT_NUM     64
>+#define MITI_MAX_PKT_NUM_IDX     3
>+#define MITI_MAX_PKT_NUM_UNIT    16
>+#define MITI_MAX_PKT_NUM         240
>+#define MITI_COUNT_BIT_NUM       4
>+
>+#define RTASE_NUM_MSIX 4
>+
>+#define RTASE_DWORD_MOD 16
>+
>+/*****************************************************************************/
>+enum rtase_registers {
>+	RTASE_MAC0   = 0x0000,
>+	RTASE_MAC4   = 0x0004,
>+	RTASE_MAR0   = 0x0008,
>+	RTASE_MAR1   = 0x000C,
>+	RTASE_DTCCR0 = 0x0010,
>+	RTASE_DTCCR4 = 0x0014,
>+#define COUNTER_RESET BIT(0)
>+#define COUNTER_DUMP  BIT(3)
>+
>+	RTASE_FCR    = 0x0018,
>+#define FCR_RXQ_MASK    GENMASK(5, 4)
>+#define FCR_VLAN_FTR_EN BIT(1)
>+
>+	RTASE_LBK_CTRL = 0x001A,
>+#define LBK_ATLD BIT(1)
>+#define LBK_CLR  BIT(0)
>+
>+	RTASE_TX_DESC_ADDR0   = 0x0020,
>+	RTASE_TX_DESC_ADDR4   = 0x0024,
>+	RTASE_TX_DESC_COMMAND = 0x0028,
>+#define TX_DESC_CMD_CS BIT(15)
>+#define TX_DESC_CMD_WE BIT(14)
>+
>+	RTASE_BOOT_CTL  = 0x6004,
>+	RTASE_CLKSW_SET = 0x6018,
>+
>+	RTASE_CHIP_CMD = 0x0037,
>+#define STOP_REQ      BIT(7)
>+#define STOP_REQ_DONE BIT(6)
>+#define RE            BIT(3)
>+#define TE            BIT(2)
>+
>+	RTASE_IMR0 = 0x0038,
>+	RTASE_ISR0 = 0x003C,
>+#define TOK7 BIT(30)
>+#define TOK6 BIT(28)
>+#define TOK5 BIT(26)
>+#define TOK4 BIT(24)
>+#define FOVW BIT(6)
>+#define RDU  BIT(4)
>+#define TOK  BIT(2)
>+#define ROK  BIT(0)
>+
>+	RTASE_IMR1 = 0x0800,
>+	RTASE_ISR1 = 0x0802,
>+#define Q_TOK BIT(4)
>+#define Q_RDU BIT(1)
>+#define Q_ROK BIT(0)
>+
>+	RTASE_EPHY_ISR = 0x6014,
>+	RTASE_EPHY_IMR = 0x6016,
>+
>+	RTASE_TX_CONFIG_0 = 0x0040,
>+#define TX_INTER_FRAME_GAP_MASK GENMASK(25, 24)
>+	/* DMA burst value (0-7) is shift this many bits */
>+#define TX_DMA_MASK             GENMASK(10, 8)
>+
>+	RTASE_RX_CONFIG_0 = 0x0044,
>+#define RX_SINGLE_FETCH  BIT(14)
>+#define RX_SINGLE_TAG    BIT(13)
>+#define RX_MX_DMA_MASK   GENMASK(10, 8)
>+#define ACPT_FLOW        BIT(7)
>+#define ACCEPT_ERR       BIT(5)
>+#define ACCEPT_RUNT      BIT(4)
>+#define ACCEPT_BROADCAST BIT(3)
>+#define ACCEPT_MULTICAST BIT(2)
>+#define ACCEPT_MYPHYS    BIT(1)
>+#define ACCEPT_ALLPHYS   BIT(0)
>+#define ACCEPT_MASK      (ACPT_FLOW | ACCEPT_ERR | ACCEPT_RUNT | \
>+			  ACCEPT_BROADCAST | ACCEPT_MULTICAST | \
>+			  ACCEPT_MYPHYS | ACCEPT_ALLPHYS)
>+
>+	RTASE_RX_CONFIG_1 = 0x0046,
>+#define RX_MAX_FETCH_DESC_MASK  GENMASK(15, 11)
>+#define RX_NEW_DESC_FORMAT_EN   BIT(8)
>+#define OUTER_VLAN_DETAG_EN     BIT(7)
>+#define INNER_VLAN_DETAG_EN     BIT(6)
>+#define PCIE_NEW_FLOW           BIT(2)
>+#define PCIE_RELOAD_En          BIT(0)

In this header, you have *a lot* of defines that are very specific to
rtase, yet they don't have the prefix so the reader can't identify them
right away. Seeing things like "ACCEPT_ERR" or "MAX_JUMBO_SIZE" might
falsely lead the reader to think this is something common throught the
kernel code.

Please pit prefix to all of these.


>+
>+	RTASE_EEM = 0x0050,
>+#define EEM_UNLOCK 0xC0
>+
>+	RTASE_TDFNR  = 0x0057,
>+	RTASE_TPPOLL = 0x0090,
>+	RTASE_PDR    = 0x00B0,
>+	RTASE_FIFOR  = 0x00D3,
>+#define TX_FIFO_EMPTY BIT(5)
>+#define RX_FIFO_EMPTY BIT(4)
>+
>+	RTASE_PCPR = 0x00D8,
>+#define PCPR_VLAN_FTR_EN BIT(6)
>+
>+	RTASE_RMS       = 0x00DA,
>+	RTASE_CPLUS_CMD = 0x00E0,
>+#define FORCE_RXFLOW_EN BIT(11)
>+#define FORCE_TXFLOW_EN BIT(10)
>+#define RX_CHKSUM       BIT(5)
>+
>+	RTASE_Q0_RX_DESC_ADDR0 = 0x00E4,
>+	RTASE_Q0_RX_DESC_ADDR4 = 0x00E8,
>+	RTASE_Q1_RX_DESC_ADDR0 = 0x4000,
>+	RTASE_Q1_RX_DESC_ADDR4 = 0x4004,
>+	RTASE_MTPS             = 0x00EC,
>+#define TAG_NUM_SEL_MASK  GENMASK(10, 8)
>+
>+	RTASE_MISC = 0x00F2,
>+#define RX_DV_GATE_EN BIT(3)
>+
>+	RTASE_TFUN_CTRL = 0x0400,
>+#define TX_NEW_DESC_FORMAT_EN BIT(0)
>+
>+	RTASE_TX_CONFIG_1 = 0x203E,
>+#define TC_MODE_MASK  GENMASK(11, 10)
>+
>+	RTASE_TOKSEL      = 0x2046,
>+	RTASE_RFIFONFULL  = 0x4406,
>+	RTASE_INT_MITI_TX = 0x0A00,
>+	RTASE_INT_MITI_RX = 0x0A80,
>+
>+	RTASE_VLAN_ENTRY_MEM_0 = 0x7234,
>+	RTASE_VLAN_ENTRY_0     = 0xAC80,
>+};
>+
>+enum desc_status_bit {
>+	DESC_OWN = BIT(31), /* Descriptor is owned by NIC */
>+	RING_END = BIT(30), /* End of descriptor ring */
>+};
>+
>+enum sw_flag_content {
>+	SWF_MSI_ENABLED  = BIT(1),
>+	SWF_MSIX_ENABLED = BIT(2),
>+};
>+
>+#define RSVD_MASK 0x3FFFC000
>+
>+struct tx_desc {

The note above also applies to enum and structs names too.


>+	__le32 opts1;
>+	__le32 opts2;
>+	__le64 addr;
>+	__le32 opts3;
>+	__le32 reserved1;
>+	__le32 reserved2;
>+	__le32 reserved3;
>+} __packed;

[...]

