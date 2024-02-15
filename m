Return-Path: <linux-kernel+bounces-66940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4634A8563D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D831F26FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6040E12F5BD;
	Thu, 15 Feb 2024 12:59:52 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24EA12F392
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001992; cv=none; b=d+FDqiPiAsuXejL41bRqmGION3DZ/V5At14edfRIPzkj8Mm5IvoOnQUCYvqNRaQz+q6Qy1EWTSle9hmHxySw2AMg6Aui5/DrVmPNHej6OxK2f4EZv7r2I/ScQ/067VazffXjpMDtueSArnAcckvQ0xBJ6Lb44+PViDR1hP3Pm/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001992; c=relaxed/simple;
	bh=ElM/cQWji1/DDHC+PMi+Ga8e53OuMa9b6/YuzGQQLsc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cxS6laqWP+/RuWaF9hNXvacJAAjQH4NJ3WXwjVneme6Z4PHbe6etwzUKkiUahtfQGtp5yILm5MDs1LnSmBfpkvaubkvKD1RRmFECp43bfbKjOAH9j67o6drY6D8nxMRtWcEGdGlxUHEbtbHA1lTVJVMipuLUVBH9xjAUrh+x6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TbFX33JVZz4wcr;
	Thu, 15 Feb 2024 23:59:47 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com
In-Reply-To: <20240124103838.43675-1-matthias.schiffer@ew.tq-group.com>
References: <20240124103838.43675-1-matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH v2] powerpc/6xx: set High BAT Enable flag on G2_LE cores
Message-Id: <170800185782.599237.17634953739221214432.b4-ty@ellerman.id.au>
Date: Thu, 15 Feb 2024 23:57:37 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 11:38:38 +0100, Matthias Schiffer wrote:
> MMU_FTR_USE_HIGH_BATS is set for G2_LE cores and derivatives like e300cX,
> but the high BATs need to be enabled in HID2 to work. Add register
> definitions and add the needed setup to __setup_cpu_603.
> 
> This fixes boot on CPUs like the MPC5200B with STRICT_KERNEL_RWX enabled
> on systems where the flag has not been set by the bootloader already.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/6xx: set High BAT Enable flag on G2_LE cores
      https://git.kernel.org/powerpc/c/a038a3ff8c6582404834852c043dadc73a5b68b4

cheers

