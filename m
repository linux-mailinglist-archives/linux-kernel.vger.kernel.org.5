Return-Path: <linux-kernel+bounces-26205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFCD82DCC2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B317C1C21BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CF1179B7;
	Mon, 15 Jan 2024 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SVSAnTSN"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BF1182AA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2bdc3a3c84so541686766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705334177; x=1705938977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GzIcEuaHWXnCzr/2sL8Vcv3dHdribnGFmFr1eaLd75A=;
        b=SVSAnTSNnvJB9AoX1CjyLEh1GcaGT2n3gYJVYuHN7mEaaXZ/HWhGfbiqhsplMWTKKO
         5HrOhJ9rLYeYmXnG7WwRZ4//E239jGifgkXELNgcBZ5jSg27wQoM6jhZmpG0yfrdat39
         oF4GvrT1aJiw7Jceh0auAasOlP9nmdWCZEqHUeBMcwKJdBojDVRvfGFUcziLVGUTBtg5
         2QJr4Dey/kcNF+S5n0FcjpOcmP4b+5UZMdgXDH2tFVtZ/gtpyO1ve6qx0pPCGW/UnNQh
         /tb40GggNQ5bgpPhLeKq12WAlR7XvICO7a4SZQl6fmvURAJwDn9qdRaSLdsUN+FZw8/a
         3tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334177; x=1705938977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzIcEuaHWXnCzr/2sL8Vcv3dHdribnGFmFr1eaLd75A=;
        b=N6kRYVul5e9sG47jLea278+UvOf2hLpkEm0UK/m5rRuY/bEtEvvok3y/ibQEZrt5HC
         wDoIQMOD3QiaNukkQeJ6pugmdSDNDGA4kkQTQotVTRChxJfA+owZEagiRG1JFtchSDmj
         Ehm7QvTXDqljSu92CL77B84WzS1cb1Nb+xavlvglZSdeOnd1QgiRSGX1KG53i5wldynj
         MGKCDZlvlUqNv+x3HDYUUShuHRzM7/UvpYcFPijMblRDB9GFNawRCFnKyz7aazRfUwOx
         hlYVnGF2nS7zRIA2YnnjsMVpMQ3tSUOHwo8fRdVyFgEX/te6sg3owxxH0KvorZ3BG3cO
         SYQw==
X-Gm-Message-State: AOJu0YykNU8x/38Pm7A819kIfKQ3Yt7CjKSxrQbFVMQY1bY8gJpNqIBe
	YDIRnn8uHL4SnzXQwIk7N0c0dlguh8MmrA==
X-Google-Smtp-Source: AGHT+IHy/Uamyk2YtYJ79+3ZC9ozJlXkNxEjS2ryGtVNOpdPIVCRT4L3/ylgzhP5km9hLu/sXJEJzg==
X-Received: by 2002:a17:906:c10c:b0:a26:cee8:3713 with SMTP id do12-20020a170906c10c00b00a26cee83713mr3113155ejc.55.1705334177541;
        Mon, 15 Jan 2024 07:56:17 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906c20e00b00a298e2f6b3csm5384397ejz.213.2024.01.15.07.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:56:17 -0800 (PST)
Date: Mon, 15 Jan 2024 16:56:16 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 11/15] KVM: riscv: selftests: Add Zihintntl extension to
 get-reg-list test
Message-ID: <20240115-6c4b2f1b0c692b6b8e609ab4@orel>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
 <20231128145357.413321-12-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128145357.413321-12-apatel@ventanamicro.com>

On Tue, Nov 28, 2023 at 08:23:53PM +0530, Anup Patel wrote:
> The KVM RISC-V allows Zihintntl extension for Guest/VM so let us
> add this extension to get-reg-list test.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
>  1 file changed, 4 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

