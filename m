Return-Path: <linux-kernel+bounces-155925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0518AF8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935CB1F234EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788E114388D;
	Tue, 23 Apr 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTSccHEC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0526288;
	Tue, 23 Apr 2024 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908010; cv=none; b=Jx/Vkm7T8ALK2Jx7RQL5goQiHVG34Uq3+6GVN5WyI9mV6POwriHl/a2PpUwd4z1QrZQE+PXn+EJDJ1W/RSu/iDehGVDdp3xzP6ld/PGLYRrk/cU3pC+GkgvnmIVsvhBiSHP5TD1pJ802FDSc/5lfQtzeDBhPHuRaQwRG3kfRhpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908010; c=relaxed/simple;
	bh=ihT2Z5BjzFijWtjLQcXTrbIwcrnOFeEuAJr+ofHU/ec=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VsuXrE4TwRuaQ6zrn2LKxwPAMd7/A8Fjj9AXCn/ZooTio0JuaJestKk7hnk2qMV/ZswBFEqyjgDnRI/Ry44GeRM1AZG9Qhsjj7+fryz/E/mvzmL6gF0B7sN0TC4lroVOLMXIhOKwC/kxBW5KJhi5AyZEE7Z2oYwFOFYQcrEHNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTSccHEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAC8C116B1;
	Tue, 23 Apr 2024 21:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713908010;
	bh=ihT2Z5BjzFijWtjLQcXTrbIwcrnOFeEuAJr+ofHU/ec=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=bTSccHEC1A4UXr/YAFMFNlsu4aXrJfYmL7QRHev+gBu+yRgviFgVQbZK+aftcJ4X0
	 VqIC6crlr2I4PmqPkFw2421v0XtEc0eJBWjAaF3LcszzrmrKqoGn/nXIrfENIvMfgo
	 h0gYuFi+ve8/ny0m5VnZCEAxVmxNAJjXFG+Ioj0ex/RaR3DIgCpCMn9HEj0oRLTyPu
	 7HaFov1cv2vCS3fM1jdDHmxItHEgf44c9EHZCr3/wymBv4O9XwkbM3dpZ/0HAnwGVn
	 DIglWV+kHYLz/MaGkrrLOwHEcHJ0ScHlD3gsq1jd+IEe/T/WyiCifNPkzkrggv95a1
	 loKItKB3KrWpA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Apr 2024 00:33:27 +0300
Message-Id: <D0RTOKUKOP3M.15LBA63K3KVWP@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>,
 <linux-kernel@vger.kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH] char: tpm: Keep TPM_INF_IO_PORT define for HAS_IOPORT=n
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>, "Peter Huewe"
 <peterhuewe@gmx.de>
X-Mailer: aerc 0.17.0
References: <20240422123711.1739063-1-schnelle@linux.ibm.com>
In-Reply-To: <20240422123711.1739063-1-schnelle@linux.ibm.com>

On Mon Apr 22, 2024 at 3:37 PM EEST, Niklas Schnelle wrote:
> The recent change to handle HAS_IOPORT removed the TPM_INF_IO_PORT
> define for the HAS_IOPORT=3Dn case despite the define being used in
> sections of code not covered by the same ifdef check. This was missed
> because at the moment TCG_INFINEON indirectly depends on HAS_IOPORT via
> PNP which depends on ACPI || ISA. As TCG_INFINEON does in principle
> support MMIO only use add it for COMPILE_TEST to cover the HAS_IOPORT=3Dn
> case.
>
> Link: https://lore.kernel.org/lkml/9d9fa267-067e-421b-9a39-aa178b913298@a=
pp.fastmail.com/
> Fixes: dab56f80e7f9 ("char: tpm: handle HAS_IOPORT dependencies")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>


Thanks!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I applied it to my master but for some reason it is not yet reflected
to web ui:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/

But it is still applied and perhaps also visible when you seee this!

BR, Jarkko

