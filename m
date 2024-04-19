Return-Path: <linux-kernel+bounces-151453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5738AAF26
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA1D1C21D38
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D5A126F1C;
	Fri, 19 Apr 2024 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOOR7Skj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6535285943;
	Fri, 19 Apr 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532631; cv=none; b=jq60fRX98p2bjVC+EzAfV7dHrNWaKN1HidibO5eNzrU/+kWYQqYoehrZ1rtKuckJegk9ugHKfqgnxuUOPSvelz1gDf/5KoiDCyVI1SCTqII/TKo3MLJDwue/gw7kcw//Q+LXlXU30IlpQrwYNgSM7W2jeHBa+nVxuGXRoDdicAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532631; c=relaxed/simple;
	bh=q3Ld7/E1tOSJKL03LUDe50RI70K98mAIFlIeQZcAIxQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OOY0vN6nvPmHuCR6LOreUcqqRXBfWQq6MLDOCsY2tjakGjH4HN/jvsq44lkHulzt89LjXQWChSW2U1glgJh2zrBvTrH52o1IL0NBpr06XuL/u8M7H9OIzgz/+0EBh0WsVsH0UAZHB70BxVTy1ESxyTX4FXQiH9pXGqt+/Xt1skU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOOR7Skj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2844C072AA;
	Fri, 19 Apr 2024 13:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713532630;
	bh=q3Ld7/E1tOSJKL03LUDe50RI70K98mAIFlIeQZcAIxQ=;
	h=From:Date:Subject:To:Cc:From;
	b=aOOR7SkjZs7coth8N50xa8QFKzYI3vIAhay9s4GX938CcgYqm4tP15WOgrD3+rBSd
	 sPva3J3eJlTOP7m8M2gVLDI6W74WysEy3/DtRebECdn9Nkb1pSVb2SC+zd8Jl1fmm4
	 Wbf4F5YuH1HjjnOJ+qgpb5qgwCLRUMi2RTpwo/FvSKGpXvj5uWyAzi+KNrOcn8hOyo
	 qxtW9FtqiZfk5u+w5fgrcdIoVU3BoFwe8GAaYD0sxD6sEfBNtzpL63rqVHC+P1DOni
	 GAc6TJzmk49l7rgw4k4nXpzekn8X+savfOwqU5+fdX6ABvtObebO9OW10SHmWYol+Z
	 U/G8HErrI4TTQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5aa16bf49f6so5589eaf.1;
        Fri, 19 Apr 2024 06:17:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWXwRZiqEpGO5jbrY7ofMMHomEeIPGmuVRRGIewVojdE/3rMcn+hPfOuxOkjhqLNMHKyBkG2gLl8PhLznOcltLytLHVzrY3i6UAlEC
X-Gm-Message-State: AOJu0YyEcS1SNEqZo3j2akCq7cFggKFBhDiB5hCMLL5HOCpmty1yCus9
	6Eh/t6pZw7XLUeuzCSUudium4Sr2fD687OsZOjXAqP2K462cdXyRknGx++TpiqRQKLNMD9STclM
	R7OsA7Pi1ZCUvpwCxxh4EfaFzF28=
X-Google-Smtp-Source: AGHT+IGPi7e6PPCsLGG25C+aWuyc+R6ey298wW4f/LoEJz4aSpU5gYPUVG76RxPZKXLKt77NeauJ98Lno+gXgRVBhoo=
X-Received: by 2002:a05:6820:e07:b0:5aa:14ff:4128 with SMTP id
 el7-20020a0568200e0700b005aa14ff4128mr2137063oob.1.1713532630203; Fri, 19 Apr
 2024 06:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Apr 2024 15:16:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hqseoeH6t0xKNOC-NMAXz5dWxTA5DKqGdxn_AghRKP1Q@mail.gmail.com>
Message-ID: <CAJZ5v0hqseoeH6t0xKNOC-NMAXz5dWxTA5DKqGdxn_AghRKP1Q@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v6.9-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.9-rc5

with top-most commit b552f63cd43735048bbe9bfbb7a9dcfce166fbdd

 thermal/debugfs: Add missing count increment to thermal_debug_tz_trip_up()

on top of commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680

 Linux 6.9-rc4

to receive a thermal control fix for 6.9-rc5.

This prevents the thermal debug code from attempting to divide by zero
and corrects trip point statistics (Rafael Wysocki).

Thanks!


---------------

Rafael J. Wysocki (1):
      thermal/debugfs: Add missing count increment to thermal_debug_tz_trip_up()

---------------

 drivers/thermal/thermal_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

