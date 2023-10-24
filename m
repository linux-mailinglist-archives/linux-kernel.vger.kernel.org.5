Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB867D4FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJXMde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjJXMdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:33:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDB4A2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:33:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso9261095a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1698150808; x=1698755608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+d68ElJXb15txlNQvNv4dpc2clYVoBlH5oUxqTkrhg=;
        b=v4CwPlmVjoGf+STU+UdvRuBYXIlFCvGPV3W6hScV0bT/LKFe6N2manye//X2QNkEHJ
         trUSoi5DFfwY21qFcgvlL3vpMSyhKtQoLoN1jX1sqFE6At3Y3BTGvjCR/Zsv8BcOhKqi
         ldecWwnCkLbYvlVZ4t9X1lY1L4/EMBEol7/jgrcyyLN7Ng51NfyQ/GomSPmO7UtWZZl2
         ghucLEKWN3V58AI7OmeE87DhbprvnMi1ZEEWc/EezbC2eLsACZtKo7Fx2/RzjGeW8mWa
         yP8qI2r65a3yMsUPmosoHZyVTspYaXf1HS0GXhrCjCcifSB2+rfdha+cvIpEqJSFVNSQ
         yCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698150808; x=1698755608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+d68ElJXb15txlNQvNv4dpc2clYVoBlH5oUxqTkrhg=;
        b=l49gFRnjU94fcV+6sUJbptILmI7CbbV+l1/HiJmoo2JBNwIZG2jm4LGS+z+v2LeSh2
         2NY9h6wD1UE8Yo+EIDF6dfwq80G5V5nxQOM2oVF05CtyERMrfPdePrkaN7XRnAOyO0Yg
         NVdDg0wGKacyxvWXd4UMkozGnNTNidkMqbGoEkY+HFHyc5YMTnFEcSbRAOWXjPXN+osK
         bdLxsk3DNfYnZPuYjqR2Hc7zYh4QDkgnWHqD8IYyPdFyG01S5vXdorAs1WirqDA1BKjL
         UdGyUddElfWfv3KwbkLYhvq6+VbBGkyPN2e0skciLUcwToePdWS5mzdoqhBEP2p+0XcQ
         PMxA==
X-Gm-Message-State: AOJu0YzDuPB1arEA+TqAedGOYaainOfSCL5F53B2H0gir6sw8+GJxy3h
        cUDhj+Z9Yqkc/RmDQmyJ4P4hLw5IeGMM34d0EyU+vg==
X-Google-Smtp-Source: AGHT+IFIE9BIMcYN4kQR4ERtaL5CfnISK2mhAZ8gLDndSgRZW3ZOJJxhy0/w+R7raxMOicROhqY26qlwaC+yMCMevAo=
X-Received: by 2002:a05:6402:430b:b0:53e:264d:be1f with SMTP id
 m11-20020a056402430b00b0053e264dbe1fmr13478212edc.2.1698150807522; Tue, 24
 Oct 2023 05:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231023104828.488041585@linuxfoundation.org>
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 24 Oct 2023 21:33:16 +0900
Message-ID: <CAKL4bV4D4VD=kQuocwjvZxjLd3h6xUCx4mKugDGhY8muxH1gNw@mail.gmail.com>
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

On Mon, Oct 23, 2023 at 8:20=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.60 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.60-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.60-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
