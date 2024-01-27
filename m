Return-Path: <linux-kernel+bounces-41430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A1B83F0D8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776201C21BE1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668C32E62E;
	Sat, 27 Jan 2024 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnbxlE8J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ADD241E1;
	Sat, 27 Jan 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394893; cv=none; b=suSGK74t9PLmmot95MBlPn0pkPHOTx3oR7llB77JVdIvGVUlsIkIz18cjkHtZVermtCI4uDEm7y1njwZjIOOv+skj8ldcRmFr2uFobCfT5FsVwjPUkuoDEAK7oRmma54aD7rnaWMOufGcwSXqIwVaEG4B6dtYHTgevF85zNdZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394893; c=relaxed/simple;
	bh=PgAuTYsegsE4i+EZmHhYRd11EsxV/Yf/IyoOBaHSkfI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bg9rn053mzAcyKZlzft6eXiXHZnVdRFWlVkdVJLvRXpdZo7r2iOXtgQW2ssNzz5iQhD3jkjZPfx4xrXmaf9b6KOJMdFf4PozkWBggVJGPhXgqnCY1L+vPY0tWsUtwqAFLPt3IB4LK/sRO1FqSVkYxBJm/n5YXt8AgevViRCvaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnbxlE8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CC3C433F1;
	Sat, 27 Jan 2024 22:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706394893;
	bh=PgAuTYsegsE4i+EZmHhYRd11EsxV/Yf/IyoOBaHSkfI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fnbxlE8JhpvPHjv7ooYUmDJSb/kdbf97vwnmHX2wVwZrn4fi51c3eno3ASd7FQjlZ
	 wi/EksUJKdG6/d7oiydDCzCF1/gHjz/KJ3gHQ5lpJNMEEAKuBJ16eB4botVaRMvrpt
	 +JZU7pwVsISWxqcxGuXd89XdMHuR81iMVx9txLoxmmeXD8lVd1Y0pLWlMkm/rl/Mri
	 mKYCrOmIx6sRUiph91oMkZREAp/ivRvLkVKPInNsONQYd4d9WGNqjJiMMpMM59Vu31
	 /Au4wHX7LIRVtL99rMdmL1ODkot1me/Qb98E6bFaKnv2hX1FsL9MTiJDDXpQIXh3JI
	 uKVQ90be6iFTQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] ARM: dts: qcom: use defines for interrupts
Date: Sat, 27 Jan 2024 16:34:44 -0600
Message-ID: <170639487716.21016.14504510609825555736.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205153317.346109-1-krzysztof.kozlowski@linaro.org>
References: <20231205153317.346109-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 05 Dec 2023 16:33:17 +0100, Krzysztof Kozlowski wrote:
> Replace hard-coded interrupt parts (GIC, flags) with standard defines
> for readability.  No changes in resulting DTBs.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: use defines for interrupts
      commit: 81924ec7a0d50f6fe3ed5a616ae3ef30f1edd932

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

