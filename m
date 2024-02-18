Return-Path: <linux-kernel+bounces-70356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76965859670
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6561F21473
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C244B4F206;
	Sun, 18 Feb 2024 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="lxo8gYGp"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E84EB2B;
	Sun, 18 Feb 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253550; cv=none; b=G86TNkD14gEACOJ6JUPLoR+T+ZVu1txQVaXlh/Ga43iMivn5vrtEjVdma6U8AfSQjpHWdoxwLnYy3xpgefuvli8Xi8yEgkDsOoWQt9mh9fb7pgWf6c9xIAsgBa/ZxbrH9tP1z5sKbuHV5je43SlOZon9KJt7yNEq1VpEQa4yFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253550; c=relaxed/simple;
	bh=hYKNM0kFY4Gq7Ym7sCk5KLWQaWpDLT8Bshvo4HPFqPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYa9HB+erl+rpTR3npOSZAQyJjGEhBYnmiaWLoeHbXRXRZCV8yWdxlljHx5eoVABGAFyVxX1/NlSxLzf6t62cB1P3OgWor3ywqSu7UISuzObaU0ENiSe+Q2PR7oOxPaVmGtK7THcPkZVeuzJ8J5BsWUg0zqZ64bKHu0aym3CCNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=lxo8gYGp; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F42BE0009;
	Sun, 18 Feb 2024 10:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1708253539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYKNM0kFY4Gq7Ym7sCk5KLWQaWpDLT8Bshvo4HPFqPQ=;
	b=lxo8gYGpE+YJ1RA0OUoL5Jec9z+z036cSl6VSBM9jeRuCVjt6Bn1Xh7DqA7yFmIR8or84z
	yg4aHamwER0BvHyrJFgkjQ2SW0ntb0/Hkimm9wKip9A4IVBO0Dnfsf3f6DNKUEae52/nxV
	efmPi+UqMkFxmJSOyt284ty2f8sJC1B/f2p7QwiMtxCcqkE0MlpkcWf4JoozomBC0at90W
	Dyv690ZxsvLdY7oLfYBelwjGSerF7XBQKk9iWbZrVDgxvjKrBsYv+KSfKXzFkk1fMxtjY2
	uTnBtMoYNOZsxyhEENmqS+STjkPqjGLTXmeJ6r4CF/wCvgPCe2+LBnh9sLmqpw==
Message-ID: <5d582382-9a31-4a95-bc81-01d99dde0a6e@arinc9.com>
Date: Sun, 18 Feb 2024 13:52:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: {mt7622,mt7986}: add port@5 as CPU port
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20230918074938.79796-1-arinc.unal@arinc9.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230918074938.79796-1-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

Matthias, please apply this patch.

Arınç

