Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BFB807355
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442345AbjLFPGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379084AbjLFPGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:06:05 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CC3B5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:06:10 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so737029b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 07:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875170; x=1702479970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bw38UF76vgagNyzeuAW0hrU8Uw5hhjptrU/a5VxUCtk=;
        b=I7f2DyY1tILulp7SFr3sEtK6PanrwJ2+hcDBGJHfw2tfBriHbm9h6g/iXpfXLkhcz1
         Bx/77oT6oaiCxEwdECQrP9bTnZwGXfIolX4QegKVmlVgvRFLUzLW7pn0YgUgLxPHon8U
         xAktld57JDTHMGzY+EyxpCtV3cdMUi3lwawIdA+RlSHV3ZtASpxAQWcUCXZemmxuC71v
         mQEoyWTLFSGIXfvsQjfumSrtnH9jQggVDTIXB6sxU2ILMDC9GrnBIWDsGdxq34qYvpba
         dT+3WXQDQIDnAE1cE9EwJwlvRnUYy4UyKxcopIVA7W8qSfFY8DMOpx7KF39gmrNSgREg
         swxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875170; x=1702479970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bw38UF76vgagNyzeuAW0hrU8Uw5hhjptrU/a5VxUCtk=;
        b=lwS2EhTVd6gH2txEUv7B+yfMdZSuCAfSrm2HBhs31+KOaM13aHSeESj7+whYUExRcP
         49Z5m0CsXeMrfw81w+y4t0Ctgb4KUD45QED5+0zMLxyY4oaEdDUjOgskFVxXSXAh0BkF
         Ap4XBPPenBnqB8PhRE8eDiHaO1eN2QCnXft8Weu9J4ZfuMNcXuvQc4EFplq0EMY1aEwI
         8JRNI7vwIZi8mDxTagsIp8CQ7BuJUUpURQDeBdb9kvlVYKW7Y4gxR3nbZ7PLkWIsBjTF
         dWNecjwXIq/7lrAuJQtWa4YGHl7krZOTTFg28qQUxyLjS2Ku/1HjrCQAd8xrrXFV+HKK
         9EVA==
X-Gm-Message-State: AOJu0Yy2R3iHTiMYwtuka7/TviGhZsmLKxiXyIEroTVJDDhy5jeZqZsD
        QfYJ94oY5FSMXVB2Hha6OhpObfXjuiBvLg==
X-Google-Smtp-Source: AGHT+IH6HqE9RvfdSclTkOiRnch/r27FsXa/t9/Ngn/smspnV6Y5HuFArcPmNWQUom4uPvb6N3cm6g==
X-Received: by 2002:a05:6a20:a296:b0:18f:97c:384f with SMTP id a22-20020a056a20a29600b0018f097c384fmr1189924pzl.41.1701875170275;
        Wed, 06 Dec 2023 07:06:10 -0800 (PST)
Received: from toolbox.. ([2401:4900:1f3e:53bf:50c7:2988:e019:4b97])
        by smtp.gmail.com with ESMTPSA id s5-20020a625e05000000b006ce7ed5ba41sm96885pfb.55.2023.12.06.07.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:06:09 -0800 (PST)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org, nm@ti.com
Subject: [PATCH 0/1] Make gb-beagleplay driver Greybus compliant
Date:   Wed,  6 Dec 2023 20:35:59 +0530
Message-ID: <20231206150602.176574-1-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In beagleplay beagleconnect setup, the AP is not directly connected to
greybus nodes. The SVC and APBridge tasks are moved to cc1352
coprocessor. This means that there is a need to send cport information
between linux host and cc1352.

In the initial version of the driver (and the reference implementation
gbridge I was using), the greybus header pad bytes were being used.
However, this was a violation of greybus spec.

The following patchset creates a wrapper around greybus message to send
the cport information without using the pad bytes.

Ayush Singh (1):
  greybus: gb-beagleplay: Remove use of pad bytes

 drivers/greybus/gb-beagleplay.c | 44 +++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 13 deletions(-)

-- 
2.43.0

