Return-Path: <linux-kernel+bounces-53800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70384A6B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C821C265B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9F4F8BA;
	Mon,  5 Feb 2024 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QOTe42Mc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859EB482CD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160137; cv=none; b=FH59rX+CLerx4NQ05qOk3WNIoua1XBfov0wrIhTf+/zibzv+E92M7lMAocIPHm30HaSTMlG4ryLwOnbmbjNI9VB2727yjZnAP7iSjxmsVJjDM6Qs57VTbZKpEPy+0cfXe6qTzQE3Kq+uPpcsXf2tnhPqL5t583XBI3goLJ4soJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160137; c=relaxed/simple;
	bh=XuGdf1uD+YN5FIV4dHSkWLQQk9x5OuJaGM/t0B+J/qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rasrNoQy0ChbwP+6A0/05PtcH1No79zqqjvOOF/3yGjcFbNOH1PUiPSjyBTo2qn3Qq9fHTAJF4I7XUH1rXQBvNRB36bHglFWg9rDNlHyVDtUlbpYDql8LxnSQK+ZgeD93f7c1CTJF3wthg/4CGPclb0iWa7/z55s56L8aeWDOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QOTe42Mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA15C433F1;
	Mon,  5 Feb 2024 19:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707160137;
	bh=XuGdf1uD+YN5FIV4dHSkWLQQk9x5OuJaGM/t0B+J/qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOTe42Mcas6DpQK8loE0JQQkPQ9JMGVHFCrlRj7r4AQHEkgtk1eWZ5Fx3LyqDPVWb
	 GCtdGbZXq8ScCRSF28vemGlShcDRwb56GYOCf93U+AZnWb7CiWgWiknhaLe8iePWBe
	 LVaYBN/J43nECNOXlBQcU0T45vZW2OOzn3TAKKZs=
Date: Mon, 5 Feb 2024 19:08:54 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: make w1_bus_type const
Message-ID: <2024020523-vastness-preformed-0cb0@gregkh>
References: <20240204-bus_cleanup-w1-v1-1-a0f4c84d7db3@marliere.net>
 <80d80422-139a-4bfe-9d8b-4ef193e72d8b@linaro.org>
 <hk2w5pow3kqhw3vk5hlgeoy3dntbujb2s2xup2vkivtabwwb2k@do5ud3tj33jj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hk2w5pow3kqhw3vk5hlgeoy3dntbujb2s2xup2vkivtabwwb2k@do5ud3tj33jj>

On Mon, Feb 05, 2024 at 09:08:20AM -0300, Ricardo B. Marliere wrote:
> On  5 Feb 08:34, Krzysztof Kozlowski wrote:
> > On 04/02/2024 21:55, Ricardo B. Marliere wrote:
> > > Now that the driver core can properly handle constant struct bus_type,
> > 
> > Does "Now" means some dependency on other patches?
> 
> Hi Krzysztof!
> 
> Please check:
> https://lore.kernel.org/all/1305850262-9575-5-git-send-email-gregkh@suse.de/

Sorry, no, that is for device_type, not bus_type.  bus_type didn't
become able to be const until 6.4 or so.

thanks,

greg k-h

