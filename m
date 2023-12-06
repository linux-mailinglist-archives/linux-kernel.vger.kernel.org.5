Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D477980712A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378619AbjLFNtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378530AbjLFNtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:49:19 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DEAD4D;
        Wed,  6 Dec 2023 05:49:26 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1d0521554ddso36271235ad.2;
        Wed, 06 Dec 2023 05:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701870565; x=1702475365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciPRe6YN2pQGxH4x4UdwC7mDdjynmra03UkjPaYHC9Y=;
        b=V/YR66p0k2L45JsVD0/g5XGRozTXa/ky/mxgDbm5csyV/ik8nrpln6oQBMtFh02c8u
         NrMUSEK4kpBLFMvL60RNdfvhzG+kvE4fLdrJjrvEkqOa+FbCUG6BI3ApyJ3hJGWSeHDI
         aNF6Ya4Wv7VH84oHWnDwMZNa7OUfhHHoZezFEcHHp9wOLAIBE1QjYS3ZpJw2W4prysKb
         ezdwtS4fpX1qbb+yY2L5fblgdIk4L0W0kVASlayxCDDboyJgoLE+Qz8pY4EQq/BAlHFY
         TLTs9rjS2Hn+idYWi6FfqQ6CDga/5TsTiI1s+J4A0HaW5UJlqQuZ7UXopnk0KHt5RzrG
         YFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870565; x=1702475365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciPRe6YN2pQGxH4x4UdwC7mDdjynmra03UkjPaYHC9Y=;
        b=HLiiErvyKpCTDX8vKoFTTUKDLKnNfYKSq8Ve3yxVIlFxI74R6tQv3bm8xMOptI3bRt
         VV5Zm4PIhxKAF3DINaxecJ34A1bllydWR3EP4nte3WHHcYo+9nvrgvHEJnthlwUyRbyK
         orc59oNGsae0n9V2COUW2pR4CPkTew2IX1iWD+rr+zXWkRmilTx3RO5FoNltb3ZZ5H5o
         x0CeV5lONUFljkAalMfnkD061ORaU/8AZdGM6zkNvJYQitlDB96ffAgylpMhM92HPy76
         Ozbh8EknOrHIGsbJ/fKcNrIGjYgnaaP26Bq7SPeMWr6gHtDxZFuhRj085s/whYAnbb7B
         XewQ==
X-Gm-Message-State: AOJu0YyQKeyShYNgoJkDmwMkt6yI5Jr1f1Ky5l62IhQL8ZqFu+C+KrPe
        gRZ74CrgmRcA6fKL/yYK6RM=
X-Google-Smtp-Source: AGHT+IHvxUx3TNy3cnv0x8mKZU1d6/LnKbh7lRZy/1lQf3tYYuzJlJKVRFicrjLRCmr2rg5CVtAyIA==
X-Received: by 2002:a17:902:8301:b0:1d0:6ffe:1e91 with SMTP id bd1-20020a170902830100b001d06ffe1e91mr577180plb.116.1701870565444;
        Wed, 06 Dec 2023 05:49:25 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.59.249])
        by smtp.gmail.com with ESMTPSA id jj15-20020a170903048f00b001cfb93fa4fasm4733824plb.150.2023.12.06.05.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:49:25 -0800 (PST)
From:   Li peiyu <579lpy@gmail.com>
To:     jic23@kernel.org
Cc:     javier.carrasco.cruz@gmail.com, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] iio: ABI: document temperature and humidity peak/trough raw attributes
Date:   Wed,  6 Dec 2023 21:49:15 +0800
Message-Id: <20231206134915.559515-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206134655.559474-1-579lpy@gmail.com>
References: <20231206134655.559474-1-579lpy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

The in_temp_peak_raw attribute is already in use, but its documentation
is still missing. The in_humidityrelative_raw must be documented for a
new iio user that supports this attribute. Add temp and humidityrelative
use cases.
When at it, remove an extra blank space in the description.

For users that support minimum values, a new in_<type>_trough_raw
attribute is required. Add this attribute and document the first uses of
it for temp and humidityrelative types.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 19cde14f3869..dc1c7df6a19c 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -362,10 +362,21 @@ Description:
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_peak_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_peak_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_peak_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_peak_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_peak_raw
 KernelVersion:	2.6.36
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Highest value since some reset condition.  These
+		Highest value since some reset condition. These
+		attributes allow access to this and are otherwise
+		the direct equivalent of the <type>Y[_name]_raw attributes.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_trough_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_trough_raw
+KernelVersion:	6.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Lowest value since some reset condition. These
 		attributes allow access to this and are otherwise
 		the direct equivalent of the <type>Y[_name]_raw attributes.
 
-- 
2.34.1

