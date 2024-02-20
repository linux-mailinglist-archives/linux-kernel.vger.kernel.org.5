Return-Path: <linux-kernel+bounces-73126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C39985BDEC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC41AB234D1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6379B6A8D6;
	Tue, 20 Feb 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rlAwWPTE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20D36A352;
	Tue, 20 Feb 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437412; cv=none; b=crdMlLzfaFvO/2UtrON5F5uM/HwNv6QeZJgRrWKLRV0FXW/T4FuoqxLjglYV9N706GusojljGtfEtZP/EjbgpA6ZOsqwFUNUxeWAf+f/+HeGAGUSMXh6qoMmWz3WZKA7DED7wCNaSFsN1l/i47qTlKhoyxMfFKy6odNYYFh99Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437412; c=relaxed/simple;
	bh=E3BCTdyRZN6XYQqN8C6S5Y9dTvLTRGnbQEBo9LCHz84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDfU3vOzxYSt0KNEcYSMoIfBVm7aJA92Qq8lMtY1Xs+pu4Y4hWcwT+97gA2/vFza1qnx1moYIhz7PLScBaVWlA3iWSSZS5gqMqHn6x0jASIH9uQVT1tNj2fpucSyl27ct4D5VxaIlHd65ny4TXpPhwnzbfLuztrwDU3aEWsaw6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rlAwWPTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C1CC433F1;
	Tue, 20 Feb 2024 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708437411;
	bh=E3BCTdyRZN6XYQqN8C6S5Y9dTvLTRGnbQEBo9LCHz84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlAwWPTEX7ehi0B0z/TLouYdO+CGYltqPzHYVNj/fJ5eFG+RAREThXUSbvJuW9UXu
	 u1kL4KGcXJ4CzMjzcD4+gsJujn2Ua5E/sRIlMTn3qxTOd/5u0E1H5QR3JqeL9OTGJt
	 dchdTdXEYsX0Dqx0dsDh9aCGQticJqYAQG8tALZc=
Date: Tue, 20 Feb 2024 14:56:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ray Chi <raychi@google.com>
Cc: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	Thinh.Nguyen@synopsys.com, quic_uaggarwa@quicinc.com,
	albertccwang@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: remove warning during kernel boot
Message-ID: <2024022033-broom-anime-6dd5@gregkh>
References: <20240220081205.135063-1-raychi@google.com>
 <2024022024-trout-kennel-6d14@gregkh>
 <4d62d4d0-3f28-486b-8132-4cc571b6f721@quicinc.com>
 <CAPBYUsD=3ux8RXgRcroVsmpqNs0D+2NeLhqPHh3TBB_oq=ziXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPBYUsD=3ux8RXgRcroVsmpqNs0D+2NeLhqPHh3TBB_oq=ziXA@mail.gmail.com>

On Tue, Feb 20, 2024 at 05:42:56PM +0800, Ray Chi wrote:
> Hi Krishna,
> 
> I verified the Thinh's patch and the warning could be
> fixed. Thanks for the information.

Can you provide a tested-by for that one?

And please do not top post :(

thanks,

greg k-h

