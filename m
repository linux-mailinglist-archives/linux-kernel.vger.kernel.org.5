Return-Path: <linux-kernel+bounces-98290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03C38777F4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C640281586
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3E539ADB;
	Sun, 10 Mar 2024 18:16:02 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A723984A
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710094561; cv=none; b=tmvcYIG+JNCUtYzpC8S63WxtG/pA7NFmRtfWIMuQq3gdOOmKBrWmwHnFh7BhF8RcogA/pugzJtTpW9jYHmMdEKRSrK4IiDe24ZNskJPgurOyWcptNLHipF2BT7wV0zL3QS255VJ74lxo53PgSpPmRIGBuw5xDh37yVO7VtQynok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710094561; c=relaxed/simple;
	bh=Qx07yZjSZ7SbcPOXqmK826JgccBle9qSUP1spG7BlnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NIdglsopqQz/cqtnkuHUSe1E2BH2Sb5Tu6RJdUooHmh6RAaLXUVgZU8mGL4a4V7zWbwtYYx5Rwc4wLg4KIdD7scrSRHwMZlRbGhVNfZn056sEnKqVxWdh/BVJo9OkDMpySlpt3dHGsSI18Ud8iv+784AmmYHS/erz60SN4xDvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-287-zx9oxXdGOaq_m6L14ONI6A-1; Sun, 10 Mar 2024 18:15:56 +0000
X-MC-Unique: zx9oxXdGOaq_m6L14ONI6A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 10 Mar
 2024 18:16:06 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 10 Mar 2024 18:16:06 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Steven Rostedt' <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [for-linus][PATCH 0/3] tracing: Fixes for v6.8
Thread-Topic: [for-linus][PATCH 0/3] tracing: Fixes for v6.8
Thread-Index: AQHab/YPIm1nuew0EUiHLmodmjEdKrExTS0w
Date: Sun, 10 Mar 2024 18:16:06 +0000
Message-ID: <550b6c44aa434b5b91e999a8d073527c@AcuMS.aculab.com>
References: <20240306184244.754263547@goodmis.org>
In-Reply-To: <20240306184244.754263547@goodmis.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

..
>   Another issue that was brought up is that the trace_seq buffer is
>   also based on PAGE_SIZE even though it is not tied to the architecture
>   limit like the ring buffer sub-buffer is. Having it be 64K * 2 is
>   simply just too big and wasting memory on systems with 64K page sizes.
>   It is now hardcoded to 8K which is what all other architectures with
>   4K PAGE_SIZE has.

Does Linux use a 2k PAGE_SIZE on any architectures?
IIRC m68k hardware has a 2k page, but Linux might always pair them.
A 2k page might (or might not) cause grief.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


