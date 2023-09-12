Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3823F79D85C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbjILSHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbjILSHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:07:35 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C693F1715
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:07:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c337aeefbdso54314375ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694542049; x=1695146849; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=5P792u/W+uYHVAlK3Wk+WMLaaMRTUy9AL0RSgtpOHuA=;
        b=EwzTTg7f2oghWMRLDP4+qz22dbsBxBYGp9NZ1unu55hG55ai+DdBrWAMJ3aWwqEBl7
         k+25QN+xtunUtgsfIhYDfS0y8mOjAY2eePKEZSH65/r6uEpPs//gk+k2cxt48t+VjdDB
         TADZ9qa25B7sVFdfKwPW62tDVN6Ajh2x0+ZnFJg1WAaL0WYrvof6MlpcqwYcouknSi9H
         xAOHVFg1EWSYkdXl6K6fBSwyQex34A1SXBkoR0JSWXxZAxr9Oz2nRChis0b/3NxM5BLK
         Ge78x7uf9qsSf4DfJ1BauBEbyUD92cuMcRsT8z0usuok1LfaC8r8WHLS5uR10yJU7NlY
         6fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694542049; x=1695146849;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5P792u/W+uYHVAlK3Wk+WMLaaMRTUy9AL0RSgtpOHuA=;
        b=BbyOTrck++ljjMtkMA/53igkX+EBAyn5sXT4h4Hd2rYyWnzO2hN/IV6IjH3ZKMalH6
         65vHR/qVWo21dlwRU83vZEgA54MJw4VyoaIsWqk050huQP/tLb3lnMVNcN9c4tl1OMbK
         egZg0cypyOqkSnQL8lPjS1Mwx8VcIpcXcqK5Kt89zkJgtKBxwkcb9FOWVPdXHhftQaqy
         rtmT+etQ9jO47YJIAIbXYpCjGhvuOApb4MKdxvMullyHmLbYmXuTwxyZyDcr0skWb8+c
         F+oINkXxOyZDGUlUHOQMYW1wu1RxAxEQ4A3Wmqh4UMij7YZj9HtwTiJnf0nCkonjk0tF
         cknw==
X-Gm-Message-State: AOJu0Yx4LPlmtUD8EqOLDKZOPCHSQtx3FEqw8OEbtC2ao7PLTCFyN/8E
        Ju/ufO8VtvHyZNcPn1LFROX6lftRAGZ8ApJlEjE=
X-Google-Smtp-Source: AGHT+IGpM+pJjvarAfRfpZy5vCZhx9yUE6GrHEVUou3LIHgewnXUK4D3CCgLD6GhHOB6XeZsyD9kRQ==
X-Received: by 2002:a17:902:ab45:b0:1bb:1e69:28c0 with SMTP id ij5-20020a170902ab4500b001bb1e6928c0mr503326plb.30.1694542049261;
        Tue, 12 Sep 2023 11:07:29 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c14d00b001bdd51748f8sm8676588plj.271.2023.09.12.11.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 11:07:28 -0700 (PDT)
Subject: [PATCH] Documentation: embargoed-hardware-issues.rst: Add myself for RISC-V
Date:   Tue, 12 Sep 2023 11:06:56 -0700
Message-ID: <20230912180657.31841-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure exactly how RISC-V fits into the story here, but I'm happy
to voluteer a sort of catch-all for vendors who aren't otherwise
represented.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 Documentation/process/embargoed-hardware-issues.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index cb686238f21d..ac7c52f130c9 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -251,6 +251,7 @@ an involved disclosed party. The current ambassadors list:
   IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
   Intel		Tony Luck <tony.luck@intel.com>
   Qualcomm	Trilok Soni <tsoni@codeaurora.org>
+  RISC-V	Palmer Dabbelt <palmer@dabbelt.com>
   Samsung	Javier González <javier.gonz@samsung.com>
 
   Microsoft	James Morris <jamorris@linux.microsoft.com>
-- 
2.42.0

