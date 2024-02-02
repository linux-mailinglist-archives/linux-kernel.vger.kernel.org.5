Return-Path: <linux-kernel+bounces-50540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBD0847A72
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0E3B26D14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FDF8175C;
	Fri,  2 Feb 2024 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G8C10dje"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECA28062A;
	Fri,  2 Feb 2024 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706905330; cv=none; b=lKU5dZ0TJ0vdbVDiciyr8AjkONtievE8yUtA0CAcLxkyF6/jWYjeT21K9vJKuClB2X7VVizbdSvsi/ZJm6ESqvRRUBDLiidYXFqvljgJikdM3BZihOpGjOrdHyRBzPTYroUGkVOkIS+TVhIgFK0/Ca/o50tzFsCibW7hmuF853g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706905330; c=relaxed/simple;
	bh=Q2m/2wszr55453umWWxAgsLwrfW/dmW8Ii0UsK5l6PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNAspKSZSc0FKEev0E921pT3RJMzJzpDoPo30Y7KF/RRoN0eTrmLVkW7i+nwYoqQBkKrLthb3uEu9dsON89WiHqQGptnRJwcfWKjBxAViXVZjhJKNz4Ng0c4+pepav0h7+mbuoFDnjUblP6wrARVBQFLnfqnvLOj5JluZz6SLqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=G8C10dje; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706905298; x=1707510098; i=markus.elfring@web.de;
	bh=Q2m/2wszr55453umWWxAgsLwrfW/dmW8Ii0UsK5l6PM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=G8C10djeXh5lOZvU247Dn+9Cm7OL0cH/D1Bl7WRpbIO2WUKq6yMS521XEpMvH11G
	 WRc1JCbYGrSI15XggN2RCra71OGpZkOw/2pMmYBAyRP02aCEoaMjo17NonpG7dho1
	 yMhEmSatRaN1UzQVYk3O0LFCT0q8ylU80Dg71ThxyrJ6FmDQIZHPGmNNoF3FfSEYk
	 isnxm9vgAhHTnXuxxAg3+TNrXnCN7Ub6cRk4KYRxDOmY6Ym36usxl903tLabYsvNv
	 SjkoKSBKfbZoeLvoa2+xR1kYH6sc07rftcALRcZ+fYHMe5Qk4zhVfR4o1fssmy9li
	 +yh3SSzuItAQLfhwEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlbLM-1qoioK00NG-00iZ9I; Fri, 02
 Feb 2024 21:21:38 +0100
Message-ID: <1a3c05b8-45f8-4205-8cb5-3b8f2d791877@web.de>
Date: Fri, 2 Feb 2024 21:21:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: clk: imx: scu: Use common error handling code in
 __imx_clk_gpr_scu()
To: Abel Vesa <abel.vesa@linaro.org>, kernel@pengutronix.de,
 linux-imx@nxp.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-janitors@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <20231210171907.3410922-1-visitorckw@gmail.com>
 <0e906ec6-fe73-4dbd-b555-a2c03b6e1030@web.de> <Zb04UUeE/cU9HtKZ@linaro.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Zb04UUeE/cU9HtKZ@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CSJNiI+KQkY3wXk46J8sqBLCgeytL9YGPMpnE6bhxbHLS1ujsvH
 WtIcKGpQpstSECuHkRUVRn7udhpV/cp9kKG3djHijk+tDqEvugBIpO3jvDiEAqjrmsEDchj
 EB/bFJ8Rrbp+rgxqrwcoYmApEj+c4vj/lGSZtItFepLt/wAggTQ5pyAma0iq4NKvir+Oe1Q
 K195UfBoLASAs8DyCP3XQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wMEpts7wPes=;A2mzpRYQ4imzka4vF4y/w2Bur/w
 +FcbRBULuHCiHAEiLUmpDmxYIoiEltOqt4+UAk/GlKEpka4Jn5xgjW1J+CEP9gFrwJB3OlNFj
 FJr4Ol1aVJgaGQ+I3MuQYaZOCVyjPu69gnwqMW8PAoBRa3z8C8bthaxs/4GvWMAmhWSpUCj4M
 K8TumhrqIE+EdrRpNSOiUe0gCQLuB3kFtQvIvhjHiWB8O98aP8if4f1E0KD5sj7ZJC7TzYlxy
 CjC4T1SDfC3Aiu9wwDuQbqzh0MB1vGCueyN6gBcoqrrrckDnwkUAaYEP5L/NWLM6/Kwp+mWks
 aMlsR0gYgdFWcCZmF3y3zlGgLeHfZ5Dm+gy1Zms2zcwWokaTBClVb/NCL32Vdir/5vKhdmouv
 PGBVxFZ77RhVflIUxRMPQiyAbfQzb/Coghset1BFN5oKKZV6GXUZP9b+DERLK9p4Bg3hS5IXf
 WckBsAsM6SRD1eXkK3sHAfX50iFQHIEQ4MKOpHQFEZuU0H5zFP/Ku/6oEXISDQ3MVa1jNUzAB
 F94sq+123wtyPRNE7ozcyCqYsPRU+zrmf7meIQpP5n8ALO8XSA86QlQh/YgE7o2abTUggMKfh
 XaPy+YMek2mKIegRxReEA6k4bjJHfVsMzxccWG+3LwXzDgx0fNNASGZxHBR1M7Ko1DdnAYQeg
 GkRwilOySYpq3y+oaBWb18XmC11HyOKkIwYkgsZ8ZexZ3B3rYcsSSpYplPZ8Hk9mjoYPZGpcJ
 YhCslGURNYJTpxQOU5y0V+K7LV1Fv7wgpLLc0lPOj+sI/hnMnGZN/bNP4SWTuSkw/ThjnYK2R
 5/y3ncMmAVC/iinfzzKk+KQynOb3EdQWFAZGl/bFksZyQ=

>> Use another label so that a bit of exception handling can be better reu=
sed
>> at the end of this function.
>
> Please don't send patches as reply to other(s) patches.

This is a general possibility to connect an information sources with
a corresponding change idea.
Will the acceptance grow for the presented source code transformation?

Regards,
Markus

