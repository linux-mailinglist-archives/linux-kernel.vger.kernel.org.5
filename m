Return-Path: <linux-kernel+bounces-38612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF683C32D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4E61F26AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFE34F8AF;
	Thu, 25 Jan 2024 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ1UNUcY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949059B54;
	Thu, 25 Jan 2024 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187880; cv=none; b=Srn+WrDCF3WsOw8geerYtCpX0ykefYtXl39O+lFnKww+U70oY6RNHTeH1yMGzo/OD+wOtbhs+ZiLLar+e58GnhMxJl+WiBocVYD4+k5aYHCRwGOPNdWG5Wu0R9lBlx8ZZ2VFWc63o0A6N65miJ27POOIIG64nG8kCDmam01QHgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187880; c=relaxed/simple;
	bh=re1mVyPi8aLdjXqW+u5VMYGNKanfxtt0Mx/XGaxSaQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nM2fYu/i3SxE6EwfWUSY7aEMLFxcwRlDAvvpcZiFSg4GdOgMEbY3MXZP9sAmnMyUJkBt9Su8IqcU8byrojnUWErvBcVjZNUB35EyQ8zZPoHC61RW7xRxPDzWDEPql+ywhjydmbb9JXgH39Eb71qhWYblqPGRotfGoA1VEtEXrmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZ1UNUcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9F4C433F1;
	Thu, 25 Jan 2024 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706187879;
	bh=re1mVyPi8aLdjXqW+u5VMYGNKanfxtt0Mx/XGaxSaQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZ1UNUcYqd7mj41uJmYe2V+XXWphdUKswCVdYtgXXW9sMtkUw7QmfJcNcLkc10LBp
	 E/ltE74PzlL1NsyeLA16n3x7IoHuV5vg5iwOrPy6BABAvhvHnWJ462MCGrG2rmQkDH
	 DRBAiAltvgNPmrh9usVLBWS+oilC7/kHVHESlmMNiaDV48RGlmVhVHcGHmhIL0OSUx
	 ohW4WC3dcQdmjr+/Z2ldkZ83M84JVbM1jVmvKTksRigG3mrSU6Y520bXulKqzkidTC
	 yM8m9r5U57fm69yrkmDfcKLMCJG0Sdq6cVAyhDBYx5SyDLlNV6jmegR23md1SqaKjr
	 irk8sHhmgvmkw==
Date: Thu, 25 Jan 2024 13:04:32 +0000
From: Lee Jones <lee@kernel.org>
To: Anjelique Melendez <quic_amelende@quicinc.com>
Cc: pavel@ucw.cz, thierry.reding@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	agross@kernel.org, andersson@kernel.org, luca.weiss@fairphone.com,
	konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
	quic_subbaram@quicinc.com, quic_gurus@quicinc.com,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v8 3/7] soc: qcom: add QCOM PBS driver
Message-ID: <20240125130432.GG74950@google.com>
References: <20231221185838.28440-1-quic_amelende@quicinc.com>
 <20231221185838.28440-4-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221185838.28440-4-quic_amelende@quicinc.com>

On Thu, 21 Dec 2023, Anjelique Melendez wrote:

> Add the Qualcomm PBS (Programmable Boot Sequencer) driver. The QCOM PBS
> driver supports configuring software PBS trigger events through PBS RAM
> on Qualcomm Technologies, Inc (QTI) PMICs.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/soc/qcom/Kconfig          |   9 ++
>  drivers/soc/qcom/Makefile         |   1 +
>  drivers/soc/qcom/qcom-pbs.c       | 243 ++++++++++++++++++++++++++++++
>  include/linux/soc/qcom/qcom-pbs.h |  30 ++++
>  4 files changed, 283 insertions(+)
>  create mode 100644 drivers/soc/qcom/qcom-pbs.c
>  create mode 100644 include/linux/soc/qcom/qcom-pbs.h

This needs to be applied soon, or I'll have to remove all of the LEDS
patches, since the lack of include/linux/soc/qcom/qcom-pbs.h is causing
build failures.

-- 
Lee Jones [李琼斯]

