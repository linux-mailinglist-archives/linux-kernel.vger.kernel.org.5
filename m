Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC607774D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjHJJnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHJJna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:43:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894151724;
        Thu, 10 Aug 2023 02:43:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bb893e6365so5512435ad.2;
        Thu, 10 Aug 2023 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691660609; x=1692265409;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWehwRx2Inhk/fUq70jnCFdNYEvhO3U8cIjUBtfVKAI=;
        b=cWEuGD9kr0kHJaa02VTFoYW7Scd7qcX9gZNN7GRBdJHXAKxiTKl3Sxqi/1k+lRq7f/
         5YNEKQVBPgb1al5KYky+hRBgXRjOSHo5N2/F74tPmPzDMY+dFNnOigkiQ6NruWAq0D0x
         BB6x4eARlTU6NokPR5sKkhlAT9+60G40q/3LWlfHtMXlL5B9FdxfnsjoS8TbXRY1oh8z
         vDPNjtMKbR7HLUXPe9mUhcNIvBgn1eD3NdLbHFO8oPMLmniYAD9jdJBcNDZRB6/ZwVje
         jrWbOoVL0743R6j9tf4YpZAjyPgwb3sGLwAGxiioneRZqobVUU6ZbgCfV/UuHxPwFrSD
         OFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691660609; x=1692265409;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWehwRx2Inhk/fUq70jnCFdNYEvhO3U8cIjUBtfVKAI=;
        b=QS1SrRDzfVZ+29ehIn7yRlmFdZHehyZR/cZ05XKfUCeRGj5JccWs90p075eswVzwI4
         UmGAqRa9q60rbiqwgeWS83NLVxKl0ss1r6YuTZDB9zO5ILpD/TrPL5w46i551HL9DWFU
         8eLNzFQtRH6gcEIjrEbERtmDC3DqhzZ7zBZUGrdOE0rods+Cto2APiGVks6I6kTpRH3H
         LQVPsQszd1S5x8asrFr/g2EQt8oBfDu7wk2Vin1YVjuxk868CaimWCQHgTP1EsJS08NM
         sqv6WbSpbuAo6YJ2tPeEhyKVBY9MtgPV5ZMF+Q3x5q4XuMv5tiBMrBa1h0AzooW47N/l
         1s/g==
X-Gm-Message-State: AOJu0YwispNbhlYO4LtIIQXvFWAaGxxxIcIQHf+alqBGWH+fqQWDn9Xc
        HkevCiKpoU1KLR2jVun93yQ=
X-Google-Smtp-Source: AGHT+IF3PCCPrn6HxRQlivjViuAxLBokR9KAe12ZdDvbvawzvVjZUgETjcH3B8CsXzBO4ugHOSiXag==
X-Received: by 2002:a17:902:bd0b:b0:1b2:4852:9a5f with SMTP id p11-20020a170902bd0b00b001b248529a5fmr1367143pls.54.1691660608854;
        Thu, 10 Aug 2023 02:43:28 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001bba3650448sm1233665plb.258.2023.08.10.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:43:28 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        KWLIU@nuvoton.com, JJLIU0@nuvoton.com, KFLIN@nuvoton.com,
        mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mia Lin <mimi05633@gmail.com>
Subject: [PATCH v3 0/1] Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Thu, 10 Aug 2023 17:43:22 +0800
Message-Id: <20230810094323.20077-1-mimi05633@gmail.com>
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

Changes since version 3:
  Remove the comparison between DT compatible and chip data.

Changes since version 2:
  Add DT compatible to check the chip matches or not.

Changes since version 1:
  rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R

Mia Lin (1):
  rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R

 drivers/rtc/rtc-nct3018y.c | 63 ++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 9 deletions(-)

-- 
2.17.1

