Return-Path: <linux-kernel+bounces-151743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C691F8AB346
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB771B21A62
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028231311A5;
	Fri, 19 Apr 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D/i3EPnk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ILQh7zBT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28122AE90;
	Fri, 19 Apr 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543800; cv=none; b=CdA14IM0zvzuOzZOK6u/n0XpHEzLaGsfdLm2SOdKWzLEO0gByeC1HjwEV/Lm0ye9vzGl09Hs9r4uNx7gWv4w+7PiVB6bRA2ejRXC27PLfIGwQH9jtjFwd9Rf+g+1z/3w6XruwK7fI7MkSu3DBBjHR5sYw5TGJH/olpHNhIk8doA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543800; c=relaxed/simple;
	bh=gs9EGPudWMGBtmD8/DHeQQnjltd36kniLLYlUCrdgW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rR2L5BSkXFvGMmIT2O/uEvwwOkV5hGKeDwBEk9/dfNnEvP6WNihfTAx8wllozb99aml/67dZ7d+DWNUfgg9mixQ3lZszCQ334s6puTdIphG47Y8RgT1sdsqgZoOCGb43PzFkfqXTakSXNZQQuzO/QAm+4EiXlaImLE32v+OP1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D/i3EPnk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ILQh7zBT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Apr 2024 18:23:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713543796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tAw1Bq+UGriHq05hD23m4NS+gVnMuksa7pvzwC3RZ4=;
	b=D/i3EPnkCg6QRKwxR6Cz0sCXhVmB2m7VlRYLCxxTP+mDVFTdb6sdiToLQKYB3peonObWAR
	TTA0XpQl8IqVR34mAyc4Yl/RCy8YxcI5QlFVDKrvOjtJBHvH+BZclwv+lH5XxvrMu59EoD
	/DL3qfcnc1WIVmiwFfIg1Vd30g23zKfZVOxuhoeaKeijUo4YaSbLYuka44fnbb48P6MKtu
	6l1cpKQKfX4Eug/4jozh8G5ODjw7npkYR2nsms1pK26jXMJQZuZahxhRD5B2n5FW1Rpy5h
	l0bDQg8Qgr23mE8HXCH9KxVAn9wgKquQth6wqYkO2SRREurAopSJj+36bXQqDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713543796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tAw1Bq+UGriHq05hD23m4NS+gVnMuksa7pvzwC3RZ4=;
	b=ILQh7zBTTk+j3vcZIhpdjyIJ52Lt6bounPhyT23Uynvd4jRKoad2bFNptUSYGrnhqVJt9N
	W0NI1X3XpVbcVDDg==
From: Nam Cao <namcao@linutronix.de>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: jayalk@intworks.biz, Daniel Vetter <daniel@ffwll.ch>, deller@gmx.de,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 tiwai@suse.de, bigeasy@linutronix.de, patrik.r.jakobsson@gmail.com, LKML
 <linux-kernel@vger.kernel.org>, Vegard Nossum <vegard.nossum@oracle.com>,
 George Kennedy <george.kennedy@oracle.com>, Darren Kenny
 <darren.kenny@oracle.com>, chuansheng.liu@intel.com,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [bug-report] task info hung problem in fb_deferred_io_work()
Message-ID: <20240419182313.3f36ac0b@namcao>
In-Reply-To: <796eecdb-f574-4eca-8cb7-ff426505435c@oracle.com>
References: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
	<20240419165915.228c76e9@namcao>
	<796eecdb-f574-4eca-8cb7-ff426505435c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-04-19 Harshit Mogalapalli wrote:
> +CC stable( heads up as this is a regression affecting 5.15.y and 
> probably others, Greg: this was reproducible upstream so reported 
> everything w.r.t upstream code but initially found on 5.15.y)

No worry about this, I will add a "Cc: <stable@vger.kernel.org>" tag
to the patch, and the stable folks (or their scripts) will pick it up.

> This patch works well against the reproducer, this simplified repro and 
> the longer repro which syzkaller generated couldn't trigger any hang 
> with the below patch applied.

Great, thanks! Can I add
	Reported-and-tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
to the patch?

Best regards,
Nam

