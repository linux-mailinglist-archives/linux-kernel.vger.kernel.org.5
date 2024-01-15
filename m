Return-Path: <linux-kernel+bounces-26186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9018D82DC7C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2941F223C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5140179AC;
	Mon, 15 Jan 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cnxNsymE"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3217980
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28fb463a28so949230966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705333270; x=1705938070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlNB6mfBhuOkYDOMIlb5FsjRSMpn/oKooeekeL6PaCc=;
        b=cnxNsymEqSFSbfBwC2dPSBbKzkEcqz7C6OKczQe6hJNpiNeDyjEX2vWVJJ3+Vjt/z7
         fYIqL4VJ6aobNq2R0NDlNrkxTnC4ASYGI1plAlDA4/2opSzs6a9F1BWK7PJ0DItoPVqX
         caXzRjZL2eg7zm5HpKhXvyLrcrat60IkG4B+bN0NXPfDq6uZWmpEeRuq8+9oHJoCezOD
         1uBCxwhSztUBOnECZW/tzDTlLp8z0Q/CcdGSpLhp/j6wS1+K5DUBkxUfqd7R3DF6CE8c
         A1B2ALTVl2gWJUnOCXJp1KFhAWmcVZzqv9imldTpCyBk5ClDjGEAYmoeqnqB/DqPNbk/
         NAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705333270; x=1705938070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlNB6mfBhuOkYDOMIlb5FsjRSMpn/oKooeekeL6PaCc=;
        b=TSBR7BnPog6q8FkdKCnA8zWXm448AhTP7bqLybuODkMmmKSTFVIf3BFu3KkawG3GrX
         U2XNnmiAnQbMeMBkXpFVQmX9vZLrET2LetVqIDjNm1NFg+SPa6/s7Qhg5HesNSK1wqxU
         lm5rv73LFavBn+s0VrmKCcu9cgtJ53umhrN1DVdIGR2H253bxUeNez6NV+Ux4Ba9c2xY
         iaFcdj7T25BEknZDdYJQ/9PgG+Qxouh8zqIXB6dMf2+zW59P3lJXDgZHuRd8mD84wEwR
         tf6FQfc7AveE3yxJ96Ko8S9PFI/Zj9SVhn6DM+AfnAVbvOzL4GalKgfGJJFKZFXzHvpI
         Prkw==
X-Gm-Message-State: AOJu0YzgPkUr+e3U1Q6EQpF/9PRvffrb+kpJyvInaMsXZZH568F3zspo
	lTbY3xQCNb35HdKzKzezsYQOjUNvQ55ZPw==
X-Google-Smtp-Source: AGHT+IGJ3Az+J+dIMt/KyGU5dufzzqP+n2WM/Bmp9nTCWuqxDlEIM+uy4FwEYLMi7yjInSoJX7ayBQ==
X-Received: by 2002:a17:906:6713:b0:a28:ce97:353d with SMTP id a19-20020a170906671300b00a28ce97353dmr2505542ejp.59.1705333269910;
        Mon, 15 Jan 2024 07:41:09 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id wk18-20020a170907055200b00a2808ee8ab1sm5405411ejb.150.2024.01.15.07.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:41:09 -0800 (PST)
Date: Mon, 15 Jan 2024 16:41:08 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 06/15] RISC-V: KVM: Allow vector crypto extensions for
 Guest/VM
Message-ID: <20240115-99866622cb962823aa8a4d47@orel>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
 <20231128145357.413321-7-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128145357.413321-7-apatel@ventanamicro.com>

On Tue, Nov 28, 2023 at 08:23:48PM +0530, Anup Patel wrote:
> We extend the KVM ISA extension ONE_REG interface to allow KVM
> user space to detect and enable vector crypto extensions for
> Guest/VM. This includes extensions Zvbb, Zvbc, Zvkb, Zvkg,
> Zvkned, Zvknha, Zvknhb, Zvksed, Zvksh, and Zvkt.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 10 ++++++++++
>  arch/riscv/kvm/vcpu_onereg.c      | 20 ++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

