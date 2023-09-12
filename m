Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A102479D8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbjILSgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbjILSgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:36:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE3B10E9;
        Tue, 12 Sep 2023 11:35:58 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fac16ee5fso2692334b3a.1;
        Tue, 12 Sep 2023 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694543757; x=1695148557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZag0nbTh/60KISxMvfYW3oBhoTMiURqNU/JyM0of4M=;
        b=Lw7kQ8VI1uju93hGv8bQFpB+p/TaWyskZDPImr62PBEQDTBaCGJo925pQ1B1ZVP3ty
         cMvC4e1pMEWI4Q807ek7FYY5YhXBntzk7x3hlNk32ReS+O7W7mMSDw8v7Isksytu3Uqf
         YuBSlAl+CEKk7iSoDavnFJVI4YgJvuqqJlGM77T0k7fB4e/LGcn3PuDy2jSRJFpmyNB/
         5+vQfT1XHK0cJ1EvI5NxJmnqjTEJcCsdcqqBLNaassnr9NVbjvOoMgGgZLsTa5qpnfjp
         cF6WmxWzyzmGRWMmg3lGbB3eW6kWlrpxmz47YQwGIfSGjVUsNSV89HRaBlhpmKTrbrRP
         tJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694543757; x=1695148557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZag0nbTh/60KISxMvfYW3oBhoTMiURqNU/JyM0of4M=;
        b=mhrsSwhSV6uywkH2wTvnoiHd/5xlmyvSnd8AhYpH/aJ03Z8RZ9iUYDTmZRPQRS6ZGA
         jUIBKwdxSeqI8mSYeHtPH2KJdEap/eofCfegyEVWT6fq7ya3vMk9vatMbX8Nh0xeLZAf
         hzYuyWBRdsG1YklL9eBVC+UUV4H+KjSOYDibhXJPTz+RBh59+6PjjI49HU4gl9gJjmM6
         lG2jTEhJsSORWvcDeq6n3Fu7Uw2ps8mK0bbSKEkdy9PrLzWDaaXcOW8K2ee1yIWkIkYi
         ZRJj0QFESr0Kz4KoCRJs8X8t+XMEfHeOhhyN2UzxQTB32CS4PqBP7TQuVRIpoHSVhYuj
         y6TA==
X-Gm-Message-State: AOJu0YzDKkv5a8B7vxzEKTB5I5qTbTqUa7XCBwA5zU0Ibs5ephZEo4aQ
        EQQAGlpksL1SVwfXNHx89yo=
X-Google-Smtp-Source: AGHT+IGjMQdzBZbg0ku2W19NjtZdbxC5I0VEjNvoGDDK53ZMRCRAjY2kmZiAPW9b8kd6sZnR9yNykw==
X-Received: by 2002:a05:6a20:9191:b0:13f:67b6:b65f with SMTP id v17-20020a056a20919100b0013f67b6b65fmr248450pzd.54.1694543757424;
        Tue, 12 Sep 2023 11:35:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u12-20020aa7848c000000b0068ffb8da107sm276179pfn.212.2023.09.12.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 11:35:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Sep 2023 11:35:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/739] 6.5.3-rc1 review
Message-ID: <82783c0a-fc60-46ea-8b93-0d3037ebe2b8@roeck-us.net>
References: <20230911134650.921299741@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:36:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.3 release.
> There are 739 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
