Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759537B4B20
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 07:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbjJBFcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 01:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJBFc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 01:32:28 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01150C6;
        Sun,  1 Oct 2023 22:32:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27763c2c22eso8293917a91.3;
        Sun, 01 Oct 2023 22:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696224743; x=1696829543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jj1R+iIJv81f1aovwEhID5L6pS+zmKgxzLxTyl4tnQI=;
        b=Xy/XXVhnPnL86oPlJXBZN/IqPour9820qmwsZDWjGnCrDvTv47ffYbdYGseRqGUTGr
         2QqeVNvZvUc5C0O8RZz9p/qYwtblsPEthD7LmNAeve4Z9k3498rkbZLfWw6cP5Gwxxqz
         0he/9kumYcK4ndAOUx0sGaTLGKGNE/t0fO3rTZRiCJSnhNft8JfLXQ1YWu+PKH8GlbKb
         PpLboRbgdoKQWofEjSnCRmBqt8Sf0i7EbHKFAPznCsh/npaoG9VWDTIZvKTfqqcEALuK
         Ly3oJxBa8OX9RtDKXt8CM5VEM3ihuDNo8sIXpqoNHE4sG/R05a9wxC7P8imUTSBEgQR5
         WnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696224743; x=1696829543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jj1R+iIJv81f1aovwEhID5L6pS+zmKgxzLxTyl4tnQI=;
        b=DeNR5rS6ehsaAWUrtTKHLJ6MIW7/MLAATWXxywwDmlK8pxVbavU5dnnj9SGHnBfd7E
         keS/lS8ZypR4R9H6bz6ET+MB1xapbwJemCvKoYJw/QrxcmyiAlhdGkzC0FurCsvw4QZi
         /Ung2A4hCmp8euHM1Ke5QnC2m6+8okAXRGs556uKC7xr5TWn4gkk18CHtQq5DlzpWua/
         SpT2mm2Sx3EtGzy3dh6zOFIJWNFzGy+lla8B0eKIb6o+fc16Rvl4b/9DER5fsogbvqOp
         NEUMkWrzB28Ifwh3o2Lsaq1pDoMrd7Cv7/dAf06iVv90D/8ykz7OV1qgErmJwu+NW1rH
         Ji8A==
X-Gm-Message-State: AOJu0YyYydNQBj90Cg9U/SrSlhOWokcjtUyIR0dfh/unVdFotczMvvZP
        eZaUp3VEWU00pqlZZzhyHAI=
X-Google-Smtp-Source: AGHT+IFFu5osZJ6tV/j8G5SqTnbmnsImfndlWC/16L6zimapvYYUy53GAvDscfbTywFTACPcEXpQcg==
X-Received: by 2002:a17:90a:c214:b0:279:cea:cfa9 with SMTP id e20-20020a17090ac21400b002790ceacfa9mr8303320pjt.21.1696224743268;
        Sun, 01 Oct 2023 22:32:23 -0700 (PDT)
Received: from ubuntu-ThinkBook-14-G4-ARA.. ([2402:7500:95b:3495:ded6:1d:ca69:68ea])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c1c400b001b850c9d7b3sm920565plc.249.2023.10.01.22.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 22:32:22 -0700 (PDT)
From:   Cheng-Han Wu <hank20010209@gmail.com>
To:     linkinjeon@kernel.org
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        hank20010209@gmail.com
Subject: [PATCH] ksmbd: Remove unused field in ksmbd_user struct
Date:   Mon,  2 Oct 2023 13:32:03 +0800
Message-Id: <20231002053203.17711-1-hank20010209@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/smb/server/mgmt/user_config.h:21: Remove the unused field 'failed_login_count' from the ksmbd_user struct.

Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
---
 fs/smb/server/mgmt/user_config.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/server/mgmt/user_config.h b/fs/smb/server/mgmt/user_config.h
index 6a44109617f1..e068a19fd904 100644
--- a/fs/smb/server/mgmt/user_config.h
+++ b/fs/smb/server/mgmt/user_config.h
@@ -18,7 +18,6 @@ struct ksmbd_user {
 
 	size_t			passkey_sz;
 	char			*passkey;
-	unsigned int		failed_login_count;
 };
 
 static inline bool user_guest(struct ksmbd_user *user)
-- 
2.34.1

