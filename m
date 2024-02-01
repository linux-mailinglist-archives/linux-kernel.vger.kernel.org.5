Return-Path: <linux-kernel+bounces-48909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54A584631A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7230728E09A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5661A3FB2E;
	Thu,  1 Feb 2024 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWcbKjK0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875853FB15;
	Thu,  1 Feb 2024 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825034; cv=none; b=kXDaIz/Xtg/E6GiuFMcb+D9JrJGbP3PgwWk++9hPFSAH8Z8eqSSJRsEbOGfLExkXAr+To+oCCUz7bMwJ73kc58OMVFQop4tJHvGsJA64k7kS7k1xI0VR5TbTo1UWtQDt2TzcozMY03PYBWYAdcuLs6PHLUSPZv2WU2XdbwBv7ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825034; c=relaxed/simple;
	bh=DyfFCo9ypbopk5SXJ0mM1Wja7KYemHh8D4kOapDKtP4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kKbtyzFeJsdQ9yczH3tzAqVBTPiCg1Z2V86W2KnNY2NzoUUz7jc4Sgr2PlFT3QgGA1d153R6kDXLzf/pnS6k9+1eUUZmQtxarcE60/MfBLFqGy+p162aE6HXTxnZ0Oz/MCONZhALfRAA0/DPI5HdsWf6fteWgVbpPUpskwOuLZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWcbKjK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B581AC433C7;
	Thu,  1 Feb 2024 22:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706825034;
	bh=DyfFCo9ypbopk5SXJ0mM1Wja7KYemHh8D4kOapDKtP4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=HWcbKjK06tEL6KahLUGO5ozn9ZvtScnt7BO65NP1wK4PxQWrUq1rO3cbqAODtG6+S
	 9HwdMUVAoR3I4fCQlPqAZbOUilnxvgFviT7YRAOW57F95JDEGBat2qC98wmcSjllkI
	 BFg9iV9O+N9tib/YDRcbREyhyHH57mu17EK+dNB2Gsjwifx1D17gHKFVds/mO4HZVy
	 5EHLSn82Wexxd4mWnLOaJrdZDdwmkkmadJf8uHSyZ5nEh2XIj1l14mAUSbZJ7ikyY+
	 AZ39XeZAYQdfW9Kr4I0UHAvFqtZKuHbwTNk6xsxtESN7Ay2kl8IVhp6AaNE7haEh68
	 LAyfFgRoCOh4g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Feb 2024 00:03:49 +0200
Message-Id: <CYU2Z635C7SX.U9BMOKPM1G73@suppilovahvero>
Cc: "Kuppuswamy Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "Qinkun Bao"
 <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, "Xing, Cedric"
 <cedric.xing@intel.com>, "Dionna Amalie Glaze" <dionnaglaze@google.com>,
 <biao.lu@intel.com>, <linux-coco@lists.linux.dev>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/4] tsm: Runtime measurement register support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Samuel Ortiz" <sameo@rivosinc.com>, "Dan Williams"
 <dan.j.williams@intel.com>
X-Mailer: aerc 0.15.2
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <20240128212532.2754325-2-sameo@rivosinc.com>
In-Reply-To: <20240128212532.2754325-2-sameo@rivosinc.com>

On Sun Jan 28, 2024 at 11:25 PM EET, Samuel Ortiz wrote:
> Some confidential computing architecture (Intel TDX, ARM-CCA, RISC-V
> CoVE) provide the TVM (confidential computing guest) with a set of
> runtime measurement registers (RTMR). TVMs can extend those registers
> with their measurements at runtime, i.e. after the TVM initial
> measurements are finalized and the TVM actually runs.
>
> RTMRs are separated from the initial measurement registers set, and TSMs

"measurement registers" and you do not need to cross-check what the
heck RTMR was anyway.

BR, Jarkko

