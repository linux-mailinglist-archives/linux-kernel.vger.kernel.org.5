Return-Path: <linux-kernel+bounces-168479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873078BB905
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D55F1F23703
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4705F185E;
	Sat,  4 May 2024 00:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5c1ZJRU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2E15B3;
	Sat,  4 May 2024 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714784252; cv=none; b=MqqPitK0zynwaB+GNjFqxg93WLiZ2bVpUlEQmJrfNgveKW1ia7omyz4FN06pLjx/YIp4Wnwle1BK9QOV3N0I+0x/m1KAYvHqsSakGhr9Eg36NKHdJAHMj6TZmqhByWxyW/BVFZ1oB6MTYcFS1riqB4TLawB71BFr45mU4oaovew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714784252; c=relaxed/simple;
	bh=0Xc7VQAdC/90/3pFKSHHnBQUDZDgCqcfRhm70VyBDVg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ToXCNkJmMrTussXBtHxn6UOtrhpUsZqhhqq22AxvBfmaYCGkYOEUZgChsJ1yKQ5ZruC2h0hSeHz3H/25qOBnpwRN6GkBch+MhzyAWd7V3ljJaSS0KIRRAtWOy9FyL+wJL46//5/9ku4O6M3EBoE7j7bfonM19+fb21psbdFfM/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5c1ZJRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3512C116B1;
	Sat,  4 May 2024 00:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714784252;
	bh=0Xc7VQAdC/90/3pFKSHHnBQUDZDgCqcfRhm70VyBDVg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=P5c1ZJRU9neVPQpXiWmKdU2HY7l1V50Sb+rKDP2IexcFtJYjAhwA+M+HOYFNoMyFW
	 8XVFdVBPo0aZA0zr1PjVESW5An8cTdo4EVXzHMzN4q9U+eHr2h7ghsiT80G3qoSIHp
	 YbOzMP907EMAkhQKsbQljiul9ZX1BxhgDwzlI5MkdRiv9KJYlbeuSI5ZwEFfcoYPZD
	 yE1SocXUcvOjiCw5h3nxkIJyNDZDKezq+yM/BHh1cXXRZ08k5uzl0tLp9/ZMKP6F50
	 gv3Ce0YXUAkLGKSST1aNDehLdtUwnuoAaAvZXXFN9CoymCpeVCTPS3jcgPx7hSuM/p
	 hQ8LzwXYA7zEg==
Message-ID: <2b0495d3b3cfcd6dd6e7c70e68da38ef.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240430180415.657067-1-robh@kernel.org>
References: <20240430180415.657067-1-robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: clock: fixed: Define a preferred node name
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring (Arm) <robh@kernel.org>
Date: Fri, 03 May 2024 17:57:29 -0700
User-Agent: alot/0.10

Quoting Rob Herring (Arm) (2024-04-30 11:04:14)
> Define "clock-<freq>" as the preferred node name for fixed-clock and
> fixed-factor-clock where <freq> is the output frequency of the clock.
> There isn't much of an existing pattern for names of these nodes. The
> most frequent patterns are a prefix or suffix of "clk", but there's a
> bunch that don't follow any sort of pattern. We could use
> "clock-controller-.*", but these nodes aren't really a controller in any
> way. So let's at least align with part of that and use 'clock-'.
>=20
> For now this only serves as documentation as the schema still allows
> anything to avoid lots of additional warnings for something low priority
> to fix. Once a "no deprecated" mode is added to the tools, warnings can
> be enabled selectively.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

