Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086F87B7EBC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242305AbjJDMHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242280AbjJDMHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:07:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE638D7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:07:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32487efc319so2032736f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 05:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1696421256; x=1697026056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WWYoB5MEV9gKIjnnbA4n0zDf7a0EYBT3iB0u8uEjVw=;
        b=LfoR86NtzfXiaxpbXUXzrsSvUW6e/C3kGBgO9kdW7ZBxR0q9T2PHUXiT3KnrjDJxWQ
         ukKhOSKnKnVQOc9oZC8LXLk1kWOa+HTwqDUpjDngwG6F6QctzkXbq3zAR14nQvOOtzVw
         F7nQ1MWSADmRfXBAVkeTdTqjOea3qRnGg7yFvWseTFGLcXGXhUOIiAB1wJk2Gf0SZcuM
         8mMU5cd3WA3RXHGJkqvCc56z+MsEAwHXsCjn3DMPwJfhL18rZz5zg3gxgKq2H9LCVSzg
         hGmO6ba1N4uvHujVozsjeEOSu8QLV24fb53cyJelPDMDeCfyPGs+pcZBjMF1rOoF2Ky+
         OOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696421256; x=1697026056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WWYoB5MEV9gKIjnnbA4n0zDf7a0EYBT3iB0u8uEjVw=;
        b=XQt9KpWgSVcl+GeUp+seDx+P0+geXCE/U+l03jofn9DlUxGM9mLjpjZy4DIj29WSUf
         RH9FiX2J+5jNr+bXZYshtpoeHo4mm47+EgFVZ4j1RfKhlePeEn5OXLKeYdYMirjY6sJ7
         mtKtJNEafuL/o75B6/L+QAqZcWodDzinHkmMtCDrnIi6tfEjWXE4ycHcNF49aDXK+o5W
         XYxEzjK1mARYKzKbuW1FyXoK+Hu89B5n5QlRbTjLuGUaKVf8PiyOxMcr1InW88u9GT3I
         3leEhoFgRMveEmSo46Hj2sZtVFgRMxG40AnvmIEsCej4R6Bg7zEIEEc6X11pg+a9M9pc
         xQJw==
X-Gm-Message-State: AOJu0YwJYYSOdOk5P4HmI7qxg3kFZcHnvwh3qrf9/rWFSJcKODkhIn+0
        eYHSZ31m9cGUayUFbFtg7f6kXQ==
X-Google-Smtp-Source: AGHT+IEcMP8TODUTJD3Q6TkG/EtsHwjdZaZi7ZK6bChvVIlU1nrC76GbGZNwPXtbJsPbT3SxcPginA==
X-Received: by 2002:adf:fec4:0:b0:320:459:5a3 with SMTP id q4-20020adffec4000000b00320045905a3mr1672239wrs.33.1696421256204;
        Wed, 04 Oct 2023 05:07:36 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id e6-20020aa7d7c6000000b005362bcc089csm2324665eds.67.2023.10.04.05.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:07:35 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] regulator: userspace-consumer: Update name
Date:   Wed,  4 Oct 2023 14:05:28 +0200
Message-ID: <20231004120529.1155700-3-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120529.1155700-1-naresh.solanki@9elements.com>
References: <20231004120529.1155700-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set name to dt node name.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/regulator/userspace-consumer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 13c0a86ab32c..9030e1d9ce3c 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -159,6 +159,7 @@ static int regulator_userspace_consumer_probe(struct platform_device *pdev)
 		pdata = &tmpdata;
 		memset(pdata, 0, sizeof(*pdata));
 
+		pdata->name = devm_kstrdup(&pdev->dev, pdev->dev.of_node->name, GFP_KERNEL);
 		pdata->no_autoswitch = true;
 		pdata->num_supplies = get_num_supplies(pdev);
 
-- 
2.41.0

