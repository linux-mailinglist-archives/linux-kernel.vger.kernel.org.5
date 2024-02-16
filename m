Return-Path: <linux-kernel+bounces-69047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E0B8583C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C092844C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F493132493;
	Fri, 16 Feb 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON1alLpW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D840131E52;
	Fri, 16 Feb 2024 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103516; cv=none; b=gfCWeiPMZ/qR8C5xrlGcW42DlT5s33TeEWkTErbRrGGRGTFU4NJHv9OVQ5m4U55jF4N06mgfsjSAYHXjdfJi931iZbRX7gv5iWYqfe3yvsU+j1KBCMKK5cMf/KpYz8bIJJCCaqzagvrn96LSINaYcmZYvrAuFhaqUOFf1GHmiV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103516; c=relaxed/simple;
	bh=YA/Nyoyhx7bhuyZ5awSGZBjpvqQmwwyKXWrJOIuIBWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE3xBEahEszQQq2egDeVsSdKox6zgj0rglj7ekOhVoUmn9iM1VbY914hi4HpcIqPh7NFSINVaywwcTviIOG2ufbi8d0NF09XRAvnii92oWfV1RJmWvKt+xGlAfK/VdOq+mMrZJ3K7RgS+i8it/GLdLnE60gtWcljqDUzvD/+Qxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON1alLpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD82C433C7;
	Fri, 16 Feb 2024 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708103516;
	bh=YA/Nyoyhx7bhuyZ5awSGZBjpvqQmwwyKXWrJOIuIBWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ON1alLpWJzLydjqiInBCLacsObWIPgmYxWJuGf3kbezZmrdPIbpXI3DehMLSG54GC
	 7Xa/63q8h+Jztw03mPO4hNDsZrKS9/GUAofvS05wpJrTKq65wflfRX+7UBK56ok6rC
	 8cKgo6xPPZLpTRHDSxmlqNFDPa0Fu/ChYw9LzsUF4Jr0I0AVhov/fiJ8lr/sXD9NtO
	 GdMJDWiN6imJB108wCamhCoMHpZJNiXVHgzjbL3YRmG4mIr+pXFP4xEDFJNLdZFF7l
	 6aRCfXUA8wgCyMeMN7y2Pb9xXy1FrjQEDQs7Rt3waiU140FsN5FnSJd+hYjVCmkjVR
	 OJxaUC8rjle8g==
Date: Fri, 16 Feb 2024 17:11:52 +0000
From: Simon Horman <horms@kernel.org>
To: Imran Khan <imran.f.khan@oracle.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] connector/cn_proc: make comm length as TASK_COMM_LEN.
Message-ID: <20240216171152.GO40273@kernel.org>
References: <20240209121046.1192739-1-imran.f.khan@oracle.com>
 <20240209075032.1deb447a@kernel.org>
 <890de365-f844-4ed9-af9d-90f5ff4bccbd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890de365-f844-4ed9-af9d-90f5ff4bccbd@oracle.com>

On Sat, Feb 10, 2024 at 10:19:24AM +1100, Imran Khan wrote:
> 
> Hello Jakub,
> On 10/2/2024 2:50 am, Jakub Kicinski wrote:
> > On Fri,  9 Feb 2024 23:10:46 +1100 Imran Khan wrote:
> >> Since comm_proc_event::comm contains a task_struct::comm,
> >> make its size same as TASK_COMM_LEN and avoid magic number
> >> in buffer size.
> > 
> > missed CCing netdev?
> Thanks for getting back on this. Actually get_maintainer.pl for cn_proc.h was
> not showing any maintainers, so I took the "To" list from cn_proc.c.
> For CCing I stuck with what get_maintainer.pl was showing.
> I have added netdev in CC now.

Thanks Imran,

please consider submitting a patch to add cn_proc.h (x2?) to MAINTAINERS.

