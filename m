Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FFB7A0EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjINUHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjINUHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:07:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7753126BC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:07:19 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bf8b9c5ca0so22147451fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694722037; x=1695326837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ry9s078EXiAMlrtPVQmJBgmFI58bw0qDCvSBdknb1Y=;
        b=I0ozokJsqNijCtEANEa1ho2aJXy9FxQRA75ucGozr2aAR4dUb8QthExSAp4rTEYq95
         MD0Nv3i4amYqhMrnt7ub153Itzu8XVpaeA8JG/GWtfZDL2/tO6Jj6Sx2AmfYFr11Q+6D
         GyfB/3wJYtasU0Ih05iBn/3aMJgkucVdAAyt9UC5r0A2J0V0jwklR1Uh0gj6Fab8zcXf
         ZSr5V++4AWd+cBsKtol72UkGkXfphJyzwGr4EkXRMO/Gm2iZ9qLMTEPc1J9GGDfVRtTV
         5++LUyBZa3idql04kpF1EjsgJPqm4qGeTrNPM9CNJTIOW1gxq1l1Dabl5IdNEktCQ760
         hEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694722037; x=1695326837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ry9s078EXiAMlrtPVQmJBgmFI58bw0qDCvSBdknb1Y=;
        b=l/qzDroJVmYiUv13h2h9hCiFslMqQXXcK00i5nO2XaRGAAjbLYc3U8VobG6gko6ups
         QPTCnz6i/O5N4WdxNp/Fdw9M41kWDb0GrVeMYWHcN8pyuhg0We/ZIiz0aSueV8O/bJil
         HfxNuK8k/bDcUwhqr3l8iQGLcGW1CtIovvy5weIXW3a6yoe07rhNeqKxvk7kborDpguT
         JqmqweWu9X5ow4XSFeIJGqNXNnUMmln13CfRitCFQVV3iwyy/8GN7ij1RpjVe9KXGxjt
         P4UtMJ8BVsUzNiXT1dA6eq2ow8u4nHHqEbzzvUDZy27BXvtfVdvPvg5i+JZgIQG7+ESh
         jkVg==
X-Gm-Message-State: AOJu0YzzgNKKtzTGwIWxgOdUK6+0NA9fO26mzkxkPILS3s/ehJrcci7E
        1UhnwJcDTLCFISHZUsdIFmY=
X-Google-Smtp-Source: AGHT+IE4QrJGJnzm6+9tMJvwmQOMA7/wp+Mi3TzvgrT240zk3wvBoqrwBG6BW4ylOuJPXcnsKk/9Kg==
X-Received: by 2002:a05:651c:144:b0:2bc:bb46:4fc7 with SMTP id c4-20020a05651c014400b002bcbb464fc7mr5580338ljd.24.1694722037327;
        Thu, 14 Sep 2023 13:07:17 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id y16-20020a05651c021000b002b9ead74535sm418368ljn.15.2023.09.14.13.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 13:07:16 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH v2 1/2] staging: vme_user: Remove spurious newlines between define statements
Date:   Thu, 14 Sep 2023 22:05:37 +0200
Message-Id: <20230914200536.47619-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

