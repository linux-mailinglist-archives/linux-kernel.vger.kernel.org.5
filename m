Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A378077D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378882AbjLFSoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjLFSoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:44:12 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3FDD72;
        Wed,  6 Dec 2023 10:44:18 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso37141a12.3;
        Wed, 06 Dec 2023 10:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701888257; x=1702493057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHSa1Vtm8ENnFSKNRrC+G4CYG5pTSbLbNbW2JCCKIyk=;
        b=gH/S/A34AcvubzEfm6SyrLY9ZCOu50zc0e195b/RiOKRysKzHXiLVTLqZnmMQxyMrZ
         X+uxra0bzL1bQZmw0U2UE4Yk5evlVaCHcJXsv/R4JutWeXNuxc9UanOV/zffLv/GkmZp
         wI6w1ntz2VJe9FbSmawAaHwLxUsYrRZFNYt9ta3gQeHk07hinc9t2kTqRv2clHptngQm
         mmxP8uyx0UNfcdHiYnfOSbXvUtaPdmUHrTnoqFb707+MTmGMtHizwfJoI+/4Dfs3jIGX
         aTHmbmIQqdS2Lp9GOYcDXhVU/j4rQ4f93y4SxBI52mJYdanRCR7abBpkVVK1fH93j70k
         DuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888257; x=1702493057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHSa1Vtm8ENnFSKNRrC+G4CYG5pTSbLbNbW2JCCKIyk=;
        b=n5MBr4bbgbZn9lYgWH98eStkNtMLqrz8dlZzMWDXW4rzePAdTkEzmzz5n3wg4nfd5t
         zVWnHE3ia+i0ru40sodn/xWidCFFumuev8GioLb7zrwHYRe0WFTkrmPWgzMt6n9t7Qem
         zP3/mvSFT9kZK+xAUMFYsRW4R1TEoz/3H0AWFEjic26siOKy40o+mPjgOIzfihCz1jJ5
         hlE/YVqqnRa5cWsAvaeIfjaZtpN+C98xR7sKY68u9hdNQ3Edonove8wSglF8pi0YWhB1
         DS+GbN3BQpC1LpLfJ2YoGr4gqwDbVRvnBYdVmy3iDN+sBEq1nlIW+6su+SfuHp8lweUh
         RbyA==
X-Gm-Message-State: AOJu0YygBdFtoAsAUX6l+6Dpfjy2fvlWXIyDNXvteGKK1YZiwEhuhxft
        2nAsNGoT+YrfyLXX5tK7iqQ=
X-Google-Smtp-Source: AGHT+IHjMMG40c19XWMzxRNZfxX9z6pZGjdTjpYc/bi0Fn6rgDx96b3o/qc747OkC+HKXk5fee5m9w==
X-Received: by 2002:a17:90a:3185:b0:286:6cc1:27e with SMTP id j5-20020a17090a318500b002866cc1027emr1072645pjb.73.1701888257483;
        Wed, 06 Dec 2023 10:44:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ok17-20020a17090b1d5100b00286d905535bsm177903pjb.0.2023.12.06.10.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:44:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Dec 2023 10:44:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.4 00/90] 5.4.263-rc3 review
Message-ID: <b34bbb33-5521-48aa-b32d-958d8da140a5@roeck-us.net>
References: <20231205183241.636315882@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205183241.636315882@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 04:22:16AM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.263 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 462 pass: 462 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
