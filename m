Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDED75803F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjGRO5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjGRO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:57:39 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FCC170B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:57:36 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1b055511f8bso3549662fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1689692256; x=1692284256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ajGnbQm/rLYXuNtWUbCODJbO/kcfV5H/sqF7rkfA50=;
        b=Msx4QTQtSnVJ9XtUxSqqTdJ0CRSQW04CPD3u9jeJGkFbeTt4zs0Nvyew7U1OJGEVjZ
         RrTu/YNaBBiYru30zFQNB19eD3V+Z0YKjZjd0JthlwVNmcmMofXdv9c0iAbYDqDh6YYz
         kipF2gHUbJjsb7PljnF0HRUrQie7KVZXYc22o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689692256; x=1692284256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ajGnbQm/rLYXuNtWUbCODJbO/kcfV5H/sqF7rkfA50=;
        b=SNk3q6XMWlN9uZuQ179qBy+y2qiyDXvDoziyp+c2Z6pbdnIMsvwhhkPxfTwuIyrHIQ
         vMTKADqwcAsf1mjKJYDMGet6ZICdDzKoUL9oG6+xMYD+Mis4II76W6ivSv3ZpcXeqIRL
         6sTeAhw1QaxbC4p/fV/qCXuy5aqmDBloEriY0n+wXJuQoEChJ2HzSXdGygYU7ha6NyJv
         1EJ/zQmZRnvF6t4oZ/Jm4IAIE2yk+YA7PevUmrN4fmB5PXH4pwu8mXdv9W5jjhPsVgFh
         +jLaPa1I9Q3pLosiVEbW0nSA9xpx/f5tH7c4zK7Jn6Qr2fbAdOO1HV7aQ1TDCSkPsN2i
         D6/w==
X-Gm-Message-State: ABy/qLZJjMWQX0afabFmtTMz4pN2fZ0vI9e2nHpMIaXYZfh2SPbrD0QE
        KYIQZimSzh3dHhqDbmUebs7Fdw==
X-Google-Smtp-Source: APBJJlGZ/mf6wjS6YG1j3smF6gpBVoDg0/l1WxbJHkjurwV48aiML6HbMqZw5++oYLIn1hZ4MmLjYw==
X-Received: by 2002:a05:6870:d209:b0:1b7:5ea8:1fb with SMTP id g9-20020a056870d20900b001b75ea801fbmr8939199oac.14.1689692255657;
        Tue, 18 Jul 2023 07:57:35 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id t12-20020a9d66cc000000b006b93d1e8e7esm879561otm.69.2023.07.18.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 07:57:34 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 18 Jul 2023 09:57:33 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 000/801] 6.4.4-rc3 review
Message-ID: <ZLaoXb7K1O+19CEa@fedora64.linuxtx.org>
References: <20230717201608.814406187@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717201608.814406187@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:34:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 801 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Jul 2023 20:14:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc3 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
