Return-Path: <linux-kernel+bounces-39966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF12883D7E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6061F2CEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8B514AA8;
	Fri, 26 Jan 2024 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S54FXUe2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC713FE4;
	Fri, 26 Jan 2024 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263202; cv=none; b=GMJudchMUTXEU+QSxOym9liwiW3MwMDvay7UeGOBRIJROOHT+7ZwgQk4QAKDMQj5xGdZTnX1JnMNp71VuntYeHfKTVU34R0Oa0lTJruTYAKd5Ddixw7hmJSJGL+uMcOWdaIQEWvXt7w6lVJR6V0wA97Jg/x6ODl/vJPs/N0Q3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263202; c=relaxed/simple;
	bh=zHjDc5owg1qOK0d3pdl4UmLNrzlMa7OICaqYOO7ZjZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8hdVHyFc5wFr+PoJjBfo0I+UjJ3eojTb7h1JBDheg6sAZmW4+sABW0me0as5ZBoJ1JNrpAgeCrJuCzYkx6CoL/wv9XlzOuKd8Dm2+QhY7INbGBNQ6hKg977O0ER9nb/J+fKMyzZl1a4ZjDA0f96saO8kRH7U005rp8Vqnoj0c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S54FXUe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B360BC433C7;
	Fri, 26 Jan 2024 10:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706263201;
	bh=zHjDc5owg1qOK0d3pdl4UmLNrzlMa7OICaqYOO7ZjZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S54FXUe2a1Z7SoIca9aVMc2+FN+OfIJjbOyAIYHB4Wtf5S1QrLRWEN+0MR2nbq05I
	 s2xVR5s5oEUqaYNzRekrNnUBC0Cjxs0grw2DN96aF4LSqLcUMMIZGHz/VUiPUkl+ty
	 9GJ465XtiRKIn7L6LQSTidaPHgyFU3aCEvx/VeR68KzaubO0XnDpjdt1wzDcyHisJh
	 QNsH9PD74q+qAsx1uW09CPpaqs9+4cpcRLzWUXstQHn5+4ZPxilOun7W+x/9ROpjjt
	 MJ3dTt4EJXB2xIlDnKSJSPP5ciiN/Z1WMe6PONrpzCL++C4kdbY6yIqTkDtvrQmyC5
	 BBv44EOTJHq7g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rTJ0O-000000006FL-2zPm;
	Fri, 26 Jan 2024 11:00:13 +0100
Date: Fri, 26 Jan 2024 11:00:12 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Introduce additional tsens
 instances
Message-ID: <ZbOCrET0YPujMpom@hovoldconsulting.com>
References: <20240118-sc8280xp-tsens2_3-v1-1-e86bce14f6bf@quicinc.com>
 <ce77861a-b362-4ecc-8e92-7fb846c7e508@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce77861a-b362-4ecc-8e92-7fb846c7e508@linaro.org>

On Fri, Jan 19, 2024 at 12:31:06AM +0100, Konrad Dybcio wrote:
> On 1/19/24 00:00, Bjorn Andersson wrote:

> > +		gpu-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> 
> Hm, did tsens only gain support of non-polled reporting with 8450?
> 
> If not, we should definitely update all the relevant SoCs.

Did you determine whether the interrupts work as expected?

We don't want to be polling here unless we have to (i.e. polling-delay
should be 0 as per the binding).

Johan

