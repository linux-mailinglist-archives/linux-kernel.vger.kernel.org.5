Return-Path: <linux-kernel+bounces-87152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA5086D04F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248071F22B34
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7FA6CBED;
	Thu, 29 Feb 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUctBZkh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8260838DEA;
	Thu, 29 Feb 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226951; cv=none; b=CY/tbINA5hwVzVLEM294Os5aIAydOZEduZ71GhUq/iaiwZ9X+i8uxYf+41LtSudLEtJBPioj+jeji/WeqHmhntxCnxdMxafizR/8HG2MqSJ/NkW3nEqlqKSaJ4p6AB0YdJQ58NBcHwMc8RRUGjjPo/zoW9G8zA0V5EgDWdqgv58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226951; c=relaxed/simple;
	bh=UI4jw++HlohXMHIBnRWkHueqa0Yr6Rngz8KiocAyWx8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XpwHsqgVTbt3RF7HCiE2WUQbyxWt52aXVHEpqeYx4rkUzHNKrQ+BANHzH0YpAjSo5JkFycG4HWQ1M/S72/WfW7fGxe7UtGPBvnmV7Bvb0RMta2E41zRF1KO3X2ht0aCHOy10ykKxA1Sc4lLyOYsxfUALYjaFK+HS1YGoBIa3Cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUctBZkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7B7C433F1;
	Thu, 29 Feb 2024 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709226951;
	bh=UI4jw++HlohXMHIBnRWkHueqa0Yr6Rngz8KiocAyWx8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kUctBZkhC8D/OOpRfrC+Nt7tidVip0E2X+VOqp/uzWLVpziV5YQ2TNJuizjA1mYqG
	 No/p82ee6K4Ud3mt4RCv5m+oSND1TRZIJtiq37ZfZMKQf6GP/RavqEze3wepRX5nte
	 fB7zURhL+k9rQyhUx8Nfma+ld3KDKw5R1g4oPYrgHIj+0f/ZeiFBOyN8WsCuVKHYcU
	 1vHsd8BZ528jTgFb7juNd7VtNwtdYeODHfvQ/JRXSTE9jA+4aaWqOKk3nrUKDDSh2f
	 6fZfmC+5wwQB+9aerpSHyQzpRoe4ToWJTuYtK32+mFJ1BJGSBN9Nt3Ahza8ugCL8aJ
	 yP8MjJW/SSVYw==
From: Lee Jones <lee@kernel.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Steve Twiss <stwiss.opensource@diasemi.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <f512045738d2102c771a171a514ed7cf612c6d6f.1708944455.git.geert+renesas@glider.be>
References: <f512045738d2102c771a171a514ed7cf612c6d6f.1708944455.git.geert+renesas@glider.be>
Subject: Re: (subset) [PATCH v2] dt-bindings: mfd: dlg,da9063: Make
 #interrupt-cells required
Message-Id: <170922694896.1610001.17817812880165232655.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 17:15:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 26 Feb 2024 11:50:02 +0100, Geert Uytterhoeven wrote:
> '#interrupt-cells' is a required provided for interrupt providers,
> hence make it required.
> 
> While at it, move '#interrupt-cells' in the example to match common sort
> order.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: dlg,da9063: Make #interrupt-cells required
      commit: d3dc362b3a3d20d64208426cc86146eb241d7c7f

--
Lee Jones [李琼斯]


