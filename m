Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64778807124
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378550AbjLFNsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378499AbjLFNsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:48:30 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5CAC3;
        Wed,  6 Dec 2023 05:48:36 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1d0ccda19eeso11718615ad.1;
        Wed, 06 Dec 2023 05:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701870516; x=1702475316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuRiXX+tHD8qpaoQh6okUrfYXevnVhYrWjiozg0Jp5A=;
        b=UJvXA19LveTth5rIb+QtqYfTJiXYlRue04PwaX1gggDwVZ3kydnyH2gUEGXfYcMVmR
         NdkAIHJmGwQ++Ray+Hra2BiLHhddEN8qjtakywsRxHxhqAijLdiMphwiPrBjifuo89Tl
         VZiF7kg6dXaWe0Qx4RBaW3HBNGVIZ985n+7FKRsHji4IYFx+tLbgGWf+8AH5m3xTq4Xc
         6niRLdoycjNig5WtQ5tb96jghtfXn9+OVfm94aB/BAXxA4pGEbs6sZcACMIXTNvVpQac
         Ln0u07GzmXhlqdV+LK7h7PDyLF7UyzEtBkJhIraLTlAFSouHHH4WuWlhPyHfLf6bKlVG
         Mz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870516; x=1702475316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuRiXX+tHD8qpaoQh6okUrfYXevnVhYrWjiozg0Jp5A=;
        b=nZAdDiIecLjD+f6BNBK1UpiCb2T0SPbPpCBOkSq+9Ouy67dcp9dNyHHn8FiyvlJLeP
         Bf5Tr3HqaD8BAr7OYmc7N01pXOKDS+UtxuznATvYEt6CSWHx7KIyAcYzmTYNFkU8V3pY
         /W0hKfrKiB549kpi+r+BF6ADTDXJ0L2Y0AiS/KkLKYdxu3y7EJzqEkmFgG37p83xIVWi
         L+jTS8HNNlnuQgzQ8EoOPvOxS3LmNk/2RvSyM+jm+aDg8z0Qd+oyyF77wjSUx3Q9Omdn
         JPKBvzd8adt7QVktCdXcvkOo3G9asPOFPj8Pdjg1/PwoYvIVFcRCEFkhQIwN6+wQQcc1
         8AFg==
X-Gm-Message-State: AOJu0YwY35qj957yqbx96jW4CGN1ZnkjNtrQ+KRItcjV6uq9fBnvcev6
        wQx3b1kQ53eTEGxknfYzHz0=
X-Google-Smtp-Source: AGHT+IHJCnNN6jAi/auxopsAFgFgPJ/SKihWkFX7W9wBYi3ra5wXzfUbJT2PlIu9KFCLvS7T3bCOUQ==
X-Received: by 2002:a17:902:c40d:b0:1d0:6ffe:1e90 with SMTP id k13-20020a170902c40d00b001d06ffe1e90mr639926plk.115.1701870515952;
        Wed, 06 Dec 2023 05:48:35 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.59.249])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b001d055328e1dsm3525812plb.223.2023.12.06.05.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:48:35 -0800 (PST)
From:   Li peiyu <579lpy@gmail.com>
To:     jic23@kernel.org
Cc:     javier.carrasco.cruz@gmail.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] iio: core: introduce trough modifier for minimum  values
Date:   Wed,  6 Dec 2023 21:48:19 +0800
Message-Id: <20231206134819.559496-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206134655.559474-1-579lpy@gmail.com>
References: <20231206134655.559474-1-579lpy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

The IIO_CHAN_INFO_PEAK modifier is used for maximum values and currently
there is no equivalent for minimum values. Instead of overloading the
existing peak modifier, a new modifier can be added.

In principle there is no need to add a _TROUGH_SCALE modifier as the
scale will be the same as the one required for the INFO_PEAK modifier,
which in turn is sometimes omitted if a single scale for peaks and raw
values is required.

Add an IIO_CHAN_INFO_TROUGH modifier for minimum values.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c77745b594bd..351c64c2f4da 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -182,6 +182,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
 	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
 	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
+	[IIO_CHAN_INFO_TROUGH] = "trough_raw",
 };
 /**
  * iio_device_id() - query the unique ID for the device
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 117bde7d6ad7..d89982c98368 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -68,6 +68,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
 	IIO_CHAN_INFO_CALIBAMBIENT,
 	IIO_CHAN_INFO_ZEROPOINT,
+	IIO_CHAN_INFO_TROUGH,
 };
 
 #endif /* _IIO_TYPES_H_ */
-- 
2.34.1

