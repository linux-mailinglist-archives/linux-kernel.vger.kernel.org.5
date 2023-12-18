Return-Path: <linux-kernel+bounces-3923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118C181752A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BF5284168
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062133A1CB;
	Mon, 18 Dec 2023 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v9vHNZXG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C93789E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4669bf7d97fso114447137.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702913065; x=1703517865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=934EXAPlSskNDkwCLvhH4lxnOhTgFQ/8JULAzlCcBCM=;
        b=v9vHNZXGtv+KLjMs59BgnZwSpwdd+9MCK1d7rxd/H9Pwr9lP2/d0gJmVspe/yo/RFB
         bZnxUDZPVOBr+ea6jcO/GxPZ0MkQqUR3wuH0Q6qbym9KGKRvO/A8acpswhoDNCJ4PNvH
         IEhfet22ND0GjS0qempqvsk/B8fiwVkHumcjkkaQHW4xvCEdB98pVd21lIq8XH6it4Bs
         fxdh/LHq1SqMV3U9dQ71lazk0IsbGMH8JzlmuI3kNIAjIOmiJTZSHpXpAJDtucsMODa8
         rxYxelGN4zkQww37ziWrzs+dDA8PLwg836TGs0ZuGVdwItyQbtNKX/WWw5BF7jxzUI78
         VwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913065; x=1703517865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=934EXAPlSskNDkwCLvhH4lxnOhTgFQ/8JULAzlCcBCM=;
        b=iIyop7jADOxK03ijxwn7S2oclHAgteFCYbj7/eHPiLIfuMRPdl8sFeWBIsEjXiSX4S
         jYIR/j7SrxOKE1dF8kiQ7iabHrqRAv2TmZAtUPf9VnlGubJ/XOJcUpDGGwXULlfpaEOr
         Gu1cHgftcN05ud9V3RAgxERIV9bt0woFZFZohzShRdYhu0I0abLN5zeEgdlWSWqiLF1W
         srn5mOFdg2omHqHWi1CGYfkKYxgixBESx2eAhedK+Kxo56NQJPoBMQxcUW8lOk3BImiT
         /TneJYP6LskqdcoBL80M/MiYZtDbNcXsN4DMRQ5oFGBYoM0ANF+tiGZGYsmYDSdvWOAg
         A02w==
X-Gm-Message-State: AOJu0YzUP18MPrNLzM8u2rPvB7LvNzWu0SGBTRqSezRIKyhoOeaPD9uR
	tn9o0fFGyiDkDvGRmMbFlADmlT44NGJUAJUOZSrPQw==
X-Google-Smtp-Source: AGHT+IHev2d/CWWc956Aeqrlu90bQQ6d2AnDJV8RqGGjgwWCKecX1tOm530gj19HmtDth76G6ZDQvSyX8iVq97Nkoko=
X-Received: by 2002:a05:6102:508d:b0:466:98c7:9b9d with SMTP id
 bl13-20020a056102508d00b0046698c79b9dmr637242vsb.0.1702913065450; Mon, 18 Dec
 2023 07:24:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218135046.178317233@linuxfoundation.org>
In-Reply-To: <20231218135046.178317233@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 18 Dec 2023 20:54:13 +0530
Message-ID: <CA+G9fYszCtMbbrurrjqpDzSa20ZX5mVdQ+RZv-KdiyLU4o5=0Q@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/62] 5.10.205-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	Maxime Ripard <maxime@cerno.tech>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Dec 2023 at 19:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.205 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.205-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


commit that is causing build failure,
drm/atomic: Pass the full state to CRTC atomic begin and flush
[ Upstream commit f6ebe9f9c9233a6114eb922aba9a0c9ccc2d2e14 ]


Build log:
------------
drivers/gpu/drm/sun4i/sun4i_crtc.c: In function 'sun4i_crtc_atomic_begin':
drivers/gpu/drm/sun4i/sun4i_crtc.c:63:44: error: implicit declaration
of function 'drm_atomic_get_old_crtc_state'
[-Werror=implicit-function-declaration]
   63 |         struct drm_crtc_state *old_state =
drm_atomic_get_old_crtc_state(state,
      |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/sun4i/sun4i_crtc.c:63:44: warning: initialization of
'struct drm_crtc_state *' from 'int' makes pointer from integer
without a cast [-Wint-conversion]
cc1: some warnings being treated as errors

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

 Links:
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.204-60-g0b1eceef25bc/testrun/21731369/suite/build/test/gcc-12-lkftconfig-kunit/history/

lore links,
 - https://lore.kernel.org/stable/CA+G9fYupBYRYc5eAdHt6TH+xfoCRE31=FpDMS+-QY3b6rKPOQQ@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org

