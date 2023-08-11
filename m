Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036C2779AF2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbjHKXFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235890AbjHKXDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:03:38 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE66D3A81;
        Fri, 11 Aug 2023 16:01:45 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34977c2dc27so9070945ab.2;
        Fri, 11 Aug 2023 16:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691794905; x=1692399705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qH48f5Rauhy4XHNHiCzl0hFwNsntFmy/BGkbt5h6IgE=;
        b=TA2HfW508CzNE3QGjhlPYmndgQhZs3pRUoA9Gre13gj7Pk+8AkZUQpxL0QeiB0k7k2
         5vfRhYirTzjVMRnYpb3BSgraqtYyJ0/wtyqAy7TmfoF36F1duwKtlHoYKBMnoFTy7cxX
         oJGJAMmMipo9zK799UDw+1g++KHyZlBT6wVBPCVulslh7u30oJrGjWPzfXciWK7NlvGm
         8rD/f80PMsPO4Hfkf3JVsvvTxlni1iwVB5e2K/DDjV+AwpmQedp9c7H9fdfk7QPccivn
         wMHVGnEjL8gKSTcF6cdBVhBrDbyx0+i/AmCRZKh2sehE077gKc2S+ShlCkcVAbKrBGbj
         r1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691794905; x=1692399705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qH48f5Rauhy4XHNHiCzl0hFwNsntFmy/BGkbt5h6IgE=;
        b=GURs0MCw8xljRaspsqUMBY6AAWbvHqidmhBWJG5wkuXxa/Is7OZsjcIs2/0PgV9a+P
         1tnqXiGao3kUq//kNJ1QB0Q95c1yFtccNiT88REaQJrO45q/sNNgpU+NfAZhfMTKL1H9
         e/runB5FD523SQYDiQo+VmO3H6o3FHHfAZh2H3ByVXjd7Ud1WG7I0Fn0o1LI8joXHfW4
         iPsJScxKRJ7xMhzptH/VIDQdE1e+sLv7qJhPaAodQp5ApL6rztBiQI9OuJLZScpH3iQ0
         Xkn5Efyk4WrNBLMiZYCMrXyIimzesDcEMbs+X/wq8j6XJcVnbKzuEOHxOhS+Ay+Ws8mV
         jlRA==
X-Gm-Message-State: AOJu0YyhlbSPIf95hvPUuumDBOeCKGc9RVOyebsBgKVle0UVF/QE843E
        v2o0jKnSyuVF75wU8XZVo7vzDKmn67M=
X-Google-Smtp-Source: AGHT+IHNjuN2Yz8k8ESxlvp0AeCvzu357qz0rm7F+GmnI4qiYi/LK4oOkR7bYTjaBh0oF+iVVireqQ==
X-Received: by 2002:a05:6e02:156a:b0:348:6736:6605 with SMTP id k10-20020a056e02156a00b0034867366605mr4358469ilu.9.1691794905018;
        Fri, 11 Aug 2023 16:01:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m16-20020a92cad0000000b003493a5b3858sm1421955ilq.34.2023.08.11.16.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:01:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.5-rc6
Date:   Fri, 11 Aug 2023 16:01:42 -0700
Message-Id: <20230811230142.2291484-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v6.5-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.5-rc6

Thanks,
Guenter
------

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.5-rc6

for you to fetch changes up to 56b930dcd88c2adc261410501c402c790980bdb5:

  hwmon: (aquacomputer_d5next) Add selective 200ms delay after sending ctrl report (2023-08-09 21:09:47 -0700)

----------------------------------------------------------------
hwmon fixes for v6.5-rc6

* Fix sporadic comunication errors in pmbus/bel-pfe and
  aquacomputer_d5next drivers

----------------------------------------------------------------
Aleksa Savic (1):
      hwmon: (aquacomputer_d5next) Add selective 200ms delay after sending ctrl report

Tao Ren (1):
      hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK for pfe1100

 drivers/hwmon/aquacomputer_d5next.c | 37 ++++++++++++++++++++++++++++++++++++-
 drivers/hwmon/pmbus/bel-pfe.c       | 16 ++++++++--------
 2 files changed, 44 insertions(+), 9 deletions(-)
