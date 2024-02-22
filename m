Return-Path: <linux-kernel+bounces-75914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071CC85F097
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D626284BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D254C8A;
	Thu, 22 Feb 2024 04:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQIqIaj2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616387464;
	Thu, 22 Feb 2024 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577849; cv=none; b=gAVbhLQ3Xmln5jMi0aa7s6UCTeJywBREay1Mx/Y8fojlp1zjnB9j5o4fTSHuQeo4vkX8n6Hu/05xuHrPkmcArshZIYSAkXKYE9fmd2wzSHFri4bqkfpKbhwHan3wrA3ZFhHnJisl4gM2Z6zaVLPsISvkYbKBqTIfx4qDR+2vqkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577849; c=relaxed/simple;
	bh=xv5Kd67LzDY3dV1mtlfan8baFAFu50zkqw7sA7SDB5o=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=SoaZss5SBHwvlVBGD7QAJ5JTdLBRqHFUpKVLb0ThgssJGgEcbjBs4xUOo69fFwNmvFC8QvobWN4oxocj6mI8VkBn5QBVE3grGLWEvRrZcLfCkS9UtDcV+wDJnqSLruSLbyYh5OrxGC6r8JcRBa5RsVvAzSs0djJ0haJWXZNxSBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQIqIaj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6557C43390;
	Thu, 22 Feb 2024 04:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708577848;
	bh=xv5Kd67LzDY3dV1mtlfan8baFAFu50zkqw7sA7SDB5o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=QQIqIaj27HFJQOJOqfyOO2nkCxNeMwagbyKhkbmkUqV3xJ0TtrCMsEsM4Nb2tsPGE
	 As2rARpZutcL4u4ZiRhBljrWNVXDU3yKncxw8OA6C3PE156LtWwZ+ku4KaDOKh08vH
	 5Q+GVicpmmDpXbxrZutUJCJYLNCAa1yP46GRTmsJZmiWPVWyjmZmn/RIyLIbrPgT1V
	 +UWeMTE1hA1dhQfbOHXtz4Hz49Zsz/ud4fuF3auSanZLlvkN4Rewfi1QFjQkkBur6O
	 VhmfV0Bq1BEtIetBAf+agaF1OFNtZIECkjzvCl0xa6ANrgae86OlXl6VFLJqKnXV25
	 /lTEaN40fsmqw==
Message-ID: <c04d314d9f934e986a53b33e71bc990f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240214061233.24645-3-zajec5@gmail.com>
References: <20240214061233.24645-1-zajec5@gmail.com> <20240214061233.24645-3-zajec5@gmail.com>
Subject: Re: [PATCH V4 2/3] dt-bindings: clock: mediatek: convert PCIESYS to the json-schema clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, Rob Herring <robh@kernel.org>
Date: Wed, 21 Feb 2024 20:57:26 -0800
User-Agent: alot/0.10

Quoting Rafa=C5=82 Mi=C5=82ecki (2024-02-13 22:12:32)
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This helps validating DTS files. Introduced changes:
> 1. Documented "reg" property
> 2. Dropped "syscon" as it was incorrectly used
> 3. Adjusted nodename, "compatible" and "reg" in example
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next

