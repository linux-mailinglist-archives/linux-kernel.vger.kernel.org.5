Return-Path: <linux-kernel+bounces-101533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5897287A85E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2281C212FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7779D48CDC;
	Wed, 13 Mar 2024 13:27:57 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF94778B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336477; cv=none; b=Vo7y3UU4IB8yfpMFUXZBh9cTyQcnZKVYmF/IMJMZQPR6QQwRnC5BgIss/W9aJX3bCaVO4JtH9JWKguUoy+/ku1w14jbc6x/nUhc5tzbwPQuyTlUZkVC3LQE61QngF5t05EwL/jmZerGfcK4fmAnsDnsgEguQE7J5jXLH1amzKyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336477; c=relaxed/simple;
	bh=6ZZnkc+pcsEo8OnCa6PHUa8Hf0CPZ0ItUMbb+TH3L80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LLFux2AZVOeOtInXZEbyTuiMvRye2wKv76S8cgK+NsRhcIa2QYWsELhXG66hXPdrgxr0bvBg5VHqGStEGlmwRIGBevF96OZ7tcHOpsBviS/k4MEfWxqFusAMq7ZZqCGtHi6Op7qVqQnc33UhgfN8dIoVMgLwa+PWUFnAFpc7whs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvrt10VGxz4wxv;
	Thu, 14 Mar 2024 00:27:53 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, christophe.leroy@csgroup.eu, Qiheng Lin <linqiheng@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221208133449.16284-1-linqiheng@huawei.com>
References: <20221208133449.16284-1-linqiheng@huawei.com>
Subject: Re: [PATCH] powerpc/pseries: Fix potential memleak in papr_get_attr()
Message-Id: <171033598340.517247.11139891507654380344.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 08 Dec 2022 21:34:49 +0800, Qiheng Lin wrote:
> `buf` is allocated in papr_get_attr(), and krealloc() of `buf`
> could fail. We need to free the original `buf` in the case of failure.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/pseries: Fix potential memleak in papr_get_attr()
      https://git.kernel.org/powerpc/c/cda9c0d556283e2d4adaa9960b2dc19b16156bae

cheers

