Return-Path: <linux-kernel+bounces-19404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DE1826C74
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD22F1C21998
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D775614AA2;
	Mon,  8 Jan 2024 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="I8jTdHBm";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="I8jTdHBm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C4514291
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id BFA30C009; Mon,  8 Jan 2024 12:19:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704712794; bh=f8fz1LwBIALyfM11oRY2m1XNTcJkSMTOVPkbnveA3Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8jTdHBmiAJZYNs4r5kggZ38nHm3BhvicdQrHU/xYfo50jFhI+JMI42vPVvkuEbty
	 16kd6Q9dt58aIKF4BkMQlVJ2O0XD5BwPCIr/rNtYmxHVhn4kHEPSJuwIyyZwZBxq9C
	 4mCsgI6+tNmrJq0mRtG36Wbq1h1582a+uEL3KBLjCamhNVd99XjEPbxjOx6XRuKdfV
	 pZgiK04S0N5idBKKzWPTjvZDZLKmYFE+AvWY44Lne/59rcIFvfiRytRivMufZ0axws
	 qKtTAfxXdeYgPE8WGoNIGbwNIJLwhson8ZLa/ThxD1S0nNJ/Fb+A6zmndv30bSwCLn
	 WxRhYjuteC1Bw==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 1ABCEC009;
	Mon,  8 Jan 2024 12:19:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704712794; bh=f8fz1LwBIALyfM11oRY2m1XNTcJkSMTOVPkbnveA3Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8jTdHBmiAJZYNs4r5kggZ38nHm3BhvicdQrHU/xYfo50jFhI+JMI42vPVvkuEbty
	 16kd6Q9dt58aIKF4BkMQlVJ2O0XD5BwPCIr/rNtYmxHVhn4kHEPSJuwIyyZwZBxq9C
	 4mCsgI6+tNmrJq0mRtG36Wbq1h1582a+uEL3KBLjCamhNVd99XjEPbxjOx6XRuKdfV
	 pZgiK04S0N5idBKKzWPTjvZDZLKmYFE+AvWY44Lne/59rcIFvfiRytRivMufZ0axws
	 qKtTAfxXdeYgPE8WGoNIGbwNIJLwhson8ZLa/ThxD1S0nNJ/Fb+A6zmndv30bSwCLn
	 WxRhYjuteC1Bw==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id d357a046;
	Mon, 8 Jan 2024 11:19:49 +0000 (UTC)
Date: Mon, 8 Jan 2024 20:19:34 +0900
From: asmadeus@codewreck.org
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev,
	linux_oss@crudebyte.com, rminnich@gmail.com, lucho@ionkov.net
Subject: Re: [PATCH] fs/9p: fix inode nlink accounting
Message-ID: <ZZvaRt4T-RjOBoS2@codewreck.org>
References: <20240107-fix-nlink-handling-v1-1-8b1f65ebc9b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240107-fix-nlink-handling-v1-1-8b1f65ebc9b2@kernel.org>

Eric Van Hensbergen wrote on Sun, Jan 07, 2024 at 07:07:52PM +0000:
> I was running some regressions and noticed a (race-y) kernel warning that
> happens when nlink becomes less than zero.  Looking through the code
> it looks like we aren't good about protecting the inode lock when
> manipulating nlink and some code that was added several years ago to
> protect against bugs in underlying file systems nlink handling didn't
> look quite right either.  I took a look at what NFS was doing and tried to
> follow similar approaches in the 9p code.

I was about to say the set/inc/etc_nlink helpers could probably just be
using atomic (there's an atomic_dec_if_postive that we could have used
for the v9fs_dec_count warning), but this isn't our code so not much to
do about that -- I agree it needs a lock.

I didn't take the time to check if you missed any, but it won't be worse
than what we have right now:
Acked-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique Martinet | Asmadeus

