Return-Path: <linux-kernel+bounces-59254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FB284F3E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22AE2890FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053BE2577C;
	Fri,  9 Feb 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9XyB3S1"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05832E85E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476145; cv=none; b=eVTRQkmDYuCHdEdYErKkttpXk5ARisQiX3xLd8vw5DURBOqvg4UwNlM6FRhQhvH4cpcNKeAAAIM6wMp44mpdWkDaTODQwaJtdBuaPk97MlZVDH2wG5Rfe9ZlTJ6xmKNQNlCJVPRpsF0VcfP2KSJh/m0N/+l3Av4BTZ584d4wxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476145; c=relaxed/simple;
	bh=o+/IioxPnfla+dglQmYWkPg9m2XjN6K4vBJSsfMOeaE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kbNNOVAaoCjEdLpxE4mpNMk/++/stLUi5ElKXcAk3t9y9LTWPxHVJHloKUlMVJZw6axu51rF2EPIDr73LLM51gk7egAvlCa0H4gjwTost+6yP787QeWK8fE+MumYKHWlblTWmjmVar4SirkNBXhRiRK0JnCVT4eMNNjD7/pT2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9XyB3S1; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4c01c53efe5so293545e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707476142; x=1708080942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/jhuyoBsFKzxtpnWlhnmTfZzhM8BWCrRSLCg0dJcXB8=;
        b=Z9XyB3S1xW8Rx/PXHKKLcBph+ns0hKGZne3wQOsLZwXHEaGH/o9loUfWOLzebtXhQ1
         esW1PtpOfTiSmCKBE3yg6o8bBmQ4fgffADfKunFaL6t9kD/65RgfqC4iylLqkcSBG9NM
         R//gpnN/aq2ymSb6cdHoRX9QRN7lpsucYIr9dIMSSdGQlRKABwWA+E7E8Yvwy+bB5AFm
         pTapE5JjjDk4TdQQJo+Q+tEnMvooJC3NgZzZbHXsS+/sY5KYCh9UqRGEFk1JKWWgpdzT
         FzjhXvfwPyHnlydT7q0cZJypv49fy0oSKzfTucxN2+VWTdM+qTv37SXROUDocvbmbtdi
         7W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476142; x=1708080942;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jhuyoBsFKzxtpnWlhnmTfZzhM8BWCrRSLCg0dJcXB8=;
        b=O5iYmxx0ahwcdawXu3DxfzIUxRjzlfasdLvcwfIvJeVhbyHb+Tkq94lxbj6WBweBnu
         +YoScCVlkrQ4WOryUpJ1W9hgiu4eNrGnF/Vq2jd/eyynBUPK+gJoBy2xnARhxQADcBhl
         Ft1+5Z2ul7FssYRArUVlZ89wuZ1oaZmbTCCzvArIj71WaVvcp54V9PAlxPqC4OqT71vk
         u6pRqc7cPPtM8CIAvH6t5tkIPRVNgb5A38q3XLctk78QtsTwJOIfXmFizrhRFAKGTrbo
         PGEThMiSceQ5vE8cU57l8LHOEwVz3+VdfpJk5X7adKxAlN1Yk1homYD+8SSoxv6pdCHO
         /kkA==
X-Gm-Message-State: AOJu0Yx+qt+3sByw8kVmdairwZCiC0bwFCEwRbehDN0GjDVZmO3TaP6f
	fsI5E6BnACuR+svn9en9jxAgAC62zwsO/7BKhEWLgLa2sjIScqUGYx7m9LYvywADrjp8BtPZ8o2
	sVpL2ymFMIJwMxkrB5KRKzJ+ziGCY3hkxse6BaTpefK7HJMv6lxg=
X-Google-Smtp-Source: AGHT+IGOvIWPUUibYBmld0tkqSUyoDYLjUuvcBaVP4a9ufjBsQCQ9MzKEEAWhiQM0P67jY13SdRYbhmNlFMGNMybc7c=
X-Received: by 2002:a1f:6683:0:b0:4c0:fda:7d8c with SMTP id
 a125-20020a1f6683000000b004c00fda7d8cmr1380013vkc.2.1707476142203; Fri, 09
 Feb 2024 02:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 9 Feb 2024 16:25:31 +0530
Message-ID: <CA+G9fYvGO5q4o_Td_kyQgYieXWKw6ktMa-Q0sBu6S-0y3w2aEQ@mail.gmail.com>
Subject: selftests: net: ip_local_port_range.c:152:17: error: use of
 undeclared identifier 'IPPROTO_MPTCP'
To: open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Mat Martineau <martineau@kernel.org>, 
	Maxim Galaganov <max@internet.ru>, Matthieu Baerts <matttbe@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

I encountered the following build errors while compiling the selftests net
test cases on Linux next-20240208 tag with clang toolchain.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

selftests/net/ip_local_port_range
ip_local_port_range.c:152:17: error: use of undeclared identifier
'IPPROTO_MPTCP'
  152 |         .so_protocol    = IPPROTO_MPTCP,
      |                           ^
ip_local_port_range.c:176:17: error: use of undeclared identifier
'IPPROTO_MPTCP'
  176 |         .so_protocol    = IPPROTO_MPTCP,
      |                           ^
2 errors generated.

Build link,
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2c4LtUoRSYhdGbErOY8hqHxc6Tu/

--
Linaro LKFT
https://lkft.linaro.org

