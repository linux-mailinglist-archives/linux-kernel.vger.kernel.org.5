Return-Path: <linux-kernel+bounces-162747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63C18B6004
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F111C21DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124CB86658;
	Mon, 29 Apr 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Octz1rqy"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A886634;
	Mon, 29 Apr 2024 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714411597; cv=none; b=AOEpu64U8nfSWg6xgbQbwiYAHKBFyg7M2Jm0YxKTLHTp+ULLnQ4z2v1Y+Kiwony0hmCsCjHYHFyo9ckCV912ZoDLbMVy+f1brC8UsPhp6Ij2G7c3xZgW6SVfANZ1RQvwxTSQBtiW5Z4RiOHDCAQYl/UjioWmSdk2z7ro03VF68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714411597; c=relaxed/simple;
	bh=w07M/vaw50sNjlO6CMuybn5nRpOkqiRmdT3SgCEP3Jo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AO+6u4vXnfV2Lths1bHfIyVYaNP28BDdCmjSinkRHPwO/r4cvMbnXAfPwzqWq5vPSYbfH/FR87pptK0LRLsw8rQXwcO5rrXTOHAOKKRcstkF2eHFLabYBxcpKC2afC3CkbydY1tb3UpkWGluIhZHabv1Xn/BgwVzrN7mbB8O6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Octz1rqy; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r4nv9lqGpL5EGgvBQaVdji0KjEOJdAny/DoV/cKu4uk=; t=1714411593; x=1715016393; 
	b=Octz1rqyfZo7K6W/ymQfTxjwICJOwp/HULD0VUNVqB9WB6BUrELf9S2I9m9oAi5MYU1Wpbah3XR
	6z/SYETmHwgqvGl8IltZUR5yV7Jmj9gA0qtPNNC8KI0pZEZn0BRvg1C/IaTrYE617B1P3TSOxhS3A
	tlqgvLzd4Hh5KGQtACi0w/BJIEtDY1JNwr4ArXudopddIKyIz6Mq9lPdp6OpxPA09pjgdb3O+YVW4
	29ifsy3t4ZUMrx+ncUbp1HQA1375JW5Ox9bqADyiXdJfbawFAnIeQ9KJWJyBAHc80A5QRBer61+l9
	Px+ovkS3Meku+iBp5IgU/8tlhPZRCzUdzxow==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s1Ulp-00000002bEb-2d8Z; Mon, 29 Apr 2024 19:26:29 +0200
Received: from dynamic-077-191-138-057.77.191.pool.telefonica.de ([77.191.138.57] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s1Ulp-00000003Dr9-1kVo; Mon, 29 Apr 2024 19:26:29 +0200
Message-ID: <9b3f9acd208842bb3c419b7f9bb40e1fe98f0c40.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: Call paging_init() earlier in the init sequence
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: akpm@linux-foundation.org, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, kernel@quicinc.com, Rob
 Herring <robh@kernel.org>
Date: Mon, 29 Apr 2024 19:26:28 +0200
In-Reply-To: <b7296e60-1911-4302-b472-b0ae11cd3d87@quicinc.com>
References: <20240423233150.74302-1-quic_obabatun@quicinc.com>
	 <6ba5b226dfcbae3d9c789bb6943089621b315d65.camel@physik.fu-berlin.de>
	 <b7296e60-1911-4302-b472-b0ae11cd3d87@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Oreoluwa,

On Mon, 2024-04-29 at 09:28 -0700, Oreoluwa Babatunde wrote:
> Here are links to the corresponding changes on Loongarch and Openrisc.
>=20
> - Loongarch:
> https://lore.kernel.org/all/20240218151403.2206980-1-chenhuacai@loongson.=
cn/
>=20
> - Openrisc:
> https://lore.kernel.org/all/1707524971-146908-3-git-send-email-quic_obaba=
tun@quicinc.com/

Great, thanks a lot! I will apply all reviewed patches to my sh-linux tree =
tomorrow.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

