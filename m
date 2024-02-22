Return-Path: <linux-kernel+bounces-77440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53F486055C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8281F23D32
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A3131E32;
	Thu, 22 Feb 2024 22:05:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151F812D1F8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639500; cv=none; b=dqk0UD5f78ot+1TZKTfbF8L4kev+Pspjd/3TjwPbxp1Wk3DDzdH4oEHa/WZmAbfr9Rn+VH0bbx6MJvtOh3bm6b1AuuX0uUpgVO/I5/fMZ1yHywg42E2ARdlOi3K4al7u8y3qx4lDr4tQYgzavjWWlvGxhWiyqduexv1mRfCDtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639500; c=relaxed/simple;
	bh=O/mRqbeuZ0m6fnh8pUV4XaXyLG4XTXO44eGPiv61WZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Baj0DlpfJzSbZcw8SwjzYXeF2bYEdZH4EES89tWRWid9GwmZNdML6LSDKd/erBpm91rragMV25ZsskXpvqHg5R8HFM3N+oHb4HwJdl4sF4dQmUTuMQ6eudTnbeX2nvo5zVvgbvAsq+eX/A2eq6X1t0TjEqFZyfcAx1+ptttSRyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4140DC433C7;
	Thu, 22 Feb 2024 22:04:58 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64/fp: Initialise all bits in vector control registers to known values
Date: Thu, 22 Feb 2024 22:04:55 +0000
Message-Id: <170863948635.1616990.11657354558055243881.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213-arm64-fp-init-vec-cr-v1-0-7e7c2d584f26@kernel.org>
References: <20240213-arm64-fp-init-vec-cr-v1-0-7e7c2d584f26@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 15:32:44 +0000, Mark Brown wrote:
> We currently do read/modify/write sequences whenever we update fields in
> ZCR_EL1 and SMCR_EL1 so fields we are not explicitly handling will not
> be initialised to known values, fix this.  The EL2 registers are already
> fully configured.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/2] arm64/sve: Ensure that all fields in ZCR_EL1 are set to known values
      https://git.kernel.org/arm64/c/2f0090549b64
[2/2] arm64/sme: Ensure that all fields in SMCR_EL1 are set to known values
      https://git.kernel.org/arm64/c/93576e349887

-- 
Catalin


