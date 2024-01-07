Return-Path: <linux-kernel+bounces-18975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7128265E1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514091C20A37
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8769E111BD;
	Sun,  7 Jan 2024 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ks87T+Fn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438A5111A2
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5f0629e67f4so9614207b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 12:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704658172; x=1705262972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8nPAFCVrC9CMoZifbVgJ5oM9DI/tQqOkvpJC/laO9g=;
        b=ks87T+Fn4XBvcggEVC+6W2s8IjGoe7r3ktcVrDrdznQ025WX0j6GGgVfHWMC6k8Dtm
         BSw5wBN3AQiEjc1rf1JvhUcMLUaKXyfkRNZrIA9871qXTxclsDB5F6xUphG953xt1YYO
         c6YuXFDGTYCGl9K5C+TQ77gBHlz8p8rKrbRNgazcp/WMfhmNIytnlTbjJH50Gao8gmIn
         T/o4Uhn+rhqQQkvh60o7vihHJJqHgxVQM7LSjrzR0WvvmgBmn7TR6fvn6OGI5HRyGwqd
         0cCmljqecJs+h4d/5hY8/WOMaMbqQP04/ZXEsH5tkaBZOZ4GjSYTiTR0yS+1SOS5u3Li
         QcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704658172; x=1705262972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8nPAFCVrC9CMoZifbVgJ5oM9DI/tQqOkvpJC/laO9g=;
        b=Q1EBgln1q1ysrtDnCwlmV+QKyxO3Zi/43o/HCRFFhIzp7UsaDRiEiWUw3wnU9Pvkn9
         AgnjNF2Ju1x45JRbeSqpW1cLRKrhFqiNNOMh3dGOx0o7abwsIwezcLSP6CG3SvF4vzXN
         IZhAOih0e1EXH1FyusNxCYTuAeKQSfogc1ADY+07ezEaKRW8CPF5rCC6VAhZ4EKUELjW
         g75XDn4R+L9L9SOIvCxPAtIDIM7nbNzW0uOufU3DyUrKAdhy9a8zqebWcchW/qCZCw2d
         RBNfMCHNPtz21xiE/lAyfgYKpyVn9dB71A48oAocXa86/eR2vlGLnSttX8csGaj7yUSD
         uwVA==
X-Gm-Message-State: AOJu0Ywsoj9irgkYCXdIGVraAU7l3jUuAw3U5Sh+bhosCMQsrOiIpmrG
	BoV0rWRKXE1VKLo/B8o+TgDXzXPYJYH3Sh4e8641Q+tYRvzUutaoHadX3WwO
X-Google-Smtp-Source: AGHT+IGry4XVFEl601f1I74BMHsJP4cbqCd0Ab5u8jISrZR00fsRvt+8hHK1amJ3NRebygDsQhpUtFxqb6C64MDG74s=
X-Received: by 2002:a0d:dfc5:0:b0:5f1:a1f2:f3bd with SMTP id
 i188-20020a0ddfc5000000b005f1a1f2f3bdmr1632919ywe.28.1704658172121; Sun, 07
 Jan 2024 12:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401061736.yM5FZ2oV-lkp@intel.com>
In-Reply-To: <202401061736.yM5FZ2oV-lkp@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 7 Jan 2024 21:09:21 +0100
Message-ID: <CACRpkdbx=qgdy1JRyxzFGW+8Ojj+g2tLKU4dD8oWX9V0xH2-JQ@mail.gmail.com>
Subject: Re: arch/alpha/include/asm/core_t2.h:587:23: warning: no previous
 prototype for 't2_ioread64'
To: kernel test robot <lkp@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi robot,

On Sat, Jan 6, 2024 at 10:40=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:


> Hi Arnd,
>
> FYI, the error/warning still remains.

FYI I have already said I can't reproduce this at all. Not using
allnoconfig, not using the .config attached to the report.

I have no idea what this is.

Yours,
Linus Walleij

