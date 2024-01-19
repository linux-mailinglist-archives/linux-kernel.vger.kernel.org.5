Return-Path: <linux-kernel+bounces-30964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 575168326E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F531C231C8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B626B3C47E;
	Fri, 19 Jan 2024 09:43:11 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237E3C463;
	Fri, 19 Jan 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657391; cv=none; b=V3YSCGI+SuNqls4uX2zJ6PA6JcBj3IfEHVMyU/syx8jzR+QgEL9xSi8AVHypwX9BfLsYZXLpQa6swBs76YIsfJQd0A8tINPwvrw6CHhb5Y/5F4ybPSCIgJtrAu3SaVfb55aOvuK+LtkYMVKj1tvCTxIRAfikxK5X79LZatlib24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657391; c=relaxed/simple;
	bh=YAIzMiJuCKphBety3PsrZGEniRd5/SSgfqJPPSFwiyE=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Xq7e3/if8FNJ1GXWSoSJ2ky/EEffhMC47PeOAcDDKMsKc8PDqWfsWrvTTZ6N7QVi45bz5uQ0Lx8QCiErmLfAJm3GzVeckTcVRcs+DYXA1c11EBvu3GLa61+JrL5ieEfP5/WkhpTZTYno+MSy1t4nm3KSeMJklWQ3sK+0vrZY2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [42.120.103.58] ) by
 ajax-webmail-mail-app2 (Coremail) ; Fri, 19 Jan 2024 17:42:54 +0800
 (GMT+08:00)
Date: Fri, 19 Jan 2024 17:42:54 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: djohannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] nl80211/cfg80211: add nla_policy for S1G
 band
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20240119093724.7852-1-linma@zju.edu.cn>
References: <20240119093724.7852-1-linma@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6acb79fc.79d3.18d211a170c.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgBnja0fRKpldnZhAA--.9518W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwMEEmWoIc4RlgAJs6
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gdGhlcmUsCgo+IE91ciBkZXRlY3RvciBoYXMgaWRlbnRpZmllZCBhbm90aGVyIGNhc2Ug
b2YgYW4gaW5jb21wbGV0ZSBwb2xpY3kuCj4gLi4uCgpJIG1hcmsgdGhlIG5ldC1uZXh0IHRhZyBm
b3IgdGhpcyBvbmUgYW5kIGEgcHJldmlvdXMgc2VudCBvbmUgaW4gdGhpcwptb3JuaW5nIChbUEFU
Q0ggbmV0LW5leHQgdjFdIG5laWdoYm91cjogY29tcGxlbWVudCBubF9udGJsX3Bhcm1fcG9saWN5
KS4KClBsZWFzZSBsZXQgbWUga25vdyBpZiBzdWNoIG5sYV9wb2xpY3kgY29tcGxlbWVudGluZyBz
aG91bGQgZ28gbmV0IGluc3RlYWQuCgpUaGFua3MhCgpSZWdhcmRzCkxpbg==

