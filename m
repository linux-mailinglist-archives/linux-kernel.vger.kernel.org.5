Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18C47A9631
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjIURAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjIURAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:00:04 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2741FDC;
        Thu, 21 Sep 2023 09:59:11 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3adf06730c4so767236b6e.1;
        Thu, 21 Sep 2023 09:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315547; x=1695920347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lHCS21QIk3L+DNjxmnEhYWKsA7WV3a4yGzQ5Vl55Ezw=;
        b=Pa5tZITZ3CCWadoQadyZD6aL+guhR+0eaWnAlzvHe2HiMRaiuWF7GbSrAi30qOODwt
         eMWLXKtS87sIXTgfo1pgiJY8LzsHFs+0IbJl+fxB8B7IfP5HAf3mnuSFKU3GkfQmE1mW
         8JtM9V74Z7iB4TTLRTFExPVjauQoDPNt8nq3ljvioDnrpQvxETXXLiMl79XgDy3OK3ic
         4L+F5rpNWx25spjLEZ99LtiJPZR0wop1nI+ppm9IVetjomROBJdyvViCBN99SHURJoNL
         TLqKFI3iAKSsjEYfSn6CLGhtVoApxGx53YyvQrnnJA2Qsf6Z3TtPYuJok6yowRB0fX4D
         BSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315547; x=1695920347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHCS21QIk3L+DNjxmnEhYWKsA7WV3a4yGzQ5Vl55Ezw=;
        b=joAyIfbHVkXDWiid16SR/hpKY+M6sGWbtc7MoCB8ZZqQctwrVG69a2AqD8tJad/JJg
         XpdUMiodU0v2RfgAV9AP4kP0W+8kqVga9LCO6ebGrGNDDlCJSuYfC9nNkvdA9MAmDL6t
         Knk1G6ky4YlFbd8nNh25yLd5neaaw5ayQz29B62ODzwgt3087O+XAp5I6p7v6bZrexJh
         mDrfOXse6+7bYPD3QNJaNn+HlivgwzQONeed7mk9ERddCQ2vsJhZo0Dksf3lPAcDgX3Z
         fAYoe9wZCneC83rJbACbh7iQZnv62zdFe2XyB0Ilxa9llauoZZZhXTXPiJtUxzGRzhV8
         Rk0Q==
X-Gm-Message-State: AOJu0YxA3yO1PxIbXde9RF21OlsvlvcCHUgYEK/0dwxXrypbOqsgrjiE
        KYUw5QDC/4vT2du+H+l1xf0OXuLtQyI=
X-Google-Smtp-Source: AGHT+IFg5DznAGOg1mVnHhU90rf67WF//DLZRWMgLq1fwB4Dooh3RaTYeCoe6mlIN5gyG9nAAZFHFw==
X-Received: by 2002:a5b:7c5:0:b0:d81:5ec1:80d5 with SMTP id t5-20020a5b07c5000000b00d815ec180d5mr4016062ybq.18.1695272810276;
        Wed, 20 Sep 2023 22:06:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s196-20020a6377cd000000b005789cbd2cacsm347811pgc.20.2023.09.20.22.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 22:06:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.6-rc3
Date:   Wed, 20 Sep 2023 22:06:47 -0700
Message-Id: <20230921050647.4048805-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v6.6-rc3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.6-rc3

Thanks,
Guenter
------

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.6-rc3

for you to fetch changes up to 2dd1d862817b850787f4755c05d55e5aeb76dd08:

  hwmon: (nct6775) Fix non-existent ALARM warning (2023-09-18 11:52:18 -0700)

----------------------------------------------------------------
hwmon fix for v6.6-rc3

One patch to drop a non-existent alarm attribute in the nct6775 driver

----------------------------------------------------------------
Ahmad Khalifa (1):
      hwmon: (nct6775) Fix non-existent ALARM warning

 drivers/hwmon/nct6775-core.c | 4 ++++
 1 file changed, 4 insertions(+)
