Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B3F792AB3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344087AbjIEQlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354123AbjIEJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:44:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51B0132;
        Tue,  5 Sep 2023 02:44:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so23150655e9.3;
        Tue, 05 Sep 2023 02:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693907072; x=1694511872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HVPs2SvSjXuP7B7EaHf0fnpwbvuEGtBL/UiPRCBlCIs=;
        b=qCNZ7SEN1PpEMEkVgSESiWhfuKelPSuM9UYWejx6GmOsvF3tGRuhqeiGo/JjnJ25Wl
         g7RZjo7L7MfLZH55Vtj2p6HyApe0ie7MGDX+7c6qWTxwe3FAeIVO6X32pY0iVIWKELnW
         EkXJlgvbjeVloAvdJRhFVlxLrA1jQ+xyoFd4okQvSL3hn49tqnbJY5SIpurQNyJmUf1D
         DTHV+f9pqtELgWXc2tcQoJxkYrmhf00FK1+qFM49tkreRUAor5MLObeRuH9tDP02pKqx
         cF2DQm9tQZ1lFSFkAPjdY1pcgYhdFrk5JvfR2DQVBkzFKiVeUSgh7lh47Yw36tykGxn7
         LmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693907072; x=1694511872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVPs2SvSjXuP7B7EaHf0fnpwbvuEGtBL/UiPRCBlCIs=;
        b=IIJz5w3oYsLx+HnBrv7j5gvZNGBKPtIF1aupbanKj/TdGjTvn4qVXTWw1yKnDmxxAr
         +HmCaCl6tfcjKFzpZuZ9ooXD0BDm8V1GlTswrOKdSk49HstkKM3mJ6CulTaeE/e52dAc
         Pam21aihxl51RerG1YI0seendjk1A8ilQryWiqdqWL5iSyduj2xsDvhdUsF+7d58zENu
         Bxcob4n2PY7WonTHOjuftkAVMev4RE8nAPMw2R/rIkm1tZ5AteEUlINUlu8dN8GfQ+/k
         DPJv76DKfCFR/DFPXPCJaHA8B340o3LrqBzD4f4m99kgd1upvWdk+oShmP2D01lAdzzi
         j7XA==
X-Gm-Message-State: AOJu0YyTGugMuEO6rlJx4m2YNDl27CBhVt3b/EbmF4w9i8gH4pDA5KM6
        7rGX9dUZ1Ra4s3g8MnGXfkxiW4jtRtI=
X-Google-Smtp-Source: AGHT+IH448207ERtKGtfi1Ay2Rcqr8Iq2mUadXBog9oVQuhWs4ht34ZxFDgG5kwoqM6IViTgr09phA==
X-Received: by 2002:a5d:6a47:0:b0:31c:8151:86a9 with SMTP id t7-20020a5d6a47000000b0031c815186a9mr8988836wrw.67.1693907072147;
        Tue, 05 Sep 2023 02:44:32 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id x2-20020adff0c2000000b0031971ab70c9sm16975574wro.73.2023.09.05.02.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 02:44:31 -0700 (PDT)
Date:   Tue, 5 Sep 2023 10:44:30 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 00/34] 6.5.2-rc1 review
Message-ID: <ZPb4fiZyzCvtvX38@debian>
References: <20230904182948.594404081@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Sep 04, 2023 at 07:29:47PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 12.3.1 20230829):
mips: 52 configs -> no failure
arm: 70 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
csky allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]
mips: Booted on ci20 board. No regression. [3]

[1]. https://openqa.qa.codethink.co.uk/tests/4947
[2]. https://openqa.qa.codethink.co.uk/tests/4955
[3]. https://openqa.qa.codethink.co.uk/tests/4956

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
