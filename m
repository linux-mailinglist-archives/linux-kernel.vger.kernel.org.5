Return-Path: <linux-kernel+bounces-102580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97D87B432
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A873B21FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3500959B53;
	Wed, 13 Mar 2024 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkP0XDDu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A1759175;
	Wed, 13 Mar 2024 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710367791; cv=none; b=oG7YoVhQ3bwtQRALFXOQ5ugq2wMHyk2oVWrEDP2+pcmCYTJpMNMEfRDh37ZcDWk7V8268HsiDBjIONrq4uY9KezBtxTNSIIkPc7lJB5lezudMGUDvr+XYEJbWEO+jZHguCVZz+HVwzX+hU7lxdgIML93DjJhNXuQGUpxfb4NVRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710367791; c=relaxed/simple;
	bh=T63j2vgyYX9Cwz5H21b5fP+iNTyYvbmn0iKcyawREEc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=G6RQ5/tafl0FDO1Eg3nu2lEKFYv0V8AtmOe/XZ/kjD/JIe79heekFH9SuVNB92L5rB3URo+A7Ol4QH28T/22BAli3YhZgGWoAs4FhnZZKUydXExZnx096F2oDWtKcxjtzsunixeODT7r4fFAY45x7rA7jRqS28/HxA3ArS17uSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkP0XDDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31488C433F1;
	Wed, 13 Mar 2024 22:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710367791;
	bh=T63j2vgyYX9Cwz5H21b5fP+iNTyYvbmn0iKcyawREEc=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=PkP0XDDuH74nKU1wtkUZJs2xM1fdkMQ02axfR1YNc13jNopN43G8p55NmcNxFhJkL
	 xTeMIAN2EPMudLDPFvlvobM8DnK/B5eVuR/y5SxO9qmalUMtcgzkW6kLeqO5i/dbnC
	 rFizWCb7Be+ZLjKUWQnZndKX94BJXHceg619KoE7Q5df4V25ictdN4NQE2GngqnEXB
	 f2ZkPJWOFRrtV7UiYm9QGMz77mdk7k6SxtHa6xm4QeKDMeUEF5lws11DOZ/LVjWajU
	 0W6Ntvm/CxLS2QhyXvTwyAwH5Tjq80fvWQl9ZqmkV/CxxaJY9NNfycqY7aFYmLZD2D
	 n1n9OtIM2RPPQ==
Message-ID: <5e8a0f9f37457d6d136f8b7382936a15.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240312185035.720491-1-krzysztof.kozlowski@linaro.org>
References: <20240312185035.720491-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: clock: samsung,s3c6400-clock: convert to DT Schema
From: Stephen Boyd <sboyd@kernel.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Wed, 13 Mar 2024 15:09:49 -0700
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-03-12 11:50:35)
> Convert Samsung S3C6400/S3C6410 SoC clock controller bindings to DT
> schema.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

