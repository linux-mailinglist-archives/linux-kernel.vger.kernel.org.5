Return-Path: <linux-kernel+bounces-133345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC9889A29A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682E52873FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF8D16EBFD;
	Fri,  5 Apr 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcqVZ8o6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECE0DF4D;
	Fri,  5 Apr 2024 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334952; cv=none; b=q+3kmNoQ9IhgmBUAfMCSOSBwD5VcoAihpFbVuQXe82jwD5sL5y37cfe7L1vpmiUAYy2JrYjWvhI5P7I82jpJK5M5hRhgXGTGiklHmHjOTQlXUvOYHHejfBtK9vXmBV9I+QrFTrRrKwFNmBPNg0iNlp7T4DgfYJFOBWfobjyxVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334952; c=relaxed/simple;
	bh=oDN6wQ8VzoG9OW2mJZ7hpzN5TSjN0YJC9IxQ2U0tMHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGXdN8oovDOhEMFXe843zRspAJ0aT+bPs9QTZOcsoHG9jz7WdS/k60IwEzYtTqJ0uqUiUYKh+xj/HQzVXhSlDvs+IUGshdPeG9ulH7QCMzi02B6uWsm4g7lLG3s6AgdiS5euGxe8h6yrNcu4ZAMG0m5QII7iZtqwb9YbrzB2dNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcqVZ8o6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE45C433C7;
	Fri,  5 Apr 2024 16:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712334951;
	bh=oDN6wQ8VzoG9OW2mJZ7hpzN5TSjN0YJC9IxQ2U0tMHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TcqVZ8o6kG0k/k91Y+FZDa/l8c53J7dkG7KmrWFQPW1cRubI3wNvHGC6oLeSEnVJB
	 fOhO5tOI7N4A+8Rs0Rt2sFEmuNplZb/qZquIVXPxi1y/u5VtS4SSDfwRulwCh9QRKx
	 EaARAq1VBxGRAyfhoatVQMys/DGZE3fHvoTP9/s+96M+69ujkLPiAWF2xdhFrM1YT+
	 1M1GkRzI8pBEBXMnyNww9WNuoXn0jVDv9dcl9/oHbwsoVfk89G2y+kWeW+j2fLmDCe
	 Ih0g84+ofUw5kuFC6uaXI4llLzi54ooxZwurdAYWbVJgnPVdZudCYWTq1tc84q/LX/
	 cusVl2ZEjKKPw==
Date: Fri, 5 Apr 2024 22:05:47 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom: m31: match requested regulator name with dt
 schema
Message-ID: <ZhAoY4snnfkGv77B@matsya>
References: <20240220-phy-qcom-m31-regulator-fix-v1-1-7675b4a916b3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-phy-qcom-m31-regulator-fix-v1-1-7675b4a916b3@gmail.com>

On 20-02-24, 20:13, Gabor Juhos wrote:
> According to the 'qcom,ipq5332-usb-hsphy.yaml' schema, the 5V
> supply regulator must be defined via the 'vdd-supply' property.
> The driver however requests for the 'vdda-phy' regulator which
> results in the following message when the driver is probed on
> a IPQ5018 based board with a device tree matching to the schema:
> 
>   qcom-m31usb-phy 5b000.phy: supply vdda-phy not found, using dummy regulator
>   qcom-m31usb-phy 5b000.phy: Registered M31 USB phy
> 
> This means that the regulator specified in the device tree never
> gets enabled.
> 
> Change the driver to use the 'vdd' name for the regulator as per
> defined in the schema in order to ensure that the corresponding
> regulator gets enabled.

This lgtm, but it doesnt apply on phy/fixes

Can you please rebase

-- 
~Vinod

