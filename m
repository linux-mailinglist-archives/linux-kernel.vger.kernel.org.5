Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D047D758381
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjGRRbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGRRbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:31:36 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC81B3;
        Tue, 18 Jul 2023 10:31:35 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-345f4a3ff76so33059485ab.2;
        Tue, 18 Jul 2023 10:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689701494; x=1692293494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nN4yUB0jlAYCAuN/np605TVswMMjj5X546vn7r9nwQg=;
        b=eBzMowJQUx3NctvOkVygaUs5EtWXyo+7DwQpNMhDxk53KiJqP1MU06g3PdkqkcqPlB
         c5UidITkzoanC1kkTFnMHQkUOrXaK5unKl8aaaC3zzoNIua+0UMYaqoRvGmPPYj5rk+v
         BwfdI28Qp1dX8sjDEOCS9X7aEsaQw1yJU6arX/NN0Z9s6bEwY9W+fBQ+KJxP09qfuMlA
         6Uid/792H8vNQCvvbZUkV8dczI93Kh+nCioH9VLx5NOehUOFRo7oNkeo0Ihy9xKwAS/d
         BBCu8YBZA1ddFrcZKBY/THmPUtBAAD+b953J3kSwwnbxUGzy2SP4Ivrpz2R/lJq7/+xx
         kWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689701494; x=1692293494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nN4yUB0jlAYCAuN/np605TVswMMjj5X546vn7r9nwQg=;
        b=guZLcKEfTG4cTTabA55/pWVz1HDrLKJlsf/cpvwjruyz1HCECfSveyKbAmBkzkWt6E
         lf55WTQDbF2NoSI3bAULpO1V1Ta6DSFuWF0c2JnWPGrZ7vNayTTwBG2S6wiUqzUYRebU
         /fg3sXy2N9atPvy64ejKKjxJlqNKMGB9YFvOMZDoT2TnhPMIgSQGpdT5PvHA8VXQNari
         tutEHHrRNVfWLjl4h5sxwBl3XpMqltt9NHdSm0mz5E9dlWbW/DYJpBP4ppbOoWW7fJ7a
         Boh0bNU3xAm2jogx+0QKEUzZle9loiDDjRgAL8Tsn1q5Xy0ph14bRVMyD5XIHeuGFhHb
         G/0w==
X-Gm-Message-State: ABy/qLaQkByhDh7247TctBGaA8OTTSZkEbSjRityEc17M47faXLpvNJd
        opTWlOQtmljYcVJjXWk1DbGJgIJuKEVM6VGdaf8=
X-Google-Smtp-Source: APBJJlHjIYS54pkZbdWSxIcrJeV6A8rpuGLvZhb8ePllk6IBa/eKWwZ/uUyoyABRnDgxMhaM9yX3ZcCbG5bN88PPhh0=
X-Received: by 2002:a05:6e02:1c48:b0:346:59ee:bbd with SMTP id
 d8-20020a056e021c4800b0034659ee0bbdmr142586ilg.3.1689701494635; Tue, 18 Jul
 2023 10:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230717201608.814406187@linuxfoundation.org>
In-Reply-To: <20230717201608.814406187@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 18 Jul 2023 10:31:23 -0700
Message-ID: <CAJq+SaCxr6ww-kVFJMaN6QiO1AnCQv1_ONFmp=Xr+GtNgJqLfQ@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/801] 6.4.4-rc3 review
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

> This is the start of the stable review cycle for the 6.4.4 release.
> There are 801 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 19 Jul 2023 20:14:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
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
