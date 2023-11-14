Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4886B7EB397
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjKNPb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjKNPbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:31:24 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DF411F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:31:21 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so4802753b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 07:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699975881; x=1700580681; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yo+N2TjxrLqUZ92GWyrWSwHOBXAjgY14sEHZXRwIRDY=;
        b=ZDxOHZBhsO0QLL4z0Luzq9p5UCHxhFtIN35lRX1sN6HTWyImkij4h18Hc3qK8BqsjQ
         fsFqVFbzgUXkXXoQLM6TP62xhOq651aOtpEyylx9ex8LR4LhT0hJfZQwudGeEiqbgsA6
         f0kuwmm+0ODi2q/q4unwj+WKkNV+cpbqotHPSKIubmD6weT/AcYhOFEq9apoH7Weqb4S
         fvjhPwDTIwCCkX+jqEM4iHaOjuO2b4gWDM7vcsjFypgZj2hc8dkmFxG0+x1Ro7Ga83eK
         rRAqrT69wL+claqqhl3iZa5j83yTExuwLEmhFoTuIj8YeQFL2bsDiYKwMTeu86wt0x8y
         zvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699975881; x=1700580681;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo+N2TjxrLqUZ92GWyrWSwHOBXAjgY14sEHZXRwIRDY=;
        b=ehhjxVk/A0k4EJNFwNglFRyPlswKBCBJmpC/H+p3paeC4ypGDBpfc7qfzsRUJBUbjq
         gs+2BkbcnZn0wS8B0Y4VvQj4rLl5N7Aj/fcC7XfZ3Totq9XR1u+jic+h+vNW1QpHC92T
         w/VK5JlTbAMaYypYkjZa+RRU//NVrxmWS1zxuDrnKAbaVN41eawUgWdZnq9FN4N/Ngjh
         Ug/TAt3M6j+EBk3Mj2wdskFkGt+5l+LFFIQ9bEnVbYWifZtwhJXeuOrj4CVqj1ly7ZJ6
         HjEh7W+Mpo35m6OdE/24ErxoXBPwZ1VsjnWOFoIpz/qpRGBO7J1Qmz4sKVilEzoM86MB
         4XDg==
X-Gm-Message-State: AOJu0Yzsc+0/M5iUCFVphVXMR41ZvvsfaxNjvawk2RdJfnynBkn+UHou
        /kAMrnzGEcxdQVYKvGQf3smznw==
X-Google-Smtp-Source: AGHT+IG2AJsWaZeUJC5OapKyqMNLMErDKtSX62TfDgTaaP18bvLy32SGjZ5zH3KyJY0U9ZaspeR1gw==
X-Received: by 2002:a05:6a20:12d4:b0:180:e3f1:4f60 with SMTP id v20-20020a056a2012d400b00180e3f14f60mr7497801pzg.45.1699975881244;
        Tue, 14 Nov 2023 07:31:21 -0800 (PST)
Received: from rayden (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id fn13-20020a056a002fcd00b006c3328c9911sm1339118pfb.93.2023.11.14.07.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:31:20 -0800 (PST)
Date:   Tue, 14 Nov 2023 16:31:13 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fix for 6.7
Message-ID: <20231114153113.GA1310615@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this OP-TEE driver fix allowing supplicant dependent devices to
be detached by user-space before the supplicant service is shut down.

Thanks,
Jens

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/optee-supplicant-fix-for-v6.7

for you to fetch changes up to 7269cba53d906cf257c139d3b3a53ad272176bca:

  tee: optee: Fix supplicant based device enumeration (2023-11-03 09:27:20 +0100)

----------------------------------------------------------------
OP-TEE fix for supplicant based device enumeration

Adds a sysfs attribute for devices depending on supplicant services so
that the user-space service can detect and detach those devices before
closing the supplicant

----------------------------------------------------------------
Sumit Garg (1):
      tee: optee: Fix supplicant based device enumeration

 Documentation/ABI/testing/sysfs-bus-optee-devices |  9 +++++++++
 drivers/tee/optee/device.c                        | 17 +++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)
