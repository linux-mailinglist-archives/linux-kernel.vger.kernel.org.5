Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150CC7F689B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 22:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjKWVLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 16:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWVLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 16:11:51 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284A2A3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 13:11:57 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507f63fcbf6so389194e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 13:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700773915; x=1701378715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmvIaEqBj6Deu/JeKDksUIpW27xW+EwbBrD/IEgkMIE=;
        b=c19EXjfBE3AHq3EEP5PyTDmDkM5/2ER2uh4cxRXr40zI1UjQ00l/2WQ6n7sb2aNQdx
         gLoee2zbIVQm2yEOdyWXTf8FWKtSRIQCQztr9fOM57PEl8kExJIhCLejN1iIz8NYweJ9
         4sGUYOEkyNkXd1snOeLWyyolEI5IQBj4fQ+VYJVVIilt/8E6yAOkri/1wOEK/bEMlBxi
         yLzeI4CafXU6kJ5H0shh2NFQkeQbJSSZawmnTdIEcm+HE9/QSPh0hY1XJ8016g43ukBo
         zxmsw7ytZ3WqB0zQLEdCq3ew63HogJ9YGLr1gnCIBJWwZQk/cVO/u2bLRsRgrup0kV/N
         lmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700773915; x=1701378715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmvIaEqBj6Deu/JeKDksUIpW27xW+EwbBrD/IEgkMIE=;
        b=uUWu8RDYa4OxGDJ9Q9CMTnMGr9Mz2DSBlHONFe1zp/7ZayIkHDhlJzKFuyRfx9tKeY
         xplSkRMVv46VDQ10/5EFtK0IZxfSu9InvMW0NVt7NLdrhLCWJ/4/xzFjGF/hAb8wou6z
         HKDIzA/pFotCmY7m4lP6+7DRFIOEjDWgJF+A/hbH1dBPY4+J7+DhGCSNnGCtacSRbhuz
         2uUVJkRXbeU1UqFhE9HL0L9dRa1wl2nHKCdlpBSNHnTXzdWYsVV2Ge6tRP43HlA5YtVZ
         maJvyPgY2VkBkgaVBAdVqjYpYkXP8x5UAeb2sw7gh0nqYJmifO3FHCqlGjjDaTFUMmFg
         cZ0Q==
X-Gm-Message-State: AOJu0YzYbxzL7davv4CeNGC2Gz8KxmnKum3M8XjnqhEvuSDa6/v7j5le
        tgGgCOPB+AJeJhQSMIM5LqM=
X-Google-Smtp-Source: AGHT+IFKn/XU2BMprJTesVrXmPsGtmy0MuYfdX+NEV/yzZFIgeuEfgvTVEk5P2nPzCHH3hanh7BIPQ==
X-Received: by 2002:a05:6512:1091:b0:50a:7806:d0db with SMTP id j17-20020a056512109100b0050a7806d0dbmr355448lfg.4.1700773915186;
        Thu, 23 Nov 2023 13:11:55 -0800 (PST)
Received: from [192.168.0.101] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7dc0e000000b00548a258227asm1038698edu.30.2023.11.23.13.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 13:11:54 -0800 (PST)
Message-ID: <b98d32fa-6860-4ef0-9c45-6602cfc5880e@gmail.com>
Date:   Thu, 23 Nov 2023 22:11:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] staging: rtl8192e: renaming 5 different variables
 patch series
Content-Language: en-US
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231123144337.13112-1-garyrookard@fastmail.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231123144337.13112-1-garyrookard@fastmail.org>
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

On 11/23/23 15:43, Gary Rookard wrote:
> Hi,
> 
> This patch series renames (5) different variables from Pascal/CamelCase to
> Snake case.
> 
> Patch 1/5) renamed variable HTMcsToDataRate
> Patch 2/5) renamed variable TxCountToDataRate
> Patch 3/5) renamed variable IsHtHalfNmodeAps
> Patch 4/5) renamed variable HTIOTPeerDetermine
> Patch 5/5) renamed variable HTIOTActIsMgntUseCCK6M
> 
> Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
> Driver/module rtl8192e compiles.
> 
> Regards,
> Gary
> 
> ---
> v3: Corrected versioning from v1 -> v3, includes change history.
> v2: v2 was skipped over..v3 corrects this.
> v1: Style and compile issues, asked to redo.
> 
> Gary Rookard (5):
>    staging: rtl8192e; renamed variable HTMcsToDataRate
>    staging: rtl8192e: renamed variable TXCountToDataRate
>    staging: rtl8192e: renamed variable IsHTHalfNmodeAPs
>    staging: rtl8192e: renamed variable HTIOTPeerDetermine
>    staging: rtl8192e: renamed variable HTIOTActIsMgntUseCCK6M
> 
>   drivers/staging/rtl8192e/rtl819x_HTProc.c    | 18 +++++++++---------
>   drivers/staging/rtl8192e/rtllib.h            |  4 ++--
>   drivers/staging/rtl8192e/rtllib_softmac.c    |  2 +-
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c |  2 +-
>   4 files changed, 13 insertions(+), 13 deletions(-)
> 

So beside the two
CHECK: Alignment should match open parenthesis issues everything else is OK.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
