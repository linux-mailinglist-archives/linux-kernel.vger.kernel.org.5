Return-Path: <linux-kernel+bounces-110746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20786886323
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB902824AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D46136676;
	Thu, 21 Mar 2024 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hGCqZzMi"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0D132C37;
	Thu, 21 Mar 2024 22:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059410; cv=none; b=b2xg/SqJZllzQcuSjTV96uDi3aFHn4OjqFcrh8RKUKxMi52e/S/BIg1WADeNc+JhLXTHn4fdoP+BhvpWoLC8gULOj6Hg451FSRsxBZFv+nVrxawnalBuyzhiYtbxsKGxj2ETeoHawhPZ4hA0b76XnvMpjGT98mCHx1+Wbqd78ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059410; c=relaxed/simple;
	bh=sJvU7ilh07Ek0FCBD32UoETqJkXvBYXcyMghBANWQm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pyse3DJcEr25Z5FvlhDatRn4dNuVw5Be3wFLpFjhJOLGcXOS+XL6GEcd9amM9izILdD7vPxjn1EiynJSuQRdEvytlBLUKEb+2fF2M77XP/5wW6enhxfLj3N8o6yJR7p2uDgIwsJzhm2hsjLl6Sa2BGg1XN/fVKcdxBfl6RPZmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hGCqZzMi; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5393420004;
	Thu, 21 Mar 2024 22:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711059405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxRLpU4mbet5kJHe9jhNwyAS8Ph3xY82FfqFnfC3CJA=;
	b=hGCqZzMiE672RlUi8VNoWWCp5xJlMCqV7b5ZCWKxWcxcPF2qjyl7V1b9godj9QLEcom8vC
	VLPoBD5ucAG+EavvSLGgW18AJzsvpXQ4ztl72/oJNpK5VO2vmUgOuIIk/QSIyi898CKm+N
	xWw9NfyUzBx/V1XLUbAl1UQoHRczwzGbyX2ILAli9TY82QhCpvLpJI3WfzIM+8CCQBxqZO
	SznJ6+NPk1oe8K0fHGBl0ClCEm8azXyaPPWDCCD8veDc6FBoX/bklq9CtE3+lgSwGuorLM
	ri6BmB5SAVxYfNv1frGDIqJPVQmQU7aAgNm3g2s5/hDdtVLCVfd+mTOxZGMlwQ==
Date: Thu, 21 Mar 2024 23:16:45 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] MAINTAINER: Include linux-arm-msm for Qualcomm RTC
 patches
Message-ID: <171105939644.367696.10302154362155347366.b4-ty@bootlin.com>
References: <20240319-maintainer-msm-add-rtc-v1-1-3a4f7d41b4d4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319-maintainer-msm-add-rtc-v1-1-3a4f7d41b4d4@quicinc.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 19 Mar 2024 17:05:55 -0700, Bjorn Andersson wrote:
> Add Qualcomm RTC driver to the linux-arm-msm list, to ensure that
> members of the Qualcomm community gets Cc'ed, to assist with reviews
> etc.
> 
> 

Applied, thanks!

[1/1] MAINTAINER: Include linux-arm-msm for Qualcomm RTC patches
      https://git.kernel.org/abelloni/c/f7cee094fb3b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

