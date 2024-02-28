Return-Path: <linux-kernel+bounces-85827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEC686BBDD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D101F23A32
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36DE86251;
	Wed, 28 Feb 2024 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3GTIYrO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066EB7291D;
	Wed, 28 Feb 2024 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161244; cv=none; b=VgBpzQ6aL8jTN98XQqym4tSGmQR3+jGg0LapIdArKY+zAopKVcfmANLJiz6cqVuIfl+l4SJEp+sOcfH/ZYXZpvQUTaQv+yNcJbOgotcqXPCgZ4BWx7OJa2DIN4U0668pdArnWj881FRYEEsLl8RNr2YwOf86D8m3FhZW9N45eGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161244; c=relaxed/simple;
	bh=cbr6b/G3lRERbyX93hkq9IWLhpeAc9lzDtXfqhVGFco=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=KBzo+kvaklLy4jGNihTvqZhEAwy75ZriYy6DGATyciClVhPkExwf5X9eTG5TNQzqF9pm/ATeaJNoetuEW6T1QzJ63CPoSdSjlx6qKy0pnTjwl35CHXl9vlXBjld/ogDWtuCKX46LLRczAn4zlsQj9cd+oIoxpqMSbXm41KARiQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3GTIYrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700C5C43390;
	Wed, 28 Feb 2024 23:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709161243;
	bh=cbr6b/G3lRERbyX93hkq9IWLhpeAc9lzDtXfqhVGFco=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=k3GTIYrO6vj2o4GWm99HLI3oqmnSpulORl0SqrKI6PEqfzBnHbZ3ZVq6+DiMdpp6e
	 v0DkzUczvx33Xs+3qhJUPOa8HlYD8d8XiSfNsF/2vaIo7Hbzf05DbIm/Ub4+U9qsXg
	 hxBANzGu7+AYgrqkHLGbFRdnZEKHhd75TSXdi4vE3YJ0weoU+uxOQwKDN8fbruMgH4
	 JrOJZ53mjP+m62AXvrYLSHvMcMMTRQp9XkbrWWd/JoOw9pzSVevFuu084aWhV17a69
	 aDUHTm8wn5vbsvg+5eTd1uM4sJT2zU1Xbuo8KAaMGT5BGAYtz9yg562MBhZWY14xGj
	 oE/JTTnW0aY9g==
Message-ID: <1cffc4a5c769f0dc041871cfb9be0950.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240224091236.10146-1-krzysztof.kozlowski@linaro.org>
References: <20240224091236.10146-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: clock: keystone: remove unstable remark
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Date: Wed, 28 Feb 2024 15:00:41 -0800
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-02-24 01:12:34)
> Keystone clock controller bindings were marked as work-in-progress /
> unstable in 2013 in commit b9e0d40c0d83 ("clk: keystone: add Keystone
> PLL clock driver") and commit 7affe5685c96 ("clk: keystone: Add gate
> control clock driver") Almost eleven years is enough, so drop the
> "unstable" remark and expect usual ABI rules.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

