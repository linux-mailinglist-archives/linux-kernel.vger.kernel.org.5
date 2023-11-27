Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF157FA87A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjK0R6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjK0R6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:58:09 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF456186;
        Mon, 27 Nov 2023 09:58:15 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58d1b767b2bso2292749eaf.2;
        Mon, 27 Nov 2023 09:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701107895; x=1701712695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gbVUsMmhBFYQhL3K5acsfFEdBlZV/KGoXmBwjmEvAxw=;
        b=GH0GJ9QnJaeQIyYRdpNMXFfjbMQRyKu/MfHOBYmPVuV/bNUC/heR0w3pjNSNyEaTNU
         K46rpBvkXNnn7C3WgujKnM6c4HM+/ThxnCFal/alaR9tKops+vdDhzNsPA8iheofQ3Gc
         tlREYqmteCoUTKH6+udmXRtnMREqN4ZqKXcT7yZHaeTe2NzUveMb0LW3K4E6do86plMy
         w08FkMDEX2k+jZrFY2AbgAFU9JjZWrEuaAzJGU5LqGi8yC6rJo1g81BH1nHALt5ir+W4
         IGp5hPMqM2LQDK2TAMVy+dXQuNurmrYLmNJKB/EBhS+ntUrtXBEYLk4ey7zJ9b+s/4rV
         CkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701107895; x=1701712695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbVUsMmhBFYQhL3K5acsfFEdBlZV/KGoXmBwjmEvAxw=;
        b=bOMSBRwkAkdtRK0L/+8gstgN0iRn97afXYGKVh7k1kFSru3ruuIPEkOzV9lCepyO+X
         HG3KCzTRSTlWrsBkapXpEf7VEJt1J9Q99ksZnfDbqlBjkSQn+FL1AADGlrUfQrk+o/Db
         Lpy7qT+50w/Ta+L8Vi7zt+XBlZTYgvbe4rAzKADl0XXBAHV0UwPQQmz1YLIRyhemogXO
         eKoHpWMRBQH+LBIA0fUvdldDQnT9ApqNxGo4X1AaOeoqYqSiQkFlQEkxVJTYjRQBdKCm
         DghXBwjh9bCl2zzP/k8QZiJN2bvIlZrG6JJ947HJHAEnD0MMAYaVp6OmZ1ZBj9/NWLZH
         RRaA==
X-Gm-Message-State: AOJu0Yy5GZkOolc9042rKhbxvULtgpQnufbsFbCje1/SFEiF7pFM5pc2
        1Umu0rK5ZimzsYaDnA34yy16UMuqZzS2hD/hRW8=
X-Google-Smtp-Source: AGHT+IEQvQcO5ygU+WPtLyMNZuQgwtHC6e4Zk9S9tzuV6H91tnxuiHnljv6ue6dwtR8xy5TU2B0P2NPhEvaXmHpGFRY=
X-Received: by 2002:a05:6358:52ca:b0:16d:fd6d:58b2 with SMTP id
 z10-20020a05635852ca00b0016dfd6d58b2mr10877692rwz.17.1701107895165; Mon, 27
 Nov 2023 09:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20231126154418.032283745@linuxfoundation.org>
In-Reply-To: <20231126154418.032283745@linuxfoundation.org>
From:   Allen <allen.lkml@gmail.com>
Date:   Mon, 27 Nov 2023 09:58:02 -0800
Message-ID: <CAOMdWSKKEQ05J5UYXj9oGUYfitkReFoS5rBKeDMXo0vUkd6L_Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/525] 6.6.3-rc4 review
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

>
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 525 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.3-rc4.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
