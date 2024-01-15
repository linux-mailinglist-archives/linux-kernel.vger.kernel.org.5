Return-Path: <linux-kernel+bounces-26187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0057C82DC81
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076391C21D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282BE17756;
	Mon, 15 Jan 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="in4w1tCh"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4D17BC0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2c67be31edso479417966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705333283; x=1705938083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IoPBd+9cqFRLXfeae6ug1abvNfzBQzrAtdxiFLBULy8=;
        b=in4w1tChfAKwkV+SbJJHCH7kBtKUxUL1R/zgajr+9q+bNP8HvT05ND7kP+cUAYWtVU
         fOlZqR+UsyIlHfk42uvTVHw5593d7qRrdE4sBo2BVAl8j2qj4cS957JEbOKzZS1ibibi
         qrnfB3rMUxdwVdcmNXD5g0jrGR4mA065/vnSkyo1H39KdjiQ9+k5oUJ7kWIODPzPLQtI
         K+SWVWXJwBeVnzfpPjKkmG6xcQoe9wLQOkwLIzFSCBVQdQg8zlPja9hpRaNNYqZ4MYKT
         ZNPdNtzMI5/HCEeCXZUMdZDnP0Zt6lWoGGtvncFKC36rGdln+O2qMjn2iKVacRFK3+6d
         KUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705333283; x=1705938083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoPBd+9cqFRLXfeae6ug1abvNfzBQzrAtdxiFLBULy8=;
        b=bABNpPYTpqQjwZFdOP+3WtMzIUxtBfkdb4NJfeXdV9YOeDelwYKgdlmn/+yQPUsAwc
         +3I5LjFReW90jG/2VYnBTsh7TxblLEfNu1g5xqSBDdUgatlQEgmEGXkcIJfjCIip5RJg
         P1SRo91jiQ0XZgNhWrJ5VMd1eqkKU3A0obzBVZAf1lTvuL5r49b5ozYkQgBfLyhdMoHf
         +bgtosCYAymNklUeUziMwHddqdQ7KB/DkHJmwyi3zUns/zB0hdJooIGm+6a99gnmtsVa
         IDRkQOXwlCOEfAnZdUa0Gu4F0XaiMxjGIiXLhqyGrpMjjbVbMbizMHIsizEjNeK1mzA6
         3TuA==
X-Gm-Message-State: AOJu0YwMqbmIRBWLvYYQMzU0N0a2Qr7vKyc9N5+hVNyxNtwbgxtS89qz
	WzPB5PNSaGLZhZKCQlh6bZsJkBjemrtoMA==
X-Google-Smtp-Source: AGHT+IFKkPeCi7wmzN9qV4FM3v9RTTO3ePVJwXYR2KVsSk7g3fKbnojc19QbqZiEL00Tk7sLG0iIGA==
X-Received: by 2002:a17:907:20e3:b0:a2b:2615:25d1 with SMTP id rh3-20020a17090720e300b00a2b261525d1mr1367400ejb.90.1705333283455;
        Mon, 15 Jan 2024 07:41:23 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v24-20020a1709067d9800b00a2a4efe7d3dsm5425091ejo.79.2024.01.15.07.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:41:23 -0800 (PST)
Date: Mon, 15 Jan 2024 16:41:22 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 07/15] KVM: riscv: selftests: Add vector crypto
 extensions to get-reg-list test
Message-ID: <20240115-8ab964d5a932bc2c5d9da188@orel>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
 <20231128145357.413321-8-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128145357.413321-8-apatel@ventanamicro.com>

On Tue, Nov 28, 2023 at 08:23:49PM +0530, Anup Patel wrote:
> The KVM RISC-V allows vector crypto extensions for Guest/VM so let us
> add these extensions to get-reg-list test. This includes extensions
> Zvbb, Zvbc, Zvkb, Zvkg, Zvkned, Zvknha, Zvknhb, Zvksed, Zvksh, and Zvkt.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../selftests/kvm/riscv/get-reg-list.c        | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

