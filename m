Return-Path: <linux-kernel+bounces-144852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE52E8A4BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846AC1F22B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C877A4E1DB;
	Mon, 15 Apr 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I2DeG4QO"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49174D9FF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174300; cv=none; b=L7N6wlwsDo6OQ3S4BGFxbbArp/vHUxRMj/1MV5y6pT51tQCg17FrovRzPX4gQryHFl83ZJEa41FizxyE57PWEx+8JDWaimuiwaSnkRtXn9VIBYj4oyjCwB8+fYLo1XawP78QcIhBmKREVVmWkkS7CzwN4jeSM9p96XixTKnVopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174300; c=relaxed/simple;
	bh=VtwuyubYUYZ4mi1Ujdo1t+RKF4tKBpowGisw1EN28aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNM/Y1TlXLQfXiym/2Eg4j3XKel5TJJykSFiOch16Io8/b2qsyUGJ1LtOi0CQXhrp5ZTEdqngoJBB1PYglsvFRFqDO82YxG76GmBPoFWmdcy/11xKY7yrhGLT7VBTVZrxUxRRZTQDKjiwjw7k9A0krewuqhcPSHF31+AmjhdMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=I2DeG4QO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3dwAMvNpKeQ9PatZlAuEMPbAqrw8p29gML5z9fKjLW4=; b=I2DeG4QOJP6IjEQADh7wSKhTjo
	Y5YVYaMxGCKJTzJMVB2H96z44xgVc+bol/xfbV/wl22KcAYKtX41YnFvNRSFeOVwtu3XBfsbSDEA7
	lUQQhFZ20aiqxcFYYv5EBOeeKucw41NswFlZyrRVCDFZXqczEpxyPwKkVLes/iVoDFmKlaTM+WgDn
	CU3beLRvx2cDdHtoixy9tzmAi0ptBAg6EFfji/pabx9EqiLdQuzZA8rlK0fHcuVF8mgvP9qeyQDVQ
	7mahxUdsejWTTat/6Aq/aErtF8I1JUJhXt1P6kcn3fZerv8+cVnslF1wlAXIi6iq2RNSVHScdRSPN
	O2Cvg27w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42636)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rwItN-0005vm-11;
	Mon, 15 Apr 2024 10:44:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rwItM-00026W-TT; Mon, 15 Apr 2024 10:44:48 +0100
Date: Mon, 15 Apr 2024 10:44:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
Message-ID: <Zhz3EEsnGSOgnYWA@shell.armlinux.org.uk>
References: <0000000000004cf5c205faf1c7f3@google.com>
 <dcf54740-7cc3-4017-ad1b-8626a22fc15e@I-love.SAKURA.ne.jp>
 <Zg1/1xbmrY4yDfhO@shell.armlinux.org.uk>
 <ZhztQ9CvDm3UPgE9@FVFF77S0Q05N>
 <c5a3598d-16dd-4aeb-904e-2084fafef9fe@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a3598d-16dd-4aeb-904e-2084fafef9fe@I-love.SAKURA.ne.jp>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 15, 2024 at 06:38:33PM +0900, Tetsuo Handa wrote:
> On 2024/04/15 18:02, Mark Rutland wrote:
> >   08626a6056aad824 ("arm: Implement thread_struct whitelist for hardened usercopy")
> > 
> > That commit says that all accesses are bounce-buffered and bypass the check,
> > but AFAICT the fpa_set() code hasn't changed since then, so either that was
> > wrong or the user_regset_copyin() code has changed.
> 
> Then, can we go with https://lkml.kernel.org/r/0b49d91b-511f-449e-b7c3-93b2ccce6c49@I-love.SAKURA.ne.jp ?

Have you visited that URL? It doesn't point to an email containing a
patch, so sorry, I don't know what patch you're referring to.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

