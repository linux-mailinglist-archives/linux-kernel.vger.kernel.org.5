Return-Path: <linux-kernel+bounces-37880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 976A983B6F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBE21F2219D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03AE53AC;
	Thu, 25 Jan 2024 01:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n80qv1tH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9F1388;
	Thu, 25 Jan 2024 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147862; cv=none; b=Eqnk9oy2TeHoKMAfAev2drarp+HESpdaiSVLoSxIiS3f2vZkNWaH3CTRYf3NlCAzKDc3AbMogvPIBLrrmX5YjdC+ahqZeVJwUenyh5OEgeKom6AMlDfKwk5t5uLnPP+Vi3M6oe/MLkvYI1WEgcLOalXqVKK4oQQjFcF3BRpSTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147862; c=relaxed/simple;
	bh=QcD8kLygxlg10WUj2we5Ozo/oHkcB52bSflymWoKYJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJYgIKXEE/eqYf+nvBF2PR77MJcOUl/B+IcGboPIy5HBwMomXlqQxl306VfpbRRPr1S6nQNXdkODqd4vAp3fgwaDyZYLYjXIpe3x0iifu/k8DQr0v1vBSKfP/vvr87JvKZFXb4mjCUpEPByiUxEKqqgDUm5z6gLz1e3+B0vwCoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n80qv1tH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EC2C433C7;
	Thu, 25 Jan 2024 01:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706147861;
	bh=QcD8kLygxlg10WUj2we5Ozo/oHkcB52bSflymWoKYJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n80qv1tHH5sjBkMcqTJSvExzCWRw3lpNxO0AlgEh71Pdq8tRZJ3AJFJih0QlXAg/S
	 t3hQdto0lRPcjxK02izYqgPyYAE/ADGcjbbcImUPc0v255zzhCAxn46Dq/0hNiqVGV
	 aSGCkEB8ZEo+X+lwbVvwdOnImFxc8N6Sdp8YLFHp96o/5xOJWP77MT4g97H9yZu4tw
	 L/MQR53ickFAccne686mAqR1P5XxYbsCOjVBVNnUEl9nH9Cn1XkOyFaJSpwsUEdGAg
	 voxecvPyToCmUDGZrtL8Aud877q5/NuTuoftKWHdg/df66tCt2Dgu/e6LVLOd0p1xB
	 hgSCBodagzyjg==
Date: Wed, 24 Jan 2024 17:57:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>
Cc: Michael Hennerich <michael.hennerich@analog.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Alexandru Tachici <alexandru.tachici@analog.com>, kernel@pengutronix.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: net: adin: add recovered clock
 output
Message-ID: <20240124175740.397af763@kernel.org>
In-Reply-To: <20240124102554.1327853-1-f.pfitzner@pengutronix.de>
References: <20240122110311.2725036-1-f.pfitzner@pengutronix.de>
	<20240124102554.1327853-1-f.pfitzner@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 11:25:54 +0100 Fabian Pfitzner wrote:
> The ADIN1300 offers three distinct output clocks which can be accessed
> through the GP_CLK pin. The DT only offers two of the possible options
> and thus the 125MHz-recovered output clock is missing.
> 
> As there is no other way to configure this pin than through the DT it
> should be possible to do so for all available outputs.

Hi Fabian!

If you want to use PHY-recovered clock you should really use the DPLL
subsystem. It will also allow you to configure other PHYs taking this
signal as an input, to forward the clock phase. Read lock state. Etc.

Even if the patches are good (which I'm not saying they are yet ;)) -
you'll have to repost this as a new thread, unfortunately. I'm not sure
why by the way this was posted made patchwork think that the patches
are separate series:

https://patchwork.kernel.org/project/netdevbpf/list/?series=819440
https://patchwork.kernel.org/project/netdevbpf/list/?series=818548

each of which is incomplete, since it only has one patch but subject
says "1/2" and "2/2".

