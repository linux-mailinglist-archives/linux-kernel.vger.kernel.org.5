Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139637FB09E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjK1CzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1CzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:55:04 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648A61A3;
        Mon, 27 Nov 2023 18:55:11 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b843fea0dfso2976213b6e.3;
        Mon, 27 Nov 2023 18:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701140110; x=1701744910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lp7jSBC47fByZPGqr9EnpWb3tiu6l+5NeCMTHc/fUb8=;
        b=hLMOWWSL4sx6w9uiCHj4Pk32/FNHY/ZM6ljtC3d8iNimROBb8aOaPI5yIHbaGkOJ7a
         boKyNJZWXBj9MUXwUJvpUcbg7Yi6BFGyx/Q2NQ2QhhAylvCZx9ugZyEnastwXQcnVRbV
         k8KKoteyD8CoZpOEFLyp0BPGFgCmz9aMPKr0DavgM2x6Z9n331F8C7iib1PhD6wSVV/B
         7kAmQ+JDzMK69/e2lUQ+CZii/QfGalp8860mR2xRpHIvnskdQ/JlWX5ew6RwVrLcTgwj
         4Ny3ZecEmtHgpSa9LXDZdW88Mxo88U71TeobXXbMLJaxyFtXP4nWaAMst/CVLowfWHnB
         45tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701140110; x=1701744910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lp7jSBC47fByZPGqr9EnpWb3tiu6l+5NeCMTHc/fUb8=;
        b=WINQZyP09OYOjJI7nCS3uqc9NGEktXude5a6ZzkpmkFYsjcg6ROBTMGcAseadpP4KB
         eFiphq4PdwFZ3eFqsMf/mTA3s//aGATU79qsbyg9qdAPghZ83qP7pxZ1C8eQbQMVwpVZ
         KaNwgCmmSKtw8TKt46J9z44K9ceLS1GVGdqMJvlPxsFiKeQf1GBAE8QCvxilUqWX0/Fm
         fYC0rVJ97EOyt6MVd6uSJi8szmF5XmWtMJxWbuD+8UiEETwlJ31yjlH7qMOvTljyq1fs
         +9JdWRysINDx7DMueHhZbrmvZreEz07XgF+8hx9G/u/tLZ0IKLeIl00rjeB9NDVu/UDS
         7csw==
X-Gm-Message-State: AOJu0YzqwFW0RrModhCg0zcy7boYF/by8+36crSgbRxNmfgG3dIpYtaC
        CfXr+sML5MrwVw2TjyKBaRg=
X-Google-Smtp-Source: AGHT+IHDA2R8rulOPMAOxsdEnIk3WJRN0edoR9iYypeCY58pkBvNjGmIFmkgLYaa30fHO9NPbr9gLg==
X-Received: by 2002:a05:6808:494:b0:3b8:4614:8b27 with SMTP id z20-20020a056808049400b003b846148b27mr15019973oid.50.1701140110712;
        Mon, 27 Nov 2023 18:55:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bx17-20020a0568081b1100b003ae165739bbsm1693498oib.7.2023.11.27.18.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 18:55:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 27 Nov 2023 18:55:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/525] 6.6.3-rc4 review
Message-ID: <5ce1915f-45f4-4191-8f3c-c58bed478beb@roeck-us.net>
References: <20231126154418.032283745@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154418.032283745@linuxfoundation.org>
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

On Sun, Nov 26, 2023 at 03:46:18PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 525 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 

For v6.6.2-526-g0f3bc3a11114:

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
