Return-Path: <linux-kernel+bounces-137203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7887389DEC7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2565C1F2D8D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C541353E3;
	Tue,  9 Apr 2024 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ejUTFtJ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B39132471;
	Tue,  9 Apr 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675970; cv=none; b=bVb53Dkg/SoemV+9R6fXoCqcByG8bJrtr2XLw4dNC/pE+ch47M4bq7H3PyCySOb3jxtYy76Fp/IdVr98dOx+SEeIkNQTtnofgzoy+zo56TCZJg7B5AhlTNRzihb7UGs0MajGEceiYChMyhYKHDWKrq/JTl9wtvM5tnWWL0asMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675970; c=relaxed/simple;
	bh=qa4rli8S2cx06P+slXxB/kOqeXSUVhNJc+VYYce+NQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF5TqeK/5OlDYHM7P3OO3mHQOM7arBs35iEfz1Q/xiSUbH0xqUicCQY2tUHJbiprLJPmZ1t71I7O8h0IkAXZlZJHhLkGjQdpaDgU6/ewczOQovUdm1ilfT2kWYojusHLbZW76YblxQmi4ZExffZNpWB+7Ope9fzDEEQZEUmUhY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ejUTFtJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64713C43390;
	Tue,  9 Apr 2024 15:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712675969;
	bh=qa4rli8S2cx06P+slXxB/kOqeXSUVhNJc+VYYce+NQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejUTFtJ0fc9EfF2toX//oGWQs/GwTwR9n+S2NnT7st8k62J7XuRG/nAqCBJ6cRhLB
	 iyvrrvspq7wNnk1naCosc0sy9OplKz3i3jfr0hXh4iTeHKkgBvDRVFy6UQoIP7mh5h
	 oydk9jPHD0wVRaNIXRQ0dNYF3Ci/3gzuSuAHMQN4=
Date: Tue, 9 Apr 2024 17:19:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Thinh.Nguyen@synopsys.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] usb/dwc3: replace of_node_put with __free
Message-ID: <2024040953-blade-entryway-5091@gregkh>
References: <20240406024838.537630-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406024838.537630-1-andrewjballance@gmail.com>

On Fri, Apr 05, 2024 at 09:48:38PM -0500, Andrew Ballance wrote:
> this relaces instances of of_node_put with __free(device_node)
> in drivers/usb/dwc3/core.c

Why?  You need to always describe _why_ you do something, not _what_ you
do.

thanks,

greg k-h

