Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C417D199C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjJTXYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjJTXXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:23:54 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0F3D76;
        Fri, 20 Oct 2023 16:23:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso20141011fa.0;
        Fri, 20 Oct 2023 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697844230; x=1698449030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6AsKFzmbJmMlgO7Kg4ODl3MalR7AIPucYJJTFRtUoA=;
        b=lxMBd7B0YBZxZtghAeckNLb9m2QJkOG4gmY/qd8JPSq7OHmmFUarXQNRy8dz9NF+q5
         0AmC5tB8u+7VU8pBU5Psy1L7jhT7VnmKk72Ihx92T3rfU6QNPV5PTbz/5Ah2hvLgF0g6
         aJHom4t0tMOAeR3Z7FVj3PJ6tKqBuLhJ0ZwPhFWyzrNPNCel3T+8/K6BNt7HTgIASwbP
         HzXhNvCQV6OQzE4GI5w0C7BH/ureYqoW593pGTz6hKHFqFj0aMr8j7jiFyMU0JexN0OW
         DUqeDJzMmSjIbJ7eWUQ6uYTKPnjoOJHjFcrFDelIgNMQRbxvZhjmEqiJ5CoXCgnnGLbg
         X8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697844230; x=1698449030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6AsKFzmbJmMlgO7Kg4ODl3MalR7AIPucYJJTFRtUoA=;
        b=ZVUW41WNMBTV5usEprxsEiOK5TJnCeQC9s6K09JrTf524aQFdAqG+BDNyrO0j94+kS
         lQiIxmF+Sqr56tyiGiuyj30zxWfYQH653L0S79JpB+E1UJAVUvPhV3E6MQ+JRYwNlBrM
         S/jioKj74qgFXN0EJj3BrIAJtStEhRUk2bRlVqrTMPipmjZSEvOBstNX/7UtGV3ytOZm
         /rQEyuUR05MEm1bqoRRTb+HeidCRNNchE3da3eQ6n2rmGZidrGqS8IuD7XraJetfq6C+
         Nky0m0LZtCkFJyp/0V+K04GkMy1/bLX5JSQrc7uUUGb3JhVL51bTJ3OOPtDrw7jywTch
         kowA==
X-Gm-Message-State: AOJu0YxDoB0HJpkDmJLgPP8gIX+nSP2QZw8p3X6HzUd03lkkedHBr70B
        qd/rMIPghRn4i9SyhcxkSA4=
X-Google-Smtp-Source: AGHT+IHEgX9LGQdLajHEAvwReWMNBXEMzzh8ebTusZ9c64zFGF6PT3ENvn0pOpZ5abzgBQVqV7K/Lg==
X-Received: by 2002:a2e:8619:0:b0:2c5:1989:ce1c with SMTP id a25-20020a2e8619000000b002c51989ce1cmr2244449lji.26.1697844229984;
        Fri, 20 Oct 2023 16:23:49 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id s5-20020a05651c048500b002ba586d27a2sm567571ljc.26.2023.10.20.16.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 16:23:49 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     mchehab@kernel.org
Cc:     gregkh@linuxfoundation.org, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 4/5] staging: media: av7110: Fix 'long int' and 'unsigned' variable declarations
Date:   Sat, 21 Oct 2023 01:23:31 +0200
Message-Id: <20231020232332.55024-5-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231020232332.55024-1-bergh.jonathan@gmail.com>
References: <20231020232332.55024-1-bergh.jonathan@gmail.com>
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

Fixed the following warnings flagged by checkpatch:
 * Replaced 'long int' with 'long'
 * Replaced 'unsigned' with 'unsigned int'

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/av7110/av7110_av.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
index 880fa8a314ba..82d4c02ae3ef 100644
--- a/drivers/staging/media/av7110/av7110_av.c
+++ b/drivers/staging/media/av7110/av7110_av.c
@@ -71,7 +71,7 @@
 #define SEAM_SPLICE	 0x20
 
 
-static void p_to_t(u8 const *buf, long int length, u16 pid,
+static void p_to_t(u8 const *buf, long length, u16 pid,
 		   u8 *counter, struct dvb_demux_feed *feed);
 static int write_ts_to_decoder(struct av7110 *av7110, int type, const u8 *buf, size_t len);
 
@@ -589,7 +589,7 @@ static void clear_p2t(struct av7110_p2t *p)
 }
 
 
-static int find_pes_header(u8 const *buf, long int length, int *frags)
+static int find_pes_header(u8 const *buf, long length, int *frags)
 {
 	int c = 0;
 	int found = 0;
@@ -637,7 +637,7 @@ static int find_pes_header(u8 const *buf, long int length, int *frags)
 	return c;
 }
 
-void av7110_p2t_write(u8 const *buf, long int length, u16 pid, struct av7110_p2t *p)
+void av7110_p2t_write(u8 const *buf, long length, u16 pid, struct av7110_p2t *p)
 {
 	int c, c2, l, add;
 	int check, rest;
@@ -767,7 +767,7 @@ static int write_ts_header2(u16 pid, u8 *counter, int pes_start, u8 *buf, u8 len
 }
 
 
-static void p_to_t(u8 const *buf, long int length, u16 pid, u8 *counter,
+static void p_to_t(u8 const *buf, long length, u16 pid, u8 *counter,
 		   struct dvb_demux_feed *feed)
 {
 	int l, pes_start;
@@ -1030,7 +1030,7 @@ static u8 iframe_header[] = { 0x00, 0x00, 0x01, 0xe0, 0x00, 0x00, 0x80, 0x00, 0x
 
 static int play_iframe(struct av7110 *av7110, char __user *buf, unsigned int len, int nonblock)
 {
-	unsigned i, n;
+	unsigned int i, n;
 	int progressive = 0;
 	int match = 0;
 
-- 
2.40.1

