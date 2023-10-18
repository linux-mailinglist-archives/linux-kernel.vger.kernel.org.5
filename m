Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138727CD789
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjJRJIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJRJIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:08:22 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A174193;
        Wed, 18 Oct 2023 02:08:20 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50cd16f3bso66329051fa.2;
        Wed, 18 Oct 2023 02:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697620099; x=1698224899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xl3s5u4aFpW0tVBln3gd6w2ulesWfdj/cSoOhMXvMdE=;
        b=beQ8wfumXHjcrcOJ/dS2DlCcpv/3AD5DhzRXm/dIK1VxE4SXONgCjTjy3LLACt05iI
         Jh2pM0hTvwNscTK183PJjItkW9lu2JG2aJQIHTcST+AK30r8UaW4XYBTRHAr0TPU9YRE
         fa/kYQlHrvuWjd1UHpHecwhBAGA421/jQin20iqbH6FNGpibQJwYWZUQtxEAQqAWUzS/
         aM9AlzemehzmDsoHiMpjqlwkC22VPScdBAzFVz4t/G+BJoUIrwbyYgf3uq20qDBwMXYc
         7tDcQh9dUO2VRsTGb8CDdTNjM11FZORLv0L83TXasx/xzSCuUZ/Ouy1YEGcOxwynbTsA
         vCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697620099; x=1698224899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xl3s5u4aFpW0tVBln3gd6w2ulesWfdj/cSoOhMXvMdE=;
        b=DX2FI5YCzb/3JOUnTtq1kgixo89J4EoC10H8dPBkm6Y6bgu24Bm0njL+Xn0greP9jb
         vPGCzpUEbw/OhA4DJ1LcpI0wuNl470mgHeFYOb22KiHtnyA5L3HkKyITwZvFWLNBZp+Z
         x0SD0zLAt+oqhnjkLnqi/Bm+Dml+TznT8XLPlrA//cXTE356i0zsAR7e5AxGlsjudhIN
         ux85TYMv2beLvALaIr1ydtWU+o6+SXGNGkxyULAlyXzBQz6yQ5juQ+SyiwTKhFYIXozO
         4Qk6zJvNDa2JZ+RfFv1N4KgEhms8KUDJ82Kdw7+xAwi3KANhYcjomXDbBBPHvSXK/UO9
         pNyg==
X-Gm-Message-State: AOJu0YzG4htR72ACGOTh+ajUQEvbyJYvm/DLpjHwtwSZGile+yEG9nzc
        96KUNjd5AR4+RMiki5Jv5g==
X-Google-Smtp-Source: AGHT+IFZxqUnj/AB3+p1hRp/y2wDrCrKc9X/ahR53kA/1QzZt1N36O5r+BKNQKC4kqgoSxtmDKX0RA==
X-Received: by 2002:a2e:9b05:0:b0:2bd:d34:e1ef with SMTP id u5-20020a2e9b05000000b002bd0d34e1efmr3527854lji.3.1697620098560;
        Wed, 18 Oct 2023 02:08:18 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.0.227])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc450000000b003fee6e170f9sm1107397wmi.45.2023.10.18.02.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:08:18 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        andi.shyti@linux.intel.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Remove unused return values from functions
Date:   Wed, 18 Oct 2023 12:07:34 +0300
Message-ID: <cover.1697619623.git.anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modifies the return type of different static functions to void as the return value is being ignored
in all funtion calls thus not useful to have a return type.This improves
code readability and maintainability.

Dorcas AnonoLitunya (2):
  staging: sm750fb: Remove unused return value in
    display_control_adjust_sm750le()
  staging: sm750fb: Remove unused return value in
    program_mode_registers()

 drivers/staging/sm750fb/ddk750_mode.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.42.0.345.gaab89be2eb

