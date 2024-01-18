Return-Path: <linux-kernel+bounces-30061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55004831891
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D28F1C21F44
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA935241F7;
	Thu, 18 Jan 2024 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="KWAPDHtA"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D724B34;
	Thu, 18 Jan 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577938; cv=none; b=r9/IXmjJIPYcxXUEdf8yvUVmkUYxA100X/4W3U3ETdR1by0IZtKQ+P4VlAdY90aBvsdF5OafTf8yM6Vn3tEkoTgsV6PeFYz/uMG2DS51V+bhbfQd6j/iy+xELWWjA4EczQimXw8hh72st8jkMD1a6IxS7naz6pmFcJ0E2Xyuvv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577938; c=relaxed/simple;
	bh=c/DzI/EJtwNTt/biOBCBJkuhhi5FFYaQGErDt8KLdHg=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:To:Cc:Content-Language:Subject:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport; b=U3ReWN5GWJ88yYOd/BkVclgtnONLU2Pkxm8tW2aihmfX/nGo6P7emWNxV0BHXMgxmn9xT51N278zdqwRuRRltR9LCFv2jr1koLSQjZ00awQHOmjj5y6NqG/JmyKkukueG6Aw2Otj942qXC93676KJNPa3UPijFxpF6p/mptZIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=KWAPDHtA; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705577933; x=1706182733; i=rwarsow@gmx.de;
	bh=c/DzI/EJtwNTt/biOBCBJkuhhi5FFYaQGErDt8KLdHg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
	b=KWAPDHtABuqKPSOhl5LaaJrgMG5Vozsn+SGsdfhRtGwa0IgKHEHUG1YURDPzahjo
	 0yny2Vz3pmxq7RqEdgVnvrMcg8AOdAIZlsWya6AyzLJ5E4L/JKvJwUBf43+bxtB1u
	 K5jFGn5gQioiPq/Bh2y598fNBm9ujZi1O2qO6NlxJXpnPgrux3iN/Ow+1Yt+hHs3e
	 Qr6vgPRqXJYU2Hn77wsrdyP1PFtFrpv5aBiUnab+IRW9O1WiuX9aIb9tc6cLiOLW+
	 KCVRSEqZaw3Czf27vaagDf/LENzE+IUzFZuXgZIjQOQTmEMSAljN1f2tJfHvTg7/5
	 /VO1s2u6TOZUD67nsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.33.103]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMobO-1rjC2K3zUa-00IlHa; Thu, 18
 Jan 2024 12:38:53 +0100
Message-ID: <92ea8468-8359-4b38-9f4b-bb15661791fb@gmx.de>
Date: Thu, 18 Jan 2024 12:38:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2zDQvmTM+X4udMWypWxBLR2+qs6VfBv2ka3SxCCFnsWg40Pc8zb
 wtx/DzkLT+/9BmK6y8Vx8P8jxYC1S2DBpTWASmS9UxoQJuwnUyXm+q/XPsoZ4bfrbzJNHtl
 LSuCbKJowGM8fpF5SBpjVKVCDsBBrc57oCzmbWd+7mnNufydudw775PizpwDSOgJdsmgdeY
 obgceTAdfLoXBDS2YO8MA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rH3xUeSG0Pg=;GOP95DBKor4tqMsHpSbTGJAjuXh
 tTnkd+sYD08+EoHJXeF/tl6I34Y3cN8Pkf2XPvJpKncJI/SvTIaDv82iGi3O3mPBOT31frbbc
 GAomtcN5OTfeGZ3hKBJOSx5qSEEk9oJy4yTjFpYwqFIUPiPUGbvkcof/WjLYw9Y8F2Wlxu5uB
 hT9CmJ4pCqVNSreQS8lEJONHbmaIeslw1MWY9lc9j0XfbxaYh554B0vAOgKKnr8CIWNJ2xZu4
 r/f1shuEo49NFwJLdz//Tl52Fw7NaHvFx3KuQsViJUV70soRKSUOeoy5kv6lkotA0wiivrOMi
 868yCPRekwLK7oDnO1o2Fdv4Z0bdCj9C1e0ZM7rsW8PW7CmrjxuCIwrrGKUCWPaL678vO+C4A
 c0FnOBiHvg1GJ4QlZpqsXL2rGZ6XcWGBVW88+AJAQYgW15CRpsPL/UM4uxH/VpJNL4tv9VnCq
 YtOZU4GJNZM88Il170eUeNAe87fLq6rFDXCdzqtV+kEZVX8dGkwuEFG0lE+geMQzqp3KL78Lz
 0vBBd27knaE7IvWzuzQnsDK94MbC6Sn5MK/3nC3X6k2bG42vYYzQJ1Rd9YxU9k+11M0o4ek9X
 UEigVAezf1N4e04bVPdVhdheM47bRZdEG/uwJv8iUMB3TYMLRAoJZ4uzmVbAuGYGxx4GfUpjT
 3lmbyO3MyPRZPlFPa2SRCr94tWLjK+7x0yMCmXt/Lh6DZhVkauEn3svUo86JWNOhhlx+Uw+DY
 EYvNrBB5+ONO0nMZ3+AnyQED0+GRzXYb5ih4W3OF08Zkf7RxT5YBUol4w+OwxfIqNfPsRYxLO
 Nyv7y76d/yAQPBNzWP7axrVjoIUGnTfr44lbZRCCNBGavfxkzEiDUGU73WfVcRIZM5+fCl4Du
 IjKeYljTgFD5rOcj+yS1JcKUVBAKelUTOIcwzh/Jo9M7zaRKg/qap2pK4cPkf8/XnmQ5c/i3Y
 i7jvEA==

Hi Greg

no regressions here on x86_64 (Intel Rocket Lake: i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


