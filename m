Return-Path: <linux-kernel+bounces-94795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9321D874553
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58E11C21D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC7B46AF;
	Thu,  7 Mar 2024 00:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="IyY8G5K9"
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5231C2D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709772712; cv=none; b=ntOTjkNC/0GcIDtGerWSagpXOeYJLEo8wAjCqtATTWqSwmfWRDuLr7aYEnlFa9uxJ1nb45CvS0SawJ3kkFZmsKJ/EPOvdIGuIPj45XJfkAftFb6RnzdB5Wup9yq1rBV7BL993/AYKHZEVyqGb1/gC3cPsPs7MK/pTFitktKg7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709772712; c=relaxed/simple;
	bh=98Yqbd2Wkh4I4wi98kaFvAWL9EqEsWOXtRJLenp0Yfw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLEzd+G2RID0DxUMANJU3Bg8Dww3mV9cAnGdZFAv+k/PIF4LlUSWZx6LdSZUNqgFawtEctg0YFYGUy83+boCkUGucCdL1obX96J5kquYldsPf2pgRjiHmxd8m2ct0lqetvWiY3j4hEISamwAGisdDThKVVVdOJ9WRlIm+ZnT1qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=IyY8G5K9; arc=none smtp.client-ip=203.205.251.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709772400;
	bh=uRsiBh41eR5/aRW2EM611Fer1G2Jrc6sG+c+CAIrrDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IyY8G5K9ewWfXTINyYLOONbeXUan9uwexYwk2F66tvzheJC8W6S2QMo6BDsX6VCVb
	 9tsmcCNR9BALMGR8+PAOI/UWaRz0YCz11n+gT/yafPMVhUeYdJKcZzBK8fhuZnjZSx
	 WXdebWNjK1yfrvWtJLx9Km/9cRiJvIMe4xpq/RdM=
Received: from localhost ([2409:895a:da03:3c6e:2868:6191:8e02:86e5])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id BA622026; Thu, 07 Mar 2024 08:46:38 +0800
X-QQ-mid: xmsmtpt1709772398tvx0jauuw
Message-ID: <tencent_D464912F65C02D326F594D667FDDC234EB06@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaLSbUu2PkHB1cleGyXUBndN7HqWcwDHwRCtrR3bjcEkMpHS3tsb
	 e7LpuThtPwtuH5Ndw2Jkj7Z147BgMAZ0NJ9MlHgSMeaPJOn5a6hbi8w1PhTSPouK0Q3I+xYee7Hp
	 dI4N8KJqYqHJeIridWclluNar42fQda1Ko+kCjp33MXHAreM6QUs/PMRkCCiqk9RM+6mNzXYqDaQ
	 6mYpycTjPO0e0ZVbLs9iuLYLDA9DbyYIl1911e1kP1fFxR895e+DxqE1g1FcLNeVOa77ZxyphPe0
	 qJafQ29hecX55aHyLlZHXjjr/GUm1JEWMMU6RqjynIVk2W5YMJv7Dg8UB2tamTak1quX0kdbLn/m
	 NWjkWN7MQyX08YM+EEmYFw95/Lco3PwCcZZDZtQmBpSGAJx1Y9HN+rj5XuMtvnsDKiHlqBKn+J4I
	 27Yzj5pCPPZxzItRZ9EL8cz/SM0+i5JVmnP1Luwjc8QWFyl6OXwMVmLam6ncitkUipaOqwA8GUfe
	 6yLtQMUqYbwb662vTRPuLXNNvMHYulMJVWKWpMob1d55/Tq3sK9Cx16SfVtd3kAmCd9ftkUgL6s2
	 +5qZCAbGDlvaG+TXupv8SNVCFBu9Fchu4iS2/Y2rN9ghOsA0t5Nn7SIeEw0jPgf0y23OuCp/MqDB
	 i/zfRLGEGo046pq1bVDQVtIEkSGHVWjx61peOONFvzku3E0y6XdXmfO3KXHrKjTCQcdUC0B3jEDb
	 wA3Snq12KgpyGH1x5sHjitFjCQk51nLnACrpjN3r8eG2ndHu1ueD1paBnSde6JGnl7X/A/+KL4jW
	 4x2AF3gErj3+1jKKBRafr1fkPIm84xoXgzyNRQ9C0WPo+cJ7QBupWzJsi7zFfVRIUd1HrOqrzH6Q
	 GP4ACDPr5uQS702M8DARHG9H+ZqlmQIAHJoekfu4Ard6b87VKz9raJmJ2wXhMeUIdkIbu+8ZF6jy
	 apdIyKB/em9Jm9d9RGXQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
Sender: kenneth-lee-2012@foxmail.com
Date: Thu, 7 Mar 2024 08:45:32 +0800
From: Kenneth-Lee-2012@foxmail.com
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
X-OQ-MSGID: <20240307004532.pvatpxz4zjg6fyja@kllt01>
References: <tencent_C5266B7D6F024A916BCA7833FDEA94A74309@qq.com>
 <Zedd18wiAkK68Lzr@andrea>
 <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>
 <ZeipiSVLR01jmM6b@andrea>
 <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZejC+lutRuwXQrMz@andrea>

On Wed, Mar 06, 2024 at 08:24:42PM +0100, Andrea Parri wrote:
> Date: Wed, 6 Mar 2024 20:24:42 +0100
> From: Andrea Parri <parri.andrea@gmail.com>
> To: Alan Stern <stern@rowland.harvard.edu>
> Cc: Kenneth-Lee-2012@foxmail.com, linux-kernel@vger.kernel.org,
>  paulmck@kernel.org
> Subject: Re: Question about PB rule of LKMM
> 
> > Later on, the file includes this paragraph, which answers the question 
> > you were asking:
> > 
> > ---------------------------------------------------------------------
> > The existence of a pb link from E to F implies that E must execute
> > before F.  To see why, suppose that F executed first.  Then W would
> > have propagated to E's CPU before E executed.  If E was a store, the
> > memory subsystem would then be forced to make E come after W in the
> > coherence order, contradicting the fact that E ->coe W.  If E was a
> > load, the memory subsystem would then be forced to satisfy E's read
> > request with the value stored by W or an even later store,
> > contradicting the fact that E ->fre W.
> > ---------------------------------------------------------------------
> 
> TBF, that just explains (not F ->xb E), or I guess that was the origin
> of the question.

Yes. I thought a link was just an unconditional pattern for the
programmer to match the actual code so the other categories (of links in
the same acyclic rule) cannot route back. But now I understand the ->xx*
relation in the begining or end of the link can also add xx to the rule.

> 
>   Andrea

-- 
			-Kenneth Lee


