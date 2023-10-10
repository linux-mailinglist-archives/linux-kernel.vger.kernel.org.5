Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459FC7BFD36
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjJJNWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjJJNWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:22:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F2AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:21:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-534659061afso9390940a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1696944117; x=1697548917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU3Xy//CzLR7h9ZqJQnq1g0juofjmbb1k71SCC4Re8g=;
        b=ERUxJsMFmcbi6cTpP+RhA6ABMs1sg6DH4cLqmhfUYZCeO9aT5/87wEMxR0vymYuHeS
         a/ySIhTkf4AKjI4BovrLlWpkWTjZnJFqPT/4mhaOgOD3RLZnxJiz0I6xZoeOcU6sif+A
         x1w1Q/bLbr+6y4aRxOfE+QJg4Jet9yHQY2f71pEd7V1KmbqarhCePT3CoRhi8p/2ehch
         xzmgggm1sVnLicH2Id1XbLxRU9wW2xnsQg/uz0RKIddwU7I+ErWOCOFbyEtfB++m8ctN
         elVczoEAEVdPSTFLk8FV9TdrYYIiVdz4+pQGSHT3IfobvcpPUtHjSU+iVDbhDIpp9Vho
         eb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696944117; x=1697548917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU3Xy//CzLR7h9ZqJQnq1g0juofjmbb1k71SCC4Re8g=;
        b=gWmeOJ23KUEQhj2Ns+OQcCQbWgLu92sBgyzck3TORXx5wZ+zz7+4OanYBXWJdWElV4
         xj83TdEcnbiMHO5DYGmFzOMcCbW2QqqMrdrYAEp6XHhjs6N2JFSYss9Osk+toAShZMWc
         +ejIvqmUuez+NjM72RZN2O9F9KFXXd9caQzB5eSATq0Tekqt1spDKxpQSzTgSLz8ZVmH
         d5ES8PEQl++o9EJADkcrpFAyKNkoeeY+06uxtBN3MStr9b4DOkvvui0/mCFmB0eHwHu4
         jlVRImvHH4v/B8+6Q9reiR5GNYv0mGvqG2bnMVLnR+TuNszB/xmiITqPCM099CP935ry
         PYBg==
X-Gm-Message-State: AOJu0YwBXx4OfO4GESy/e4pXXbnFlu6uMqOfYLCF5ZahXQDAs8qjbxWo
        vF80ebrHXt+O3eO0CKw3wXOn5TMWmWl5j8M380GcFw==
X-Google-Smtp-Source: AGHT+IEGxCodEgS+dG4Qmb/gPW4HE0qW8E/tpxQhRepvXhxikQlgiFrJMtbJ2Kx1NfOPrl6efMMFbwubxYJl8VIKgTE=
X-Received: by 2002:a17:906:844a:b0:9ae:73ca:bbae with SMTP id
 e10-20020a170906844a00b009ae73cabbaemr14081742ejy.62.1696944117138; Tue, 10
 Oct 2023 06:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231009130122.946357448@linuxfoundation.org>
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 10 Oct 2023 22:21:46 +0900
Message-ID: <CAKL4bV5ZhhThGzTgo3keFKnnHBwfnhZ+7P6HMX2xAPjhZTFgug@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Mon, Oct 9, 2023 at 10:16=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.57 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.57-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>


6.1.57-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
