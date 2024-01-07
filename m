Return-Path: <linux-kernel+bounces-18964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249008265CA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4591F212FC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5914C11197;
	Sun,  7 Jan 2024 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="5/zHpgcH";
	dkim=permerror (0-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="nF2yXHd2";
	dkim=pass (2048-bit key) header.d=nerdbynature.de header.i=@nerdbynature.de header.b="fQAHzeaR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D210A2A;
	Sun,  7 Jan 2024 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nerdbynature.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nerdbynature.de
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1704655636; h=date : from : to : cc : subject : in-reply-to :
 message-id : references : mime-version : content-type : from;
 bh=BvIoYb/Fn5HQPIN8rIurDtiMGDlWrRB9nG1WDbCuGZ8=;
 b=5/zHpgcHmNmU4ARFrdNiIbEBaMdr2LKfIMwQ/YnTCR4Yw6LNoneY4R6ZQ3RWF3fPsKG5y
 e5xZDHMrbwRLb5pAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nerdbynature.de;
	s=dkim; t=1704655636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmQJjEhWMY+tYzgMK5HnZv6TWvOnuPe8JnejlKdQzqU=;
	b=nF2yXHd2EIy7JsJdxgMDTiXl7PAlF9Rz0f5vnWKIxk7eo3P1tHkr6rg7zy4v+3FbMOA3nk
	VrcDHSDigm9+vLBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1704655636; h=date : from :
 to : cc : subject : in-reply-to : message-id : references :
 mime-version : content-type : from;
 bh=BvIoYb/Fn5HQPIN8rIurDtiMGDlWrRB9nG1WDbCuGZ8=;
 b=fQAHzeaR9TdD0eU4cy0QQwcGqQlm0W8s3DGhE2/Ixnl3K7f2LufEOZzeGtFYbhhak86IL
 aH5E0hzUx7TzLzunDzmQRLazzPd3+OVubewyeTcSQIF4yCyHnOFKNkFY8x61HnKECbGScRZ
 Pf4Ow/ITcBIsZJa9KOv4Dbuk58wlI/B8dkVO7BH29mA+VjLgFTY4Rhr4dQTievtJRnUku6O
 PqCIk5bQB9k3tXMtzaCGHgeWTyiwX7h1PTUzHm33fpQBw6hUJw0kQhYp2U12m1OTNbawVxM
 uHQ1+ssk1cDfqNNC6Az1sP+fS26pGAqqEWEAwNJ9hiwg3DthawnMy8fjnzwA==
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id 389755FFAF;
	Sun,  7 Jan 2024 20:27:16 +0100 (CET)
Date: Sun, 7 Jan 2024 20:27:16 +0100 (CET)
From: Christian Kujau <lists@nerdbynature.de>
To: Dmitry Safonov <dima@arista.com>
cc: netdev@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, 
    Francesco Ruggeri <fruggeri@arista.com>, 
    Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>, 
    linux-kernel@vger.kernel.org
Subject: Re: syslog spam: TCP segment has incorrect auth options set
In-Reply-To: <491b1b19-f719-1aa6-7757-ba4168228bbd@nerdbynature.de>
Message-ID: <65ad94ae-36a9-f128-ea45-26772772ba31@nerdbynature.de>
References: <f6b59324-1417-566f-a976-ff2402718a8d@nerdbynature.de> <fe1752a6-9866-45e6-b011-92a242304fce@arista.com> <491b1b19-f719-1aa6-7757-ba4168228bbd@nerdbynature.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

On Thu, 4 Jan 2024, Christian Kujau wrote:
> On Thu, 4 Jan 2024, Dmitry Safonov wrote:
> > Yeah, I guess it's possible to down the severity of these logs, but may
> > be unexpected by admins: TCP-MD5 messages existed for long time and
> > there may be userspace that expects them (i.e. in arista there are tests
> > that look for these specific messages - those would be easy to fix, but
> > there may be others outside this company).
> 
> Understood, thanks for explaining that.
> 
> > While thinking on the origin of your issue, it seems that the logs
> > produced by either TCP-MD5 or TCP-AO are desired by a user when they
> > add/use the authentication. Could you try this and see if that solves
> > the issue for you?
> 
> Thanks for preparing that patch so quickly, did not expect that :-)
> 
> I've applied this on top of 6.7.0-rc8 and will report back if I see those 
> messages again in the next days.

No messages so far, great!

Tested-by: Christian Kujau <lists@nerdbynature.de>

Thanks again for fixing this so quickly,
Christian.
-- 
BOFH excuse #323:

Your processor has processed too many instructions.  Turn it off immediately, do not type any commands!!

