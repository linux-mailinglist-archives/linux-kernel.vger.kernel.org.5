Return-Path: <linux-kernel+bounces-144032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31988A4113
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BB6282A17
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B1B219ED;
	Sun, 14 Apr 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Icd8wFQL"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E448210E7
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713081274; cv=none; b=jLthgWFZCXr6UcRkswqfxliNGlHOgHmGiuHD8V1lzli1e044AxxLi/VAFjbeIn2zKpUFL/KVERB6d9OG710NYXjTa3IOxCafkSR28Pq48B6VC7FzOu0sVVUxitDuBlKFYWh+1s1EAcnDGQTRYuvtCsMKGadMhUEcH0cYHKzuZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713081274; c=relaxed/simple;
	bh=QiCmaIA46YBttMr2zxE4z4EHqUMxri5GTMlnh1cuTMM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZvYKePkfTwjgR39jGlUOjAucB3grtkcRbqvijKaUfZG1kQzEMqdtN0Rle1qOl0Gg+ITy4uYaiiBfBPEMUYTCwUGAzIUdt1NP8ooFyT/h7yH0324yR+7DAa0c2lRDXWQSWTvmYMYy7GixWUSckBfMkALWzxb0pego5Mtc6ebXZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Icd8wFQL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5252e5aa01so94704966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713081271; x=1713686071; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RDmbXTK8tq3C1KB6gwxY1RuSZ+692LSqLFpWZZExa6I=;
        b=Icd8wFQLDgwaelxYYuhT63JbuwFCF0gmmj3w4VPG25sAlBibjAGJ9LmQAttErlQrq6
         lyOuIdXGE+JPTSoTl/xth85z1DQBU98IxaYNHmm1wWgdkWXThklHGpRUbftQvpY7evd8
         8LPogzTA8JtuOEQULbsg0yeB4ZwYbDlVopv9+AsOb0/oATYnR880UWG+A2HALdUSpwSn
         HrmiBRPayr/jEkTispCgdutISuZUK+JoMqtZp+3ZzGSqyyKRM+LjAoR5x3q4RyRHzwZZ
         sdAz28cvuRO/pa7DbQM70tPxW7kdjaKarpQfxYDG5u/xpw7aNuTBRMN3931KPav2c39G
         +g9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713081271; x=1713686071;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDmbXTK8tq3C1KB6gwxY1RuSZ+692LSqLFpWZZExa6I=;
        b=K3i4qPJpcPhGk47b6BHfjYaUZ/qVnuV4nDbpFFuu93UbwXy0GF58MlQQe14f8WnQ+O
         buoPZJlRqxWF2Bo1+7n+PHi2eSNClOygdvRbZ3Sgey+PKy7YTj4t/xHhslTjS2OLzISS
         oX0wKQdkEo5itO7GcjR2F0K6EoCeaR9v2iaL+WqQBCcBNUlzu8AmnxToRbVnyCcIRSTl
         nrTRcfKodnGfdwYXwMD2k+Z8l7PO7Tp/sRJqGMqdMh87aPVM1RHCvApM4CZyXDKjfetS
         iAUjar2JYcuTfHXrStjKMFRI0sTRUy2Kpp7q82tiPs7pTXWUDpx0pJbz2sSgR0Eq7kOW
         GSTg==
X-Gm-Message-State: AOJu0YyT0eD2Y1rB3KUiPucYi72coX8PwC5tLIIpFIOmu3qmA+Oq7iKn
	Mx0aXZP+8EQVzncd7aioUaXNj7CbJw/pnHRx5Or/6cQwQrQYb0H5
X-Google-Smtp-Source: AGHT+IGuKHD4XXJPfHNXCbGaJo/5r9IK+/BjzNEWkzowZbDgEcJYXb0Qb2n5rwCgoKqLSV3AEvWhoA==
X-Received: by 2002:a17:906:3c4d:b0:a52:28ba:2ce0 with SMTP id i13-20020a1709063c4d00b00a5228ba2ce0mr4035128ejg.29.1713081271197;
        Sun, 14 Apr 2024 00:54:31 -0700 (PDT)
Received: from gmail.com (2A00111001332BCD9129005EE765889E.mobile.pool.telekom.hu. [2a00:1110:133:2bcd:9129:5e:e765:889e])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090624ca00b00a46a2779475sm3889301ejb.101.2024.04.14.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 00:54:30 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 14 Apr 2024 09:54:27 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>
Subject: [GIT PULL] IRQ fix
Message-ID: <ZhuLsx9u+UYKpBZc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest irq/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-04-14

   # HEAD: 80e9963fb3b5509dfcabe9652d56bf4b35542055 irqchip/gic-v3-its: Fix VSYNC referencing an unmapped VPE on GIC v4.1

Fix a bug in the GIC irqchip driver.

 Thanks,

	Ingo

------------------>
Nianyao Tang (1):
      irqchip/gic-v3-its: Fix VSYNC referencing an unmapped VPE on GIC v4.1


 drivers/irqchip/irq-gic-v3-its.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

