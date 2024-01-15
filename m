Return-Path: <linux-kernel+bounces-26026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCAD82DA14
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E492825DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E392217553;
	Mon, 15 Jan 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=automattic.com header.i=@automattic.com header.b="aD+b8qHM";
	dkim=pass (2048-bit key) header.d=automattic.com header.i=@automattic.com header.b="eP5B1+Nm";
	dkim=pass (2048-bit key) header.d=automattic.com header.i=@automattic.com header.b="bPE/bRTr";
	dkim=neutral (0-bit key) header.d=automattic.com header.i=@automattic.com header.b="IjF7c1v4"
Received: from mx1.dfw.automattic.com (mx1.dfw.automattic.com [192.0.84.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CED317552
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=automattic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=automattic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx1.dfw.automattic.com (Postfix) with ESMTP id EE05C1DBF50
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=automattic.com;
	 h=x-mailer:references:message-id:content-transfer-encoding:date
	:date:in-reply-to:subject:subject:mime-version:content-type
	:content-type:from:from:received:received:received:received
	:received:received; s=automattic1; t=1705325380; bh=oQro7HLcf72h
	4Wd8Zl/xcn3Bi2GJZnL4eMf36nHFiQQ=; b=aD+b8qHMgxAYIBoiEMuLMfwLF8Uw
	FXXDXy8QP1iLiHJy+1QMjmUejwC7jUI1XUWYrtJxmCduIDm9cb22tqeHY0F0Pjbx
	c9ZaVEtEU4+WP890hC+s1mztmDCfqTJzKSkl1XgkYRiC2Wfr0GsTPXzcVdFPonIH
	wjm1EhqgOOT0ngPG2a/L+E0RJTyWd91BcBLgWb/Y8SU7j2qDwWuJ58rTw3itTI5M
	Z59MCw3NxnVi3yPJLEfkSsi87m/aPbZv18HnR1lwZPJlf+OPYnTQB36GX0ShJ536
	t/aoAJ2maY49mB0JwJDjCVHPDaO9gVmWrVIMqAO11bL+TRuDqLxYE1c/Ag==
X-Virus-Scanned: Debian amavisd-new at wordpress.com
Received: from mx1.dfw.automattic.com ([127.0.0.1])
	by localhost (mx1.dfw.automattic.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O-4SIpfD-Yjg for <linux-kernel@vger.kernel.org>;
	Mon, 15 Jan 2024 13:29:40 +0000 (UTC)
Received: from smtp-gw2.dfw.automattic.com (smtp-gw2.dfw.automattic.com [192.0.95.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.dfw.automattic.com (Postfix) with ESMTPS id 6E22B1DBF57
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:29:40 +0000 (UTC)
Authentication-Results: mail.automattic.com;
	dkim=pass (2048-bit key; unprotected) header.d=automattic.com header.i=@automattic.com header.b="eP5B1+Nm";
	dkim=pass (2048-bit key; unprotected) header.d=automattic.com header.i=@automattic.com header.b="bPE/bRTr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=automattic.com header.i=@automattic.com header.b="IjF7c1v4";
	dkim-atps=neutral
Received: from smtp-gw2.dfw.automattic.com (localhost.localdomain [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-gw2.dfw.automattic.com (Postfix) with ESMTPS id 5F321A03C4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=automattic.com;
	s=automattic2; t=1705325380;
	bh=oQro7HLcf72h4Wd8Zl/xcn3Bi2GJZnL4eMf36nHFiQQ=;
	h=From:Subject:In-Reply-To:Date:Cc:References:To:From;
	b=eP5B1+Nm9IS4u3JnYlRZhirS/Dnk9FFdXb7Y7MwvJg3eGEemEHHBlKH4A4UzPBmIy
	 NnuKO4VX9/FrQR6e/yrDVQzaJhZmZHq+m40RiIBmyBBiy0mdH5A5XwKmuz7dgIxZ80
	 pFyyB8d9ILp6WUZCA/V8qa2BcmEjuJUwl3rscN+JZQgONVzTWaTyqXfT5Aa43d4TmI
	 zkv34I19l2aHcyI+WlJAjxYZlEnxW3LeOiUBIDOVsIsbt2E1p9CmAdfS7Vik20G8G1
	 5KIvEYm9VRY+AObh8GuMtamQfgDYAf0b1Lamy6axTAwnQ51sHpRtasLkUeojyGd/RV
	 4aJr252FW3LCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=automattic.com;
	s=automattic1; t=1705325380;
	bh=oQro7HLcf72h4Wd8Zl/xcn3Bi2GJZnL4eMf36nHFiQQ=;
	h=From:Subject:In-Reply-To:Date:Cc:References:To:From;
	b=bPE/bRTrgfgvhDMUY0QnzJIgTyFz8MbnRTqEXJqpKVjW6l2tec5poevXz19i7KpmF
	 UuGUZH3jljOtqPMSD6Kbas4G/+FsEYDQ1kO1gnbRR10dngJfDokKdRJ2rtppv8Ea4Q
	 UfLz6KMSf+zupuiTXsLMPKty48oTzuTP8tdLQ/srzqXX+PEfA1KMvcSOdxRrHB1TUm
	 tFWGope/OFTS6LZoAkK6lwgEj3oMnr8Ud10LMs+1yyqYgN21iuQacVl6mGGXvRLUd/
	 bRsSHoXfd+qDjxLysQmpEtnVZXZTetiCCYIhw71mCwq8CWdlgF1Qcs0THPdBtQtbaG
	 ED1GQ9SQznkmw==
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-gw2.dfw.automattic.com (Postfix) with ESMTPS id 5087DA0350
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=automattic.com;
	s=automattic2; t=1705325380;
	bh=oQro7HLcf72h4Wd8Zl/xcn3Bi2GJZnL4eMf36nHFiQQ=;
	h=From:Subject:In-Reply-To:Date:Cc:References:To:From;
	b=IjF7c1v4sB4WM54Wr8JmfQjRwhkeZ3vHnTMHeIPdqSg7RVUdKtXnsWRimQ8zplMTm
	 ZeM1xVCFbD6ILhKHfJKnDDNbuOq7aEQBJpp/tKVgAbkcx//3Vt0gkGi8KC11hZFjim
	 EIXNuc7fvTMD8l5yZw86KZT1N5pcjCeC5nAdXnoOBNZrsqOf0oy7XTBzLHn4j6bB6U
	 MrERIK1ueeWPmmHqVEReL9kte5k9jlA/xpTu+W5Gt0pj+wkqwO96YORr1dDWlDUnR8
	 2lSMUAklmX44I+qIJMijQrYim2QLweSauY+ajo+s/tCP7A3oAViU9Yl691VueEnp4M
	 CQ/9m7F+nWGpA==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e76dfff9cso6537295e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 05:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705325379; x=1705930179;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQro7HLcf72h4Wd8Zl/xcn3Bi2GJZnL4eMf36nHFiQQ=;
        b=Bz60v1udef9Z9KGj9DydkU3tr8dIMGXBCOMRdWElEvWPr0g9R8Whn8env1bl4PU4Yv
         QkEb6Rbe0/lvONDP0/rWjyxM68zBQVziy5aqXpH6OdRn2Gkj5DGFI7hZqCXCG/ve+rtB
         22VpxS6/I/ZTzjZ5GixX8hI/HH8FUNU++7V/yaqPtxjGpR1u6/7FRQcaXrOHciKb6p+W
         V07qgJG/6cwqylHCiIKNWTUvcVgIvUSoxbsN4I975OZeQc0AozHZP0w5H37t2iw9DQl+
         OueT5RcnIKt9cFAISQ5SJUBNZoX4Qy01oQYP96hckbERJ+JtgmwjI8U0jG7wr4kZSDWF
         eulQ==
X-Gm-Message-State: AOJu0YyXDNXCYlgyRqiYbt47KAOI7LGJIf0aR3jQfq26POBvDqZJAovb
	Jpj+0cDCd7yr4/qAYUW3Wfezq+AoBBhrPRNOLGy5VzQQsRPdrixXf5bVAuWck4AkCHrIf8TmaGC
	jJN3nqrxAIKRFInaz6ebfyIK2k0iUEE39
X-Received: by 2002:a05:600c:2312:b0:40e:4ac1:865e with SMTP id 18-20020a05600c231200b0040e4ac1865emr3320737wmo.52.1705325379167;
        Mon, 15 Jan 2024 05:29:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJUhm7zn1lpSGmwHspUb9RZPBTtpl9oZj6TRNdYCuAIt4pH+vqJ2FTS0neeOHxdg7wo/bCcA==
X-Received: by 2002:a05:600c:2312:b0:40e:4ac1:865e with SMTP id 18-20020a05600c231200b0040e4ac1865emr3320727wmo.52.1705325378798;
        Mon, 15 Jan 2024 05:29:38 -0800 (PST)
Received: from smtpclient.apple (2-234-153-233.ip223.fastwebnet.it. [2.234.153.233])
        by smtp.gmail.com with ESMTPSA id q8-20020a7bce88000000b0040c11fbe581sm15658393wmj.27.2024.01.15.05.29.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jan 2024 05:29:38 -0800 (PST)
From: Ale Crismani <ale.crismani@automattic.com>
X-Google-Original-From: Ale Crismani <ale.crismani@automattic.com>
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Performance regression in ip_set_swap on 6.7.0
X-Priority: 3
In-Reply-To: <D2070167-F299-455C-AE4B-5D047ABD5B28@automattic.com>
Date: Mon, 15 Jan 2024 14:29:27 +0100
Cc: Kadlecsik Jozsef <kadlec@blackhole.kfki.hu>,
 linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org,
 Ayuso Pablo Neira <pablo@netfilter.org>,
 xiaolinkui@kylinos.cn
Content-Transfer-Encoding: quoted-printable
Message-Id: <7214C087-ED54-4D3B-A17C-DA811951BF67@automattic.com>
References: <b333bc85-83ea-8869-ccf7-374c9456d93c@blackhole.kfki.hu>
 <20240111145330.18474-1-00107082@163.com>
 <d5c24887-b2d4-bcc-f5a4-bd3d2670d16@blackhole.kfki.hu>
 <41662e12.d59.18d0673507e.Coremail.00107082@163.com>
 <D2070167-F299-455C-AE4B-5D047ABD5B28@automattic.com>
To: Wang David <00107082@163.com>
X-Mailer: Apple Mail (2.3731.700.6)



> Il giorno 14 gen 2024, alle ore 21:38, Ale Crismani =
<ale.crismani@automattic.com> ha scritto:
>=20
>=20
>=20
>> Il giorno 14 gen 2024, alle ore 06:30, David Wang <00107082@163.com> =
ha scritto:
>>=20
>>=20
>> At 2024-01-14 02:24:07, "Jozsef Kadlecsik" <kadlec@blackhole.kfki.hu> =
wrote:
>>> On Thu, 11 Jan 2024, David Wang wrote:
>>>=20
>>>> I tested the patch with code stressing swap->destroy->create->add =
10000=20
>>>> times, the performance regression still happens, and now it is=20
>>>> ip_set_destroy. (I pasted the test code at the end of this mail)
>>=20
>>>>=20
>>>> They all call wait_for_completion, which may sleep on something on=20=

>>>> purpose, I guess...
>>>=20
>>> That's OK because ip_set_destroy() calls rcu_barrier() which is =
needed to=20
>>> handle flush in list type of sets.
>>>=20
>>> However, rcu_barrier() with call_rcu() together makes multiple =
destroys=20
>>> one after another slow. But rcu_barrier() is needed for list type of =
sets=20
>>> only and that can be handled separately. So could you test the patch=20=

>>> below? According to my tests it is even a little bit faster than the=20=

>>> original code before synchronize_rcu() was added to swap.
>>=20
>> Confirmed~! This patch does fix the performance regression in my =
case.
>>=20
>> Hope it can fix ale.crismani@automattic.com's original issue.
>>=20
>>=20
>>=20
>> Thanks~
>> David
>=20
>=20
> Thanks for all the help on this, I'll try the patch tomorrow hopefully =
and will report back!
>=20
> best wishes,
> Ale


I applied the patch on 6.1.y on top of 875ee3a and I can confirm it =
fixes the performance issues in our case too.

Thanks once more for having looked at this!
Ale=

