Return-Path: <linux-kernel+bounces-55947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC58584C3EC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7944B282C19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DE3200C0;
	Wed,  7 Feb 2024 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mpbu+Mz3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D21F953;
	Wed,  7 Feb 2024 04:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281219; cv=none; b=MZJF++JJCYkBIIIYirkDH9TzyGAoujjO64F0pyUMbfcoYaOblCjnpJkUOSMXA8eft6qbZgobAFItncWUlIsjLH83+wwK84I5lZaY+wO8grs/QeALRATmXSit2yTuyPoZVVgiDgd8+noXTKaiZi0MqGcsanXAtjI4hoAMxfuRkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281219; c=relaxed/simple;
	bh=51/2Huw7n6UcNCzZg5mIF9NnD6EQsLcBAmZLq5KYbRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYp7T/nAC3fj8nteO1YGxEB9nBqKQgumHAwyYS3JaDUnZXoq7aeKxyC6dFL5xB9L0EJPg01CSoKqwZjIziaa5Iy/KCrBxCAe5VATEknb56Zekex0drMlmQeG+7Br/JGY4io3xjaL0S6c2nzmvwTMDA5yVdSwkkhN9HbRu5S3RUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mpbu+Mz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93641C433A6;
	Wed,  7 Feb 2024 04:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281219;
	bh=51/2Huw7n6UcNCzZg5mIF9NnD6EQsLcBAmZLq5KYbRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mpbu+Mz3AQMFjbfiAxcz4DfU+A6AjC9EoK+FwmOOqtpZB0hjXRhDQS+OKzie2t+dp
	 6t8PhfUZKaK8FxOZVI5Wu1BN4poQ/3aGTQbJFEw/XbfYRXT7H2dVwkGv1Y1YJkCs6d
	 EBWx46htRWKimUuuDRkk6T3dNUTPu6y/XY4qW7CqxYXQ8p8oZHLu1Ni1syf+DEmvsL
	 m36P7Sj3jvoiW3g87zbvuqtX7ATL5un5L2yiUSftmwysqr1P0pxNoT7syDCJxpURWv
	 sNu/rLO9HFpgkiL23b9X9fswViB9fNsdMca94W/YcsT3JjFbdTFHxtQK0mLFW80TQH
	 OPADRsv+wmyFQ==
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
Cc: Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH 0/4] arm64: dts: qcom: x1e80100: audio support components
Date: Tue,  6 Feb 2024 22:46:22 -0600
Message-ID: <170728117671.479358.3966190565168052883.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214131016.30502-1-krzysztof.kozlowski@linaro.org>
References: <20231214131016.30502-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Dec 2023 14:10:12 +0100, Krzysztof Kozlowski wrote:
> Still not complete, but most of audio support.
> 
> Dependency
> =========
> Depends on:
> https://lore.kernel.org/linux-arm-msm/20231212125632.54021-1-krzysztof.kozlowski@linaro.org/
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: x1e80100: add ADSP audio codec macros
      commit: c6d6df1703d47c693e8f44b086f902108d22d0a2
[2/4] arm64: dts: qcom: x1e80100: add Soundwire controllers
      commit: 641a7e7e97b6cf657ae4b04a4d19c270a776697d
[3/4] arm64: dts: qcom: x1e80100-crd: add WCD9385 Audio Codec
      commit: 229c9ce0fd1168fb5e48ab1729e81dd06c4029f7
[4/4] arm64: dts: qcom: x1e80100-crd: add WSA8845 speakers
      commit: 0293019c6709c707cb34382d7e745cf636f39baf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

