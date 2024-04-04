Return-Path: <linux-kernel+bounces-132142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE672899030
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91D42830AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800EC13CA92;
	Thu,  4 Apr 2024 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYMCYDvR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C0A13C9DA;
	Thu,  4 Apr 2024 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265811; cv=none; b=Q2l2NK8BQxA6Sh7V3UEcbbonLZQnFKECmT6zP3MtD5t20TKK0dMz+/q+M7aIhLojLgkx6xd1Tk3vqo0rrVmsG1jMVIurfccANFBtw9K2OOpGRtuSfETh0SjLh5xL9/6626DS6zP5FR8Gies7CpWupqNJ5IeDa5TgL4TLt+7LZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265811; c=relaxed/simple;
	bh=jTeEuJ5HuYDfWTI1wvH9YlNGGxykqiWfIpqUOk+gGFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZKmuQOcLUxUl6xZPFCcvN93zB2i/Ul/12XdWRzctzfsRfJdtLGPAfirD9KvrFbt5yDa8HOgfJ0YTBR/ShUqj32zMHFj0KVmsulSwFHZhS3VUYgfgh/pVZujHy4Gj5mrpyBEONoGcE87rnYLw9jvDIKZnPFnfRsrMvJmpNQPAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYMCYDvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E85C433A6;
	Thu,  4 Apr 2024 21:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265811;
	bh=jTeEuJ5HuYDfWTI1wvH9YlNGGxykqiWfIpqUOk+gGFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYMCYDvRP8Unvaew/ozJj3ZeXLiXdLCyHQQ64gotFLqnH1XFShWzY9KeTnMn3YnSR
	 G9a2c7gDEmGFCfCXEm7E5QEGl2ewhCwtp9Pbrz9zQAzNJbpMjfW0uaftwxnOF5+joe
	 Ntm4kKDT2ujmBHDihAR0b1nOKxcebpUrKsqRNSRd2VBQtXXRiD9iGyc5GNhWRDxk2+
	 rgR1vEgtkOyBp+Yg0mn4NqAtuQsfLSa9clxD2+9x3JFexALSdkzoJ90fApfX+J7Nvy
	 rYI4mQGBAjiBnSuOYJrPAiUjHCM0rH7CG41chBZ9T82T2T4OPF5oPFGeti9g1ObqDZ
	 MTc9zW1a7Muag==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] firmware: qcom: qcm: fix unused qcom_scm_qseecom_allowlist
Date: Thu,  4 Apr 2024 16:22:58 -0500
Message-ID: <171226578692.615813.4444393111756948362.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231120185623.338608-1-krzysztof.kozlowski@linaro.org>
References: <20231120185623.338608-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 20 Nov 2023 19:56:23 +0100, Krzysztof Kozlowski wrote:
> For !OF builds, the qcom_scm_qseecom_allowlist is unused:
> 
>   drivers/firmware/qcom/qcom_scm.c:1652:34: error: ‘qcom_scm_qseecom_allowlist’ defined but not used [-Werror=unused-const-variable=]
> 
> 

Applied, thanks!

[1/1] firmware: qcom: qcm: fix unused qcom_scm_qseecom_allowlist
      commit: e478c5fb6aa10af7b7edbff69bc8aef6fbb5f0ed

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

