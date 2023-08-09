Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2617761AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjHINvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjHINvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:51:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83842110
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:51:04 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2681223aaacso704807a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691589064; x=1692193864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZSZbnMxGCAQaiOpSsvGGxA9SQHJTADmzlPQy3XEacw=;
        b=gRYaeUtIwG7Vsj6K1gs1mw8g0NKm027QxgPMpJN3XS83Of3CN0gDtXTRiqfP2LUnTS
         MpezfI1H7RLZHUXUCJYiYNKU1Iv/CPcbmf5GD5ql/EjLssB/yM4Diz7haopmI4H4we1/
         E58q0yyDy8Y9M/ByN8h3EoEfOwpnlYyJH8YoLZorF6Q/dH+e4LmW4D6L0l0ld3Z3MuUi
         dVk/l2hAXWz1lmEzr3Ps2R4yAcqOIWdmRQk2sFSig8h/PH5M3j7GsZiZbgcAOgG9LpaY
         SBwV/De7DUvsQ1MtQ8MoH3lkmF88u7NaLVDtd97+0GG1h++3hPmyiHR1rwAGBrXxGSaj
         +GmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691589064; x=1692193864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZSZbnMxGCAQaiOpSsvGGxA9SQHJTADmzlPQy3XEacw=;
        b=l0sgB5mzxJptmy7H4XuEUT93vrTnxk1ExCTkgyF2vDE/+98feSLS4MO7P2kjJt2qD7
         ZDorXvl7d9KBgHAJK6UTBW+EbSHGnNMdfLAowcymYGnCDORztfXVjLFIlsq9bCB7HmQj
         xFl+vZ6SH7HF6+H+yf+MZ/Pr8CeUCbdqfw8avVE2HG6bddlqraa9HnUc76lz1Fqr2C2w
         rm9DMHyhewkU5K9CRtsJQbw7ydaM++pGcK4aJMzvsKfcgVC5xYu4wVlWq+qe6QWjRWqQ
         fZpmI3OH61aIOyAGEY9lGYX/L/l/F41rdaX8TqB2RzYDbwN80cB0HAwCkK8ZBHceyZra
         6fpw==
X-Gm-Message-State: AOJu0YxwtB7zzp1416N82v5CLEVmVHTEGPNfo3OtGX365Ia6D/pN2LSo
        xsV+XiKCjGG4UG+dqAI/wcmuNQ==
X-Google-Smtp-Source: AGHT+IGyRd7WJudjB3NASLPZ4tgpVvTHKIUwDcteCrieyWhPuWEJw66UxEJgD77KWtV9WrOp4w7wbg==
X-Received: by 2002:a17:90a:6e43:b0:267:f1d7:ed68 with SMTP id s3-20020a17090a6e4300b00267f1d7ed68mr3848999pjm.14.1691589064187;
        Wed, 09 Aug 2023 06:51:04 -0700 (PDT)
Received: from work.. (1-161-169-231.dynamic-ip.hinet.net. [1.161.169.231])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090a284c00b00262ca945cecsm1542677pjf.54.2023.08.09.06.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:51:03 -0700 (PDT)
From:   Nick Hu <nick.hu@sifive.com>
To:     nick.hu@sifive.com, zong.li@sifive.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/1] Add Sifive uart suspend and resume
Date:   Wed,  9 Aug 2023 21:50:41 +0800
Message-Id: <20230809135042.2443350-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sifive uart suspend and resume functions for system suspend.

Changes in v2:
- Change Signed-off-by: Ben Dooks to Reviewed-by: Ben Dooks
- Remove the unnecessary check

Nick Hu (1):
  serial: sifive: Add suspend and resume operations

 drivers/tty/serial/sifive.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.34.1

