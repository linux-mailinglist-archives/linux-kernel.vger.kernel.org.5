Return-Path: <linux-kernel+bounces-57846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4484DE21
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606871C2359B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DDA6BFC2;
	Thu,  8 Feb 2024 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GJLmOuTn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i4SDpC6S"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2E6A347;
	Thu,  8 Feb 2024 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387677; cv=fail; b=bB2Ro30Yjk4PmOYR5IOsifxUpCprebK/4lkNB2UrFix0WLjudWSMDM4B6PcKIks9A5mQRpOooc1I19MYMTvCpDd3lx6UAzR6D58mUkLcDL9EoLXEnm59i8GIABEvrZaZLh70qZhZMYccdlQh8oIm8p1gn+zr2bVYWqv5RfkrKHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387677; c=relaxed/simple;
	bh=YbEXRayoXXt5ZO/ZxRXVFYSdCWsy+exHMecJHQD5L7g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RQlAetOz5/9AdCt6AmYa+deJGu94k65jRpItXN3IIxrUGFDjW2SCKL+Pxw94jSrgCLfkWpXAWk4nPGkvyx3QoKHmB/jd0gskmzNJLeaBBm8cICUf1317/2MrYxx8PB5j6L5CbhAfHZJ4/clR3pqzuPREPWDn4n4ufiUCAB5BiP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GJLmOuTn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i4SDpC6S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4188xk0F009442;
	Thu, 8 Feb 2024 10:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OBaRRfSO0BQB1Y8ZRkhuLTwl5TO3a3uJpYknUqjZd28=;
 b=GJLmOuTnzbzRolVyGzPbo8bJ0krZs3JqewLAb64wSa3aQW0dAennsuZ8hxQ7xqyN9w+V
 aOQ4kqK6Xelkx/bOcVFWnibcGxr1tn8YA97A/Ais2OmqeCcdhMFClP9yq38t70Xcfnqs
 j+6NuEkCXibExKxoUnKCZ25u8l/IFrJfdJsxe51Fcjn2wpUUod8ocEOGmfojlRPTHZ8b
 9h7MT73cHfr8S7QecK9JKR+6yGmRJ/AUx6ImxjnpJas6bYQWgB3BelUEvGD5OZ57zn+/
 5tK+Zp19Tc83GsM/aapRSZ7VvpfeA2uOIEtLX+4Lw1QwHu3WnyBD7YF1BByPOq6raMVP +Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1vc3hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 10:21:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4189ZRQY036711;
	Thu, 8 Feb 2024 10:21:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxaegp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 10:21:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dn3nZ4lYlGw+SOwpLm7m1if4TRo/V0c9Uigz9Ec1vFu666y6zWxcJywWQLJoWh9CdU34/VOoFgjLirXEabFxAzczEGfI4+JtZCmpGU+E8vioMYu/MrWmUvAaorbzh24qzLcI5QSSAicatLy43nPI8H9IfxDp/vPO1J8TNOx11xuImY7oSxO6ZdqaxjNJwifG8qpJy/fXz6rlcKTyWhkDPbntbfGTlIYTkIEuU/y7t+3o2oHuRkfaWzacd2+kqENh+qOlHLqXV97Iy33XslmFnkl8SITNP1gNl6mvanRi0vBCY41hAWbR/JY/giUwy+KIHxjPJbSJYJiuMmWFTBgymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBaRRfSO0BQB1Y8ZRkhuLTwl5TO3a3uJpYknUqjZd28=;
 b=mMIaQbwKnQJUJIzNYNNAkieXtEfAIRB6U2M86MPE4RVlx6IWk40UtMlZcgmfJZtHC6KykG7+GwQfcXEUOeegFumSORMp7cfHQ6WlQ0rRN7Dn5hgM8dJZhMGmt9aGVqFFoecM/twHTH1zThsDtt1PKq24MGAjy0aolZoTgN05EaQ1f+w3ZY53bXYiUI6ARwkXUYuSCg2uWAYkS8xkidK3KD1OV/Mm95dgj55vx6Nnhs8e7Zhl8HuYXBKbcwd0wuBskCKZUX1oow1pfCd0pJJ0hemUS6y25JcvrL3ypjh7DjfspLzpB5tDYy97qjaa0bO/oJpR7r0lysUPjM7/mHE9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBaRRfSO0BQB1Y8ZRkhuLTwl5TO3a3uJpYknUqjZd28=;
 b=i4SDpC6SGiuZpG8NkxrYKV6pHfb0tG+p9qb+JBdK/dARtouOpm8BLgzHjD/2ybYEGib9dXvKQciqrIDsugnnjl1ZLkR6YOqW8I9CpPw5zylzvnv4fIIGBX3HXJ3r9ymTUFhpykzrWqP0FkVDKCb6GedsjO6npM57smILPu0/eGA=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA2PR10MB4457.namprd10.prod.outlook.com (2603:10b6:806:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 10:21:05 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33%4]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 10:21:05 +0000
Message-ID: <c6555e01-1945-410e-9950-53c40052626a@oracle.com>
Date: Thu, 8 Feb 2024 11:21:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: scripts: sphinx-pre-install: Fix building docs with
 pyyaml package
Content-Language: en-US
To: Thorsten Blum <thorsten.blum@toblux.com>,
        Jonathan Corbet
 <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240207111236.7242-1-thorsten.blum@toblux.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20240207111236.7242-1-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0111.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::13) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SA2PR10MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 093e95a7-323f-47e7-c2aa-08dc288fa8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SjikIIBtaEazv3OrRz73BoP7lfs3xcBS2TxnZxMjEb2oql0GEltn/Ow2iYMCqZrGfV+eHbD/WsfTMW5xgsCrajVVit3I2JDm9ydoSWSQORnnaLaE5zkhn+tHEPCtms/PCoAaddhyp2F7TpDrE8IHneZLdHPvJnFF9IoIkjz09qz42zNle45rblQqVsv9Rd30vZB1pHDeie5juE/T5RsS+6sK4/Bpz5L+mh71NEyRa5Oks2lMMd2+0YB9zb3v9uoU1LWiRz8LutMuYVkDy2Gmg4fsB2Dy0XNHNqgH0W4MkaphumRHYUAIewrtHTvoOFlX/rvmQZWsQdDFPsIVd9xUdfB7et/iS/qUr4z3lTKV0jndbYnWESH8+A30C7CrfBaKEsCynEGQSrZQuFo6/vA6o9ja7SRTG+czljBvk7Hza8j4MrtClrjTLHjZr8bkYWGGbA/5ivQGFh+jHC8gK729R/2HL86oKsCiBLLnOwewchEN4us/Y6QMttLse5eTWbAQQpawvw42wmjBwaRZ4xECqcmL46FxsIWlP9Jh/hFBplpji6pri/EwcR1tGcoKzNCf
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(36756003)(41300700001)(31686004)(66946007)(66476007)(66556008)(110136005)(316002)(5660300002)(8936002)(6486002)(478600001)(8676002)(86362001)(31696002)(38100700002)(4326008)(44832011)(4744005)(2906002)(53546011)(26005)(6506007)(2616005)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bXdVWkhTWkRYS3p0Qng4WkRvU2JwSUQ5WGlPcjZESG1HVkJmQk5WaFZxTGx2?=
 =?utf-8?B?ZHViU3ZJVjNFTktlYll6alNRN0pWSFNuQVdsK0dCUW16cFpaZVRQdUhDM3hH?=
 =?utf-8?B?UjNBcXZ1dGdTSVFweUJRY0F6cWphcW0rTE10blJHT05KOVdLMjFJd0oyQnZn?=
 =?utf-8?B?NWJZNHhJK0pQMHBWU3NwdDMxcnZlbnVweGU2TGl3RHlaZ3Y5VzJ2QkhMZVRJ?=
 =?utf-8?B?aEU2UmcwMGtTczBydzlpWWo2MlNKNTA4NnFZM2l6RXZJMFpGMXRDN25JOWxX?=
 =?utf-8?B?YnMySnZmWURkcWEzREZaanYreXRQMFQxczFOZnNMd2k4TjYyejVXUSs3bmk1?=
 =?utf-8?B?c0lVRVRCeGNjbzdZQkxTeTF4NzJ2bzhOenVNem1WRlplMFNKNWNwZnY2Tk94?=
 =?utf-8?B?dDk3U1lXVUNaMGxuc2l2ZmtKKyt6TVpmTW5vN2VvWVZiQmVuN3RvdVFyZlRn?=
 =?utf-8?B?SEJ4dzBjSzRpR01KOVhqN3FVWWhoODNadjZkS2Ixazk3VElHbXlpcXowQ2hk?=
 =?utf-8?B?TVNIRmtkTHZHV2JZUzEyeXdsbWNsbmcvWGtIbG9yVzBFVlZGUDBvdVp4S0NQ?=
 =?utf-8?B?VWllcEc2c28zSTE3VzVwaGdmcVFCc1lQUDBtNFVBNFNiUTI0Sk5zZWVSMDg3?=
 =?utf-8?B?QlBTaDFkblYyaER2dXdkS3h5c0RTYVczN0k5OHZaaTQ1VTQwK2tSb0tmekxt?=
 =?utf-8?B?ZEpMQlEwSUhPQjVnUEJySittK0JPMEpncHQzYVMvZHhxazdyeUZuZ05iRnU2?=
 =?utf-8?B?THhUdWpSSWNvaW9ISS9FZnc4ZWdFdlIvNzVqMTV2L1gwNWhuT2c0d3pCcHNY?=
 =?utf-8?B?Q0VOMUVHUU9Od1BOeEFTazdNUTNjdERzekdUQVd5dEx6aWJodEloRmkyYnNR?=
 =?utf-8?B?WWxVc1lzM0tDcmtlc3YwamNJcjhHSTVaQjR3YnJwWmlhUjJTa3htcC9UVWoz?=
 =?utf-8?B?SndOK2JNQmdsckozZGFmRTlIMS9mWDZVQXYyOEdrb2JIMyt2WllxT1VYTW1w?=
 =?utf-8?B?N0RKY3ZpYUp0NzZCdFdTaEpDdlBRbGdDQ3JENDUwaGgvaWJhMHpYZ3V6REdU?=
 =?utf-8?B?THhsTmhQNEQ3bXhSNkNIdnJ6M05UVUlJVDUvb3BXRHMrTzJvR1RuUnluT0JI?=
 =?utf-8?B?b3ZVWHQrdVpTK21QUXZvZ0paWHpPUUhGSE8wc216ZUtZelNPNHFBeStxZ295?=
 =?utf-8?B?TTRmc0xRSFcwbFdrVTlEWWZUSHU5SXR3QzJ6ZllLczRROXpTaHFQZTJLeEFK?=
 =?utf-8?B?dEUyR1NCc0dUeXl5U245M2RtWG8xajlQWE92YVhHYWUwaVI4WE9xeitaSWFF?=
 =?utf-8?B?Z0MrcjlzTjFtcHFCYlpBRWZlNFVqUXJjTnBnUzlOMmZOUFUybjJyNk8wSEpi?=
 =?utf-8?B?TjBGYjRBa2JkZFhLeGwwNU5zYVFvVTBLY2FlZlBPbll4cjhyYjliYmVRWUJP?=
 =?utf-8?B?bmYxUUJjSTlhT3ArM3hsN1RhVHZpb2c5amcveC9QK0NMMjVkU0dzSVVVRm1w?=
 =?utf-8?B?K0JIWjVFZS9vbnlVb3hiQkNWNDhzQWZua08vbmFOR1dxbXBiOGVxcmxRdWMy?=
 =?utf-8?B?UVllbzFXR1VTN2szZWVZN2RaRks3NHJVRW9pUk13L0VaT0RGRW40OWlxSzVV?=
 =?utf-8?B?cFRIaUR1MDIwSjBjeFJuTU1VQWJtU2UvaUlsaS9KYmo5c2dBbVgwRm5VNGI2?=
 =?utf-8?B?UFltNDllc04xSXNaVzNRSFFSeWUxUmg0bXhhVUt4ZjlyOFR3T0NrV21KdkRT?=
 =?utf-8?B?YU9mNjZoRVc5Yk5WM240WXVFbFdmZWttcTlHYXpSeUNwU3pXUFBnNkozZFJE?=
 =?utf-8?B?TzZQOHphUXprNS9DNEpyMytnN1pWZ1B3SWpKb1B1ZERzV0pZRGhSUlVoQnlH?=
 =?utf-8?B?dTFUNFFwVEhXTlRsR0gzOTZUZU04aWk1ZGlHNTdtS2E4ZVExNXM0bGduVTM1?=
 =?utf-8?B?Y0premdYd0RFdkRzM0xoMDA3Q0wwYzBpZlBTelFhN1ZmeXVsdk41TzQ5MHI3?=
 =?utf-8?B?bFBlb0s2NjE1SHNLdE85dDJUQnRoUmFobFNkYjBQOTBDUnVDSm9Pb0Q1N2Vv?=
 =?utf-8?B?RTdQWDcxT2Z1TkZWcUpLVXRuS0twK3JKbDNwUjIxYkRVam11TFpxU2NZeTVS?=
 =?utf-8?B?WWkyZ1ljQWpmZmZmY3d1Tm9pTEw1YlhSV2FsMUVvTXF3RU85WmhmVVhHM3o1?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UMsSudxXgLRQ/L7J0CRIoDvp9qNfRciF0rCdeTGF/W+gqUd5FcXbkULWUMqTMBWQGAkMUtT5+ZFZngHCs48G52gbKD5pNDLQV/DgiujFuzVo8TiTpyW1puSoEGl1ScH9RxewiiIQ71dhefZ2QPaQljT+hv4De0FvhvdXZxosz/wTnlpx4WanwOAlz/5lLOq4ou0ml0YUppRdAXqT6RXgQ1MoBe32fKCW84VIwx1jFTHCa8J2uU8e30BX5VSZTPDY6REewirIZPXbUvFxdGSxG9YH7vnDeIbsrgoMRpi++Ujvi7zikSreRz2wrXHwY0moRftQSS1+DwUOWSpm71QF+c1QzH25k5FNjnfYLNNA4iuggUg3Y5upraRceceND9wSU3ZWi7Gr4A8zT8Gh94eDCqA+aeEB9xP84yNR8UEeFVN1ciBRluUYu9bnJUUuYKR6H0xIwuEx2oPP0T1sef2V9/cyI7hC/vCxu7357pctm/rEDvbf266wzFrG1vbnNF+vZ5OKNI0AgJxTAKMAngvbxtZTD30qsoccERtnU/yQKE4uPqhappYrDL7WLtLsIVagDT//O9EwPh4np5W7a8VXWBrd4jdiE5CWLHp42HmLKRg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093e95a7-323f-47e7-c2aa-08dc288fa8c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 10:21:05.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCph52whuhOYSwsU1dUl2RVQa/rXHsKbdi/T2tjtgx10ye+yoRB+t8qcMWp08V2JenLcttutC1yPhIFGxTnJDgni86WHUKsp55LHmnXeW1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080054
X-Proofpoint-GUID: 90i0nEsB8YddllnEOK1k68O9q0RJX0Hy
X-Proofpoint-ORIG-GUID: 90i0nEsB8YddllnEOK1k68O9q0RJX0Hy


On 07/02/2024 12:12, Thorsten Blum wrote:
> The Python module pyyaml is required to build the docs, but it is only
> listed in Documentation/sphinx/requirements.txt and is therefore missing
> when Sphinx is installed as a package and not via pip/pypi.
> 
> Add pyyaml as an optional package for Debian- and Red Hat-based distros to
> fix building the docs if you prefer to install Sphinx as a package.

Thanks for fixing this!

> @@ -955,6 +957,7 @@ sub check_needs()
>   	check_program("gcc", 0);
>   	check_program("dot", 1);
>   	check_program("convert", 1);
> +	check_python_module("pyyaml", 1);

Shouldn't this be just "yaml" instead of "pyyaml"? check_python_module()
is going to "import" that argument and the Python module itself is just
called "yaml".

Hm, but then it's going to add "yaml" to %missing, which keys on
packages, not modules... Maybe add an optional argument to
check_python_module() so that it knows both the Python module name and
the package name?

As usual, I could be wrong...


Vegard

