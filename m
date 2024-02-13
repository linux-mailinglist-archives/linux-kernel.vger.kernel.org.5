Return-Path: <linux-kernel+bounces-64460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C15853EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21CA28CD51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0701626AF;
	Tue, 13 Feb 2024 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ic1ftN/J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1678862167;
	Tue, 13 Feb 2024 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863401; cv=none; b=TMetafkAqg35+w5JVMKYFvFQ4odvY4O4GZhhwVA1CNXClIAUH5ow76zOesBc9TVUnUzvE4WV20bVxToJl3KmSYvWy5EufVO8bNhma/JgDgN97uyYy2exT229ozh33+i7rl6s4dtdre4nQJ4V+EmkRAiqbaA6g+zKcKXNv05ENv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863401; c=relaxed/simple;
	bh=Fudw3qoxvHN9Hf18ZS81IuKfFF23V8VoXx2unf+dOW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSDTBOgA7HwzJ+JSQkt5ayK4DPQwpfjjTv0l3a9pMdWqWuaT64Hz65TvhvQF9U5d2OUKJ5Taq8yzlDK5367j8My0ZWm6nPlE1VU/fZlECFNZIHvMH/dirHv2vBIdfSRbxKTEJon4mH8INPRFrFMlGvVLcUzfjlK+x4rSkXuLTmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ic1ftN/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4B2C433C7;
	Tue, 13 Feb 2024 22:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707863399;
	bh=Fudw3qoxvHN9Hf18ZS81IuKfFF23V8VoXx2unf+dOW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ic1ftN/JPB4ikN2uzgIR2Fpin1nzDVRSYVZRJ11EMXM0SMtyHAbPonIUET46qqSxd
	 9Ojes7k7SEOxKhcYs2RsQ0Q8xpbqRuKCi2joz2aSTCCZAV+ay0PAnwD2Fy6tA5NehW
	 AsDP5w/utBNn0mdl4czZncZcSiXowz0QkG9qeuY2wTeuFPZWXdS6WoolWwT7KxDplB
	 C6kJZFzkm4rKDxuMEXdRrcT/SxZIAJ+EmXmOfkH/+rzG/3Zd8TzXsEqJpD323b6wTy
	 /aU65DWSCcLEOJIeRbja1kIh/ut5ysn/gEhb1HXqxsMBRaYcJb74jX8LeMLLvb74q0
	 tUp617BnHdBTw==
Date: Tue, 13 Feb 2024 16:29:57 -0600
From: Rob Herring <robh@kernel.org>
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tao Zhang <quic_taozha@quicinc.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename
 qcom,dsb-element-size
Message-ID: <20240213222957.GA2502642-robh@kernel.org>
References: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
 <20240213160521.15925-2-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213160521.15925-2-quic_jinlmao@quicinc.com>

On Tue, Feb 13, 2024 at 08:05:17AM -0800, Mao Jinlong wrote:
> Change qcom,dsb-element-size to qcom,dsb-element-bits as the unit is
> bit.

That may be, but this is an ABI and you are stuck with it. Unless, you 
can justify why that doesn't matter. (IIRC, this is new, so maybe no 
users yet?)

