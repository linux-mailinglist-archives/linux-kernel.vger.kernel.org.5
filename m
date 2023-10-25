Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455277D6990
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjJYKyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjJYKxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:53:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A81C93;
        Wed, 25 Oct 2023 03:53:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32db188e254so3833081f8f.0;
        Wed, 25 Oct 2023 03:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698231198; x=1698835998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5LFOX0gmykKgdLOW/m7PRk1qIDkKpMeejYtgVYKiAg=;
        b=F4nT09ndUMlwwWWbCVxY3wy02UbyC42jmTu3td70GsgxCueh+EKRU3frpzawEfpx5p
         /NfeB05Ef1X1fih7+3Je1WiUVF/BMAo1Bt4f482cwh4ZHYBL/jNhpTf+ltWcoKl8ER4I
         lvUnyLh9CdAeEuxZmwhHSv0ZpJgtMjPPbsl4hMg5nTQkwOOnTIxLxaqRMe0JShGo6G0w
         R7YTq1spap76AusAs7s/UjfPhBuO/McBlB7eDwDXQY+WP1Cc40HDJ6Ii44wsqQWNgv8I
         dB8vrhDwIj3lhmbOVhH9NiTkLU5F8qVKmvqDEKbF8BaNsCH/X+WTPTfkqYe3L6DL42cu
         kCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698231198; x=1698835998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5LFOX0gmykKgdLOW/m7PRk1qIDkKpMeejYtgVYKiAg=;
        b=DOtzITtmCEA5WfEYFarh+fDd147R7CbiVClqAdm/HNQYp42CpcQxb/jXJbkQOyU2SV
         qzQa7yCvnQQkCY6gcE1246AWCwoZnTfi4NLV97lCXs9byxn25Ju8ts6M8u6SSYIbCW3c
         2kaVH5RnfIU2sjtaCGNFCw+ut2lnhNwaPaPwAgTbU0N+T+vECNgE54cCxBqcMuvU52/r
         90YEq1JOB3ZtpGISPtD9Krm0270G02oyQ5Gr+yrjZX02maWq1Dpq5Hy7Z31bpQhDwQQ3
         IQ9tWjVM/SBSYJkV5/6Mb6lnbaZ16mZhjN2JaPwguzUfaO4TDsE4TB0NxpCCafaIQE4H
         YI1w==
X-Gm-Message-State: AOJu0Yx3BX5LkzzUjRBL793eKmz4vnTDOWkFPlSsAV7Xx/09Bej1zNrN
        TGJnaZFsvk3DRtEqucu97LY=
X-Google-Smtp-Source: AGHT+IHm4rhFsIfSunj99etgP4L3hKz3Kf6mT85Ndo9cH1jm/mZT7VsHlOrM9UgiVd/BbfdlfX7xMw==
X-Received: by 2002:a5d:660e:0:b0:32d:8872:aacb with SMTP id n14-20020a5d660e000000b0032d8872aacbmr10935716wru.53.1698231197566;
        Wed, 25 Oct 2023 03:53:17 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id f1-20020adff8c1000000b0032da75af3easm11793086wrq.80.2023.10.25.03.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 03:53:17 -0700 (PDT)
Date:   Wed, 25 Oct 2023 11:53:15 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/135] 5.15.137-rc2 review
Message-ID: <ZTjzmw_pVK4eSOED@debian>
References: <20231024083327.980887231@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024083327.980887231@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Oct 24, 2023 at 10:36:50AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.137 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:55 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.2.1 20230511):
mips: 62 configs -> no failure
arm: 99 configs -> no failure
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

[1]. https://openqa.qa.codethink.co.uk/tests/5379
[2]. https://openqa.qa.codethink.co.uk/tests/5381
[3]. https://openqa.qa.codethink.co.uk/tests/5380

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
