Return-Path: <linux-kernel+bounces-41847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066CB83F899
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF45B1F2102C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A062E413;
	Sun, 28 Jan 2024 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOaRa1Y/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACE023745;
	Sun, 28 Jan 2024 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463960; cv=none; b=b3bLAjr1kmNVEY5pa9JY53n5P4+LNuRWmT06N0nfq0KovrGmStXZxEM6XGOfTD08/g1r6O0x7HtI778tYMNzU4qkPzhbw11C7XZ3KPcqGGGu2EhOJqfWq4PZ05MhdGEamdV8CsCy5qKX/e+8S3ZtUCRmlKeKaYJD3/QdSyafqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463960; c=relaxed/simple;
	bh=T2gZhT7bqNZFPeyBjwatwdiknnzawEsBDJAHm1MVP24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCx9PO21HQ8uPC5Wo1I4JsvkR/kuWqLjmoNFx5tHU4gc8kQl1osfDPFT+/9BewyiREukL/6+fzBjKCehiSJPE7q1Y7WhS2hq0WGn+iqYll/b9HLjeQQC9cGfm9vikDK3uvj5+SgygrtgVwvTRhyMLO4YQSkCPnej0wBD/3HhgEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOaRa1Y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70B6C433F1;
	Sun, 28 Jan 2024 17:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463958;
	bh=T2gZhT7bqNZFPeyBjwatwdiknnzawEsBDJAHm1MVP24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOaRa1Y/EgshGHzRHC0ynwxoJKymgNDEyUFur8wxgkijU5LwlgwvX/B5jmh1aIReo
	 xeh3q2nQn8hD/M7HWq3tAV1e/9RzbuARt16G4STsi9L/d+mMsSZTcdiCxybN/JQOB3
	 KeUKyjWKe41xpt3p65Ce2bm3dBPt0K5hF71vCeKflYa7N5TWlAq1mwb5aFODkRuGVc
	 SqHgw7h5bYT1MspBANpNQ6toVg7pWPUpGsBquD+nxyTYUfNxUCZ4wsaCfm9LcDLE21
	 1OT7FvgTgcraZO0rok6ugSa2QY6U44fGd8FKaqPG7kLlxjR5zR426M7NmsjwseN1L0
	 bidGv691kjhlw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Dylan Van Assche <me@dylanvanassche.be>,
	David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-oneplus-common: improve DAI node naming
Date: Sun, 28 Jan 2024 11:45:41 -0600
Message-ID: <170646395043.64610.5068987727804354474.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229200245.259689-1-david@ixit.cz>
References: <20231229200245.259689-1-david@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 29 Dec 2023 21:02:33 +0100, David Heidelberg wrote:
> Make it easier to understand what the reg in those nodes is by using the
> constants provided by qcom,q6dsp-lpass-ports.h.
> 
> Name nodes according to dt-binding expectations.
> 
> Fix for
> ```
> arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: service@4: dais: Unevaluated properties are not allowed ('qi2s@22', 'qi2s@23' were unexpected)
> ```
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845-oneplus-common: improve DAI node naming
      commit: 278d3807d304c90e59edb61aa7ed8a05e1e836bf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

