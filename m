Return-Path: <linux-kernel+bounces-80914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 875E8866E05
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B913C1C23727
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54D54E1BA;
	Mon, 26 Feb 2024 08:33:17 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7439FFA;
	Mon, 26 Feb 2024 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936397; cv=none; b=d4ry8HBqOIrkeT1GrkQF2U5ekQZ+vfesMx8oIEVgujkYXVeqChcV4rUn8bGISwqfT+Ca81S+FYRgf5PvVj/rf0lhfSBuFudLgX6hhpGhQ1TyQh2wZxUH2kABN8pShkoGNHg/+Ch95s3pM0OJyW3iphzdzS4n7VD7TVSbRlRFogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936397; c=relaxed/simple;
	bh=8YnqCvaVNYar5aIZBImce4B4KXZMqOiJJmxtzNMwcOY=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=Q9DizdHYmIF7GroclEUu76lV9uT0uYJQYkcUjzyg+Hbd5+BBpV9WuvJ46CvHQ5dis7PprGP7s0GTXQTPStgkJ+o+Bv0z1pfsRP48mBUzF1K2r6JvPKPPemt9TgJesmfhGmHlDTHgxHC5FCPMRZPpH1Sosjo1KOmSCkmpQDder+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-FEAT: B8vEhG33zUTqMh/Df+7C7/cZTpPTQihZsq8pvLymg+J8YWdC3ZJw6O6x4eqO/
	nti0nNjmZ4R4ntBHTIbWl61+2eCvit1id/VezWT+CFzzdaClVgACFXFN06iCxbgC4C2/0Hn
	UisnnP2IRvPIl+zzxNzXr84Q5npOIp5Bo5xGB4hXLeojn12YtboYb5N0URS7qPW+iAknfUF
	ubIZ+KCzOhPJjijpVNvY3gsNFLFHb5//f1UPweiVFIfYlMQnAdHNRpx6B6xF3ar9rLTL/SB
	RRVIU9g5n8eoD14SyEjCVx044dFtzFyQzMnl9XxoPBMDllh3pdwcnt++pIyyTZ/g9Rh3cER
	hkfddYg7NQAPVoBKwAcYKMQbe9XHLyyWYYertnbSAZl3uHTpbc=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: Cyo8Q8zJxI1JsbZ6iSukuqr7xFbz3rxXnIeXv/emwKg=
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1708935908t4705339
From: "=?utf-8?B?5YWz5paH5rab?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?V0FORyBYdWVydWk=?=" <kernel@xen0n.name>, "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>, "=?utf-8?B?aGVyYmVydA==?=" <herbert@gondor.apana.org.au>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?Y2hlbmh1YWNhaQ==?=" <chenhuacai@kernel.org>
Cc: "=?utf-8?B?bGludXgtY3J5cHRv?=" <linux-crypto@vger.kernel.org>, "=?utf-8?B?bG9vbmdhcmNo?=" <loongarch@lists.linux.dev>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] loongarch/crypto: Clean up useless assignment operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 26 Feb 2024 08:25:07 +0000
X-Priority: 3
Message-ID: <tencent_29355025499B47007555CE13@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240226080328.334021-1-wangyuli@uniontech.com>
	<48afa638-9145-40ee-9868-fa82a1fce271@xen0n.name>
In-Reply-To: <48afa638-9145-40ee-9868-fa82a1fce271@xen0n.name>
X-QQ-ReplyHash: 3202933845
X-BIZMAIL-ID: 12383567994983227794
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 26 Feb 2024 16:25:10 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0

U3VyZSxidXQgd2Ugbm90IHNlZW0gdG8gaGF2ZSAiY3JjLncuZC53IiBkd29yZCBhc20gaW4g
bG9vbmdhcmNoIDMyYml0IG1vZGUsbm93IHRoZSB3aG9sZSBmaWxlIGNhbiBvbmx5IHJ1biBp
biA2NGJpdCBtb2RlPw0KDQpUaGFua3Mu


