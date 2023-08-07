Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34AA77187D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjHGCyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHGCyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:54:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF5D19B2
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:54:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686ea67195dso2829229b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 19:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691376858; x=1691981658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HE26zhyKNkPCXPa2HwFDjRJvbDDSFlypR7DF1Gd2Ifo=;
        b=JWEja0XZ0Kwj7ox+oekYyJHCQ6ubJF9ry9lS0meVZRo3OdZxuTHwYS0VzE0G/HHl9M
         rBSb9uW+monh9++JB/pvvkW9rAetUFJFieAPsXu1x43Kq6ntht0/QbHQadZTBrY6SwfX
         c5FkPEccfvaCCKCCajQm+jkuE9Dfo8atgvwkE43KChiryWVGQ5zsazdFbI8/BSPW+WBZ
         NONeU9uSXTYUjJc2Sl4I9WsYTnlPUiL9o7cWLnpQk2HhaQ4a2i/Do4+M+1rd3y+3Fg0E
         IQR5FTNupB9k2TwWXPH8FDXsrWh+bMh6ncF1A0aUjasy/Qpr124iXwCdjadS/zbVuEr6
         KFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691376858; x=1691981658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE26zhyKNkPCXPa2HwFDjRJvbDDSFlypR7DF1Gd2Ifo=;
        b=OhQZZe04vXSLRkN38WtMEsIXDnoeWOahNK1YKkSvFDj1SzpypHi+F1SHK/dzyOVtPN
         wGIBlA8aZWYtep9S/0X0UQZzybn2LNO3t5yGikEXPlybxjKUJ906pK2K9MrBN+rqW2tV
         Yj/svn9eHJEl72d8a1hzs2bzsCMHQ4oZXvkDXH/kUrs+fR8qrBOOXQnmJPN+2xT6QT0y
         RMte/apwaP8ljUc+NjWoMaRqbgan7RXqVEdDaX4d6muNu4E9HYOmRI6gHRoDBM5ptIPQ
         KC6q6MF6r964+ngf6Nx8m581SxyUWwKGzU6Q8Czfe+OLKj4Nz6bPtRKs5m2QO6W4ojTx
         A9UQ==
X-Gm-Message-State: AOJu0YzzNJKCWr5YO7DsP7K4kbK3x1BLUa1lQP/fQo0PMrGIw2GDrQTp
        5X5L6e1gFWGLvIUkaL6G9goTbA==
X-Google-Smtp-Source: AGHT+IHQA9BMFCnntNc/Sng9MIlyD6wUYGhHHU+dM4gaCPPHxXubSxC9mcFgO4H12SIiV5tDzc8KUA==
X-Received: by 2002:a05:6a00:852:b0:687:42be:a274 with SMTP id q18-20020a056a00085200b0068742bea274mr9288145pfk.5.1691376858064;
        Sun, 06 Aug 2023 19:54:18 -0700 (PDT)
Received: from localhost ([164.70.16.189])
        by smtp.gmail.com with ESMTPSA id g10-20020a62e30a000000b0066a613c4a58sm4980480pfh.102.2023.08.06.19.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 19:54:17 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-efi@vger.kernel.org
Subject: [PATCH v8 2/5] efi: Add EFI_ACCESS_DENIED status code
Date:   Mon,  7 Aug 2023 11:53:39 +0900
Message-Id: <20230807025343.1939-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230807025343.1939-1-masahisa.kojima@linaro.org>
References: <20230807025343.1939-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the EFI_ACCESS_DENIED status code.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/linux/efi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index faea18b42c08..603bba2d6437 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -39,6 +39,7 @@
 #define EFI_WRITE_PROTECTED	( 8 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_OUT_OF_RESOURCES	( 9 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_NOT_FOUND		(14 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_ACCESS_DENIED	(15 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_TIMEOUT		(18 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_ABORTED		(21 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_SECURITY_VIOLATION	(26 | (1UL << (BITS_PER_LONG-1)))
-- 
2.30.2

