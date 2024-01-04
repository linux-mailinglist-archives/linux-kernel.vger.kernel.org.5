Return-Path: <linux-kernel+bounces-17015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB5982472E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A751C241CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B062E638;
	Thu,  4 Jan 2024 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="pIGjQc69"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E92E41C;
	Thu,  4 Jan 2024 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCbGo1pXtg8gvpKthpMLKqi++sXUCzxy2JXxFfWBXJiuNW8W57lFQn9cEwIEOloYWUPHIb1+XoUQq1m3+vH/sacOoebJD8fe/PSDmq7CTpSdnFIKMEdMvN5eSyHnsDZ8epSpVkztGjCSUflblj83Dx/VHMbvvYxIRQPRzQsB3GVES0EQNBLB+O7W8Zhkl6kHJjMSrA63UcDOP7HA8MSxv1ig0nvhb5oyGAxN34FCne0xLp9fERWVzhoYUrlmMix2+dHJPBey2i+IQKuect/7Rp77IbEw1joN3QO9NrmD0cM74TCCHlJ+Zcq1iV75QMHaBgHKTbXRO85qscKFrbKIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18QHf6RG13EYJ8a22yyUePkjST2ghheORwQW+lRTVZo=;
 b=LQsXjG+Uomu8VNIVgLjXmuyQXJAunQQB5gINkPdBwrk2aPrHsv+Hs/ingPo3651/tpirHG0n37nlN8FQ4N5QMACCSzMX/degbhLpGthlgJLPBmp8VmFJ/EbD+7nsFifo0JEbUTgMuopMhPFAPc2o/ItKyV4HXYXfXhYSNAm4Y+XOk2YktYCfVyYh6U9ecAqrtQwNxrEgzsJNk3Nb86MkhaOBlcQp9cmVu7gI4PcwVg5neD2RjoYaNyLozkccQ6kpSLR6+Y2d01a+DbdMvuIr1KauSFSYwkHSraUGax1qyBXVd1G+ER6OxmjozTDgVG3pKmUqzFo4Rx7fL5S9SHxMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18QHf6RG13EYJ8a22yyUePkjST2ghheORwQW+lRTVZo=;
 b=pIGjQc690c6S1/xI2l/62Bce1m/YGqpDWcKuqVV/60ijs1EtzxXHF8XmA0PBmPVtCl9pSyGdyVLjOWrNhVsziMML4AopchAq0x92ykFToUH95dfTfLRlC3PqkBxFbKkIOmdJ0oX9AFGJaNynct7eHrPtOKdyB5GH3twVF8Xv1I0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PR3PR08MB5803.eurprd08.prod.outlook.com (2603:10a6:102:82::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 17:15:20 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 17:15:19 +0000
Message-ID: <31a619c6-f3dc-4a31-93c8-1a24a92d88ed@wolfvision.net>
Date: Thu, 4 Jan 2024 18:15:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, Jai Luthra <j-luthra@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com,
 d-gole@ti.com, nm@ti.com
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
 <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
 <2nqiaxakx6setx4tzgddnbjadbh7miegz5p6wamsbbiyrfuq3x@un2uxajbswkg>
 <e9e8dd9f-b11b-43fc-8d76-6734dbddb540@kernel.org>
 <b0963302-b498-4a81-b635-0b4faf02e83b@wolfvision.net>
 <5ed7ee66-ad7f-43ce-8550-a1a671cce9ad@kernel.org>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <5ed7ee66-ad7f-43ce-8550-a1a671cce9ad@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::11) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PR3PR08MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: b93e6052-4d1f-40b6-18d0-08dc0d48ba6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ClzAYhyO+RrSlPkRw3O7i8itfKHC3lONv1OCQ9tsAJd5SwFMjzW3zoueE1DQs3zqlaxP6o/jF3U6yNY5QoU/5bH5nxMhAiBTj9tx6nR2BXUi50QVz6HoWoU3yFgWBIOfQ0Or6T9SVmGF3u+k/qVzFHm+pIadUawDt18aWtebi4ruF/afW/E3/hI1W7/ivyBsQEaYtAHcQByRk/FvEEUsi1cIeZggtQLnRR2EbJzq47VR+l9opZYhzYBqhhz4akJZ3oM2DV60q0RtOFVWMR1LDVIZqv/c1E7z4WI5/ZQbDpRwNvUjqSeCLHjIJF7dTXE40V+jPBdS3Ah4L78Njuk+gaQ6Ci6iIsOJVdw8prrrZWRMrJ0yM/zofekPyBbxNAfLMaz7QiJ3b1DU5S48yaHGx8r7E9r7mIGiZLHKK05/aE+D0CCH6+U/aq8KZ5Gg/uagt3QUvZzxvzla4Oz1IpxI5huXrnUkqw1Nb/13HFSD+vJRZ7Y6Hp5k8VoRAcHyA30Z4Xiiqz54YsX5LZN2o34y1tpvIG0w3fizaIWz8+2lNOx0A0GoYFLEHDbboL/DL7r2af/bi0a8QgaGRxP8mOXF1S1oI93s4I4JSg4DwA+Nxg+aD8r0R5LmdYVZ5xrh8fZgCVlkpsIQcq6fsPk54C531g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39850400004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2906002)(53546011)(5660300002)(6486002)(2616005)(6512007)(6506007)(38100700002)(31696002)(86362001)(36756003)(110136005)(66946007)(66476007)(316002)(66556008)(8936002)(8676002)(44832011)(4326008)(478600001)(31686004)(41300700001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2c1cXNpVmhjbk5JY3AzTnB1WDZ1d00reERRVWE3Zno3M0NoaUZ0d3pITWZS?=
 =?utf-8?B?cU5YOEhxSjRvbm55RGtEWnp1SHpRcjR2SVhjUnAwdnd6eVc4UW9KQ04wWnh6?=
 =?utf-8?B?ZVBNbnZ3MHlnY050aERQMkZOd1VQcnpES3RoQVkxVEg3ZmdMVGV0N2c0TWlC?=
 =?utf-8?B?RG95WEpCQk5YT1dCM2YrYlpqUHhDV05nUllHaS9DZm5Ibm5QcHJVcmFZSG5I?=
 =?utf-8?B?SGdabFhaeUhrTTZ1SFZyVzkvbFZWazV5QlRQeDRHN2xLZFUxSFJ4bmNSQ0Vi?=
 =?utf-8?B?MUR4cU4wYm81Smw5L2h1K1orWlRJdExIMUFoT3R3UFlwRFl3clJoT2tPeGw1?=
 =?utf-8?B?Z0pvZkViNythRkJFUmNFc0NadEUxZTNRdXhZclUyclVNS2I0amNHZ2R4Qk1z?=
 =?utf-8?B?WXlsRnpNQU9TOHg3T2JSY25TUDE4RG5HRzFTRlIyNlNPUjBjTnpQSnJ2SS81?=
 =?utf-8?B?bXdFQ0hka2JRUk1oUS82S1ZESU1tWDdXT3NuRnk4VVBEbjlDMFJnaTNlRS95?=
 =?utf-8?B?clRhQ1lFZ2VJSko5NHVxdnhnSjg4Q3dqT2lOMUFqNlk5NnlYc2FLcmRKcFFZ?=
 =?utf-8?B?dFVQSFFWM0RwNzhTK0w3V0ZMN09kbEQ1cmRYb3BXR0UzYlVNRHRYS1hFd002?=
 =?utf-8?B?KzY2OXlRd2lmQ2dXMVk4VVdla2pBL0lWV0NBV2QyTGNYbWtZS2YvQ04xKzJO?=
 =?utf-8?B?Q2tENGp6ckFNbVRRSDhaOVB6TmFvZkNuclRjYzhkL0E4cUN5cHhIMmdabHFX?=
 =?utf-8?B?amxBeXVpcGhlcXR1ZjBlR1BtbDFQUHVXNjRyZm5YVFZIc1k0bkxPVkszcW1X?=
 =?utf-8?B?elBoUWhzSGZHT0hvTTgwaWtkTytPbjBBcEVaK0JCT3d4SE1NL05sM0R2Kzhl?=
 =?utf-8?B?RkZzU04zcEZ2NjlZd1I2R3JXcEIxNzRQVGxDK3kyeTRrVko2Z1N6TVI1R09X?=
 =?utf-8?B?UHFjRFVDM1YzdkdxcEQ4SlcwOXBHaE1RbXZhTTRhVTdrMVZhejBkOXE5eG10?=
 =?utf-8?B?VDlLTGpoTjZNdTVLUU9LRFVPN001cHFFaVVOeVp3OTJNM3dZejRMUTZ2cXo3?=
 =?utf-8?B?ZFRYeEdIRkp4bFFpN0cvUFB2SklZQk9rNXZ4UVM3NTNJbjRmdzFPNlNoU1Js?=
 =?utf-8?B?aC9rOTV1ZndEU2tjbW9nWVIzb1VONDl0dDJENytadDl6NEovMlVIa0NDV0NX?=
 =?utf-8?B?RStsMnVCRVJoZW1xa0Z2SEN1R282MHR1SHJGdFJyYWRDSk9HeDVpcEdNUHJ2?=
 =?utf-8?B?ODVQMGgwK2tiU2E2eGZVbUdkTkFyV1lva2ZWbnYxSmMyTEx1S0NtTjc5eURq?=
 =?utf-8?B?QmRNSnRjNnU3N2xzSlBrTkZaVzNtTVJrcXdka0NCa2MvZGliQmdUSWc4VU5h?=
 =?utf-8?B?UnByeDROQkZJL3ZBZDhxdjQ4d1VRUXlBck9OZTRzcGhMTktJK2FQTGcxN3Bl?=
 =?utf-8?B?eGZsckxqam9WMm10V2VSZEg0RE9LY1V3cUNOcVJYSXpMQy9relpGdThYeldu?=
 =?utf-8?B?QU43cTFlanA1b2JteGJTQk5SaVFncGJaWFJjTUE0WW4razZZR0hrNDcrRU1B?=
 =?utf-8?B?QWxzOStjODNHNEViRXR4dUxhdlVkZEpnZzR6ak9KMGd5QWZyVFV3RnE5N0VF?=
 =?utf-8?B?dXZERmlGZ00zUzhFallZTGxiaFFtQzJMRXlEc3N3bGxCZDNmZkVyQnNwandS?=
 =?utf-8?B?Yk9EbXlEQmE3b2x5dVI5K0JYRVE1SWlWUUdkS0I1YVFodm9yRkJPUHpyQzE1?=
 =?utf-8?B?QTlHTjFMY0JRb2pZcTE1d0RTbkNuNDA1eklBdTR3eFRqaWxzbDlwL1NYeDIw?=
 =?utf-8?B?eStITURrc2h0K1J1bVRPZGdnNDhDN1ZnbmI5ejV1NDRJeVRGVTZ5Z1F1aUVo?=
 =?utf-8?B?RzY3SVJtMjVyelp2MmZRQzllam1pWTFMK1hNSnMxajEydDBldXcrVWVoMVEw?=
 =?utf-8?B?bFltcUh1YmdCMWdwQk9YVkQ3MnF3elg4ai96UTBnMUlRU09nL2l1VmZFdy9y?=
 =?utf-8?B?aUE4YUxBREkwNUJqNTVYWGZqMitRSnhSV2hwUkoraEJRSjY5QzljcW9IZ0VR?=
 =?utf-8?B?WVhOVFh4TFFHckZCTWpScjY1dFpPMkhLUlRrM3NwUmdObjNFc0pUQjloaU9K?=
 =?utf-8?B?Wk9BdTd5UXVrVzBFTkRBcFJYQ2E4cVBPcW9QTXZKcFJyQU1VWlY1aFBRNTN3?=
 =?utf-8?B?dnMrekZMK0tOaVNtNjhmeUJmUWU0aEtqSmFsUlpQL2w5bHVzbVl0dmU4elhs?=
 =?utf-8?Q?HgYsQ7/HTpK47LWuIIjPJNczQJzTbHuiL/0c8mg9C8=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b93e6052-4d1f-40b6-18d0-08dc0d48ba6f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:15:19.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GHNeUYzAz7geuXNCJuYvDDwC9KTe6m+NxIJkUh9phlx9W1cJmgh481Y0Gmr2JT9ySjR2JEUPqEv6aIlwSSXmE+y7nmnTFoFqzYngVtXIBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5803

On 04.01.24 18:08, Roger Quadros wrote:
> 
> 
> On 04/01/2024 18:36, Javier Carrasco wrote:
>> Hi Roger,
>>
>> that fix only removes the reset function and does nothing instead, but
>> the reset call is identical for both devices (hence why there was a
>> single function for both devices). As I mentioned in my reply to Jai
> 
> This is incorrect.
> 
> Look at the original code, the GAID command is issued only if it is a
> tps25750 device.
> 
> Below is your part of the code that replaces it with reset() ops.
> 
>> @@ -1340,8 +1360,8 @@ static int tps6598x_probe(struct i2c_client *client)
>>  	tps6598x_write64(tps, TPS_REG_INT_MASK1, 0);
>>  err_reset_controller:
>>  	/* Reset PD controller to remove any applied patch */
>> -	if (is_tps25750)
>> -		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
>> +	tps->data->reset(tps);
>> +
>>  	return ret;
>>  }
> 
> which means the GAID command will be executed for both tps25750 and tps6598x
> as you have a single reset function for both.
> This is a problem for boards using the tps6598x.
> 
I have to admit that the GAID for the tps6598x should have been added
separately, and not right away with the function pointers. I added extra
functionality that was not expected. On the other hand, the GAID command
is supported by the tps6598x as well (Technical Reference Manual, page
113). Hence why I was surprised that using the same command for the
tps6598x is a problem.

