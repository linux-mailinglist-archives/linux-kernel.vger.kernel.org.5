Return-Path: <linux-kernel+bounces-86268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0BD86C31C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DDBB26396
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64C4D9E0;
	Thu, 29 Feb 2024 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0m3krLQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768C0481DF;
	Thu, 29 Feb 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194093; cv=none; b=BOkIFZWivb+qUpPKOuq0Hr3JqRhBuuKPiDSr1ozTC2Uj+F+rwM22L5TxHNXcqLzQJF7zlQ6P0E7EFqq74hxkiC7WFI0/T7gSEzn+UzHujpLltk7JwuNEaOLXAhgYBn8/pLbBvjlns5xm8/A8pRn0d0fOIJlxBMv+7m4dkHUMDHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194093; c=relaxed/simple;
	bh=/UXXFqYle1FvcWueLqKYM/ySMplJRb44Qq0V1oGp/jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTZ92hvfdgVYrajGSGNAo1ybB2d0432ZrXuFTFEl2NazFFiGw2UyPtwJpAjx/3tVUE+DRrsXfq3h1JmXUU2tlvPtfogJsr7mlcga4tawsvSmeBiqlWqNSmgOE90RsspBbM36Uxu0Ak0PT4Qys3Ds4koSVac9QeMSzZycsFsjX54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0m3krLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006CBC433C7;
	Thu, 29 Feb 2024 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709194093;
	bh=/UXXFqYle1FvcWueLqKYM/ySMplJRb44Qq0V1oGp/jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u0m3krLQ2X0tassVGfTrEkYEbwrz+UXrcWqWYd8mf+75aMEucMwh1ETfzp5RLTXMs
	 bJMUu7/8zPg6rbEiZFU9XNc/ijUSVd09z2aq3MfKZGUhZO3IUmC+gTXOv9EXfl3CdQ
	 1nHHG2Q9a0u9UZlJJJMKFToCb4qMDN6SptoBTXAUE6PUBaGIP1FnEJKnrjEnn9AgVe
	 ZQzqhlJZYLrzZcr6pOf6AaDOuc6HhmKKE8wkMeZB518VPa0GBis5vB3IaWFhQczyaX
	 go4mHJniPv5vsGWo+IJLi2iCP4f0XWIbE/o7VhH+SjEfXQ8Ri08UZ8Xt9nrGZAfHb2
	 4WR4gMP51VBow==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rfbSn-000000000OV-1qEx;
	Thu, 29 Feb 2024 09:08:21 +0100
Date: Thu, 29 Feb 2024 09:08:21 +0100
From: Johan Hovold <johan@kernel.org>
To: Vamshi Gajjela <vamshigajjela@google.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] spmi: hisi-spmi-controller: Do not override device
 identifier
Message-ID: <ZeA7dVBmm1yuf6F9@hovoldconsulting.com>
References: <20240228185116.1269-1-vamshigajjela@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228185116.1269-1-vamshigajjela@google.com>

On Thu, Feb 29, 2024 at 12:21:16AM +0530, Vamshi Gajjela wrote:
> 'nr' member of struct spmi_controller, which serves as an identifier
> for the controller/bus. This value is a dynamic ID assigned in
> spmi_controller_alloc, and overriding it from the driver results in an
> ida_free error "ida_free called for id=xx which is not allocated".
> 
> Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
> Fixes: 70f59c90c819 ("staging: spmi: add Hikey 970 SPMI controller driver")
> Cc: stable@vger.kernel.org
> ---

This is v2, which should be indicated in the patch subject and with a
short changelog here (e.g. mentioning the split and rebase on 6.8-rc).

Johan

