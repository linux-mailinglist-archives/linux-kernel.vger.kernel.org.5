Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFAA77D7A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbjHPB02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241014AbjHPBZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:25:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9E42121;
        Tue, 15 Aug 2023 18:25:56 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68872ca740bso805344b3a.2;
        Tue, 15 Aug 2023 18:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692149156; x=1692753956;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS73907VIaCeI53gzLLDOXrTmdR8uzZ1TgnhrmdjAfE=;
        b=W2BVuarHi+6pbrQsl6hiKrxEXM9fXIA6Su8DOcpzFEbDu4//L9sLF6EgJaZhkvnUev
         N+6t2NTVAFl4kSpxLw1uez5Hr9nAKkejmVBfrO9jWHRUGfWjoY/MKlNxovAqpdnq3q+F
         Ol7+C2hR62tDDpgSDlO8yl9qHCUUEBBrVG5BkoP3jgS6hXSIOzRgzsThrOwRSzfSSr4m
         H5i1bOOFKxV6J5Hkbz5Rz5FSTmBGa8uqXf6OdKg/L35iBDzSz4D2iMajGiyz5b1/I+TV
         55Eh8VMUCMAHp2oRIyjIwcYbU5JwLH/Xa13gWByWSA171lnThMuEJQIsSN085rlWkHYb
         uVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692149156; x=1692753956;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eS73907VIaCeI53gzLLDOXrTmdR8uzZ1TgnhrmdjAfE=;
        b=ZN+r1OhBlh82JjyLxfYd8tmdSsRnlLIEvPFzFDa3EUT/BQxYixd7Lu7UJBOCllZfvt
         1rC6yRYc/SNTBoM2YsF+xRhiAYZCWU83fooZ0iTKLGmGuSJIO7j+hCeH5QYADdBOE6ue
         5/4mBKqYV/1jK9j1X53drUQV2sXt78/rp2sankJWc7T+JPecq1UaWAJkWOwpCt94BlKN
         LASFWx7DkZVwZb2dhl0qG1ahng1Y2DdJ9A7KA7wGdkWBhezPio/XSNFC7tlPsG50AlpW
         YavFoBQvtpZZ5AARHSPhBnI67celkBDisUlUwnM2YycGIQWnZCzAyS+TFRLt5WJ6MBR/
         P83A==
X-Gm-Message-State: AOJu0YwDz77Vmg7aktER3xaEPvU89iNmmUFcfa5RZjahgUTYOv37VuAS
        M5XJcjl4V0dLBHi9xELu4Wk=
X-Google-Smtp-Source: AGHT+IHKxroaeDsPMZSPoBDxdrhVDk2WoFodBQQXZmJfm7VKR0XuLLTGvJIobdyYW/H8EJzlkqDyDQ==
X-Received: by 2002:a05:6a20:42a6:b0:135:110c:c6de with SMTP id o38-20020a056a2042a600b00135110cc6demr769678pzj.6.1692149155478;
        Tue, 15 Aug 2023 18:25:55 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79251000000b0064d47cd116esm9895468pfp.161.2023.08.15.18.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 18:25:54 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        KWLIU@nuvoton.com, JJLIU0@nuvoton.com, KFLIN@nuvoton.com,
        mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mia Lin <mimi05633@gmail.com>
Subject: [PATCH v4 0/1] Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Wed, 16 Aug 2023 09:25:39 +0800
Message-Id: <20230816012540.18464-1-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since version 4:
  Add an introduction bewteen NCT3015Y-R and NCT3018Y-R.
  Restore the initial value of err in nct3018y_rtc_set_time().
  Refine error messages to pinpoint the correct location.

Changes since version 3:
  Remove the comparison between DT compatible and chip data.

Changes since version 2:
  Add DT compatible to check the chip matches or not.

Changes since version 1:
  rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R

Mia Lin (1):
  rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R

 drivers/rtc/rtc-nct3018y.c | 122 +++++++++++++++++++++++++------------
 1 file changed, 83 insertions(+), 39 deletions(-)

-- 
2.17.1

