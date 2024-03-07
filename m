Return-Path: <linux-kernel+bounces-95354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4460C874CA9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92B8B227CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C589A85643;
	Thu,  7 Mar 2024 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="x8FGPlKd"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A50839F6;
	Thu,  7 Mar 2024 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808451; cv=none; b=tg4uKQpDlGox6xvMvJo+TgCmWmqF1gmHE+EcsiYXiGXX3xmE8goVMXdE5D9apa7a/SkRAgXQxmb9JNECqyT4gspe1bFFEt1Qxeyrs0QOxrN7KZd1AHzeBPispv3wSuk3iS46DUn2T1vcL1otknj0woa9ZfflPoLYva/NbnHsXck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808451; c=relaxed/simple;
	bh=i0lDZeGH5UKbhkAAP9E9Zdgf2J/oVw2oSwdfminksT8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WZHNIpnAlL8fWXQlvFigSgz8TOPEnBpMZwN1vfyL/wzJGBYY8d/Q56WDL84mgl7HJbYU5GxdpVK7meHa0+QQsYunKVhAOHR6WTq/UTyg6jNOx8d43Rgi0sya/NQtGjimA2tCsgXrJ9mVmj1Xcz8GywSsFg6wLynWo6zRojvYuus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=x8FGPlKd; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 05ED59C47A0;
	Thu,  7 Mar 2024 05:47:24 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id MvV_bMyc-VL5; Thu,  7 Mar 2024 05:47:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 573869C4AC5;
	Thu,  7 Mar 2024 05:47:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 573869C4AC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1709808442; bh=i0lDZeGH5UKbhkAAP9E9Zdgf2J/oVw2oSwdfminksT8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=x8FGPlKdSLDTGimD+q+tiLvLOHVYUfy192hnbF6NpAfKaUWV2r0/2YTvTYbcf1UFm
	 5rDSosOSRAqKpPa3YKQE+RJxPI3Uo527ch9oL+U8sh82+nd7qumxVv0v80JtMwi6lt
	 A5mgwT9tC9kb4yZCcnyffV+ZrSdzkJx1K7MW/o96nKSMR4xjC422agbjfqZuErWqNZ
	 Ah0/irhD1QKH5UsnoY2/o9NxfYpRedszlmqq40BgznNSGOgaPUCDFDjonda0AaTjcP
	 jjJqw13BHkiWH9TPSAynknE75mZY+guPG+C6zZJfIlpRFPN/UoBz8tMhceuGHE6NlV
	 5R0DOgH5bOK8w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id WUO1xUb3eM7u; Thu,  7 Mar 2024 05:47:22 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2C5BA9C47A0;
	Thu,  7 Mar 2024 05:47:22 -0500 (EST)
Date: Thu, 7 Mar 2024 05:47:22 -0500 (EST)
From: =?utf-8?Q?K=C3=A9vin_L=27h=C3=B4pital?= <kevin.lhopital@savoirfairelinux.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Dan Murphy <dmurphy@ti.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Message-ID: <1992141776.1592829.1709808442035.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <ZemOp4MGP/UK31wq@shell.armlinux.org.uk>
References: <20240307085254.183905-1-kevin.lhopital@savoirfairelinux.com> <ZemOp4MGP/UK31wq@shell.armlinux.org.uk>
Subject: Re: [PATCH] net: phy: fix phy_get_internal_delay accessing an empty
 array
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - FF123 (Linux)/8.8.15_GA_4581)
Thread-Topic: fix phy_get_internal_delay accessing an empty array
Thread-Index: juNkTQ67iC3rqV83oDhFVEulGn7U9A==


----- Le 7 Mar 24, =C3=A0 10:53, Russell King (Oracle) linux@armlinux.org.u=
k a =C3=A9crit :

> On Thu, Mar 07, 2024 at 09:52:54AM +0100, K=C3=A9vin L'h=C3=B4pital wrote=
:
>> The phy_get_internal_delay function could try to access to an empty
>> array in the case that the driver is calling phy_get_internal_delay
>> without defining delay_values and rx-internal-delay-ps or
>> tx-internal-delay-ps is defined to 0 in the device-tree.
>> This will lead to "unable to handle kernel NULL pointer dereference at
>> virtual address 0". To avoid this kernel oops, the test should be delay
>> >=3D 0. As there is already delay < 0 test just before, the test could
>> only be size =3D=3D 0.
>>=20
>> Fixes: 92252eec913b ("net: phy: Add a helper to return the index for of =
the
>> internal delay")
>> Signed-off-by: K=C3=A9vin L'h=C3=B4pital <kevin.lhopital@savoirfairelinu=
x.com>
>> Signed-off-by: Enguerrand de Ribaucourt
>> <enguerrand.de-ribaucourt@savoirfairelinux.com>
>=20
> The sign-offs look wrong to me. They indicate the path that the patch is
> taking to be merged into mainline. Who is the author of this patch and
> who is passing it along? If it's co-development, then there is a specific
> tag for that.
>=20
> For the actual patch itself:
>=20
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>=20
> Thanks!
>=20
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

I will send a V2 fixing this, thank you.

K=C3=A9vin L'h=C3=B4pital=20


