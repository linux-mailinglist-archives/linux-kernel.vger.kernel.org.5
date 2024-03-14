Return-Path: <linux-kernel+bounces-103372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E233D87BEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202881C20BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3101C6FE0A;
	Thu, 14 Mar 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiXDBHTz"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9CA6FE02;
	Thu, 14 Mar 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425771; cv=none; b=t4+o8/lB+o14O5d7kLv+tVHclPT1Qwe/TN//GAyMdIGXf4cQ8eUdgDQ/qYHB0PajBcd7opi41lPKTRxkW+6Cu1uN2lRcQrbkqG0GfkJ4qWwLKCs2QPK4K1v0TGTJlCSRWTND8QnMHYQl+s8aHDGIR2i2nBlkvHuHIGQewcM7kxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425771; c=relaxed/simple;
	bh=bVGU/1nT0H0Si6zm/Sz0XZCYeGIcHvVz6AxiepPYAXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VGTKsUUtOObEJTRL2ubJb35Y46MUcT2tEuIK64KdXB0fhGkyNpzxe5+Ck2XsbN5qp2lYU5WeTblIHbJhzLrEjIpfNH4agqLSi9Opb164y1RndE1vXflVOvhb4U3VV+aINgavzV/BUfKlYUjwGW5x+IEP0pOPmUSmlPMQv0YQUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiXDBHTz; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68f41af71ebso7812286d6.1;
        Thu, 14 Mar 2024 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710425769; x=1711030569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVGU/1nT0H0Si6zm/Sz0XZCYeGIcHvVz6AxiepPYAXg=;
        b=HiXDBHTzuwviFWvMBfXKXl/R5Uklrh4zWYXcF6Ie9rjblyrSTYDFnXKL6XZ6U6sxe7
         sBh5iMEubWBz2y/JP0iOZuJpAatn7G/W5QoSv8BpaCnarKssRV+wSxq37DZIuzaI8bi3
         YVenQird21t52bWnugumgFCiTNx9ygeMB7RjwOnsfuef8LWlyecRAKDaAnjy5BhHM9XJ
         iUGahEk+247jP9qydMz+jSdmJe5+Kb9wXFZdi4wJw26Xzb9O/n9QzTEXbvQam0JPDWCC
         QP4ibKT1U2OdHEht86l3Lc1Qz/qykMjyOsfa9Ai7dItSYEflx4RErvLUm8QA42ornb1Y
         OORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710425769; x=1711030569;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVGU/1nT0H0Si6zm/Sz0XZCYeGIcHvVz6AxiepPYAXg=;
        b=eIxLMwHxFduIFtTQ9YuXv+yUFLS7caH6rH4fuVeeO3QDiCMg1UV5s3rxxSv2Rubn+o
         okNLikKnSFPzqdagfHHjUFr3M2Bd75HQMmWwb4PJ0L1ATTDZ3/vbqzbkeoEinYLI12Si
         fcah1+cYfzU5DSXNao0ei36u01gSwMEEfHH1XO+YZKACRvchID/e+QDaQeEQYu0rJHj1
         W8aEZcJp34pnKBNdpUUj3vr8Qs+K3Q/6FbmP88germkOQNEPaSyI6JQvWp3AXP1raDuJ
         KWisg74SPXPVxN5dzXshyEqqX2U2F7OPPAnW5IL1AqUFedbWV16L4oxy9U9j5Rqh+Y62
         pAeg==
X-Forwarded-Encrypted: i=1; AJvYcCXCbB/JMJvhH4iFxpvBeERCfQmZ2nFDP9U5tS5mxHkBHLwpya1B6UT5fy9QZFC1Ul+XnyTpc80sKcTsHHfMnm12r/l3nldgPwVmSTGbRfsJ10ikizmEVFrfGLxWZzR8i4MD2nnuL+pKQ5OoEl3kFhLU
X-Gm-Message-State: AOJu0Yx4+QqaBkDrfwSjBlhrkY9emcX4Tb5ALnDw28xwqMkLB1PVuMOA
	ohCsHIHNl9D7kMR0ePfFJCc2RvFsqDbNQskgiq/TJFBNnwzREGMR
X-Google-Smtp-Source: AGHT+IFXeFnBQdQlRURMStTP2QEs5eBWxgcZpvwyfw1K7G6sqYNL0c+PpV2nyZYeVsGMmtLdDAXx1A==
X-Received: by 2002:a05:6214:2e11:b0:690:de5f:2127 with SMTP id mx17-20020a0562142e1100b00690de5f2127mr1939361qvb.36.1710425768813;
        Thu, 14 Mar 2024 07:16:08 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id jx5-20020a0562142b0500b0068f4520e42dsm507705qvb.16.2024.03.14.07.16.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2024 07:16:08 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt
 <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, Bjorn Topel <bjorn@rivosinc.com>, "Song
 Shuai" <suagrfillet@gmail.com>, Cl'ement L'eger <cleger@rivosinc.com>, "Al
 Viro" <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
In-Reply-To: <8734suqsth.fsf@all.your.base.are.belong.to.us>
References: <20240306165904.108141-1-puranjay12@gmail.com>
 <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
 <8734suqsth.fsf@all.your.base.are.belong.to.us>
Date: Thu, 14 Mar 2024 14:16:04 +0000
Message-ID: <mb61pplvw6grf.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

>
> Hmm, depending on RISC-V's CMODX path, the pro/cons CALL_OPS vs dynamic
> trampolines changes quite a bit.
>
> The more I look at the pains of patching two instruction ("split
> immediates"), the better "patch data" + one insn patching look.

I was looking at how dynamic trampolines would be implemented for RISC-V.

With CALL-OPS we need to patch the auipc+jalr at function entry only, the
ops pointer above the function can be patched atomically.

With a dynamic trampoline we need a auipc+jalr pair at function entry to ju=
mp
to the trampoline and then another auipc+jalr pair to jump from trampoline =
to
ops->func. When the ops->func is modified, we would need to update the
auipc+jalr at in the trampoline.

So, I am not sure how to move forward here, CALL-OPS or Dynamic trampolines?

Thanks,
Puranjay

