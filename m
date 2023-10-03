Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61267B6F7E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbjJCRSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240636AbjJCRSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:18:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBB0A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 10:18:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so9162055ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696353523; x=1696958323; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/Pj0lt9hCfSD4N+KqQXF0RTWOozDuEYDrepCdOvld8=;
        b=kpk5HC/oCLKUVaodxUDfdM4+4pIjDfj8Bql8cJSi9Fkijs93WRso3dgIfSrSvHioZt
         d9jkUtljkYhygUvfkBvLFElA2W7/YirZEx5wIaPT5MZEGvjHnkAPz/fhaD1ZPLLS0V8L
         7e+pdTt+Kfcr5gAmq1mmP72F/Pdjk4wcTdbnuAnfq+UIjM8LKAMt4eIqyiT1sXtmO4pk
         dO26p+R3E9L+16Su1xGa/QrJPRwgq5XQcyB5FIM8AxB3hA8RTmKNvc2OF3/a2OZjaDH7
         W79FXJzEkUzSkm4Cw1argB1GwUIlicz9XuyDrSe4HeSYHbckOeszdBbMtbPf9LjHY1aP
         RIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696353523; x=1696958323;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/Pj0lt9hCfSD4N+KqQXF0RTWOozDuEYDrepCdOvld8=;
        b=uR82LzckMxgx6Bh1UmW8+NEG6nxslCUeTBT0u0f9x1O1wVBxAzs23mgjne5WtDTiUf
         g0R7RyQe3t1+PcO55nWTp+g3CQT2WWGL1FeEbUcdEQ+DZM6jv+HmH4P667sTo77vGT2h
         EVR1R7UoW4zv6Bxu9AToLbU123VvNIriwlgiTQWuiJ4YH9CwNirB7fSiYitHCTKwO9I1
         rkRClqlgnAdpzKSvPm5XS75sl5txu6omfPyB9no3fySLmhRVrzTxk8JqQOIp3MfsDRah
         t0SNRW5lA+AboLFUEIi53HEsu7Zu+RPmpUErHRh5eDB1/udlm/ofFdM72dIDVyyEm4yo
         xGJA==
X-Gm-Message-State: AOJu0Yz4Mv+DlnKtEdu0bsp20rD9Hj3iWdv2HxAtQe4+dQtpo82J1Cba
        kcwCjdLw9ZNmw6HV+sXNEIGtNfdWW91xYU0yeAY=
X-Google-Smtp-Source: AGHT+IF58FaGoQFqY9KeEFCKEPSiO70wCn4vIXbxjOXbc+BnUiGWSpchqcrEqXsw1PsbGYXu+jFjlA==
X-Received: by 2002:a17:902:f807:b0:1c7:495c:87f7 with SMTP id ix7-20020a170902f80700b001c7495c87f7mr209978plb.22.1696353523640;
        Tue, 03 Oct 2023 10:18:43 -0700 (PDT)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902788300b001ae0a4b1d3fsm1849620pll.153.2023.10.03.10.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 10:18:43 -0700 (PDT)
Date:   Tue, 3 Oct 2023 19:18:35 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] AMDTEE fix for v6.6
Message-ID: <20231003171835.GA669924@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small AMDTEE driver fix addressing a possible
user-after-free vulnerability.

Note that this isn't a usual Arm driver update. This targets AMD instead,
but is part of the TEE subsystem.

Thanks,
Jens

The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:

  Linux 6.5 (2023-08-27 14:49:51 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/amdtee-fix-for-v6.6

for you to fetch changes up to f4384b3e54ea813868bb81a861bf5b2406e15d8f:

  tee: amdtee: fix use-after-free vulnerability in amdtee_close_session (2023-10-03 19:13:53 +0200)

----------------------------------------------------------------
AMDTEE fix possible use-after-free

----------------------------------------------------------------
Rijo Thomas (1):
      tee: amdtee: fix use-after-free vulnerability in amdtee_close_session

 drivers/tee/amdtee/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
