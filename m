Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9778A79D717
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjILRDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjILRDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:03:13 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B484110
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:03:10 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5733aa10291so3780715eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1694538189; x=1695142989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vyG3UChShGVJO9DWooQ063oFbpwzovAkingO0YTtxfI=;
        b=OJXnNQq22ImboOsDZQKoqNBtfuBtRO5jz6p5gOZZzg8WWf6s8QNlX/gAKI/kdSQ3Px
         29PDoHqWCZxncz44rOz6to9FRHZEaTtD9GD6OUnvFqzgTQyZtCBVvmKrzERgC94AmQIe
         I3Jnjglo670ivj2EuR20knFhsfvTLFRG1WFw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538189; x=1695142989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyG3UChShGVJO9DWooQ063oFbpwzovAkingO0YTtxfI=;
        b=CxB7gHly398a7wwqEEbOKSLv7dOmP+fnyIgfdl8qdBPzHVqtDFDWK/lgJLDrOkJ1hK
         PgiIdF79YCwidpvMinWVOjnbZfyF4UmO30ql6FB8IKOvRf16bkI9V/CJvTYJQurAnKeu
         WdW5vNmsjXbFiuevVtL5IhR+ciInulVnTJGBjwvqJX3gBydDI68qYc6ILaQeEukkPJNm
         mU0bhC/NNHuFL0h3zr/r5Mb+uWkmjWZk9vVr4LHau2eDS4moplFeVzJ4172KKSlFyhzP
         U0+gmy69P33NZdk9POvb1LrY3nq1LClMXx9nYobAcaOfwhLC94hwJa+3FEt6cVXalpNr
         kerw==
X-Gm-Message-State: AOJu0Yxsn8mNQ5mToM4sV5t3qNetTsc02aYFtRexf2Q9R2leDJej95G9
        fNJR7m6Xp4JWJMctvsqwcSyJ5A==
X-Google-Smtp-Source: AGHT+IFCKe6ZKfTrhZHl95sSgIwCL7qqz010E5vDYreq+fSA6t8kfGE757Pd/hNfqIyqZBnnxuBvPA==
X-Received: by 2002:a4a:91de:0:b0:576:8c2c:c865 with SMTP id e30-20020a4a91de000000b005768c2cc865mr216156ooh.8.1694538189434;
        Tue, 12 Sep 2023 10:03:09 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id r62-20020a4a4e41000000b005707f68f78bsm4453817ooa.18.2023.09.12.10.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:03:09 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
From:   "Justin M. Forbes" <jforbes@fedoraproject.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: [PATCH v2] tpm: Fix typo in tpmrm class definition
Date:   Tue, 12 Sep 2023 12:02:47 -0500
Message-ID: <20230912170248.11007-1-jforbes@fedoraproject.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d2e8071bed0be ("tpm: make all 'class' structures const")
unfortunately had a typo for the name on tpmrm.

Fixes: d2e8071bed0b ("tpm: make all 'class' structures const")
Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
---
 drivers/char/tpm/tpm-chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 23f6f2eda84c..42b1062e33cd 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -33,7 +33,7 @@ const struct class tpm_class = {
 	.shutdown_pre = tpm_class_shutdown,
 };
 const struct class tpmrm_class = {
-	.name = "tmprm",
+	.name = "tpmrm",
 };
 dev_t tpm_devt;
 
-- 
2.41.0

