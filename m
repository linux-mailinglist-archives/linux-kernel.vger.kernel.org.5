Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6691A792BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348136AbjIEREP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353052AbjIEGDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:03:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F561B8;
        Mon,  4 Sep 2023 23:03:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68bed2c786eso1228840b3a.0;
        Mon, 04 Sep 2023 23:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693893830; x=1694498630; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiBuOJI+CBSIVZXrdUCIwxPgk0hrH9gjlhPqB1GT98I=;
        b=laQ4p0HbC2hElTTSGIId3gk68kCbl+/k0gDwgCKvWw/JajajBejHFGuiyeU/PrFtcq
         LSR+nMS26vKTiOQWcdssImxlOBvslumY/VglZJQrBB9PXU93IpvLwmiqk2V4Ux5ZLjL2
         rciaZhNjugv9PwZ/kw4Sz76Zbzd2xX7ryGD8M3Od1Z/Um3AokgTAQVhI8FMyLCAdOcQJ
         YelhicN5XlG0QlBojsgqssmeaQYTlPavfRpTjVoA/UD+4GfRT6Fi3Euc8VSwXfpIvUv0
         NMrOhTt+ghQ+q/BLRvlBFiEVJ8W5pyM3Btao2VCdqxxLoAsEQI8tX8MCSiKsK79+a0rF
         0vsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693893830; x=1694498630;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KiBuOJI+CBSIVZXrdUCIwxPgk0hrH9gjlhPqB1GT98I=;
        b=ZVgf4iTkLx9vVBdYPNtQHXKJnkHlARRruo7lFfe/YOr4Py5MqO5gimIGmwRmk+HAud
         le95q2U9CGP9iVSbA55ETS8ghnsJ8SZiDIEXIsihP75bXWJ527nl3UzqtvUzVIYMB+uM
         N3XR5eBkMSjDuCXIur52+cEF0RuwPq+tOnz6gsirPJ5tmEWmvOVyPnJ+vcmgpmyWDJZq
         gGc8BFAKx3GQVCLhDtGlGxEsSm/0DmLE4vUGZO6pP7AlTnjG2u5CZJTKzGMlxImUy4J5
         hkudvFaxUEgI8JD2e0Pvj4JqrdJbqsdoj7oPhBRVUhFxfP7WCX9em19D3NSk9SCZX1NS
         4zpQ==
X-Gm-Message-State: AOJu0YwHJb8ic1TYxz3Kthp4P3yIsBFM/qiQWVjDME27EdyNYq8aI3cI
        Qe9K9oWz3NFO3OxXrJqebcI=
X-Google-Smtp-Source: AGHT+IFP8zd0itczP3+4VNTwpFdK3waU0XTslf+VWq3OTW1dVfoSL3qvPmwgTG6xNUFXXfIY9L0Usw==
X-Received: by 2002:a05:6a20:8f17:b0:133:e3e3:dc07 with SMTP id b23-20020a056a208f1700b00133e3e3dc07mr12560721pzk.49.1693893830108;
        Mon, 04 Sep 2023 23:03:50 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b001bf6ea340b3sm8482921ply.116.2023.09.04.23.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 23:03:49 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        KWLIU@nuvoton.com, JJLIU0@nuvoton.com, KFLIN@nuvoton.com,
        mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mia Lin <mimi05633@gmail.com>
Subject: [PATCH v5 0/1] Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Tue,  5 Sep 2023 14:03:40 +0800
Message-Id: <20230905060341.5632-1-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since version 5:
  Add global parameter to store part number.
  Remove unnecessary changes for easier reading.

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

 drivers/rtc/rtc-nct3018y.c | 87 ++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 23 deletions(-)

-- 
2.17.1

