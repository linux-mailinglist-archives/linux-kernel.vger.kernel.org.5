Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF414806229
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346449AbjLEWxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346254AbjLEWxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:53:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03698B5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zE9h+EG2yFCT+gKKsKeNhjviqRADwezmTT11FG2cDbM=; b=qqXDv1UFaZLW6AULkV8PltqRwr
        fVIXNr9vBTWVfDI+tRUyABXUK3XjmUW4v5ntq1YjVUMvLjhBQHBxpYeQSaxPO0WCzYtmjdQwt9fCY
        OnEOkfzb6yR2qJMTCRTZaUnGN/5Or8bfjXhWUW3C7c7Nc3aipAb8K8qiY2zS8vmvVHvu5oyiR1GAl
        sULWedTFq6gw16SugXVJuVdNCkYj90eYGQ+oHWi91mAFS+3/lWDT5+iUcnCK8gkoQXlK897rFvqKW
        jozTd849VkZ7R19JpzJKY7/2XO30PpWRPQ43n9artfLtEPvkXwYS6meSpBTNfFpVodWugVKaWtuVX
        M+Cj6o4w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAeI9-008Ydu-1R;
        Tue, 05 Dec 2023 22:53:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH] android: binder: fix a kernel-doc enum warning
Date:   Tue,  5 Dec 2023 14:53:18 -0800
Message-ID: <20231205225324.32362-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add kernel-doc notation for @LOOP_END to prevent a kernel-doc
warning.

binder_alloc_selftest.c:76: warning: Enum value 'LOOP_END' not described in enum 'buf_end_align_type'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve Hjønnevåg <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Christian Brauner <christian@brauner.io>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
---
 drivers/android/binder_alloc_selftest.c |    4 ++++
 1 file changed, 4 insertions(+)

diff -- a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -72,6 +72,10 @@ enum buf_end_align_type {
 	 * buf1 ]|[ buf2 | buf2 | buf2 ][ ...
 	 */
 	NEXT_NEXT_UNALIGNED,
+	/**
+	 * @LOOP_END: The number of enum values in &buf_end_align_type.
+	 * It is used for controlling loop termination.
+	 */
 	LOOP_END,
 };
 
