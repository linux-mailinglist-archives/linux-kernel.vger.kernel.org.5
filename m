Return-Path: <linux-kernel+bounces-83403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EBD869870
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622CB1F24BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75361420DD;
	Tue, 27 Feb 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SQ+sofI8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7EA143C4B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044295; cv=none; b=Ytle4ZLm8fZ3yDB0zv3eOgRgPvy1LPtcbyW34BZIWlnJxAc06UvwZxjXj56HbtIv32j+cwnCNQnvAgVVMm+PoyD4IUpMToK+4F4z5EmmtQEn+mkzcygzvC0G8ajK4iaWruBn9L1GR+UkQOJjZR+a9AvOjghBhzfIsjJb84f+FGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044295; c=relaxed/simple;
	bh=6TtyQXmfOCcjrgrX6vJpohPZ4bkiKsW5e+66dVrcDi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGlq7GGoRmlnC2TSa1HfisCvv6vHkMS2wL2eWSteBKL31IxB1nkjTCvvXZDwOOmEv/CEsoT0A5FXoSqnNkrjpE/dyiDTz0NWD1WfeRsAzQE97eTN8oRLTpNfbFmGd2T+j1OaJ7UQ7OHJqaUGYPtjRztarpHmiH45kdAf3hWwJVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SQ+sofI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F828C433F1;
	Tue, 27 Feb 2024 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709044295;
	bh=6TtyQXmfOCcjrgrX6vJpohPZ4bkiKsW5e+66dVrcDi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQ+sofI8vk+Ol28Lyx6aHC1GkUWNH+odtpTQW47UKmhjoE4npGhUiX5jiIoi/JZzs
	 l/UhE1huUmrH469/StCeLDaeVTZE9+LnPhk26BiCHxOwKUa1tt4ZCFCctM0tsrgekO
	 sQELxlRNR2PfrNBNRM6tvMK5ckq07MPEW8H4l0es=
Date: Tue, 27 Feb 2024 15:06:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2021-46934: i2c: validate user data in compat ioctl
Message-ID: <2024022720-derived-impish-d245@gregkh>
References: <2024022750-CVE-2021-46934-79c8@gregkh>
 <94330624-1f8b-49b8-8a66-b7adf1f589f4@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94330624-1f8b-49b8-8a66-b7adf1f589f4@suse.de>

On Tue, Feb 27, 2024 at 02:33:50PM +0100, Carlos López wrote:
> Hi,
> 
> On 27/2/24 10:48, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > i2c: validate user data in compat ioctl
> > 
> > Wrong user data may cause warning in i2c_transfer(), ex: zero msgs.
> > Userspace should not be able to trigger warnings, so this patch adds
> > validation checks for user data in compact ioctl to prevent reported
> > warnings
> 
> What's the security impact here exactly?

Userspace should never be able to trigger kernel warnings.

