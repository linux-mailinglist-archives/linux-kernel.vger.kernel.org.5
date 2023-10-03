Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816717B5DFA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbjJCALd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJCALc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:11:32 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C36C6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:11:29 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3af5fd13004so244664b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 17:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696291888; x=1696896688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks1xegmL9smUxtsS+SMxje7YFeTJohysqIN7y13aErc=;
        b=P92zNgIEREdkIR6L98oatRszRF8JEa3orFWQL2QszQQpGxwa5FkODI+SNzpDFngwyo
         KiMUEFKWYdO74gco08YTk/tQc9+tpsR+waagD2SdWbwAcd9c6S9/GlbxX9O7br+5HcP0
         KCiFqowKCcSZtIQmVqLA5xhvwLUw85oi+E4SyGuNgVPz0/Xadlf73y4aDfcRIHhaguDq
         WaXhojP187TbRZu8+F+FubTF1apG0JozUen9U1cZDXqtMWzSt7ZngzxIoV0PnS724e0I
         Vw3i8b2XFWuwdI1KWKOQFMwi+nVz/LTiJNAR2/r2rPT5j2ro7CtDsekCh4NlLIcj92WI
         49QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696291888; x=1696896688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ks1xegmL9smUxtsS+SMxje7YFeTJohysqIN7y13aErc=;
        b=cJfYpmxabar4iXPFGvp0RdaJDfAv9VyYp+Q+PcF0p4qhQ5NX1xxjFUbHqsBuK/yy0v
         XBP+241rI0fxwpWm23NCpsijyzKm+9qZyzgB26JYLJSUfA7CilircXRO56B8mkhprdQK
         tsjPyxtEVqfgVU1/yafO8XTPaF9tXi/w4xAsM1gA8Sxr2eqYgDixHPq/DXl4lPtueEsk
         6AYXrGo1aRGV55GyILOq4D4gTyvmSsV+mShfdDo2bdHu+Ql+ASKC0BO3BZ2OyJFrzZBf
         qeTPbtsCGzlw4CM9FwCZnZtrqFf/d2XosDVi+/tOdKouh9iuH5Iat6Tk5kvYU3D7Te4n
         s83w==
X-Gm-Message-State: AOJu0Yw0PNVnjKjsanUxjN64AhE/TNuxpjkcs9h5RnLEJq6cXIw4/aD9
        hBOeYFzA5k2VSe5D1+cVQwMOJlY0S1rwBf7i
X-Google-Smtp-Source: AGHT+IFTWba9eUFM3rjM4kgPEDm8MwKiMQMbS/JQZLLX2yNC3re1qyZgQ3d34guFhNkiV6jeZKnnUg==
X-Received: by 2002:a05:6808:13c1:b0:3a9:a334:907e with SMTP id d1-20020a05680813c100b003a9a334907emr16317500oiw.16.1696291888591;
        Mon, 02 Oct 2023 17:11:28 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a743:e840:d142:20bb:769e:e427])
        by smtp.gmail.com with ESMTPSA id m123-20020a633f81000000b00578f697b277sm47192pga.5.2023.10.02.17.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:11:28 -0700 (PDT)
From:   Lucas Gabriel <git.send.mail@gmail.com>
X-Google-Original-From: Lucas Gabriel <g@11xx.org>
To:     felixonmars@archlinux.org
Cc:     highenthalpyh@gmail.com, kbusch@kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        xuwd1@hotmail.com, Lucas Gabriel <g@11xx.org>
Subject: [PATCH] nvme-pci: Add quirk for Netac NV7000-T
Date:   Mon,  2 Oct 2023 21:11:19 -0300
Message-ID: <20231003001119.384377-1-g@11xx.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907183605.631347-1-felixonmars@archlinux.org>
References: <20230907183605.631347-1-felixonmars@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same problem with Netac NV7000-T that also uses the MAXIO MAP1602 controller.

Adding the NVME_QUIRK_DELAY_BEFORE_CHK_RDY quirk solves it:
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2f57da12d983..d44a69b1548a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3430,6 +3430,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1f40, 0x1202),   /* Netac Technologies Co. NV3000 NVMe SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1f40, 0x1602),   /* Netac Technologies Co. NV7000-T NVMe SSD */
+		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1f40, 0x5236),   /* Netac Technologies Co. NV7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
-- 
2.42.0

