Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E78B78443D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbjHVObH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjHVObF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:31:05 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B60FB;
        Tue, 22 Aug 2023 07:31:04 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4106b6aa94bso29829221cf.3;
        Tue, 22 Aug 2023 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692714663; x=1693319463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OcEW3HG1uQnuo/0JN3vRz86npLk/Ya1ZhqBpKC2zxxg=;
        b=HLRgPsPpJLbsqSsiWSmIBbbcetXlN3wudneshLX4f8NEVk1Al8KXSInZviDnOIiryb
         1p9Y0jYG8PX0ySG6PcbpkgLqyc0mokOPHvyFhExQpFWwmXFDzSGJvQmpvCEx3pJAKnMc
         EyxhT1h3K8Opkpsogx7MiM7qFGRTLkt53lnEwoXhe4HiGckECDbepNMgzbyWdwFcL1+H
         zOv9z8xzuzTYhR808WSwAJRiZWU9HCsZ6ghlvKfXKJ8akpWbJJW6g6MsYuli1g1IZDwF
         jnxdRbomA1sGACqk8YRkWrpV1P9Ejxv+F7xlSxmA/hEJkoCIPDqCR2kBW8INgkPp1Oad
         1W6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692714663; x=1693319463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcEW3HG1uQnuo/0JN3vRz86npLk/Ya1ZhqBpKC2zxxg=;
        b=Q0J1NWTyWrdCDvJq9/BMTCmNhF1gXFbrQn13D2RFchsKC+bcZblJOJtFkO5EcrhYM/
         OOaq5GWZsC+5P8bYMJtukzz307pcZiIKbH9WVmh0h8HmMXozn2vYUw+raE59GF6lyIWq
         nBpB8pB8cqxZDKMEj9hvZodJ3ZLa3xTiotGcR7+lMj2m+fV+dRO7SuWGzoADivKv1VKj
         8g3BHl9BmXblhnnla0rfxJhq4qFbRj79xaDAN/8B92W8SnW206E//7gZXlDDmYDdgny9
         Ja9GRTWEWzynk9U4M3pN3PHfPLPrbkKM0WJajxU3rYA4QvDL15aW/arGTCQvEPUiSslD
         06CA==
X-Gm-Message-State: AOJu0YwhyAR7mKZxHvDqXtH1Ot4cqNRs92235bmshApLHZSjxQN35bMT
        czKJ7fBHsM+oI+cBZQHp5GerObpVRVU=
X-Google-Smtp-Source: AGHT+IG+0E+y/yzYhssSq+ahpg8eC7c9Z9Gr/S+lD0BajNWuClw2m3XXLB6OhTZNphJ1RP9WAh8kCw==
X-Received: by 2002:ac8:590f:0:b0:405:5ae6:9f3e with SMTP id 15-20020ac8590f000000b004055ae69f3emr12130990qty.33.1692714663202;
        Tue, 22 Aug 2023 07:31:03 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id e19-20020ac86713000000b00407ffb2c24dsm3055750qtp.63.2023.08.22.07.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:31:02 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     robertcnelson@gmail.com, drew@beagleboard.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] pocketbeagle device tree updates
Date:   Tue, 22 Aug 2023 10:30:46 -0400
Message-ID: <20230822143051.7640-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple device-tree updates for pocketbeagle:

1) Update the LED information

2) Remove a dependency cycle.

3) Now that mainline supports the PRUs via remoteproc, update the pin 
   information to enable the PRU pins and set their mode appropriately
   as per the silkscreen.

4) Add a missing mode setting for a GPIO pin.

v3:
- patch 1: retain the "label" property for backwards compatibility with
  beagle documentation and tutorials, simply add "color" and "function"
  properties
- the remaining patches are unmodified

v2:
- update the patches to remove the pinctrl-0 property early in the set 
- patch 2 is new, patches 3 and 4 adjusted accordingly

Trevor Woerner (4):
  ARM: dts: am335x-pocketbeagle: update LED information
  ARM: dts: am335x-pocketbeagle: remove dependency cycle
  ARM: dts: am335x-pocketbeagle: enable pru
  ARM: dts: am335x-pocketbeagle: add missing GPIO mux

 .../boot/dts/ti/omap/am335x-pocketbeagle.dts  | 58 ++++++++++++++++---
 1 file changed, 49 insertions(+), 9 deletions(-)

-- 
2.41.0.327.gaa9166bcc0ba

