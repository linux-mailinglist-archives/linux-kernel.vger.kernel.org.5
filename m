Return-Path: <linux-kernel+bounces-18833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC238263C0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 11:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B5E1C21403
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D1812B9A;
	Sun,  7 Jan 2024 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="cCAh+KaV";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="2IydRGWO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DF12B84;
	Sun,  7 Jan 2024 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 9AC1EC020; Sun,  7 Jan 2024 11:26:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704623208; bh=Ga6+A9cwq7fuTFNzHnNcQM73H/BQTgpX+VIIomVa33M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCAh+KaVsTqWTJZUlpjJJHi5l02ZixUhXOfMchd8cNdp+ugjbyB9f7rV8UTp1whjA
	 argbE6PPo3bR6DKN9rpCkAWmXVlfRytioNOq2DF3Jyh1hxxme2g/Sse9BK2tuKCHYc
	 m65FJfuFHnP+yvuTE5+eaSaA1cYJ5fwALp8bu1lDf3CtEhzFSf2un03moUMtZcGXNf
	 IbWYCqKqctVPtJmeNhVYEXF+dROSwIyrEUhLdy15OC0i38amOAjffoJLZbtC+O5m2u
	 rpdAXwRkoVpNDH+J1I5rZAybH47NqVBYJurH85vTNzgJ6TyQpHC/l7IQE4Ez3AgDli
	 fHb5UrH1GMSgA==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 41EAEC009;
	Sun,  7 Jan 2024 11:26:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704623207; bh=Ga6+A9cwq7fuTFNzHnNcQM73H/BQTgpX+VIIomVa33M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2IydRGWOTysQ8G6+EBZMnwsgxmp1yOF+lpkxOPTa37yMiOLo3QRmRmvM1NVicBVTM
	 oY6lMGpPXie7JITYpogkmL32qOQ78/xOrB/4/F9994kz0kkelOstUzkVwa1tDnZS1Q
	 4aWfArX+USObNxrWQKBEFXxjM/ys9k2ZdGQ5/UbuKhQv2A6aWW3fMx9u4Db5JhsFUt
	 yg7x56RjFRhzkAB5KgbBnXaScOPjeU8x8/0rm/HsJweVasvQAqghykX9mT5/b+m5qJ
	 ra/ZcmHJSFcGfO36CEo3fVy0C/uau0qPuLmeeHK82/Xrj7qgQI/3ploPaZA/uuym69
	 A/K3VPjwJnW6Q==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id a0446c8c;
	Sun, 7 Jan 2024 10:26:39 +0000 (UTC)
Date: Sun, 7 Jan 2024 19:26:24 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	v9fs@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v4] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <ZZp8UPkH-TJIUngl@codewreck.org>
References: <20231206200913.16135-1-pchelkin@ispras.ru>
 <1808202.Umia7laAZq@silver>
 <ZXeZevFb1oDvMFns@codewreck.org>
 <2et72smsvglzicqsyvt5m7bx2akyqzi2moq7tjupppygbsme3u@o2sltttok5wy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2et72smsvglzicqsyvt5m7bx2akyqzi2moq7tjupppygbsme3u@o2sltttok5wy>

Vitaly Chikunov wrote on Sun, Jan 07, 2024 at 10:56:23AM +0300:
> On Tue, Dec 12, 2023 at 08:21:30AM +0900, Dominique Martinet wrote:
> > Christian Schoenebeck wrote on Thu, Dec 07, 2023 at 01:54:02PM +0100:
> > > I just checked whether this could create a leak, but it looks clean, so LGTM:
> > 
> > Right, either version look good to me.
> 
> Also, there was unnoticed bug in v2[1] - `int i` is moved to outer block
> and `i` counld be used uninitialized inside of `if (errcode) {`.

Thanks for pointing it out; I'm not sure if it's the same thing
Christian noticed but I believe what I had applied with his suggestion
of initializing i worked either way... But this is moot since I updated
to v4 afterwards:
this v4 has been merged in 6.7-rc7 as follow:
https://git.kernel.org/linus/ff49bf1867578f23a5ffdd38f927f6e1e16796c4

(the message-id also points to the v4 correctly, e.g.
https://lkml.kernel.org/r/20231206200913.16135-1-pchelkin@ispras.ru )


Thanks,
-- 
Dominique Martinet | Asmadeus

