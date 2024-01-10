Return-Path: <linux-kernel+bounces-22025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E4829816
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854721F21AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6EE46BA6;
	Wed, 10 Jan 2024 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gWBSL8iU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FEA41776
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684B4C43390;
	Wed, 10 Jan 2024 10:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704884085;
	bh=D4GZJI/fl4ZLtkVheulpsbnrFlrk6tndzkZ6OL+Rsf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWBSL8iU4Lz93BC9yEERRP7dHEr2iuJaUALtgBjd+rF8s6A+lwjp7RpuZKZqMJUlk
	 uNPhWOVrOzJc1I0gP5kGeyqR93Ls5QI1Dl5mlDp7dl81JCLLAwBu4YpHMhYdlx02ve
	 6EMwEE7yObsm7R88/F4/5o5OsXG+qTKjZ9mGnQao=
Date: Wed, 10 Jan 2024 11:54:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: kovalev@altlinux.org
Cc: bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
	arnd@arndb.de, linux-kernel@vger.kernel.org, nickel@altlinux.org,
	oficerovas@altlinux.org, dutyrok@altlinux.org
Subject: Re: [PATCH 1/1] misc/vmw_vmci: fix filling of the msg and
 msg_payload in dg_info struct
Message-ID: <2024011040-unlaced-yo-yo-ff76@gregkh>
References: <20240110104042.31865-1-kovalev@altlinux.org>
 <20240110104042.31865-2-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110104042.31865-2-kovalev@altlinux.org>

On Wed, Jan 10, 2024 at 01:40:42PM +0300, kovalev@altlinux.org wrote:
> From: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> Fix "detected field-spanning write" of memcpy warning that is issued by
> the tracking mechanism __fortify_memcpy_chk, added 2021-04-20
> (f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time)

Please properly quote commits.

> Fixes: a110b7ebb9c674 ("VMCI: datagram implementation.")

It's not really a bug to be "fixed", right?  It's just a "shut up the
fortify checkers with this false-positive" type of thing.

Again, see the thread I pointed you at for this same discussion.

thanks,

greg k-h

