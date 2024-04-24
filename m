Return-Path: <linux-kernel+bounces-156525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C9B8B03EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48317282888
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214A158855;
	Wed, 24 Apr 2024 08:11:30 +0000 (UTC)
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E569A158202;
	Wed, 24 Apr 2024 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946290; cv=none; b=YNsTecWaG9ODwxfnhhYn/ZKIdvOa3YW7zotNWxygjZwZBtldQTJqtM3t11DHvFffga8ry/jImls3nDeJLZuViJaZRuqeAJj1InOAW7KVjWrT6JNudRwoggOsskiw9YK3PQ9j14TVDCDtisHnNRFmT773P/FZ0ezpPdpQTXfUMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946290; c=relaxed/simple;
	bh=7HDc/MqVQCPWa5gWooNoBrslr6ONAaNmJF3PdVsJytY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GLUkwtRApVLeUjBqXMUSE7NwQ8PutXnIFSO5V+4kw592Gg4uqbzBxDV6VxJTw5v5xXx6P2AyPdxygU/GJOXzj8oAIG27x4dA1lhgWifeJGOggQh0iUnqg1JxO7UT5tlXV9PKzMgvJndefuv2RLozM9itD0U9YEANXzv9v3PF5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4fefc49c.dip0.t-ipconnect.de [79.239.196.156])
	by mail.holtmann.org (Postfix) with ESMTPSA id 979D1CECBE;
	Wed, 24 Apr 2024 10:11:20 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <PA4PR04MB96389E67F826216C44FE19FFD1112@PA4PR04MB9638.eurprd04.prod.outlook.com>
Date: Wed, 24 Apr 2024 10:11:10 +0200
Cc: Brian Norris <briannorris@chromium.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Kalle Valo <kvalo@kernel.org>,
 "francesco@dolcini.it" <francesco@dolcini.it>,
 Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
 "rafael.beims" <rafael.beims@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8F76484-1359-437B-85BF-C646A21F7BCE@holtmann.org>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org>
 <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZiLlPOvKlfCySZwF@google.com>
 <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96389E67F826216C44FE19FFD1112@PA4PR04MB9638.eurprd04.prod.outlook.com>
To: David Lin <yu-hao.lin@nxp.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi David,

> Johannes agreed that cfg80211 is the correct way for the development =
of mwifiex
> (mac80211 can't offload association process to driver/FW).

that was never my question here.

> This patch is used to fully leverage SME of wpa_supplicant and hostapd =
which can complete the missing WPA3 feature of mwifiex.
> The patch series had been reviewed and discussed. It looks like there =
is no more comments for patch v10.
> I wonder can patch v10 be accepted by you?

If your hardware is a FullMac hardware then what is the point in now =
separating
auth/assoc out. Is this done just for WPA3 or also for WPA2/WPA1. Are =
you no
longer a FullMac hardware?

You keep saying that you just want to support WPA3 and if previously the =
HW
worked as FullMac hardware, then external_auth should be the way to go =
for
having SAE handled by wpa_supplicant (or iwd for that matter).

Now if you are fully embracing to auth/assoc and we can remove the =
support
for the connect ops, then lets do it. However I don=E2=80=99t see =
anything properly
described in the commit message. You keep saying WPA3 support and =
nothing
else explain what the new Key V2 API of the firmware would do.

Regards

Marcel


