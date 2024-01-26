Return-Path: <linux-kernel+bounces-40490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C765583E193
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C811C218B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35F01EEEB;
	Fri, 26 Jan 2024 18:31:06 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2AF210F0;
	Fri, 26 Jan 2024 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293866; cv=none; b=AAKhTTlJfumQy30YB4wa1gZ3qkEv5y7TSsy8GH2AGToKq+6ofCSh/uuS3LyPtFiL8aEkT7gvlCmTI4kgGyewlqR6IM8ebCeAHkgZv7jsPgqCYv597e1FtNIHJB+zq2ZoGapZWhM8cQZr+FpIfCGuRVVuxdvJ1/h/DKMjuWmrMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293866; c=relaxed/simple;
	bh=ZhSEfHuznS26ympI5OU2fq0Cuf5U8W/L1VhfhnE40wk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MbQET/2jKAVT2XvLn3zjUed22j2el3wJUE2bL4T67WMxKwufHG+zyqQEq21QKyGPLLSPqKIzlPaWsjY5B5SNWZsMVIIBJdT7STsKHcDdg3e/d/RFffgh4wuN4Ihd5AyiS8m4j4vuDq4wCNnzaqkO0Zk9sVU1ndQ4uimYBlAxsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e10ce693b6so178875a34.0;
        Fri, 26 Jan 2024 10:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293864; x=1706898664;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xe2RIiMOWacUU6vJ61NqzqRq1k1AoFwmcf1USPH8WnU=;
        b=mZZS8Zwy4UoASWDuElJoMnoj9AE664eIFtvYQRV/7KB+WYkCm1mtvBzid1xrIXVhCl
         cbr3dblltli5grCKXqHbHVWqZYkCMk+sAQdx4VjA0xAPcfBLa7XgWTOWpIKF8Dy7Arlp
         4d+bHDXs7jgADEdFiB0aMquzbDixK9c065KVxK5UAZRO2+bjTfK6qAyDLt37YKMbyJe2
         GhULlJc6baXMTvrE+O3X0s4tEdI8UjDNElRD9GxEsZbjqZpj14OM2e8/H2Jj34r/Tasu
         Or5jucN+700Q1p96cuucdl4ozsSnTy/Y93o+hp8KfZaoKA27Xt3GgmeiRrfj8kU8Uxeu
         cBXA==
X-Gm-Message-State: AOJu0YyKIjOOu0wZCigfQWqX7hs5V3yosASZf5jS4rFWDYoLHIXsMuhz
	NXa6FKo4NQNJO9RnX/wbWf5SMCEvbSOO+0+YgNgNQzSh088i1F41QnhwWC6MG60h42dvreOlb3r
	tsK0kYpgHqCHV+WBEbRx7yfH+IXzSlkEFLWw=
X-Google-Smtp-Source: AGHT+IF8ZAmHSgGI1AtGk2IDQ6XCCjmDo/AT4Jrspt+7v6V83d+oB7OCInUPVzb+Njey2SVFGcTvSfSm3xSaQzG+DYw=
X-Received: by 2002:a05:6870:f10c:b0:204:208c:aa68 with SMTP id
 k12-20020a056870f10c00b00204208caa68mr207725oac.2.1706293864021; Fri, 26 Jan
 2024 10:31:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Jan 2024 19:30:52 +0100
Message-ID: <CAJZ5v0hCuQuyctY9NUXJ8-NGR2PfVmY1y=Ajd936Mh9LnjNg+w@mail.gmail.com>
Subject: [GIT PULL] Thermal control update for v6.8-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.8-rc2

with top-most commit c6a783be82c893c6f124a5853bef2edeaf26dadf

 thermal: intel: powerclamp: Remove dead code for target mwait value

on top of commit 6613476e225e090cc9aad49be7fa504e290dd33d

 Linux 6.8-rc1

to receive a thermal control update for 6.8-rc2.

This removes some dead code from the Intel powerclamp thermal control
driver (Srinivas Pandruvada).

Thanks!


---------------

Srinivas Pandruvada (1):
      thermal: intel: powerclamp: Remove dead code for target mwait value

---------------

 drivers/thermal/intel/intel_powerclamp.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

