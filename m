Return-Path: <linux-kernel+bounces-120053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5434988D0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACFA8B24930
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B38B13FD73;
	Tue, 26 Mar 2024 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTmHKClI"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8613DDAC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492213; cv=none; b=sY+74aRKcoldQkqmmpxSY3JQjcYDvOksn+a5d87TPrHFUxJs8vKvY6VEB922dIHUKAldX6qSpMVkUc9NJm+IphEyaO5f12VPblwIISHqpH6mjBxtG1ekGt1rDhLcq546RYZj6rz2do0SOv0sr5hbqInPp0gRTpZuBt5Xu27SR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492213; c=relaxed/simple;
	bh=w8Czqi2K8AT/tstKpsl1KE3WkzNI7atVD4WaXXsX2aU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ptFvEgaNdRy6swWy+UpvNDOKVelQ43XhNie0hRVBDix+YUxq/qxE42mCAkHHnx7eWMh/ApCO2ql7EAtF/nh3jymax4UNKlGbhF5TjorMNpC7hYC7pDqWEu818ejK6eRsJYm1EUKlc9qc/8t+TwDKihWj/TfHaAWuub+EKLH/Cek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTmHKClI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ecb04e018so4278907f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711492210; x=1712097010; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=79Q4JSiG520z9H9GgKa1sOqwXXSclwi98WKQxVVkT0M=;
        b=JTmHKClIKmTH/Gc0YI5B0VZfPin3ttzbdShwh+e9/pS1AZdf3cQPJrCBRypDEHiAip
         wiPNqrMae9B3D+TxmaYrov0FjRPujWA1K1j3CwzPJseiDp8+nPrepguUCfcymxsQJtP9
         w1IP2YFkcx9OVEV+iJBkU94OQUyAjCwnGqFl2ssCW1+YmylwRNJ6Io+3xxzw2ZElFonO
         rHykHMktb3MY/aQne0BsKQ6QgqvmNe2APHsmm2Jr7esuSig6+bJJtuFyLnzAxka6gYvw
         lnWQFhXRDa3Eeqn84IMwe7HlDrE/FtIRwqKqBByZHHv21KE1ssqzbKbeQg1Yk+rHSKlM
         jZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492210; x=1712097010;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79Q4JSiG520z9H9GgKa1sOqwXXSclwi98WKQxVVkT0M=;
        b=Queis9UbtHEqibe6hnMVHVCd4tJQdOfXzxXSuVSgmAZxbKPzP1NWWiSRsd3KK1TlYW
         E55y9r1FRF232HJU2lpkymG63MKQtFM/u1+0YzD2kvs/Qv9ZbNG7e214KvcxkihYsfYT
         f96GysuqzqPbHHbOufj/9cT3mikB4PmCLhIhx2LzxagLqCKsgrmWaNQ/+4hEKMGSrdX3
         0wqN/dQJmzWAKLHV6Y9/J2CoHLa3qoAZ15jqljsYGbgqBOLz+Jurm+FUyg5CdkuhrfLy
         U5y6xg1NLLije881fZk5ZFSHa9C0zUMcX865gjywKVQ3e5TDnrtc8HI0Io0CgRCTOhdZ
         5Kzw==
X-Forwarded-Encrypted: i=1; AJvYcCXk2C///uAQFe23Fg+Q04AM1rZIIfPkKVRxUhKnrTsK1gDiUPs0FMo9OgiizMWSQG9iWJLqUggoZUDYFaSyrgsHPctCFh1lxSTsQldh
X-Gm-Message-State: AOJu0YzUYnKGnpt9zNZ3CzMYdMx6p7ItatUMabB3oHpTjRqGpYtNHK29
	GMX+vv2AUy+325qaF99qM4JDIByCvaNioYQpAqjPLx3uMnBV1oWSkH6xW7u6g0RAxpLC
X-Google-Smtp-Source: AGHT+IH0zSgzCJUjVH92vO/QU4aWl7q+QMkDuJzT8hNDUaeajUA4XPo0MJSogLhPYHSfb6174eXpOg==
X-Received: by 2002:a05:6000:5:b0:33e:c389:69ff with SMTP id h5-20020a056000000500b0033ec38969ffmr502235wrx.68.1711492209958;
        Tue, 26 Mar 2024 15:30:09 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b00341bdd87fcasm11049415wrq.103.2024.03.26.15.30.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:30:09 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Zong Li <zong.li@sifive.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH 0/2] ftrace fixes
In-Reply-To: <20240326203017.310422-1-alexghiti@rivosinc.com>
References: <20240326203017.310422-1-alexghiti@rivosinc.com>
Date: Tue, 26 Mar 2024 22:30:07 +0000
Message-ID: <mb61psf0cvd74.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> Both were reported recently as there are efforts ongoing to
> reimplement ftrace on riscv and both are independent of this rework,
> so here they are.
>
> Alexandre Ghiti (2):
>   riscv: Fix warning by declaring arch_cpu_idle() as noinstr
>   riscv: Disable preemption when using patch_map()
>

Thanks for this.

Acked-by: Puranjay Mohan <puranjay12@gmail.com>

for both patches.

Puranjay

