Return-Path: <linux-kernel+bounces-157142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5EE8B0D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63ECB1C24A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC90715EFBE;
	Wed, 24 Apr 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="D5lHqkVs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qMC62mhU"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EA415B15C;
	Wed, 24 Apr 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970665; cv=none; b=u78pg77VeAL0xFw3DakpiNOxWbreLm/DUxF2w1EIy2jvsjbfwpGxlPjVeTiHp56j3GkqJ6/9kB+IT79ogKn2c+gz1eYbSdExJn45KLTNNLPp6sA816OtcqngP9ngOLDIRIW64l9lySmwvS/wufvy/U04rea2HGuKYhGmmIqgmbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970665; c=relaxed/simple;
	bh=yHNt98WidbxCEeSX3RQ9DOoGRKU6MVAVqIFcGJI8Vog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XlwhIJw4i8L5nyX1WO55+CwNsKA27XdSj3u0whw/Zk+Ao4zriFawh/5XQjTkqeJ0lBRKsVaNWzaU6JLI/V2C+k9A81uX9JZ3zxtECpJlobrgtzbx0BcTpfdYUAFXac5JbCqz+Hnwj0D8SlC8AG6IqCdUH3R4tg3QI7yrS0UHjuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=D5lHqkVs; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qMC62mhU reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713970661; x=1745506661;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yHNt98WidbxCEeSX3RQ9DOoGRKU6MVAVqIFcGJI8Vog=;
  b=D5lHqkVscU5glOSgQUUHcuOKmFw5kaE+heJuAfGODyVpxz1DUCjfFOKu
   ywCxqh+uL77ovg3SMm2cXaasFNR2ouZxjnArgSHd8Jjc23iyUKByAtsYN
   Ze030UcsPC7SnBo28WgWmo7PAu1TSXldzsBHYFFKBz12heTMkccoJiCEa
   ogRcpy3jTOl5/T1bDyas910B77Pdx0IAKHok+7W7Sjx4mYnBfhX6i4u5Q
   ewE6suTUoRuN8dI00DexmlhozlWTXDntwiXZW0ZT9K6JJTCtxcCGkNfXH
   HnmQBPElYCR3fn8f60Qmubu7UeSbFPprfUSuKNepl28NgJtYIyE8DL7vM
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,226,1708383600"; 
   d="scan'208";a="36595123"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Apr 2024 16:57:38 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77C14170C3E;
	Wed, 24 Apr 2024 16:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713970654;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yHNt98WidbxCEeSX3RQ9DOoGRKU6MVAVqIFcGJI8Vog=;
	b=qMC62mhU5FeXGOga50JZBVDVdw4aoIP3fFcOoOI1P+nbGx/KsJZrVoFMSg9Xoj0K8gmb+S
	ZQlyrxaQ9ze5OeNfEVZ6by2w7qW2ffBuVQ4nJ6/ecPKbsbz1Ql1w7mYSMoubOLfcz/nbni
	Fv/wsQR0WEQn+Q8UfI2i0fEkvouaCRRpE3+VswggJyXIczSv2zhR1Jy/rLcJzEvrU7UJst
	cyiqE/2LRyFG6xVULxjlh4NYDcySSE67VdtIyG+n1x64fYk4JKXoxt+SHnbyofDOozPqtP
	QvjY9xDoJnKEmrdcIF2e3ilXSHtw3OkbiOgO0EWR1P2SrU3W33/4+p9gpFHb3g==
Message-ID: <5426c24a215b363e7b9b03a97d023d2e29b6a0a7.camel@ew.tq-group.com>
Subject: Re: [PATCH net-next] net: phy: marvell: add support for MV88E6020
 internal PHYs
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux@ew.tq-group.com
Date: Wed, 24 Apr 2024 16:57:24 +0200
In-Reply-To: <64dbfe14-e777-49e2-ab7d-ec6fa517a8f1@lunn.ch>
References: <20240424121022.160920-1-matthias.schiffer@ew.tq-group.com>
	 <19c4b8da-203e-4a81-9531-9ba4a4f750fd@lunn.ch>
	 <1cb8bafb44075858221b31c056d75a40d7ba2ee1.camel@ew.tq-group.com>
	 <64dbfe14-e777-49e2-ab7d-ec6fa517a8f1@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 2024-04-24 at 16:52 +0200, Andrew Lunn wrote:
> > We currently do not override the PHY ID for this family in the DSA
> > driver - my understanding was that this is only necessary for
> > switches that don't provide a usable PHY ID at all. As I have no
> > idea if this PHY ID works for the whole family or just the single
> > switch, I went with the more specific naming here.
>=20
> The 'broken' switches have the Marvell OUI, but no module number. From
> your description it sounds like the 6250 is the same?
>=20

No, the PHYs have a proper ID, 0x01410db0. The "Functional Spec" for the 88=
E6020 switch family gives
us the 0x01410c00 part, but the lower 10 bits are undocumented ("reserved")=
, and I don't know if
they differ for each individual switch of the family, as I only have a 88E6=
020 here.

Matthias



--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

