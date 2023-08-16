Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1074177EA99
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346098AbjHPUTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346103AbjHPUTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:19:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F58A1FE3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:19:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c8b2d6784so13547107b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692217161; x=1692821961;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3wsWTylhhPdG3/T8LNZoJaxLDgLi/vqIDceWVK88NME=;
        b=Ht3ZRd1ImNrc2iTkzCJ5Fql3ljWCB2/SIVSsRNPxYYsUGod5lhvmeTUN5m3FrjuquK
         yL/RgT2BZliIqrkqCktYGQQQcjCncJNHHINboxuRqGGFWxbtQ1YDCAEtEKwrmFE4ZBHP
         UFxkKjPiw6Qij5Ai7S4lvAOmHBP0MUy6fAM+SSZwI/F5Z1pCqWikJh4O7NUr7IxN2+7V
         dC2jUXD03hBSxm5SCpr2+nuPq9ZM3WVjvxqaJCnHxvtyEduJvTqlMNLMf6Dt7hNGzZxV
         OObllt001yGEJEjG4sYLTOL+Q2yr8czIGVcvpF7v5/YIvcUWt2l8KuK7e8rBtnrhKKZG
         fv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692217161; x=1692821961;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wsWTylhhPdG3/T8LNZoJaxLDgLi/vqIDceWVK88NME=;
        b=YZFqhqFuwjV0e9kRxX9rnTxs5q3bCUHfooGRgyluq8ycgSwOHj/PH6RXBvcIcMrhy+
         xh2RLqC0UyuWo1zj3MsBAM4PoBSKCWjfTJ2CFvecRg4HgRKNg4bzOF6UYp1fcnmCRgKY
         UjBn5CfNgyoJjoGoHqUJBNmp7GDIDnP/echucOcuVDoCtLzNfrMShzbuWNJNBP8exTqs
         +ELm+HoKXBRsVenR9NpVRfle5xwDHpi+MI2fwf5DjgPmKH6M9uJ+VXalCzbvFrBLkJx6
         mVlO5f+TDPdhPMWZHV4f0FR7Pt4nrPc50E6q0UU4u8Piz55V226FOuaZ6bLYZBurCyBH
         Fk5g==
X-Gm-Message-State: AOJu0YxmczBdRKzxnAvfHMlTfGOZ1J3Of/nz0zVQYBSEho4gcoOAR8vf
        Z532f2xwAzfJ5MeXd6yKwmnHSIQmmFrxLReMnw==
X-Google-Smtp-Source: AGHT+IF1NY2O9E+AcCVUc6YmSnFStWnAWmT+ayAT17Q7KEQNdNUBTRt8h9InsGVkNddn7kVhEA8MaXYUcc13W2aRUA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:4407:0:b0:58c:b45f:3e94 with SMTP
 id r7-20020a814407000000b0058cb45f3e94mr37282ywa.8.1692217161433; Wed, 16 Aug
 2023 13:19:21 -0700 (PDT)
Date:   Wed, 16 Aug 2023 20:19:06 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADkv3WQC/x3NSw7CMAxF0a1UHmMpCVX5bAUxqMgLeEASbIiKq
 u6diOGZ3LuSQQVG52ElRROTkjv8bqDbY853sMRuCi7s3dFP3IpEjioNahzRkuLFaMhvxvLNxbj W54encY7ehfF0SIF6rCqSLP/R5bptPwOrzAp4AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692217160; l=1505;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=3i09RUBjajBo5aL6e0TrKmXYq85q23Jzin6ZTPYdgyY=; b=S4oTPqidmSx4pnXekqz3cAvXwTPXkBzQ1EIFWu9hSsoThdtp9eduwMFBcm4W1kNzVJZvIyFio
 YGlmbwClC6pBWurTU/dRHGUj2NmAVzjjY0yT3dMx3QDNiHt27E7UCjd
X-Mailer: b4 0.12.3
Message-ID: <20230816-void-drivers-devfreq-event-exynos-ppmu-v1-1-3fac11083742@google.com>
Subject: [PATCH] PM / devfreq: exynos-ppmu: fix clang -Wvoid-pointer-to-enum-cast
 warning
From:   Justin Stitt <justinstitt@google.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang 18 I see the following warning:
|       drivers/devfreq/event/exynos-ppmu.c:530:21: warning: cast to smaller
|       integer type 'enum exynos_ppmu_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
|         530 |       info->ppmu_type = (enum exynos_ppmu_type)of_id->data;

This is due to the fact that `of_id->data` is a void* while
`enum exynos_ppmu_type` has the size of an int.

Cast `of_id->data` to a uintptr_t to silence the above warning for clang
builds using W=1

Link: https://github.com/ClangBuiltLinux/linux/issues/1910
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 896a6cc93b00..f798e1d6994d 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -527,7 +527,7 @@ static int of_get_devfreq_events(struct device_node *np,
 
 	of_id = of_match_device(exynos_ppmu_id_match, dev);
 	if (of_id)
-		info->ppmu_type = (enum exynos_ppmu_type)of_id->data;
+		info->ppmu_type = (uintptr_t)of_id->data;
 	else {
 		of_node_put(events_np);
 		return -EINVAL;

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230816-void-drivers-devfreq-event-exynos-ppmu-64ad102497f2

Best regards,
--
Justin Stitt <justinstitt@google.com>

