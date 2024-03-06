Return-Path: <linux-kernel+bounces-93157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F78872BA4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF03B28273C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EAD4C91;
	Wed,  6 Mar 2024 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqPxY7Ul"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAB1A50;
	Wed,  6 Mar 2024 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683810; cv=none; b=TUIcqL7fezozm4shs2IbpfqlY+Af3P33iQpyQroffRH+LZODj16rpcYii4uaDlkNNKEBa3HJ5HcmyeH2FcmAp99HbjZBN2KuE1SOxuQpao1w7esNE3WFpCnGleGe0UQRtQfjYRL14kVWNssXi2v3IEJ5P6XHnHU4/QxtEo5YB5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683810; c=relaxed/simple;
	bh=x1sK7a0RCA15eFFBmvlQKLOIEP3zTJjtnhBDxwr0SNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXI/2pYvDE4MOMjXEDAubIGe3GwQJsySiy15tLT53IKTo8r5U+IqHTMuhOp7WclPCMtdXIEs3NcdWToYUYT9CPBa0aUgsgwErry+6Y3lSrXZz37U2GECvFZTgPYHkCiqmXBOzRnDy4utwsoE3ZAVSizRpkMPw+c46K+iWI0t4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqPxY7Ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3800C433C7;
	Wed,  6 Mar 2024 00:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709683808;
	bh=x1sK7a0RCA15eFFBmvlQKLOIEP3zTJjtnhBDxwr0SNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqPxY7UlHK/zYOF7xvKx/hlPX2CABFqnw26+lqNWb7SDECXWr2WfuSppamCB+1B6h
	 /wvZv+C5/BfLN3sAxeOcvLfrTwBAuALV7KWyh4bDVbOLCnVOEt7OycTcgHoHoCPmCd
	 7ez6eJ7vRPft0wXqp+9pfgBIRBMpAcCdipLmbMEGUsy/EhqMCq81gUTfFvsWeZtcEq
	 aWOkzq15PRuGEybzP6m2YOSzSDz3XaOUIt9ArFknwM91rFBpbZ+5nI54ZA9CU9tLxy
	 9XXbyNF5ogWejOTHbDG8o1/j3+QLDpF02XwtPMu53PJYCeNmHVetod+eM98uPz7auB
	 L+ruD4+O4FzUA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Yangyu Chen <cyy@cyyself.name>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh+dt@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] riscv: dts: starfive: jh7100: fix root clock names
Date: Wed,  6 Mar 2024 00:09:20 +0000
Message-ID: <20240306-chowtime-gravel-061baa8c2214@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305160046.46337-1-krzysztof.kozlowski@linaro.org>
References: <20240305160046.46337-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=311; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=2XRB0K85Jf3Fnq7Xb4RYLRCpkEXc0uSg595bg2V1Imc=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnPtxgUb9tseKTLi5krfNm7H8qL7m+rmXF4XmOrvXHcz M7EvS49HaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIKlVGhlapvzNTZbvsihez WzptZhCeZNK1nXdNZpMUb7PbPObGPobfbMurqtLOr641aeMLkF8SJ2JYz8uVbyF1iiVUPObKn5m cAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 05 Mar 2024 17:00:46 +0100, Krzysztof Kozlowski wrote:
> JH7100 clock controller driver depends on certain root clock names.
> 
> 

Applied to riscv-dt-fixes, thanks!

[1/1] riscv: dts: starfive: jh7100: fix root clock names
      https://git.kernel.org/conor/c/7921e231f85a

Thanks,
Conor.

