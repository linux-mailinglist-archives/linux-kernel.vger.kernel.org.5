Return-Path: <linux-kernel+bounces-155679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0FE8AF58B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50ABE1C22E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C03413DDC6;
	Tue, 23 Apr 2024 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="DBPJ/FxH";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="bi2wmK5d"
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [46.30.211.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED8C13DDA5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893626; cv=none; b=tU/89EQxUlRAOqGnYTTF6I2L9zrgZ6MXNWqXlCeMPFw0SoBQFZsac5VcStzyzDI8nrL6WdiokCnWNmjs/LwrwRo6QZvrazvXWHsjWMmwI929rH2Ia21cSD/DOhkQv7BoTXqgRTD1s4XZjA/iV/QVi3U17Khl/2Uu3S5GRQLHt/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893626; c=relaxed/simple;
	bh=9pjnF/sPtJO+LvWkr3X+fDnCjrIy+zY6WcPdCHL1znE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqIDwYd1UkEtIVTWvvMDWmDxFivYf+H1qsdZwp+ilHyhLmFn02S8eOGlYTEyGi+lk75HVhub4o4uI6sRAoJ8tzzSVaI+7qKrH7i78xKJ+M+7L8CKbMZTJg8RT+f88gLmvhqtuQoRkgMHiGY3x3zSX0QUZV/7ncnzW+/HpDyZ++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=DBPJ/FxH; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=bi2wmK5d; arc=none smtp.client-ip=46.30.211.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=nmviYWlePXoCTNoL8uSMyNJyymgrWXMrhVfEOl91VNk=;
	b=DBPJ/FxHGN7LZz/lQwGoM3czNIekdth+G6EpzOp8tp6+noiZ1JDunl/AZQW7XV0eHttKF+SQ5KrTJ
	 aXiOIMguZw0fr3MzVsuwLXsq/zl0NDBXwOE8vfGgEf8jGwCWIiBrwWvE20UbAh6gKAf1DzVaCGniMM
	 RoaRifInqY8ER1RRMYCrOugAelCILEK0c/zCiloA+WWfRY+BkcM+2pJmw3WfOfDIHz16vKGWZSnuVk
	 WbwoAfcNLygUX4u22pIpm48+aZIcqIFaJZs164rK0+uGsZlJnzf4hA/0YtRtXLWlVZDZbO+Z/1dvgu
	 CIm7mHiAPfEFFXzHGKk9bG7Qx3LwP+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=nmviYWlePXoCTNoL8uSMyNJyymgrWXMrhVfEOl91VNk=;
	b=bi2wmK5dXvsDnj398Vd8zkDcpaiRqWPqOj8Zhffn+JtA+0KH+m+aT8DHmqeODIcPCHT8snKI3ZSSx
	 jtWIS4+Dw==
X-HalOne-ID: 73280bfb-0197-11ef-867a-f528319a6ef4
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 73280bfb-0197-11ef-867a-f528319a6ef4;
	Tue, 23 Apr 2024 17:32:35 +0000 (UTC)
Date: Tue, 23 Apr 2024 19:32:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] sparc/init: Remove on-stack cpumask var
Message-ID: <20240423173226.GB903763@ravnborg.org>
References: <20240423083043.3735921-1-dawei.li@shingroup.cn>
 <20240423083043.3735921-6-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423083043.3735921-6-dawei.li@shingroup.cn>

Hi Dawei.

On Tue, Apr 23, 2024 at 04:30:42PM +0800, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> Since the cpumask var resides in __init function, which means it's free
> of any concurrenct access, it can be safely marked with static to get
> rid of allocation on stack.
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>

I am not convinced this patch is the right approach, and I am not sure
it is worth trying to fix it.
This patch adds complexity, where the other patches simplified code.
I recommend to drop this, we can re-visit if this turns out to be a real
problem.

	Sam

