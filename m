Return-Path: <linux-kernel+bounces-165748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA6A8B908B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3431C22BCA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995BC165FBD;
	Wed,  1 May 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqVUX+3e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70F165FA9;
	Wed,  1 May 2024 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594863; cv=none; b=ryuKM579jDK2Dhu/3PPfXqzZyvxs/4AURCQrKjHnFsxtxXB/bGo/G8pFF4Iv2A6u5dlpesLpiUIXj8TdtwkvxQCwRe1apPhwh1Rx9piGuHStq9sc112HMJ0hWge9GVgHwuqs7Mqo4yddKo0834Z9EYsnCGmijTPvKwIKtpmavv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594863; c=relaxed/simple;
	bh=xKCF95MtbtTIYmyPX1cgokc8oWxl3i3VQHH9oJo8TH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPjNppHjzPybrGbGSu6kXxU4b/bYYfmy1KAF0zo/LihyCa5u6ZLCPElZ0aTdLFCEX6OtOyJmMEVGizfhsDzgktG8A6ilztm+qsxCi5SLBCahkI3XAkOQXb8iicy8UOgs4tl+USI4t4as0iKYHb44O2YMG6g+PwOmXIvC0Luuf8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqVUX+3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2410C072AA;
	Wed,  1 May 2024 20:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714594863;
	bh=xKCF95MtbtTIYmyPX1cgokc8oWxl3i3VQHH9oJo8TH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XqVUX+3eXGYhXpbbPGlIu1+xruvMfb3s81ar9bNPqV64neeWJ+jWdTu8cCb7VfZQk
	 gE1YQwCYcNW0FCroABf83NScwXTxVH/uVAWm28LfZn5FWTY1ORrxEWS1dhusP6rq0a
	 uI8WpqasvjDHP7fpkNos5egJuISyEL9bxHy0q6BUhMHWQQ02/wefwgksenL1yp+Vit
	 ezEesBZYsYBr2d4u/l3xzKt0fP/QFYixCs9M6fwynoTW1We00/ly3KQD1nLvCSgVcv
	 eq2I9l7sOmCR3L5Qrc3VmzUXnOWyN3EjyopwDp7LETSrEiVaXDoZShIeWUb2NhL8CC
	 icETRCaNUEOig==
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: fix bluetooth device address
Date: Wed,  1 May 2024 15:20:53 -0500
Message-ID: <171459484208.41039.14534043220899840559.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501075201.4732-1-johan+linaro@kernel.org>
References: <20240501075201.4732-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 01 May 2024 09:52:01 +0200, Johan Hovold wrote:
> The 'local-bd-address' property is used to pass a unique Bluetooth
> device address from the boot firmware to the kernel and should otherwise
> be left unset so that the OS can prevent the controller from being used
> until a valid address has been provided through some other means (e.g.
> using btmgmt).
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: qcs404: fix bluetooth device address
      commit: f5f390a77f18eaeb2c93211a1b7c5e66b5acd423

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

