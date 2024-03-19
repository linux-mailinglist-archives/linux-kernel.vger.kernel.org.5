Return-Path: <linux-kernel+bounces-106940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E9887F5BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F7CB21EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8A87F7D7;
	Tue, 19 Mar 2024 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEsHWdcX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C77F498;
	Tue, 19 Mar 2024 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816548; cv=none; b=apLfSjgHrA9fEH+QANF3O+T9T29Tv8fcqiftOecZDd+x7j85fowfZgnoS52H0lzDCAQW119SKci0OfqoB5+Bi75+2h8y3LGo38Hp5cZNzThcUAuOwxcEgwIdbqca3hswlpzGYIrZ4Tv0ZPMPfcCw79Ji2Hs76uCdYZQ/olEyQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816548; c=relaxed/simple;
	bh=rdWTPTQzZXcOYkX1NQ10jyVCRRxNuyNaJC3v4FRLsK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWhqqoj54coPmmAYvDxQ7D9mq66LcgnlkeUjkh5jXONo8xvAgsCtUL1nWaVs+A+8ii4oB9I9VDJ/zF7A4bRuiGDwVE0xixJcIgE/Bx1TJqw6gxRRr5Vt5MURZCS8ZT+l+H2o+rqxFlPkXDjSjENKU/57Dq/4Hdr5lMm3fjdzmJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEsHWdcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FCBC433F1;
	Tue, 19 Mar 2024 02:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816548;
	bh=rdWTPTQzZXcOYkX1NQ10jyVCRRxNuyNaJC3v4FRLsK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aEsHWdcX8XmzlNU9QAqm6+H1Lpx/mwFy9zISXOnHzqVsF955+OQwWVj8kUgNFQxkX
	 IYIA64GLzUPV0+mOpUmcB/lXt96gAXee4J64LLL9QkHvrvr1wUXt3U3ujzyXhwYHON
	 FVaq65N7g6prL0P5O78THgaJIYTKYxIXO86D0cn6NwbK9aIemB5WbNQ4kEHdbfVVIx
	 7k3y2v8RpfQ9yKhJz96a8MZcuocwK+YYXQMh76fN0R66e0o4QXsnj745SWVz3tjjSn
	 avBpfBIafLKzjuvFQKiky3QEdmi0QjhIgMF9/VqflYmLAhN0clNgqpItiXpZCjOdiC
	 I1WzgLZKEK4oQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bhupesh Sharma <bhupesh.linux@gmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm6350: Add Crypto Engine
Date: Mon, 18 Mar 2024 21:48:38 -0500
Message-ID: <171081652652.198276.10264102128162813821.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219-sm6350-qce-v2-1-7acb8838f248@fairphone.com>
References: <20240219-sm6350-qce-v2-1-7acb8838f248@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 19 Feb 2024 11:16:02 +0100, Luca Weiss wrote:
> Add crypto engine (CE) and CE BAM related nodes and definitions for this
> SoC.
> 
> For reference:
> 
>   [    2.297419] qcrypto 1dfa000.crypto: Crypto device found, version 5.5.1
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm6350: Add Crypto Engine
      commit: fd5afa5d7e5259cb2320fbe2cf60250f7336f439

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

