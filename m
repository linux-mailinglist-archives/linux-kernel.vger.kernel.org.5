Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3C780F66E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376960AbjLLTSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLTSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:18:48 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DDF83;
        Tue, 12 Dec 2023 11:18:55 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d852e06b07so3169533a34.3;
        Tue, 12 Dec 2023 11:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702408734; x=1703013534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lRI+Z3So7cR4czFluxvYwlfma5c41gzeBHqb5Y4Vja4=;
        b=L8ZKjkAj4FxUuDel9bmnOGK4HBLG4mWngj2QLiVQ99A3jpDeinLzXLuV0lyFGbO2Hq
         hkL6e330DaXwDzdCW+pqSswR/MeCX7S07m0SMqHKGc4U/z24DCUl9sg1PUKhRN3HqhYD
         FKQo9Nk3J8rAPjdTTZ9zk0PY/Tw7W6MJcnOPjvaMSkekJ9usnTIiAm0bP/jqXFbvZsYQ
         LrKYv8lVk/F9BGiKUU/W13ibOodmT7fNfHI6NX6LOwcKjxs7MN/s9dJsE+ALN9TYrcd4
         q5eJ8jYqRlIa3tBDl6AJ8LMQQrAcjoDaGrGAHe7vL9wkT0lutFFaxKagi4X0mSztUiqh
         n1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702408734; x=1703013534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRI+Z3So7cR4czFluxvYwlfma5c41gzeBHqb5Y4Vja4=;
        b=iwbLn70FD/z0b86V2KIu+7RYAsjZDy81Rr5xJda7/UX7HUCm6mwbfJTGOfItdXUzJ3
         72pEspHEoMPVcc1ltfVfgu1soco3+mGP97mysmZGEtBUGuSHYv6wlyvje2nUBsb0xV/j
         Lx6WSIkt0NehJRA/yhFX6z9I2o/vaQGcIGibspSHWbjy35lDae8NHI37jCWNNXL6MqIX
         oUr4xGiy71SYaRgBcCAOf7zuuqTQx/sAaE6olEzBxTwZuGfRQ0IgJUpHvp0u6NYbOhnr
         IdT0Oyj3O/UX0e8v032jDr/OpBXcpnBELqqBFnaZq7uwrMVIZkSRaw5i7Szpb9fhHVBO
         +6Cw==
X-Gm-Message-State: AOJu0YyfcvR+d8Xi05DUnsNTGocgJiUMwVRv3AdBV0OFModl9ExJQWZM
        jW9B6H9GHIYWiofGE4C6uSq/NAaGBD1wzEnL2vY=
X-Google-Smtp-Source: AGHT+IH7Gl41yzN1LlyzIXzr+mlZbXiwYsHqWWxOt4X/4Qmx+WYf32alvxIxL2Sd1mYkqJPxFCwDNJ75FR52QYnPlC0=
X-Received: by 2002:a05:6830:118c:b0:6da:3071:2f78 with SMTP id
 u12-20020a056830118c00b006da30712f78mr516440otq.23.1702408734423; Tue, 12 Dec
 2023 11:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20231212120210.556388977@linuxfoundation.org>
In-Reply-To: <20231212120210.556388977@linuxfoundation.org>
From:   Allen <allen.lkml@gmail.com>
Date:   Tue, 12 Dec 2023 11:18:42 -0800
Message-ID: <CAOMdWSKV3KfehCOpkANWxbbi7-kCwbBs93L12Pay6Bk_QRfPXA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/139] 5.15.143-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 5.15.143 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Dec 2023 12:01:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.143-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
