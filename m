Return-Path: <linux-kernel+bounces-7798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7A981AD1A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2602C281240
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4608D4420;
	Thu, 21 Dec 2023 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="lqlu9iG5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFB24416;
	Thu, 21 Dec 2023 03:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xlgbq+py2YPN2/wOj2SNiCuPJF2XuUvg4JZHZn/xRiV8StLGclsbt1SV5oBRanTOVBua8Q6wf6TV0rklL/IdtVEsC/tDldvBcDDWaVDizpyBv4AL+YXm8s7pGEWz/RaY6lc7YqhGd7jfareGG5yrz23DMkz10OF3CuhJ5QCCMYAzuxSksuYXbXJ5wfPgzRFmydyC94HbhOxsVdfvO4FZfDQmFje/I7KV45/AnXhuHVjVcZtwEUK6BULSmmYD9/8WuJlLkDm6zi060UgWNnRTif7km2w8hJKcHC4Oy5va3lvncwBhcB+KhdJctOqVIIDhjckNPrii8MR8Me7B02BFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0LyYJZMrN5QrDFF6nsdkYOdTJYY0CWwlgSq4cAuVXQ=;
 b=PNBFko7ASzix28oCxtttmFgpqu2Oh72YNQyEsXsAZb8/rG2LMHD1IWnyyCdxuWbbGKy3ayjwYcAj5E35kZ/r/AGONxzw4t+9UdrslLwNQIBwtqkc0v5jdb6bZYjsGBr1gPJCm/9fgtsfCljd3Emm0PEL99wegAw/yDahJ8wSZi0olcR5AFmANFJnJQ0Ihnq7+jd5bkumgkfIUbEZF7Rilk/EmbCcQJhspREJJ4P1z18sZk8NhzHelhRCiw0cO7p23d7Oy2gqR2bpAQWOdzWr54ZmhuYpx6jtjXbvF+jDE+Ka+Gcz4v5Xt9/xoeRV44v5/vkU0m4NJSCosltsdPADew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0LyYJZMrN5QrDFF6nsdkYOdTJYY0CWwlgSq4cAuVXQ=;
 b=lqlu9iG5SstQQjo48fan1P1F8nDj5QASpqoFBqFAMLOB8lqqxEwg3tLvxV/U73NRtaDsDJyI6djSh9XjlU8BgXnoAhGSaIu6jUuw3dBohNiwjUemiO2ZsSGehW2CVMgyTA5krgrSfUj3jA36D2HNf9/7CL1kzHikyyNTL1D2WxyKjNGfzBuDp5xQzGjnnAFCNuzFC0KBnAe6BCSvxRE2GocCFmUYoJhV/W6oo6WmI1972NrAz8MetOMd6ENvWcImE1nDu4b84j0VEvAZL/AA/riHCT5Jz5Avgrvdg/ISKT8ERnFNKONF/9cSJPwg05aeDrZLlDB/qzTIvkPrsN43DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by TYSPR06MB7100.apcprd06.prod.outlook.com (2603:1096:405:83::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 03:16:34 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 03:16:33 +0000
Message-ID: <65adb1a4-51c5-40f7-b345-f278abb4ef4d@vivo.com>
Date: Thu, 21 Dec 2023 11:16:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v4 2/2] mm: vmscan: add new event to trace shrink
 lru
To: Yu Zhao <yuzhao@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 opensource.kernel@vivo.com
References: <20231220012123.2787-1-cuibixuan@vivo.com>
 <20231220012123.2787-3-cuibixuan@vivo.com>
 <CAOUHufZjxjra9Cfw8YC2eA-xsikPw=K5=1ew55hKTdYhMwjUig@mail.gmail.com>
From: Bixuan Cui <cuibixuan@vivo.com>
In-Reply-To: <CAOUHufZjxjra9Cfw8YC2eA-xsikPw=K5=1ew55hKTdYhMwjUig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To TYZPR06MB4045.apcprd06.prod.outlook.com
 (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|TYSPR06MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fadae4-4696-4489-1013-08dc01d33bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	64sET4Ia06LDn79Wuk+sLRdk5DYbFWO0sfST9T87F5RulxUWCVU4zd8lVrwrRndOtKjqIEY3EzsTAvb7faYyx1DEZxlksokhSiXnCa2Y14IprRnuBSuuZAjknheY2tqSZmyhrnGB/X7kr8fKXocovkb+ZF97Av12N78sizdqWDtl9k7nwxANtXMtO+ZHHXZyPigjHYeJEP/1lFki5IQRiecwCUCzgnAfUwEZ+Ujb3XP255DPXDDPYeQsFarsigY7Va0KpS88SR8kmj47hbmZ1MffnTYiSb2sZV0FgWarYhXEHPAOMbGPv05rNKaSHvxZB/r8UrdvgbWcU0fv056ybQu6Xve9XlVUPwygjwp4+hJrkm8vAUPau29pbiSTPDRGxqgQgXT3pSzn+rEENXmRJ0x9vSsbpU5FhQOJ/H9yNtfVFfXr7NhqJVS9xkCiWMU1dxcm6VXFHOIYJY7bf8E8RXqEcPEBxx5ngoLSmeJc2hKoKxaKcsv8H38LaDIVYGFVEtIShl2p7CPu/WduvG4Mn4CIlgsrrCGHSG/xxVDLEHcuUbe1Wyz30EAFrNugMNZU66PMJok+XrgZt77rFkr6NnqyTWEucW/OrhZQZqViyH7f8NF86lqAZtX9B35pDd4CluqcmPxE6FUwjtv8jIhNx5xmJqCC6l/hbefmi4BC0UspPuJk+G6FDbPJ5Cxqz9QZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(6512007)(6506007)(26005)(107886003)(2616005)(6666004)(31696002)(86362001)(36756003)(38350700005)(38100700002)(2906002)(4326008)(8936002)(52116002)(66556008)(5660300002)(8676002)(41300700001)(6916009)(66476007)(66946007)(316002)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzVMd3lWYUpNK3llRjh1STdzcDJ0UVFEN2Jlcm1qQ0drclk0U3JKaElxRFB2?=
 =?utf-8?B?WG9haFhkczF5UmptQklEb3NsZmtzYW5kakFzS3pJY1E1elZIUnVJWDJwZ1ZF?=
 =?utf-8?B?andLQStYbTl3eG10OHFCc3p4SWRWcWg2VFpjZ2Y4S2FoVndqZUdEZUtvck1Y?=
 =?utf-8?B?WGpDK3pCMjVxWllicE9OQk5KeUdsYWxqUWs1SGxmVms0OWZEN21pQzRUdEZa?=
 =?utf-8?B?eVgxejA3cnlTMU42NU9CTTJwc0U4ZWtlNzFvNzVsaFV1NFdqSkpnSTBOZldn?=
 =?utf-8?B?VVVKQkcvcHkzcndUN3dyNDRtS0hHMEFNanFGbytBNW1zaHYxSDZ4c3Y5VXov?=
 =?utf-8?B?NmIyZ2NMdWhjdkdEd2x1VWdkTW9Md1RiRm1hbE9jR1NnbVhtUWJsUEE2ajU3?=
 =?utf-8?B?ZnJWZEJiMDlyNS9KWkJ0VkE1UUNudkordG92eWVabVVXakV0SnFUOVUwVSs3?=
 =?utf-8?B?Rzg2MHdoV1hSWkxLNHMvMndUYitvcXF2azRmcThjYnA1T0JldmdLTW1VRGRR?=
 =?utf-8?B?SHgyV2dTSUFtcG9QNmorbFp1cWgxY0IraXBjY05ocUFGMGNYcHJkK0orNU5a?=
 =?utf-8?B?UjlDWkFRQm9tSnZPenR2bzdMcmVDMnM1MzFOQlgrY3BHVm9CWjUxQlgyU1JW?=
 =?utf-8?B?K29sWmo3Ukp3TXhKb1BWR2VOV2dnaTJDL3ByRTA0KzdSMk5la2xUaEU3TjJk?=
 =?utf-8?B?clBQZitQSUlhd2xQcHVLRkVOdFA3MllyaDc3V1JsOTFCRVpjZTRLcDVEY0Jn?=
 =?utf-8?B?a1hrVWhiWHFSSE1BYlFKT2FmR0oyVzk3aU1EdGlMTjNWQVVheFRybExVYUhX?=
 =?utf-8?B?bnh6ZXUzYnJ4RWpvT1J5cW53amVTZW1sb0xrY2RUTDZ5eFp0SEc2cktneUoz?=
 =?utf-8?B?Ui9XaW5SbDFiQWZab20xbWdjYXdoRjNrSmIwVTc0VDZlOW1UU0Y2S3dIRFI2?=
 =?utf-8?B?RVk5UjNYSjhweFk4TDJFSGJiWm9LRHU3bWN1eTdvalpUWlNZeXp0NzUyMkFU?=
 =?utf-8?B?SUxtZHFUZ2haUEtDNWVRcWd2TWowOUwxYTc2NTQ1RDBQZkVDanhyVHFKd3dM?=
 =?utf-8?B?RzNURDhPN2lWTUluU0RDNGNlWjNWNGdJcnoxc0F6ZXRBdVNvbzVISFQ0WUY0?=
 =?utf-8?B?NzB5UHNQL0xUQ2NXTWdxY29PR0VYMVNESjRESnNXU3BNUmVnSkI5QytIanJo?=
 =?utf-8?B?NWtMdmVRbFF5SkFBTWZIWDJheEx5L29rSFR2cnFDOEt6cU83dG5WREkzNEN2?=
 =?utf-8?B?YWowRGlpNjdDc0V1eVpWblI3eW4wRXlWZ2ZqV0JJM3JpeDZYMk5oWGhSSHY2?=
 =?utf-8?B?SjB6UkJPUGRNWWpCNGpUMC81UnphS0Z3ZTBDMkN0cFYrRzlIMHBqSnB0QWxp?=
 =?utf-8?B?dkVVa3c3OGdMTmpGM1k2NzI1ZHk5RHJ5QUkxbVM1VHhoa1NrU2tPT2xrRUpy?=
 =?utf-8?B?a1JCM0VISFlsWnNWTkR0dE9tMWUzbkdVcm1wVXZQVXdjdHZZa3pTTFJMQ1E0?=
 =?utf-8?B?UHRQOHRHNTRGYVVtNVNHZXdscS9oTHFZRzBhUE1jeXgrOVFpelVBODY5VlBp?=
 =?utf-8?B?VWNkVlJ2dUdXRnpvbG1memhjdmprWk9UdWhZS29abW9iVTB2RVh2c0ppbVdy?=
 =?utf-8?B?b1JFSXRUQXA0ekQ2OE1Ha0taTmdsaUNlaDZCRXFOOHF4aWp2ZXB2aVMxNkRH?=
 =?utf-8?B?a2hHMUZpNEhqUFVBWmFFWjBQTnZlbzhiaFI2M1lxM1U2aEFlbjdwTEdUeGl3?=
 =?utf-8?B?eXhYVStjeWFuUEh6NCtSQ09zbEhPL2dGTmNaYURYWDlrRnBiWG5ITHdYdGdX?=
 =?utf-8?B?eVZraitJZlpURmxDbnpGQlNwRnphUjlvREtPOXlQTGJydGtNQ3NpMGdaZ3BJ?=
 =?utf-8?B?RE85Q2RBOGFCMDkyU2k5YUc2ZGVqK1ltZjVPREJjWDA4T1lMZTMyNFp3QjN5?=
 =?utf-8?B?V3paUWVHcy9YdjZ6ZnRFVksvMWpQSXZCamZQaHo1ODNrbTN6OUdYNlNUa21i?=
 =?utf-8?B?L0hOR1VqQUVxYzAzN3ZZYnFYZlJjeG10Y2tFMGNCRGRNVWtERU8vaEhxM1JO?=
 =?utf-8?B?TGV3NlN0QitpQkR5NEpjYlFhb1BxZ0pyM3pnNm9wNk11eDVWU3hOeWUrTlQr?=
 =?utf-8?Q?UCeJ5vrw7lE/IOS+5DkCddGMR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fadae4-4696-4489-1013-08dc01d33bb6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 03:16:33.7549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0g55CFt7Dm8oFOVCxhZOLk4a8Yoz73ZCoUQ+d25IMWe9ZjngNmAUk66qZwC5qU7agbY0/wEZDOSckvvJLMVSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7100



在 2023/12/21 1:54, Yu Zhao 写道:
>> Signed-off-by: Bixuan Cui<cuibixuan@vivo.com>
>> Reviewed-by: Andrew Morton<akpm@linux-foundation.org>
>> ---
>> v4: Add Reviewed-by and Changlog to every patch.
> Where did Andrew provide his Reviewed-by?Hi,
I just want to add Reviewed-by to my patch to thank the reveiw of Steven 
and Andrew.:-)


> 
>> v2: Modify trace_mm_vmscan_lru_shrink_inactive() in evict_folios() at the same time to fix build error.
> The reason v3 was NAK'ed was not mentioned or fixed in v4.
> 
> So NAK again.
The build error pointed out by Andrew has been fixed in [mm: vmscan: add 
new event to trace shrink lru]:

@@ -4524,9 +4528,10 @@ static int evict_folios(struct lruvec *lruvec, 
struct scan_control *sc, int swap
  	if (list_empty(&list))
  		return scanned;
  retry:
+	trace_mm_vmscan_lru_shrink_inactive_start(pgdat->node_id);
  	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
  	sc->nr_reclaimed += reclaimed;
-	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
+	trace_mm_vmscan_lru_shrink_inactive_end(pgdat->node_id,
  			scanned, reclaimed, &stat, sc->priority,
  			type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);

Are there any other reasons for NAK? And thank you for your review.


Thanks
Bixuan Cui

