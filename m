Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BD27FC2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345705AbjK1Oj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344760AbjK1Oj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:39:57 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67568D51
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:40:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b27726369so39186985e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701182402; x=1701787202; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pf2DfL3Xh784BuSAN82jj5QlQKywpWu+Wh7+Xy6CbRs=;
        b=Q4KjlMdxTapkbOb2ioTBUKEAMM7mscUzFNvl3IAywCoIfG02lqJK80lq+VHdm//JGf
         JX2d69F9/hLq216t5NI151MiQ2IJg57vE2zhNSc7F2BE+eTSgIDcLd9vsNkF5pqQGR2y
         6Dcv353IlXNpTW35MLzdf4JK8uvEhJFSe6QzHfMVCtJFVvrMfNJdRsdRB8QbKp7+v0Bp
         K2QYm99Idl60pHeSvrHeLaYr21n4urgY31MaErZ8cY+Lwc11/li5F4jx6IdihmfQU34W
         Ed94XFQr1VLlnj2flMInPylulZqAiS1jg1ngVhcN3wEtq8QthlFsxYWgdKIQx3ncZdPU
         3Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182402; x=1701787202;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pf2DfL3Xh784BuSAN82jj5QlQKywpWu+Wh7+Xy6CbRs=;
        b=kUilfPCZvX304xYuMnA6ag3lU5GxScwpRdZZqvly+OmsVIsOxmAs+wZlLhZP3is496
         vunfBJ5Ms9aU+CPjFzFyIJC84AchiOEonsemlC3EI6qFg2KR1q8kpVRglFWB9TOi/Krq
         zelW4zqxc4bc2CGZDvwT2i62NfpD9LHXj5eCmIy8tpvJeOuw/m9jGpr/Jq2PjNefD3SV
         wktnrU/PVFmgaRWmXDpxgPsSM97ggfNXJVcV9ijpZSGM5EaQtdMXneQZ2BheGkOXdGMv
         DvWKWDq+YUOpBOE/G6/D8F30KmhG35dfEhfcDKIqPrz8S/Ofu+n2yHJAHLM1P/k0k2o7
         JnPA==
X-Gm-Message-State: AOJu0YynVhgTEjym47p2byY2JeAK4iTCg3w/NJ5b1jv65iOJpwJ2rIrg
        twRC+aDtWlAAone9diBYjCbLOQ==
X-Google-Smtp-Source: AGHT+IGYMuSYtzC3hhgkKzrn7uQuIfeDdduNP779y1aGb9C8fmBYxztzj7SxI0lLQ+DhL8H4tStW1Q==
X-Received: by 2002:a5d:484c:0:b0:32f:80cf:c3cd with SMTP id n12-20020a5d484c000000b0032f80cfc3cdmr11478470wrs.4.1701182401913;
        Tue, 28 Nov 2023 06:40:01 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600001c600b00332ff21038fsm6730985wrx.106.2023.11.28.06.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:40:01 -0800 (PST)
Date:   Tue, 28 Nov 2023 17:39:58 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Nas Chung <nas.chung@chipsnmedia.com>
Cc:     Jackson Lee <jackson.lee@chipsnmedia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] media: chips-media: wave5: remove duplicate check
Message-ID: <9bdce1f1-b2f0-4b11-9dfd-16ca7048281b@moroto.mountain>
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

We already verified that "ret" is zero a few lines earlier.  Delete this
duplicate check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/media/platform/chips-media/wave5/wave5-hw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index 3fcb2d92add8..f1e022fb148e 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -578,9 +578,6 @@ int wave5_vpu_dec_init_seq(struct vpu_instance *inst)
 	dev_dbg(inst->dev->dev, "%s: init seq sent (queue %u : %u)\n", __func__,
 		p_dec_info->instance_queue_count, p_dec_info->report_queue_count);
 
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
-- 
2.42.0

