Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0FF7EA8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjKNDCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKNDCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:02:31 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBC21BC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:02:28 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da37522a363so5289941276.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncf.edu; s=google; t=1699930948; x=1700535748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMWgF1k2ykWuu8Bjcr4iQLPBPTDTPxlZiLEGw/7iu+w=;
        b=i66m2BXxO5m2fCl6TChxLH3RK3HhkX1c9U+6fhB3huWTo2pHps72Eh9SfsPCfjNGKF
         MGahg1zOaHYCHWXRUI7RIeqxCDuvBD9WNAl8KQV+khG8laHxqoDB9GJDTfV6Z6etnWfV
         2bFesxMPwGPk4jne/ehvQaxZ4jmmkmnM2Rogc8ccg0SUWXiRN4cptodc6ORcBDs1NGLa
         nXAo/P81gpjTLI/L6LbnSTZ3QH/iL4+lCAxILi1RICeMfdHTEXfcU7/9WfNByGnK2Vyw
         cYXeazQbe3kLGXsoDS3Dn7v5uQA64MFOuIPPgElaR6I+8zk4S+BJbL71u9ZGZ+r4oiib
         tjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699930948; x=1700535748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMWgF1k2ykWuu8Bjcr4iQLPBPTDTPxlZiLEGw/7iu+w=;
        b=nKLHIKuXG67LMmP0SCRBt1Xc6JJTV/4wEXNU6x/TkcPRTnYEW5BTRe8SkKVAB/tN33
         TMiY5uYv8M2bdea7pNLLvCzsJyDUCSUP9CW5Z9DpI/SLHUlcISDXhUi0gis5ergdZWJU
         nX1gTk7AHCjfNQc2lyK/SLJs2liq060QNJ7kvuR39dLXVnUH+5CYbK5N+LK7aIlPf9jQ
         c4tRSBWnvj05LQrrlf6xqTUunNaFYq9B6QCF9jxHX6EHKv0sMvolkdLIeCVUXZfh/wt7
         4mmomc29e4/LDalQ1j6oPQEaVJF1luvoxOyfc0uR48WiVRAAp/ZOmQxIdLNO3h4C3QEq
         rhHA==
X-Gm-Message-State: AOJu0YyTUOMQ5/HVsp/ho/x1zDCyW7bXYh2Y6hcUxp3NFX5Eoq/rxUXS
        qVVFJBUi8ap6Kp1DcCSEKKTNlw==
X-Google-Smtp-Source: AGHT+IFD7KvbTb+tGl/UoCilRnSomvyyiLX7mTYIn/1QS351TQtySzpDsuxpleORlfRRWeSOhHUCBg==
X-Received: by 2002:a25:34d1:0:b0:daf:6698:89d7 with SMTP id b200-20020a2534d1000000b00daf669889d7mr6608575yba.47.1699930947775;
        Mon, 13 Nov 2023 19:02:27 -0800 (PST)
Received: from Lux.hsd1.fl.comcast.net ([2601:580:8201:d0::4174])
        by smtp.gmail.com with ESMTPSA id x6-20020a25a006000000b00daf78e2e63dsm1403315ybh.27.2023.11.13.19.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 19:02:27 -0800 (PST)
From:   Hunter Chasens <hunter.chasens18@ncf.edu>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, ardb@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hunter Chasens <hunter.chasens18@ncf.edu>
Subject: [PATCH v3 2/2] docs: admin-guide: Adds explicit target to EFI-Stub doc
Date:   Mon, 13 Nov 2023 22:02:08 -0500
Message-ID: <20231114030208.30479-2-hunter.chasens18@ncf.edu>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231114030208.30479-1-hunter.chasens18@ncf.edu>
References: <20231114030208.30479-1-hunter.chasens18@ncf.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an explicit target to efi-stub.rst so that it can be
referenced via roles in other documentation.

Note: scripts/checkpatch.pl is asking for a SPDX_LICENSE_TAG.
I believe this is under GPL2 but i'd like to confirm.

Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>
---
 Documentation/admin-guide/efi-stub.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
index 090f3a185e18..cba966338087 100644
--- a/Documentation/admin-guide/efi-stub.rst
+++ b/Documentation/admin-guide/efi-stub.rst
@@ -1,3 +1,5 @@
+.. _efi_stub:
+
 =================
 The EFI Boot Stub
 =================
-- 
2.42.1

