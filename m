Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BAE7B69ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbjJCNNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjJCNNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:13:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56613A3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:13:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405361bba99so8752675e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 06:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696338828; x=1696943628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvJMFPN5XnfTryJd6+O+n7ZB7bWg89FdCPQdvOsvcr4=;
        b=soAZbw6jmNVjeh6/UtRaQcV7puJBnxWddrgWrdbrVqsm8mzJR7bt/hhkAXXdLIdqOZ
         G3mSQhZOC5kJLNNUefguldj8lvAoNWcPsAtJtofVovVENH5jjy8bJZXYzhmAguCzNOVY
         NXO+CP/KPLEBQ+SGz/JUFAft3UVupfwjyli09i3uVW8ZGld4f5Y31U2VsL0/sRoK5d4X
         tD+OYGzgMO3Hgszz5VMtodd4Dvqm5GPIBLEMLTo8lWMdvSnR8xLJxfaJYW6BiIQqH3P5
         g5SiNVA3y7NBBQLbWtKHdL/n2s7sHpQ0q0+eEEo5OCmqXNvFU/yvrcjELhWaw3QSlvSs
         XFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696338828; x=1696943628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvJMFPN5XnfTryJd6+O+n7ZB7bWg89FdCPQdvOsvcr4=;
        b=Lt9fh5gvT7aej01g7Gnyhv+S43H6J45BBlxdKfhI6SMpM9DeDWyDxxsM4pBb4G46jl
         iCpMnkHX46YT7mXZwRJ56hfdVWnclTo04rdgzjnPkIEilGYQiadA8ixFQXZ/q7Foubwq
         nJM4Q2XTzJxOZN4RVFR9j/hQu0p+0zmdd/RjSH9PDorDB0E3mRz1zS4mtA6PGo11Up79
         xbNl+UjwLWgqfRG6cltwOPpDPGlqKlRn5IEIFb0V21/VbGtG6PZFIpdqXKt2lXCxG6sN
         afUO2ktXQ4NOOROEQvxBBZ+bOqjec6ngp4mfBprvi6RAT7IAx9NpC900hitARbANm4iz
         Y7CQ==
X-Gm-Message-State: AOJu0YxDPSLN6rVZdX4uLi19DQqGE71RvR3fyWqWgarIhiY9GKLYWCg1
        13mCWzWF7vdtXaIQl+kIlPg4yI5o5sJvsDAGGhqbfA==
X-Google-Smtp-Source: AGHT+IExPEFcZuoTnw4s70mC2iDssgJUPOn8skie5JIgUxQqRtwkBoV1wW0AgUE33byl9ZMwcWTAgA==
X-Received: by 2002:a05:600c:207:b0:3fe:f74c:b4f6 with SMTP id 7-20020a05600c020700b003fef74cb4f6mr13419469wmi.17.1696338827645;
        Tue, 03 Oct 2023 06:13:47 -0700 (PDT)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:6937:1bb0:405c:b59c])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0ac400b00405442edc69sm9385112wmr.14.2023.10.03.06.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 06:13:46 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] nvmem: core: Fix possible buffer overflow on nvmem cell write
Date:   Tue,  3 Oct 2023 15:13:43 +0200
Message-Id: <20231003131343.1324962-1-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing prevents a nvmem consumer to try writing excessive data to a
given nvmem cell (except when bit_offset is 0). The allocated buffer
of size 'cell->bytes' in nvmem_cell_prepare_write_buffer may not be
large enough to host the copied 'len' bytes.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/nvmem/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index eaf6a3fe8ca6..0b27ab3b3b86 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1654,6 +1654,9 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell_entry *cell,
 	int i, rc, nbits, bit_offset = cell->bit_offset;
 	u8 v, *p, *buf, *b, pbyte, pbits;
 
+	if (len > cell->bytes)
+		return ERR_PTR(-EINVAL);
+
 	nbits = cell->nbits;
 	buf = kzalloc(cell->bytes, GFP_KERNEL);
 	if (!buf)
-- 
2.34.1

