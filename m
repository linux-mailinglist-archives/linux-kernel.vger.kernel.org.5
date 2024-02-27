Return-Path: <linux-kernel+bounces-82937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C26868BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F84D2851C6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F67130E48;
	Tue, 27 Feb 2024 09:15:55 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D7136644;
	Tue, 27 Feb 2024 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025354; cv=none; b=UsDUyQY63wj87Q6rt5N8TC1T0xHf9rBKfjWbJB4J6cp0H+b/AJUQDK18kcX5dRB9abB55hZrc8haGfhkBhVCC8EI+zvr8DtnB0YnckScYNEfC7QV5QzWJC9nBrLMCr3ygq8x2uIXI5iGSdZRdDuxkza99nivMn2brFmXznu3Y40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025354; c=relaxed/simple;
	bh=q3X4DyIN6ikii6oyoObnkh3BANWnYYwXcgEqll1XmI0=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=PIgYboLoJ6Bto/pkYjzlJkEf3uLgNULb7s0MPfunoBlUh+/3vKeSup2ET97BljfRzRUmGkgwlwgYdX2qMP8hUr0oevUHxlp2+rpxJ99638cDcL1qHY9SNR8YISuOKxAOW/4j4ZMlQvXK3E+qlllnGb5xlyaU+RYp+OycsPh+HaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-FEAT: Q4gfBD3K7t9Ff30Vz19LwZL0M515kJvPrV724lJtybTSINIYtQ1l8UqYjgBx8
	by99BmmNiJ9qRcuU+ymazD+3yEW992KNHyY/Daohciw17T11kx3OE1HxQwvSnaMMJkqphNh
	pxfkd6V6lFusW52EM1SCpSNOjBHE7NWFJuP4/cdpGsHlBcY7rBzjfFLRf0MmwvoxkC4bi7A
	kVMKDHV0vsDw02+DfmujndNQtnR3etqcVFkIx9BI9QGujvCa0EMovexmHpRFDqqJdjN2fJl
	SeOJS+y2b61FlCWs62mHrHBYjrolsuC9VQtpIfrve/YsnrTuakUEyGhRWkZVi0FkoFIEtOm
	BnKZD/kiCI70GNCwuDBhTnEJ6rhKFtAZIiTcc8zLstPSQxAS31fmIHmsxC+sw==
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: c4I++hesTy1A7ZFcNMsz9OLPOJeAWWdLhjaoUqczMUw=
X-QQ-STYLE: 
X-QQ-mid: t6gz8a-0t1709025277t7164113
From: "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>
To: "=?utf-8?B?5YWz5paH5rab?=" <guanwentao@uniontech.com>, "=?utf-8?B?V0FORyBYdWVydWk=?=" <kernel@xen0n.name>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?Y2hlbmh1YWNhaQ==?=" <chenhuacai@kernel.org>
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
Date: Tue, 27 Feb 2024 17:14:36 +0800
X-Priority: 3
Message-ID: <tencent_5A62BE3B57D34B9C2C5D3DF3@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240226080328.334021-1-wangyuli@uniontech.com>
	<48afa638-9145-40ee-9868-fa82a1fce271@xen0n.name>
	<48fd3c4d-9b72-4515-9a95-d241857915b4@xen0n.name>
	<tencent_1407D9AC6F6B4411233FEAD6@qq.com>
In-Reply-To: <tencent_1407D9AC6F6B4411233FEAD6@qq.com>
X-QQ-ReplyHash: 1643990783
X-BIZMAIL-ID: 12681889040870989663
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Tue, 27 Feb 2024 17:14:38 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-3

VGhhdCdzIHdoeSBJIGRpZG4ndCBoYXZlIHNlbnQgYSBwYXRjaCB0byBNSVBTIGdyb3VwLiAN
Cg0KV2FuZ1l1bGk=


