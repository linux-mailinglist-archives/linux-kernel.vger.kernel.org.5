Return-Path: <linux-kernel+bounces-32392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33C5835B22
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8331F21217
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C68C8FD;
	Mon, 22 Jan 2024 06:40:52 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2099.outbound.protection.outlook.com [40.92.91.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A37F9C4;
	Mon, 22 Jan 2024 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705905651; cv=fail; b=TvCQO+DTm2U1ZXpPoadwbt23KTMPh7yvnPizd4mtzOdqH2gfSnbNLKyecniFgLWRNcvv1RW5z73SYeC8tFs5Cs5TvoShZMCiKffoivxVl76Rar1J5Oik0sscPf+7Z72E1wPONsXbWF9nnTC5F+EhXKZg1ebn8aGjvgXOH/gxzYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705905651; c=relaxed/simple;
	bh=NSkMO4Nac3nz7cejeoqqrvTeOLHmq3mz2ZPJFYeFpjY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S/ssqyS4DxDs3XJJcsP1GjJR0j5ZnSImAhiyba5tjhJl2uBWuY5CRjHij+teTRg4hjJbG2x4VWnBqJV+gHZKZjeVSclxFway2j8jBajqBqerZjZ85Y9pgxylQgNNV54WoD0LBqjmYutLSgs0YwUPJ4cLdILyEU8UGD2InISV8XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; arc=fail smtp.client-ip=40.92.91.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ad/oSl/AiIb8OCS9g8JP1R3e0JS1m9zLm3bI9hSIBFBxFVd2yDi2RW7uzZbF12hySgPIVpCUdUMTHZiMWoGN1pJ1UoAg0eOLv3U5T+0MOIpbeC2UG92T2xJsJj3ILmbW2Y5J8eUljph+hRwWns2FiLj9cJXJFdeMD4qG4/dChuuPAqVaksO/0lB4w2iLjcBsALIYU62k3tLMsJ2kMVRgE4+e0qvhFf17j/0e43yj2rpG0r76ZyWtC/qHAZdk05lenLgM5kPo4OU0ZBoTUbz31pON8Orv057wIGZiHAGpYN6cgsFWGeOZYhE4uDtn4597f2WxXAL/tsDkDuvuUp1FMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytEtmXqaKsOZm1gTjcEc+6KeUtF9uMBuPamMf6HLzIU=;
 b=XHtEb5UvP0Dwcj5YEW/8PZ5vLCDWiH8fv3LXZDPyGRW0RInejELQ+wxfoe+bVF7jbg6gW7cj7p2U+Mw6Ns4ikigBH2Sz1ED6e3DC0bIf8AMBNlo23mibaJpQ/jyQ0LWJ0WPXwj/PcWTLL3jjCf3eWErVtIdCXzS66PcKfxS5mF5hyDu9//6KZCfTvEyDUXGjbFgxDExTII83RUeCBjq8pFKOG46MfTWgnsWmUpX5W7qOlNOujONXKRz1l2ZwdzjS7cWo+Qm2JPS7Hwi1fD06Znqc3vlu//0uPzxMzujejY0fepHvPHXDI41xC8vlw6PH8zZPXX4dmIkzGtb8vj728Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by DB9P193MB1258.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 06:40:47 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 06:40:47 +0000
Message-ID:
 <AS8P193MB1285D9F82E8065739C0AD962E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Mon, 22 Jan 2024 07:41:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: stmmac: Wait a bit for the reset to take effect
To: Jose Abreu <Jose.Abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285EEAFE30C0DE7B201D33CE46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <6e33c038-45a7-4941-b5d9-ce5704e13d48@lunn.ch>
 <AS8P193MB128591BBF397DC664D7D860EE4722@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <DM4PR12MB50883D41B18E8627FBDF5E32D3722@DM4PR12MB5088.namprd12.prod.outlook.com>
 <AS8P193MB1285B34B71F3143FA9B0A053E4702@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <DM4PR12MB5088435544A3D355C94632DFD3702@DM4PR12MB5088.namprd12.prod.outlook.com>
Content-Language: en-US
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <DM4PR12MB5088435544A3D355C94632DFD3702@DM4PR12MB5088.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [MbmuCELclWdqPjWjsFMftdLCZiOUMnOFD/HE2Nzg5aQthoxFJl24AEKOaTo1vhkn]
X-ClientProxiedBy: BE1P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::8) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <5eac8f06-1044-4c84-a77b-435cb4954243@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|DB9P193MB1258:EE_
X-MS-Office365-Filtering-Correlation-Id: 284b56ee-95f6-42ed-fbc0-08dc1b1510e8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	63Skqt01WyK7Q1lhb+2jxw8EHtAGaOiPnTXXSDeLAY0L1dVYPCiIwmlcx05M1al14dC+QHVrgicvozDGg2oA+JoXTprByrF0JNlqSdhHc31EXPa2YyFnvpS4drSitYrcboqguWBKUEhnmhno7uPMj1K/ivxWV9vs+0vzGaHhib2VRMvVCljU+bz946l+rNKsLJKiDfZaJ4xxeIdO9oLJVOdq4fo+TvePBJ7H1H2nzwdJy1RfqHU1ZmCl+EhScwZwFWJwuaRG/Z71mW6QLnkBtug/lcRkvFODkhtPTN2kS2Oaas/YQKoM2bCH8RkHSWi02LOm0qTZtLzYt0qRgU4UX7iAW+Ex3DJcvPAKxZ7/nNgfOr9fYGmRBHZNFHrYWfMCAo9k9lGLDrHInwlAI5NUCWV+QBfyCo5jmiOyxdJoH6RV7D+v5xiYvwQ5AXVK8THTLlja+1t2hkG13nrO2CD9su+iK0YRAo9aUy+JVAUDA2ccjLbWgVomfXwSDCLkYgk2LKrqv81jIDHlCxs66x2UxbaoAhTrAdAnOtHFAHCglBQdVKfYGjbSUR73SGoysVcn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZElRMUxQU2hsUUlqcXN0ZEFVQXY2aGxjR09wSHdTeVErNEhEdGVLcXFZUzRH?=
 =?utf-8?B?N3VhTjJmY2pmMWVrTWIzNTdSUEt0bFIyVkQ3VFV1UHRYS2Y1OStNaTVDUE01?=
 =?utf-8?B?YU82VFdReHNrU1U1eDFITExGdzlHc1ZkbVNhV05uZlZFQnRLOEZBNWcvRDk4?=
 =?utf-8?B?dkV4ckgwTXVLdXBPYlVXRzZDK3JHYU02V1Y3aWZrS2oyei8yUXF1RG16dGhw?=
 =?utf-8?B?SVJRZ21oR2dpWVFYU29OaXp6TG40alFWWFYrUk1rTXhqYXZUMCtwbUtMb2pG?=
 =?utf-8?B?UGNxOEF3TVVHNWY4Qnh4VTBXczcvYXRoSk96ak50T3dpZ2tGcDlyM2JOY1Y2?=
 =?utf-8?B?RjB6ditsTlRyYmMwWGVkZm5lTlFzWWsvdE5BQ0NnWWp6anVUbDhUdmhhN3VG?=
 =?utf-8?B?TDZGZ0UvNkVZMVhHbk9QdnkwWEhwZHZleHpHWVVCL2tMQ3Q3WTg4dmtSQlBE?=
 =?utf-8?B?SjVlaTYwRVl5cHRDdnhrSGxsQnh6SEZIU2Z1YVg5Z09WeHJIZDVwRmZRZ3gw?=
 =?utf-8?B?Q2QrS000M3NlWVF6RkpTZnAxRTFXeFphenN5S1hhMTRYdTJUY3ZGay90SmM1?=
 =?utf-8?B?WHZFNXgrYU53eTFFM0ZjUk1xUWsvNmRxV3BDWW0wTHEzNHdSM2Zjbmx3dExZ?=
 =?utf-8?B?Z01NSFJJY3Z6TFdsSU4rcmUzK1didzhBTVpGUEpLR1Q3WFFUdUk4VUF5WUpw?=
 =?utf-8?B?RGM0YVg3ZkkzdnNHbEF3VW14MWJKR2NnL2I0YXJZQ20vMURjQnlld1hOZDhj?=
 =?utf-8?B?VTJpSjdIdHdreFFVVEQwOVJZMFB0aGVERElleDJLTlN2UXkxRVM1K0ttenla?=
 =?utf-8?B?ZTJBYnp5WkZINmgycVFWVnlLWWVIb1h6b0JCV1BnV2VKQXU4LzNONmQvbDh3?=
 =?utf-8?B?MnBUNlFHLzNrbFVLeUNxUU9jSS9wUDNoVjBuZWtXYkJBd3l4cDd4dGVMQjk1?=
 =?utf-8?B?SjR5TnJHNUw3S2ZxNHd4QVViLzZ6bmNCN0FqbXZGdnpTQUR4ZHM5azRqSnpk?=
 =?utf-8?B?di81NlphdllickowSTZxTGdTRVRSKzJyMEJyT2p6VDV0dHBwSWg4czM2MFpU?=
 =?utf-8?B?d3JQRHFLOTd5aFVQM2NySGR5S01tUzlZbFFvOGl6V2pBc1FORjJERXRmaCtq?=
 =?utf-8?B?b3F0NWZ6a1BsNHY2SlM0NXd1aVg5WndJZ0NWRktselV5bDBkSnE1c3NqZzc1?=
 =?utf-8?B?QWk1V3Z2VXhyNHVES1Z6Nk5pWlVyOXZlMk5manp6azVUWGpRQlpXcHJzWnB4?=
 =?utf-8?B?WlpWMWN1L0pOKy8rd2dGcUtwV2ZGWmlwdmxQbHYwZG9BLzUzOE91UFhITVBO?=
 =?utf-8?B?MlBkUFErWUUxTFkvNklWV1JGcE1USE1JSFlwUitFRmFFbmNIRVcyeFl1VUV1?=
 =?utf-8?B?bCt0VUtLMll2a3dmSm9qeTJKVFg2QWNvdXFPNVpWTFR3TUxESnRKLzZRMEFT?=
 =?utf-8?B?WkhmdUo1dkVhT1BSQ3VML1RDZkJ4UmJZL3AveFpNL2NiaXZNV1ZtTkZQaDhK?=
 =?utf-8?B?RUlsY1JwODhFOWxiWHhOaGNublZHdnlsRDhITHFZL3pFWVFSRGk2MlVTNG1w?=
 =?utf-8?B?bmJjM1VISHc3N0xkenJsR1pBVmdsK0QyTzhoY3FoTDVxT2tjWldxMGpST1RF?=
 =?utf-8?B?SE9oRlB4WmxiQWdqWTVWRzZvdExRcXpRQmZLTHRHd3g3Z1RBaWtqdTJpWWNJ?=
 =?utf-8?B?MUpBN1JrVHlVc3VZUC9rQXAvbEp4bGtzeFY0cERMcUVvQ3REaEZFZ3ZzemVk?=
 =?utf-8?Q?lD+qsbDUGF0oSLB4mA=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 284b56ee-95f6-42ed-fbc0-08dc1b1510e8
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 06:40:47.5225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1258

On 1/19/24 11:38, Jose Abreu wrote:
> I understand your point, but the delay should be on reset function itself, since it depends
> on the SoC that stmmac is integrated.
> 
> Please refer to reset_simple_reset(), where usleep_range() is used.
> 

Okay, in my case the SOC is an Altera CycloneV and reset control seems to be an altr,rst-mgr
which is indeed based on this reset_simple_reset.

So it implements reset_control_assert, reset_control_deassert, and reset_control_reset.
But the above mentioned delay affects only the width of the reset pulse that is generated
by the reset_control_reset method.

However if you look at the code in stmmac_dvr_proble where the reset pulse is generated,
you will see that the reset pulse is only generated with reset_control_assert/deassert:

        if (priv->plat->stmmac_rst) {
                ret = reset_control_assert(priv->plat->stmmac_rst);
                reset_control_deassert(priv->plat->stmmac_rst);
                /* Some reset controllers have only reset callback instead of
                 * assert + deassert callbacks pair.
                 */
                if (ret == -ENOTSUPP)
                        reset_control_reset(priv->plat->stmmac_rst);
        }

I don't know which reset controller that would be, where only a reset_control_reset is
available, but in my case ret == 0, and even if I could get the reset_control_reset
to be used, the issue is not the duration how long the reset line is in active state,
but the duration that is needed for the device to recover from the reset.


Thanks
Bernd.

