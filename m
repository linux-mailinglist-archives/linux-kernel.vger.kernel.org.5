Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C13076FF68
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHDLXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjHDLX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:23:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3864611B;
        Fri,  4 Aug 2023 04:23:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f38692b3so1863006b3a.2;
        Fri, 04 Aug 2023 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691148205; x=1691753005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8v1fzLuIHSkSWidT/pjD4MCOb3hYEoCKe89MymR54k=;
        b=EKLgrG5ORf5aghlNw/yZjA+YXB/01lu40hRGKKwmY3xByuVcOgIAHBjeowE+M9iDQj
         c0paVsgZA+tZ+cR8oEzoeT/6xXFA/yFIJrTsbJyCZZVYys0aOgRk/7TnynSQRRSYv3HA
         f3CwO8S70ebKKbOe/EGn9TIwvw64I2W3nlAQW1tEfyrMqrtpsuhqA/O+TWpTSBK3McYc
         HuGQYH1AHGSuRt5GvJCkOfYGm+UUi1tNok7ZujDvjHwmB31xJ0U/FOxvMBjfZztM8Pvx
         QsVNp0DzUl0JygnFrKIhzqpkO59kh1lpY32OT8l65LMn4UMxlwT8o8uX59dJuGosyWVW
         u0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691148205; x=1691753005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8v1fzLuIHSkSWidT/pjD4MCOb3hYEoCKe89MymR54k=;
        b=NAK6FkUnQcHcsYvF+xiHUqmLfoRbKKUwYTbtQhJTXvPBq/jK+sIu/vJ3FrFPS+i412
         Uagcbg5pi93t0w+xmdzEDzN7FxXK78F/RFWg8MBpUgJTPKNhkRY3RMvzI4IlYLnn7ji1
         rBg++dZsbF8CemUV3O0CitEbT1A6TfTorP/d5Kjk2WsjX6sg1UBLVk/cEJKPRoKQJJO0
         L/e9y0/M9d6RB6PifbP/zLKwKl9i7cKnmUn8nxD27ykKUPRlApYI4iMNFH4fQCx/v55K
         VDXMVx4Q1DubjlIbPDTxc4S1BKlxu5oJFkO6sVsbTGSUSuahJq11nra2XcsNLgUrvkZx
         F6AQ==
X-Gm-Message-State: AOJu0YwXhIkzg0KbOKZm2HdRNs5pUTM9ta2G7Pz6fuvn704TUOCbozJ5
        4synE0V4PLCc3dNHTENIHe7cROibuwE=
X-Google-Smtp-Source: AGHT+IGv/8f7lL56IGOF+b2qMIMq4UqHSYAXxVDH+amKA6L/tzNx2OpzCmn5wKbRokq53BV+pI7K1g==
X-Received: by 2002:a05:6a00:1409:b0:67a:a906:9edb with SMTP id l9-20020a056a00140900b0067aa9069edbmr1575297pfu.30.1691148205499;
        Fri, 04 Aug 2023 04:23:25 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-73-13.dynamic-ip.hinet.net. [36.228.73.13])
        by smtp.gmail.com with ESMTPSA id j16-20020a62e910000000b006687b4f2044sm1394890pfh.164.2023.08.04.04.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:23:25 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Hu Haowen <src.res@email.cn>, Jonathan Corbet <corbet@lwn.net>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: sparse: fix invalid link addresses
Date:   Fri,  4 Aug 2023 19:23:18 +0800
Message-Id: <20230804112320.35592-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The http and git links are invalid, replace them with valid links.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 Documentation/translations/zh_TW/sparse.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_TW/sparse.txt b/Documentation/translations/zh_TW/sparse.txt
index c9acb2c926cb..6d2d088b1060 100644
--- a/Documentation/translations/zh_TW/sparse.txt
+++ b/Documentation/translations/zh_TW/sparse.txt
@@ -66,11 +66,11 @@ __bitwise"類型。
 
 你可以從 Sparse 的主頁獲取最新的發布版本：
 
-	http://www.kernel.org/pub/linux/kernel/people/josh/sparse/
+	https://www.kernel.org/pub/software/devel/sparse/dist/
 
 或者，你也可以使用 git 克隆最新的 sparse 開發版本：
 
-	git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git
+        git://git.kernel.org/pub/scm/devel/sparse/sparse.git
 
 一旦你下載了源碼，只要以普通用戶身份運行：
 
-- 
2.34.1

