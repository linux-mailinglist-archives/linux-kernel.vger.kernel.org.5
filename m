Return-Path: <linux-kernel+bounces-130174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A4B8974EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54E228770E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12714E2F9;
	Wed,  3 Apr 2024 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SkQ+dY5f"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583614B073
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160739; cv=none; b=sKYvQwAJzJmBC3cTWFbdVo22APuF3Qaah5e6a8PJTyK9CwaDBMk/7TjIkBJyuRLew1A0X2ibOQQ0Ha6i8GvYWetG2apqtJblDVmg6nBjLxg+sFqI7jYOxrrkUhvd5NTCpxCRN1SrIdA51WZ53h0mkTN3CWVpqKc43DKDXYR0KZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160739; c=relaxed/simple;
	bh=qsyRmOlyTALS7ji80F2+z/3MPYXg6x1pvXiJIJElu34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPMW5BqutHen9nvdNnX4rVCpxKQGC783kCcmpx1SRP85JpOwrSkWx0rTkVUk9nZ80KPlBVh62/NUtLhULQOF4u7SboJXMQgNz1O+2RPeu7af2OUB7JRV5jgI7fw/nV0KxiMFbkKqKlveRDsuLrKnJ4BFtBK57gfjdKe/v7+kKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SkQ+dY5f; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fc4gDAai9j+UWYc45hYpxViIgWITb5osBGXho7qrtHI=; b=SkQ+dY5ftzrf0uRCZdT/BokK+/
	o36GyvaribvslS5SRmOBx7cKS7a1T5FIRzKY2QojVu/I82K7gFOIDEqhL0o2HKLn/ou2KdlqrlcTM
	y82+JAb7I1T2IOjWQ8JYsW72aBIsyzEyQeHy2Z5MniFsGdd/cXLmzH83PlzxjJjUukBey/iXc6xEp
	iaQhvXb/1uu6Ma5JrViy38atJ8lrOAjg3HAwc1AKieBhdwV5qh7w3OLKD+sM1Bek5mo+P7BmPnb0u
	wpnpBKq1HTuVY3wPa600P7tP/zMBDtuJFQbwqkqpiA02suKByZsZzgH1kKqkJeqzHzjC8pTvgtlzR
	V1o4pddg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56948)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rs3Dc-0000Gd-2Y;
	Wed, 03 Apr 2024 17:12:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rs3Db-00084V-Hs; Wed, 03 Apr 2024 17:12:07 +0100
Date: Wed, 3 Apr 2024 17:12:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
	syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
Message-ID: <Zg1/1xbmrY4yDfhO@shell.armlinux.org.uk>
References: <0000000000004cf5c205faf1c7f3@google.com>
 <dcf54740-7cc3-4017-ad1b-8626a22fc15e@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcf54740-7cc3-4017-ad1b-8626a22fc15e@I-love.SAKURA.ne.jp>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 05, 2024 at 08:27:07PM +0900, Tetsuo Handa wrote:
> Hello.
> 
> syzbot is reporting kernel memory overwrite attempt at fpa_set().
> I guessed that the amount to copy from/to should be sizeof(union fp_state)
> than sizeof(struct user_fp), for arch_ptrace(PTRACE_[SG]ETFPREGS) for arm
> is using offset == 0 and size == sizeof(union fp_state). But my guess did not
> solve the issue ( https://syzkaller.appspot.com/x/patch.diff?x=11e46dbc180000 ).

This is silly.

sizeof(struct user_fp) is:

	8 * (
		1 bit for sign1, 15 bits unused => 2 bytes
		1 bit for sign2, 14 bits unused, 1 bit for j => 2 bytes
		31 bits for mantissa1 => 4 bytes
		32 bits for mantissa0 => 4 bytes
	) +
	4 bytes for fpsr
	4 bytes for fpcr
	8 bytes for ftype
	4 bytes for init_flag

This totals 8 * 12 + 4 + 4 + 8 + 4 = 116 bytes or 29 32-bit quantities,
or 29 "unsigned int"s.

This is copied into union fp_state. This union is made up of one of
several different formats depending on the FP being used. user_fp
doesn't reflect this. However, one of these, struct fp_soft_struct,
is specifically sized to ensure that user_fp is _smaller_.

struct fp_soft_struct is 35 unsigned int's. This is 140 bytes. This
is larger than sizeof(user_fp).

Therefore, there is _no way_ for fpa_set() to overwrite anything
outside of thread_info->fpstate, because sizeof(struct user_fp)
is smaller than sizeof(thread->fpstate).

Syzbot appears to be wrong in this instance.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

