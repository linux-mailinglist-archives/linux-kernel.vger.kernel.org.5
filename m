Return-Path: <linux-kernel+bounces-45341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3103B842EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639AD1C23F16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA5A78B67;
	Tue, 30 Jan 2024 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSLXRogc"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83E78B53
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651064; cv=none; b=N/9aTz90K9xNS1K9H9Ilut5b5RuIzkR3ajEJ62XBIYorsmjq9eouwMsprNdTjhI6H1/Gmq1ETQ1Z/29szOEibaeuOic4Aw1cAb8w8v6TlcoDDZ+usOEVF24Qrn9p4eAi0grG7qyYApO2Aao1kWlcgpRR0exbKwPJ1JwFGnW1WpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651064; c=relaxed/simple;
	bh=hH0fFL1rhdDy1jDzPQJtyVIkSrdaojh+vGVUB+jM/s0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Idj4AIiD7YdbzmQSUzM+ecNM8qP4oqSQxa1+PQf9jvr0GCB81NuFouAEeeXkLCOxkjIKFy0HfWd8Eicc59VKEQzG9brAJSiuu0oODcTUNkq3yFp0pj5ayfSqpYQQFCpQhPdDPRroL+obz0wFigoaAmhQiAXVjiJNI7s0S5Xt6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jacobhxu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSLXRogc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jacobhxu.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso564673276.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706651061; x=1707255861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hH0fFL1rhdDy1jDzPQJtyVIkSrdaojh+vGVUB+jM/s0=;
        b=bSLXRogc8EAZctYYiKx8zhdePd7R5ZilI6UxmmhSlHp7rhL5j9vLxRZxyIilySGbIp
         8HC2MvwSb8S8FpoOV2fIQiK7x+0WOIrNh5IZf46rfYe0MQnoJQrw8Bi9uLJtF26XetSL
         MIA7bUBR0utSu8a0ummVksPRrJsdkBYnRSmQARdg23aGDBfUDP+mLCSKnSzqXA5i9JHM
         XCCrGjJJQRMx4H807f5arZsshCQXBpijl+OP7Hhd559MN3xA7h4YJUMMxGuxjO2pKb03
         j6/0JoGcRi3bkpVWxgjE3fyaQAIggM9Cvat3cCyLSjq6MUxzac+P9CgzqSt3Ft3nu/ly
         ky4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651061; x=1707255861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hH0fFL1rhdDy1jDzPQJtyVIkSrdaojh+vGVUB+jM/s0=;
        b=KwfefF9KjYsGc010Dy46wQkwsCJCMr1jQjbzCGq4v06ta9QQtmkLL+JNeopUWfbuKc
         4xi+s1z/W2BQFrpMwUIACwFaZlTUWM3dPl1M3wlr5iaYTxsUxt4eaRTpRIBD2Xh8tbc3
         c0NmUWR6xbueNEhZtnJniZNu4C0NLJUy+f9myH0bwLVCkO1D0rnjWOpjSoLMCoyg8kYg
         2l3W3NpOQ1am1gnC5vlm1OBrkRfq8AjWEUdEqNdqw+71EwHm3N6VXboSHLwlr6/dzxsO
         QOz95ymeBgexY9iGDB1g6sub8CXgr0oJVtlodhAo6o8PH9thwC9XCYqTMWF+1mQKTf/u
         wjyA==
X-Gm-Message-State: AOJu0Yw+3nT7Yl868/jmgK8ajQBRYDUELXBO0H0MGrg/KQmaOuowX41i
	G+VEdKhIvs5miTx3f4EMbHYSMwbj8CtlkYH9jZ051RbuIdWsc/dx/8kGNT1BcL09v1X5hofCawt
	Ws/wrLJay+Q==
X-Google-Smtp-Source: AGHT+IGh/xh5lCFQGHw6m7O7r8t0nyOFosPRdkS7E9/mG35x/7Ab+zup3wJppwa54bJiER+yWjU7ZHH2RM3LGg==
X-Received: from mhmmm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2ad9])
 (user=jacobhxu job=sendgmr) by 2002:a05:6902:248c:b0:dc6:af09:66fd with SMTP
 id ds12-20020a056902248c00b00dc6af0966fdmr31043ybb.1.1706651061652; Tue, 30
 Jan 2024 13:44:21 -0800 (PST)
Date: Tue, 30 Jan 2024 21:44:19 +0000
In-Reply-To: <20240130213354.863963-1-jacobhxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130213354.863963-1-jacobhxu@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240130214420.870856-1-jacobhxu@google.com>
Subject: Re: Reserved bits and commit x86/sev-es: Set x86_virt_bits to the
 correct value straight away, instead of a two-phase approach
From: Jacob Xu <jacobhxu@google.com>
To: jacobhxu@google.com
Cc: Thomas.Lendacky@amd.com, acdunlap@google.com, ashish.kalra@amd.com, 
	bp@alien8.de, felix-coreboot@felixheld.de, jeremy.compostella@intel.com, 
	kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, 
	michael.roth@amd.com, mingo@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Oops, I left out one of my questions (besides for the chime-in on fix).

What's the consequence of having this field un-adjusted? We noticed it's zero for milan but non-zero on Genoa.

Jacob

