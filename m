Return-Path: <linux-kernel+bounces-16368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E24823D7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05A4285944
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CEE1DFC2;
	Thu,  4 Jan 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oen5qtXA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA80D1CAA2;
	Thu,  4 Jan 2024 08:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E2DC433C8;
	Thu,  4 Jan 2024 08:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704357026;
	bh=JUVtlUJqIjwvTWxtaetbdpmTuo+79ScvueqKYpGwJA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oen5qtXAbuHqj8a+doaOBLofKIyPNKhN1k84UcEmO1pLljuymsPS0BvGBCFou48Bg
	 MpWFFJDFWcpKqHWtqhLAZxfEPIx84k7GSDBzPyru8fQuH5r187SpHvVcYyqsFgvNLx
	 3tPjlvACqTTq3Y/RbbJbFn/OzFZw18yDlfK2OcJBSVfnpDjzLHjS7WSKIZHym2YS3p
	 F1U6irpje9K/+Z177UuathtMvqKNcEYkCDPWvdJMQ5qU7FriDG900GBCW4uW1F13Yk
	 Jam27zpFhhx6htWIc6zUG8yj57IqimNE0vJRAVGbRJ+gZKfZjtc+pD9z8IT4Esirq8
	 UP1n6olsyHVAw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rLJ7O-0007ZV-1s;
	Thu, 04 Jan 2024 09:30:23 +0100
Date: Thu, 4 Jan 2024 09:30:22 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v5 02/12] clk: qcom: Use qcom_branch_set_clk_en()
Message-ID: <ZZZsnvjTsmMrUwWt@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v5-0-99942e6bf1ba@linaro.org>
 <20230717-topic-branch_aon_cleanup-v5-2-99942e6bf1ba@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v5-2-99942e6bf1ba@linaro.org>

On Wed, Jan 03, 2024 at 02:36:00PM +0100, Konrad Dybcio wrote:
> Instead of magically poking at the bit0 of branch clocks' CBCR, use
> the newly introduced helper.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/camcc-sc8280xp.c     |  6 ++----

>  drivers/clk/qcom/dispcc-sc8280xp.c    |  4 ++--

>  drivers/clk/qcom/gcc-sc8280xp.c       | 25 ++++++++++---------------

>  drivers/clk/qcom/gpucc-sc8280xp.c     |  9 +++------

I only reviewed the sc8280xp ones, and with the updated comment this
looks good to me now:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

