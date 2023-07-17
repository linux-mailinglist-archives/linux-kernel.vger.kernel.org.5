Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCC4756047
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGQKUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGQKUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:20:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DCCE67
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:20:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31590e4e27aso3897478f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689589238; x=1692181238;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xjHSH6JPN242twkYagyCM3b4pHivNarK7/dz84nfUo=;
        b=Ed1Oon/LLl1kLQVVPM35G/cpdQIIwld+034WiGpAV0AsAfXzNJo8HuzR9CLzKG301r
         UYdu8sIIYGEyXT5fQwBCCielixfulMCbEyS+80ysDfxQdQKXjfoWKAOj0VihOBys0N+y
         dH1qR7NQm3hzj0edg1q/47XDLQhlM8c3JhdyNmxQrzLvOs2vaa5Bd5LAwebjx1daqz1U
         XI3HooTbSo5OPKOhBIDxO4hrbB4WFtEzFuxZL71yluEmyZl/deW8Tg8hLFW7kMJq5Ro3
         2PqHyr4CQd8A3FPTSiSx9nHGs6YaaXtXgCWleiDHtH0Q4ZuvCgjLUXD9u8LSFJ4wpSAT
         THzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689589238; x=1692181238;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xjHSH6JPN242twkYagyCM3b4pHivNarK7/dz84nfUo=;
        b=iyKFsaw/JTCUIbddIkrQwp3o4mZjrr4Lz6lJUgBHD6tn3x/XsaqFRur1q6NeRdJdBA
         PL4uRiZEX7135DcL8D9ucpJOGcidvN/20DxJjEZ9t9ZU0Vqfj13C0IXdO35VLYXVPogZ
         x/lx/zyVbiv7kpw5aRkp6rnuoaXRJK8PYPoSyE5l+L7niaauQywH83ApcR5jHF8wU3Ma
         om3Wo6oeID2enn0/w6d35NrphRt5s4Ujyb8DaMYF7gqj1GuuaDQHVBqyjtVaX44GofL4
         dDDsCpjatvcfZKo7m22UTrmOKv+M+Eej25Z3dK29RQa4t0MIvAx0WSfkXLouAKuWnPGJ
         u1ZA==
X-Gm-Message-State: ABy/qLYoc8GCzCgX4Yl/YeoTfLCmNuBX9Ropt2NWZtGj1Y9TBT/Ty0Q3
        yNyyMv+tLNZWKNL/+mdVqO0vPQ==
X-Google-Smtp-Source: APBJJlGYOxHZkuEqeOeiGNHqrFtQ9ewfMH5QDg09+Jjvucym7gtBd/zyQVew6hrbcd/86yVMl8OR6g==
X-Received: by 2002:a5d:4b44:0:b0:313:edaa:2505 with SMTP id w4-20020a5d4b44000000b00313edaa2505mr10379451wrs.20.1689589237859;
        Mon, 17 Jul 2023 03:20:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a3-20020a5d5703000000b003143cb109d5sm18694615wrv.14.2023.07.17.03.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 03:20:35 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:20:31 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_conn: clean up some casts
Message-ID: <5cbde2b4-69b5-4b25-a095-251c8347cb09@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ERR_PTR/PTR_ERR() functions are only for error pointers.  They're
not a generic way to cast pointers to int.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
We should really create INT_PTR/PTR_INT() functions.  But this is a
cleanup until someone creates those.

 net/bluetooth/hci_conn.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cccc2b8b60a8..aea6fa12d954 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -873,7 +873,7 @@ static void bis_cleanup(struct hci_conn *conn)
 
 static int remove_cig_sync(struct hci_dev *hdev, void *data)
 {
-	u8 handle = PTR_ERR(data);
+	u8 handle = (unsigned long)data;
 
 	return hci_le_remove_cig_sync(hdev, handle);
 }
@@ -882,7 +882,7 @@ static int hci_le_remove_cig(struct hci_dev *hdev, u8 handle)
 {
 	bt_dev_dbg(hdev, "handle 0x%2.2x", handle);
 
-	return hci_cmd_sync_queue(hdev, remove_cig_sync, ERR_PTR(handle), NULL);
+	return hci_cmd_sync_queue(hdev, remove_cig_sync, (void *)(unsigned long)handle, NULL);
 }
 
 static void find_cis(struct hci_conn *conn, void *data)
@@ -1234,7 +1234,7 @@ void hci_conn_failed(struct hci_conn *conn, u8 status)
 static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct hci_conn *conn;
-	u16 handle = PTR_ERR(data);
+	u16 handle = (unsigned long)data;
 
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
 	if (!conn)
@@ -1264,7 +1264,7 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 static int hci_connect_le_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn;
-	u16 handle = PTR_ERR(data);
+	u16 handle = (unsigned long)data;
 
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
 	if (!conn)
@@ -2854,7 +2854,7 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 static int abort_conn_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_conn *conn;
-	u16 handle = PTR_ERR(data);
+	u16 handle = (unsigned long)data;
 
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
 	if (!conn)
-- 
2.39.2

