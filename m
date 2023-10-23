Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB227D3E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjJWSDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjJWSDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:03:19 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81924B4;
        Mon, 23 Oct 2023 11:03:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c87a85332bso30051815ad.2;
        Mon, 23 Oct 2023 11:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084197; x=1698688997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x2ZqpTyCO+kJIAJ7HqJgpSJj35kBsl28+6ENLNRZ63I=;
        b=W5NbTFTDwYBe0rjnOtSPFwjjhymsLaRmiC5/dflic5Eo5bnN+NzLR32DmvuTo91MG/
         xhoPXnjsyyok/URCARUCkxtxtAYPM0BTyi+H1RH48kIAq0rcs7Zs7M9iO2skkoqM5Ryp
         cRcmP3zlnxF11ZI8ifnPn+EZbd87InNlCmksRspOXX92TYikP4ig44RqnvWglsnW00cm
         5SSdkIB9MG7mhiq6wm5RUBNVkJKrh02Q5iCyr9z5YFusgnlLIOMzC1/vSPSJ/JQv+AG9
         XtLeun+GR/crsKIPs9R/jpdrP1I+CINFX7xADoxcrBEkzbJCCTpG0rmLpgtuzTtu4zls
         HKcw==
X-Gm-Message-State: AOJu0YzCwXbEEeuwmSep7gpjfcu5pBOrMCW3+95rskUSlIkMPg3CaCZ8
        Ovmae9T7qC+bcBcdf2/S3WI=
X-Google-Smtp-Source: AGHT+IHH5PQ07hCGgq+WSZeo7fx93rChffPvxtWeFggG++Gzf1iak1AGF9mR2o7X0poh3s1kwFr7tA==
X-Received: by 2002:a17:903:1383:b0:1ca:8e79:538f with SMTP id jx3-20020a170903138300b001ca8e79538fmr8233599plb.25.1698084196857;
        Mon, 23 Oct 2023 11:03:16 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001c465bedaccsm6227165ple.83.2023.10.23.11.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:03:16 -0700 (PDT)
Date:   Mon, 23 Oct 2023 15:03:17 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1698084192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x2ZqpTyCO+kJIAJ7HqJgpSJj35kBsl28+6ENLNRZ63I=;
        b=YiPNrgGbrrWiFs8dHHlwO55lm1ipsGjy2+/viuXz1VrCybJ+Wojs/uHrzyRgESyVnIKgXa
        UUdmbR350zYHGAAUHtDJPShfAdAyYSBa7T5/hWn1Fa4ZaH7U0OOFs7dTCshUtkUayRRqOU
        AxStKeWJJF97x3oqzJtncvQPUgHorIiPqAwmDzSdZvzyjS/ypiNhJWwWCvMwQcGl9dUV/t
        K+X+c1G1lgHDZQhV3Yuxsq/26EyPN7iCBKyOe7+Y268xgTEsVU3sIfzDMLOkeaGcYBet3y
        RYa6nmO+LnTCdsGAcN2SSIPgTMEIC/0vjFfY6wFPQQBwVdXroJm6HDfVkN4piQ==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/196] 6.1.60-rc1 review
Message-ID: <n2fduxk6hes7u6wqii3mqg3eqeojc7fknraltfevuvlhnhqoa3@x3ykifdp4f27>
References: <20231023104828.488041585@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/23 12:54PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.60 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.

No build and dmesg warnings, my system runs fine:

[    0.000000] Linux version 6.1.60-rc1+ (rbmarliere@debian) (gcc (Debian 13.2.0-4) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41) #3 SMP PREEMPT_DYNAMIC Mon Oct 23 11:52:39 -03 2023

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>
