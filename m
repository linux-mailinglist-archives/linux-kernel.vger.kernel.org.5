Return-Path: <linux-kernel+bounces-42021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725F383FB12
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FB128260E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA66D4596E;
	Sun, 28 Jan 2024 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yx4fMni1"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892CC3C47A;
	Sun, 28 Jan 2024 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706485789; cv=none; b=VB0oYCKjxfQmKt95BH5aZhMIJtyzmJcAzbNQ3aze25n2TXG45In0g+brHvtAktpVKVGQ02Opj9IOYq/Q+2Foc3hIxt48V4Um7ik7+KROFGqgR4ogu5aPqqtFrDjZyYAclrWRIa8olzzw9ceuqnbV3h95vUfZt3MdiV/lZGTd7mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706485789; c=relaxed/simple;
	bh=lq7eikxLGfSU1Pgsd+84ToUZtUentUsrKtNbPTnkRNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psN6dlF9p3UOq+uEOFNPvumUu6Wb68guWV3Y4uU6g5l/1dld6UUXq4OT7t7AM+Q+RU1WaTrxU/1fFH9Bbk68PceHHG0uiN3xM7FGDApD4qHHt0CR57qvc/BTycGUfsR2d+XVA27NAwn+JIXCxQnIoHYErZbWOTBDut48Lwrtzck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yx4fMni1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m+yaHYc695suSGR2lx4a68Xx0sDS+gochYBAKxQhhNs=; b=yx4fMni16TAuPVuNgb0PR/CNMy
	ZaPuyvfMxNy16N9QtfuueN2iYhugFZtdZ3o9T4sSVH5eoaU8PFct7K28uUWdETXrFLkvpIfrhpdDx
	FMOWfYINyYsIVlXXjvDRF37zoKdwEuqPDyyKPY0qOtw1esYekbMBrCyMz1O7IpzgDXvI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUEuC-006Khz-3x; Mon, 29 Jan 2024 00:49:40 +0100
Date: Mon, 29 Jan 2024 00:49:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v3 4/5] net: phy: qcom: move additional
 functions to shared library
Message-ID: <669a5c03-74a3-4ffc-a530-9031b04b888c@lunn.ch>
References: <20240128120451.31219-1-ansuelsmth@gmail.com>
 <20240128120451.31219-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128120451.31219-5-ansuelsmth@gmail.com>

On Sun, Jan 28, 2024 at 01:04:25PM +0100, Christian Marangi wrote:
> Move additional functions to shared library in preparation for qca808x
> PHY Family to be detached from at803x driver.
> 
> Only the shared defines are moved to the shared qcom.h header.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

