Return-Path: <linux-kernel+bounces-161901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9778B52FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B206B217F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C609F17580;
	Mon, 29 Apr 2024 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jz3Yxdhs"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E2214AB7;
	Mon, 29 Apr 2024 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378879; cv=none; b=eOARJN8hYCI39j/l9H8z67MhXOCL7WcYGWbXaWYj8dePzYpNPrViYv3dEcmfrm029w0/ZfNwJtCuMCBpvm5e5/s/K+EUTHHAfXSKWbyOI+Hh2FVCjfIhdmklRXveHAYHEa5VghxlOQyFNc+gXgni+XRjSxceI0weGpChwm4givE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378879; c=relaxed/simple;
	bh=8JgsMZmmDtrljtiYk0KmNtO1KiklYvquJQzmiFrlFKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmLK5i0654VikTtrIfNJzgNjLNsPbaHx/fA+DHwQHD8/RIbs5ZPgrWjSLdYDYtH0IPGji6+EDpVXct1relmu2R2pOxznepWmfZEw+ljKu0AF+xulhDBshkZP2vBEczn91GpPtIzUdzC8mIhNwCljDvNkRp0M7Is46WLch2k/eWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jz3Yxdhs; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714378847; x=1714983647; i=markus.elfring@web.de;
	bh=8JgsMZmmDtrljtiYk0KmNtO1KiklYvquJQzmiFrlFKU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jz3YxdhsZB9z2L88XkxBSD7gp4WS9DUFe8Y3TdbbO129JIxHK+AGWWVnSNJb+XQ/
	 ltmc2Jqvlrnu4RGrqyzaGvXwYepSKAN6zFIllxlu7fw+eFsEHGt099rJQQ+O7dDP/
	 PSJzz/whvF6au/+o7AGXLQ1wx/cLv8AhMI6V9r0dhsqKU5ultR00rgXiG9+aD0mzA
	 ZhCSJ1lyZ5CurY3ja7nR+px5yNtnqcQSZyikG6kdGbF3eKzK5N5qBe5EhYdFCHhSR
	 v9RwijUiYSKM1lfc+4MuZWU5AQy9b0ZD4bIPprGLydfaXRWTNPow3enhwZJmVh/Pr
	 KUOfbs9GcomUDY186w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMp8Y-1sHnAp0YiK-00IG5k; Mon, 29
 Apr 2024 10:20:47 +0200
Message-ID: <b50cf967-b5ab-49e9-a270-a4ff4ddc4559@web.de>
Date: Mon, 29 Apr 2024 10:20:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] LoongArch: KVM: Add PMU support
To: Song Gao <gaosong@loongson.cn>, loongarch@lists.linux.dev,
 kernel-janitors@vger.kernel.org, maobibo@loongson.cn
Cc: LKML <linux-kernel@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Wang Xuerui <kernel@xen0n.name>
References: <20240424091813.1471440-1-gaosong@loongson.cn>
 <e68e09e0-75f3-43b8-b947-22cc0d1a0dae@web.de>
 <b8818597-2770-f2a3-03bd-1653cd26fc78@loongson.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b8818597-2770-f2a3-03bd-1653cd26fc78@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y5Yp/ApPG9GOM2Ye34aPN4ka9s+kqq9SHP6K0xcyCgGQQT9oAOZ
 W686YPoqgaP/sRspCPkP9tBxVWUKHDiExnY1FBaZ7UXgc3Gxoz/lREcWEA2X1Bb+aE4gZyu
 KdhDSZU7LuPZ8yxgcmrCs7TlC1YXpYzTfNQfMtGm3EEJiqJDdv/AL7DIcntm42mCaZ7gXIK
 se5r+cHDpKSVaxUs9T+vA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zS9BJorl81w=;q3pqBoET+GDs9NIV3SlC1m3l/9n
 5UyEfpwRo24/7Og09E9ODYf7wodSJ/dybnHMp5/y8ZP+HKHviC0peE+OKBAmBYlRVpdiocjFl
 gh1Uje0SOGEWAU0qlhLO94XzxQGHSAbz9ulJPtiHUDZ/WyeOjTr91GxBabNf3QH9B+Hzrael1
 GvSZGa0a0QCJk/u0FUO7Ke/1RuEFq/QN/QOse0gDtQHTDmLstXDS4zXc6ZJcvTjCv1wubdLdG
 f3+rf+9Zos1GC4gxV2y6hA5LQBfkrsnpTFS1biR04ojREogqgcOLAq8Ia2Gqa+Xz8vN3iW/Iv
 2Xa9OddAPRYHscNRIySVAsUWONxrgwspHeTyFvDiM4e8y99M9LsZjc/oI+/fMI13BDWXHNV67
 MStglUhZ4ifPdS/lkjSlFgi1ofmhIrUPj+ey5fEJNctnTQOZzsbHc18ia125wBMHbEsiQrqlE
 7ypSSkDnQUN8j3dliWh2khAG/IZ5NK6InN3uRLeYyAFPukqO1U/86e6ZvigqFqc63ygT2LymV
 97uYXUx+8aOuN4aXdGyTjvIUdnQOt4dWtfdMQ8nsm8z0EQMAFyNgQ4317Vh/Eu5NZ7SR2G11a
 Mx6aeuoFdcoTTJwM/tPpNx9n260gg0zGC2JKDV1VadMzc9R0i5UYOydmiQmxjFNjYZYveouXH
 FYoW3TU7IwbQyLpLFNikZeIly081nJCRTyi5KKPhW7te4afyvW7KnjbaK9VdP7YjKwrEl1XIS
 ShTjcWO8nqFI6jZq3g5ZR8/wRCXtHSSKrUb0SSmpNt/z+u46o/tXkr9ty92KX/g3LnoKkwf0D
 Rs7naDTZC+E9E0zIukflWIVUSrDleb8FSYwAKhddSK8tQ=

>> * How do you think about to avoid the repetition of version identifiers=
 here?
> I'm new to this, is the following example correct?

Different enumeration styles were published.


> ---
>
> v4:

Would you like to specify version identifiers with =E2=80=9CV=E2=80=9D con=
sistently?


> Patch v1: https://lore.kernel.org/all/20240410095812.2943706-1-gaosong@l=
oongson.cn/

You may specify such links also in each description section directly.

Regards,
Markus

