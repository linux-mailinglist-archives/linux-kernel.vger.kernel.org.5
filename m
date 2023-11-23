Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8072C7F639A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjKWQHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345384AbjKWQH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:07:27 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457CC1704
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:07:27 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a00ac0101d9so139238566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700755645; x=1701360445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m+HLaQ4LBn/sUNR9G8JbWf1oEDH+SCWwSR/AdZg4c2Y=;
        b=W7Zri+G3aiK6XVTpfVwlxAq+BWwbYCHIT1ossIXHWaainEBIyS8vASvwJSpuDzB6jg
         y+AwoWcsKRKiiJ33LPst+wzvSqDViqy9imxAkEvhrnl7pmCQzZGDYxrYcBFkpvtl1HxB
         jCKSAR2KgJ8sEEDiTgn9+NWK5dV7bqk1+fpzdl9Ld5XC/Oy4QGey1g+yVgBU+jSjstP5
         +TPOmFaxX34G/dtjD8nwxjDCZtoRHWP35ye9R1JqPIPzBKTBe/Rh/MfHACCzDZ7Y9WSC
         xKOCuC145YUudpiYpnOPXqM4ubQEU8N4oDN5clogXOYIjrTv/HUdbJo5qs15r7bUiyHp
         l/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700755645; x=1701360445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+HLaQ4LBn/sUNR9G8JbWf1oEDH+SCWwSR/AdZg4c2Y=;
        b=cYtbTBy2o1v7EjI1SpsRyAd4ZIgtf28hJFscDiFBKGQk65sDJzXtS5Rxaq1wweTJNO
         9+m3O4w8aaDRfQb1lIxxsMMKkzmEkeNw6qOUxcnsXIstYiwPLPwnzvCdx7Q49xBc9I7y
         GthKLq0zRroY+aDzKT4b3O+9UpiaX+SVaXb1/BF3tRBOjaqUOlwJylzZFfbvth5k+68G
         EAETkgO4cCj+ttZwDDEPOp/56I3fQ7K0EU7Ksmljt6r/HKtuk5JUkNVdyq3HvdDjNqgm
         4wyMFyFGtQavQod+X/y4S4SwiINuQ2u/lftv/YLdLdQAzWpCp9wNXYEmFpfpgv2svEgB
         aIzg==
X-Gm-Message-State: AOJu0YzlFLgXx8p7QNuGhnxBxf+7IQKpP6GuXFu98Ct0cygMl9MF9lm7
        R913YIRJewb1Adyzst27zcGuLg==
X-Google-Smtp-Source: AGHT+IFQndvSZg4w3rJtAcl353aA4kMN8cLIKAAKZ1SYxXym9WFmaRRbVMUT8K1eNEDWBPB5R6KVdw==
X-Received: by 2002:a17:906:19:b0:9e6:1dc9:9807 with SMTP id 25-20020a170906001900b009e61dc99807mr2768988eja.77.1700755645627;
        Thu, 23 Nov 2023 08:07:25 -0800 (PST)
Received: from 1.. ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id h21-20020a1709070b1500b00a0180de2797sm941490ejl.74.2023.11.23.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:07:24 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     pratyush@kernel.org, michael@walle.cc
Cc:     linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/2] docs: mtd: spi-nor: add sections about flash additions and testing
Date:   Thu, 23 Nov 2023 18:07:19 +0200
Message-Id: <20231123160721.64561-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=626; i=tudor.ambarus@linaro.org; h=from:subject; bh=RUUGrpTnn+dK3J0RLE96RVqrRMkZ9QBsAMu5cYh/kLM=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBlX3i4B51az5Zp+f+mQkihPnjD3/FOh65ZfsOfe LO5hsaU/3CJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZV94uAAKCRBLVU9HpY0U 6dgvB/4jv9Tw8sjK0Hr3+ZlkwR6ZRSeTFWb4Sqnu8Mu9jjD4Vj2mesXCjLdT/uVvUlAS0NEFfJQ POEmupH6KVbZ1uCcquSiT7+1b7toRJgCRKNGoV/1lmjX+9sg/2jjyWm4Q98S+qJKKmuogY1gFfh CHSG+ExydRc8n87+Tj4IjSrLdSaZGk7gj7gEdgC7MG1B5zFzyXSjhDvr43s6Pn/1GcBbeyFw4Jx H89+OrQceFSqVhgoNyb1jV85H2z66DrgXpctb+Jgoku//MRltAAdBhF91R+TCzSFW3z4h2qGEF9 MzX8jBpS5XtL60zmNynrExjwpTnGHI57xiz3gzXbUfuFXQ4h
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce guide about when to propose a new flash addition and what are
the minimum test requirements. Dropped the old documentation as it no
longer applies to the current SPI NOR framework state.

Generate the htmldoc by using ``make htmldocs`` and then find the
SPI NOR documentation at
``Documentation/output/driver-api/mtd/spi-nor.html``

Tudor Ambarus (2):
  docs: mtd: spi-nor: add sections about flash additions and testing
  docs: mtd: spi-nor: drop obsolete info

 Documentation/driver-api/mtd/spi-nor.rst | 249 +++++++++++++++++------
 1 file changed, 188 insertions(+), 61 deletions(-)

-- 
2.34.1

