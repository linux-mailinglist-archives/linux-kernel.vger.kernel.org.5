Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D37A778E63
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbjHKL4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbjHKL4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:56:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C93F110
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:56:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c4923195dso263889166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691755010; x=1692359810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KbOGymP7OaffTHBxIipa1qriFrse7ok8bc9+6gM8Bo=;
        b=SUJDwsnTW6pbG7vD+g67dznFE3s3+YgkqWsX1abky6jdEPQM0ziAqQujZfLELDSzP/
         Ax+pTse635fKzsGn2yquOaJDMXxbZyYmZyU/IvsKQm8u9BKU5bETs64ahDDIdxHVOGyB
         Jzrl4Z/7AVi8sKOod30vD6VWIUcYpLXF0Up0zvW/eGGY9ln5hkXVrdo+CYZnh0TzqfWJ
         mDeFdoGBUQGv7Ee70VGDfU8MqEUeTuJnJ3uwlsrCOHLSyFfZvX1oqtScIjxkjp7784hP
         vALP9lBBPkqG398pnc6QCRenNkUh07W9ax81SovmDhhN85HxgecUgQ6kAXgLqoKMQQKW
         zfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691755010; x=1692359810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KbOGymP7OaffTHBxIipa1qriFrse7ok8bc9+6gM8Bo=;
        b=LoXD+nB9V9nzAU9KvaY2LNrq3gimd5e6u8tQCUC7KrUvXzhll2x38j8NMWIBcJO5oL
         QLLb6gVEwZ5YpbNtE8D2xAJN6avYFxkKX+FRJlM+j5nDBegtU3rsjEwLRLYI/yEJS59l
         tKvg/Lau1LoXYm76WG4JFbfZY7a4vD5ytDK9GDdKpNmckoZ4obPEHIasqrjN2P7K0XUw
         WFP/N4udke66ghIdk39/KLNLwzCzaLr+NI0peXbmuFAtqLkStwTym+SfvfxZfMQSkVjY
         A6azDDqAxwRyumYtIn4m0oWRC15Q3shfhz+VB509wAwga0jjhwDOQWny8Tl4ofAMDk4u
         wZ3w==
X-Gm-Message-State: AOJu0YxtYgymyzaBJQh1F0DgcyFduCtLzu8uHQk7VppBVJN0774vXGRY
        +74ikJ8uxUtOHw49zmi58JaRZg==
X-Google-Smtp-Source: AGHT+IG0wtiSPVD2BI/rt+0tKNTU322QQvf1TbPMiyS3rD+x0owk8gamY2YX0bJwHcEi5Ivdo7cVAw==
X-Received: by 2002:a17:906:31c6:b0:994:3207:cddd with SMTP id f6-20020a17090631c600b009943207cdddmr1569351ejf.34.1691755010074;
        Fri, 11 Aug 2023 04:56:50 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f16-20020a170906561000b00992076f4a01sm2165395ejq.190.2023.08.11.04.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:56:49 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        stable <stable@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] misc: fastrpc: Fix remote heap allocation request
Date:   Fri, 11 Aug 2023 12:56:41 +0100
Message-Id: <20230811115643.38578-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811115643.38578-1-srinivas.kandagatla@linaro.org>
References: <20230811115643.38578-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

Remote heap is used by DSP audioPD on need basis. This memory is
allocated from reserved CMA memory region and is then shared with
audioPD to use it for it's functionality.

Current implementation of remote heap is not allocating the memory
from CMA region, instead it is allocating the memory from SMMU
context bank. The arguments passed to scm call for the reassignment
of ownership is also not correct. Added changes to allocate CMA
memory and have a proper ownership reassignment.

Fixes: 532ad70c6d44 ("misc: fastrpc: Add mmap request assigning for static PD pool")
Cc: stable <stable@kernel.org>
Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9666d28037e1..2faabbd12755 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1866,7 +1866,11 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 		return -EINVAL;
 	}
 
-	err = fastrpc_buf_alloc(fl, fl->sctx->dev, req.size, &buf);
+	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
+		err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
+	else
+		err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
+
 	if (err) {
 		dev_err(dev, "failed to allocate buffer\n");
 		return err;
@@ -1905,12 +1909,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	/* Add memory to static PD pool, protection thru hypervisor */
 	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
-		struct qcom_scm_vmperm perm;
-
-		perm.vmid = QCOM_SCM_VMID_HLOS;
-		perm.perm = QCOM_SCM_PERM_RWX;
-		err = qcom_scm_assign_mem(buf->phys, buf->size,
-			&fl->cctx->perms, &perm, 1);
+		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
+			&fl->cctx->perms, fl->cctx->vmperms, fl->cctx->vmcount);
 		if (err) {
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 					buf->phys, buf->size, err);
-- 
2.25.1

