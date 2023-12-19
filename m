Return-Path: <linux-kernel+bounces-5526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA72A818BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC941F25438
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7191D54A;
	Tue, 19 Dec 2023 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV1Np/Ug"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20561D153;
	Tue, 19 Dec 2023 15:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0A9C433CA;
	Tue, 19 Dec 2023 15:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703001440;
	bh=j2yw/602MaeLtlULoNG/LK7nRRRFWoUbu8CFwJBiZpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QV1Np/UgvDY8bP9JRjLns6z5g1O202vAyf2EQMYUUnmydV5gT/wAjOnPn255Wy+4V
	 jjkxQsCyZaZpFqyWe3j0RSBgPSlmAygVvZXewfe3uTKUhUPqBHDERSx7TWRZ8iFPnz
	 2HAhrciYWCLJ548w3SMRTDEajekcsVBgLymxFHzYDQqCEOxbwvkDvrUJgOV+73xcFh
	 HhwI789/5XJTN5q6l3HS0QDvCeJ53K+ZjsUZLOGQNk3F/PbrrruHWKAHtMaBOhucOH
	 wJrslUlzsxdhbKAghz+109p+fllXrxaJp0c+6Z4e0cA2TlfRlzhcLWBiQQjJl/aLzx
	 JDjzQbGowbDzw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rFcT8-0008JB-0A;
	Tue, 19 Dec 2023 16:57:18 +0100
Date: Tue, 19 Dec 2023 16:57:18 +0100
From: Johan Hovold <johan@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: qcom-pm8xxx: fix inconsistent example
Message-ID: <ZYG9XnH47opu2-eh@hovoldconsulting.com>
References: <20231130173223.12794-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130173223.12794-1-johan+linaro@kernel.org>

Hi Alexandre,

On Thu, Nov 30, 2023 at 06:32:23PM +0100, Johan Hovold wrote:
> The PM8921 is an SSBI PMIC but in the binding example it is described
> as being part of an SPMI PMIC while using an SSBI address.
> 
> Make the example consistent by using the sibling PM8941 SPMI PMIC
> instead.
> 
> Fixes: 8138c5f0318c ("dt-bindings: rtc: qcom-pm8xxx-rtc: Add qcom pm8xxx rtc bindings")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

I noticed that this one is not yet in linux-next so sending a reminder.

Johan

