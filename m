Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809C879CE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjILK3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjILK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:28:04 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27AD198C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:27:26 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso92360251fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1694514445; x=1695119245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nAtcapW5A2eYCMdDal3WMSIZ7DcndsXa8JTxiNms/o=;
        b=W9X1AHRTeBsHuk1Cy7eoekhrVE1uIHogv+anFnFJ+mBgsdnU85E7DV0BKWGl/csI6P
         Ox8laaxHw7LIkP3dvgnuqLvtTkquhlgIWaLXQ2vlNykqXWewGObdzNclLoYm9GI3+Wsi
         /r3TTKMGg7uIBit+IrjdLZQ7a7xEznEnsu7QjhcExoeWKfHEr38MiGUCEMPb9kPtZjpy
         wokWMb/DjPym2zeWFWolA6BNPAFjKElGYI9D9NowsA7xt1xPWPEakz6vBGwwdnNBxxQM
         sVosGL4W7mNaHYGyrj/i9k30hOLX2+d0dTH5V18yagC9Ui8vVRFdiLX4LJXKcWN7A94C
         GQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694514445; x=1695119245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nAtcapW5A2eYCMdDal3WMSIZ7DcndsXa8JTxiNms/o=;
        b=IeDqSjD9Cu9zGxRn1JG1zF0R0xru1yVCLGzzKLXFbSkslvmBZ/XZHE4uB27SHUMvId
         1iRGMj39tXr0jcjHKW/TCFoXqXMGAITlaVj4+51ZyugrbyRlj0agApnDMfC+vcTKI5J3
         XdTNxslamME0fAaJBRKuqVR2cWlIoLJYZ5GNNrGGfnbL/lgxX/Lv5M7ApK0zkqhT8ZUb
         I8qIQwaEhu9BCAOY1uKvND6I4C/qyDtf8Gv8rAEMbCLiAGXK2e3/tbMXaR13XIbdktAT
         6gUaFQXh5YcYH4Koodfys1L2ifKObq2PY+5YXe2MAYae69HuWdJCEvK7xMavOCkDZRMv
         Ifyw==
X-Gm-Message-State: AOJu0YyH6zuGWtPlXWsNz5VVwTG5EP8g+SHmPrOb6bMsmA3ARfUmefjx
        iETK0A315+/4nkSCF1a+MzZ9Y/eJZOxXgH6Dczdq2w==
X-Google-Smtp-Source: AGHT+IHWgn+HnM07fBBSXLrHBH2jRmH2HvCWi8b0JAGpmFtkUyfgz0ePS0MBfuPCdDGkJXyz8ESfbJQnECbrn33c6Wo=
X-Received: by 2002:a2e:8957:0:b0:2bc:d7d6:258f with SMTP id
 b23-20020a2e8957000000b002bcd7d6258fmr11131770ljk.35.1694514444672; Tue, 12
 Sep 2023 03:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134633.619970489@linuxfoundation.org>
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 12 Sep 2023 19:27:13 +0900
Message-ID: <CAKL4bV6JJ5PXVuo=8+8LpdAn7saJN54AtZn_f-UxjH5q7kJ_fA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Tue, Sep 12, 2023 at 6:17=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.53 release.
> There are 600 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.53-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.53-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
