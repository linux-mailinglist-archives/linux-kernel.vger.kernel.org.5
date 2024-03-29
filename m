Return-Path: <linux-kernel+bounces-124344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FB5891604
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D91281731
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE188563C;
	Fri, 29 Mar 2024 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDk3CHEd"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F2B81ADE;
	Fri, 29 Mar 2024 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704502; cv=none; b=d53ILXd8Ijn1G2V9dCZqVH/LAa1fcxdtFe3yDXyrFBOq4/sHmcpYLmaPd2/JMcBFNGO8EcFXOAPjg74+n1K9FcRxtF/uatY+kil/nfk4rljtdiseX45EGyKGrZyJdJvz+E2zWFh7scXHEVn+cEyWiQXndGyUF5CeOLTLEMZNcmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704502; c=relaxed/simple;
	bh=FgbEWwixLhT7dYnqZHGKfknzb3PHUcM+sA8G6CiqAe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CNHNs+ilh1NcJcTNWbEo5sh9wiEBW0yHf6SX6Oi+zyfmcJe7+M6lMQtnEzKvGvTC2E4VuL9/HH0f0AoFxr7JIqy4dtjCBUgqzJs0prm3ZUv3KXHOifczwSMa7LdYsEugxsX7p6QQ2PErLe93KXKLhp0pa/ECVE518Rrj9IRJkhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDk3CHEd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4e38f941c6so28531066b.2;
        Fri, 29 Mar 2024 02:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711704498; x=1712309298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yYeY0H/o+D291JZuUItJ//uSQXIkkpkUjGt91aVkHI=;
        b=RDk3CHEdkEdcpqRbWjRbQe3VU8E0dopCmoojQyOMzbgazZAiuQeXQjgonB3z9mMTwH
         pmDi49/s9OUDxWhjWAlPPHS7d+zA5UNX12rm08vkXHVslmuJT66eCEQwWmz7IZBJGdmJ
         tuz+i433/25/MOmmc1Q7lN/nbH89NjC3gB+rwFGtRFWHkDkHnlwWHUFrKm+A62GPne6u
         Sqhg9A3kk9cO+LF/PbGK/wuaTcncieV1yWtbpioRQAMd2W/+VHYJjCcSERI8KHb/Uzz6
         UrNFEFZ4Fi03Pe43CXQtwxSrmaIBKzLx1MgHgs1WhHgqyH+l/IeqTb0RWdapTqX9lPNO
         jfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704498; x=1712309298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yYeY0H/o+D291JZuUItJ//uSQXIkkpkUjGt91aVkHI=;
        b=iHv/GajsIp/qysPqbF7kg8Y9B08TTA91WXIs0CZFZoCiWYSGDTrgnQvq7uo9zYH26B
         VbO3jNuP8CDCI5Lxm65MUhBApi92Dug+eKVSZxPO/Z8Sz3lO3+ELQsJPPtMKAbtv1wzl
         pFdT0ALN/JWlvOmVP7OpNyQRGMsM/STEg1+m/njj+xaPYrPHt0akEqRnMbnbiFbb1fq4
         cSJ4EzBy3HnPJrjoOnxj5jiw2KazvAQAfE52BgdUHx3pWNqL/jC+H0zsiFQCN2awl1ec
         qIzmHRTM77JfHCjv2oc/uDYcLw6yh7NWzvkZhWW8dBdbhyvXggYy4wxdVj2kp8Oofa6X
         90EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWir3iyG7uo3FQ3AFcQd+UsHzncFlSbeEQjspDepL5uZ+xySF7uI+6CCclF0ayC+eu0E3hnbdFmYmm1SL34USEuvWQhCVXhqkZH4TQd
X-Gm-Message-State: AOJu0YwmSbh/YANKI406miQp7DWYZs+REKBGSF3cqy9nG8Q4EVv1G8gr
	BtrLRRxJvL9TIcuqY4NzZI+FTpt+jh8hH9mJaX8Ib9DGoCTcPwoPtAft21vx4Lk=
X-Google-Smtp-Source: AGHT+IH5FqR+6o3rp17Vqc4ITZTMPFQ0E5+Y6+ypvKnsQqxkz00z32pYdvIQHp7/uf/yIVjogP/g/Q==
X-Received: by 2002:a17:907:868a:b0:a46:c11d:dd01 with SMTP id qa10-20020a170907868a00b00a46c11ddd01mr1486058ejc.50.1711704498085;
        Fri, 29 Mar 2024 02:28:18 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id jx24-20020a170906ca5800b00a47152e6d10sm1700975ejb.134.2024.03.29.02.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:28:17 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: bpf@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 0/2] x86/bpf: Fixes for the BPF JIT with retbleed=stuff
Date: Fri, 29 Mar 2024 10:25:06 +0100
Message-ID: <20240329092723.17435-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joan Bruguera Micó <joanbrugueram@gmail.com>

Fixes two issues that cause kernels panic when using the BPF JIT with
the call depth tracking / stuffing mitigation for Skylake processors
(`retbleed=stuff`). Both issues can be triggered by running simple
BPF programs (e.g. running the test suite should trigger both).

The first (resubmit) fixes a trivial issue related to calculating the
destination IP for call instructions with call depth tracking.

The second is related to using the correct IP for relocations, related
to the recently introduced %rip-relative addressing for PER_CPU_VAR.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>

Joan Bruguera Micó (2):
  x86/bpf: Fix IP after emitting call depth accounting
  x86/bpf: Fix IP for relocating call depth accounting

 arch/x86/include/asm/alternative.h |  4 ++--
 arch/x86/kernel/callthunks.c       |  4 ++--
 arch/x86/net/bpf_jit_comp.c        | 22 ++++++++++------------
 3 files changed, 14 insertions(+), 16 deletions(-)

-- 
2.44.0


