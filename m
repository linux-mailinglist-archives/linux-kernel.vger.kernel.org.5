Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A1E80A75F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574304AbjLHP2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjLHP22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:28:28 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC3A10EB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:28:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a541b720aso2690262276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702049313; x=1702654113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T7tnk50IwyqvmhchVAZ1NJZqOjg7SDg1RGawYTJHOFU=;
        b=aI9tg7ZIFlw0GgI2y+Dqc8wgX+BZ08+rK/HBTI87K130Z36fMR4bBLFdxDvCk10T3m
         b6vZ+GhvbmdkMNqQcqy6v3+CD3U4CYqOYFhTNhwI734W3KP9r6xYmZtjjvfrDKZssM/A
         YS48QIkylUveydjUao9dDC3Qy+1V9iiMgzU4kVnHNOalC0m7MHRwJHbJL/9QQVrQc+u0
         vn+ZCYcZQ5SNM5vIbzeaIHhmxmqYoJyjpXkWcNfX70/MfDOfrTdeYe6mkKfgbkdn13Cs
         F78l9ZgxB391T/BrdUcuaacNFSHJCVV6O+IYSP0uQWZQrd3ugDEytUDxJ5f0oRPgnetp
         zxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049313; x=1702654113;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7tnk50IwyqvmhchVAZ1NJZqOjg7SDg1RGawYTJHOFU=;
        b=GETXHrD8LVuLdKkf7csd36FWdG8RQP7yHvx76dTGn+P8ZzAGW9cdMZHhQlq1s5JOLN
         c+bbXHi4tQqJy4NwwtvCYOXA1sTxTSBX9Y2XrESAnp0Pz9nycw6i+U52QEhBAmC3MNmT
         U4BnNmzkeuhnAb2Uj+vJN1eYPUgspgF4qORfVUtYfrn2onZu5eT1EjCh5RYWH1C7BT2Y
         fcZuhxVKQPfszRzOde0wkmx6Abwlg9dN5eAzLVQzZ5867Sd5jWZjWT1oQBjkkiEShSOW
         vXgeVvUF566ZufslS2pj+suHGX7nsIfsKtug1AmS2gYSRQ7v/4NTkNLBlO/u8P5AG+Cv
         ub7A==
X-Gm-Message-State: AOJu0Yylb4y1zosFyil1Ps5dhYmvdRzRqR0/KxEjILS64QgENFChC/KU
        h1ezY2H/Dalbr8EcuL57AGTeIziwOC8L/YI=
X-Google-Smtp-Source: AGHT+IF7J7BFKvpyGMNaSkj247TP7YThJeTIvWXl0xOrf2sMhRLLoq+ZgiIYJsNer4q+KHPSvp4ESYjJ7Wl9AoI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:f02:b0:db4:5d35:c5a3 with SMTP
 id et2-20020a0569020f0200b00db45d35c5a3mr1977ybb.0.1702049312631; Fri, 08 Dec
 2023 07:28:32 -0800 (PST)
Date:   Fri,  8 Dec 2023 15:28:01 +0000
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3314; i=aliceryhl@google.com;
 h=from:subject; bh=zGpp5cQAX7hq42U2GcG4K7mya1fkRh95lulBLb3AF+c=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlczJdpsFIwVnmUqLmjKaqU5i7Ex++2a/e9Ycmu
 CzDA66XGmmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZXMyXQAKCRAEWL7uWMY5
 RnExD/9dKqsgXInLMi3zcvmLWQodNn3tlBfAelSFrqMssJXzalfQEgaaTfP6F2bJQpa4LXfGD+T
 akVRQ3lvBqYDjwNS/dmtpZ25W3RBEEqYjYXU9umefhAbsnIiY30roWdKrfctAKfFPoS2YOWpX6v
 DFggJKAWx48h0QLjcd+gymg2tNTbUW8eJDNQ+ePG4QeKhe68OpdWyiLmTTnH5Zy4WnyMW76eSCL
 93Mc6e28g5q1iIcNhiF0mee+tws1x19j8lg1n8Z/FsCAEQYTBn8slMalai6GOwvfwMoX9qn1lQk
 AdbxD/oDdy+Tv9Fe8TEMkIptq9T7oYcxt44xjmuND2diN85S1rNr88OUBoPc4R8c9jE1c2FlJYX
 syyL3MgLO34tDqfuZ7D8ya/CzsyV38fOBb6mV+rEtQyfgHIV84tGaxzUacjkzLwu92K/rtNNj6t
 ACny6rw6tHM1WCFoShGvc/dyBe0kk0e0sazvF3z7XjRnpD/xkdVg84wg1tcfwOeL+9sEFzqxgoo
 aGHpJRpSIHIJ+jMnxEsVTs8iyz6ccxlN9c6Gyb0LwAcH/9vkjtho6ZMTACHGrLH0LVASmHbvAII
 aJGOKbWPkRCgNrWKwEj6/CVslgfk5VdDRZh9uVEloJ2O/W9wFFJAoUv0u4kvSXHD0Jd38vELoL2 3cHpniT8MffG0Cg==
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208152801.3425772-1-aliceryhl@google.com>
Subject: [PATCH] binder: use enum for binder ioctls
From:   Alice Ryhl <aliceryhl@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Li Li <dualli@google.com>
Cc:     Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the other constants in this file are defined using enums, so make
the constants more consistent by defining the ioctls in an enum as well.

This is necessary for Rust Binder since the _IO macros are too
complicated for bindgen to see that they expand to integer constants.
Replacing the #defines with an enum forces bindgen to evaluate them
properly, which allows us to access them from Rust.

I originally intended to include this change in the first patch of the
Rust Binder patchset [1], but at plumbers Carlos Llamas told me that
this change has been discussed previously [2] and suggested that I send
it upstream separately.

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-1-08ba9197f637@google.com/ [1]
Link: https://lore.kernel.org/all/YoIK2l6xbQMPGZHy@kroah.com/ [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/uapi/linux/android/binder.h | 30 +++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index 5f636b5afcd7..d44a8118b2ed 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -251,20 +251,22 @@ struct binder_extended_error {
 	__s32	param;
 };
 
-#define BINDER_WRITE_READ		_IOWR('b', 1, struct binder_write_read)
-#define BINDER_SET_IDLE_TIMEOUT		_IOW('b', 3, __s64)
-#define BINDER_SET_MAX_THREADS		_IOW('b', 5, __u32)
-#define BINDER_SET_IDLE_PRIORITY	_IOW('b', 6, __s32)
-#define BINDER_SET_CONTEXT_MGR		_IOW('b', 7, __s32)
-#define BINDER_THREAD_EXIT		_IOW('b', 8, __s32)
-#define BINDER_VERSION			_IOWR('b', 9, struct binder_version)
-#define BINDER_GET_NODE_DEBUG_INFO	_IOWR('b', 11, struct binder_node_debug_info)
-#define BINDER_GET_NODE_INFO_FOR_REF	_IOWR('b', 12, struct binder_node_info_for_ref)
-#define BINDER_SET_CONTEXT_MGR_EXT	_IOW('b', 13, struct flat_binder_object)
-#define BINDER_FREEZE			_IOW('b', 14, struct binder_freeze_info)
-#define BINDER_GET_FROZEN_INFO		_IOWR('b', 15, struct binder_frozen_status_info)
-#define BINDER_ENABLE_ONEWAY_SPAM_DETECTION	_IOW('b', 16, __u32)
-#define BINDER_GET_EXTENDED_ERROR	_IOWR('b', 17, struct binder_extended_error)
+enum {
+	BINDER_WRITE_READ		= _IOWR('b', 1, struct binder_write_read),
+	BINDER_SET_IDLE_TIMEOUT		= _IOW('b', 3, __s64),
+	BINDER_SET_MAX_THREADS		= _IOW('b', 5, __u32),
+	BINDER_SET_IDLE_PRIORITY	= _IOW('b', 6, __s32),
+	BINDER_SET_CONTEXT_MGR		= _IOW('b', 7, __s32),
+	BINDER_THREAD_EXIT		= _IOW('b', 8, __s32),
+	BINDER_VERSION			= _IOWR('b', 9, struct binder_version),
+	BINDER_GET_NODE_DEBUG_INFO	= _IOWR('b', 11, struct binder_node_debug_info),
+	BINDER_GET_NODE_INFO_FOR_REF	= _IOWR('b', 12, struct binder_node_info_for_ref),
+	BINDER_SET_CONTEXT_MGR_EXT	= _IOW('b', 13, struct flat_binder_object),
+	BINDER_FREEZE			= _IOW('b', 14, struct binder_freeze_info),
+	BINDER_GET_FROZEN_INFO		= _IOWR('b', 15, struct binder_frozen_status_info),
+	BINDER_ENABLE_ONEWAY_SPAM_DETECTION	= _IOW('b', 16, __u32),
+	BINDER_GET_EXTENDED_ERROR	= _IOWR('b', 17, struct binder_extended_error),
+};
 
 /*
  * NOTE: Two special error codes you should check for when calling

base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
-- 
2.43.0.472.g3155946c3a-goog

