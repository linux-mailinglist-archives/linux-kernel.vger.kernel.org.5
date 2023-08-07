Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3112C77207F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjHGLP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjHGLPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:15:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358C31FCA;
        Mon,  7 Aug 2023 04:14:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686ea67195dso3073689b3a.2;
        Mon, 07 Aug 2023 04:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691406810; x=1692011610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21IzbhQ2qjGtr356saQ9/OyLk1G9ny5Nf5RhalLfvY4=;
        b=P9rgXifauC5Zfo4AGI8Tc/duItoQ62OzWivkZrp68U0630cNxUVC1JFNMayn+xcahP
         RZU9uNB2lnzsrP97yiCwzruGMWLfEwxkVxaK5SW0k1Uw38OnWOO0KvisigRyK4xoT4SV
         ykzbIkrGrxGebNQmsg00aAvVByVnLjJZLNd9SwnH+/ihU/BFgVWvc4pwgp9uuRqnyaVw
         VSs7dZBC3mkNhxig5SD5VDrgPT03aplUpzg9YBl3YE89/EoNgvuoUBg4ZH8Q3OlLJdjl
         7eEq6N68rbYn6FfkFCEkE1zEBFUWjNjsSHGhLu41WHyga0b3x7ncpTBz1NURxx/UPzHu
         UTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406810; x=1692011610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21IzbhQ2qjGtr356saQ9/OyLk1G9ny5Nf5RhalLfvY4=;
        b=as2iTK2YLpptX5sItaxDwjAjLsAlcAXZp9+o56iZZTitCYL/XoB1kS0MtI8XUopOs1
         JX5r8qE8kHnEh8MsOKe+kFdMbFrqG0O0OCtYxM6M0SHf07Y5yuyyYIcBD+Lmx6uq1n4a
         zYlCYTlfTCg0a7JS6rjH6CjBrlR4FKb094P3zv0qsqe/zqyPJ7s3bU+rMtntrbBGYrJR
         EPsYCZub/j1302XP9n8NbYxuBgFP0sGNipJ1yboW+VPEHRAPBaiC0ILMHEWw9lSGSkTv
         gqZA7VEYH2GkE/OdHISrBkCnvlo3mDMQ0v9vLAEOKR0tq/lqEWgMUPch9SlT6IPCm/PO
         wZGA==
X-Gm-Message-State: AOJu0YwL4+vpDu28ufvP7CiqRsEFMuU7eWnP4Ax0uYjCNaYDUbY6ybao
        BndlrPAgPBsUy3aQx2SF0T8=
X-Google-Smtp-Source: AGHT+IHe0gdNpfHxdLQBJS5MXgEwnuJsAsf2syMt6CcS2tr6LlNStREhwl2S8Iwzh0o1r6KeWEoPzQ==
X-Received: by 2002:a05:6a00:178c:b0:64f:aea5:7b49 with SMTP id s12-20020a056a00178c00b0064faea57b49mr10514361pfg.17.1691406809931;
        Mon, 07 Aug 2023 04:13:29 -0700 (PDT)
Received: from f38.eng.vmware.com ([66.170.99.1])
        by smtp.googlemail.com with ESMTPSA id 4-20020aa79144000000b00660d80087a8sm5939173pfi.187.2023.08.07.04.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:13:29 -0700 (PDT)
From:   Shreenidhi Shedi <yesshedi@gmail.com>
To:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu
Cc:     yesshedi@gmail.com, linux-kernel@vger.kernel.org,
        sshedi@vmware.com, linux-kbuild@vger.kernel.org
Subject: [PATCH v8 6/8] sign-file: use const with a global string constant
Date:   Mon,  7 Aug 2023 16:43:14 +0530
Message-ID: <20230807111316.315836-7-yesshedi@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807111316.315836-1-yesshedi@gmail.com>
References: <20230807111316.315836-1-yesshedi@gmail.com>
MIME-Version: 1.0
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

Reported by checkpatch.

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 scripts/sign-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index d3abc5721a7e..e8dfbdd3eea3 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -71,7 +71,7 @@ struct module_signature {
 
 #define PKEY_ID_PKCS7 2
 
-static char magic_number[] = "~Module signature appended~\n";
+static const char magic_number[] = "~Module signature appended~\n";
 
 static __attribute__((noreturn))
 void print_usage(void)
-- 
2.41.0

