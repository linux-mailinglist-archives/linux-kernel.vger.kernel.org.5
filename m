Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C880ED08
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376586AbjLLNPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376583AbjLLNPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:15:33 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E97107;
        Tue, 12 Dec 2023 05:15:38 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-6cea0fd9b53so3359457b3a.1;
        Tue, 12 Dec 2023 05:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702386938; x=1702991738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QcCXCm4DPHUOC/Ldcn3syRLAjzqmkGV7uvetVmifyw=;
        b=H6/RmvsCHZVQeCoEnugvkOoaz2lU65BOr88iitTj6qAasc+1CN0cBXYH9Qi+ktYqxU
         JVJ0nDtCaiarBEFgZrCQiGcJiJkNON7NhPcIBeZ2pa1H0LCy/eFj6JErjR79cbLrdE4Z
         UlsuCcbiVgpKFM430uUL+Gx1faJg1DMhFxTyoTVFbsYLiqRDruXR7+LchMl8naBZGCwt
         y3rEWvu567omz817ZC63YPGkAkeeyIkwvMgW5DqMv9Sp9jw9rPp9thdiL6z9Rf7luYSK
         zUiEdUzmbljQMclLrrOOTHUxmnVOU8Pz7mauBMygTMRSvaPMFiCuXch0qiL1zRVfqNh+
         Bkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386938; x=1702991738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QcCXCm4DPHUOC/Ldcn3syRLAjzqmkGV7uvetVmifyw=;
        b=JoCWRy0wVDnTW1NHNxbAjaWiEMvBTsXeh9VOXVwUWomWAVnZIClQ6JNeBub8egjJLO
         ort42PwDYW2QJL3+8MXpf9zTn010GwFrAAfl6Dar3+v75me8leHeFdaTdMy/C/Sy9y+x
         Y6rWijYUyMVoEABfZ4Ey9Gh4WLM5hYVLaTsq805RqOZCbh95JsQ4FClHyRjT2lFVZxAE
         qhrrVAiuQQmvDsM+vGWLCktNBagTeLFqD3hUzR0TpA/HyshP248c5tkysU6ooAgL4v99
         VQMmVfRVhm6hMHXYR0ZGg3DzaxUwvDE40LeAIqYYehg7FU4rWnyfw9bD0gYggOp5t/XW
         CcfQ==
X-Gm-Message-State: AOJu0Yy0jGtGaIzZldkwt83rC7wZf4OQJBtcnD8JnXDT+WxjRrOVKVEq
        0VYASB05Z4S4zcZkaQzaOwU=
X-Google-Smtp-Source: AGHT+IHZ1rPA8bbXHF5K+fD0vtYa+UCVTZys6KqO/2Q8XqQUtl1NXzNnQTcsYwJJYZKy4YMOHkHqXg==
X-Received: by 2002:a62:be11:0:b0:6ce:6407:2264 with SMTP id l17-20020a62be11000000b006ce64072264mr2500987pff.56.1702386938219;
        Tue, 12 Dec 2023 05:15:38 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id x20-20020aa793b4000000b006c4d2479bf8sm8095026pff.51.2023.12.12.05.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 05:15:37 -0800 (PST)
From:   Menglong Dong <menglong8.dong@gmail.com>
To:     andrii@kernel.org, yonghong.song@linux.dev
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH net-next v2 2/2] selftests/bpf: activate the OP_NE login in range_cond()
Date:   Tue, 12 Dec 2023 21:10:31 +0800
Message-Id: <20231212131031.3088661-3-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231212131031.3088661-1-menglong8.dong@gmail.com>
References: <20231212131031.3088661-1-menglong8.dong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The edge range checking for the registers is supported by the verifier
now, so we can activate the extended login in
tools/testing/selftests/bpf/prog_tests/reg_bounds.c/range_cond() to test
such logic.

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 0c9abd279e18..49d8d4bafe99 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -590,12 +590,7 @@ static void range_cond(enum num_t t, struct range x, struct range y,
 		*newy = range(t, max_t(t, x.a, y.a), min_t(t, x.b, y.b));
 		break;
 	case OP_NE:
-		/* generic case, can't derive more information */
-		*newx = range(t, x.a, x.b);
-		*newy = range(t, y.a, y.b);
-		break;
-
-		/* below extended logic is not supported by verifier just yet */
+		/* below logic is supported by the verifier now */
 		if (x.a == x.b && x.a == y.a) {
 			/* X is a constant matching left side of Y */
 			*newx = range(t, x.a, x.b);
-- 
2.39.2

