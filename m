Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460E776186D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjGYMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjGYMdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:33:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17149172E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:33:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fdea55743eso5089150e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1690288391; x=1690893191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKpkzF96g9NgPXhoWUx4qyrJxQAYJZi3pZkdXCYeBMY=;
        b=4svnrkRxCvqD6vorNSJ9EaNW3eXE3a6UZ2gc6wDPppaH8KH26QSUVB5VR0+xPfNfkB
         3uwaDda0GVEq5B74jOGO3Sgj30u3I/rpJan0+jcgEj1o0QElQte7N2suv86J3/SLewNX
         9JDYA9sxvSUT0QGxctNzMwl1/+KGZ14n5jAm3Vywncfc+FZ9al9JCOFhnB+LJgbvEJ4p
         76g/SCsq+F4PvA/D7gx78PCLrNyjDniUtWMBr5BAvKwHI8+AUoUgzNHyWru9hdl/q3ff
         EQIng1U+whNHxVRd3bNHL9CtvRtJAAR1w/Gw4y/3SapsDAgOMcINyW+xnht4HjrTw8+y
         VFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690288391; x=1690893191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKpkzF96g9NgPXhoWUx4qyrJxQAYJZi3pZkdXCYeBMY=;
        b=ilFSXEiplB1PPkAS+MWqV+4OyZZxqSSoV11WhuB7C4qfKf+Q52NUSMhDKqc9J9piwe
         RTZvRn92wKdBoVFJCqitjLlpuuSpRwj1rPQJ01Q5G9YAvhgj3pB+PAgPMd4ni/ECu6kG
         sm0zrNbXOUImwgnExf6TUUjgUzfoSyG67zrnuJFAaKhnxU7wa1dy7gg5x+fQlwMW2644
         lEdpQ/CcIS0sp6sc5RU5sL9iBi+PscSCdDE7qrTVbNMfDf4zinHiGbg0BRl5NgkUjGPW
         w8DdtCzs2q5xdCtdke3D3xzYcuckulj7vtm+vl8s6sS8yDw8WGRvkZw4rZTsDpLoGEFM
         ADug==
X-Gm-Message-State: ABy/qLZmr3nuDpaBH3R4CAMjSX9D/6TIOq7X3GV1YQMKG7R9HsqQ1k9O
        LJbbwjBAr8QCN7yQXifaVih6g30HrGctk6I/8hB7UgboKZghBXZGcyk=
X-Google-Smtp-Source: APBJJlHmfFkFQER3q6Dst2bu92mvAGDw0hUkJ4O0za2LwpY5NSiE/siaSsfkrIU/FsRkfek7BbGEr5EpbXqs7WSnVUg=
X-Received: by 2002:ac2:4f05:0:b0:4f8:5696:6bbc with SMTP id
 k5-20020ac24f05000000b004f856966bbcmr8779702lfr.29.1690288391202; Tue, 25 Jul
 2023 05:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230725104507.756981058@linuxfoundation.org>
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 25 Jul 2023 21:33:00 +0900
Message-ID: <CAKL4bV70qiD5jFcx9ALXJdCS+OBeQnZpAwJZZsJhs6=vCmewsg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/183] 6.1.42-rc1 review
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Tue, Jul 25, 2023 at 8:03=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.42 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.42-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.42-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
