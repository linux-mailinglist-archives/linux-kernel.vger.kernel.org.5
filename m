Return-Path: <linux-kernel+bounces-165390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B1C8B8C28
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1189A1C208BB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4F912DD83;
	Wed,  1 May 2024 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Z49Tqcwb"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40FA51036;
	Wed,  1 May 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575005; cv=none; b=rrxWpnPkRrdhP1NLCikeUldbKbjf+UlQpvKuhgv1gVJcSiC6N/sI4rilsxJzdMbm/fNlN8YRePPEK2CsKvCXIZxFh/zhT0IWmK68DQqB6mdgFNXJROc2Dwh9qG1cU0FTzk/pJ9BCjjWEN7n3GIz0Fb5Xqw1lnYCrF356EIvGZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575005; c=relaxed/simple;
	bh=sLvBTfpmmzucnDRKj1TzzUegK7SP40wGOpJjCskyQEM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rVbpvr99KuO8dqgBq1XED4nB/PhykngDRoWn1WWjg4MWPG2Vh8KyJdbfIRe3hMHJC/sPgEFyjrNH5kvel+BSJbke6aFVM7znZS5p7bzBC/0ubKH1oKRIjajn1J1uc0sRd0vxO1LJ3TQ37jOEC665lFg7vB6mpdleeNgu3hMwVUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Z49Tqcwb; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G1c8VPPjpU8t54HGr8jcj9ZiacIyUIRMTCeFMOj4sFo=; t=1714575001; x=1715179801; 
	b=Z49TqcwbWA5mkNFu3LRleuPeESjWiSSev92/eo2BBnJXgqDTJk1GVsYYaJHIwkfKe1Zaqje1cJT
	xxItZYJI6n7n4bbMN9FQWfBoGkS2IDan19wK4G5aimoBPOs1FC9L+eEVGEU08nOAqusm8GJdU1zBy
	uWU+lGtwADRZt0osieNdzx8YsS35ja0VQAJUDZ0+epRtcjW5QPHoeuY2AigvTQSO+9WoQAOsF1xtO
	3i3hWCKFJ2Kuo5eNBhKAHVeYSGUmEuSBl9uvkKtarEfKqTBWcp+ip4y3kkmiZxXITTS1IKR0n/w59
	Yi7XXz38MWWkkmit30/rdM+licflNvwm9Tmg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2BHT-00000001RII-1EfU; Wed, 01 May 2024 16:49:59 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2BHT-00000001IKZ-0Lkx; Wed, 01 May 2024 16:49:59 +0200
Message-ID: <429f4343463b824e4e5e33b87b275e35464b0721.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] Revert "sh: Handle calling csum_partial with misaligned
 data"
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>,  linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 01 May 2024 16:49:58 +0200
In-Reply-To: <a489b335-9174-40b1-8ffd-a34eb83fa8c3@roeck-us.net>
References: <20240324231804.841099-1-linux@roeck-us.net>
	 <059d03a5da257660fa0bc188c6cc8d0152e97704.camel@physik.fu-berlin.de>
	 <a9ac59cd-82db-45a0-9f85-ec3880c54dbf@roeck-us.net>
	 <cb8d3d2a-b843-49d5-a219-10a29b5877d0@roeck-us.net>
	 <1e77ade4fb1d924ffaf226cb946ba3314ba59a1d.camel@physik.fu-berlin.de>
	 <fb0293d85dbf82341c6b7e4d56fe8f1d23f7768a.camel@physik.fu-berlin.de>
	 <a489b335-9174-40b1-8ffd-a34eb83fa8c3@roeck-us.net>
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

On Wed, 2024-05-01 at 07:44 -0700, Guenter Roeck wrote:
> On Wed, May 01, 2024 at 10:28:11AM +0200, John Paul Adrian Glaubitz wrote=
:
> > > > Did you have time to test this on real hardware ?
> > >=20
> > > Not yet. I just returned from Easter holidays and need to get synced =
with work first.
> >=20
> > I might have to skip this for v6.10 as I haven't been able to test this=
 yet.
> >=20
> > I agree with the change in general, but I want to make sure I can repro=
duce
> > this on real hardware.
> >=20
>=20
> No worries, This is not a new problem, after all, so it doesn't really ma=
ke
> much of a difference.

OK, thanks. I'll be happy when I'm though with Geert's two series which tak=
e
quite some time to review.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

