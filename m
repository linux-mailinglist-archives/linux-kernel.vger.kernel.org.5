Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316B38062BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346519AbjLEXKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEXKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:10:23 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C9D120;
        Tue,  5 Dec 2023 15:10:29 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4b2dcc7b71dso837455e0c.1;
        Tue, 05 Dec 2023 15:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701817828; x=1702422628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex0xuJD8dLtr5W9ktKmdcDTgblnS82FZlDJnqATe3g4=;
        b=LyTRxQoMU4+XMDXB+XDWsGZPaXUowpkcCQFqs/VwaPiCf/jYauO5mS7Grd/hZ/w9K/
         B6LdW4IQKyHS5NouYs5zkNJegT8C2J9Js6Ot4im2mKFKGWgdYRYG7lAPw2WMlZzDsM05
         vKTH1jTwAFOtQJUaaAchR0yhgfz4PfXyDLYuvFdUmC7LStpbrCxiiakUrOA6mQfRnE6D
         bH67g9djYWxKtWIwLAKrNBWirKPwDQ03Nah4MYevbsxGsnMNbWjjmzAMXiowlayU9Qb6
         kD0hFl1FAaiUBmJ+J/O1uSh1pLJ1TzQ2A/obuV4QGmCA2QNsxWbxRO9OkVrsdh2RSYHy
         ig3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701817828; x=1702422628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ex0xuJD8dLtr5W9ktKmdcDTgblnS82FZlDJnqATe3g4=;
        b=U0qRZ2eEErk0YC4GjbKCAEwjmqy5ivcjOTJlFm999HCSO8pFH7SNHqi4AB0u7EodUb
         wAAubKPSKL7IfK0w8NrBOL6DXJn1aPo5dhjTBdbOffSSStLoaRxspneUPUAcYRp0RpXt
         XlBq5nrkjMz3XDrSqFei5WcEDQVDhRWIgNj5hmkpr2jZ6ehJY9GDu8C5+mCsK11enqbF
         swTH+ku6jWP0COcBeeZLcFfWgcadgvpur7AKHQWE/LFvXlWbhMYpmK1lHHsrl8nq43Y4
         oxhjDbYSAcZpb9d8hABV6Ps+JuAF8xWYTQasP0vhuURzV03icgVcQ9IlSM+k1xYrSqaA
         BZgg==
X-Gm-Message-State: AOJu0YyrSr0S4CrWXz1zZU8IwBR2UyDYGUo1TYOZc8lbqj+n0D6lO5yQ
        S7OT4w9wSaoZVYAN4OyIx2CrH7/ZH8VINIzBKAuXJnX8yPE=
X-Google-Smtp-Source: AGHT+IFaovgYQ4wrDhxWUlbTwSEWewXKPDQW59WqOhWKaNUvPVYJ9Qd+nU2ms3ispWoLC3oQmcYI2LeVpK+FDuHZLWs=
X-Received: by 2002:a05:6122:d07:b0:4b2:8ac7:1a92 with SMTP id
 az7-20020a0561220d0700b004b28ac71a92mr119598vkb.16.1701817828563; Tue, 05 Dec
 2023 15:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20231205183238.954685317@linuxfoundation.org>
In-Reply-To: <20231205183238.954685317@linuxfoundation.org>
From:   Allen <allen.lkml@gmail.com>
Date:   Tue, 5 Dec 2023 15:10:17 -0800
Message-ID: <CAOMdWSKuSZE+fY9Q6kuK6YY_iOmKSOUNxRefGGwtq1dY07g2rA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/64] 5.15.142-rc2 review
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

> This is the start of the stable review cycle for the 5.15.142 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc2.gz
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

Perf builds fine too.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
