Return-Path: <linux-kernel+bounces-71028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF4E859FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20181C211B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938B2376D;
	Mon, 19 Feb 2024 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BIrabAyZ"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCFC224DA;
	Mon, 19 Feb 2024 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334824; cv=none; b=XEdU3hI15gZFiHU4qrUaCCqUE2azB0W939zvbxsBgthECCUirwYgvfj7qtobd5UI2qo2pOECUQYygpQT0LypgVaygUEBjL/7hsGk7p/2JacOeQUP91IksIJqtc0GrUkko6FnTR1MTTO9j+EVtd5aNNKGtjdNwYaK5zeXuhC2a+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334824; c=relaxed/simple;
	bh=pV6OcNifszV+/iw/c/toiIcPwTQmu3XK4ZhLAbXV/s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVWE1WCXGnV+IyGdBtNx2LfIFh+HTy017JbJJW5UjDs4oPn+3nV6mFq7CRNyO2wuWBJFAC4UmdxthTT5Mgl3dYJ6pEV621BpurXmHAfLvrPUuTDyxjsD3Z1NRc57Yt0zOrkvYcamJBQjJnNX3igEoh2Kg3cuE3NnjXIViMti9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BIrabAyZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/LzjvA8uDCXuz1zAKNQ/JIcMEOk4CVtuLJzwpOkdWrY=; b=BIrabAyZ8H2iJoFDb7tlM63h4l
	H76D4cYaNEZF5I8dY23y8rCEtyQ6fr+MXAIsGmyZKHE52skjAw/RurHXN52SfRtkhGmrEA+iw3CzE
	l9qVcW+QMNKoDcVJhrrn/OD/dpslVZkPc3Q/CImSSBN9OFK1vbUpnf4m6Cf98GgUHCJ7560xygNi1
	AbiQSCpfThgGr9XeBqHgUL2SHeV1mXZC4gFFmL0MACVhmvKzuFsIIN767oHljmjXGgtB1nhqpPT9Q
	85WaKiGLU/DN/mEQYQS1QrGUkdqerCnGXLtajv0Rob8cSgbgqFUxmimY90rtM5nFnSQjbGcJJ7YFB
	UtRFz0NQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56090)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rbzvK-0005wJ-01;
	Mon, 19 Feb 2024 09:26:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rbzvH-0008FV-N8; Mon, 19 Feb 2024 09:26:51 +0000
Date: Mon, 19 Feb 2024 09:26:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Calvin Owens <jcalvinowens@gmail.com>,
	Dave Martin <Dave.Martin@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] arm: Silence gcc warnings about arch ABI drift
Message-ID: <ZdMe24xN1Ej4QoVU@shell.armlinux.org.uk>
References: <fe51512baa18e1480ce997fc535813ce6a0b0721.1708286962.git.jcalvinowens@gmail.com>
 <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431dd956-ad31-4da8-ad42-34f7380824bb@app.fastmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 19, 2024 at 07:21:11AM +0100, Arnd Bergmann wrote:
> I think these should be addressed in bcachefs instead.
> While it's not the fault of bcachefs that the calling
> convention changed between gcc versions, have a look at
> the actual structure layout:
> 
> struct bch_val {
>         __u64           __nothing[0];
> };
> struct bpos {
>         /*
>          * Word order matches machine byte order - btree code treats a bpos as a
>          * single large integer, for search/comparison purposes
>          *
>          * Note that wherever a bpos is embedded in another on disk data
>          * structure, it has to be byte swabbed when reading in metadata that
>          * wasn't written in native endian order:
>          */
> #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>         __u32           snapshot;
>         __u64           offset;
>         __u64           inode;
> #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>         __u64           inode;
>         __u64           offset;         /* Points to end of extent - sectors */
>         __u32           snapshot;
> #else
> #error edit for your odd byteorder.
> #endif
> } __packed
> struct bch_backpointer {
>         struct bch_val          v;
>         __u8                    btree_id;
>         __u8                    level;
>         __u8                    data_type;
>         __u64                   bucket_offset:40;
>         __u32                   bucket_len;
>         struct bpos             pos;
> } __packed __aligned(8);
> 
> This is not something that should ever be passed by value
> into a function.

+1 - bcachefs definitely needs fixing. Passing all that as an argument
not only means that it has to be read into registers, but also when
accessing members, it has to be extracted from those registers as well.

Passing that by argument is utterly insane.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

