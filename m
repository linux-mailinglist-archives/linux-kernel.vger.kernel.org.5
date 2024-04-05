Return-Path: <linux-kernel+bounces-132844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F18899B10
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028321C209D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A21161902;
	Fri,  5 Apr 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bLFZiVd1"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086936CDB7;
	Fri,  5 Apr 2024 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313781; cv=none; b=Kphkzt1ONV3viX7mE+nc779l3TSteQlJ/Czh0O2V+92dCujYKDSoR5DgympWETbuFUrIohlAjZYf5Gqr+BlJCDudD+jTa8u8oAoG/35lvz16GcMMFrexMEKU72s/KIKA+ah+U0S1IRTwWMLYWxq6xzCacLoYFE1NBG0rBwfj4H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313781; c=relaxed/simple;
	bh=lKVWj+/AvXPW1519XJYd+uB6uFezQ3USO+uYicvUnac=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GbOkGbzb4VDTGCIXUcZApweAIlJX9SDti9KwARLWl5AvvRiVse+9sz6KCgYmveANYhm2+rGaAcPUWxzSCLBmcENgMsJSUo1X3mAJuEWFggrL8yj92zoyxvAGzlD3Al4dsogG645+8aWKj2o6FRTHybVlg0bUlGe99xN60BaZfrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bLFZiVd1; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712313760; x=1712918560; i=markus.elfring@web.de;
	bh=zNWYX40W1sR7cyro409DdtaBN6sNKplV4C4Ty1gAp/k=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=bLFZiVd1AOHzG/gWAc8J6Aq8NfgSXVkf7g+tLHQskkS9GHJkP/eoN+JTJusBpHhq
	 Zl/aihewYdoxum5wtyGINUTjtmkOoW1lVrIBd2qFfOXUfnhwQkR/+KOB2e8VSyiXo
	 Sp16pVZOn8/JzrU9SSmVUZkrtylNhOBCamasFy4MQLi4SxqHEH49faR/4g+XMyEfK
	 D+s4bcQxLzHuXdrdgsYdEqd5N0ZH6WMWDsnvO1X/95k54saRr/6hHjHnOY69M1gKp
	 YMjRtA3mEQTjXAVdxks6bw7wV8uZkXQ8FxNaWY3EV8xXEnVSgqszklfsUv2a7KDX3
	 vfh/xQTOlDYztnFtAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9Zdw-1rvyI03cIu-005Z9d; Fri, 05
 Apr 2024 12:42:40 +0200
Message-ID: <f0cb08d3-00a5-4ed1-adf1-05f40875c510@web.de>
Date: Fri, 5 Apr 2024 12:42:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shahar Avidar <ikobh7@gmail.com>, linux-staging@lists.linux.dev,
 kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Felix N. Kimbu" <felixkimbu1@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240405074000.3481217-7-ikobh7@gmail.com>
Subject: Re: [PATCH v3 6/7] staging: pi433: Add debugfs_remove in case of
 driver register fails.
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240405074000.3481217-7-ikobh7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KQ/UTNT/usHK+HdybQjkUZDB2pvRZtNWt4AL66Ao63VqK2WxhE5
 RfxiFoIkS5tcsTfLKQQ3IQfDO6MovFbQtaU1YJJtBz1Bv09twP+Kaq4fmUdICSD2adkSd6I
 zHH50Z2xKyzpa40h1Jj+nbA5y4f5J270rLXy9jVeFAs9K2bTiSMYQTJ/9rhC7cqu/m1lBAa
 JzFNwSufVJ1FQkWKM+pEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sHoSA0adK7U=;BmEev2IrjKj4JG7kD3JEGVdUydM
 v7PvTR4wFJlwfSIwjIVZLAGnTd5SXewMjTxXRTFvpwMQJDIHygFahK8quWhIc7l8LImIBKxq3
 J2VyPDOXsStOGLcPfIRJN5tZjlVEbxBzUKBHGDpy06Is5fUrkvrheoWXET5U8XR8VY1oZj4Jh
 55TfsGXcuJGq5NzxmkHQ8E2495Z1/CuMPASm9Ff078ZqO2rKyKQIL6CvJdjNwzH8U9OSxOo+A
 xYCGHu5U/morsY1gqVsaCjCaoftyddEfr2M3/LX5fvS6ooDgXjIZisnqBuEQ02aZDmhdHti4X
 2PfjkuohfRK9ch4D8DtkthAPhXnO4MDeU88f4oPMsAkX+EID0w8XaJEyYk4aOboku8dRnjltI
 wFQXYEyLqH4ZXpOeME29aSJbbrZHvzSvDfp0VBOleXqoJLB+3EqFlpVbLuT6MtugTF6YSZD+W
 IxCxRf402jWu6fbuAETipbbKXugrtxgx5Re3jAQL4OccLXLg0QRrGUpI2BpbOVd8fUjuyVPkb
 p43VkE5f31ThKxgDQM1bQJV74c184SHCsAVnxGMABvt+gs6+zItM9Jh4dgUo2pMFPDV02L80P
 S8AyboP7uxCbeiwyKqyACTIOVDv35T9QY066xjEWBIp/PWGcNjmi3E71nF/xmxOE2vPfAaDy1
 9k6xGnMWc8vLZg5JuElv7sle5jz4DrXQaX6IbNMSmdj23X6qhsQYWdLx89qT+fGiFOVAG9WnO
 RRywZ7yRpRlsijuedh3zzIE5L9pc7rQDrKaV5szNV0ZnaHFMaDTp4EPkyFsmMrgTDzXkXVq0m
 i6KygoM1yRuFsS7sWKbL+LMAqtjNlu3Ll8fXvqDk/tgM8=

I suggest to use the summary phrase =E2=80=9CCall debugfs_remove() in case=
 of
driver registration failure in pi433_init()=E2=80=9D instead.


> debugfs resources were never cleaned in case of failure to register driv=
er.

How do you think about to use a change description like the following?

   Debugfs resources were not released after a call of
   the function =E2=80=9Cspi_register_driver=E2=80=9D failed.
   Thus fix the exception handling accordingly.


Regards,
Markus

