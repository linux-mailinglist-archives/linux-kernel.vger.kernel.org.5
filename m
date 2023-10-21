Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A07D1C67
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjJUKPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjJUKPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:15:16 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A902BD7A
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:15:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507bd19eac8so2399698e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697883307; x=1698488107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlDFm1A0ZxnZFxu7liRZfTzTOUGufRMA62jY0m2ti70=;
        b=Cm6DVO3/G5S18qkm8vFgVgbUb+gJGCsngLXS/bdUAjMZsSOAxRxeYmWuicZGJ1WTC4
         7TK8hfbrsEnD2hkz0u1qVc7B3B6o43wfqJI5DUz8Q7sudpGq7PwVoH/f7aZVO5Gf++4Q
         BxI+XnKy0Ti2W6bPiPV7++KwVIpDhcsIrTEUPncaz0s30ZxcrqwDFrJ3IMM67o/Y21tp
         cXTiBLZyYmvuuZP6A7/7vjrHsucK1k8LIfhnjmhbBxoELocY0p7YlqdVUFzh5NNIqbPr
         daPXAZo2CmDOW86dyqJLpIMrEzNSpZ9Djz9wSnMgJdSKmeGM3sYeb82Q+yKYdYVz6xGx
         1R6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697883307; x=1698488107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlDFm1A0ZxnZFxu7liRZfTzTOUGufRMA62jY0m2ti70=;
        b=Ke6SUgIu/q0w9Kly4MjE6fxKBLggXZx3ErUCyvSAMTagPr0TRPcWnmUGgUj2pFH+s2
         l+k7Ay1GZkUF47+wzTWQ/nIylS08WO17pF6WahjcS/kieg4hYQIqheNeL6fnid8c+y69
         E08jOD09x7a/t2PRYSPqbL7UkpsvlhWnzlqQizV6WQGx0ps/N5PmisDhCehC9loBDVe2
         IzFAe8k2RnuZO7+CrxB3Kjc+flaQOIa78EBahfrieaBeacJ1Cw7z0LKFzMFGkl5tFc55
         sbNgOeqVWBqv5N0bW84+VgcpAao7DoKOHeV3UcRJS2n4Y5StFY2bz+XFhPBtaF6qeJC9
         oJMg==
X-Gm-Message-State: AOJu0YyAJd0uqQfgkEBxl+B1EiXjvFIVB0akhQLJwcYJQX0YYQAGaoz0
        qvDmgsocgusWCqMsOj/U0Mc=
X-Google-Smtp-Source: AGHT+IGllfT3vKhWR+EL0kgG+v845jM1KXqcbLEVCj1CC59eCE2TaxI7oIKfUiAmgfxy6u3DETRb7Q==
X-Received: by 2002:a05:6512:20d3:b0:503:74c:9446 with SMTP id u19-20020a05651220d300b00503074c9446mr3044220lfr.24.1697883307412;
        Sat, 21 Oct 2023 03:15:07 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id d18-20020a056512369200b005007e7211f7sm803114lfs.21.2023.10.21.03.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 03:15:05 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH v3 5/7] staging: octeon: Fix introduction of new typedef cvmx_pko_status_t in octeon
Date:   Sat, 21 Oct 2023 12:12:36 +0200
Message-Id: <20231021101238.81466-6-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231021101238.81466-1-bergh.jonathan@gmail.com>
References: <20231021101238.81466-1-bergh.jonathan@gmail.com>
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

This patch removes the introduction of a new enum typedef cvmx_pko_status_t
in the octeon driver and then fix implementations which used it.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
Changelog:                                                                 
v1 -> v2: Fix breaking change spread across multiple patches                
v2 -> v3: Break changes up into individual patches for each removed        
          typedef

 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 6c0196c1a9f6..529a75ad7c67 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -244,7 +244,7 @@ enum cvmx_pko_lock {
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
 };
 
-typedef enum {
+enum cvmx_pko_status {
 	CVMX_PKO_SUCCESS,
 	CVMX_PKO_INVALID_PORT,
 	CVMX_PKO_INVALID_QUEUE,
@@ -252,7 +252,7 @@ typedef enum {
 	CVMX_PKO_NO_MEMORY,
 	CVMX_PKO_PORT_ALREADY_SETUP,
 	CVMX_PKO_CMD_QUEUE_INIT_ERROR
-} cvmx_pko_status_t;
+};
 
 enum cvmx_pow_tag_type {
 	CVMX_POW_TAG_TYPE_ORDERED   = 0L,
@@ -1384,7 +1384,7 @@ static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
 						enum cvmx_pko_lock use_locking)
 { }
 
-static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
+static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port,
 		uint64_t queue, union cvmx_pko_command_word0 pko_command,
 		union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
 {
-- 
2.40.1

