Return-Path: <linux-kernel+bounces-119943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B20A88CF27
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D511F65AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537BE74E11;
	Tue, 26 Mar 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyE0IEcN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B81BDE2;
	Tue, 26 Mar 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485466; cv=none; b=gngEvpEG/KatebIo5TBohyi6y5DsXF9C1iY/VBJsFngom1oMP1sEr5C4wR52Y2Jmgxil7wX6pENBZynnLRNtyrJr387ANyNJaBuTM26IzCaA+ue8l/WenDq4FX47t8fHobVoB2VihKfiZ98hrxjAkAhhGoeF827dnpQKtYdl/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485466; c=relaxed/simple;
	bh=Q+0/ltytHVNVe17dw4a66rMcIkTyRhhWaQELFnVBTFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gW3jdXuac645l4R8+ukLYEq5bPwc6tSt5N+pnDYTho1e8StlneWHlb0SorcLfKtUeZViM5thiVpwmfdIV+MQmMhv4q893cZlTCws5sJXx7j11crQ0vCskveGz2DKnh2K2wJYe4PHvz+TeSg+6YfdYpIBLf77dn/V/jHfvcwH45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyE0IEcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FEEC433C7;
	Tue, 26 Mar 2024 20:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711485466;
	bh=Q+0/ltytHVNVe17dw4a66rMcIkTyRhhWaQELFnVBTFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyE0IEcNh+PkrmksKPNXCL4zEUBaje+Mc9e8mt4+jSbTMuejZkiWj66j3zNt2kobC
	 E3cCcMm/QNxYAiwJ96ylGhIbqIKiqOpyqe7+RjfRHHCdDI3Eersk/0GMMzBKA4a15N
	 7b1+ZZ/xkGc0Ixof4ibRUzrDJxpPO9fKa6DsgQntRZzsWj/50BS+lrj6YVmTAcSDG3
	 b3BeAQCQYeKPvr923WN0rYDoe+nCeYpwFYtE5h3zf0oTTHZYQr/zC7DnKgyP7d6K0B
	 Ud3/ffrT9kkR8RS75EhgMz1HGzsMbgC8mdEGHf7s91wPH/X3z1bX9mcO/t6rqPjenf
	 14Eco3vyLQVYQ==
From: Conor Dooley <conor@kernel.org>
To: ganboing@gmail.com,
	kernel@esmil.dk,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shengyu Qu <wiagn233@outlook.com>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: starfive: Remove PMIC interrupt info for Visionfive 2 board
Date: Tue, 26 Mar 2024 20:37:10 +0000
Message-ID: <20240326-create-motivate-2792be1692c5@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <TY3P286MB26116B828A34D614C09F4E8898202@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References:  <TY3P286MB26116B828A34D614C09F4E8898202@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=472; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=flQK06d61XVdV/qN2kQBXCsv/i+05oATJwu6J3J8ZbQ=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnMht8sb+xIW/FtLUdJRcUiFc0f05m+3Gx+w/aw7q7jx DgD16Y3HaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIggZGhlPNnIZTlUtfSGmv OneJ52C0zdprSuJrdGt7s1Mn5xwOdWT4yXg2e9+nlZ7VXpOFXZcts+D98fPRZXaOSXZHpnis5Tt kwgcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 07 Mar 2024 20:21:12 +0800, Shengyu Qu wrote:
> Interrupt line number of the AXP15060 PMIC is not a necessary part of
> its device tree. And this would cause kernel to try to enable interrupt
> line 0, which is not expected. So delete this part from device tree.
> 
> 

Applied to riscv-dt-fixes, thanks! And I didn't forget, so I re-wrote
the commit message to add some more information as promised.

[1/1] riscv: dts: starfive: Remove PMIC interrupt info for Visionfive 2 board
      https://git.kernel.org/conor/c/0b163f43920d

Thanks,
Conor.

