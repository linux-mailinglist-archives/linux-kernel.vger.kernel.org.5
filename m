Return-Path: <linux-kernel+bounces-88920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4072786E864
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED99D287D11
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714FC26AFC;
	Fri,  1 Mar 2024 18:28:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9834C9C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317732; cv=none; b=opZrhj7r5NhcqcMZOfLE85oC+JwlcoLlJtvRdUPC7Wxt070l6sRjqsaTkVZ3+1To9gAECELsw+7+EOYsALkSebNxdHnAYBakIw1F+3ueUDIBQwafVpJKsE6l9SifkPalS0LSs8UyZOzouJBFYH7kzhz+bpG8HsbtUwxhihkx9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317732; c=relaxed/simple;
	bh=sqVQRbpAS/3s4rOgJ/Qh9FNwbGQYhih1M/bN0s3J8qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naPe2VENrKw82JhwIapAdZYayXAqAAMmC4LqRxNn/3VBi5rptIbyB+bHS4WQ7/VH4JfqD8/IqUAodOT93nDGXmA+yue129NZgc9oZ73VVDvTc6+5opwrtXOA/gjQEnUx/M7xFiBbxOwKgbO/Ej5Ph93cXfcMvNJnnhhp3iZMiAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1113FC433C7;
	Fri,  1 Mar 2024 18:28:49 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] arm64/hw_breakpoint: Directly use ESR_ELx_WNR for an watchpoint exception
Date: Fri,  1 Mar 2024 18:28:47 +0000
Message-Id: <170931771878.4170325.12050372302818451052.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229083431.356578-1-anshuman.khandual@arm.com>
References: <20240229083431.356578-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 14:04:31 +0530, Anshuman Khandual wrote:
> Let's use existing ISS encoding for an watchpoint exception i.e ESR_ELx_WNR
> This represents an instruction's either writing to or reading from a memory
> location during an watchpoint exception. While here this drops non-standard
> macro AARCH64_ESR_ACCESS_MASK.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/hw_breakpoint: Directly use ESR_ELx_WNR for an watchpoint exception
      https://git.kernel.org/arm64/c/9d6b6789c878

-- 
Catalin


