Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32FA79AFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245075AbjIKVIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbjIKUYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:24:14 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE7A185
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:24:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68cc1b70e05so1221242b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694463848; x=1695068648; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn8EO86ew2G5koQdtUpUmo/smciVJt5uebn1L8KxdOg=;
        b=yg75aD32gulF/qUWkUKtX5HSQtqwioWyWHHd504pNSVg1UP9YMe0TNohP+EHO3OGt0
         PK3SRsTnyIWsEc9oFRi+/9i50O5u5MBUVUGqrz2SZmcmYpxG9qhjzzBLqkXIuM+1rDn4
         /uWTD0IORB+OxYokQXvvIpSvOJ2VCS3Rxjalj6nXaJKHf6DahdyK7yJPkA2mOeDiDG2p
         FzWhmS4WfDbQwRWbi5NYPs3X2aDccoSZKJECy+PQan7L8PkxJZ3rWpGp7h8qVEa5lrEW
         eOdQ7gp+7hA32nvGmsWfondo/GeYvCjtO9f6DcWyVDcpPmHUYv5m+zgID6EQs+Vv80za
         ivVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694463848; x=1695068648;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vn8EO86ew2G5koQdtUpUmo/smciVJt5uebn1L8KxdOg=;
        b=rp1sxHr9sO6CwERCAdw9o6IhkVc97iMNcVygZ8dghE+4wTR4FUX5OedrPmQq96/O4T
         ZR//tix/MHYZFgLFCtG2rWem7rZh3lSWEjPJbo3B4uqXpRZ0NZqGlCAON1JKJjGaxlZN
         YteQ3b/PslfXXb4FGbS7TRkChr/RUsx08U+de3HJ6TGBQp85/GFGhVUPRoHjcdZlbTLS
         wGaGQvwNWRCNDFw0MVSuXuh5brL+jyXg2JR/W18NSGZHYfJXtAo5N19MYvdlZqNPoadU
         wELbAZDptb0CnCGioY3EYsROU0bxRudzzHTmkUVgPhnFbXyecgZ5G+uOf08NQH74yvaA
         ibcA==
X-Gm-Message-State: AOJu0YzNWj8Xzr/CV2kdSA7vs6EV6lCwQAUj41KBHk9tX9Bf1+i9NKsF
        TpVqcgxMPtY6trTAsHqZudfCDKNVQuSgqsUNC46jxA==
X-Google-Smtp-Source: AGHT+IFPkHLeosFy5WqJI5fJy5plDxQV8kaXbmcc+lGJtK2nEXIQIcpuNA9vDz6qAEps1U3PMcNX5g==
X-Received: by 2002:a05:6a00:27aa:b0:68a:5954:fda4 with SMTP id bd42-20020a056a0027aa00b0068a5954fda4mr10901997pfb.1.1694463847814;
        Mon, 11 Sep 2023 13:24:07 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8-20020aa79148000000b006889081281bsm5903593pfi.138.2023.09.11.13.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 13:24:07 -0700 (PDT)
Message-ID: <93938bff-baa3-4091-85f5-784aae297a07@kernel.dk>
Date:   Mon, 11 Sep 2023 14:24:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] task_work: add kerneldoc annotation for 'data' argument
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous commit changed the arguments to task_work_cancel_match(),
but didn't document all of them.

Fixes: c7aab1a7c52b ("task_work: add helper for more targeted task_work canceling")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309120307.zis3yQGe-lkp@intel.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/kernel/task_work.c b/kernel/task_work.c
index 065e1ef8fc8d..95a7e1b7f1da 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -78,6 +78,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
  * task_work_cancel_match - cancel a pending work added by task_work_add()
  * @task: the task which should execute the work
  * @match: match function to call
+ * @data: data to be passed in to match function
  *
  * RETURNS:
  * The found work or NULL if not found.

-- 
Jens Axboe

