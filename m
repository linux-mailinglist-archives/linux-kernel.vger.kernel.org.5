Return-Path: <linux-kernel+bounces-50254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC469847670
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEF11C25A0B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2116A14D441;
	Fri,  2 Feb 2024 17:41:59 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2032.outbound.protection.outlook.com [40.92.64.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08D14D420;
	Fri,  2 Feb 2024 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.64.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895718; cv=fail; b=diBq89qyfcMjE7Ixs4nB0tVnQKTj14qoyqxwFu9vPagY3uECoeR8ZREZx/5iVtunBS8I4zRBm/AYSkLKwCtWKuKiPj/rN1j1J0pM7da643lKkq9yq/c+bU78cUDPT0UJQx5thi67G8Vz0l+OJi5dIkWy3NYu0gV6w+o/INfpOzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895718; c=relaxed/simple;
	bh=WSROJmYThrvR0g7sNzjj+m9G1wlV9LXZVr1AP8GDbOU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f03iKmHkLivis07riEESYIBe8OS6GFfg7SD06frToNKIg+TwCuvOgQhioWc1Zk9P6vSb3YIYRUNyrMzvjPc4IFW556SZ0JmPY7epb5EGNJYbDIXmSpgOib0cMadvTUPLDDeH7hMZTZl4cbp92qlDt+nflJ2r0+nYsAliDOiqVEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.64.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBECjDpEep/UPvUy80j4Ps20Kqw10d5+Yson3WkOGGfipS6p6d14sfRFsvy7qcuUVBNCupZPu3KOcHvUbgNb/yXpDDCaeBW+H1SqvYQggFaFO5SASaQUrNc+assvsDEX/zpu23goQlWOgIlIp73WhH1I655Z64bhZSzLMqzzKF3aF2hfkhKlk2pMA0VfigmFFeYELViuhV1EcFA1kF1OQkoSqJDN2v1/5jkbpQKxFES/ImOLDjbStZ2j1FudNx/hg2eeaUtdS35Ewpa4JpfBFf79J8SSSAiFnLKGy7GtImgeKmzLjB36blTQGkJkxYY3MeC88WAtucHqRdT1Gp5IWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9/Scwcs4VLzCV/9QA4zWThnbSJi69q75uQdzz5v3gY=;
 b=YzRv6z0IrSE9Mcsw8WB0uwof1rWtqYBrPAbWQ5B+Ou0uObu3AA7XOng5AAoy9SagerIqjBAYi8wByWbY3QLylT+5qP4aNuHB+ctB8/JhZhkxOdRgQxcac/zw4q+sNGA6aOLf8mmOCouAz2nVTSDsBwWXvd5u3x/kyn5NhhNagqiRgzUAsw5WqcRH/KDt7gNQjWhRhdmWnrHvoOM8OhtPDbnBB5ZU1xqEk+8YmKdgNKxVbv2czXcgLj6ZPMbjM4VVeuDDVfd755OeuzUqJKj0PVYXE9Vp5cNaXFmLrPUNGWBwgpYjcz/1W1P+6OqawH+vHj+Ay7lYa/ok3BcJCQg8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by AS2PR03MB9840.eurprd03.prod.outlook.com (2603:10a6:20b:607::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 17:41:54 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7202.035; Fri, 2 Feb 2024
 17:41:54 +0000
Message-ID:
 <AS1PR03MB8189B99C360FB403B8A0DD6882422@AS1PR03MB8189.eurprd03.prod.outlook.com>
Date: Fri, 2 Feb 2024 18:41:51 +0100
User-Agent: Mozilla Thunderbird
From: Sergio Palumbo <palumbo.ser@outlook.it>
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON ONU
 SFP
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AS1PR03MB8189AD85CEB6E139F27307D3827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZbZn8oCiyc1aNPuW@shell.armlinux.org.uk>
Content-Language: it
In-Reply-To: <ZbZn8oCiyc1aNPuW@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [SMRdlE9lALEWM0Nol0Tnvp7kjxUYPMOa+C+l/PPsnd+rFj+680UR8lEQa5PvXTKi]
X-ClientProxiedBy: ZR0P278CA0069.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::20) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <56c1566e-b2b4-42f6-9e9b-a2543a9197f6@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|AS2PR03MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 714b424a-1898-484e-e2b2-08dc24163e62
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vww/lsKdFhHJXlZFCOt2mtoyrwsHbu0EoZ+O3LfjBzaZTVAqFIuTQSWUHeRHYeKwafqoToMESIXcgcMfmgfJrTc2fL3YZmCUKPosZ13HmBPtmyOa6To+xnt9IlJyF9P66YvkmpU7j2AkMnR7IsPTJ9OIRmRJRe5rZEVmznZeQLd6Gra2kM3/AbQI8f1i4uSBbKXFF1MTAGqeUaReRBgPR50a6f6TRXtCDH5XaHewtjgc/KPhz1fo+PCh8bAvKHvDffBpFzIx7hoazdslewIDlI7qFI1WATLkvpqRRrwhWJoM66i6QIX6oE396svt/6eikPIttCol+vfJJ7B3uVWGLymkd/4eAcFRwvN6zkK5uUqM7gkd/Q4n0Zy5svvsWiHwUTo52q0gNDOVP9SWaZJ8zg6t8n142nv/SRJHxKgaSmz2oodKrr8Urtw2b8Dr0DKiIBuNROcj0rvE/WwgJPEoqou2bH6YvypN8Syrv+7llvM1cR0D4A9+EHTf/vWkwr6TqI7WNYuqDdopchVTgcEnt0NKfLq7kKLgLxQwRdqo01fPlKWMxPycSxJV/IeuxkX7aH+pXDPO8p3IRwYGKTGlVP4t4IEzvtooQTDR89etRlM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1R4RWM2SDZNUmNrR2pPZE1NU2RXdmZuNWExbi8zT3B4cDl1eUZrc0ExMTEx?=
 =?utf-8?B?QkxWeHFMeFpxeHc3UGJ1UTBSTHI4RmNmS0VOYXhXaEZ1QUFvdjBocmlxc3BU?=
 =?utf-8?B?MmZvRG9MNnBTSjRLK1FhalBYSWFsd3hlOCtnTVRrQ3F5UXRsZ01BbW40dDNv?=
 =?utf-8?B?MUZFMUhUbEx5YWlGT2xka1BSWTNiQ3F0QmJTa21OQ0JkN2Y2WjJEaE9rc3FF?=
 =?utf-8?B?aWNqR1RSNTh4clhJQStyVWFubEUrY2Rlczc5QlY3eUh3RWdYQWRCOFY1VldR?=
 =?utf-8?B?TTd0V3NUMEk2bW1jRFgwZFF2Z2RsRjRZVW5YaG9LbkR3cy9yUE43RlpDcXB2?=
 =?utf-8?B?eEVSTmtqOWh6WDlNS0VWRmJaWEVOMTZUdFk1ZDdPQ3VtRy9HdkQreHVHcXNQ?=
 =?utf-8?B?RWhERmtDcDhaVlUyRG5DVXdXZFdwajVjazJnY3RDOHhXMjg3a2doTWFhUDFG?=
 =?utf-8?B?TUJ4V2hsZWtlY3RHVE9YRXVsbmluZjVPUjBwVTV6d1crVytKejk1RDdnQnly?=
 =?utf-8?B?M0lxSG81L1hPeVVVNFV3cTlLWU44emNBV3ppaGdFSUlIUERaeFgrTmRoUGpj?=
 =?utf-8?B?R1hXamxrNUN1dEZHb29hYUFyOTJncnpjNWRmUVpMNFR1dEFxaUtiM2NQdzA5?=
 =?utf-8?B?UTlvRG5NbHdvZGt6WDMwMEY2SCtGaG1MTFZOSElVQnc2NnRIUWZ4YkVGZ1Iy?=
 =?utf-8?B?b1ZReEwyb0NYTWxMVllEd04rcXAwU0Q4L2xEUVI1S1pabjRwckdENDdCY3M1?=
 =?utf-8?B?dUljLzdzN05xMHFpMENJa1E3YStuUitaWEpabm4weXhJYlBHOUtVVDJ2RU9U?=
 =?utf-8?B?R0VXS21ucmVxTmVMUGMwT05NR1RNQzE5ZWNqMnJhOGprajh0bjRJODE1dTlB?=
 =?utf-8?B?dnlrR3Z6RkpML0wzSEtsQ1lNcE1YNXArMlgwRSs1WDhTYkQ3Q1psd1pDb2tq?=
 =?utf-8?B?ckxHRm00cUlzTFgzT2dFTlViajZ1Tm9TejVIeW1xUjlmNis3NUEreWN6Ujlj?=
 =?utf-8?B?ck8wZU5iYTAvYlYvL1NyWjhHL2RMU3hmaS8wOUxyMDFKNkNWZWxPaGZYY1Ev?=
 =?utf-8?B?TUpjSHRBbm02LzcweExwV1FCSmlCYytQZFhEZS9MOGZSL2k0K3ZaTDFmdlNE?=
 =?utf-8?B?dGZGT1M3Q1NKN0xCdjJ3VS96Sjl3OG9mcTNTdXFyd2FkSUJWQ21meFFEYXpk?=
 =?utf-8?B?azh2SWFuWWtveW9ZbFhYOEROakRVZStSTEFUeEJEN3pZSWd4MWFDQm9MK0dC?=
 =?utf-8?B?ak9kVlZGRzZlZG9HOG44TXRvYVJMRDE0RkJrSytWNkl2em9pUXBURnZrL3V5?=
 =?utf-8?B?SEduUkdLd1lUaHh5MjlucXljRlZYNGxZdTJvVEhJNExENHgvTi9pcksvUDVG?=
 =?utf-8?B?WHJMaStselZzVWxMYTBIK3NQOUlCY0tmS1h3M2tLQXpzTFR1dFZrSElBUVU4?=
 =?utf-8?B?WDRESU1oZHJrREJEdWxFcjFVclB4QWhpcDRQbklVejF0ZVBQM1hKNkZ3ZDZt?=
 =?utf-8?B?QUJKQnBLaW9obGhhTWRtdThSRnBvRVhBMEdXanpERTNhKzRJaGg0ZXN6L2tF?=
 =?utf-8?B?cEtiWTdYQ3NJcGJmOVB2VEVxd0xPY3FuMkJPcUU0N3pQVEpBdEpjTmNHLzZF?=
 =?utf-8?B?QU1OSWwxcHp3MkUveWZaYk9hWFB3VmlNS0ZFcXNxT3pSS01NZ1ZWM3RUbUNK?=
 =?utf-8?B?UW1vVFVQOWpaNThZaGxhc0ZZYnpJZE5kcjhWU2MveDVKTlVhRDF1QzgvWHhW?=
 =?utf-8?Q?M1J67bfcePzTjVyaDo=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-10f0b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 714b424a-1898-484e-e2b2-08dc24163e62
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 17:41:54.2033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9840

Dear Russell,
sorry for the indenting. I will no longer use indenting in future postings.
As explained in the description setting up the module via telnet with
LAN_SDS_MODE=6 puts the module in 2500X autonegotiating mode.
Without applying the patch the module shows up to linux at 1000X
because the EEPROM is not correctly reporting the 2500X speeds.
Ethtool lines in the description repporting only 1000X and host
connecting only at 1000X.
After the quirk as you can see from the ethtool lines I put in the 
description
the module shows up to linux with both speeds 1000X and 2500X.
According to the above if the host has the ability to connect at 2500X
the module is connecting at 2500X, if the host has the ability to connect at
1000X only it will connect at 1000X.

On the other side after the quirk and the module set to LAN_SDS_MODE=1
1000X mode. Linux host is connecting at 1000X only.

Therefore will all the possible combination the patch allows linux host to
connect at the maximum speed of the host up to 2500X.

Please note that, as exlained in the description, this patch is for the 
"OEM"
vendor version.
I posted anothe patch for the "ODI" vendor version.
Harware for both version is the same only vendor name is different.
If better I can post a patch having both quirks in two different places 
according
to the alphabetical sorting.
I thought it was bettere to post two patches one for each vendor name.

Hope this clarifies.
I remain at your disposal for any further information.
Thanks and regards

Sergio Palumbo



Il 28/01/2024 15:42, Russell King (Oracle) ha scritto:
> Oh, you re-posted it already...
>
> On Sun, Jan 28, 2024 at 03:06:33PM +0100, Sergio Palumbo wrote:
>>       DFP-34X-2C2 is a GPON spf module working at both 1000baseX
>>       and 2500baseX.
>>       Setting the module to LAN_SDS_MODE=6 the module is working
>>       at 2500baseX with auto negotiation see at
>>       https://hack-gpon.org/ont-odi-realtek-dfp-34x-2c2/
> Please don't indent commit messages unnecessarily.
>
> Also, good to know what this module *requires* AN with 2500base-X.
>
> However, what mode does this module normally come up in, and does
> it reflect the operating mode in the module EEPROM?
>
> If we accept this patch, and the modules normally come up at 1000base-X
> we will try to use 2500base-X and the link won't come up. So it's
> important to clarify this point.
>
> Thanks.
>


