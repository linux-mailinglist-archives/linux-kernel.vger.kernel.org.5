Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF880AB28
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574495AbjLHRth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574152AbjLHRtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:49:35 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D4DB5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:49:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54cbabf4bceso615853a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 09:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702057780; x=1702662580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gf91RaT4psSnTjQOvkHoL2IZEpgv+zezQV3dSOeHfM=;
        b=ctv3uAGeLsAM/ZnchYzIptMCgHD/1y08yGcusoNSdoBaqOKTrgL/z3h5f7VVMagLxX
         RtH/vhbjYur7ORJY7kFQliMjm73eptNUHKeFhsvQKZGVTC/TNmbOqLsJ/vfs4PoVOuCl
         7rMdExHb8JtRenePlfjhQZVfikcMxv+iW5NVDiic75TScBJri4GOd6d7WC4/nHOytuIi
         f45xFKsoLZSgfQb9uXe1bTn6TR0XUUDNKM/nZMKezijnCjR48E+qCMglqvsMpfmMVCJZ
         KjO8aSwYT58yJVLC1PqNuvOurIBFApDLWfJe2uV+437CFKYUdKi9o1b9yll5O4JvoZVQ
         +7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057780; x=1702662580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gf91RaT4psSnTjQOvkHoL2IZEpgv+zezQV3dSOeHfM=;
        b=ZLDiwPR245051YqeokNWAzpd5B7zwdnhv1BQlH24tJz7Fp+I0/zQndlr43yaax5BBt
         WB+EH7mXPUq/yMgAMSOjH8j63oiuqeSFqAoAfvWCUr29wVn3yEYH/mNUZ60cvLcyZ44e
         hltW2Q3/FLg/94D4K/RiyND/tCLaljpIgtX8szP5OjUMHH8OI4+rgEgcMlaOOJ3Uiogu
         6h/1xgQnqdlJuL0YW7Y1zwHWBxoa3xNm8L+Ymhk4PpHtuNGkHTiBgwXul8Y6fslV3IJi
         gkxDQvgV1/rFEO97r493rSvZEdxxIOFvpaksfBVBeR3Ns8gjoHRljqpF3EWISYIwFNaA
         5kSg==
X-Gm-Message-State: AOJu0YwJy2B2CGouRMeVE5NGfAFMUCFUChi2zaYovyyMbZK2rvnusJGc
        QjiwDKzzZEwrwjMP9MBX5LhBmoekZp8=
X-Google-Smtp-Source: AGHT+IHp1bqbIduEvqo5uZujud1Xq8U3dFm2yrl/TdI4//NFcvUqeh5moXJ3Rp5abHwycc1GgkYtdQ==
X-Received: by 2002:a50:d5dc:0:b0:54c:e90f:2c33 with SMTP id g28-20020a50d5dc000000b0054ce90f2c33mr676889edj.1.1702057779964;
        Fri, 08 Dec 2023 09:49:39 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id 28-20020a508e5c000000b0054b686e5b3bsm993617edx.68.2023.12.08.09.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 09:49:39 -0800 (PST)
Message-ID: <493fe783-46b3-4da7-b0d9-01425e6adf2a@gmail.com>
Date:   Fri, 8 Dec 2023 18:49:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] staging: rtl8192e: patch series renames (5) different
 variables
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231208015536.21013-1-garyrookard@fastmail.org>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231208015536.21013-1-garyrookard@fastmail.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/23 02:55, Gary Rookard wrote:
> Hi,
> 
> This patch series renames 5 different variables with the checkpatch
> coding style issue, Avoid CamelCase.
> 
> Patch 1/5) renamed variable bCurShortGI40MHz
> Patch 2/5) renamed variable bcurShortGI20MHz
> Patch 3/5) renamed variable CCKOFDMRate
> Patch 4/5) renamed variable HTIOTActIsCCDFsync
> Patch 5/5) renamed variable IOTPeer
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> 
> 
> Gary Rookard (5):
>    staging: rtl8192e: renamed variable bCurShortGI40MHz
>    staging: rtl8192e: renamed variable bCurShortGI20MHz
>    staging: rtl8192e: renamed variable CCKOFDMRate
>    staging: rtl8192e: renamed variable HTIOTActIsCCDFsync
>    staging: rtl8192e: renamed variable IOTPeer
> 
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  4 +-
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 22 +++----
>   drivers/staging/rtl8192e/rtl819x_HT.h         |  6 +-
>   drivers/staging/rtl8192e/rtl819x_HTProc.c     | 58 +++++++++----------
>   drivers/staging/rtl8192e/rtllib_tx.c          |  4 +-
>   5 files changed, 47 insertions(+), 47 deletions(-)
> 


Please use present-tense as outlined here:
https://kernelnewbies.org/PatchPhilosophy
So rename instead of renamed

Please use a more unique Subject for your coverletter.
It often cannot cover everything. But more unique is better.



Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
