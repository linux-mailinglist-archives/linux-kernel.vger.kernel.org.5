Return-Path: <linux-kernel+bounces-14725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF4D82213E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573D72838BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8351615AD8;
	Tue,  2 Jan 2024 18:43:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9A15AC3;
	Tue,  2 Jan 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.104] (31.173.80.188) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 2 Jan
 2024 21:43:15 +0300
Subject: Re: [PATCH net v3 1/1] net: ravb: Wait for operating mode to be
 applied
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <mitsuhiro.kimura.kc@renesas.com>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Claudiu
 Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240102110116.4005187-1-claudiu.beznea.uj@bp.renesas.com>
 <20240102110116.4005187-2-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <df73cd5f-4185-233d-eada-7b5598a070fc@omp.ru>
Date: Tue, 2 Jan 2024 21:43:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240102110116.4005187-2-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/02/2024 18:31:01
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182449 [Jan 02 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.188 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.188 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.80.188
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/02/2024 18:35:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/2/2024 5:17:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/2/24 2:01 PM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> CSR.OPS bits specify the current operating mode and (according to
> documentation) they are updated by HW when the operating mode change
> request is processed. To comply with this check CSR.OPS before proceeding.
> 
> Commit introduces ravb_set_opmode() that does all the necessities for
> setting the operating mode (set CCC.OPC (and CCC.GAC, CCC.CSEL, if any) and
> wait for CSR.OPS) and call it where needed. This should comply with all the
> HW manuals requirements as different manual variants specify that different
> modes need to be checked in CSR.OPS when setting CCC.OPC.
> 
> In case of platforms with GAC, if GAC needs to be enabled, the CCC.GAC and

   Better to spell it out, I think: in case of platforms that support gPTP
while in the config[uration] mode..

> CCC.CSEL needs to be configured along with CCC.OPC. For this,
> ravb_set_opmode() allows passing GAC and CSEL as part of opmode and the
> function updates accordingly CCC register.
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c> index 664eda4b5a11..9835d18a7adf 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -66,16 +66,23 @@ int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value)
>  	return -ETIMEDOUT;
>  }
>  
> -static int ravb_config(struct net_device *ndev)
> +static int ravb_set_opmode(struct net_device *ndev, u32 opmode)
>  {
> +	u32 csr_ops = 1U << (opmode & CCC_OPC);
> +	u32 ccc_mask = CCC_OPC;
>  	int error;
>  
> -	/* Set config mode */
> -	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
> -	/* Check if the operating mode is changed to the config mode */
> -	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_CONFIG);
> -	if (error)
> -		netdev_err(ndev, "failed to switch device to config mode\n");
> +	if (opmode & CCC_GAC)

   Worth a comment?

> +		ccc_mask |= CCC_GAC | CCC_CSEL;

   Adding CCC.GAC to the mask not strictly necessary but OK...

[...]

MBR, Sergey

