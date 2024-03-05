Return-Path: <linux-kernel+bounces-92026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835BE8719EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C001C212F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1354794;
	Tue,  5 Mar 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5MJLzYS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9E535AB;
	Tue,  5 Mar 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632177; cv=none; b=pvgLEeUkmpZpt5zess3w1lrhyx0H9RZ+xVxanrQpQkXKKTB5N6rEPAPgZIL4+1odIJZkAypq98fGYtF3eR2sAVUdMz434mk4Uykko/t9t7vxrywnujSfxUMOJ9hNSJAqP47pxbiufsCdilVTZdHomyLb/xxRo6j4f8PxkYtu4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632177; c=relaxed/simple;
	bh=N3axigCyL0acGIqYzOY4GKXFswG/IiVRbVPbQw5st9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlUGTO9F7mTVX9GJ76IrDn9NtSw6IZ7l7y7+L/w4g8UY93O2yeFpY3ZoEfBndLQfyPjz1ovqsm3lKueHoG2TaLe6tGCEGazdhFum4KevZ6NwtiGSMmiUpt0Xm9TEYRQ7GKnw1M+BkApF+ffPZD2G9FWLSXAVoOOxDs+IA4N4Lwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5MJLzYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F22C433F1;
	Tue,  5 Mar 2024 09:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709632176;
	bh=N3axigCyL0acGIqYzOY4GKXFswG/IiVRbVPbQw5st9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z5MJLzYSS52eGLNJyhrnt0lPG1hy3FkIK3TCwpo1tT7W/B/1dh08FK3XNwYip2wkP
	 qN04zWZWDr8bNPsGGkAx4ezj95bUhN62vcd3f9zpxYPf74u2GJqRODf394go7JjnJ+
	 ITpeAZQU/ZteMr07AF6b4c+rcdv5cjaVLlldpJ1QkxvW04LKqNSxvHrtKkGy+AoTGb
	 teqpdTkiV9qevO/WWeLRfMbmG/2A3J0HCc+NIObkwiZKzVIiaeqUze6D5Ug/Idp8dc
	 n1hb/ec7Gx9vcnigSu/12A+cCKLFM4ivR5IziVGgjhyDOgi0l9PWp5tVxpu1iPRCOd
	 DiKJ5KeQGiPzA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rhRQd-000000003Pd-0CkH;
	Tue, 05 Mar 2024 10:49:43 +0100
Date: Tue, 5 Mar 2024 10:49:43 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH v2] usb: dwc3: qcom: Remove ACPI support from glue driver
Message-ID: <Zebqt6ohrAz2eVVs@hovoldconsulting.com>
References: <20240305093216.3814787-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305093216.3814787-1-quic_kriskura@quicinc.com>

On Tue, Mar 05, 2024 at 03:02:16PM +0530, Krishna Kurapati wrote:
> Minimal ACPI support was added to the Qualcomm DWC3 glue driver in order to
> enable USB on SDM850 and SC8180X compute platforms. The support is still
> functional, but unnoticed regressions in other drivers indicates that no
> one actually booting any of platforms dependent on this implementation.
> 
> The functionality provides is the bare minimum and is not expected to aid
> in the effort of bringing full ACPI support to the driver in the future.
> 
> Remove the ACPI code from the Qualcomm DWC3 glue driver to aid in the
> implementation of improvements that are actually used like multiport and
> flattening device tree.
> 
> Commit message by Bjorn Andersson.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> Changes in v2:
> Removed ACPI dependency in Kconfig.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

