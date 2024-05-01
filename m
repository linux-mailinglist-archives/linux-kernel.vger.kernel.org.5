Return-Path: <linux-kernel+bounces-165749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E10698B908E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BB1B22E86
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527B7165FCF;
	Wed,  1 May 2024 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfamgVdz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB6165FBC;
	Wed,  1 May 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594864; cv=none; b=Djzit7K2qDK4LtrLA1RqgC0RE+AwdMgsZJKmiOAsI1wlFSpmJQDWUvEYkC0nxBp3jFFDfBp8wwBUpF1MJKQkf66ZzyHwjdGLyXoDQ/bIObK4MloRwmpbRHv7FmLdZJekAepagki8qTz+cdDUGAzEJUex+x6v+e0YastpcQsb5bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594864; c=relaxed/simple;
	bh=0ManovgD0aWEOG+UsMRayeu/IcZOohBcA5CFxQqUQGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqLUnvRRaqsC6P4VGXjpzrUStUXbgMntifllN6ImXvbk+qWsmDS6ON+/VrivJaMHAquyYnIAMXwNgkNslnqJ8j0vT5wk3smoibGWWdaAWzfrzofK/hD0kv00oWmg/qERrxpZxJnbbhEk94kuWv+nKZ5hUz9e0COgpJXA47wEt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfamgVdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AA9C4AF48;
	Wed,  1 May 2024 20:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714594864;
	bh=0ManovgD0aWEOG+UsMRayeu/IcZOohBcA5CFxQqUQGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfamgVdz2uVhBdquElT+HBMJ7yos9J2aWLsKERE5dKAdsPxdKHeSzk/v21MzAj361
	 O8CsnZ874lL0qhtCQPXoi+tfvF2DoofoU8sL/tg2LH/I1TI9HnJlhBEZ1Y3U905o0r
	 LpL1DEMRFWYfBUeYUFZoCDQLDCze/wDLf0UTHtx1KDdpVhy1dWAyo8sCpmvnU6baE5
	 +HsMpVEhFTq/vbEd5RaRseSMY9JxtRDzDyiEUFQ7qj4cCtRhKGOrnSYQix9NXHP7z5
	 kwhNGOLq2HspMZV0InPcnfK+ZT4U5j0jFSmZCyt/41pX/vlb+D86CP9oE0H9oBNoR5
	 B5NiMJ4WKACBw==
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: enable USB MP and fingerprint reader
Date: Wed,  1 May 2024 15:20:54 -0500
Message-ID: <171459484207.41039.1305919008828894232.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501065641.965-1-johan+linaro@kernel.org>
References: <20240501065641.965-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 01 May 2024 08:56:41 +0200, Johan Hovold wrote:
> Enable the multiport USB controller to which the fingerprint reader in
> the X13s power button is connected.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-x13s: enable USB MP and fingerprint reader
      commit: eb24bd3c593fad7bd88cb7e7db683014c125e23b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

