Return-Path: <linux-kernel+bounces-14163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBD582189F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8D31C21702
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195A611E;
	Tue,  2 Jan 2024 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbBGNzbg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A445663;
	Tue,  2 Jan 2024 08:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C8CC433C8;
	Tue,  2 Jan 2024 08:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704185735;
	bh=xcyM9Lzy1bHGatQvJpZM8mMNBURf6l+UqF32aRscneU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbBGNzbgptzv630Z08gZGOYXaXQsYdxaNmXmmrAvVzk0qc1138IWhTqkx3v2g4dL/
	 c+raznQx0AYVhKw4kqrxfAnLreBpzcliumoJb+ZTOyi9DYjWslFj0uDpTSTKV4Jd1S
	 o5y6cXvtLWrO1gTwO9gSeVWrXw+NC5CY2RCBmfZvrC4h5KluoWCQ47usdM88QIqJc0
	 vsayqI/pj+zKfsa2Or7IbTRV1cD0wxTU7IIPJ8Cl+8w0OTSkap+LwQe5YoZW1yujsv
	 gg1xGZxy1Et1d1HJELysjP1yQUWuvr3ERRTFgDjblMtpKOxKxsOlpUR9KOrXJvI6vW
	 ccTRGSXHxXntQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rKaYY-0004y7-0i;
	Tue, 02 Jan 2024 09:55:26 +0100
Date: Tue, 2 Jan 2024 09:55:26 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp: Correct USB PHY power
 domains
Message-ID: <ZZPPflCNy6rULI2F@hovoldconsulting.com>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-2-13d12b1698ff@linaro.org>
 <ZY7DEpaIgvfL_A11@hovoldconsulting.com>
 <20231229171008.GB9098@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229171008.GB9098@thinkpad>

On Fri, Dec 29, 2023 at 10:40:08PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 29, 2023 at 02:01:06PM +0100, Johan Hovold wrote:
> > On Wed, Dec 27, 2023 at 11:28:27PM +0100, Konrad Dybcio wrote:
> > > The USB GDSCs are only related to the controllers.
> > 
> > Are you sure?
> 
> Yes, that's what I was told by UFS and PCIe teams and some of the internal
> documentation also confirms the same.

Ok, good. I'm not sure I did a corresponding test of powering on a USB
PHY without the corresponding USB GDSC enabled, so perhaps the issue I
noted only applies to PCIe.

Johan

