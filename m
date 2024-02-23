Return-Path: <linux-kernel+bounces-78733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933B8617FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F9828C2ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250AC129A76;
	Fri, 23 Feb 2024 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO2AX4SW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590405D913;
	Fri, 23 Feb 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705873; cv=none; b=KIFmpKE6haX5pR81JUtPzCQy6pNzvVRClSkWeNq7kdj1wRiE48MxK9QAa7Tj8R+sOG/h/e3oWEMORWfluY2bO1jMgcc8O+hz3w5E/9UETrWeO136w5TgExRD1oANtHZI27H5gu4fHrn/ggdAQ5s0nscs4wX2avFbHg3rzHVgn5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705873; c=relaxed/simple;
	bh=9KObiyXeBDrFMyADFic1+zEVpdJvGxx+oX+zDNIjVi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgtViSKGw2ROUvl3dVSl2uAoY82mJX57lWmI4txB/0Y3/REe0JREwZmG/s3hitZ79yitUngnXo3CpSBBetXPQ62vSnvr4Dc5NGuuM2qu0woTtx+AWS2rTZZ8WUHVVP7XXRRsYRVeV2ixTyv+/EJPx3YSXjWFdvpDCMZx++pzyxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO2AX4SW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB7FC43142;
	Fri, 23 Feb 2024 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708705872;
	bh=9KObiyXeBDrFMyADFic1+zEVpdJvGxx+oX+zDNIjVi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kO2AX4SWo1L3W2khLMFbuzILafe1Zbp5P4pYVZSAzZhKDlUp03DU+7qOFFvERY50t
	 HfiOMJlGJkuHonfrOEx2wCkPIVRyNk/9X/FGQGgvOh4eiA3Pe5wQ1GYWBxSKKDHEQU
	 4aLTISzXtUNUsFHvtqUFAU+UJ0SKlHlWa3DnqBKLeSHhw3vbqMR7sXKvUZKc0xvBEI
	 LI4+dgQrDC7NgvveeQqrog/oxyBwx6FbNt5zIiBrECpHyAn6UIvEroeQHnK65Gbv9e
	 ZrYwXjzIe35YQi/qcwFdWKwueVr0KzecCqlQolIV7XQTdVusXlJDB6mmkV2IdZaSaP
	 N2RGIxmBhMe9A==
Date: Fri, 23 Feb 2024 16:31:08 +0000
From: Lee Jones <lee@kernel.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Luca Weiss <luca@z3ntu.xyz>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/4] Ensure all backlight drivers zero the
 properties structure
Message-ID: <20240223163108.GL1666215@google.com>
References: <20240220153532.76613-1-daniel.thompson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220153532.76613-1-daniel.thompson@linaro.org>

On Tue, 20 Feb 2024, Daniel Thompson wrote:

> [Sorry for the RESEND so soon... embarrassingly I got Lee's e-mail
> address wrong the first time!]
> 
> Luca Weiss recently shared a patch to zero the properties structure for
> lm3630a... and shortly afterwards I realized I should probably scan for
                                      ^

> a similar class of errors in other drivers.
> 
> Results follow in the next four patches (they could all be one patch but
> for the fact there are different Fixes: tags)!
> 
> Daniel Thompson (4):
>   backlight: da9052: Fully initialize backlight_properties during probe
                             ^
>   backlight: lm3639: Fully initialize backlight_properties during probe
                             ^
>   backlight: lp8788: Fully initialize backlight_properties during probe
                             ^
>   backlight: mp3309c: Fully initialize backlight_properties during probe
                              ^

I think you may have the wrong locale set mate! :)

>  drivers/video/backlight/da9052_bl.c | 1 +
>  drivers/video/backlight/lm3639_bl.c | 1 +
>  drivers/video/backlight/lp8788_bl.c | 1 +
>  drivers/video/backlight/mp3309c.c   | 1 +
>  4 files changed, 4 insertions(+)
> 
> 
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> --
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

