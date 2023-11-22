Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A43D7F44BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjKVLOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjKVKko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:40:44 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67449D8;
        Wed, 22 Nov 2023 02:40:40 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40842752c6eso33497995e9.1;
        Wed, 22 Nov 2023 02:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700649639; x=1701254439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BWEJ4p5oF5My5H+DDjkWQZxD7K1sIs4EyPFQ443g1H4=;
        b=VWsJGUBb8EBUm7ej/c0zQFMab/O4pQVtVTH3ZO6dBlC5zXXR27p48vhEF+dc8vdd6e
         n7ZbG8XwSV6jKq1ez93v06NkFMq6y3rIDeXHlw5wWly7i/ugi36b7vsDj7d8/cwmF9fm
         1etZnxnFnYAvv0vnrYcGd/Qj8seRnl8qBSTF70LrSxFwbZGWd1KNOEML4QcUCIKizwPB
         IeHnF4MOEc/U0ZuztamO6GIsCpghJie8j50cus5HdxExkT+I0RXX9sEcDgAiKD0mRoZ0
         amgM1nKvRejltW3X1diangbnSe3sDapVGqZ6l6Uh9qt1/pRZ0aEQxkyVI0UxJ8VH8UlG
         rkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700649639; x=1701254439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWEJ4p5oF5My5H+DDjkWQZxD7K1sIs4EyPFQ443g1H4=;
        b=YWx1OLXxT3eQvWYu9LngtdA562hDAL87BammzKZFpNVgJevoIEhRqH/XPrVCy9KH2s
         0cmG7Y+r5Oy10bKn7/IpHHbcNqWWkj/bs5SHdVwL4xviiq3Jv0OxJqbv6QnmE43kgfHh
         8UR50wVu94sxWGaNpHG8APkbEW0Z20xkuoRjY1mLeqClrBeVrXHHkfKogH92rCJydZQ7
         fyyf+jecJIOqF6yWHf8Syhjrk72pXZWAsSqvu8iENygAZUhBhL8nSsh6H/NRV5fSdSHc
         8I5P+9y2bVHx60dl9slMX+FkIacul82sRKrhfEPUeDPI0vaLiDQa2Ndd/wWHMERd+fcn
         IeBw==
X-Gm-Message-State: AOJu0Yx31RlObvdde5flVCXR2dtJJz34Pnd7lBq08Y/Ld6KLK3KhvnXu
        jIY0APzRvTkxlN/48WsG2KuD5nx2DLA=
X-Google-Smtp-Source: AGHT+IF6GNB6My6d4ckpfPXb5FpSvJHkY8U2dwMLOBnvWWoqEBHBNpcSvcG+3C2flxq0ONjc8hSHRg==
X-Received: by 2002:a05:600c:4f44:b0:40b:2a7a:fb11 with SMTP id m4-20020a05600c4f4400b0040b2a7afb11mr1346905wmq.25.1700649638494;
        Wed, 22 Nov 2023 02:40:38 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b004094e565e71sm1781756wmq.23.2023.11.22.02.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:40:37 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scripts/spelling.txt: add more spellings to spelling.txt
Date:   Wed, 22 Nov 2023 10:40:37 +0000
Message-Id: <20231122104037.1770749-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Some of the more common spelling mistakes and typos that I've found while
fixing up spelling mistakes in the kernel over the past couple of
releases.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 scripts/spelling.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 855c4863124b..edec60d39bbf 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -26,6 +26,7 @@ accelaration||acceleration
 accelearion||acceleration
 acceleratoin||acceleration
 accelleration||acceleration
+accelrometer||accelerometer
 accesing||accessing
 accesnt||accent
 accessable||accessible
@@ -137,6 +138,7 @@ anniversery||anniversary
 annoucement||announcement
 anomolies||anomalies
 anomoly||anomaly
+anonynous||anonymous
 anway||anyway
 aplication||application
 appearence||appearance
@@ -267,6 +269,7 @@ cadidate||candidate
 cahces||caches
 calender||calendar
 calescing||coalescing
+calibraiton||calibration
 calle||called
 callibration||calibration
 callled||called
@@ -288,6 +291,7 @@ capabitilies||capabilities
 capablity||capability
 capatibilities||capabilities
 capapbilities||capabilities
+captuer||capture
 caputure||capture
 carefuly||carefully
 cariage||carriage
@@ -340,6 +344,7 @@ comminucation||communication
 commited||committed
 commiting||committing
 committ||commit
+commmand||command
 commnunication||communication
 commoditiy||commodity
 comsume||consume
@@ -406,6 +411,7 @@ continious||continuous
 continous||continuous
 continously||continuously
 continueing||continuing
+contiuous||continuous
 contraints||constraints
 contruct||construct
 contol||control
@@ -757,6 +763,7 @@ hardward||hardware
 havind||having
 heirarchically||hierarchically
 heirarchy||hierarchy
+heirachy||hierarchy
 helpfull||helpful
 hearbeat||heartbeat
 heterogenous||heterogeneous
@@ -1199,6 +1206,7 @@ priting||printing
 privilaged||privileged
 privilage||privilege
 priviledge||privilege
+priviledged||privileged
 priviledges||privileges
 privleges||privileges
 probaly||probably
@@ -1251,6 +1259,7 @@ purgable||purgeable
 pwoer||power
 queing||queuing
 quering||querying
+querrying||querying
 queus||queues
 randomally||randomly
 raoming||roaming
@@ -1324,6 +1333,7 @@ reseting||resetting
 reseved||reserved
 reseverd||reserved
 resizeable||resizable
+resonable||reasonable
 resotre||restore
 resouce||resource
 resouces||resources
@@ -1427,6 +1437,7 @@ sliped||slipped
 softwade||software
 softwares||software
 soley||solely
+soluation||solution
 souce||source
 speach||speech
 specfic||specific
@@ -1458,6 +1469,7 @@ standart||standard
 standy||standby
 stardard||standard
 staticly||statically
+statisitcs||statistics
 statuss||status
 stoped||stopped
 stoping||stopping
@@ -1548,6 +1560,7 @@ threds||threads
 threee||three
 threshhold||threshold
 thresold||threshold
+throtting||throttling
 throught||through
 tansition||transition
 trackling||tracking
@@ -1571,6 +1584,7 @@ tranasction||transaction
 tranceiver||transceiver
 tranfer||transfer
 tranmission||transmission
+tranport||transport
 transcevier||transceiver
 transciever||transceiver
 transferd||transferred
-- 
2.39.2

