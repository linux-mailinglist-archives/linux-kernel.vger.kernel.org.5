Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354FE78B2FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjH1OXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjH1OWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:22:42 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8B5C9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:22:39 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34cad4e6a34so4032955ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1693232559; x=1693837359;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzfeysG9TJSK46/l/REIskZ93UImUVs5B7Y+yC2BIcY=;
        b=l1iyR+bVvO1yKAzmX7iITGp05C7AFkQjwli8n1SLPPrVvfLff+TTnQMF+Lhs2tQ5fU
         8xHRQSHhgjWk6VPV0UoSG4g87Y5hxKrHbw/MOJvCZtibxu1O+aepjoJRHH2Mk08iFp4B
         34u/jF/OYkKC5BfETvkVctWO7CjC9JU4nRld7j0memYWIzZUhl3Qu2BeeZKMwnJKZ5V5
         /yvbCuAKTUqKElgonn2Ra5E+QuyWO0h02wHma49yxic2GbmuMeOQMqXLdiWZh8lLsLvb
         xScrbHpnszSACkHjPmFm0jEu43a5HPOzCVdQPZ1Q9qJuYdC8B2l/9bRRQhzR1nAVcyoy
         auFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693232559; x=1693837359;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzfeysG9TJSK46/l/REIskZ93UImUVs5B7Y+yC2BIcY=;
        b=ZSOiUNJxZo6s3MzjXAZVUdQrfUBy4B53TtyJl8AMBPiwr3gp1iHCY6uDd+MP17esAM
         dPSFogEH0ZXeO99XMgvyNvAdX+RKlOK/aLHyQuQc+8F5TkLEOU+fRkO4kS/mKAFcZoot
         vFx/woElBHw7pUtHo+NfU7hIOUZ76kpOGuEJuqf9ML3TAnWQhOLjYoqVZktUJSWaFY+W
         B5i2GVqsyRQzh9BpjJ82Wvnrbt8Sr7EWsN3jRQZygtgGPZ5AWYzxl4DwlJjjc/6VjMZy
         51h0/0quYJQaVUS0151AyTp0iKq43Lts20SosnOC2ekGVaa1M5Nh7iBooQ55wxM6QSYI
         erCA==
X-Gm-Message-State: AOJu0Yw88RoKCqb+1HMGFuDCGT4B0zOfXcjglkotJDZ6UKxv0e9zbsgU
        PHVoRDeevSPp3ckTsxxkivFkhQ==
X-Google-Smtp-Source: AGHT+IFF1bVJYW7v4IS8K8h8vQnipCssxqREGND5bLZxWPR3wD8i86TM3oywauSP/vvY6eyuxaZedg==
X-Received: by 2002:a6b:c9cf:0:b0:792:5f79:ef9b with SMTP id z198-20020a6bc9cf000000b007925f79ef9bmr15113039iof.1.1693232558804;
        Mon, 28 Aug 2023 07:22:38 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h16-20020a0566380f1000b0042b61a5087csm2388790jas.132.2023.08.28.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:22:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        io-uring Mailing List <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20230826141734.1488852-1-ammarfaizi2@gnuweeb.org>
References: <20230826141734.1488852-1-ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH liburing v1 0/2] Two small fixes for the map file
Message-Id: <169323255792.13568.16202224062478802932.b4-ty@kernel.dk>
Date:   Mon, 28 Aug 2023 08:22:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 Aug 2023 21:17:32 +0700, Ammar Faizi wrote:
> Two small fixes for the map file.
> 
> 

Applied, thanks!

[1/2] liburing.map: Remove `io_uring_queue_init_mem()` from v2.4
      commit: f22655091c35cee2bc2a8c8b48bba7e1470e53a0
[2/2] liburing-ffi.map: Move `io_uring_prep_sock_cmd()` to v2.5
      commit: 58ec7c1aea2d57acbc3d398d0c8b2625746eaf04

Best regards,
-- 
Jens Axboe



