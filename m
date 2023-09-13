Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E8D79DDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbjIMBhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIMBha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:37:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C8710FE;
        Tue, 12 Sep 2023 18:37:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fc081cd46so2634224b3a.0;
        Tue, 12 Sep 2023 18:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694569046; x=1695173846; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh2Jx+3S+9JoD1fd1NoMZMT1+EHOY1WNMnptmQPxXtE=;
        b=Tv9sozEEi5mF8gmqVWKKH7RSQzKTJ2ncHBImcbk/4KmAfThG06XOPm2oizuMjK6kyB
         EQZZeZhwRDEvAzXZ59I3I/n6xAaTFpG/UzBMKWLaOvnSc20oo8giAAEmb9J9LAzTnaz9
         fhGvqEGHA/K8QgzQjwZcvvwvmDQmksPt56JYFM+9WIWiOVOHcciPP4cSPaacEFETIMuN
         SIYQDN1JlG+b7O3b2FAewCL0vb4TyzgPFjx3nOT6yd9Q7MT7HRZ9MKnCQbotcAT9IF/o
         hVhrdLcey1u3x2jXhISKgNALGcskO0aR9VqAhMiLA8Gss+hYR4U9NwliyHswNx1Ichbs
         lUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694569046; x=1695173846;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fh2Jx+3S+9JoD1fd1NoMZMT1+EHOY1WNMnptmQPxXtE=;
        b=seArTEx1w39ZlMdzkUKUKHt/9hFKXgo4RwgmWnGjGUh6Qr29SVu+8+00fApdeFcvdh
         FLgDMqR+CX3B1hGW80Rca+g3Jk5MiSqe6OHaGoJ/e+6rVmIeOiy2C/BCIZSmTvevlvjJ
         g2TF5HwcsZMuv5u5T19AlLXXVA1FAHqUEFfGu7QnFeZ+CjeifFy+mu5CSkh/+ETXKJrl
         WojLmrT0DVz+UYPdHJ8u+PnmHT7IrT5RqlCY3259FFpRynuRkg3Fda2M0Mpye6dlrz6V
         CDTiXFTjanT1+Fe0eNtomEuwICe//UivALVOqjmx0Sap1IDW/oegJd0NJlkpN+aTFIKu
         D/1g==
X-Gm-Message-State: AOJu0Ywg+KGn/JYThKEqU/FHrCY4ddw1RYUlCIVMA3+oh2fsCvFXtJKE
        JVchnRKgBqHsC80LcN+OL/o=
X-Google-Smtp-Source: AGHT+IH8zbLKTSdUX5D73pqq4SUlqTUyb6QdU05sKLMXfE9pkui4MoWrEShh92TtebO7wHppGkimLw==
X-Received: by 2002:a05:6a00:1584:b0:68f:efc2:ba46 with SMTP id u4-20020a056a00158400b0068fefc2ba46mr1516597pfk.25.1694569046160;
        Tue, 12 Sep 2023 18:37:26 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id l20-20020a62be14000000b0068a0c403636sm7874648pff.192.2023.09.12.18.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 18:37:25 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        KWLIU@nuvoton.com, JJLIU0@nuvoton.com, KFLIN@nuvoton.com,
        mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mia Lin <mimi05633@gmail.com>
Subject: [PATCH v6 0/1] Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Wed, 13 Sep 2023 09:37:18 +0800
Message-Id: <20230913013719.8342-1-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since version 6:
  Move the part number parameter to struct nct3018y.

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

 drivers/rtc/rtc-nct3018y.c | 52 +++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

-- 
2.17.1

