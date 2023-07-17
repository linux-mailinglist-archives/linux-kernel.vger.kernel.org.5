Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF957562E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGQMkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjGQMkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:40:41 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9F1E47;
        Mon, 17 Jul 2023 05:40:40 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1ba79f16f4cso1108227fac.3;
        Mon, 17 Jul 2023 05:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689597639; x=1692189639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LfL84LAIi1r27lZlLbd37kGrrsw2l29HoDFKJOl4Ac=;
        b=bl7pi9BwVeVvPvArUJ1DgctUD5M5O5JzJO6HoBMf5wql6uv05L9lN2w32IQtkPz3Xf
         R1farv7PIGwje5Rc2optcizkz9QxGdqXuwsCn4EV4Cw1GE7AUKytNqgLo9vAtupe2IaC
         3Lg5pInY1pvIGl3WTTLzdZM5QIzilR+T7Lul7DbWtzvVWok3CvO5T98XvXLH/cxkG0/B
         dGApxNxU/FQVtdhpbSw2uoq7aC6C2CH35Z2JhG1m1PCrItNvomkFC5qmYxDgzM5m1KWM
         kfSKELkKeKg/RiPxD4+bQwMnyCxPt5eqBoKsQ4YM4ErPmer8KdIWJWP0wsLaEqwt52ZI
         WIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689597639; x=1692189639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LfL84LAIi1r27lZlLbd37kGrrsw2l29HoDFKJOl4Ac=;
        b=SNdR7MJTUPg1UpYjghk8IFRY3N/ya3xZzK9xaY78+3R2xy8empFSR8HrJGqoFuOl4x
         d3vd/TTye/3z9NtQPUVWzXj4ZpAPlkDRBrWII6OKATlIeHCgF+00QSRIpkgorwMrSE4O
         JcXYbUHDBNGVLlG7GgJIQoZY0ZZoCO/jq6FhexfohVf8DsNkNe2/8TAFiBovZBzz1LuX
         CXsvCRVQYjyhIoSZO9rcSrSKZPgMLu18gTdTj1tN1B4jAIC/UEfF07Ki8ZvX1vNoAWVO
         IimPvVLtvO+HMAzGW4WNnAqhLt0Rg5kbb9wHVB6Sc7qznAofm7TreVNYKknMVoZqzHRS
         MOdw==
X-Gm-Message-State: ABy/qLaCLOFWrdAyEXIHFyY1x9u/699Fubze4WjSzZEhNeMm3qx7jZxh
        rzrUlL3dMS/d6WTdNG/8dvm/dbT6Nuw=
X-Google-Smtp-Source: APBJJlGyWP4ZzUIV/vnHnzuwRBHd33zJBe810WUJc3blUoPl3Al2kg9yBbOYcJRCdfAIu8L9XRNFUA==
X-Received: by 2002:a05:6870:708e:b0:1b0:2fc3:b4f1 with SMTP id v14-20020a056870708e00b001b02fc3b4f1mr14389162oae.9.1689597639341;
        Mon, 17 Jul 2023 05:40:39 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id em30-20020a0568705b9e00b001b02a3426ddsm7032173oab.14.2023.07.17.05.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 05:40:38 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 0/3] hwmon: (oxp-sensors) Refactor probe() and init() and remove devm_add_groups()
Date:   Mon, 17 Jul 2023 09:40:03 -0300
Message-ID: <20230717124013.38796-2-samsagax@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Remove the use of devm_add_groups() in favour of dev_groups in platform
driver structure. This will allow for removal of the function as it was
intended in Greg's email[1].

Also since the driver is not hotpluggable move al the initialization and
detection logic to init() instead of probe() so we don't instantiate the
driver if the detection fails.

[1] Link: https://lore.kernel.org/linux-hwmon/ZKW7WuP0T9QdCR+G@google.com/

Joaquín Ignacio Aramendía (3):
  hwmon: (oxp-sensors) Move tt_toggle attribute to dev_groups
  hwmon: (oxp-sensors) Move board detection to the init function
  hwmon: (oxp-sensors) Refactor init() and remove probe()

 drivers/hwmon/oxp-sensors.c | 81 +++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 35 deletions(-)

-- 
2.41.0

