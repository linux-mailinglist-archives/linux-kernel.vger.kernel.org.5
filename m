Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B697E7A3037
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbjIPMjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbjIPMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:39:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1534CEF;
        Sat, 16 Sep 2023 05:39:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-500913779f5so4898977e87.2;
        Sat, 16 Sep 2023 05:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694867944; x=1695472744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q79fUZZbSUv3woTyk6fuaOdxQDm7PBUultk07mBos+4=;
        b=mgRIJ0a+yRHvOk2MXIASEWi4SCoaqfvBsezrBUFB9gWl7u7Z6V28ewtN7RAuCEyDYn
         BJzdZUNncLqQfa+3dvFRE2bjt3+WldIZ40pL05QJn+spnGjocV6K26gW428mN93f+Kw8
         n/m0edWr1fwvDX+hupI+zeiFVMtAIcg6WZDzB88SX9GFHLBl6ObHzDQV3qEEdiCZD7xy
         UreoWrLfnuhHr0WfDR5KpS7iLoVAqY9pqntz81ERpZqguP2UmTEVQPCYBl+oekqnxDzB
         tbSFdQrbK9EIY1zunZnLV4Kza1O2wAIbf1nHPh+lw/GJ0sWcR7CxcgAQfrnQwca9U6g8
         r3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694867944; x=1695472744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q79fUZZbSUv3woTyk6fuaOdxQDm7PBUultk07mBos+4=;
        b=VxK+WTygJgRbrSVn7e6qOqisETscPzMTFrKVqYgoOYFzX5sDElXLFFD0NUW9yIJ55u
         NUXd0gEOX5/s8I5ev1IPwdXBAyn2n0NXWU5XQcBXGb53+jFFCY4odPAdnLAJ3je6FVY4
         keaCtNTT2sKaAhk8SKAydbKuPGzW9Vr6ftL8tw8KRDTftUi7ceQXcAM7TzR1V/HOC9rz
         TQn8uFOBkBeoQHzzD5QjU2l1iTqQp2jNv/z62INwGFFrydfQJSnCO5febav08VxcAWZo
         kbQpOf96mdLmkWTVe8MRiO3N+L0oBQrs8TgTHj8qvQ6i1IWTNKvlFiBJ4WTu0/hEr1Kr
         v8+A==
X-Gm-Message-State: AOJu0YwGch3BJWEENOTD7x6QFqK8MVejZ/6kdJA6f4Xa5OG6qNlbbliy
        Wbd8tZDBih0LZaTwLOl7DS0=
X-Google-Smtp-Source: AGHT+IGG6yNDr1u/yJrve6emYBkyCfBo5rXmedyP3fAucUQrIqExiENN7gWRJp/OitCxwnERHwWuTw==
X-Received: by 2002:a05:6512:e96:b0:4f8:71cc:2b6e with SMTP id bi22-20020a0565120e9600b004f871cc2b6emr4423713lfb.33.1694867943947;
        Sat, 16 Sep 2023 05:39:03 -0700 (PDT)
Received: from localhost.localdomain ([77.134.181.150])
        by smtp.gmail.com with ESMTPSA id bo6-20020a0564020b2600b0052284228e3bsm3474064edb.8.2023.09.16.05.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 05:39:03 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v9 2/7] iio: accel: kionix-kx022a: Remove blank lines
Date:   Sat, 16 Sep 2023 14:38:48 +0200
Message-Id: <3489099f653491e97b13b8f19fe86635b03020c8.1694867379.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1694867379.git.mehdi.djait.k@gmail.com>
References: <cover.1694867379.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove blank lines pointed out by the checkpatch script

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 drivers/iio/accel/kionix-kx022a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index f164b09520c9..2f1e7da25460 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -341,7 +341,6 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
 		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
 
 	return ret;
-
 }
 
 static int kx022a_turn_off_lock(struct kx022a_data *data)
@@ -1110,7 +1109,6 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret)
 		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
 
-
 	ret = devm_iio_trigger_register(dev, indio_trig);
 	if (ret)
 		return dev_err_probe(data->dev, ret,
-- 
2.30.2

