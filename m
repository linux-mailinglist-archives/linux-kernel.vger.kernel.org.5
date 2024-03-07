Return-Path: <linux-kernel+bounces-94867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24657874622
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9EA1F23EF6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1563D0;
	Thu,  7 Mar 2024 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="O8WtXdlI"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A31C634;
	Thu,  7 Mar 2024 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709778990; cv=none; b=H79Vofko2klAtiD4LvaEzYy0VNGY5+V0me9aNECl1JsaSnyxVqvg+J3Dod3A66AETDKu6eMeK0jTK5W0Iv7BBfK9MkSt/rTb3dS0WoUrqoD5vjbI+kJ/YfiFRK+PBGmXorr1ZjKh0KaE5H4BYZgipMqi3Td1qsSqnayMzaslHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709778990; c=relaxed/simple;
	bh=ph/feJGGmyKfp67MFuqLst7sYIAeGwNOGN5BYN+bQ0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gIUFIugVn0NqpftCVkXydJ2oCTvS//RNeg6HWOF6PoKDddxGngi6IZd1q3J26pur1FJoTJzedD6NxjR6tN16en6vm1Ra97O1RNX6qGQOTdE3KJGO1+rZ1of5dvK99aHLYByHSNUq3rWLf/QOh47MGHcSeFWjXXaL4/3imgQ+D5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=fail (1024-bit key) header.d=126.com header.i=@126.com header.b=O8WtXdlI reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=eOz3J2MB+Wc80am0ayotko7x6oelnuQokEDQt3pZbG8=; b=O
	8WtXdlIUkbirCRFEmhsm0DzJ42qOhzf1IMsAJ0w9NDk5KHerNqNk0dpFARil+2kA
	T6LCcY6gBeFKJ+GuRWADzPqgIJY3XCXib27E0RwGi7XFd3edjcZVJ+GA27U34Z5O
	OAttvNKlZ072NkkTjbzxewMjGm+kwIWqEn/GnKmDwY=
Received: from zhanggenjian$126.com ( [116.128.244.171] ) by
 ajax-webmail-wmsvr-41-107 (Coremail) ; Thu, 7 Mar 2024 10:34:12 +0800 (CST)
Date: Thu, 7 Mar 2024 10:34:12 +0800 (CST)
From: "genjian zhang" <zhanggenjian@126.com>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, axboe@kernel.dk, stable@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanggenjian123@gmail.com, "Genjian Zhang" <zhanggenjian@kylinos.cn>
Subject: Re:Re: [PATCH 4.19.y 0/9] Fix the UAF issue caused by the loop
 driver
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 126com
In-Reply-To: <2024030421-obedient-unbalance-a728@gregkh>
References: <20240301013028.2293831-1-zhanggenjian@126.com>
 <2024030421-obedient-unbalance-a728@gregkh>
X-NTES-SC: AL_Qu2bC/uct0Au5CKdZOkfm0kTg+k6Xcq4s/gi34NePZh+jDrjywYgQnxAAH35++yzCxq9lxuUSzJA0d5hZ693X7MoLEPpoF0ktS/iAo7kf2uWYw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1d74f009.2179.18e16c2d99f.Coremail.zhanggenjian@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3v_CkJ+ll1IcAAA--.4032W
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiHgqXfmV2z9pb8gANsf
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMDMtMDQgMjE6MzE6MjAsICJHcmVnIEtIIiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOgo+T24gRnJpLCBNYXIgMDEsIDIwMjQgYXQgMDk6MzA6MTlBTSArMDgwMCwg
R2VuamlhbiB3cm90ZToKPj4gRnJvbTogR2VuamlhbiBaaGFuZyA8emhhbmdnZW5qaWFuQGt5bGlu
b3MuY24+Cj4+IAo+PiBIZWxsbyEKPj4gCj4+IFdlIGZvdW5kIHRoYXQgMjAzNWM3NzBiZmRiICgi
bG9vcDogQ2hlY2sgZm9yIG92ZXJmbG93IHdoaWxlIGNvbmZpZ3VyaW5nIGxvb3AiKSBsb3N0IGEg
dW5sb2NrIGxvb3BfY3RsX211dGV4IGluIGxvb3BfZ2V0X3N0YXR1cyguLi4pLgo+PiB3aGljaCBj
YXVzZWQgc3l6Ym90IHRvIHJlcG9ydCBhIFVBRiBpc3N1ZS4gSG93ZXZlciwgdGhlIHVwc3RyZWFt
IHBhdGNoIGRvZXMgbm90IGhhdmUgdGhpcyBpc3N1ZS4KPj4gU28sIHdlIHJldmVydCB0aGlzIHBh
dGNoIGFuZCBkaXJlY3RseSBhcHBseSB0aGUgdW5tb2RpZmllZCB1cHN0cmVhbSBwYXRjaC4KPj4g
Cj4+IFJpc2sgdXNlLWFmdGVyLWZyZWUgYXMgcmVwb3J0ZWQgYnkgc3l6Ym90o7oKPgo+VGhpcyBs
b29rcyBnb29kLCBidXQgeW91IGFyZSBiYWNrcG9ydGluZyBjb21taXRzIHRoYXQgYXJlIE5PVCBp
biBuZXdlcgo+c3RhYmxlIHJlbGVhc2VzIChpLmUuIGZyb20gNS44IGJ1dCB0aGUgY29tbWl0IGlz
IG5vdCBpbiA1LjQueSksIGlzIHRoYXQKPmludGVudGlvbmFsPwo+Cj5Eb2VzIDUuNC55IGFsc28g
aGF2ZSB0aGlzIHByb2JsZW0/ICBJZiBzbywgY2FuIHlvdSBzZW5kIGEgc2VyaWVzIHRoYXQKPmZp
eGVzIHRoYXQgdXAgc28gSSBjYW4gdGFrZSBib3RoIG9mIHRoZW0gYXQgdGhlIHNhbWUgdGltZT8K
Pgo+dGhhbmtzLAo+Cj5ncmVnIGstaAoKVGhhbmsgeW91IGZvciB5b3VyIGFkdmljZS4gVGhpcyBw
cm9ibGVtIGFsc28gZXhpc3RzIGluIDUuNC55LiAKSSB3aWxsIHNlbmQgYSBzZXJpZXMgb2YgcGF0
Y2hlcyBmb3IgNS40LnkuCgp0aGFua3MsCgpHZW5qaWFuCg==

