Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E620C756FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGQWZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGQWZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:25:39 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4289AD;
        Mon, 17 Jul 2023 15:25:38 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b9c5362a51so1959589a34.0;
        Mon, 17 Jul 2023 15:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689632738; x=1692224738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8+m1PD1OV/T4vMth1o/3b8d3uLDURVNRPW6GjP1Nfs=;
        b=TDebd7yPRGqPxaM5ODAw7ZQJy48JGvV0rw0DfVAXn2C6meWRSrVMVJDmWiIbeqUiV7
         XxjcZqULoUkkl9g7Z83ez/BprYj/3IoAGNede/r6FGS/DCc7GYQK/THKGJGMomyygkcS
         kboyn2Xzj0Gn17uZ1zreypTjKKgeeQ8apmmZHk9GZ2/EEuYKtcV5b9UXBWaVaUI5O8Dq
         0d+2NycV/hXszI8s24d1ZBbKd+6f1jKbKiqjFcNw2sg07tWRpI104SJqqJu2mxxbyl1n
         lblYGKB4HEs50hF1XTWHH0Uko3gSA99VTd1SnpJhV2X3+0Unh4cIwWeCx5VPh6igCLFb
         U3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689632738; x=1692224738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8+m1PD1OV/T4vMth1o/3b8d3uLDURVNRPW6GjP1Nfs=;
        b=P67ty9yssiWmLRLKDWIYUi1l6M047VjbahpDQnuRMcrknfZLk3/tRLsvKy6rfPKVUr
         rq8wQku6UkE3Wtd1xUCSYhw2So9n1vg5ih/lEf9uMW2xT17+CqB7y6EmIPwTjzhTjxSi
         5C7ErE9jVvVjVr/7pcNXX+u+0hVuyib0aJtW9+P333pMpaUFL8yQAFEQTdG296FlMEAs
         y8XvAdYD+tzyDSrGq5Z38TiTdXzlxjGG/8JUolZU6Ba0QirqIslF64AKvpgINEXQjdeg
         6Qd75ouOSR5aRuLS54vMq4iSqBwjvMlqvpV1vFthLov/AmQSC8sx3QWjMsTs7vUb7Vzt
         z99g==
X-Gm-Message-State: ABy/qLY53nUqrQbnpiXh/iPUTW+puGXRHH1URWA2MkElMk/z9ENoQOyq
        1KNv7lYiwSqY/Sz4oEaIswQ=
X-Google-Smtp-Source: APBJJlE93PlA0GYL94amq0efR62QSmGXji/PUCV3v2ijHpfI15OSX5gTuP8Yfhc1HHAC/lu7FN0Bmw==
X-Received: by 2002:a05:6870:589b:b0:1b3:eec8:fa94 with SMTP id be27-20020a056870589b00b001b3eec8fa94mr13299018oab.7.1689632738096;
        Mon, 17 Jul 2023 15:25:38 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870374700b001ba72480f2fsm385553oak.43.2023.07.17.15.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 15:25:37 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v2 0/2] hwmon: (oxp-sensors) Refactor probe() and init() and remove devm_add_groups()
Date:   Mon, 17 Jul 2023 19:25:14 -0300
Message-ID: <20230717222526.229984-1-samsagax@gmail.com>
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

Also move board detection to the init() instead of probe() function so we
don't instantiate the driver if the detection fails.

V2 drops the 3rd patch that removed the probe() function.

[1] Link: https://lore.kernel.org/linux-hwmon/ZKW7WuP0T9QdCR+G@google.com/

Joaquín Ignacio Aramendía (2):
  hwmon: (oxp-sensors) Move tt_toggle attribute to dev_groups
  hwmon: (oxp-sensors) Move board detection to the init function

 drivers/hwmon/oxp-sensors.c | 67 +++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 28 deletions(-)

-- 
2.41.0

