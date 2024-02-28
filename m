Return-Path: <linux-kernel+bounces-85161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CAD86B14B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10FA1C25956
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2911D154C02;
	Wed, 28 Feb 2024 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ/Ny0dx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB4148FFC;
	Wed, 28 Feb 2024 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129353; cv=none; b=tUpcYCxeWG7mWOmej4+gfsEXonue79JAWFtn82GagyrZzjkvShh0nFO4WDH4Er7yAiUDhPJhYesvyi5EHgsR9B01U7Oxfu3uQjQZHnv1RzGwst4JF0W+ViEhMh71Z5ltmM4HRwG7yOBg4zIpvICPnRSFzFKvsno40Llr4UxyQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129353; c=relaxed/simple;
	bh=jrePBEDD+LSREfFk9ElVQL3Of9a8rn4iwpCCpmX7pck=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=AIRvFa+XgTPpNvvUL8jIWApg2fma+G6eFO+HWbW9iRoM0ew72oZIVSFLSm76PyH2eQ0N5E+izV3Stkf1d81HRJXN5qfXsji9XQ6EgsAWI3P0NO3SPbsXGFSLwNhQCmCAvaceXWkfSiE7yjG+4/xF3qgLxM7D3YJTZjail2fQS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ/Ny0dx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2055C433F1;
	Wed, 28 Feb 2024 14:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709129353;
	bh=jrePBEDD+LSREfFk9ElVQL3Of9a8rn4iwpCCpmX7pck=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=hJ/Ny0dxrz2/5IefuLTfuUeZugiQypMoiJ6O5MnV1I+sMQoK3VUo+RUNC6fI2G+lP
	 IHK+1nfLAl6NsCM0ScOpc+Z8+tx7Ar/VNmRv+HVJJLU7Nv2ndtDAUFZTO/HddWozbL
	 jxKtVjAu4XQxyGj+9i7fh40xpH/yfJAknblkvVwAbX2CAt+75B2X2sWBv21qaLqitY
	 gJOXEkLpq40/PdjBYYpfk7y8gByglk5tekJzzjc+lxYCXEtXBSQo7ItFzPFRPq7CRs
	 ne2X/EhqHPB2HymsNxpNnvPCPlCseasxoxwPg9mRpy8k89Ocs42qyyjK7hYeUurg6b
	 K7WL4zy8R/VtA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: constify MHI channel and controller configs
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240223-mhi-const-wifi-ath11k-v1-1-51b9d42d2639@quicinc.com>
References: <20240223-mhi-const-wifi-ath11k-v1-1-51b9d42d2639@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170912934984.3989537.1475358075618175010.kvalo@kernel.org>
Date: Wed, 28 Feb 2024 14:09:11 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Unlike the event configuration which can be modified by MHI, the
> channel and controller configurations are expected to be const. And
> since they are not modified locally, constify them to prevent runtime
> modification.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

766cf07c4023 wifi: ath11k: constify MHI channel and controller configs

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240223-mhi-const-wifi-ath11k-v1-1-51b9d42d2639@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


