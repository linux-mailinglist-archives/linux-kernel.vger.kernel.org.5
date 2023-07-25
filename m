Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AFB7616B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjGYLlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbjGYLkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:40:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2904F3;
        Tue, 25 Jul 2023 04:40:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so45099215e9.0;
        Tue, 25 Jul 2023 04:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690285239; x=1690890039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIwK4vNakYsmHhWk3gPu9jeD67klp1zgcobWm0hLfMM=;
        b=qzWmo+ENoePc/UCYjokwm8n28ajtGiHJ8cBotYdjFTxBLJ3ZyGwp4fhCr1uKAe0qgg
         eCHqn/SNWsBHo1OO75pdizfTIc4oGRcS2hA1Nmc4UeW+MqGByA5PCewlnvGbjn89sxLs
         1028IIY0p9O+5piV+G92YSigAUjgbbkKvVLoImuT+mIcTACzEL1rPKR+Mb2bREQ5VSno
         pprqhzm8/IkUTHEitJwsR9QKc9aiSzDX6ADuw2GNbIaHLlNlgJIVRBcD4L+h8EnEHT1v
         gFYo9UVtuoKT7YI2Yd9nHXrcBo3xrf0gpd701I0UozteYywqEJuyggJI07Dod8VFivHi
         lOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690285239; x=1690890039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIwK4vNakYsmHhWk3gPu9jeD67klp1zgcobWm0hLfMM=;
        b=DMrtKbJG0ZieEC742BOODrSL1TASnO6AdySL5iGHkzl+p+i8rkqB0KwFKi8yjxulKO
         obKp5wmAMnugrcJtw86BDfXylKp62GtG66kZFNeLCb7n9hBOFMZP+YprNDFMUqjF3l8d
         z0XBqjwZu0lpt1KSwWqrnEDC+lbd3pt2B72sKejL9EYMl7EFdtrbv3II80IjgQ2lySpA
         JSuOanm/s4jDh5WArF6WFOC9tsT8wOo4N5S96FirZERr1GBsjPVHoXjupuveehLP6q8B
         U/jDiUCyUEERGQtEFqkP4J+qqDGocxGeiMeWXhCXDWIBPrzQtbcnJxlEp0ndyKNtDKjQ
         pBNA==
X-Gm-Message-State: ABy/qLYxSfg8kBtSQDKV7HS5PF9JFcsOMuhogE0LPsL5jLS1l02VfRVZ
        MfMXO3uOgnTtk+9/bOHUCnA=
X-Google-Smtp-Source: APBJJlEHMeV1GT0gHESC09Zjy+axUc4imX5ZHprKSvGpdZB+jCUtQ1yHI/p8VsPGTg9IdOvMJtAw0g==
X-Received: by 2002:a05:6000:4c:b0:313:e456:e64a with SMTP id k12-20020a056000004c00b00313e456e64amr8961163wrx.21.1690285238976;
        Tue, 25 Jul 2023 04:40:38 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q3-20020adfea03000000b0031435c2600esm16177847wrm.79.2023.07.25.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 04:40:38 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] accel/qaic: remove redundant assignment to pointer pexec
Date:   Tue, 25 Jul 2023 12:40:37 +0100
Message-Id: <20230725114037.36806-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer pexec is being assigned a value however it is never read. The
assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/accel/qaic/qaic_data.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index e9a1cb779b30..8a6cb14f490e 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -1320,7 +1320,6 @@ static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct dr
 	user_data = u64_to_user_ptr(args->data);
 
 	exec = kcalloc(args->hdr.count, size, GFP_KERNEL);
-	pexec = (struct qaic_partial_execute_entry *)exec;
 	if (!exec)
 		return -ENOMEM;
 
-- 
2.39.2

