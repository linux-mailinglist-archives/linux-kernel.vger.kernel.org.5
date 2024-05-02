Return-Path: <linux-kernel+bounces-166243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 247398B97F5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1712823BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1245955C3C;
	Thu,  2 May 2024 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kvzib3r9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5267D339AC;
	Thu,  2 May 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642839; cv=none; b=Oh7r+dc/xe+EGkXazKsH3RtwSQXVwn6tW2Xd3mlhG9Tdr7ScCAd/hTzY6IMwMGYHSSa+62DGxuP331+mT+mjh8E+E8anZBFHZsHAcdOv7VL8DqVrrl0/clr/KZWFLMuCmVtjev3CbYWhSrCPyIUrAhK3NidQ03HRvn3fpzZhl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642839; c=relaxed/simple;
	bh=BgSJP0uWC5NzW5M9QygMOjFlqUJa8kfyqr7Hon1aOBI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dF9l5srDk3B978vYQo9kNBz74WJ0kdCEW68m6wntNKeV0n150jY/ZZIZLcoL2bZQ3ycDxj5elF6pf5+TZzY0TWWh1hV4cyf6R6jRF1vb79cEl1b83xzjwpPYuxK8XkBsfZn4wIweyBn+EkGeLvD9PUvzPQ3gJ8obQ5/IOCffhgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kvzib3r9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB40C113CC;
	Thu,  2 May 2024 09:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642838;
	bh=BgSJP0uWC5NzW5M9QygMOjFlqUJa8kfyqr7Hon1aOBI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Kvzib3r9S+RFTvB2XLnAMx/O85zU8UWECjUIXBB4NT4DWYllfPH7mpuTKAYXjJzg0
	 ozWg1z1E4Zr9ycpSZNwESwXByaoq/xk5bd53aa6ZbLTE+tBfLApcRsFJ+tdwj0UP8d
	 hdhBQU6gcwuo8RE8UPI9T8oweACkQuL2LEkiJRybvO1lkoLPgF7X8CImIYitsPOoJk
	 AkVsMG6sIcgca7ibTRt7myYuZ8oGazMId1k27qtU4RUO5aNdtgNIoj2C9vRVhfpGx7
	 TKhc8+GVp0Cz1t2CON+j9878Ot6k+mxyeQbzvVZLIrQC2hJRe20McvtmEpTwaH6taK
	 oWBIwAoqipX5Q==
From: Lee Jones <lee@kernel.org>
To: andersson@kernel.org, konrad.dybcio@linaro.org, 
 manivannan.sadhasivam@linaro.org, jassisinghbrar@gmail.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, 
 Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@quicinc.com
In-Reply-To: <20240426055326.3141727-3-quic_rohiagar@quicinc.com>
References: <20240426055326.3141727-1-quic_rohiagar@quicinc.com>
 <20240426055326.3141727-3-quic_rohiagar@quicinc.com>
Subject: Re: (subset) [PATCH 2/6] dt-bindings: mfd: qcom,tcsr: Add
 compatible for SDX75
Message-Id: <171464283598.1133936.13130931244723156364.b4-ty@kernel.org>
Date: Thu, 02 May 2024 10:40:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 26 Apr 2024 11:23:22 +0530, Rohit Agarwal wrote:
> Document the qcom,sdx75-tcsr compatible.
> 
> 

Applied, thanks!

[2/6] dt-bindings: mfd: qcom,tcsr: Add compatible for SDX75
      commit: 6b5c5e3546aca232f1bf4837c89cde4ea3ffaf04

--
Lee Jones [李琼斯]


