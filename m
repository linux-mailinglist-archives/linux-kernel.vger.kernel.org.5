Return-Path: <linux-kernel+bounces-152990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846578AC72E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C571C21787
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C5535DB;
	Mon, 22 Apr 2024 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E4aZsJok"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048BD535B8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774897; cv=none; b=iqznu63fCyMn+34M+QsRlICJFiuXKIagw1xSdVDxQR67VdHwcQT1mWEPrnKcMRc8AHoIAgrjnIqbpals0TXyiVrEKA8mKSHUhKl4kzbTjYjqcMJJwkAPzlUIT6S2GOycQ3N4G9K5QF1HWj1hNq/FnpWE7PqQIs4RB2/mLJnPYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774897; c=relaxed/simple;
	bh=F3cTKTmerVbQ6uoJlKX+yppvxNK3d2MPp9LlpPWAt6I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jda2Pl/DKSq0LzJ8OKPjjYAjNkxjhrJwWiuLjJDk5ko8LQhLnR1vWA4iMPIPHnWlHyJxCHjiox7iLIwWM9ezD9/yaoJ04efj6oelAguu6DPukKkjKjb/ZSllEc6kfHUu1rkMpOb3HnqonTUObz8Xr3dj1jqYisvdWAuzpjwjwzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E4aZsJok; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4dac112e192so1186025e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713774894; x=1714379694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cNMmD9gbVJ9AGa/GKEJtK6907l6CLFIHUYACTDbu5tQ=;
        b=E4aZsJokfWk3A06qFm1W6xLh0wTn/+HuDcseZrUcLrlKD5cxud21nrO4LZIVDz4DQG
         u6vFZLfMpqEzG/C7oygouZeoMTKehhSEDcZEQ3FcpP+U12VTYprkD3vohWkN0tPaQLHD
         miiWYc5W3aAKuwNKiz7AQJrkz6aAwy9zv4B1BihAjq+zi9Sxumz5N7SUZC5ZHEz/1lCk
         8qSbPoErWWLtTRRaIoQ4ktlWu8wwFE8BZeM1hOrqE0XNBqNNRWnnljcf90w9JIVYngQ3
         7gZvdL1UGhvywxSN6MnK5+JvJuQ71zmX/uXHghJbpgbN5b949tGHhbLVJzPgDtqGGqNy
         IoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713774894; x=1714379694;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNMmD9gbVJ9AGa/GKEJtK6907l6CLFIHUYACTDbu5tQ=;
        b=LcSS6jvTZ3kkMFExTco0lXGU/oUh1/xKeTVf5qsDCEoV7IRdayEvIkWuK+IvCAHzeJ
         2B/uGCSxtfdUp23pbqx+9O/Q6V/CMHn18ElzzgMnw45g+3rVTeg7vQgwkLSz/e+zE2bK
         OFcfB7U9a8mCtF9X1EOzNuTD8vBbAHnaEXHpZHbaV9AAmPL7iOX4v6ek9kL/Ws1wuN9U
         bAQLcC8wGal1wxSoOwYXFrm5w1fqnSH6nl8ik217lXbBGYRc0Xjr/aIuIPNnA4yng3dn
         nVdo7wMezPKTJBM8d1TeLg6rkVezu4ghlXh6vBBO6ySSonnt9FO6yKi+vA9HdKg3cHsK
         nLeA==
X-Gm-Message-State: AOJu0Yw5WdN68wUAE+hJiua5P6Zi79nT00kDGxRpnuOr6gnoQa9z71QD
	5y2g4jLP1Lm2WB+f23cjS57TyIKCWNc4hpoKmks2BoF5KmQ/HWKajuKiXvBNyqN++XJFqXDZpnZ
	k/ZZrj5jnZ742ZAovwg78GTrGAzkUoz9Rje9YoCJS7JK2N4aHGGw=
X-Google-Smtp-Source: AGHT+IFGeTMhcnuzzh3TJqCna/pGicA0/DNk1zHO73mrweIwQNlKA/d49QB4S8rUgtCLEik6kgAcN8aB/1iN4sciE58=
X-Received: by 2002:a05:6122:7c8:b0:4c9:98f8:83db with SMTP id
 l8-20020a05612207c800b004c998f883dbmr10346379vkr.5.1713774894545; Mon, 22 Apr
 2024 01:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 22 Apr 2024 14:04:43 +0530
Message-ID: <CA+G9fYsCL5j-9JzqNH5X03kikL=O+BaCQQ8Ao3ADQvxDuZvqcg@mail.gmail.com>
Subject: gcc-8: arm64/kvm/pauth.: Error: unknown architectural extension `pauth'
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Marc Zyngier <maz@kernel.org>, joey.gouly@arm.com, Oliver Upton <oliver.upton@linux.dev>
Content-Type: text/plain; charset="UTF-8"

The arm64 defconfig build failed with gcc-8 and passed with gcc-13.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---
/tmp/ccSUNNZy.s: Assembler messages:
/tmp/ccSUNNZy.s:3159: Error: unknown architectural extension `pauth'
make[5]: *** [scripts/Makefile.build:244: arch/arm64/kvm/pauth.o] Error 1

Steps to reproduce:
---
# tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
--kconfig defconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240422/testrun/23551634/suite/build/test/gcc-8-defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240422/testrun/23551634/suite/build/test/gcc-8-defconfig/log
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fRe0ZWWmise7cetIz0aXdnq4jJ/

--
Linaro LKFT
https://lkft.linaro.org

