Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13F75D0F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGURyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjGURys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:54:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253CF3583
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:54:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e5e4c6026so2929819a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1689962085; x=1690566885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjkRTaECuNngklkqmuey8QDFNRY+Ib5isKPE9flrp4o=;
        b=DYlabRZyrBAtigJv1oK1ilQ1nyN4CpyVfMjId24nLyeQwNgBmY/XEjNeVodRL567/0
         NGAD7R8fk5si13uFZifLYe6C21iKvssMliXk04MZyhhhZNg8sIFoxSG+mWEQ3Oqb0h6n
         3XvIDwvm33o5CRA+1pYC1nC8LP7Xxth00zKmN6/m6MVsClIEyyHkciTLIagQbOrPnWwh
         78LP6VDlTZzsoK5zgHhDVT5Qy9zeLL2K7AWOCfN40N3YFH2grtwTa2A/P/fz8SC4ktor
         xFvSgsWRuun2vdvxtzY4WBsskvgDYcH8L/a3aQHrZs2bqco20mwpVKt2GP/crc7s3BE/
         8nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689962085; x=1690566885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjkRTaECuNngklkqmuey8QDFNRY+Ib5isKPE9flrp4o=;
        b=XgdWC80zg37DZDjZfUGMy736dfv+2U0X1v4YcKyigSUnRnubo58xUh1MVRBNTaMMql
         yYbjw7yeYgGIVfjmlfnTrpB7ukuzH115nAInguoY+utvE1TYMJi9kL1qId2Mwg/bBC7q
         IzCkJTrFvVk2bqrjsz8aUkuFGpZXmf88svyLx6XPGtjjKfPdpNQYy39LL35q3Flcr6Yy
         LMKS9Ba8bFKjxIpr/IOikqRohF/FX52bWGQK+YHvHD3dOW/yO2HLcYuHii3VEgJkelcz
         gzc1xxxIB2daWzgDXLzrqYIfpHTS/o1MseOqZRi0NbzdaLyvqJAALgT9x0WZ4wPicefM
         LlCQ==
X-Gm-Message-State: ABy/qLYd3OALQSloEQS8sQF3v1BA75IQQ0ENTG3gCbXJ60dZL/7s1j2f
        f2qeFGXvDqpnK0j/toSypBnpwbKxz1jPhQXg+NsQwA==
X-Google-Smtp-Source: APBJJlF4l3FSenIHeRPlauSq1HxXG7xMFKq+3I+4+GnzMmk3eVgiT4h/Qip7SqbYCPlEeqqDEiXVZvzaaIgsxpT2pxg=
X-Received: by 2002:aa7:cd09:0:b0:51e:54d2:b52a with SMTP id
 b9-20020aa7cd09000000b0051e54d2b52amr1993264edw.26.1689962085413; Fri, 21 Jul
 2023 10:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230721160528.800311148@linuxfoundation.org>
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Sat, 22 Jul 2023 02:54:34 +0900
Message-ID: <CAKL4bV4J5wK=piP7n8txU9RWR=yiH=fArTEDQHUYTHgvZLDLnQ@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/292] 6.4.5-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Sat, Jul 22, 2023 at 1:09=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.4.5 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Jul 2023 16:04:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.4.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.4.5-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
