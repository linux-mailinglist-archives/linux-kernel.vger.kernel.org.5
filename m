Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A8078622F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbjHWVRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbjHWVRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:17:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6366410DA;
        Wed, 23 Aug 2023 14:17:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fef3c3277bso30120425e9.1;
        Wed, 23 Aug 2023 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692825420; x=1693430220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk+27VqlRqrj/ivAPFtnt5mYhJJ8mv21V/tphnroa0c=;
        b=eT+uzmtzQo167/cZpSk4pujI3G3HgH/Uw6ruSLWNGgV6wxndBv+DT1eiXjy6zp10in
         7/x8g1UqAgIJuR9ftUEubvcc9QRNWukOKHGvht89eySQwWfA4nj39zpaWfNzRDvWSfEI
         LBTIo2tRXdQ60cyqboRb5VlP6AJKUqhur/EMjW32lgTZyxIxSQoyMECO7Rcdsw+l8PHl
         vr6lLfkQ4IK33JZ0sE4roHUPxodf2SB5hQN/dSl6AFJM11N6Ybdv8bDzqP6wgRa0YlUM
         AjuPzJ7dD8kn5Yx6+q0eOkyPwyh0spiSfnco6FkWph1yWBdDK+MpqXDxDgxlUVdR9Qcm
         4FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825420; x=1693430220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk+27VqlRqrj/ivAPFtnt5mYhJJ8mv21V/tphnroa0c=;
        b=gRlqa1BfKHnU5c9LdiuNrnlXFcMGmIp8dn1wEqobIzR5l6ifvYqJTBSyXhLZmBoTII
         KLSof/7VVK2ORKHmaDWF3EVys/oCmkazeXGiAGYLgvam2lPGJviGKcbafXZH2XDQzMzv
         c6+9+F1Sn7xGCAFelwdPLn/TUE1bnorwu1JyWXH2wMP70mZGoGF+XPZ9AJZgfIZBbue7
         LOMljYiY22v/q4rl++SGiRd7oi1G8TKmHR/lJ0n/QJ81TpX9ba5YGdtyCO1xug309Pwo
         vCUAYo/j1hHOfzEa9hZWr9JGXSB0bBltL+KlKKT27P5J/OjtvO7dSFW2XuvLkLxMt9t/
         cI7w==
X-Gm-Message-State: AOJu0YyU2pYG6BOr7AaJY1rXypppqCCb0XrjlQAyLW7lTtwaL+XWcZWl
        wKZm/fFzIbcCHLhMJ+g3Y2k=
X-Google-Smtp-Source: AGHT+IGeZLQumrD19cF7aY8h4mtOeYJZR/V6aKbSBafS7YbxJJODXiWob0SDFrvis9E8NMwIS//bbw==
X-Received: by 2002:a1c:6a16:0:b0:3fb:ff57:1750 with SMTP id f22-20020a1c6a16000000b003fbff571750mr10763840wmc.32.1692825419785;
        Wed, 23 Aug 2023 14:16:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:bb2:6df0:64ae:3840:3a64:b26a])
        by smtp.gmail.com with ESMTPSA id p11-20020adfe60b000000b003176c6e87b1sm20193399wrm.81.2023.08.23.14.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:16:58 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v8 2/7] iio: accel: kionix-kx022a: Remove blank lines
Date:   Wed, 23 Aug 2023 23:16:36 +0200
Message-Id: <b1809c807b0638c9a171ac56e99e9773531610be.1692824815.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1692824815.git.mehdi.djait.k@gmail.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
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

Remove blank lines pointed out by the checkpatch script

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v8:
v7:
v6:
v5:
v4:
- no changes

v3:
- no changes, this patch is introduced in the v2

 drivers/iio/accel/kionix-kx022a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index f98393d74666..ff8aa7b9568e 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -341,7 +341,6 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
 		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
 
 	return ret;
-
 }
 
 static int kx022a_turn_off_lock(struct kx022a_data *data)
@@ -1121,7 +1120,6 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret)
 		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
 
-
 	ret = devm_iio_trigger_register(dev, indio_trig);
 	if (ret)
 		return dev_err_probe(data->dev, ret,
-- 
2.30.2

