Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA34D806280
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346278AbjLEXBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEXBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:01:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874EDB5;
        Tue,  5 Dec 2023 15:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=veuA5jcJpJK6ZOBUYJpEl5tEQ5a6kyp2AU4+606vnO0=; b=Ixct9+YK621xO+NHLV3Bl7IpTW
        RD2TXwUyTf9T5SoFN4RP5+r0GpMXDSzhPaiPhIaMQj/bPyZY8YgfAj1La7E6qd2VvqGY0S1ut3BY+
        3o1iMIK9VRhWQqZUrMYqplKosgXALBP0NTTenE1BPFmFdyHsHZGbh/MXk1MOx12278cmx7N8ClhF4
        bZY55cHSyq+XQXIF4l9R2k3DUe0eZLlPMk2ROb8SYuBtIdFl9vXufyEdK4sfSwx1MdpLvFxUxbYAn
        DD6VqLrOYtaiaSw0uRZO9M4kXFcoDqWhoVUv8PmxJDdFpac5mPf0eznPqzMatOW9cDEM3hpXdGN0o
        dQ14unRA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAePZ-008ZJ8-0v;
        Tue, 05 Dec 2023 23:01:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: cr50: fix a kernel-doc warning
Date:   Tue,  5 Dec 2023 15:01:04 -0800
Message-ID: <20231205230104.414-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropn one function parameter line to prevent kernel-doc warnings.

tpm_tis_i2c_cr50.c:681: warning: Excess function parameter 'id' description in 'tpm_cr50_i2c_probe'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org
---
 drivers/char/tpm/tpm_tis_i2c_cr50.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -671,7 +671,6 @@ MODULE_DEVICE_TABLE(of, of_cr50_i2c_matc
 /**
  * tpm_cr50_i2c_probe() - Driver probe function.
  * @client:	I2C client information.
- * @id:		I2C device id.
  *
  * Return:
  * - 0:		Success.
