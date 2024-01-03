Return-Path: <linux-kernel+bounces-15935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E848235DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E20D1C2417A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B70E1CF92;
	Wed,  3 Jan 2024 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DWEQg2N7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162BF1CF8A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso108557345e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 11:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704311293; x=1704916093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zs7YK65vsgCJhyJ8cxRJlQYt/xebK4dr15ogDzD3qOs=;
        b=DWEQg2N7MSlgwVSHy/TPqQbxpXN5QjacuZkCClS6ACC9SnmEb+n2uTNR/ryPtvp+nT
         wfLkECn4cYzLqXw2I5ynOVvEebVRXYw+tuqDJCgohXkTXYnJxiQUKFSttuMBfi/WqvQx
         odGxMXx3DfONkP22bpgdsVSRRnciXOKJ2d7EMEWspbrH/lbKRWvMJBlKWxzMLMCPwcCk
         WIdjI980BgBsvqoxUKwJqm5gsCV9ItLwDRwutoPBjvl2STHkRJzgzzpaGCb06xjtBajJ
         uM9Rs7VREcxcw7JdhUX8DXVhLndwe/Jje97ndxAb8yd840rBOkdFe8Mor4rU6P+Vq5xj
         Uh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704311293; x=1704916093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs7YK65vsgCJhyJ8cxRJlQYt/xebK4dr15ogDzD3qOs=;
        b=cX6ukPNsXcHepo6rDiRyuRkH3IuGQWRz0jgFNsGayf7Bt4q9y9nEeJwR2gCn1GGkY2
         BCPMWr5yL9cEp8Gso+DJ9dKQswkFQulXLv0D7Jc272LICIJ0XJH/OW43Uwm00s9nYZTY
         KMzDLKdrPamqUQPw45x2T7cPt3FCePjTEp7lXijz+PHuvEacT+zg4wNehRNCiqbFco6z
         YdVPrulWvIfSY264nlnecP+GCPnCXNiUszuveTTAHWCX95rsxnKf/WGZuf4wuM1fzIxA
         qlCdcTJuftAf7aPRsPTJrGOoCtWe6+t7i/z6qI4fJWOwXfwCl39a85Fkjv9iL8HeiApe
         Q+xA==
X-Gm-Message-State: AOJu0Yy7kJmFv85BQi72vIAvysJVD/qLoCQcoY8akQrqGX2aLUTKmMsE
	N+6FnZ7+NCYz27vdJp+Zalzaff5Csr8WEA==
X-Google-Smtp-Source: AGHT+IGPKgforDJAQaqV1A5QN2T0jJs2gRNZTWT+QgU4y55oKFqLDC2gqwiPp88YH4GAEVXueke8qg==
X-Received: by 2002:a05:600c:2296:b0:40d:71f3:1597 with SMTP id 22-20020a05600c229600b0040d71f31597mr4615711wmf.172.1704311293257;
        Wed, 03 Jan 2024 11:48:13 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id je2-20020a05600c1f8200b0040d5a9d6b68sm3284877wmb.6.2024.01.03.11.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:48:12 -0800 (PST)
Date: Wed, 3 Jan 2024 20:48:12 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: guoren@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, 
	panqinglin2020@iscas.ac.cn, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	leobras@redhat.com, peterz@infradead.org, keescook@chromium.org, 
	wuwei2016@iscas.ac.cn, xiaoguang.xing@sophgo.com, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, uwu@icenowy.me, jszhang@kernel.org, wefu@redhat.com, 
	atishp@atishpatra.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 1/3] riscv: Add Zicbop instruction definitions &
 cpufeature
Message-ID: <20240103-4f92e1f7290975300ecc64ce@orel>
References: <20231231082955.16516-1-guoren@kernel.org>
 <20231231082955.16516-2-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231082955.16516-2-guoren@kernel.org>

On Sun, Dec 31, 2023 at 03:29:51AM -0500, guoren@kernel.org wrote:
...
> +#define CBO_PREFETCH_I(base, offset)				\
> +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(0),		\
> +	       SIMM12(offset), RS1(base))
> +
> +#define CBO_PREFETCH_R(base, offset)				\
> +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(1),		\
> +	       SIMM12(offset), RS1(base))
> +
> +#define CBO_PREFETCH_W(base, offset)				\
> +	INSN_S(OPCODE_OP_IMM, FUNC3(6), __RS2(3),		\
> +	       SIMM12(offset), RS1(base))

These should just be named

 PREFETCH_I
 PREFETCH_R
 PREFETCH_W

without the CBO_ prefix. The other CMO instructions we've added have the
CBO_ prefix because their actual instruction names are e.g. cbo.zero,
but the prefix instructions are not named that way.

Thanks,
drew

