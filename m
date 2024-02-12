Return-Path: <linux-kernel+bounces-62165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D04851C89
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C248B236C6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DAB3FE5B;
	Mon, 12 Feb 2024 18:12:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B059B3FB0A;
	Mon, 12 Feb 2024 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761523; cv=none; b=mvfjeSAdgHwqUhaPRePqgIID5PvgSpjSDmwtLPHmEFDSrpd+1f3y7EXI0pRnPSYxV9rNVb9rBBIpGYtwiV+x/HjDR58mGIGDG9zoItxTf7JWq0+ttusa8kb7TJ7xMtKdjJk0kAeVjUspKl2UaWxpCQkQQ0O78Q81vZDupNbj5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761523; c=relaxed/simple;
	bh=JzMsPut3TWVma1P+X3v9VKs2Am/ZFCeLK77HD30zSm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxJM5kWyFpIKtmsOJ3Pd70diebNBmnwYWOMoE4jW+re4BtfKa/yx+MlwTRHJx4b9nrOzgUav2f2oq4jUxXPSFLcblkkVI35AB0qUG1uAJApX1g0LfALnn5zeUmQnIyrf7beD7J0og1GpUUWZNd1mOABMwbt0GRabXrGpQjLgaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17C99DA7;
	Mon, 12 Feb 2024 10:12:41 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 019383F5A1;
	Mon, 12 Feb 2024 10:11:57 -0800 (PST)
Date: Mon, 12 Feb 2024 18:11:55 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, andersson@kernel.org, konrad.dybcio@linaro.org,
	jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com,
	conor+dt@kernel.org
Subject: Re: [RFC 0/7] firmware: arm_scmi: Qualcomm Vendor Protocol
Message-ID: <ZcpfayAEqr828Pun@pluto>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117173458.2312669-1-quic_sibis@quicinc.com>

On Wed, Jan 17, 2024 at 11:04:51PM +0530, Sibi Sankar wrote:
> This patch series introduces the Qualcomm SCMI Vendor protocol and adds a
> client driver that interacts with the vendor protocol and passes on the
> required tuneables to start various features running on the SCMI controller.
> 

Hi Sibi,

> The series specifically enables (LLCC/DDR) dvfs on X1E80100 SoC by passing
> several tuneables including the IPM ratio (Instructions Per Miss),
> cpu frequency to memory/bus frequency tables, CPU mapping to the vendor
> protocol which in turn will enable the memory latency governor running
> on the SCMI controller.
> 

As a side note, before I forget (and I got lost again searching for this
thread), next time you post this, please CC also linux-arm-kernel, being
this series SCMI-related this way can be seen by other non-MSM/QC
SCMI-interested people. (as it is advised by get_maintainer.pl too)

Thanks,
Cristian

