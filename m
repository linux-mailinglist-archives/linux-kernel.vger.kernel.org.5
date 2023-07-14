Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8483754504
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjGNWiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGNWit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:38:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D6030DB;
        Fri, 14 Jul 2023 15:38:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-668709767b1so1847611b3a.2;
        Fri, 14 Jul 2023 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689374328; x=1691966328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvCYC5lv06+yLWhD0vA+gpIwnot2YJ3/Uyd9naS/lsA=;
        b=nmRGUqPWsPTlmQZTGYimNHPs27FHh0igPCKpfO6fXyDKn32CX6rpE5gB2tnhku/76u
         eRWTmj17XcctctljaDWxdsoXbEE4WPqFKxQFznPet1ysMA1E58pYVO3No+m/j6SMRxVy
         OfBgVtKZZYTwsFBB37PAu38FEffYlXqf3zFYZOIsBTjsmkaCr1JnVcSFGyBM/Xiv0ZWh
         O20pN6R0Ktnq1dW8yTzZys0mnpaOSwDHagJhk2MpBnyysWrs960tMz67481GAg2xQp/2
         h9/x42QOvoOAozKFtvcl2r5PoPdKbAnK8+IoslaDXGOc9AVArtd3s9daTvGB2E+NrRyh
         cLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689374328; x=1691966328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvCYC5lv06+yLWhD0vA+gpIwnot2YJ3/Uyd9naS/lsA=;
        b=Y2kU9JxmQX8Py8mzi9U2lOl8vKGGo7Lp064LqYxxzkgim7kgiVucv79fWlEn0mPApP
         WKzVBbviKHlG0DtuZhUasLsBKBOBLQuEtRtENME3ncHdh9kk7/5uGg2MZR9G4gtDf18c
         OfLrH5swTJnAlHskEL7EloOZKdp/62QFfkA5d9FGtsWg5Rxjy6QY0JulebuQ/ncwlupX
         OwIjtEsaOEfJ4OkZstKsZRgRgL/i8JXbvSKP07nKeCj6I3WixgUjXWjVMn1TKDWhm8SH
         1DjumjyFhkjKf48Swvw43kIqbfcSz+IrX58tWNhm/Tg74fTaTG3B8qi8DGM/iOjzH83s
         h3wA==
X-Gm-Message-State: ABy/qLZYUuXU6eLFzU+vH0gDtFHUESxas+6PekkY/bDbUivmoPKT85qp
        Lw1v73YIpzVJ5vc7PCcSZelBGjenAWr4rB14Vcw=
X-Google-Smtp-Source: APBJJlEQ97yEQ5WWAnqQqNasWTEfg+38d4oTAKDBV9QwaDQUny3iCJE2CnNMXAPyiF1PBaJkK4oNRg==
X-Received: by 2002:a05:6a20:9d94:b0:131:dd82:8c01 with SMTP id mu20-20020a056a209d9400b00131dd828c01mr4200677pzb.23.1689374328043;
        Fri, 14 Jul 2023 15:38:48 -0700 (PDT)
Received: from localhost.localdomain ([221.231.171.18])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001b9e0918b0asm8225460pls.169.2023.07.14.15.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 15:38:47 -0700 (PDT)
From:   Polaris Pi <pinkperfect2021@gmail.com>
To:     kuabhs@chromium.org
Cc:     amitkarwar@gmail.com, ganapathi017@gmail.com,
        huxinming820@gmail.com, kuba@kernel.org, kvalo@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        pinkperfect2021@gmail.com, sharvari.harisangam@nxp.com
Subject: Re: [PATCH v5] wifi: mwifiex: Fix OOB and integer underflow when rx packets
Date:   Fri, 14 Jul 2023 22:38:07 +0000
Message-Id: <20230714223807.3926654-1-pinkperfect2021@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CACTWRwuhkz60t8TSy6xvPjeS5BGp9f5H_o=rf42yUUcrY5m5eA@mail.gmail.com>
References: <CACTWRwuhkz60t8TSy6xvPjeS5BGp9f5H_o=rf42yUUcrY5m5eA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> formatting issue, space after (u16)
Delete space is required by checkpatch.pl

> why return -1 instead of returning appropriate error code , may be EMSGSIZE
Because of all other error paths return -1, follow original return code

Thanks
