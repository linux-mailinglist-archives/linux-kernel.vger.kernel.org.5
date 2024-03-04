Return-Path: <linux-kernel+bounces-90193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6829186FBA4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989321C21BAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3F517586;
	Mon,  4 Mar 2024 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btDQsP2I"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E151D1754E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540457; cv=none; b=m8jSFdajyg+vFDBR8lKFxAc8R2o7zu4Qvucc/5LhmHi6D+cNq2xQOgW/oH8t/wz87Z4hQNGpRBgD8Py5I2YrGbLtE+pjSEHoWAjVq5M9GNJjGYknJTnp34C66Mz27OR0NkRpK0INWXi0YJCPZpsIWkLvLYjI5LZl+qxk1z9bIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540457; c=relaxed/simple;
	bh=h5skSJ29Rx6hMZ+bxWVfh2F6h/C4mmQL7SPqvYCARcU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AA9+cJ37AIHfCABl27TiOZHezYkEILq4XurMcSQ7N7c8+KKO6nMZjGASfxnGY+35B1xBt+RxB1+amzAfLFmkrIKrN04Z9ZxoLt7+zAJkomyaYGLMedESI953aZXJwWwfg5e6DyJlxG9FFUfOJH3kN57Y+uOeZux0fWj3RAkOh8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=btDQsP2I; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4d346e4242fso978466e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709540454; x=1710145254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yyEcn3m2A7yavQvE00TpjSl9UF2QJItgWnXnzeCS3YM=;
        b=btDQsP2IT56FcWf2WcP40xueffLSrtGE0oxbS3l0iP96DPZVY4rOlxLi7r+01vDos/
         D1ZzVTxKNMVXtQAUiXE1//XsZyERj6Xl0zb47/YwqYJIU3wa3CU+RjC34a8TKcbsMUtx
         5hasdMWTrQC1fS0R0ryyM/grqTfsUFOWLwdJ7MNykPBfZIdYU42RWbhQ4DLtw5OtDzrv
         eApK4+bqwML1Uc1fe7jrXpsQXCG0aDlfRJ2j7plFJtrJjs+Inksl9uc1UI02E1C2UB9n
         RkWR0CsSmnhG3wtsFdgekAKGMDsFgRuyepQknNOuKOc6q/dI7DTz15VAOIWme4tQpqn8
         c7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540454; x=1710145254;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyEcn3m2A7yavQvE00TpjSl9UF2QJItgWnXnzeCS3YM=;
        b=mijVkG/ihYYG6sTy1JDjxVZ4GnGbBA5tnsCDnYNNyYpYkpxtLLkjApdwOwBsE+wAOT
         xGRMXrwg5n89PIwGpht1Ky5KWwg1Azaf3KmMuM97xHAIyPwd1oSgXuo8IL1KSgZJySn9
         sIdd0xPeWXVM86qePm0Ob012vs7APKbTo1Tyn637hVl3EFW8ZsnVgCmCu1LGM4vP0yeP
         PPkaFbNG/RmDHrQ1pfqC9Mjza+9HTNFK9QGEI88cUF24zVsnjtz0RvGHJVUTP68wWNWG
         /QHGzVCPZ/W8KO+Jz9l/OWETNL2ZalLhyHsiYlsjoR0Dqz6ofVmEANPZ6VMCJskjnboA
         Oqxw==
X-Gm-Message-State: AOJu0YyuLWov8+pR+6qS/vzcj3//zDPW92Gjlig1J8GFo0APhmh3BMg9
	lJkoUwzSIBnFjVMRSTeIMtknW+Z2sdUd6EudJT8JeVc1o5h7nuw/tXLyzLBfi2SJsEBV3qj7QNe
	J80iHeZfwprgUclV299hNVksz+lKpovvNXUcqX3OuDm3XceCAyA8=
X-Google-Smtp-Source: AGHT+IHi5xUT6VReqMwudYvcimoxVjZtj0eGM2mqhV92LARqhWB+invYdIZQv1GlviuVLJkoncYGckQNqOnQq2cbuuE=
X-Received: by 2002:a05:6122:917:b0:4d3:4aad:a8c6 with SMTP id
 j23-20020a056122091700b004d34aada8c6mr5928625vka.0.1709540454609; Mon, 04 Mar
 2024 00:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 4 Mar 2024 13:50:43 +0530
Message-ID: <CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com>
Subject: fbdev/chipsfb.c:401:31: error: invalid use of undefined type 'struct backlight_device'
To: open list <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The powerpc ppc6xx_defconfig builds failed on today's Linux next tag
next-20240304.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
drivers/video/fbdev/chipsfb.c: In function 'chipsfb_pci_init':
drivers/video/fbdev/chipsfb.c:401:31: error: invalid use of undefined
type 'struct backlight_device'
  401 |                 pmac_backlight->props.power = FB_BLANK_UNBLANK;
      |                               ^~

Steps to reproduce:
 # tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
--kconfig ppc6xx_defconfig
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2dDE297yLFrAr3gigIDy8tIleDh/tuxmake_reproducer.sh

Links:
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240304/testrun/22919857/suite/build/test/gcc-13-ppc6xx_defconfig/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240304/testrun/22919857/suite/build/test/gcc-13-ppc6xx_defconfig/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240304/testrun/22919857/suite/build/test/gcc-13-ppc6xx_defconfig/history/


--
Linaro LKFT
https://lkft.linaro.org

