Return-Path: <linux-kernel+bounces-16887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A02F2824565
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4028EB213A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0845624A15;
	Thu,  4 Jan 2024 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pB2Rqs4C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E46249EB;
	Thu,  4 Jan 2024 15:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614E3C433C8;
	Thu,  4 Jan 2024 15:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704383497;
	bh=1luNWj5cKMiyzoKw4DA98ZYN/31mB1KaR2bRKhzEGLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pB2Rqs4CnP+/FGRuYgVshvaWAV8/BJ8GLT9vsdLORLkd+oqdCjjAAzU1WNVEhzkrp
	 zQSuiH+vKQrQ80aw/gD7VZ7vGYO3ASqjznki3guoupvNZ/kXN1lavTlIRZNPKffAQz
	 pj8kwQ++JIf4qZX+dyBEDxvnXPO9l/mB7hGxXA0U=
Date: Thu, 4 Jan 2024 16:51:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Kosina <jkosina@suse.com>
Cc: benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 1/3] HID: make hid_bus_type const
Message-ID: <2024010431-scanning-devoutly-b603@gregkh>
References: <2023122045-pellet-eggbeater-8d2f@gregkh>
 <nycvar.YFH.7.76.2401021129490.29548@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2401021129490.29548@cbobk.fhfr.pm>

On Tue, Jan 02, 2024 at 11:30:05AM +0100, Jiri Kosina wrote:
> On Wed, 20 Dec 2023, Greg Kroah-Hartman wrote:
> 
> > Now that the driver core can properly handle constant struct bus_type,
> > move the hid_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> 
> I have applied all three patches to hid.git now. Thanks,

Thanks!

