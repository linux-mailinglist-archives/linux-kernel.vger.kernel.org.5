Return-Path: <linux-kernel+bounces-138044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D62389EB77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF9B1C21706
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD113C90F;
	Wed, 10 Apr 2024 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8wgi6wm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C913C902
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733010; cv=none; b=ncNazf4WdTk2OTzfNU9CzonZ0/Fn1193DdIm6dE+ITDy5XI8wK20/+QpQ4Ea2WXpBI6MhQGCe+fGreZ0Rkr3XxNliYSfR/mXM0JCelGA17WWnKk163+dGS/yc1zAVeIoVQdW0IVcP1YO1lECI7B5xv/YKw79WANl1ojXZI3O5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733010; c=relaxed/simple;
	bh=AM9KaNBpxNWCQi5LL7cIKKG7N80lhLsstQXI2gkti8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AFTMw4ddweqINHvahXjGe6AWZYqC7XVGR4lR3V78NAXDHV02eMxthi7GZLksn1IwephCoeB3/8uUG6/ykP9sL28BuTa13AmE2xB/Cs5x0+ldh/TtXBgoxqBTQfvWqdRtHfEh/8VpzLxQ7w1f/DZq2/PsFlBYaEiMcxeHD2ftg3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8wgi6wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0972C433C7;
	Wed, 10 Apr 2024 07:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712733010;
	bh=AM9KaNBpxNWCQi5LL7cIKKG7N80lhLsstQXI2gkti8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=c8wgi6wmHDXESGTtZC/cO3KnmYd6HPNqyYrasrkycLYVdA7+oeHKqvIcNJZ4frXHV
	 jXDt4cHr3HLCklwbOQyds2OfLpNeOoy5sc63PBJysMK/yqrHiR4tqv5h6cqvZTNIjt
	 y3zd+F+as/SphdnWuME4Z13GM10UUTX+6heJpF9INfHoS1ZpbzBYECVzoZc3rWARc5
	 etZ4gU/zA8GwJGWI7Wi9fDIdSokfnF7ex8VNkAb04HF5pYQaC62JxIknDSHrXkSvS2
	 8v+7KIUHDHOFpiV4paKHqt3eyKidC7UhgiYKGIVpMVz/T3Q3qPinYt5fzsNjHJ4vkS
	 NrCj+O1ywtt1Q==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jinglin Wen <jinglin.wen@shingroup.cn>, palmer@dabbelt.com
Cc: paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
 gregkh@linuxfoundation.org, atishp@rivosinc.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Jinglin Wen
 <jinglin.wen@shingroup.cn>
Subject: Re: [PATCH 0/3] Add early console functionality
In-Reply-To: <20240410063432.23058-1-jinglin.wen@shingroup.cn>
References: <20240410063432.23058-1-jinglin.wen@shingroup.cn>
Date: Wed, 10 Apr 2024 09:10:06 +0200
Message-ID: <87y19lpub5.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jinglin Wen <jinglin.wen@shingroup.cn> writes:

> The following patch series implements support for the early
> console on the RISC-V platform.

I fail to see how this is different from earlycon=3Dsbi?


Bj=C3=B6rn

