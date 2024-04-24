Return-Path: <linux-kernel+bounces-156571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07438B04AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65DAB22CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684B1158A06;
	Wed, 24 Apr 2024 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MFiEXoG1"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68410156C6D;
	Wed, 24 Apr 2024 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948360; cv=none; b=IhiNMbHqWcZycmSJs7H2rTzJzIwaPhgXRZ21n7fNA1JuL3THNPvH2II1pI10+qAQhr05HIKXa0WIo2zGT6lNr3qzzngoyvVTdnyTFbwH3CQXXb1mmErsfEI3eOxrkpi7SQ56ExIKSCrYFTGlz6ULWEXXRP9elMTrS7d46ekyVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948360; c=relaxed/simple;
	bh=uEdlRl8Jc4JFRBA1J8W5/TuzeZ48w8/YmJIGgstTKCY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Q6P+s+ZSbehO8GqsUPPWKq4GzJdo791kVP27ytLbRA9ZY9e0SoyXK/28X2gyIzUmnOiSyx43CxTbZ7j6TRzBRT/rzqb3cLsnofenvNmFv9b+lsmmreH2O6gIEpSquYMLmzrx3flmiyfwKdPsSGKMJilyYmwX2MEVcydDPfaswY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MFiEXoG1; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713948319; x=1714553119; i=markus.elfring@web.de;
	bh=uEdlRl8Jc4JFRBA1J8W5/TuzeZ48w8/YmJIGgstTKCY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MFiEXoG1hzCEcxtx7TtI8kVWf0uqPNtc9pn0AB4w/yv74v6F1V75DrqF59zGkAJL
	 V2ABrdxV0EIfN6gj8aSwQmTSX9QXEmwUWIfETIAHwXXM4Z99iXItNllbq2Z6+/+a2
	 vIXfrhUvUcSZOytcyxN6FVww+WWaQ0vyWXNoUmBdqERHCAR0QmlaQWlxWhIQzcKTF
	 tMPwFYrjO4HJOSYBQCxtuk6gc9Hhf5tffa/thHsv0vAthVZZqFNFAIuEEH1pHKeQt
	 Mus5w8+rkZKDlGGesKAldss6Z3RNiTtnoEuxGIqe2NRlceEEdSLDygbKcHydSMgqw
	 chlsoy9g+yk+lSD+5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M91Po-1s5bzN12XO-006MWT; Wed, 24
 Apr 2024 10:45:19 +0200
Message-ID: <f74fdb82-5d66-48f2-830e-3874570f022e@web.de>
Date: Wed, 24 Apr 2024 10:45:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, linux-sh@vger.kernel.org,
 kernel-janitors@vger.kernel.org, kernel@quicinc.com,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240423233150.74302-1-quic_obabatun@quicinc.com>
Subject: Re: [PATCH v2] sh: Call paging_init() earlier in the init sequence
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240423233150.74302-1-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oDDtZE5QTI6HgZu8daXqlXif8l0UZyjgE5+bLaur5LHSocjnwgO
 gW8Txa5Nd4nJ75hAUuaxWnY9MzsjWpqOPbeZEX7XZ10oQ8b1E5N07MklbKEJN1YgeHPwU2V
 +Vhqvz7XtI9gcdrkagJw5i+8MzzhSXIpNNH4sH0mq0srUTygmIXNolv55XD1gzn1KZNwmeq
 g0yzkx/OYUSEDOevdAMlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SwlBNNsRryw=;QZ+WI6pzzujKucnH37AACiHDU6m
 841de6/jPxCFDZdlmZRYUS+CbeWgZ/2NJk4zt09xZ+o30kbvVnUh+rK8NCa9SQ0pMYm9YCzAa
 KfP9oIGLqC2oN196WGO5yQpyMMXZvYow6G/Idozre+37/CQGTbdTJoTW5Y74uW5KR5H649DsA
 VTT6KGMar4aUN63NVNjSjRHvvFR8RncYTTK2xNO5EU5Q0FRVOF0K4OPrlsj5jHzd8OckydOKV
 HvsrELG9AVx31IX9SVq+JeRMcN5prh1nkH6DN2SENsdFSRy+Ai3MZmquSV9A4cRTnV0yntCVw
 3mvZqjEOSOwqLmTZnsw66C+Wc68IjsBwJP86MT4aw7TJJAFiCiHFNwEYr2Gi063AYakwUa+ZK
 TAn6OdQG04K/4be03arZxAZVzaojQebjKxuqvn4FKO7hymOf+TPVfUh5nu8J9lm9pMyca51OZ
 bkZcrd7uUgp9cYYxdRI8nWDL3glhLjEZjFK6rH4/ALUdVigOTmhIOK16jxLyHUGGDuTeVPXp3
 8ZiPjhkzTdpIiwEbm1WOvSGR6GXX9WEQblPX+TAwyA7CueV1YjtQgUdDhQ0x5S2pVVbCE4t3R
 nF1jEV1XNfwG7kOI6165FfNqPXFzIRe8wlejNNHblzXb9sFX5SFDHQu+z83V5ON6tUw3kgv5A
 lloQUn8ybcU0L79enEGqyJZAp8x2JK4QtvDeR3lirlkt8pmdm6tdQsZ8FdDCCogAHsCY2xOxR
 NIlkuwEXinyerk+1pezD0bInB/pOzK+Q+BDLZy3ov2IK1uUKI2649IrXV73SeGjKmciqs5ufU
 mzfOFgYh6n4+yzqFe0t8keGN1HJzNgzhWiuNqjdz8Xugk=

=E2=80=A6
> Hence, move the call to paging_init() to be earlier in the init
> sequence so that the reserved memory regions are set aside before any
> allocations are done using memblock.
=E2=80=A6

Will the tag =E2=80=9CFixes=E2=80=9D become relevant here?

Regards,
Markus

