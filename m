Return-Path: <linux-kernel+bounces-123638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E68890C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5231EB25236
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CC813A879;
	Thu, 28 Mar 2024 20:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3GmzLix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370284594C;
	Thu, 28 Mar 2024 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659288; cv=none; b=CfKRkrGZNMj3HWoHNsJp4O6Bb7tq+pbaiJocZ4SFOHfAk9sKhk6cBjSpVHRRVY9bcQEzvQJWze5GVdvZ0+xlNlmiXvqfbWKrCXCwhee6YjGVW+vGo/d0x/xjYxiEWP/VEXROopRUHoHG9dOCeLn7aZvpxJ8OslOenwQTII+eoBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659288; c=relaxed/simple;
	bh=tnxhmYo+aIMTZ7hUCuZ2Munr4Hlnba/v6s+s7n46tus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9n4RmCYAFnECA3fqARWYThwCGL5r/G4NYXLvsvOoWepcEl80z1/HggrWctNPkVYEtpiHo4pXWUyaqZFolgc0PYraNKa6aqnJ2uWQarKBADLNJmlYXbroLe6W1qwzpNCmBcMAqTbGR1Cu2MPEAoJek3FkrpX0TIM5Hus2F42a80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3GmzLix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80063C433C7;
	Thu, 28 Mar 2024 20:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711659287;
	bh=tnxhmYo+aIMTZ7hUCuZ2Munr4Hlnba/v6s+s7n46tus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3GmzLix6HyR/Kt7l8QmDD8iTZjBz8uo08lYmxs+Y21ilofyVZylnVhbG0PJ9cK7R
	 D5X+799u/SI2BvGrnqVsvm76+PhszXExERgvTzOS3inUd89xlPDaDK3zn4soHNVaA7
	 CCOwIgP/3avvMJ9xdvIg49oARvRD5VhRtc4XBvFgB2VIlVL/t7U+H0j0fn7CXgEI1j
	 NKOHHGONygPwTUGqPoikDRB4ecmEwWH6AMWiypMb1prpegBTb9T6WpnDUpi21TRvNU
	 8PkHNZNCoJIr09Prj+S1WRssGOmVS8JCensZDPETPYP1Zdv/KQjYmgfkeZ9NL4ILfu
	 ob7iK/ebgVS0A==
Date: Thu, 28 Mar 2024 15:54:45 -0500
From: Rob Herring <robh@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, andersson@kernel.org,
	konrad.dybcio@linaro.org, jassisinghbrar@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com,
	conor+dt@kernel.org, quic_gkohli@quicinc.com,
	quic_nkela@quicinc.com, quic_psodagud@quicinc.com
Subject: Re: [PATCH 1/5] dt-bindings: mailbox: qcom: Add CPUCP mailbox
 controller bindings
Message-ID: <20240328205445.GA326382-robh@kernel.org>
References: <20240328095044.2926125-1-quic_sibis@quicinc.com>
 <20240328095044.2926125-2-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328095044.2926125-2-quic_sibis@quicinc.com>

On Thu, Mar 28, 2024 at 03:20:40PM +0530, Sibi Sankar wrote:
> Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
> controller.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> rfc:

rfc is not a version, but a "state of the patch" tag. This should be v2.

> * Use x1e80100 as the fallback for future SoCs using the cpucp-mbox
>   controller. [Krzysztoff/Konrad/Rob]
> 
>  .../bindings/mailbox/qcom,cpucp-mbox.yaml     | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml

Reviewed-by: Rob Herring <robh@kernel.org>

