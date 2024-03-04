Return-Path: <linux-kernel+bounces-90766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8C18704A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2B91F21DCC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F1747F51;
	Mon,  4 Mar 2024 14:59:06 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9C50147781
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564345; cv=none; b=DdwDQUS+ucOh5zTlNtPRNz+wmZcrKe7fInej6ftRfK9wjXbb4gyMR7Fz7PdoAexJzLSXCyPrbXPCnvDjCeCzzo26ovtVkHIHnztJ423JLjrzJsdQNHu5Go82VjnOebtV/oGPPjqYNdrg4Z9Wi2e9zdbBspUs1HqJSIcI5ziilbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564345; c=relaxed/simple;
	bh=CEVJTvZMpHOkYg+nGBcfcqSN0V25NksUunP3f5onNj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nc56MvPxU43o3urbPtx33BfrEc4Sx8Pk+tUTD/or/RzpNOApWuZRzLJNQLje+71jMDmJLGYS2XTO85YJ7useTJzxYvyq4R9T6N61+wQDW0bdbCNT05x8kQo4IebhgRMC1QBQ8ESzDKJdFGmDAwmrxtqqmfyjcbTz0uv/Kpfxfs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 122693 invoked by uid 1000); 4 Mar 2024 09:59:02 -0500
Date: Mon, 4 Mar 2024 09:59:02 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
  "xrivendell7@gmail.com" <xrivendell7@gmail.com>,
  Greg KH <gregkh@linuxfoundation.org>, hgajjar@de.adit-jv.com,
  quic_ugoswami@quicinc.com, stanley_chang@realtek.com,
  heikki.krogerus@linux.intel.com
Subject: Re: [Bug] INFO: task hung in hub_activate
Message-ID: <a9f7b830-da5b-46d5-bc68-61b362a4e87f@rowland.harvard.edu>
References: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>

On Mon, Mar 04, 2024 at 08:10:02PM +0800, Sam Sun wrote:
> Dear developers and maintainers,
> 
> We encountered a task hung in function hub_activate(). It was reported
> before by Syzbot several years ago
> (https://groups.google.com/g/syzkaller-lts-bugs/c/_komEgHj03Y/m/rbcVKyLXBwAJ),
> but no repro at that time. We have a C repro this time and kernel
> config is attached to this email. The bug report is listed below.

> If you have any questions, please contact us.

Can you give a pointer to the part of the kernel log that precedes the
bug portion?

Alan Stern

