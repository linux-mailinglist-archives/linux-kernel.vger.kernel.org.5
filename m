Return-Path: <linux-kernel+bounces-6997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB6681A05A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E84EB243BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153B5374DB;
	Wed, 20 Dec 2023 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jmBmrJHH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457A536AF6;
	Wed, 20 Dec 2023 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30F261C0004;
	Wed, 20 Dec 2023 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703080541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tWIpEAW+BnNLwW+nUhjUHHKtOBv1NjjJSAc83dB3i1U=;
	b=jmBmrJHHEZNWLfUXdiqWSrpF53WS2o+/03LuaAeqZFo+6aZ5BOeW/b5kRIXNS6PDfYcjN6
	3OBUPOVFULiKauybA1fyx540e1n1wYXq7NGp3VPDDulo0IlxdNBbFfPqps3o4H+tFE5Pk9
	Ol5zfKw6iv+c6yzLyZ3IGEgHHO7f0LWGZCjpJAbd2dbv77fh+lqpiAurxfdpoYi9ejqyXx
	kl2IMz2PryFQcxk9Nv8hut6FNXDhiA8XbqioXZ9TLTYGcYSIVP/oNopJ6kDupT0dwZKexL
	lNwaCXDmzXycBBOyF2LwJmNVD6QosIX5rJlYOABPII93rMUEFde0bCTBYxW9rw==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Sjoerd Simons <sjoerd@collabora.com>, Marek
	=?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc: kernel@collabora.com, Andrew Lunn <andrew@lunn.ch>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Moxtet bus fixes
In-Reply-To: <6c93241c35153cfb718db1d81e99e01bfb6dede5.camel@collabora.com>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
 <87fs0ceoif.fsf@BL-laptop> <20231208161724.5f4f626a@dellmb>
 <87fs03cyki.fsf@BL-laptop>
 <6c93241c35153cfb718db1d81e99e01bfb6dede5.camel@collabora.com>
Date: Wed, 20 Dec 2023 14:55:39 +0100
Message-ID: <87o7elash0.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com

Sjoerd Simons <sjoerd@collabora.com> writes:

> On Fri, 2023-12-15 at 15:47 +0100, Gregory CLEMENT wrote:
>> Marek Beh=C3=BAn <kabel@kernel.org> writes:
>>=20
>> > On Fri, 08 Dec 2023 15:51:20 +0100
>> > Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
>> >=20
>> > Gregory, as of yet I've never done a pull request. If you are
>> > willing
>> > to take all 3 patches now, please do. In the future I would like to
>>=20
>> OK I applied them on mvebu/driver.
>
> Thanks both for moving this patches forward; Gregory looks like you
> only applied two of the three patches (missing the dt patch), are you
> expect that to flow through a different tree or ?

The device tree patch is applied on mvebu/dt64, I've just pushed the
updated branch, but it was already in the for-next branch.

Gregory

>
>
> Regards,
> --=20
> Sjoerd Simons
> Collabora Ltd.

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

