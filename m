Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9247E2B6A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjKFRpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjKFRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:45:38 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB44EB7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 09:45:33 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-581e92f615fso2468386eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 09:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699292732; x=1699897532; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+A7ELOEb77dVJn4keBjmFNgvPFut5P8spAKELBqPho=;
        b=K+Eh8X2LWdAaaGzxn6MMYckRxQm1qiZ0Eg41fgpYrcRor1gxwfUkdATGrYjiMFgViN
         hTnTQCeLni+9ZgqRigkRmGd5h3wFYJYrmnshl6PprV33z88R2moFL08WC2c2e3yv1hcJ
         eQHjuvQfZvg02PZQbVB+MjYUdiXpBeRs5LQ2lmwfTYIhKpiFLsR2NlwuFWaUgdT8daKM
         tUU1iizDHxTbGsq0kNxQwUCYbuZbO0hczGQwD1h2Q8cINV1l+dLzjTwGw3X2GxMtEZTU
         hnVptERJUv5Jko/Rs75zQ3xNR8rXNH7yGMIM0aAvkO4UG83LnGTBscXS1BCZuSftFeYi
         /eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699292732; x=1699897532;
        h=content-transfer-encoding:from:content-language:subject:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G+A7ELOEb77dVJn4keBjmFNgvPFut5P8spAKELBqPho=;
        b=AUTPKqUral5A8wfiuQpJTC8ZYfLsypiJ9Zs4Un2Ncrc6Hkz+oW/IH9/BsxIZ8qfV1U
         WTOi8IGvpzw1Le2X0ei72qqy1yUNDOaRQpHZnfTJdL/rp0QW2QkBsDGABaynsZ6dLUN1
         nYyj6BrXN1Pr0XvoWLYn1+O7zTedf9fooA8VD78p7G4P6FRf76lGELCZyQ6HC7BKHZVZ
         LnMSFluUYMF2L39mcVmkJOiO47R/hTBWsbKeFeTw2d/2jCAFPWm7wk0KaQCGJ9CE7xRu
         2ejJVQkRmXgYbkKtUV/0zZ6q6UQ4X1vz7G0+ow2s6ktu4CvlSCfq7nSIFpWuj/wBxa2T
         j9Bg==
X-Gm-Message-State: AOJu0YzDbbF/9zDTfrqMS2L8jfDpN9wvHIn+PxYkSsH50z5FQCl4NXnZ
        WdsFb7NQGuTBSihUo9yRfnkHziuj4UhF9g==
X-Google-Smtp-Source: AGHT+IHqWJQBY49KSFY7A8EZl80JXMJEAVMWxX8d4xu2CS6Z46gqZw+lWNvG6Fa59gq7k1M5VXO9Ww==
X-Received: by 2002:a4a:b206:0:b0:582:28e:93a8 with SMTP id d6-20020a4ab206000000b00582028e93a8mr29228510ooo.3.1699292732318;
        Mon, 06 Nov 2023 09:45:32 -0800 (PST)
Received: from [192.168.1.4] (172-8-197-221.lightspeed.livnmi.sbcglobal.net. [172.8.197.221])
        by smtp.gmail.com with ESMTPSA id w34-20020a4a97a5000000b00581fedcb06csm1721358ooi.19.2023.11.06.09.45.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 09:45:32 -0800 (PST)
Message-ID: <c15e02b4-9add-8d8a-e22f-4ea803ec0937@gmail.com>
Date:   Mon, 6 Nov 2023 12:45:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] Fix 2 Acer FA100 SSDs from interfering in 1 PC
Content-Language: en-US
From:   Christopher Lentocha <christopherericlentocha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In order for 2 Acer FA100s to work in one PC (in
the case of myself, a Lenovo Legion T5 28IMB05),
and not show one drive and not the other, and
sometimes mix up what drive shows up, these two
lines of code need to be added, and then both of
the SSDs will show up and not conflict when
booting off of one of them, since if you boot off
of one of the SSDs without this patch, you may
randomly get into a kernel panic or initramfs if
set up, else if you do merge this patch, there
should never be problems with booting or really
anything at all.

Signed-off-by: Christopher Lentocha <christopherericlentocha@gmail.com>
---
drivers/nvme/host/pci.c | 2 ++
1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 507bc149046d..052af40bbd7f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3439,6 +3439,8 @@ static const struct pci_device_id nvme_id_table[] = {
.driver_data = NVME_QUIRK_BOGUS_NID, },
{ PCI_DEVICE(0x1cc1, 0x5350), /* ADATA XPG GAMMIX S50 */
.driver_data = NVME_QUIRK_BOGUS_NID, },
+ { PCI_DEVICE(0x1dbe, 0x5216), /* Acer/INNOGRIT FA100/5216 NVMe SSD */
+ .driver_data = NVME_QUIRK_BOGUS_NID, },
{ PCI_DEVICE(0x1dbe, 0x5236), /* ADATA XPG GAMMIX S70 */
.driver_data = NVME_QUIRK_BOGUS_NID, },
{ PCI_DEVICE(0x1e49, 0x0021), /* ZHITAI TiPro5000 NVMe SSD */
-- 
2.38.1


