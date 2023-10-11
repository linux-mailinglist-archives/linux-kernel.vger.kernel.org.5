Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EB97C5F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjJKVaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjJKVaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:30:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABF8B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:29:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af53bde4so4846727b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697059797; x=1697664597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m3pTpYqn2463yxqFt3mIFAjuaB6ZhS9Rkhs7QnUkljw=;
        b=Nq7uSgZg0s1stmYMn6ZzSakIy/plW3bDKlrSQIprCvdcoMowghQ3C2GG+pqav8ZMij
         iFxE+b+c/pqU1LSOSMeDbVzbrJxBcQNqkxSN5+8NvmofmQ3RNTNXoFteHlXQeissIHjZ
         RcSPcJ02aCYEw3a7pK7a2j7NgAupJZTV/m1kBXDfPX0+Xy9HTUwjFEdkETepOyfiSsCg
         n3n9PsQNbZR1vm98HHuV2XJmTpFRffMDry6+L3x+M+9mLjdRB+ElplXUEGrdfMGj67Ka
         oOhJe2zmogwnSU4qfy8BA9ZCiYl0ayjpPt4ET2fTQIcqaF5vRf4KHb/zvgotMugxa9is
         qSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059797; x=1697664597;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3pTpYqn2463yxqFt3mIFAjuaB6ZhS9Rkhs7QnUkljw=;
        b=nNzDkYAvItoxkHgKiOMSN3h02RHZg/7SDKMsErIFPkyNmm0GdNWfeeZN/GZO7h/ZSO
         27CW8paIwGsfvBlx6Z15WGhRrGXeg87DZz8TXNm2fw6i2/N/Ip5Sjq9g6kheStcN3mDa
         kfFCj5eykUT3Cah1piDmIRYHXjjG+LiCaqd5anVGLJNKcCuwvDuLVYOJ3A1oJ7eX7eML
         0UWAKjDp228OZCTOCmlpBdF/AOYfeA3PLC6gfqHY6JuNgxDJg1zGpRmnHA1VY7IfFHDm
         2nmTvy8rUrs09UhJccbMSelHMYhaSJOram6b6PschO/ov1p9OIhN4UJABlHAk3kue1fq
         56cQ==
X-Gm-Message-State: AOJu0Ywz6UEYiBjBZJvFkmXgyNVPBSu//Hx0dWn0aoH2ZRPc6KPqpabz
        UEgNRQhsjPPLtTiwQLUVt5vBRKkf2+QXSZyxgw==
X-Google-Smtp-Source: AGHT+IFzh11O2xXhTMZejnqEuXav2mfhp3aDFwJLnzB7+Nt/FhAkhc5xn+9+x59VZRntczfgh2jwR2IMVZ3LVuZyww==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:52d:b0:d13:856b:c10a with
 SMTP id y13-20020a056902052d00b00d13856bc10amr387725ybs.3.1697059797461; Wed,
 11 Oct 2023 14:29:57 -0700 (PDT)
Date:   Wed, 11 Oct 2023 21:29:57 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANQTJ2UC/x2NQQrDIBAAvxL23AU19NB+pfQgumkWdA2rBEPI3
 2t7m7nMnFBJmSo8pxOUdq5cZIi9TRBWLx9CjsPBGTdbYy3WphK2A6PyTlpRqCG1lfQHmVLyUjr m1O8YihJmz4IBXYwPPy/eOTIw4pvSwv0/fr2v6wtZvHP6iAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697059796; l=2667;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=usepiRchsBWre9GwPIWtzyZBsxT9tg3v/Wn5P+lFJXo=; b=mFh0xX/ALc4XkRYsUlu0sqE+8WUIH0DgX2syBIUwocnImlvC26efKkQIraF5PVPGcpvC0ArXs
 uOKWtTvR0P8CTm/inIvAVzS2Y/WzNweabRpteNbBdiyh+QIkfzd5LLl
X-Mailer: b4 0.12.3
Message-ID: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx5-core-main-c-v1-1-90fa39998bb2@google.com>
Subject: [PATCH] net/mlx5: simplify mlx5_set_driver_version string assignments
From:   Justin Stitt <justinstitt@google.com>
To:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In total, just assigning this version string takes:
(1) strncpy()'s
(5) strlen()'s
(3) strncat()'s
(1) snprintf()'s
(4) max_t()'s

Moreover, `strncpy` is deprecated [1] and `strncat` really shouldn't be
used either [2]. With this in mind, let's simply use a single
`snprintf`.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://elixir.bootlin.com/linux/v6.6-rc5/source/include/linux/fortify-string.h#L448 [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 15561965d2af..0c829b6d2b49 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -218,7 +218,6 @@ static void mlx5_set_driver_version(struct mlx5_core_dev *dev)
 	int driver_ver_sz = MLX5_FLD_SZ_BYTES(set_driver_version_in,
 					      driver_version);
 	u8 in[MLX5_ST_SZ_BYTES(set_driver_version_in)] = {};
-	int remaining_size = driver_ver_sz;
 	char *string;
 
 	if (!MLX5_CAP_GEN(dev, driver_version))
@@ -226,22 +225,9 @@ static void mlx5_set_driver_version(struct mlx5_core_dev *dev)
 
 	string = MLX5_ADDR_OF(set_driver_version_in, in, driver_version);
 
-	strncpy(string, "Linux", remaining_size);
-
-	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-	strncat(string, ",", remaining_size);
-
-	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-	strncat(string, KBUILD_MODNAME, remaining_size);
-
-	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-	strncat(string, ",", remaining_size);
-
-	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
-
-	snprintf(string + strlen(string), remaining_size, "%u.%u.%u",
-		LINUX_VERSION_MAJOR, LINUX_VERSION_PATCHLEVEL,
-		LINUX_VERSION_SUBLEVEL);
+	snprintf(string, driver_ver_sz, "Linux,%s,%u.%u.%u",
+		 KBUILD_MODNAME, LINUX_VERSION_MAJOR,
+		 LINUX_VERSION_PATCHLEVEL, LINUX_VERSION_SUBLEVEL);
 
 	/*Send the command*/
 	MLX5_SET(set_driver_version_in, in, opcode,

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231011-strncpy-drivers-net-ethernet-mellanox-mlx5-core-main-c-2dd9a3fa22e0

Best regards,
--
Justin Stitt <justinstitt@google.com>

