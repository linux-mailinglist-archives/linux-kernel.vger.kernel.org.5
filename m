Return-Path: <linux-kernel+bounces-166757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850FE8B9F21
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B35D1F2389A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1887C16FF2B;
	Thu,  2 May 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbyRwes4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FA728FC;
	Thu,  2 May 2024 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669207; cv=none; b=BIBXqX/OTkk9XmmZjKJ62q+iMpcDOnai+lm0CRm9edA+th8BbSDD+wf5LYbbD5pCAT9mws/L6Jou5kD4rVoy71dFHH2FX4YAm8VlJBVqEjUV2KvlxA28WzPNuBEWBUw6RQEFf22Qh2yQXf9x74aERxCaXcGcP+1MPLNvU2Ug84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669207; c=relaxed/simple;
	bh=OiDJwOanTJQJbw1DN8FqcsNA/YyYHEbYGPxLuFJsy0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BqPoX1OwWrI0N4erXZ5uV5w96mComCuMa3+BlmNbKY8QpNuADOQVvcbvC/d1Ukj56+RActZi5Nmf812mkTZTS3F4RZSgdrqU5Z/XKpLtDKEk7DfRFWzkdeZlOUrSob1GZmbLpvAeF5nLvzTQecASXJ73Xu18ImjTX8YFmZniIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbyRwes4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25924C113CC;
	Thu,  2 May 2024 17:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714669207;
	bh=OiDJwOanTJQJbw1DN8FqcsNA/YyYHEbYGPxLuFJsy0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pbyRwes4UHVWEBR/jQB9tj8jnwJRglInaCgddQklp6Oe1aUrJTZN84ObIgEBXzg4Y
	 vbdsTPjPFBFHutKIaq4wXN+0vcslYLCPnNeuCHbdwXk0ZGDozqH8mAJr+4crBsaE1B
	 fLZ5JuFoT9XsSPfkgaBqeIFy5Xucqc4Gpi/yVIg+mnbLKFqr2SaD62zaLPcgBJkFjO
	 hYjw/oTGRgdArsgiNOhZGmndlfQkJMUYlKq+snr7OCmT9RlFxX6wfn6nMls+jR55mr
	 HQ6S2EfPq6ySYT85mAm0AxohvvE/JJSK/7aYpfV1ZxhHnyuPjL5JCqnwaK20nCm1Ib
	 roPbl3Kb51YOg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
In-Reply-To: <8a76de25cefb533d94dfe35062bbd9a8e72f4bb9.1713971415.git.christophe.jaillet@wanadoo.fr>
References: <8a76de25cefb533d94dfe35062bbd9a8e72f4bb9.1713971415.git.christophe.jaillet@wanadoo.fr>
Subject: Re: (subset) [PATCH] mfd: ssbi: Remove an unused field in struct
 ssbi
Message-Id: <171466920590.1212584.14000886789749205606.b4-ty@kernel.org>
Date: Thu, 02 May 2024 18:00:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 24 Apr 2024 17:10:29 +0200, Christophe JAILLET wrote:
> In "struct ssbi", the 'slave' field is unused.
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> 

Applied, thanks!

[1/1] mfd: ssbi: Remove an unused field in struct ssbi
      commit: daa2efd8f49cc2dd6d900e7f5f6b6077a8bdfa87

--
Lee Jones [李琼斯]


