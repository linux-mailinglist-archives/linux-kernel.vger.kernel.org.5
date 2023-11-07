Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E5E7E48C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344086AbjKGSxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjKGSxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:53:22 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FCA13A;
        Tue,  7 Nov 2023 10:53:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc5b705769so54577245ad.0;
        Tue, 07 Nov 2023 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699383200; x=1699988000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WaGbCVLUnKDZ3bfXvy2/8j1PjC4OaR2+c5JCYFFb1oA=;
        b=jrg2gQQDkjQhp4Bc4pg7Pu3bbckJlG3ereuKB81wPFsgfj0RiSpEL601xmfMcTbsQD
         Lz+Jwkc5nq3iPxZl7nj6Osxg5gVgXqy7R5E8cUsrHXnE6dAMH9S9ABSezf7CD70PG72y
         79ke5vCW8FcH6rVhci3Nb1I5lbcZo1cSzZqjS5DvqvZULbLFg7Cxd+PFOJp1b1+ijjjS
         93flHzasZJC/0trHC7t2x+YVuyALEiCSAl9I3W79P7e26zWNyb2YTwHboANRdy7HKNhE
         sZHDdg8wQeUJFErTHxTtw7ZTKS5U/Ix9wo3CO6zCWXf9bzlozv34zs+tTJ2VehD79R/7
         YmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383200; x=1699988000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaGbCVLUnKDZ3bfXvy2/8j1PjC4OaR2+c5JCYFFb1oA=;
        b=hBQQbwP1W1zGsxaOYc42PWvVlJls605VTuJXRHi5lVHbAcPcDSa/AmshjkZ5fty1Zz
         8BA5DL/auieHMe9IpGgdn4KQdS/QMxbnFZLr9vD9Kvta3KGKWPefZlKOpzcC/6XkrgM9
         FMVgR7l/3wEuwJCt65egcB/au0Vhwd00Spl0X5Syu69T0ANE+8q/r8AOT7t2nSGdifkJ
         +TQGBIIGY5bWM47seVlinrjEiC8N985G8zPZ4swbjl56iDYSCSvoEpsnF0HDbQy3CsKF
         aPi68+YbtgYQvBD9BgA1/l/O3pCaqpdZYPRRG9eBQSBr7kXuz/dnCZwLlwFbVbEEUE5N
         rHaw==
X-Gm-Message-State: AOJu0Yyj7fLMDiX645e8DCcQpoycDcM5LpthkLk3hoEuMOA9wrIBdbFi
        GY0/p/VBcGOfTM8pRhNFdfA=
X-Google-Smtp-Source: AGHT+IGRhFHFQZwRKAoVe9ffVagKva5NQMORwu2aSNiazG6bOxqfFTL5cfi5CqD2CTDOlTJkC/V+NQ==
X-Received: by 2002:a17:903:294b:b0:1cc:8cf4:d8a7 with SMTP id li11-20020a170903294b00b001cc8cf4d8a7mr13511921plb.16.1699383200016;
        Tue, 07 Nov 2023 10:53:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902cece00b001b9dab0397bsm164662plg.29.2023.11.07.10.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:53:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Nov 2023 10:53:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 00/61] 4.19.298-rc1 review
Message-ID: <059cdd05-135e-4e7d-8bdc-8c1affff915d@roeck-us.net>
References: <20231106130259.573843228@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130259.573843228@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:02:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.298 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 149 pass: 149 fail: 0
Qemu test results:
	total: 441 pass: 441 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
