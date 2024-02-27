Return-Path: <linux-kernel+bounces-82883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E96F868B26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35FF1F25507
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10D4136642;
	Tue, 27 Feb 2024 08:45:45 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338A1350FB;
	Tue, 27 Feb 2024 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023545; cv=none; b=rJPeTfY4yQcU79AnUBokwFZ8azZmaQuVxrZS5QjPbFNIN5ym1sKOHktEJMgJa26ZucWTMnLC2OpGcwCG2C0cvLJQ6Sn+83zVNeXWqtL/cWEImibpwNco6cw8KI7mp7gPxw4MrNRv6LG1nbCiPAql8W8wTAL+C8LoPLsNdMLdIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023545; c=relaxed/simple;
	bh=CCn0CZhTswxO8dDtG9PzR8GZNoyxR230uzKtsvN3+pM=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=TOTzHgtUI/wKUwb7Ib51FsByc8ckgq28gu9AKed2J6ZecRuL4IQpCxs/MlunAxdvPJnTb4zjYNCLH1UYGc7ndKQMBaWTIZoc4+c3smXf22n4ZXTSgenWUlzU8fExFSQGBKTSZ0kjehugsDlmV2+kXwMd7ZLSVyGXm3kXRktrrNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-FEAT: hfxFW6oFtjtalW1lY5E2j+3Epj1A5pO4GIQu5QBhQ8URGybqh4mPiCEHjxSio
	u3D4RQd4twFzZVqkXVZ1JqAsbqiTavYmLc9PcNQwiDx+76AiybIyEaKTeaup2zni/AHFKkW
	dLmzjXjIM8MUEFLGRdn9sjyhA5lOvIOI+onaJCRWpLK6vEx5RmxPkWKEsH0Rcb/u7ZXb19R
	iFkaryPj0KYRHJjSRBn0DF/G6nYalllrGsmJ42DRddrxkt9mWnykLMDguJ3WsSnpWRSvGio
	9u5XtLWc/PKrBAAo1S1j8erD0zGWUZEgisCiH9OpFb/JgOmIG/M/qvAshr6ZTiNQTYE0obm
	DdlSjjXCtzwGWxwU/hWIkRhIvlc1KHRnDsRBktxkN540pUj3g5oV42FraK+zw==
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: J9wt3V2enXy6+o2IMVQUP6Ji5KRVJGddXFirrQ2Sc5w=
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1709023492t9054922
From: "=?utf-8?B?5YWz5paH5rab?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?V0FORyBYdWVydWk=?=" <kernel@xen0n.name>, "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?Y2hlbmh1YWNhaQ==?=" <chenhuacai@kernel.org>
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
Date: Tue, 27 Feb 2024 08:44:52 +0000
X-Priority: 3
Message-ID: <tencent_1407D9AC6F6B4411233FEAD6@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240226080328.334021-1-wangyuli@uniontech.com>
	<48afa638-9145-40ee-9868-fa82a1fce271@xen0n.name>
	<48fd3c4d-9b72-4515-9a95-d241857915b4@xen0n.name>
In-Reply-To: <48fd3c4d-9b72-4515-9a95-d241857915b4@xen0n.name>
X-QQ-ReplyHash: 4040909372
X-BIZMAIL-ID: 17922161660482131816
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Tue, 27 Feb 2024 16:44:54 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0

T2theSwgc29tZWhvdyBpIHRoaW5rIFl1bGkgdGhlIG9yaWdpbiBjb21taXQgbWVzc2FnZSBz
b21lIG1pc2xlYWRpbmcNCnRoaW5ncyx0aGUgd2hvbGUgc3RvcnkgZXhwYW5kIHRoYXQgb3Jp
Z2luIG1pcHMvY3J5cHRvL2NyYzMyLW1pcHMuYyBjb2RlIA0KImxlbiAtPSBzaXplb2YodTMy
KTsiIG5lY2Vzc2FyeSBvbmx5IGluICIhQ09ORklHXzY0QklUIiBtYWNybyBkZWZpbmUsDQp0
aGV5IGFyZSBqdXN0IGEgImJpbmFyeSBiaXQiIGdhbWUgYXMgd2UgdHJhbiB0aGUgbnVtYmVy
IHRvIGJpbmFyeSBiaXQsDQp3aGlsZSBsZXNzIGFuZCBsZXNzIG9uZSBpbiA2NGJpdCAsdGhl
IGxlc3MgdGhpbmcgd2UgZG8gaWYgPj0zMmJpdCBkbyBvbmNlLA0KPj0xNmJpdCBkbyBvbmNl
IC4uLiBldGMuLi4gSWYgd2UgZGVsZXRlIHRoZSB1c2VsZXNzIGNvZGUgbGluZSwgaXQgaXMg
dmVyeSBjb29sLA0KYW5kIHVucmVsYXRlZCB0byBzcGVjaWZpYyBJU0EuIFdlIGFsc28gdGhp
bmsgbWF5YmUgd2UgbmVlZCB0byBhZGQgDQoiI2lmbmVmIENPTkZJR182NEJJVCJpbiBvcmln
aW4gbWlwcy9jcnlwdG8vY3JjMzItbWlwcy5jICJsZW4gLT0gc2l6ZW9mKHUzMik7IiwNCmJ1
dCBpdCBhZGQgY29kZSBpbnN0ZWFkIG9mIGRlbGV0ZSBjb2RlLi4uDQoNClRoYW5rcy4NCkd1
YW4gV2VudGFv


