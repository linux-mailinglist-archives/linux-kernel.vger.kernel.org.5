Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82C7883D2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244038AbjHYJfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244328AbjHYJez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:34:55 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C802133
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:34:26 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-48d2c072030so1094678e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692956049; x=1693560849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NkOXDPx/S3uX0LGrWHhqDuzgnalOjRvvuzfXBDquIJE=;
        b=ukX0Pnuivh/o6xISkXG2MwEK0o1GsQV27v/wL8PCYr3K8rw4rCQ89pL5zDucAFhMcb
         YskOrO04SlvsfelPwM6wi6bo33kueI9hAzLSHaH+rO3C/KdletWIMPRTOYoAyAI3o5Bb
         gwe8YbDTEL9VB12BM6LBCliW9FWhwvSr325DZcjSigPSeB9JpebjY5rhdU88q9fnhEcr
         bO6YXtDqCkq7TIBUj7afnMs8Ik0gKHvbzTGASsEDdGmUvf5tgRjCJeHx7rzEZgS3e+cq
         5wBCW0y7FKsG5YGqd1KFGnDwwJz8ywHAaQLG/7SL+2BGaFhCrt7m2jYp93piNMTJfTI7
         5ZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692956049; x=1693560849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkOXDPx/S3uX0LGrWHhqDuzgnalOjRvvuzfXBDquIJE=;
        b=QnG1WpT986LYISSDZsQyHmw8kICo/V3YmS9wVRUCVgE2J8tdLzOWpQ5wEKwk4PsacJ
         d+LJKtW8UKEyubzM1vY3TzN5NcIh4Hwdl/U2J7CX3NoajqGGkGHq4bfdrqqqSkLdLOnX
         stD096Nhu11lVBq6fEf9q0nkm9EcqKyUaScFejjZgFxz3AjZTN72CpSJNHzDo1ytuW93
         EcUdkBWNBpVLOow49pIh3u/7FI4yY4DO4olf0j/qlp9aSCeCjZxJ4kHFMlDTCj+2ivL5
         4LhDG0ik5d6eu8BVvG5dkk7ULHTtdNbz6OiPzofS7YrJV4hgib2BKhw6PODf3kS1kPtR
         wLkQ==
X-Gm-Message-State: AOJu0Yz4XPWe9vTn87EClD/OAQO0mUdbs2+37NBxYhPtDYHwRwY4zNHK
        AnSKm76yJ3p2z1BNzXnY7IrtPdm6EYK7dR7jyq5Dy5fvylwR/U4A
X-Google-Smtp-Source: AGHT+IHYxHlYu/b9jq1hZYwDJBTUYSSDdzBlVxG6txEHWSCkNIMRdBra+qgQir4lLTbNjKOfAbjN9wZa5rm8CXm04BI=
X-Received: by 2002:a05:6122:2527:b0:48d:969:af8b with SMTP id
 cl39-20020a056122252700b0048d0969af8bmr10536527vkb.1.1692956049376; Fri, 25
 Aug 2023 02:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230824141447.155846739@linuxfoundation.org> <CA+G9fYsPPpduLzJ4+GZe_18jgYw56=w5bQ2W1jnyWa-8krmOSw@mail.gmail.com>
 <2023082512-amusement-luncheon-8d8d@gregkh>
In-Reply-To: <2023082512-amusement-luncheon-8d8d@gregkh>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 25 Aug 2023 15:03:58 +0530
Message-ID: <CA+G9fYsxAgRcvc4G_mU2LW+bw3aUVgTNGd+zmkhkoaXUsWv67Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Sherry Yang <sherry.yang@oracle.com>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 at 13:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 25, 2023 at 12:35:46PM +0530, Naresh Kamboju wrote:
> > + linux-nfs and more
> >
> > On Thu, 24 Aug 2023 at 19:45, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.1.48 release.
> > > There are 15 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> >
> > Following test regression found on stable-rc 6.1.
> > Rpi4 is using NFS mount rootfs and running LTP syscalls testing.
> > chown02 tests creating testfile2 on NFS mounted and validating
> > the functionality and found that it was a failure.
> >
> > This is already been reported by others on lore and fix patch merged
> > into stable-rc linux-6.4.y [1] and [2].
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Odd, it's not a regression in this -rc cycle, so it was missed in the
> previous ones somehow?

I have re-tested with newers and older versions of the kernel and here
I confirm that this is not a regression from this round of stable rc review.

We have made a couple of changes to our infrastructure and are investigating
the root cause of these two test cases failures.

- Naresh
