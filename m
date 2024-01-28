Return-Path: <linux-kernel+bounces-41853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EBF83F8AC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD2428220A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F4C44373;
	Sun, 28 Jan 2024 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUuLgP7t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8AE41A8F;
	Sun, 28 Jan 2024 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463966; cv=none; b=mqDsjO6QvgY+Cea2K84Y0CHnVhVBqx11kOi5a32/EVTV+rMkW4GzQpZVVCpuT2NLYRfdy1Qk8aVjtmFOSgQgstiFL1XvNKububoZjKXedgGbeIQUwJdKuOK4w1JtSKSHrFewXZJXvSISlO7fEwyCvyH6SEAJNGqINtjggVKWNSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463966; c=relaxed/simple;
	bh=4iOszAdH8DjmH7arROjjyCcg53o+BvdhsAW+OufJ8PE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NcMfEOThInBU0LXpGU5dy8gmg4dgFI07UPiNi/1ruIgOAzbLBVr3NK8w0d0wUtzlED15519nY/tvJ3lNmiE9JJ/4P2p6tFo2GT2DkVHVGySA6AwP3gpBANwFN2dHM62lXVBl107ThUCjYQ+pYfrdsIEsNcbX1gQrhkKhwDQVj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUuLgP7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0A8C433F1;
	Sun, 28 Jan 2024 17:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463965;
	bh=4iOszAdH8DjmH7arROjjyCcg53o+BvdhsAW+OufJ8PE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUuLgP7tYRcqZWs8rS8DdpU2t9WhNKB+XQLfU4Y6Yicj5JCGkco0nFwJm4QtljL8b
	 xjOc7b4Y8+QsmTnOBgeQ/EtjZ/ckM3ihGUo2WcEZ4szUchqn9HZeAkHj9qqpJdNNVy
	 ZVSMHHbANTr4ZDzaQuIgGEBYZv4Yzpl3GUqf7iEbiEGK7T5BsahT2GC6sGWhGkj2TV
	 G4k+yeK1U7G57Cher3EqhG6MoXUKsxBEzY138XwD3tewYv4DZeRmGIoc7e+4dpefyi
	 YqUFuAWD+XDd0u5n77xxXbUEzlihwbBnyJMapRdFw2O1cuUY/xd3y+FMPNTSpHr2xu
	 kU2IMQgCYcu8w==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8926-htc-memul: Add rmtfs memory node
Date: Sun, 28 Jan 2024 11:45:48 -0600
Message-ID: <170646395032.64610.7751619864693491875.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240121-memul-rmtfs-v1-1-e9da29b1f856@z3ntu.xyz>
References: <20240121-memul-rmtfs-v1-1-e9da29b1f856@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 21 Jan 2024 11:21:54 +0100, Luca Weiss wrote:
> Add the rmtfs-mem node which was part of one of the "unknown" memory
> reservation. Split that one, make sure the reserved-memory in total
> still covers the same space.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: msm8926-htc-memul: Add rmtfs memory node
      commit: 713bc594c6334a36d0caf4b98510ba3b6795616a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

