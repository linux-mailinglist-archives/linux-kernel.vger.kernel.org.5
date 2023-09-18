Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E667A4C67
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjIRPcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjIRPcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:32:06 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8824269D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:29:12 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b9e478e122so2967718a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1695050751; x=1695655551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVKIu2PP2j4ok3fw5mLN5mcVXh2mH1/J+kvJoPupo4Y=;
        b=eTFlzsNVq5npy8Lw9LUug4dHHPrXPsPUBADl2YmNCSosHQQrZQVN9Fv5scHw859Ugi
         t6BgoZiAF0ocgGcAAPdHbZKuJuMDoe1KsPWNUba5dke/izsCzoyhIaSJL7aX9ND1kpM3
         ls+M0A7SzRMwHvCzEm654o+tzKrTsxU0DHGtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050751; x=1695655551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVKIu2PP2j4ok3fw5mLN5mcVXh2mH1/J+kvJoPupo4Y=;
        b=avNG1QdJBdfWbus6a7l+0t0lxopXWHQ5lBSk86xm/HsOgVscM4cPfGUTpf3flcs2+z
         X8aQ5a1hCBGQFNlHs/pGx9l2x4XzWSiufnlnZFHZRSb0MVHhP1dTrsjGzq/PbhCYMFs4
         x6WSbgI5ITDkONBjSKvn0Up6sZTXlK/fNz3oBnzIZ49BQLWPIvFDEl82bf8HiMMyAOA2
         otjSFoerDmM8f8pN1DyvNvZeNAI+sZafdhttYPgecni4z1xTP4VU2OIuVIV9azsr12yM
         zIhI0mUKhXSBVXWOXmsKJNm1NzYJWuFAGpg2t5Ylc2nKsZ5v5olLZojj8lXJR6peuwys
         ETLA==
X-Gm-Message-State: AOJu0Yx3FUObzFPUDWRHu9SvTupd60h74yk2iW0aSsifrE2T1DwIEpVE
        iITFKRq8SD4psBp26W1h1IGzxbNkCVudttFMJr/FfCQV
X-Google-Smtp-Source: AGHT+IGe9SqnHwSEgpsYlD4JGoZ7FIJxs+MdYsxgK7B+OtUSYfkXctreGRJaR9bm+s8ZbO3v7rj0GQ==
X-Received: by 2002:a05:6830:2014:b0:6b7:1d93:72e0 with SMTP id e20-20020a056830201400b006b71d9372e0mr9169561otp.32.1695050751405;
        Mon, 18 Sep 2023 08:25:51 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id e14-20020a4aaace000000b0054f85f67f31sm4217899oon.46.2023.09.18.08.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:25:50 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 18 Sep 2023 10:25:49 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
Message-ID: <ZQhr/TN/taOKqYIm@fedora64.linuxtx.org>
References: <20230917191051.639202302@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 09:10:00PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.4 release.
> There are 285 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
