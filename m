Return-Path: <linux-kernel+bounces-161337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6353C8B4ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E93B2123D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C8258118;
	Sun, 28 Apr 2024 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiNvf6gd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6990257339
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714294773; cv=none; b=GkyNx9IKBYnwyAsmXinbloCFPub3p3q0pqbSU24PaAbYjKwUEKomnwDjzlw4BUPHnt3VGs912rBnitnji0tfkXWq9dryBXYzUgT0AW8+b9q7vbOaEmR3s1nEzfZgqbB8tauJvggcwt6W8t2rmMQulO2VuMq8leL+UUtzOKPYoZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714294773; c=relaxed/simple;
	bh=3RPBJnEa8F9ju/oZNf/uVJ98wZNleuMeT/hp6KLEqdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RM13+oUg2EU5jOFw2eOooMuiGgB9R6YVvuf7rPhdFgyoRePW3k45uywTlJqzFq6xckNCbN9lEdqHHVRovTW0WqDJtTTePJZUC3BndGA6ONmAnVUn1qLHim4LyRM6k3VgGb5T2CGfqcRZ1PQar+CqA+2v7A/02KhlNPqxfPs+i/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiNvf6gd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95406C4AF1B;
	Sun, 28 Apr 2024 08:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714294772;
	bh=3RPBJnEa8F9ju/oZNf/uVJ98wZNleuMeT/hp6KLEqdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HiNvf6gdS3rJ5xQ4dxCpeZ76MTCK3Bq1YgXCylQ5E6WXXyv3C8y4Im7tvrz0fvDwK
	 3GT79HNlMdXQMXmyqwP8S/M/M2E3D0BeVfUXtVGtZqZS29+UeXClPpwMr9EZ1Gh41e
	 meoPcRUelOSOxA44D5KtjEpl/BDQnolGMvnYmGcOa9we49Ehu2qsAmHYoZGRX6eHvM
	 QTMJVMlxeHB0e4E69KtskV6y0NzQV8znEvEIzRf4OA6JQ7XN6bY7FonD5P7O1aUWRq
	 MSdnbRyNwifJ/t8sUaZHr5KsQLXdBLmG+jgOLiVMpNYjvTfBZuZOQc/AsFSGYbHbQl
	 3QWlWmQS2DJTQ==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	shuah@kernel.org,
	xieming <xieming@kylinos.cn>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/arm64: Remove unused parameters in abi test
Date: Sun, 28 Apr 2024 09:59:17 +0100
Message-Id: <171428922245.1714704.824188321990470965.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240422015730.89805-1-xieming@kylinos.cn>
References: <20240422015730.89805-1-xieming@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 22 Apr 2024 09:57:30 +0800, xieming wrote:
> Remove unused parameter i in tpidr2.c main function.
> 
> 

Applied to arm64 (for-next/selftests), thanks!

[1/1] kselftest/arm64: Remove unused parameters in abi test
      https://git.kernel.org/arm64/c/b7fab1b69b9c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

