Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE5E7756B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjHIJvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHIJvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:51:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8AE1986;
        Wed,  9 Aug 2023 02:51:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686ba97e4feso6219230b3a.0;
        Wed, 09 Aug 2023 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691574679; x=1692179479;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt9dQKZoqhtasn30KB7Up/m1rU5d0WCMxNZV+DTQ2Ss=;
        b=LTCfXecnkcHGwZXyR1HuHvU5wzUTY5wu3IXntbMdvBIZw0S6Y4V78XnSb0kwGdSPkN
         4LpkupfdgmEx0QKEPZXmSPcqyvPkc5EEEWJI7R3PLuzB6uBad/jdkpFSxQ1EA1SSGGOF
         PGaC6QGR/BDWG0A4uaj1W80pu9u3FqIz3mosLZc6RCt+9MDpVoy6O8f5soyTamTp01E5
         4K5OD6d0Dxmt8guWI20MdYHpLWumFfuHmNnjh0h9E56yPbk3G6Litg3E9hMxW8f+yixi
         t7sYJ0j73x7zztge/M7HqjDCGSFvfCbRz2rAQJap9Qjj+uAG+DtqyAXdNIXYTuG2ZtOg
         mNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691574679; x=1692179479;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt9dQKZoqhtasn30KB7Up/m1rU5d0WCMxNZV+DTQ2Ss=;
        b=eZ8Xg96NCmL2r4zN8sWTrc/uY/V6yRH9LA2X4QjjXBp2QRDCne9LGVcmywGYVlWHbw
         RhVc9amiGxRbgdCv/PbTI7VWWfmmZ4u3vwczLoiI9jOe9HHLagKoJAnwoIu4QF8UB/3c
         bIS2Q8tQoYAjhwqWXgTl5+ahgRusS3YrtSFfHzu09zcySRZiJJYWwmSdEcffIuhdxhln
         z05qxeKjrn1dtgIhXS9FX6KDieEU3YMYHKVfUSWGdAinW5HzfWNfrHA/dFd7MsGO8x/B
         PsNSgxwyE27YcepC2thDgqWtvlNMxRNSuiE5Zjt+m03X/Mbu5Ol67136PklHbmaXwIGc
         o0xg==
X-Gm-Message-State: AOJu0Ywm305ciQAslp9P41LbDdpxJBdHLIk5eifT2olUgx0Ebr/0LwK6
        ssUR3hdgjiEPAEFNHk0F4oo=
X-Google-Smtp-Source: AGHT+IGZio4gfn9u9Y7XLZnq7XVmcq9ZF76Kzn3wLjKlRZMQA2enJpEfxlEQb3VsmRK+89eeZtL2lw==
X-Received: by 2002:a05:6a20:5504:b0:13d:7433:2ebf with SMTP id ko4-20020a056a20550400b0013d74332ebfmr1983829pzb.60.1691574678454;
        Wed, 09 Aug 2023 02:51:18 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id j21-20020a62b615000000b00687375d9135sm9493822pff.4.2023.08.09.02.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 02:51:18 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mia Lin <mimi05633@gmail.com>
Subject: [PATCH v2 0/2] Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Wed,  9 Aug 2023 17:51:10 +0800
Message-Id: <20230809095112.2836-1-mimi05633@gmail.com>
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

Changes since version 2:
  Add DT compatible to check the chip matches or not.

Changes since version 1:
  rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R

Mia Lin (2):
  dt-bindings: rtc: nuvoton: Add DT compatible
  rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R

 .../bindings/rtc/nuvoton,nct3018y.yaml        |  4 +-
 drivers/rtc/rtc-nct3018y.c                    | 88 ++++++++++++++++---
 2 files changed, 81 insertions(+), 11 deletions(-)

-- 
2.17.1

