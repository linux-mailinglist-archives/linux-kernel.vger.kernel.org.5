Return-Path: <linux-kernel+bounces-118389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D00F88BA1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691ADB21D34
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01C212AAE0;
	Tue, 26 Mar 2024 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lykr++in"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77CF84D0D;
	Tue, 26 Mar 2024 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432739; cv=none; b=i/tn7DsmmNfLWC8hkmgKu6CtLvm6eIq3XSK1zV2cggmTndErK3JYs3iz1zzgqSgtUe6FSiAEm/uHO3rI0Utk8OVmu2d1G4KkW1knsovVxrvuB+UxWMUgODyhEknnmUtLtIbhbIGYVpWg9wgydGdrgT3dVQbxtlMI+sNSBjDiQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432739; c=relaxed/simple;
	bh=h1uusV+cyBXJPcXhdymwjfHgzRSwOLITOdDET8ssoHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbSjPWy5MeC18rSM/ffh5V8UbqILs0DAOiSirimh9OfRpc2Dz4q2s5gXECGFDwXrwtJXeF4LqKUH0UePM341ZoIEd36UkrsjgIUTTW2Bks89QVTIRxAoqmRmcWdUyVTIy/DMmaobbzuOZALegRqUr2Vfc3HevpN+eBoAI0TraUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lykr++in; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0916BC433C7;
	Tue, 26 Mar 2024 05:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711432738;
	bh=h1uusV+cyBXJPcXhdymwjfHgzRSwOLITOdDET8ssoHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lykr++inGuPg7GwoQWhXIRN0Yw/WdceU+kJWHiQ7vdZi4h0/aSIxsKfABKphpZxjX
	 T5kWuQihnl/fJdzoNTSpyyhe3oPXsvlGBX+TfkFIto+StCYz8bJK73e9EdWseLMDTs
	 o122t5ccIpYuV+OGBh52W8hongbGE/8kzyeenW4M=
Date: Tue, 26 Mar 2024 06:58:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] staging: wlan-ng: Remove broken driver prism2_usb
Message-ID: <2024032605-celibacy-wistful-ad08@gregkh>
References: <20240325195112.GA17878@matrix-ESPRIMO-P710>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325195112.GA17878@matrix-ESPRIMO-P710>

On Mon, Mar 25, 2024 at 08:51:12PM +0100, Philipp Hortmann wrote:
> Tests on wlan-ng hardware have shown that this driver is broken since
> April 2021. Remove broken driver. Find fix for bug in link.

Odd changelog, if you have a fix, why not just submit that instead to
keep it working?

I'm all for deleting drivers that are broken, and obviously not used,
but a better changelog might be needed here.

thanks,

greg k-h

