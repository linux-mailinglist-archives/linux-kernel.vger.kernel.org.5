Return-Path: <linux-kernel+bounces-152962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B867E8AC6C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46CA9B223AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1D954FAE;
	Mon, 22 Apr 2024 08:18:53 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461E5491F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773932; cv=none; b=bASoLS83KupeORQtCXCNN5qy6COWoB+L6qixjkGlPaYZDXWAO4AMrI5XJQzcYRxi6sZtaXwcNolUpb/iycMA0sxrQMm/+agJ7ettTET+nstQnZQ351/hYVywkOQx31VTRKHz47VeBDGFm7VdC+RndjhxKw6Hs/vPeYipFsYGEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773932; c=relaxed/simple;
	bh=gc7vvvMvakGpC+ThgH0O3n8f0SfI2ScfTXFog3lR5is=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HeYifeYxT9+pKpLEXH2GN1zHz4+BVcNylvf1D4MyZKCwev20xx5ym4hYlF3aYn7tHxHhJH+mMZ2f4ZCDrQzL99UUM/bGZVUS7ra2uO5hGCuT8QUs9aC1frI+pUdaa76MX2AQOFQX1d3twngdZBjoDZP2W0neutbDjHOIkhH2p2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNJ6x6pF1z4x2d;
	Mon, 22 Apr 2024 18:18:49 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Thorsten Blum <thorsten.blum@toblux.com>
Cc: Rob Herring <robh@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240331222249.107467-2-thorsten.blum@toblux.com>
References: <20240331222249.107467-2-thorsten.blum@toblux.com>
Subject: Re: [PATCH] powerpc: Use str_plural() to fix Coccinelle warning
Message-Id: <171377378352.1025456.8238193274214108693.b4-ty@ellerman.id.au>
Date: Mon, 22 Apr 2024 18:16:23 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 01 Apr 2024 00:22:50 +0200, Thorsten Blum wrote:
> Fixes the following Coccinelle/coccicheck warning reported by
> string_choices.cocci:
> 
> 	opportunity for str_plural(tpc)
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Use str_plural() to fix Coccinelle warning
      https://git.kernel.org/powerpc/c/3e42e72796d8991fecad78d61a180e24a4853427

cheers

