Return-Path: <linux-kernel+bounces-108983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18C48812FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A669E1F247D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75D43146;
	Wed, 20 Mar 2024 14:09:44 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038193EA98
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943784; cv=none; b=UBAfLncNcMad+BNZ3502gzUQV+3KrYjH/2lIDRtIlZ0A3z1KVIY7aBp3ndTjmOAP63hJwtvi5Dv6HkXumkZ9wPyzg+ZLDurNkSQJv1hf+Q0E7p9Cfr+iRb27GEoSCU4ge8iV2vgV0XJRExT1SceoojxqD028CTztc8ygG1IdAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943784; c=relaxed/simple;
	bh=cUeoLhqhxAO/gfIfl0ulk6l/PXX+VNYlpSZYXY02GiY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hYsy3T+MQeff5wqnzdMh8r1TtP/ZgFvrKfiCyp/lycoO0efUznO7+Nx9S/Q38uZHZ2QzepQaVuvhGDcfdcQ6VdCfvnDqfe3+rEejkvl/ckZ0V0UTpPaNXL2y4X2oyBndeLPiLVvOELjI7BSKvbvbA6exc2QZgfOVHQVEGREpDSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A464A6451633;
	Wed, 20 Mar 2024 15:09:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id ZShp3J1YnL-t; Wed, 20 Mar 2024 15:09:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1E08D6451635;
	Wed, 20 Mar 2024 15:09:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6KDg9rbOOcsf; Wed, 20 Mar 2024 15:09:38 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id ED774645162C;
	Wed, 20 Mar 2024 15:09:37 +0100 (CET)
Date: Wed, 20 Mar 2024 15:09:37 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	petr <petr@tesarici.cz>
Message-ID: <156343757.79841.1710943777684.JavaMail.zimbra@nod.at>
In-Reply-To: <6a62f534-463f-45c4-a5ea-2c1021cf45d4@huaweicloud.com>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com> <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com> <8d45f94c-bce1-4327-9573-cec254a4e9c3@huaweicloud.com> <1418379493.78340.1710886685735.JavaMail.zimbra@nod.at> <6a62f534-463f-45c4-a5ea-2c1021cf45d4@huaweicloud.com>
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: oops on accessing a non-present page in the vmalloc area
Thread-Index: pOp1mjFQTnV9/3sqj8nu+xKmKml6Lw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Petr Tesarik" <petrtesarik@huaweicloud.com>
>> Yes. I'm just way behind my maintainer schedule. :-/
>=20
> Understood. Thank you for your reply.
>=20
> By the way, are you looking for more people to help with the amount of wo=
rk?

Yes, help is always welcome!
Johannes and Anton do already a great job but more maintenance power is alw=
ays good.
You could help with reviewing patches, testing stuff, etc. :-)
It's not that UML itself is a lot of work, it's just that $dayjob is not UM=
L related at all...

Thanks,
//richard

