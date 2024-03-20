Return-Path: <linux-kernel+bounces-108670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A51880E37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880831F23142
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B47338FA0;
	Wed, 20 Mar 2024 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pkbhoZLW"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048723B791;
	Wed, 20 Mar 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925430; cv=none; b=XJdyPMDw4jUAF13w9rdD+AL1dRKlUjaygOTulYRjedAF0No2M8vP19gON6DvWv2tAmpIVWQr378kLiJXSyG9MD2HSrcDv1xGeKuOIQvWdgP5TYaek/CDktuZyh9T6enWgpSVFvhHc+RCmlUXXa3QEkMcK3JEYGohZhIL3f3OinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925430; c=relaxed/simple;
	bh=ajQewOq3z6kaZJsImjXe5I9M1OMxJ07y6xZgj3AxAWs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HNw8m4BFF1mgfJNIyZ4EtnUIEFJcsQZTaKl/BsOa965khOTy36zpHnz+FDgMG4bKKnDBZC7zRhX6LyGcSP17jzw4BGZ/8XmzcU/sOOhuLjG1ivcokaE3t4XcC3bR7/OYbrMlw/f4u+hH5ESm0K2Z9mD6XnykDhZX9KEQnLFgq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pkbhoZLW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tZqcChox9CcHzEf0v2PKkwHSnC5LQfuFi9qz0i1saPE=;
	t=1710925428; x=1712135028; b=pkbhoZLWOaWUotWk2wlSAZuhtswfw5tJ5ctb9qAhvsT3Jlo
	0jpavuXQhcW8QhjIWpUgwHSs2HqUmqinU+HRYmpy6xbqIXkYT8NLKQ2VhBFC7N4Wfy7svp8zpUxPr
	gsK+B+41eYsz0dj3cOgyu00JGi5vPu1qU1MnVKjoB5ZtdC4cU84Xx4qaCo6lHMiCTAx9CyIcxa95a
	9urn6mLGKA0xMlqeFj91KIqQCCEmHwUlCPTwhpaV5tM8b8HkTYFJzIjabl0vmg6tUEFPbERS1ME3M
	CfQYHLESjNCeoZLXBZZYZk6JBYgRve0/f/Qt6/rxogKmL0dNJTLOY3o2sOw1iR6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rmrrJ-00000006tf1-3zv6;
	Wed, 20 Mar 2024 10:03:42 +0100
Message-ID: <e7204512f71e9232572fced208899f7b6baa920d.camel@sipsolutions.net>
Subject: Re: [RFC] wireless: ti: Can we just remove this flexible array?
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Jeff Johnson
	 <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org
Date: Wed, 20 Mar 2024 10:03:40 +0100
In-Reply-To: <483362b8-ea79-4036-89eb-d6ab737e1e96@embeddedor.com>
References: <3a531d5b-9bf6-4e88-ba8c-a76cfa95be20@embeddedor.com>
	 <328306d9-953f-482b-bf9a-a753d7d4e2ed@quicinc.com>
	 <483362b8-ea79-4036-89eb-d6ab737e1e96@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-19 at 18:42 -0600, Gustavo A. R. Silva wrote:
>=20
> > > -       /* payload */
> > > -       u8 data[];
> > >    } __packed;
> >=20

Why not keep (or even add in the cases where it's not) the comment
though?

johannes

