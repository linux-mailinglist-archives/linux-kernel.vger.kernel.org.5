Return-Path: <linux-kernel+bounces-41851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D344C83F8A6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E281F222BE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957713C493;
	Sun, 28 Jan 2024 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6jq8s4A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF13C08E;
	Sun, 28 Jan 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463963; cv=none; b=eEjmzzubn2l4f4qCaFE/L4qM8fQkimARw+1hZjc53vDDUuNdNya/jXZaZZqhV6SMQCZQobBsmOUs0Q5FycuFhvgi2X9MEOmnT33vMmZ4DwnPeS+YU16p/692dKsRh6irHs91LnFnr2XsqP0++KzU3OlnWpz4IpX5UyJLM4fRqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463963; c=relaxed/simple;
	bh=b811QY5D3pqP+wiWzcBtS5Qv4bcFj9F2QfW6/5d3pQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBJ4hHUNiln8JnFmLau7/KabgF5llAf07bC0A+dv0N9UtQalVAL+iiHZkkEd72Jt4n1BIhDE5TVuxEPuP6bpZvLVExmsdsP0mgkgXL5fzOPuDYpuUtH2KFc+cgm3Eg93YVS5LB1xvBagp93F8XQ4cOyC+AqOJhG0CPJegGJl6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6jq8s4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4257C433B1;
	Sun, 28 Jan 2024 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463963;
	bh=b811QY5D3pqP+wiWzcBtS5Qv4bcFj9F2QfW6/5d3pQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6jq8s4ATqIp9ILFvFAxNCYATeTLW1jz1d/6MTyby3/EMrqiPgrGALEc7c5468EUX
	 dj/7TfKnZno/yqyWU9EyMaF1HzLNS9RTT0TMXVcSFrhqAfFvINV5fV4xM0MyqLgpuI
	 cW445ypXkpKk53ZumAi+V6PwZDPO8NJFXOrm95o623pVTbJ03M8U0vCVL0/JEL2+tM
	 TBOofBCRMVYO9WGYnjzGj0fpWKBd6Zcxg6SGbTX5R2wnQlJmS29GB/QNQ3BhMYaynT
	 wXQXfb17e+0/V+u5fHxXAOe7mIX9E5xlNQCNHGKsFpDMAdniJBjE5mFUmbLpODgVuQ
	 sStmUm8gIX2mw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490-fairphone-fp5: Add missing reserved-memory
Date: Sun, 28 Jan 2024 11:45:46 -0600
Message-ID: <170646395041.64610.12625908348864380007.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229-fp5-reserved-mem-v1-1-87bb818f1397@fairphone.com>
References: <20231229-fp5-reserved-mem-v1-1-87bb818f1397@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 29 Dec 2023 13:53:17 +0100, Luca Weiss wrote:
> It seems we also need to reserve a region of 81 MiB called "removed_mem"
> otherwise we can easily hit the following error with higher RAM usage:
> 
>   [ 1467.809274] Internal error: synchronous external abort: 0000000096000010 [#2] SMP
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qcm6490-fairphone-fp5: Add missing reserved-memory
      commit: acc38e600c52c6d423b374ec6642e5acfaea4710

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

