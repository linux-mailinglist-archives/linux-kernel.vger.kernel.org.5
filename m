Return-Path: <linux-kernel+bounces-69359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4AE8587D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363FE1C22B70
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56DF145B03;
	Fri, 16 Feb 2024 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="g1kLTSFU"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C412BEA5;
	Fri, 16 Feb 2024 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118219; cv=none; b=jhiXOGf/4MFkMfujMs7IGerutgBlTg4ik74n9Utcv2RpWFY84aIfuZuIgLFeE5XgC+p8u04btAbrmXCgy/qrpZc9m7ajaFpMnwudaHRkEOhacUrmxrwgGuWcqyYeuIjoJiuAjgpc0KN7XWVMtYgM6vzWuvUTZ5pmXgBe6JUbkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118219; c=relaxed/simple;
	bh=CfkJOwc768uqlPsNwBarTmKVFwEcec7Zu4eQPfcuDKY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfKe8Dt6l9+h68A6oIwHnQSzj94U1jSLnLjOpax3hfM+Eb7KkVO5M5hO4Gc+Ilt52KztLRBVvlxYifw2EOGfUARtC8IA1YFhFdG1vWhgG86UscazfSEk2qJTuy81K5a2MnMIxDKA7OqdtStQpkY+AZ1D5vt5bo4j+wVU7+/W5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=g1kLTSFU; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C4BCF120005;
	Sat, 17 Feb 2024 00:16:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C4BCF120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1708118199;
	bh=GEWIYujsIGK1qBJth7fHLRLKuwS+uxfDCkWZ+vejPIE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=g1kLTSFU/u0PFhAK9lpAHIYHQ6fCHKPgC64MEZ5lIh/EsphXaQCQnFtUVl4TtrH9H
	 92t13h7IEbtsOhr6Z0iIbjLy8fgLW6JOXC4CWxodvLsZOFIUkeUSf/ot8vkJW6CAZv
	 oOZGN1v0byMaOabycadNHweKo95a0pbmK/3VdjbAImaEtx7suu3fd36DC08NGALWT0
	 b2hVCjKiX9XjUQeZo9FGY/LJdEJ4wzEu9qYAUhjsu7UpgHxlRT2q/70NO7XWmlOtiM
	 /2fSTVC/znuEqLELw+r00EExbmhM5f/ZTLu8snobgRRxEmuwDDPWGVSwUZ/9PMmbvN
	 noWr4Ki9EN3UQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 17 Feb 2024 00:16:39 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 17 Feb
 2024 00:16:39 +0300
Date: Sat, 17 Feb 2024 00:16:39 +0300
From: Evgeny Bachinin <eabachinin@salutedevices.com>
To: Viacheslav Bocharov <adeep@lexina.in>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/5] firmware: meson_sm: move common definitions to
 header file
Message-ID: <7zhsafmokydl3fxtfsjjnhizq6tidxsuefqcemsqqwqdje6m4p@gxfz3ajr76mv>
References: <20231122125643.1717160-1-adeep@lexina.in>
 <20231122125643.1717160-4-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231122125643.1717160-4-adeep@lexina.in>
User-Agent: NeoMutt/20231006
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183517 [Feb 16 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/16 20:10:00 #23642199
X-KSMG-AntiVirus-Status: Clean, skipped

On Wed, Nov 22, 2023 at 03:56:41PM +0300, Viacheslav Bocharov wrote:
> Move SM_CHIPID_* constants from firmware meson sm driver to
> header file.
> 
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> ---
>  drivers/firmware/meson/meson_sm.c       | 4 ----
>  include/linux/firmware/meson/meson_sm.h | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> index 402851ed4ac0..96e50811336f 100644
> --- a/drivers/firmware/meson/meson_sm.c
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -240,10 +240,6 @@ struct meson_sm_firmware *meson_sm_get(struct device_node *sm_node)
>  }
>  EXPORT_SYMBOL_GPL(meson_sm_get);
>  
> -#define SM_CHIP_ID_LENGTH	119
> -#define SM_CHIP_ID_OFFSET	4
> -#define SM_CHIP_ID_SIZE		12
> -
>  static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
> diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
> index 8eaf8922ab02..f62acd2bf52a 100644
> --- a/include/linux/firmware/meson/meson_sm.h
> +++ b/include/linux/firmware/meson/meson_sm.h
> @@ -7,6 +7,10 @@
>  #ifndef _MESON_SM_FW_H_
>  #define _MESON_SM_FW_H_
>  
> +#define SM_CHIP_ID_LENGTH	119

Does anybody know why this value is 119 bytes?
if in-shmem data, arrived from BL31, contains only up to 20 bytes
(in case of chipID v2):
+-----------+---------+---------------------------------+
| chipID ver|  cpu_id |        12b-serial               |
|  4 bytes  | 4 bytes |(per particular die unique data) |
+-----------+---------+---------------------------------+

> +#define SM_CHIP_ID_OFFSET	4
> +#define SM_CHIP_ID_SIZE		12

It seems that either the value (12) is incorrect or the current naming
is misleading. This is because the chipID is 16 bytes. Of course,
likely the SoC serial was meant here...

Furthermore, it appears that SM_CHIP_ID_SIZE is an unused symbol. It
has been unused since its creation in
0789724f86a5 ('firmware: meson_sm: Add serial number sysfs entry')

> +
>  enum {
>  	SM_EFUSE_READ,
>  	SM_EFUSE_WRITE,
> -- 
> 2.34.1
> 
> 

-- 
Best Regards,
Evgeny Bachinin

