Return-Path: <linux-kernel+bounces-22475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F279829E32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987B128A7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1162F4CB35;
	Wed, 10 Jan 2024 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hMlVxTcT"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887884C62A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40AG5aj33097971
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 10 Jan 2024 08:05:36 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40AG5aj33097971
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1704902737;
	bh=c3SD6krcaN3L4ZV1t0ZZX8uNTqKCQJfuhVX1apshMB4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hMlVxTcT7qIs++aUT5R5AudmXgqK1tKZlejBPp+/qzmjVLk+ldoEfQ+3wUA/zIICa
	 /D0R9/DaniDate3SQUNMe4xJ2WLovBYkEU5caCEx9fr2xjHdpHFd1pUYrthiKnXHwf
	 mQJW7KAkoh+FaSGNGj93epBiiX2VKz02m6U+Owwb3+TIFwy91y18qLrEUPCKcff4Nl
	 uews7lGJYOJaLjR8BJ0OYXQ0j2zWsJ2pBKpcEWM1JHDtCf1a2IXKRfeE/6Ivo4iO92
	 SEoM1cPtzLzfeUDuazBpakHriF0xOc0Kx2aQ5MpER4gmxHFNBQHYQEiS0N2YG836DX
	 h2TpY6cbtFsbA==
Date: Wed, 10 Jan 2024 08:05:33 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Neal Gompa <neal@gompa.dev>
CC: jirislaby@kernel.org, dhowells@redhat.com, linux-kernel@vger.kernel.org,
        pinskia@gmail.com, kent.overstreet@linux.dev
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
User-Agent: K-9 Mail for Android
In-Reply-To: <20240110155233.GA623732@nvidia.com>
References: <938ebce3-74c5-4fcf-9de3-849271d3581d@kernel.org> <20240110130456.142763-1-neal@gompa.dev> <20240110155233.GA623732@nvidia.com>
Message-ID: <B3A41699-C200-4174-9820-6BFA0B6742DD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

SFINAE giving inscrutable errors is why I'm saying C++20, since "concept" m=
eans you can get usable error messages=2E

