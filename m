Return-Path: <linux-kernel+bounces-128499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63626895BAE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9039B1C2222F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2348915B0E2;
	Tue,  2 Apr 2024 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GFp57npU"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F7A15AD8C;
	Tue,  2 Apr 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082319; cv=pass; b=KN7Uc4t+PXA9erYZS8yCcJjUO0SAVnyinXNc/I77SZvPweoyOgbiuwu3m24HnvgiDYJxElLIAipYfsUmpw2kmztlm5r3/2Bsx7+9hZ5zRzaqF0wH1sVZy+EFlXAI8MCfIUFUymiZdIZn0Rh9vt2ooQJNpNgx6q7oTEbSW/s50cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082319; c=relaxed/simple;
	bh=zLP5HGy7Eo8mQWxAiJSxR+5ytMdTAxmWJ9FAh8+ef9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1vUTXhX42gf8HdEYGkDNYK1WOKBvXWtVvgYp+BIsnmw/NbMAKj2ldWPx4IhbWOOyIMwy50chJGF3dqFunWzf5cxdlCgps1akq0QEjamsyFyWQjiJbu44I+hKf6MQa+sz8PGLL4rmlJTLvh1gc1Unp7dSf37Ic495ql7FrVoloQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GFp57npU; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-140-31-nat.elisa-mobile.fi [85.76.140.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V8GWs5jhNz101C;
	Tue,  2 Apr 2024 21:25:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712082314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3xbDHOLUh31Rvr0RX6usuhXdocLcppeNwZwP3eZpvE=;
	b=GFp57npUZ4TtbvwjUMuO1v8q2BUytoXmoXjUDKCawofJb4C79Y8TCdGmmJWgW/txBCyYL7
	3Hyx2BeKiZaQewG5AzKyix49tdOkB6pjVTIj/PSMBaXgPwKDC6Ir7a0cy5rbxT93IyRw3h
	HiREkaRCkDmjd/b/C81ZngCQAitElz0=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712082314; a=rsa-sha256; cv=none;
	b=ecVGnRlbvAh0/NjlKysFHtI/KIK09KYu4bX5WiH/gRrV7F1I3VfcVmgyoTpcDXGshWpteN
	YtlKYRmWrBDDOsLjz0oIQr4xHPXe8MELq4O0fVrUUA8+8nXY+pPMD/m+s7O8VbKAZq6bj9
	pdaXXW6P02k+NsofVxarXA4G10qQASM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712082314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3xbDHOLUh31Rvr0RX6usuhXdocLcppeNwZwP3eZpvE=;
	b=xWTPLttcBKHc0cuPipsbWwbmNuukzpK5hg/WLK5fPPK8d1JrTXoLK2mDrxiExbRowWYZ5y
	E9SBTlVewUfCtOHLkrSJVA91zmNl4gZnZbqkh8NJBVbnhGMMgBRpV1uu+Ku36BoJR5AeKy
	ltIeF68SA/WWowzGUnR2gEIB+cSn4Kg=
Date: Tue, 2 Apr 2024 21:25:11 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Waiman Long <longman@redhat.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	will@kernel.org, boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
	Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: Re: [PATCH v2] locking/rwsem: Disable preemption while trying for
 rwsem lock
Message-ID: <20240402182511.GD91663@darkstar.musicnaut.iki.fi>
References: <1662661467-24203-1-git-send-email-quic_mojha@quicinc.com>
 <20240305110402.GA72649@darkstar.musicnaut.iki.fi>
 <b92644e5-529b-4403-aba7-d316262cc8ac@redhat.com>
 <20240402173032.GC91663@darkstar.musicnaut.iki.fi>
 <2024040242-babbling-dreamy-6336@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024040242-babbling-dreamy-6336@gregkh>

Hi,

On Tue, Apr 02, 2024 at 07:42:03PM +0200, Greg KH wrote:
> On Tue, Apr 02, 2024 at 08:30:32PM +0300, Aaro Koskinen wrote:
> > Stable team,
> > 
> > Please cherry-pick this patch into v5.15 stable:
> > 
> > 	locking/rwsem: Disable preemption while trying for rwsem lock
> > 
> > 	commit 48dfb5d2560d36fb16c7d430c229d1604ea7d185
> > 
> > It fixes the following bug present in v5.15:
> > 
> > > > > From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> > > > > We observe RT task is hogging CPU when trying to acquire rwsem lock
> > > > > which was acquired by a kworker task but before the rwsem owner was set.
> > > > > 
> > > > > Here is the scenario:
> > > > > 1. CFS task (affined to a particular CPU) takes rwsem lock.
> > > > > 
> > > > > 2. CFS task gets preempted by a RT task before setting owner.
> > > > > 
> > > > > 3. RT task (FIFO) is trying to acquire the lock, but spinning until
> > > > > RT throttling happens for the lock as the lock was taken by CFS task.
> > 
> > If the RT throttling is disabled, the RT task will remain looping forever
> > in the kernel. If the system is UP, it will lock up completely.
> > 
> > The issue can be easily reproduced by running RT task and normal task which
> > are affined to the same CPU core.
> 
> Does this only affect the -rt patchset, or is this an issue with a
> "clean" kernel release?

It's with a normal "clean" kernel.

A.

