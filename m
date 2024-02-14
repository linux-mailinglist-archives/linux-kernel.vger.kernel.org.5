Return-Path: <linux-kernel+bounces-65751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EC985519A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2DDB2C3DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281E912CDA5;
	Wed, 14 Feb 2024 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU2guIOb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3212CD8B;
	Wed, 14 Feb 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933478; cv=none; b=j1mHW+CIURpKFaQSTV5Be63Ifv6VQlOQvF1h38eOiMdfX1oHUQ6cB/K8CZI+f4ffahSOn09utjPNbAw09P91aysMiGu2OxIG+wEVV0SmciEKZ2mzFcy/mYqP4B2u8cWu6K6SUAO6oIIonA9B97gpszUyI7hWpt76b+clqTvZPvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933478; c=relaxed/simple;
	bh=FPmL/JV5tip5hbCOl4QcYlHN8Qvya/knBKszVBeZQiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQR052HeXqVjo75AsF4tUvRO78IMH5FhEebODGCH4PDXICKitCzgGvgJUvwhE+Y7nrYVCweAyH63e4KZbUxUlSEaODfntQk8qRZC7fyPK8odvl3pGwzGMftwhQ7PDkmTAj4V5vFRt3zq9aCbVDmkJH1IBfjBRMwAU7ww1Eclg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU2guIOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ADDC43390;
	Wed, 14 Feb 2024 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933478;
	bh=FPmL/JV5tip5hbCOl4QcYlHN8Qvya/knBKszVBeZQiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DU2guIObV8tTqqWoSVHglRI5P6g0GvddeaxXP47WmBNihT9BRzWiJVxcq78eZ3IF1
	 UIBrlHIB3/p4/LF3Ws4ga14Itwm0v1w5C19KV91fPQEjKHIRZ87xBRL7E8mtovzlEu
	 vcOBnfhjnINFfWQwHeLsnasSGVKHbgKxjBCnu80yL7pdRcZ3qB7KVC0XVRAjsZ/Aph
	 pyPR3pSAvEhs17+7mtoKYfiglLzW40flSy2bw1tt6CL493TLwDHtDttTepVnrWtRSI
	 hGS6K8tJIA5al6xUDOmBPmIObQQqHUM2TMsPuRWkEwhmwOFbpNUKtP1wcJfDRoNmS9
	 bGAnK48uyYukQ==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Eduardo Valentin <edubezval@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: Rob Herring <robh@kernel.org>,
	Andy Gross <andy.gross@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [PATCH v3] ARM: dts: qcom: msm8974: correct qfprom node size
Date: Wed, 14 Feb 2024 11:57:32 -0600
Message-ID: <170793345827.27225.4764725704979764030.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210-msm8974-qfprom-v3-1-26c424160334@z3ntu.xyz>
References: <20240210-msm8974-qfprom-v3-1-26c424160334@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 10 Feb 2024 17:45:40 +0100, Luca Weiss wrote:
> The qfprom actually is bigger than 0x1000, so adjust the reg.
> 
> Note that the non-ECC-corrected qfprom can be found at 0xfc4b8000
> (-0x4000). The current reg points to the ECC-corrected qfprom block
> which should have equivalent values at all offsets compared to the
> non-corrected version.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: qcom: msm8974: correct qfprom node size
      commit: 724c4bf0e4bf81dba77736afb93964c986c3c123

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

