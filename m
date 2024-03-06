Return-Path: <linux-kernel+bounces-93606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAA287324A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FAD28604D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FED65DF01;
	Wed,  6 Mar 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q27lC3TZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33EB5D91A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716593; cv=none; b=EEA1RTkvgWYPgVE6uNnl6wfWm5TaSmIyKvlknD3dxrpfIgL39oa7w1DqyBuLUjpXf3lgck8olJ3DFmBjv5mmCk7z6tLgpobKiQuqDm/OUYoKiWvxZQicbFK9HZGzbEdY0YjHw2WZSy6ONuMiEFEA9WIA53gCa3sQyrfSbIXGiKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716593; c=relaxed/simple;
	bh=AxT/q9GfqhNnP2P8qI4TfjdaZ0cJ/bFkdt1x4Rv1YwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/uYsaA8CxHCgs1etMAcYWNIBRwWev3iwegAfUXSBf6atX4iQEw5jXwpaeOhy4yjj4gDIh5O1fGNe3p2/1IBEH0zaog4j/5V+p4u0lseVh/lukHOWorjoByygC1gvzzm5TkQFciEr8ur4OiZOQ6X/Q0ubsbM3IPQipLWXmLOAi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q27lC3TZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35FFC433F1;
	Wed,  6 Mar 2024 09:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709716593;
	bh=AxT/q9GfqhNnP2P8qI4TfjdaZ0cJ/bFkdt1x4Rv1YwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q27lC3TZ9eUOVELoitFV2p9rPPsKO/di3aPgsL5ZWfXGDUhL1/wE5aDcGeaso13ax
	 GhaGf0MTbx7L2AJfSOAbuaMMFh61vgcePVPhn1VIa8yj3k3XGgW965Sbd9wMUVLBQ0
	 kmAjdgCTkJvJtk55yozl/kLavdYKAD2uH7pglqEM=
Date: Wed, 6 Mar 2024 09:16:30 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Red Hat Product Security <secalert@redhat.com>
Cc: security@suse.de, rfrohl@suse.de, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: CVE-2023-52572: cifs: Fix UAF in cifs_demultiplex_thread()
Message-ID: <2024030628-skyline-contently-4b85@gregkh>
References: <15436477.7601.1709663408600@app142018.ycg3.service-now.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15436477.7601.1709663408600@app142018.ycg3.service-now.com>

On Tue, Mar 05, 2024 at 10:30:08AM -0800, Red Hat Product Security wrote:
> 
> Hello Robert,
>  Thank you for reaching to Red Hat Product Security.
>  I have reviewed the flaws, CVE-2023-1192 has the correct patch used in the reference.

What do you mean by "reference"?

CVE-2023-1192 points to a patch for a totally different filesystem
(ntfs3).  Will that be fixed?

And please stop responding in HTML format, the mailing lists reject this :(

thanks,

greg k-h

