Return-Path: <linux-kernel+bounces-84610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74986A8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE811F26E32
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C42561A;
	Wed, 28 Feb 2024 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="D62rkL/Z"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A08425603;
	Wed, 28 Feb 2024 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105474; cv=none; b=kh4zj6XWQWL9sZOfLZWtp5D8482G1963jKf7aaAn7CVuckCqf1Ftx+IEV2fBC8rWX71URCqiiRXbTABoUFNi9cc3N0DDAs2v/8E2AAFS5J8g1T3TAeWdI2jMJw0jqsv/oKj4KBPqkSkQjgFDlcsfgNhie14QLmPws1MSsL5Jz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105474; c=relaxed/simple;
	bh=bAhqk/05b8Deh/CrIzHszwgDXByXMAhoAe9aJbpdWe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrZkI+gxQyzNob9O6D+A83KCa5s5HK+1lSoYTYCqLNmR8saBlHOBrT/MwFLatkM0L5fu69DnztJfqgiZhjfWZYx+bpZczf5LRUdxm1FEe6iCTutUnQ1SemvfvFlFEHgB1Wh/gSPWzXa9Ihtp1OosRUWKaKXPtOx2FLUufVC9+ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=D62rkL/Z; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id D5C0C60429;
	Wed, 28 Feb 2024 07:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1709105472;
	bh=bAhqk/05b8Deh/CrIzHszwgDXByXMAhoAe9aJbpdWe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D62rkL/Z5dRMQsFd4AD+bN9vvTKIVlxz5nkOJxPXKVcZdINh8PJNWUdreAgIH3zhm
	 7GuNx+PSZ/kQwEwHxjFqDtb6znK7vb38tl84TYuGh/8CZFDF7iWyEmSZI3/73coF/7
	 3F0NkpoxPIOyx6uF+/5iTMdgpYYLENmyV2vOGhY1Ywn0TIoBpn6/eDip8h0IPYultX
	 b2IxUxucALeyikRs+iL8JDJMPVfy2gn1Klr4rtQjugBmUiXLJYYKsJUNFXWXFoy5Rn
	 80pu3A8fr3YdfpmUzCtYEhWS2JmT6zGqZrBJ3yqqhpZCQIEKn61D7pCaZw3Nh/afZl
	 r6gN4PpTVeytw==
Date: Wed, 28 Feb 2024 09:31:02 +0200
From: Tony Lindgren <tony@atomide.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] bus: ti-sysc: constify the struct device_type usage
Message-ID: <20240228073102.GE52537@atomide.com>
References: <20240219-device_cleanup-ti-sysc-v1-1-13b53177d0a5@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219-device_cleanup-ti-sysc-v1-1-13b53177d0a5@marliere.net>

* Ricardo B. Marliere <ricardo@marliere.net> [240219 14:09]:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the
> sysc_device_type variable to be a constant structure as well, placing it
> into read-only memory which can not be modified at runtime.

Thanks applying into omap-for-v6.9/ti-sysc.

Tony

