Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4925A792F34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjIETqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjIETqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:46:30 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0123C9C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:46:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso45306241fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 12:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693943185; x=1694547985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ry9s078EXiAMlrtPVQmJBgmFI58bw0qDCvSBdknb1Y=;
        b=Ts/fbardNvsSN+d4c6kyo4XGXowSBAUFsG9Z7Pe97ywPuwohU3gvVegtU250lNxrVE
         C9fkbw1xfQn1+y6KoBAlLwg2LTS0eEKXqkGmzajKsUm7Cd27wodADtvuGnJY7mc7ugDR
         HcejgsYLwKWL0bXGRW6DAH91P+k2UQKSRfhQUoe4JhxV8eiXyygwl3VlBoyYzqcVAr6f
         PYvOcf5DG0LcZmu82h0eV9NoXqBepKbhMJTRE03chUjlXHWgTFa9d+EvjtLxWJh985vv
         CWbL+KwCjiDCE9P2K0/1ayPLLm7EyLFxjlYLL1szcFlfGNj5InJZ6lqnu+sjKFZHrJDf
         3hQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693943185; x=1694547985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ry9s078EXiAMlrtPVQmJBgmFI58bw0qDCvSBdknb1Y=;
        b=lu6S6N9VYXiXdCrstYELg6yaBF0qI58BCGzHTugA4zIRPJa8Ifb9FFWqNZYISG5z9C
         ORqyosknbGHUh9wBulB9W3kRpRvXQ4ogekB0AUKVEmIaSk6+B0ZtutIMnB9uwIjMcQnW
         bjbglLwrjuMwuilx6IRQtkkW3OCzAEDOCHOHDhT6ky+l15yvsIp/XR0Z6M29pMgJokYA
         dch2oHq4OEUdi5fWjmwEWdQI3zJrZE3JpNwj0UL5ubi2r3Y4RqszpwcWNreiFMMAWbjL
         5t76J5tjVuE5jp+fvDLxj52Dr0uqqqMwax77cY83aXbhDEaqEvPsO9DX86PSND3S79Tg
         Vy3Q==
X-Gm-Message-State: AOJu0YwoJL/SAQwZyWSeXI+smmagmAUY2no7dqRasPAZ/cJDIxYyh5D5
        vlQXHu9PIZb0g/wrGJ4kPu4=
X-Google-Smtp-Source: AGHT+IHoPdop9hvXm0i5hBN7egzbZqC7DkozwOdI3q8cPKNtDNchLFvWIQC0Ns6sWTdVtrnfW146tQ==
X-Received: by 2002:a2e:3c13:0:b0:2bc:d7cb:8283 with SMTP id j19-20020a2e3c13000000b002bcd7cb8283mr569853lja.40.1693943184944;
        Tue, 05 Sep 2023 12:46:24 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id n20-20020a2e8794000000b002b9e65912cesm3011861lji.140.2023.09.05.12.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 12:46:24 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 1/2] staging: vme_user: Remove spurious newlines between define statements
Date:   Tue,  5 Sep 2023 21:45:51 +0200
Message-Id: <20230905194551.19146-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed spurious newlines in define statements so that defines which
should be grouped together for readability are grouped as such.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/vme_user/vme_tsi148.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
index 63f726e1811a..dbdf5dabaf90 100644
--- a/drivers/staging/vme_user/vme_tsi148.h
+++ b/drivers/staging/vme_user/vme_tsi148.h
@@ -96,13 +96,9 @@ struct tsi148_dma_entry {
 #define TSI148_PCFS_MISC0		0xC
 #define TSI148_PCFS_MBARL		0x10
 #define TSI148_PCFS_MBARU		0x14
-
 #define TSI148_PCFS_SUBID		0x28
-
 #define TSI148_PCFS_CAPP		0x34
-
 #define TSI148_PCFS_MISC1		0x3C
-
 #define TSI148_PCFS_XCAPP		0x40
 #define TSI148_PCFS_XSTAT		0x44
 
-- 
2.34.1

