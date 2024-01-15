Return-Path: <linux-kernel+bounces-25814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2A882D637
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DA61C21573
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98055F4E3;
	Mon, 15 Jan 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0I81QZm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28ADDDD6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705311713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+Jk1nbj3uW6migT2Vqo+VfpLTraUaZDdhQVwMiE/20=;
	b=c0I81QZmwUhWfcKFSfi9cd1bJlhXMyA/f0LeJTkKtOGnJzkd9rmxtzqecCKbvuCPZaVQ47
	TAKg4ZcgebSDwtK8Y1MqEqqa3Ze2ZJN92NhqHCjCz3t4sF/Gx5/NwBxcFLX+gdH2i4V28L
	BoUnFKxHjHiPrnsS5Up4j82RCLKU+Fk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-nrcTZ4UcNuyIsOZ_j6BWeQ-1; Mon, 15 Jan 2024 04:41:51 -0500
X-MC-Unique: nrcTZ4UcNuyIsOZ_j6BWeQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-681476b6bb3so34475466d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705311709; x=1705916509;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+Jk1nbj3uW6migT2Vqo+VfpLTraUaZDdhQVwMiE/20=;
        b=RBtVpZzLDo9s23f872iWLfvZjaLrFbw+7BSb/DySaKNFm0Aqo2+KOP0IYGG7EagA46
         eXolA8Y7/B8Zw6aysaI8qxMyGcTTl7/ivQ6ifmykXFvLxEN77fwV89hTezk7muS/QQ3m
         RzKmY6Y4us6k9vIW/106reCioz0C+5wZxS9863LTREnY1VZpRZPsEeQGGHa/TbDkFVJg
         YhzFZopOAiio+KD8LA/2l7AoJXoQ8eTbp0O8td9GC6R+dv20+28+jZy3YKHBzD3AyNUe
         Sn1qm5jwyorlnVbgYatqCszxPWe9JtA0Dd/lDCP0s/uOr1IXfNbOQR4l373701FPcRvo
         wFNQ==
X-Gm-Message-State: AOJu0YzBiIMS28eVVMCLjNHrnfGa4Tjc9XR+6V1zjbuPIoj35RApAby/
	zCAHgwOIDEh0ggpPumSUWyKm7Hjgl0PKcO+/zZZB8Dl99CPrf1SZE303KjBhFCHS4rpNrtr/DOp
	GtX0WMgmPUFZQ4wRk9r37kTSOLyHwiXHW7C5wdjPYPS9UcJKF9zW0tTIgoq4SltDU/wNfkDo2LL
	+oMwCYbu0+LcjNZVBY
X-Received: by 2002:ad4:5ba9:0:b0:681:656f:4990 with SMTP id 9-20020ad45ba9000000b00681656f4990mr301112qvq.4.1705311709641;
        Mon, 15 Jan 2024 01:41:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAOOoM1Bm+v8qEYAvYKrGoQCl6CNZBl4IdAdptOpUkzfuoO62Z5TqjIUAbKxWrq0EP1glzaQ==
X-Received: by 2002:ad4:5ba9:0:b0:681:656f:4990 with SMTP id 9-20020ad45ba9000000b00681656f4990mr301089qvq.4.1705311709206;
        Mon, 15 Jan 2024 01:41:49 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id x19-20020ad44593000000b0067f678747ffsm3189342qvu.50.2024.01.15.01.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 01:41:48 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>, linux-riscv@lists.infradead.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, Yong-Xuan Wang
 <yongxuan.wang@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Marc Zyngier <maz@kernel.org>, Anup Patel <apatel@ventanamicro.com>, Atish
 Patra <atishp@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>,
 Samuel Holland <samuel.holland@sifive.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] RISC-V: add IPI tracepoints
In-Reply-To: <20240115071246.32675-1-yongxuan.wang@sifive.com>
References: <20240115071246.32675-1-yongxuan.wang@sifive.com>
Date: Mon, 15 Jan 2024 10:41:44 +0100
Message-ID: <xhsmhh6jfhr1j.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/01/24 07:12, Yong-Xuan Wang wrote:
> The strings used to list IPIs in /proc/interrupts are reused for tracing
> purposes. Also slightly clean up the code by removing send_ipi_single().
>

So this is adding trace events for sending & receiving IPIs.

Regarding reception, AFAICT arm/arm64 had that historically because IPIs
were handled directly by the irqchip (see rambling on the first part of the
cover letter at [1]), but now that this is no longer the case they are
obsolete: they show up in trace_irq_handler* events.

I don't know riscv IRQ handling, but riscv_ipi_set_virq_range() looks
awfully similar to arm64's set_smp_ipi_range() and does a "proper"
request_percpu_irq() for handle_IPI(). So if one wants a trace footprint of
IPI reception, there already is infrastructure for it.

Regarding sending IPIs, there now is trace_ipi_send_cpu{mask} which is in
the core kernel and thus benefits all architectures, though it
only covers IPI_RESCHEDULE, IPI_CALL_FUNC and IPI_IRQ_WORK.

Long story short, I know the ipi_raise and ipi_{entry_exit} TPs already
exist and we can't remove them, but IMO they're not that helpful because
they just give a string rather than an actual function pointer, *and* they
have to be manually added to the right place in each architecture. I'd
rather see trace_ipi_send_cpu{mask} extended to cover the missing cases.

[1]: https://lore.kernel.org/lkml/20230307143558.294354-1-vschneid@redhat.com/


