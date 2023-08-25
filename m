Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514D078878A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244813AbjHYMeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244880AbjHYMdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:33:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F88226B2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:33:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso1359030a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1692966797; x=1693571597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32P+ZFI1tSBojfi+E4xOhhTXJzH5jER+YjKVHzgSHAY=;
        b=3/pPdnklLTkdbJrgJjjALLC8S9ds83NXjsVorOj0iSf6+JOH8lir8uFRqKG6jmWPy1
         SPr0o3gfGT5Yfn4LFHq8NhmF9KpZg9EefVxYUchbr1wIVAD2jLL+PhrhAHICCuCvBKm4
         m8NhhP4ncZ34L9rcscQKJpyU4MiofBRki8f6WMlhJkpPvyLDKS7LLuF1EqJ4w1+pnE90
         2dQxfBLlvVTHhMst30TsErK2v1ph3CGs6lAQ5AJsMTTDWg61TVnHRE/NdShkd40W3WFF
         diaqMnMWOIzFox+XEC8ibWHvaos6f33EItwBcHkzIwQBQd0fKs4YOqEuxvyEgmvEA7yx
         Cyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966797; x=1693571597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32P+ZFI1tSBojfi+E4xOhhTXJzH5jER+YjKVHzgSHAY=;
        b=IkbSr/qVT9yY3LpSeQXAz6HMCpgPGLSPGEwk1y1dG2D5tOaU1CKt+N911Ww1H2MQBJ
         QNsD7qQObqm7vXwnm7IO2M1tFq4Y8U53+sF3uP/h3l6XA10odfyo2xwipZuTt6OUo5aU
         I+G57QqvLVtxbmj2nsL8IKFNhoYvzYWKe6zWZiotcrZeevITTUq78gSk/ADH+drsSQSe
         SDab856A6AtpjSZuLNa/DrDVdsTou3gBxqwwphESBHsOX/7qWv8xo3khw3NTz2Y7S42v
         i832ysSzzBb7DfMfm46kdEhb+5kNmD4XB6vviZ7Ep6LLmWgaYFM/b4huUk8YAX1ZMyZH
         oP+w==
X-Gm-Message-State: AOJu0YxEDD/3GM0HgwesJbnczf7n0EINDYIQXduXI+kcV2ZI5ngfLR16
        v8eQDkD3/dVS6689p6QL70DSmGJl8m7rGrLS1KSuOg==
X-Google-Smtp-Source: AGHT+IGaKjOzBddpOyoRZ6/22JOWZ17clvrTJvTI5coC7kWzoLT+Rqa0qdBOS3qSGTaXHQW2d05vTnDmbIn4hnC0mD4=
X-Received: by 2002:a17:906:cc4e:b0:9a1:bccc:ef5f with SMTP id
 mm14-20020a170906cc4e00b009a1bcccef5fmr7737503ejb.53.1692966797212; Fri, 25
 Aug 2023 05:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230824141447.155846739@linuxfoundation.org>
In-Reply-To: <20230824141447.155846739@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Fri, 25 Aug 2023 21:33:06 +0900
Message-ID: <CAKL4bV7tpe696zsOWxF7uv5J-Rm0E=b5BVLw=+pbe7Wpmwv17w@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Thu, Aug 24, 2023 at 11:16=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.48 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.48-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.48-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
