Return-Path: <linux-kernel+bounces-17687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9A3825129
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBA71F22615
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A67824A10;
	Fri,  5 Jan 2024 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="oALvBcnX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC91249F3;
	Fri,  5 Jan 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5FEXOiTNO+tm7m2ZMwDQRfrXuAermp+ysq4We90IAwDcmvREu/D5geUqjNIuehKVPbEUEqqK9WzGHlia8aY33JS5iHsdTN61NEqyGziCspyStOF0bXB0H09sp4dv7ZZO2wp99p4VzjKLCS1+YQDECh16vuvzNPjfxtNWjiL966odh7yFgBP8ckVjhkLDXYdd9KwnWzINXhZFcrE+iar3uVjhiwNo7RLTUIqicmWtMIkpO42jcnlOUQHFbb4x0HB7LxU7IKYdjkga+JbIs0K1W8UIgJzly6cRNLrmi7Wwqc6sz4DS58sv6pytx+/UVOr2CWfnDzOf2m3fxOapU6utA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qreaq7pIlv3I9KgmB23s4C5L+I54TDWlcB/WPIKD+M0=;
 b=SMGMw5FEyK4/4n/aPNYmBT/hzc4ryje75svElacZq9lp9I5JSm87XauQbKxeZMzxtmW7TM9nq1AkPizog5tPVuUClV3JnRSUKCSUCN98w4IsQ87OiTfnse8sYT+Ed/B8QqR1v3aRmxKcSO/lCHx9BCDB+vs6lahpdVuDi1NAj0NeU1pYVTxXazZr8+NMg3aPVEtUSkZJNq38DwEKiK+JEjB4wJF+CcbNwe4B3raOLSWbeV3sczJUogNRKIDKD8vAIRpDRNGfflB+jBw/rRcx3r/mSoAdlZC2xLztjhBygLDOIxDOLZtAU7ldSdpS+awPmS2poqUk7bxau8f/dicvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qreaq7pIlv3I9KgmB23s4C5L+I54TDWlcB/WPIKD+M0=;
 b=oALvBcnXV24gM06r7Nv7+5X0Xusr3GX8t5hN++zKncr0v1Ttm8XnrsdAidzvoMJyR49sbqg7r6rAzGmp+bCMKorahOgVzS8D9kex5fywpxOTVSjpHlmhBfKE1sQU1A3Chdj94BydNbc5G/fnRlK9uvnqxUsZ0yjgUqTIGyrDChU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM9PR08MB6177.eurprd08.prod.outlook.com (2603:10a6:20b:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Fri, 5 Jan
 2024 09:49:25 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7135.023; Fri, 5 Jan 2024
 09:49:25 +0000
Message-ID: <6e63a1f0-8ed6-41cf-b1bc-34b49099eedf@wolfvision.net>
Date: Fri, 5 Jan 2024 10:49:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
To: Jai Luthra <j-luthra@ti.com>, rogerq@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com,
 d-gole@ti.com, nm@ti.com
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
 <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
 <f463e49d-9e69-4bff-a663-3ce7c1093202@wolfvision.net>
 <nza4s2kjmcptz6epbyegwy6wh32buyxm5evnk2jultqblgzs4b@6mzuklpqhby7>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <nza4s2kjmcptz6epbyegwy6wh32buyxm5evnk2jultqblgzs4b@6mzuklpqhby7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM9PR08MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: b270fd17-7fe0-403d-1189-08dc0dd399cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wov3L+NvCTDx9wYKNzGQ4/jkbMadpZRsNiUkyRfwiY38jj7/+kfknVXQX32F+W5elRkvi+lcFsvKbvzREH1xDc83k1AE96LWk33FqZCihfZGicIE7aY4kFQnOBFNFVfTGpc3E/3gbXkt4TVajJ/juL92RlEhsVinw+nMI88ZVSlmPoBd/0iM9l28Jc3aTB8psm0MwjJuswkC8CpYiX7wYv1f2pGuy4wZdiNYFn0OjK4h0aPNym6g4kBhgMbS8XEdkKdI/s+RhtK/JLPGQt7YBR9kmi2360BvYe97rRuJyVBE4INQ7ZHDE0e9osx/OEky0POBziM5fL5Z2amTgMIHy4cj1dAUis5VO3LKLqAHwHSgn+wn3xXj7PcTlbgWhZ4jc832yih8BZyVVpCkaK23pjLqLhpABQ5gTvGlARQY79ZsN0uu/lf33I4lTKvCrLle+rh0731RbwD2t8CLobd9E7wsdBQZy6eBQL8O9J63qVX/rq1QV77f5xj0ZkoJMevbIF4tHzX4OYjL7cZukrNn0gOw6Yd1okaq5VlBdbHrFJH5JYmgzXmsbzT3KQR5fuOPH98a9RZWi4Ftl6q6JnubwMBZnbBA04v6E2URDo1FBv/GFlOTEK1mmjZCJA446T6q41NhBsnpNDtQaaq7Ko6NhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39850400004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(6512007)(83380400001)(8936002)(41300700001)(8676002)(2616005)(4326008)(44832011)(5660300002)(2906002)(6666004)(316002)(54906003)(478600001)(66476007)(53546011)(66556008)(6486002)(66946007)(6506007)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2VubFVNKzNJdC9yemJPY3Y3cHd1a3VQWSthWEpuMDJnQy9Cc1RQcWprNGp2?=
 =?utf-8?B?U2lUYmJlUDJOQmtQaXoxY0d0SE1sOGJXd2E1VkdwZWhnVTlhdkdnYWhMM1FK?=
 =?utf-8?B?VE5OdzUvTkNOeURJMzNsZlVOU1VkcjByZUtlNFB3M28xQVZoRnR5R3VSY3hW?=
 =?utf-8?B?b0M0QXEzejRDbU8xczhmSThDRnpURVp4ODhUU3ZzR3QyTm1xU2JLRXd3VExz?=
 =?utf-8?B?MjI2VitJV3V0TmE1dnBJVEFYWXJSVmp3RzByT3loYlBxR201MWcvcXRYYTdG?=
 =?utf-8?B?aUVEYjZpQ3d3NEFDeFZEVEVEemtnM2QwWVF4dG1MeWpUd2pvOHRhUjREZ2xx?=
 =?utf-8?B?VThOTFFMNHZ3OEQrSkhyRnl2SWhNaWl3UW93QTM4a3MrNFJ4Y0VVWEEyZlZT?=
 =?utf-8?B?d3pzMTdtS0IvSWRzRXBFcDhkNWYycytaSkptT28xdVBDRFJtWTAyTjJuMzZ5?=
 =?utf-8?B?NlNDSUlaUFJLM0ZQK0xJNGRNYXgzVE9RaCt2UGFGUVZxdE5PeWp4V1ZCMFZo?=
 =?utf-8?B?V2pDQVQyTTlIRkNDKzBDNjNJM2dkRHkzdFkwRVJBR2g2bENTMDFORW96YTJF?=
 =?utf-8?B?QzJlcVkyenFmMFVnWnVGeVpzczVUcFJPY2dCNzRtbUxJWVRzRzhVa2lwTWdk?=
 =?utf-8?B?TTh1T2FJek5zU0d4S3FyRFhXTkpXVEkvSWh0OER6b0JrR1ovYmJHb3JOTkVQ?=
 =?utf-8?B?ekRlTWM1WlhTclpNMzM5c1NnVzBTc1ZXSTBUVVhEZjF3QjlEQjBWRm9LUWdn?=
 =?utf-8?B?VEp1TVpOMkpyRkpYQlp5SlZyUHpJaEJzVlJEOTJzRGtXcnJFRm1MWGR4d3NL?=
 =?utf-8?B?bDExNjRXTW9Sd2RHcHFHUGJvQWJ3S3RLSklWbjloUWU5enpXNURSU2lCMnNN?=
 =?utf-8?B?K1dic3prZXBEalphbzJxM0Z6RStNalVRMFZobGlzR0tnaGxWcnNYWWpNODdK?=
 =?utf-8?B?Yk1GOUJMUUk0Nkl4dmEyam1Yc05IZUdYTXNMankwek1jdGRBUVVFWWVSVlR1?=
 =?utf-8?B?Ymk2KzdDNXlpbTNXL04xaXBRU3FGTE13dndaelRBa0lEcitXNzg2YnBQVTh5?=
 =?utf-8?B?d1pwenZMajZlOFEzNS9yTWZnWU9CZjQvZ0VITEZOSVp3NnVmaUNtZll4Y1I5?=
 =?utf-8?B?UlRCUUtRZlM4a3hDbTI2bE02U083K2I4QmpvYjJXa2tqeHBuUFF5WGg5RUxi?=
 =?utf-8?B?cjQ0ZkxSanhtQ2M2SGNTcExxRHcyTnZOWEY4Yy9tdXVQY0hnbEg5K1RXN056?=
 =?utf-8?B?aE02a0owU1dnRlpRaVR4MitMUGplNXdkK21sazlFQWJMSmNGQ2g5Qm5ENXc5?=
 =?utf-8?B?VWlzSnFKVnE3VDhiT3Yzb3dDNGxYSEo0dTV5U2FVMExFQ0dxWVR3amxzenpx?=
 =?utf-8?B?bjdINkxPMUxIVDhlbjdyNjAybm9oQkt4VWYzb0tOMG9JN0RVRm5pbjBqUGJI?=
 =?utf-8?B?RzFkWTRCblZ0RlA2UkNuajR4ckg3N0xvUTVqQy81b1JaZ0FkTldGVTRLREFC?=
 =?utf-8?B?VmVyMXc5bG5uTHEvMXVXVkVsOE5uQ2pHM3FpTzM0cjk2TWhRdE9nV0xONE1T?=
 =?utf-8?B?UTYxRng5UTVPSUVjWFRlRkFnOGd6V1ptTEtkbFhob2daQnEvSDF3NlhBSkk0?=
 =?utf-8?B?ai9SZk1uMkJhTENTcDBHNkNyRlJFTXN0RzhOL2VoQlpML0pobFlRZTQrVFhl?=
 =?utf-8?B?blFyUVJUcXFEU3licllZOGtUU3JpU1U3MHV3TWxNTm1uMEE3OXZSeHdTcXhm?=
 =?utf-8?B?OVBwWlFZWU93cE4zTGhpbXBVdWU1RFdWbXRkOHVuNFJ2UWVpejROcEhCd1ll?=
 =?utf-8?B?d3BlMEE4QWl2M0ZtZVQ0R2xrdHROaFlwdTV5MDdFQS9PUXJBdVlEK2lpT1pQ?=
 =?utf-8?B?ek9HU3pJWlhsY2owWUtpME1qemlpQ2dZNnl3OTI4UFdONytOQ2F5K29CdDhp?=
 =?utf-8?B?cExBbVlybUNEcFJxU0dCS0plUkpBM1A0MXBUSjZ6d3ZZbFM5dTVCRSsrN2Jr?=
 =?utf-8?B?dTRZM3FBcFFWSjFsR2hyaldKcXRYRjA5SEh2S0w5TXF6UmZFZEkxa2ZzN20x?=
 =?utf-8?B?SE1MVUQrMDUvRGlHK2o4eUo1QkYxR0ZNV3lFa0c1eVVpQXNMcjhweEo0K21r?=
 =?utf-8?B?WVRsbGRiaTJUbUZQTEZqckFHN1M2OTR2Wk1NNTFITy9TUjBmcmE3SWtZSWxt?=
 =?utf-8?B?OGp1QjJ2TE9KNWVXTHZzYk1uLyt1cXAxSTI4OVdyVHU2R3NZWUc2c0QrNlFO?=
 =?utf-8?Q?Mh2rvruPeqkyMuutp79Nj123E8p3wu7ifwPyPCc0ZA=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b270fd17-7fe0-403d-1189-08dc0dd399cc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 09:49:25.1580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EX0wKVafFYiKMWiijGT4iacwEp0moiVVWqVE06FS5yzvukdthY8iJKje3Q5/Eq1pfDVMa3G2HBl3L1uAT/P8bZkMbP1TG0H6XXI+WEFql9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6177

On 05.01.24 09:12, Jai Luthra wrote:
> I added some prints and can see that the probe fails once at 
> fwnode_usb_role_switch_get() because the other endpoint (of USB device) 
> is not yet probed. It then re-probes later where it passes.
> 
> The GAID reset being done unconditionally in your series seems to cause 
> the board to get stuck in the boot process when it hits the above error 
> due to probe-order between USB subsystem and this IC. My guess would be 
> SoC stops getting power because we reset the PD chip?
> 
> Anyway, I will send below change as a separate "Fixes:" patch for now, 
> to keep how things as they were before your series.
> 

My biggest concern is that we are sending GAID for the tps25750 under
the same circumstances. Could we not have the same problem with that
device? We would be resetting the PD controller and the SoC would stop
getting power as well, right? Or is there anything device-specific that
would avoid that?

> If you have a better architecture in mind that can reset only when PTCH 
> has been applied and not for other probe defers, feel free to send it on 
> top of it.
> 

I added the cold reset to have the same behavior upon probe failures for
both devices, given that they use the same command. But if that can
cause problems, let's leave the reset alone...

Best regards,
Javier Carrasco

