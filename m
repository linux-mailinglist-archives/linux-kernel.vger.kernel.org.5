Return-Path: <linux-kernel+bounces-40525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A983E1E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F88282703
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C422325;
	Fri, 26 Jan 2024 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ryF+vtFH"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5AE22314
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294808; cv=none; b=mu8kHn0QguGTBkbXV4T+cQ5F1yXhPp58MyAGgW1puqat5BgtYV1qOzjhsfIuDEi302BDkQ6RNVZituuJoN2psfMs+CDVqjPr3kRlfTDQrIM3ewHYI/8PX8h/gswAAbAJ3NYhJ2OjhCB3YXywGDSLNYvEOdQRHcuWHCcSWIV5L7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294808; c=relaxed/simple;
	bh=xILlNZZSLJqUybs65q52lmoSYlI8UiIMf72uaPBntzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SOqZq2PsY2FOa9v2NZP6kXTGVB87ZKk5I85ZflGvp0KjkgWee/3enlDO/dm/EBElJJFw7sUkUjMsLTZcgUD3f4LMUffPT+ioP/daG3O0RcBm/hpGJXqPPtByXK2pZ+OdCSTxXYFb+niEFPgHqEF8LgWTA+C25T+8lfSLoyRF+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ryF+vtFH; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 538C8100005;
	Fri, 26 Jan 2024 21:46:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 538C8100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706294799;
	bh=o8Wk+nRV/WANv25MMKemwcRfh2eTYuNCBHJRR9H6Ffg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=ryF+vtFHBMhpfIExhPDXu//aR6hScmNHZM9jpYGU32nzOx8JFLjWELR0qBx4OqyYK
	 ON88fyR+Yh6Q8hVa7Mk6rxoMTArln90fYmcSSeDlqc9jPvfPw08kQm4hvPxXI5yOsz
	 FOSl2Snm4PdRDiY+LyAc8Y+ODi/SJkrorGYkNwtJE2HLbLPdqqdkZX8pcWsTsb6jfC
	 5mrMHL3s49x2/rQuUYv5zUSCwMosKNY863gY86dmNBA8hIJ6FwAXW65oq3X2f9K/mq
	 sZ/Mcq2YcBi2nBS8ocKZMalhmb/8tDkyKlBzMXggq66XQRGKXp9sfu8+M5FcrC8jVC
	 EQLI/1G+2dnXQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 26 Jan 2024 21:46:39 +0300 (MSK)
Received: from [172.28.137.2] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 21:46:36 +0300
Message-ID: <7a5c147b-e531-4aa3-8439-1b80d8ed7747@salutedevices.com>
Date: Fri, 26 Jan 2024 21:46:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mtd: spinand: Add support for 5-byte IDs
Content-Language: en-US
To: Ezra Buehler <ezra@easyb.ch>, <linux-mtd@lists.infradead.org>
CC: Chuanhong Guo <gch981213@gmail.com>, Dmitry Rokosov
	<ddrokosov@sberdevices.ru>, Martin Kurbanov <mmkurbanov@sberdevices.ru>, Md
 Sadre Alam <quic_mdalam@quicinc.com>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sridharan S
 N <quic_sridsn@quicinc.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	<linux-kernel@vger.kernel.org>
References: <20240125200108.24374-1-ezra@easyb.ch>
 <20240125200108.24374-2-ezra@easyb.ch>
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
In-Reply-To: <20240125200108.24374-2-ezra@easyb.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182973 [Jan 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/26 14:25:00 #23442014
X-KSMG-AntiVirus-Status: Clean, skipped



On 25.01.2024 23:01, Ezra Buehler wrote:
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> 
> E.g. ESMT chips will return an identification code with a length of 5
> bytes. In order to prevent ambiguity, flash chips would actually need to
> return IDs that are up to 17 or more bytes long due to JEDEC's
> continuation scheme. I understand that if a manufacturer ID is located
> in bank N of JEDEC's database (there are currently 16 banks), N - 1
> continuation codes (7Fh) need to be added to the identification code
> (comprising of manufacturer ID and device ID). However, most flash chip
> manufacturers don't seem to implement this (correctly).
> 
> Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

Tested for F50L1G41LB

Reviewed-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
Tested-by: Martin Kurbanov <mmkurbanov@salutedevices.com>

> ---
>  include/linux/mtd/spinand.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index badb4c1ac079..5c19ead60499 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -169,7 +169,7 @@
>  struct spinand_op;
>  struct spinand_device;
>  
> -#define SPINAND_MAX_ID_LEN	4
> +#define SPINAND_MAX_ID_LEN	5
>  /*
>   * For erase, write and read operation, we got the following timings :
>   * tBERS (erase) 1ms to 4ms

-- 
Best Regards,
Martin Kurbanov

