Return-Path: <linux-kernel+bounces-140798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9728F8A1903
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABF61C20357
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE13956B91;
	Thu, 11 Apr 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzW1cBI6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39756B65
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849559; cv=none; b=uck/rdhmroFZFUE+T87XpXNP4pGOOHGK6y3dmwVDZNvJrsde2qvK6Bcxe9I4eA9jlGMq7yZEi/LD5wV5LR2p0A1TOCkOBF3/LDRYsHIK6QCmfqo2+akxOhJlErSz8fX8WAorwlVIMEPwho1wzRkOzRstIKR020Kq8Ev/1nWMwGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849559; c=relaxed/simple;
	bh=38ZIwSl78e1M6TRfOuddRt5TKZo7xB/cbMv1H2Y3ygo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vCat+tlU7BJ6Xmz5Sq9A8xOfiRBjzBjUZBkutwZsfmqK85pNhOxKIZxyXcUg958GqBtRyuIii2PSw2GpKSYyWKpZ2xH9q1ookwYGy7M1aVEe0MHYtC4KjBE08oj7ckgUFEcOSQKxVgBIGfJq4C9mq6UZjCckcJ/krryABnTt1Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzW1cBI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9058C072AA;
	Thu, 11 Apr 2024 15:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712849558;
	bh=38ZIwSl78e1M6TRfOuddRt5TKZo7xB/cbMv1H2Y3ygo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZzW1cBI6p2CLl/YOU9qOcUFCfDaZB9GbmYoAD9RmGDYdbGHNUE8iLn4YFXFBfT0zd
	 DYBSXE3FtG7pz/NCQ6HFxUDnkPz5Wg2+giymeC7GXzOF0FHci/ptSvnabJ6KoW6ugK
	 H0ScFwpZZYDm7sLMpUn2HKEpHK7QC8aKH5G6l0X7ONdrD36XFs0+MOvPnNk5uQ/yX+
	 VbhjIv8Lb31/8DjOXnGVdXsxFznfRbljQ2bgT3lmm37gSLmT73zgjGoL4ekydw5a1r
	 ghg7xHhr8+G112lXXpXcuS6yzMhAngfpoeZGuNeZPOxldnL6BDYxbWXJgE9RIRPxwd
	 q6CF7yx20s2eQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Jean Delvare <jdelvare@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20240407112445.503bcbc6@endymion.delvare>
References: <20240407112445.503bcbc6@endymion.delvare>
Subject: Re: (subset) [PATCH] mfd: Tidy Kconfig dependencies
Message-Id: <171284955747.2452070.5244744964514321007.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 16:32:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Sun, 07 Apr 2024 11:24:45 +0200, Jean Delvare wrote:
> Drop unneeded parentheses for clarity and consistency.
> 
> 

Applied, thanks!

[1/1] mfd: Tidy Kconfig dependencies
      commit: 74df506226990245f01cdedfaff06566c5c8fb7b

--
Lee Jones [李琼斯]


