Return-Path: <linux-kernel+bounces-78544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1F38614C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5C11F24DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA3481202;
	Fri, 23 Feb 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifwMnqoY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0717020B02;
	Fri, 23 Feb 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699953; cv=none; b=inynvalC4gV3puD/zdS1t3cTGgbWhbwcZK1jgAu2CT3gexzPMG/Egaaq1SnbDeODd2REWkD+JSZ7DNiukS14IGEknNSBF2Puz/e4jP66Bym/ECFY/tZ9j3tqckUdJpr9MBpUm+ev1LT6I/18ttKCQtz+pGIFcJ5bTAbL04JGW1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699953; c=relaxed/simple;
	bh=sIKBNSWSsBKNFEntTgfSFYjQ/wSintFsKDHaczAEZiE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R5w3aoA/DDPt8/sSHkfLEtCbBURDbAvI5bPk8zJQwLvrboFrT9LVQJeybb1ZeSazJIY5Qo2+QSiF7ZYz/PhBhChu8IPdfa/SekGrOMkNqupI1YE7dxxkbP6i7xlH+UZIya5D2n8EyfJ/g8DCbnnzHPQJdvQ67eEsxVu/07tlZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifwMnqoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28D4C433C7;
	Fri, 23 Feb 2024 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708699952;
	bh=sIKBNSWSsBKNFEntTgfSFYjQ/wSintFsKDHaczAEZiE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ifwMnqoYzCEKfiCB6j0R0v4qF9sFYG6UKlhRkLGCJPZUTdzrTzI5D6LC2X+VqMCax
	 C7oGPnKQC6/+Ce0XCsJoNe+VlkV49+SL9ZZs2rbtnIR1LGDE0lH7fIxVgIOJvxBSV7
	 xl86SbPo2BB8akuYQiBxbAyFbMrOMuc1evsP0wesuJkBXl1il4j3ek9LCDLC9EIwHv
	 Z74Qum2BkdyJuS9FyU/K4BxNCMbzgbOoI0kkFR9S3q7P71ff2pnKitNeRiN6UgIbP3
	 L/Tmf2GiOraWxYO+prhr0EMgnTan6cUmY1QdkP6MHqZvmrHLUfaW2+pGzEizDWvoAt
	 nyR1MbDi2K5Dw==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Anjelique Melendez <quic_amelende@quicinc.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.de>, 
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212111526.829122-1-arnd@kernel.org>
References: <20240212111526.829122-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH] leds: qcom-lpg: add QCOM_PBS dependency
Message-Id: <170869995050.1680781.3053673810947690497.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 14:52:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 12 Feb 2024 12:15:02 +0100, Arnd Bergmann wrote:
> The lpg driver fails to link now when the pbs driver is in a loadable module:
> 
> x86_64-linux-ld: drivers/leds/rgb/leds-qcom-lpg.o: in function `lpg_brightness_set':
> leds-qcom-lpg.c:(.text+0xe7f): undefined reference to `qcom_pbs_trigger_event'
> x86_64-linux-ld: drivers/leds/rgb/leds-qcom-lpg.o: in function `lpg_probe':
> leds-qcom-lpg.c:(.text+0x16a5): undefined reference to `get_pbs_client_device'
> 
> [...]

Applied, thanks!

[1/1] leds: qcom-lpg: add QCOM_PBS dependency
      commit: 2b6e12192159605ed7cffd36892cea2c82786975

--
Lee Jones [李琼斯]


