Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42D47D3FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjJWTF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJWTFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:05:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B4194;
        Mon, 23 Oct 2023 12:05:53 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5b8c39a2dceso836939a12.2;
        Mon, 23 Oct 2023 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698087953; x=1698692753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CoXVo5DxTAi4EBRQZDyqhjyxY/df+SUG51aUayqk9HA=;
        b=OKpUqJOW4TkiE0CmcEQEM3QmqldQ7nr/TwEu6jCdIr4LtXR0DhygiOEzKgZnhGwvj1
         CVVCF5bi62lwhiYlak/qqMqB34uMbMnT6ck34qBlmmaWD74EiYNX6yoHWNs1plMbyfXd
         2aSe6qxINv5lZFjl2/Fqcv9shRdTRPUpX2Tl7u9pH5/en1IONgtvURFduGVhqV6Pw/CR
         darOZMQdsPFARx9CMQhCro68gVe6hTwKX1JO6uxLbicpPG2kwaZ1fj+TwzFQ5wkZbMpe
         K9JJ7EEjfdTXfh9AcgmFmJwkgQz9v2LXlhI7crKIhsGqo9303SjoGc/aLsG9r83i+FFO
         i4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698087953; x=1698692753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoXVo5DxTAi4EBRQZDyqhjyxY/df+SUG51aUayqk9HA=;
        b=Rs+3ygDq+v6619umPnm4MYCONCNsINOkT7L6ylmVkuBiJYUgAGwF+uD8H6uZGlUfmf
         iCoIIMM3pmbH08k3C5j7av0kATqVg/g33oAM1tUINWgmqibIKRSRatUmN1GcJZFtzkyz
         cxSVOXOx/RmA1Jb0uC8WeiueDdvL8hlCXGwXwrC4/j2zno6LKST6mvuNSCeryOsoe0yI
         RTjY5TEGgaLY2FGNyROQzdXcOP58lQnkD/lfKydD5ds33nyiC/RM+EbO6sP4Q5YV9sA2
         UCQvB3PCVj2z0pguzWOZ7+VRPomjwTd5pfTkq9ZIYl1afRstBcgLXBOUjsvJ3Z+UhoFY
         /rhw==
X-Gm-Message-State: AOJu0YyFuIoWXRh0WWPAAFsKoVot8my4VPdtotYtuED1rDqtOgvhQD4I
        pJUuzmDIwg6lzh8Saba+iYDRgUw6DLXHmKetqSc=
X-Google-Smtp-Source: AGHT+IEmjuv59mNMB6QoRW34CgTQjFoFjhRKl9UCcPWJj5rbo+evs1HNpQ1eApafLDhOh3rJGbS6HnyW/D5i5doBuk8=
X-Received: by 2002:a17:902:ec8e:b0:1c9:dfb8:a58f with SMTP id
 x14-20020a170902ec8e00b001c9dfb8a58fmr9595524plg.20.1698087952872; Mon, 23
 Oct 2023 12:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231023104828.488041585@linuxfoundation.org>
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Mon, 23 Oct 2023 12:05:41 -0700
Message-ID: <CAJq+SaDPXFvHfmEGzbhxtPpqPCt-HHbvGyMjFWrTJWJGEGV7BA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/196] 6.1.60-rc1 review
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 6.1.60 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.60-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
