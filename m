Return-Path: <linux-kernel+bounces-40035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3958783D936
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69EF28DBEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FE91427E;
	Fri, 26 Jan 2024 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7KXsdJl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116E101DE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268060; cv=none; b=gzYGKb3Edm1qag8p1w4AN99GsXeFkQxsSzX97EDlP3xlTYiUVPgsvUii1QxHG4G0FO0baUutVdYqFgpdtmDhZTvtHHJFJbtAkX+P93yEFqb468MHPCbqdv5+0g7f8fuhyNtQJA6ZT+M/7iNTYKc+5L+8JZ/Yv1hn8fAw1nxscVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268060; c=relaxed/simple;
	bh=YtoISk5aCRteP2uoLibHHtWzyEFd/HJziJP7lH/+VOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCqf30y/K71kKwYvuKh75nDZmUUlx2VrvcVf/v/oOWPEA/ANzDL65mCYrnOoggusNVNI9AL7nBkDx1McoV2+vCVyYoL60QnlykkiSHM8Ke4yYnajt+v2ZF9Y2n8P/foNehYMcYqMCtd/154BifDWuVNuMBmH39WX/+cmx7mlzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7KXsdJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0729C433C7;
	Fri, 26 Jan 2024 11:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706268059;
	bh=YtoISk5aCRteP2uoLibHHtWzyEFd/HJziJP7lH/+VOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7KXsdJln7fa5tUcZpiTIQtM6qBy/x36BnLYjnQBmX9BnZvRzKhn19DD5FNRxC9Fe
	 eF7Cu9R+VPoQ0j78RXENTbwfqh4Dg4KG5w5GEs84xZo+nwU4XTnzuEavgJcB4NLMZG
	 oBnxpF9771iMY9GiPDVZAM9zk113kdNONvh0ce3q1A5piS1OXR85PKy2rDglvmw2YW
	 ROTz1WE4EobnFzJepjDu0LuwOUyCZJD9HkomYMGtOtP+/wWLqJmoRGSdXu8uyp1pgV
	 w2p/yww9C7/t0r4pr/GwJLd5oVU5B+X89ND1vbAszLKkVnrjlxcMacfwOStELzcygt
	 lY2e8qvGuO+3w==
Date: Fri, 26 Jan 2024 11:19:25 +0000
From: Simon Horman <horms@kernel.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] kexec: Remove duplicated include in crash_reserve.c
Message-ID: <20240126111925.GD253507@kernel.org>
References: <20240126004449.118407-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126004449.118407-1-yang.lee@linux.alibaba.com>

On Fri, Jan 26, 2024 at 08:44:49AM +0800, Yang Li wrote:
> The header files kexec.h is included twice in crash_reserve.c,
> so one inclusion can be removed.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>


