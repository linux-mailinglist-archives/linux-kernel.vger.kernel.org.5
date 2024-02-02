Return-Path: <linux-kernel+bounces-50243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC0F847639
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4991C216DA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B7314AD3E;
	Fri,  2 Feb 2024 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1vYBLdx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C4314A4F4;
	Fri,  2 Feb 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895320; cv=none; b=LkaDpdJY4NO6zgAjVBxTjFU7MxMUfOjwXivGoJ0YXWkaNUAqsdlW0aZZgw8ICXKVKatqURiRQaeXda+zkq8PSfXYiEQquTOIv1hGCEmT/Ikh5zYdYD6tiuUJR9h+NoXwndWmY7qXzPnn9q2a5VmuvMcU0W7kL6ePblzx4EF5XUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895320; c=relaxed/simple;
	bh=pbu0xiu71mLzG3tpAlx4XRiq02M7PQbHrw97/JF7Ohs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moSFJP+ExnfhQMLmDyjzPX99EC/Ul5mv0phXfIXsAFW/ibCk9DKVy9z2B0OcjX93W3IFrR0GHdg6vHNJ4l4p3R+k8GrgHNjEAkdkwsL1/HkCEpVoTtBQQ9H2EukDXIzn1EHq1UV4A2r55FjOCZSfATbQEiY9F31J1644a6tysAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1vYBLdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80438C433C7;
	Fri,  2 Feb 2024 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706895319;
	bh=pbu0xiu71mLzG3tpAlx4XRiq02M7PQbHrw97/JF7Ohs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1vYBLdxQMumiL5sxhAxnqvnHpG6QNMuCs3YsPZgglZQwxqXD2ii4jpO0SDI6+BH7
	 oKMIes1W5EcWzMTTKWx6aglx3CJLB3O2SzP0qDBCYiSMt1S9oBWBORQGbq57kzwZ6U
	 NTuee7T89T9vUQumVHY5mknuXTVi39A89JlzfZixiPgnavqPm+7M7bp3qom3MEifcB
	 34V79gLh1ooMWm9kbM7F3LublFgKQXwhlOgcnYTdXJajTXzj6/N8Uom+oskQEN6UZC
	 PTd0scEJYo9HtAMZWu3n1dSjNH/YZRvBJfrlzWQtVPOxdcjSXJIowB7Q5TmivPdpvF
	 +XGUcjwAMjA/w==
Date: Fri, 2 Feb 2024 11:35:17 -0600
From: Rob Herring <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: usb: qcom,pmic-typec: add support
 for the PMI632 block
Message-ID: <170689531689.307900.6931801262613726978.robh@kernel.org>
References: <20240130-pmi632-typec-v3-0-b05fe44f0a51@linaro.org>
 <20240130-pmi632-typec-v3-2-b05fe44f0a51@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-pmi632-typec-v3-2-b05fe44f0a51@linaro.org>


On Tue, 30 Jan 2024 21:32:55 +0200, Dmitry Baryshkov wrote:
> The PMI632 PMIC has the same Type-C register block as the PM8150B.
> However this PMIC doesn't support USB Power Delivery. As such it doesn't
> have the second region used by the existing pm8150b bindings. Add if
> clauses to handle the PMI632 usecase.
> 
> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/usb/qcom,pmic-typec.yaml   | 32 +++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


