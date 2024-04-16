Return-Path: <linux-kernel+bounces-146766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0545E8A6A92
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52DD281959
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6C812AADC;
	Tue, 16 Apr 2024 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJYJhJHp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD61DFEF;
	Tue, 16 Apr 2024 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269859; cv=none; b=fytmuQNUwdal0vRCgVsZ5aKj9HE3o8b21jglg/aRWIC98GniwC6K7T5u2vuw/VwXbMs/CbdyBatwpebm9DYQVvJNkKFGXyw3nT8d60Q0Z1pI22u3+Nhst3oCoilA8frYjSYDTf9yPEnHZrq8SUZufxq+dGRDmmMEimAddJgDYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269859; c=relaxed/simple;
	bh=KUoqvIfp72VSJoG5DlTPcOVEPeLqujFVbiYLFnOG3Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+XBzF9DL8P3aBSeaeYxFRROU8Fn3dLVY7EL90FlhqhWspPJxIRqHfJI979J3Ve6idRFXVHnBAHU5swBqCbPt9LDiUYh5dZRsdAx56fC04KyWuLLzxrmV+5Ha7SgUmu5Gh29dOl7veZVgClYrsa++o1/cOOGcirmLNuCAAvAFmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJYJhJHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95982C113CE;
	Tue, 16 Apr 2024 12:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713269858;
	bh=KUoqvIfp72VSJoG5DlTPcOVEPeLqujFVbiYLFnOG3Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJYJhJHpWaR9fEXSKGb6ceVdVPpkVkFO5CLpLz1gLwxykLV0VmXc+EJnZjGB7WV9U
	 IWLAUVln3CfDRumS9+hBhcGb83plwk9y+WCFN0cBjda1PnQ8PaLPKevZLQsFvAK2aD
	 aGQ3kqFNvD3K1zAQkM6swrch7sSUiAg0TUFf6lIA7RtwTtIOE/hideOl8Kot5UnkvY
	 6gaBO7clG9PBQVOJXrqAZrlMLA8rCjdR+pXczxYI8ck9OOGn6x3OTp0qBrRdpuEjAp
	 33fOLjcCjVm0VJw9m6Ia4zFOKdpLHJTghqGxf/0sXGRQcErJKuGLZUNz4iisWFzgjW
	 bmESs2+dcTUOw==
Date: Tue, 16 Apr 2024 13:17:31 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexander Shiyan <shc_work@mail.ru>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 00/18] backlight: Constify lcd_ops
Message-ID: <20240416121731.GT2399047@google.com>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <b4cafdd1-c1b0-4abd-a849-8132c19d1525@suse.de>
 <65adee30-fd12-4cc7-a227-9a586bb9e6d5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65adee30-fd12-4cc7-a227-9a586bb9e6d5@kernel.org>

On Mon, 15 Apr 2024, Krzysztof Kozlowski wrote:

> On 15/04/2024 08:56, Thomas Zimmermann wrote:
> > Hi
> > 
> > for patches 16, 17 and 18:
> > 
> > Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> This does not work like this. Toolset will apply your review tag for
> EVERYTHING. You must provide tag under each individual patch.

And for that to not happen now, you have to resubmit the set. :)

-- 
Lee Jones [李琼斯]

