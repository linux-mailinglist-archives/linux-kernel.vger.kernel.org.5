Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C2A77818C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbjHJT3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjHJT27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:28:59 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB8B26A0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:28:57 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-563dfffea87so985560a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691695736; x=1692300536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LKXLnqK7mLXxFGBNP/mSfzDoE34EJtJtYOY6V+pFjw=;
        b=Vy6MwqMZHUwHzHqu0oLi2djO4Byo74KF00zJZc2rlHedIwBNKf7hKh+pgYZHUrYT6f
         AUrlAPL8z4N6upJx3SS+DHBwUZUS9nyI3KHqGXxX6TlCHbPFHr7/9S0yjBC2BKfgapCJ
         g9C4r68KWgVvAdtG0eWOTFph4rzQY39GNXXaV8M/Yf6pvvBqIdZr/tL6pX7TZbpVYqK5
         utTy5umNZEYo6b7W/QfDzeKmBIeffFbM47UaZWsRcIFObQ9HJLHz8/aMFDY2O0J3XW27
         9UpZaD4oDu0nWJWRvYCIzIjL0+Ls2gx+8fjpye3KmhXwCxXid+tPBWhlgFxhBIvkf/JT
         hHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691695736; x=1692300536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LKXLnqK7mLXxFGBNP/mSfzDoE34EJtJtYOY6V+pFjw=;
        b=DCPrKxXxmuBfy9ObxeVaHn4vMjUSapuKvMegAa5Cvl/iRb3T7scGicLJL/04qog7Nr
         1mKQQbzI3Tej33A7AUTJkeVX5grOgd/DfYdyhMY4AzArCkGH5H7L6hQyckvxOrMjjkGn
         9ulbsFXmo8G7bM6H1iVd0IpitqyFLbyOdwXRBN5jfNw6K9C1PeC4AvsKhk78yewziiqp
         61Pq6AdrdyFURTTM7kNC1SvnS3OOqisxKKBWcjOQ3qRy1aYi8AiBO5xWQ6Qgt+7PTRGQ
         RClyu2IvKKSOPNL5MgF4kAyBhJUpeZ4+zY8ZEhxK3YgxDTwttKuIupW0JgBoy4fKZWs0
         XByA==
X-Gm-Message-State: AOJu0YxdSC4c1kPbZb2waZSU+9Etn3vTNJRMm5Ilm++MQPDERNCbAgQl
        nvBvkkMkS+1UVCSxfNyA3NKp71Ap/GTOa3Btsb/EEvXtJnUFAzeYbusFVJQx
X-Google-Smtp-Source: AGHT+IG/BAgOkHm5XQDhsD/Oh//+tZl07HXSnzMaYEHIcpqsC6utQkylOcfF3gzZbCmB+Xpb14oXDYXxa7SPcDUJumM=
X-Received: by 2002:a05:6a21:2789:b0:13b:c4a8:1a68 with SMTP id
 rn9-20020a056a21278900b0013bc4a81a68mr3584038pzb.34.1691695736491; Thu, 10
 Aug 2023 12:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230809103658.104386911@linuxfoundation.org>
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 10 Aug 2023 13:28:44 -0600
Message-ID: <CAEUSe787p3uDD9Q0wq=Y=PY0-wLxbYY8oY6T24dhm+qgK1MjNw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/323] 4.19.291-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, lyude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, 9 Aug 2023 at 05:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.19.291 release.
> There are 323 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.291-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 4.19.291-rc1
[...]
> Lyude Paul <lyude@redhat.com>
>     drm/edid: Fix uninitialized variable in drm_cvt_modes()
[...]

Two new warnings are introduced on x86_64 with GCC-8 (defconfig):

-----8<-----
drivers/gpu/drm/drm_edid.o: warning: objtool:
drm_mode_std.isra.34()+0xbc: return with modified stack frame
drivers/gpu/drm/drm_edid.o: warning: objtool:
drm_mode_std.isra.34()+0x0: stack state mismatch: cfa1=3D7+112 cfa2=3D7+8
----->8-----

Bisection points to the quoted commit ("drm/edid: Fix uninitialized
variable in drm_cvt_modes()"), 991fcb77f490 upstream. Reverting makes
the warnings disappear.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
