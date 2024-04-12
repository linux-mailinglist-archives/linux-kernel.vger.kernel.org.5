Return-Path: <linux-kernel+bounces-142025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8158A265F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2651A283DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB902869A;
	Fri, 12 Apr 2024 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2oH6sEo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C715C82;
	Fri, 12 Apr 2024 06:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902906; cv=none; b=jc2hNKzjkQMGZ+fpOtLqDl/q/FCmXsRDXTeHVq1V/QcKZMdWy4n1gPlO8qCp0KpAx3PkBr7dCN4VPyVmZ4GYCldG3OSx4uRxrgfYG6RIZojFy6dA9evJVNk957z/xr8FUP8mQNtOGvwAtsZUQcreB12NCUz5LeRJR3UvfwfyYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902906; c=relaxed/simple;
	bh=3HkpJojy/K1PBxL+4mbZbpwq+U3GGqzPtMY8c/dVemc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Qkrqzog37WndLOcpaVkEuLatJZ6Z34MBOF8IGhrUD1N3eayNO/edZzkvZ3Zsle1rbbJTS44FaUYEtuxuCyaJEyQ7LTMu3loOrKeyBeK/2YnlbNLXEWlHG5s/76ouAUSoHZLL/KXZum2foTBNoZgVs9H6p3kB+7PkAmnfpPruFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2oH6sEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7044C2BBFC;
	Fri, 12 Apr 2024 06:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712902905;
	bh=3HkpJojy/K1PBxL+4mbZbpwq+U3GGqzPtMY8c/dVemc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=t2oH6sEoxUvKpABTuzdEvcxBIg+pIRL+XCecL1b+p6Y2BkQb2XQTp3KVqf/NHZU+5
	 ssV4p1dEpC0JU0+Y1goSDJXUfFjupXzk2w9GbCDgha0iUNp0MMji0G8yrIc/jkHVoN
	 UHL8q9trcQwm175POiBhTFLYOXTZqnC9HdjqMpBKL62teCJY8qOq3kt6DRJXlr2zTI
	 qAdhVY63NG2FYFYaxCFseLdAmKB+yAHjcXMfMl10wez9egmnFpEVPzwIGER2eEr7Db
	 gofbTjSQAmu1CUMPQBS7Cw1o5sxRBhplUqUqL0/RNZtFBvewmJK2D5JnWIrDgsuBQh
	 PIrGtV9wk1chg==
Message-ID: <c6db329bdd8f760878cbbc84d099a4e5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240411092453.243633-2-gabriel.fernandez@foss.st.com>
References: <20240411092453.243633-1-gabriel.fernandez@foss.st.com> <20240411092453.243633-2-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v11 1/4] clk: stm32mp13: use platform device APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Thu, 11 Apr 2024 23:21:43 -0700
User-Agent: alot/0.10

Quoting gabriel.fernandez@foss.st.com (2024-04-11 02:24:50)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> Convert devm_platform_ioremap_resource() and remove unnecessary
> dependency check with SCMI clock driver.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next

