Return-Path: <linux-kernel+bounces-137566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397ED89E402
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C85A1C238B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D31581F9;
	Tue,  9 Apr 2024 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZnqDT9ka";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dUKgrXTI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87549157E9F;
	Tue,  9 Apr 2024 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692656; cv=fail; b=DmswRHTztB7Jm5ZQVC7BUKNIbt2uT7Hdw/AKk7GmjcCn/AaH3QzYdkTyAgxqT9H4q3W7Q+Ng35ihDFcc9Q5aiRgtIVqnU+i99+OGGGuLEbfCUUprjG9FQPrDVQmYRRZaZ9EU9XEVVpEts2CtcDjiNMH9udQCjL9NeDXPy212Y78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692656; c=relaxed/simple;
	bh=uOrGDqkkAKsKI9feEDpNj0rSvlzwf947K00dhWAubFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QfDxJxqJIttkcpECx5eE+deWd0am5JzT2ARo0mXxWXZtjUAG0RCAvoVhvxfuVLiG6EhIevce4ThFNem7hswX6LNQCXTLOTeOiHYIE/HKNuOomK+I0mSz4TFY3eVcNuP+qIvuIbFULmkW1bEYji8Fsc1hsQb0AHrzt7DerAd5cQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZnqDT9ka; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dUKgrXTI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439JUUN7000333;
	Tue, 9 Apr 2024 19:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aCYdJ0r3fKDrHQY+5WUn+ylNhZ1rqALD2s9ZsWS+gXU=;
 b=ZnqDT9kaXGN/NXTMikohn+eU9oB+xq98oBdoKHdBSXENoBc41Eau8PoCa10Ei2AViLpJ
 t7sH+Q+kssCIHMXdSQ24OBA0MJUedwwZGzEOJHgi3vxovB8a+tLrlwDrd7aOVWcegg4B
 gGMrOirLDD4Ingu+fJaye9rJiPCqCk+hm9n0yzu02Dwc0NAwHMeZbY5WNT7aTOBiDBJG
 x+JkyybrTEe77NCSq8jMiS4PqXLbpKfUcTrlCXhjIAIuyU45V7ypoxO/7CWCdK4OeyO5
 uaOedLgu/z2FBc9Xf+VjykZ2sfvRkASycOK4pu7uQopS1rJ4h7yL7r0ITkhZ8burXve3 dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax9b5urb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 19:56:57 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 439JhTdd010486;
	Tue, 9 Apr 2024 19:56:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu76ws0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 19:56:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfQRzy7ciX4997BdZs3VRgVfxipVP4IQYjkcst6T2/ozWXDHrQiyCyZcYiAHNq9guTUwC3shFPQDix1ycATGxztuP2j2S3fwRj9a4dt5OM71dbHQa5Wljj8QkpcSl749uV6Ll00zk3uFuxdZGg2tjhzMmZbqdo8oygLp+CeL9MGTzvvsDcD0qRsg0J2dniWHOSejKvBDTB4KLI2I8wSYwszw87y49Sd9NarjteY3/zMJ8DOnrgsKgnAZbK6ndkUS/bh5mLD+Z94y2WiSgI8hVZJel7EslLz0rbgWK4GAPw8Tb1XPvIA9bsMBy1Xgktxo78ulXqGKtBI538xJo+BUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCYdJ0r3fKDrHQY+5WUn+ylNhZ1rqALD2s9ZsWS+gXU=;
 b=aIrHJFtpDHRqwW9KKEuVIZ0UY0bn3Dd++oDsc8924ZlwvjC3iHHJV2LKjlQFniJPmHDQ30VrlX4LAJDVIigKmUW2IqnxB0fWhBrwpAE6Ew1oL8luV99ySOxSUqh7SHkeqWNUjxXStsCYurx+YuaEdI2xd9+d9FyOoMdbAk0CJP8x6nEBXJQ+EksDki/2fzQ4IWd6Csd7clQc4nOxK2rDQPV9RDzGYf69fUs+gG1SnwIemJAYyFBv/H1ZUbmH2dq5D0TzTF9M8DCtesYIKMZhF3zmvKAdOXz2ecgMufEJavdv1p1GGA7oj2hBzNP6RaWILfGizFgJCCvpBYLkpIB4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCYdJ0r3fKDrHQY+5WUn+ylNhZ1rqALD2s9ZsWS+gXU=;
 b=dUKgrXTIQYOS41zM/7cfEd1O9tyvtsOQ0LH9rEl9bOSLDshLdKV/s/J3qCQ1aMch7+2J0YceeJVMF4C3Zeo6oNtyuLaVkW56Sn2rMqJsRiHA2iVlUxHkKFOq+pS0G2GH1aURAri8g8ZRXYom9jDax2si747jHZW8RCT7/9YAqxw=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH0PR10MB4741.namprd10.prod.outlook.com (2603:10b6:510:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 19:56:53 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 19:56:51 +0000
Message-ID: <c98d91e1-b284-4e2a-93a7-5973538920f0@oracle.com>
Date: Wed, 10 Apr 2024 01:26:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240408125306.643546457@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0021.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::9) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH0PR10MB4741:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ibGz/lbIsHXluvQTY4Qzlsm+v2Ui6z2teIxwWB4IuSiQ+W0qu/FXZE5DC8zS37rCbhk7iAK/xtk9kntwjr53YhTbRPvpxqCFlpvwKxqz4Ifyk1pyhxkEz2gyYoQN12NG/ynyvfv6XlP0D//8VUqmr/f2yNdDS0BxXQ1Cu/qjw+ua/XcD2jj1QuTU720mOcrZ9W0FnlBKfkX7U7MgOJnIoPMesjLVIQdwz31MSiGROeXCIvgvmlfLZdb9HqQUxeEO9v1Y2tZtM5opCehLhOVBgByDYo+xUi5pqWTAxACvkuT+0SnxP6N071yw7y8QOzx3D/BH89imjPCj1N3QDOKzEihdykDxdrscYLo7+ugTjNxQMZg0PYHO11GpVfeU6++DJf9OpoTDNXuW+bZpCnJXJ17EZfSFzY6TRjHKBz7zHVyDLBiv0uFKHsPyvAACMRZ7ceUxoXUpXirKmAefZT/0wyUFm+/LQziWaTJAOLYQTpAp8XpiuMbZhnnWqt2vmtx2fR014zAsvTnX3cpWe8lu8XbGfNOBgknjj2/1Z9k9pe9ua+CVI48R58m21fx2L0LxOyCBb8Z9YApiAH9OlRdIorfbX79oC0s1uqwb9krn8CdibGHtCwwS89bzroIt5VC3KpaY645bAu17YYoZ8XGO/+RbAQd7BgfGbXw8KSMon74=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cFA1SHBLZXQwR2dtdWtzdWVLUThkdjlZcjZ6VlBNVjloM29ROTBPajA4RGMw?=
 =?utf-8?B?cVY5YzFSRkU1T3Vya3M5U2RqSjN2Uzc1NXM2aHFFaEdhUzFOaEp2cDAzZ05N?=
 =?utf-8?B?NjRyWVJNWmJLbngraUJKUElUNEpoNXNYeTZxajVHdEV4a1A2SWxVS3F4M1Zu?=
 =?utf-8?B?MFh6N3BXamZmdEtsb0owbS9aR1RnNlpDMFlITzFqSW1KbmJydUh3Vm5JVS83?=
 =?utf-8?B?NVJtNGd4UlcrNzZ5R0wwdG13VUx1V0h0ZlR3Z0RabEF1NmtOZXhXY1NzLzMw?=
 =?utf-8?B?My92b0hGcGFlR3R0SURpZFVhczY3U3EvaGQ3bHNYM2IxSHZORFcvWnB5VVJy?=
 =?utf-8?B?bERxc3dJNVRDWmRtYXdTZkw0VW42bTdtMDc4VVpvcFRDWFlBVSt0bGs4Qlg0?=
 =?utf-8?B?NlY2NWFqMG96ckx4cjl5Q2lwaHhJcnJWbDgxRjNSdTBrYlZqZmhHNC92QmlL?=
 =?utf-8?B?a3lHTkxDVUVVa0hqdzlHQjBmU1BaYzVNQnlULy9uY3JKTE5qWUIwZ1g4ei9i?=
 =?utf-8?B?dGNGQURLNW51WDlzUHZOODgrRXlpaE8rVitIU0FpMVBsTWhhZXQ3OW5WWU9r?=
 =?utf-8?B?NzN5TkRKTUhOYWR6TG9VanJHdG1tSng4OW5FdXhZNk9VeWp4YzVLV3lYUzls?=
 =?utf-8?B?amtoSkdEOGhPekt6MGJ2ZFlhV3h3eGZwT2Z0bklrdXQwRit1a1hTa3F6SWUx?=
 =?utf-8?B?Q2Z1V20zSks3MmlFdElHeXM5OFpnai9uKzhiRHpxc2JzWkJ2OHBLOUNiZCtM?=
 =?utf-8?B?R3czakdHcU1PQW5neUxpL0o2SG12emhJbnEyVVFTTTRrUnhuY1RaSWh6bjdV?=
 =?utf-8?B?UDkvVGFBYnBTVWtSUU01NktTM0NGcHpOdHUxcXIya3BkM0JyNGx1OEYyT1M3?=
 =?utf-8?B?R1ZUQ1ZYa0RtYm5FM3I2SHU2WTAvQVBQR01ZclhhUEhndmErRDl5bmFPcUVW?=
 =?utf-8?B?allDZkRET1dXY3F0WFY5WEVZTXNBTDlGeFhkTzFQMHllZUZGYWV2VndacHlZ?=
 =?utf-8?B?Wjlhd1RtNGQvdFRUZHZacWhzMHEvZUhSQi9RMkhUaXpHaXcwUzY3Wi84SzZo?=
 =?utf-8?B?QUsxRUMwVS9nSEQ1cEg0bWdYRjlBaGdQdGxvUG5aRVhKOWZOSnUrczBRN0p4?=
 =?utf-8?B?UWxaN1NZdGp0Q0Z6TVZZVTlPbzlDNExJUEVUTEpDblJlQVVqbE55OEkwRzZE?=
 =?utf-8?B?N3pIRzhYeDZBTGF3dkhPZkx2Sll2cWJ6cU81YlMzQXJ4bkc1cml0a0c5aEFa?=
 =?utf-8?B?WmFTMTBFWUdvb3luckpkOVVtVXFFYXVWQTBneUttbW9NNFBEd2dIU05qdXNC?=
 =?utf-8?B?eThZeEY3bFJ5Wjg0aUNlU3N1QUN3V2U4dGtpV0tGWndMWm85MUtxVjd1SS9R?=
 =?utf-8?B?ZHNtNUl1U0dMK05pamQrY2tWdHpYUkl6VnVMdmhhQlpPRTczSGxWVERWczc0?=
 =?utf-8?B?VHFOZjNlMXIrL3N2UVlXb2lJNytNUWVWRkdtODh0L2lOZHloV1RaaExodXpZ?=
 =?utf-8?B?YjVsVGdxM0N3RDh4LzFRNzdESXRmbU5XYmJ1clBURGFHSTREWkpsUE9ZbjVt?=
 =?utf-8?B?ZEs5MVYydlNkUDF6SlZrK2wvUWpmdWsyS050VFVxK2x2SWpvdVRxdjErUXNa?=
 =?utf-8?B?VzRqQXlWT2w3dXpEYUYzbzUxd0FyRXVwd1NvSGRLRVZYakh2QjMvQ3BHNHhY?=
 =?utf-8?B?RUlmNFVURy9Qb2pxcWQwbUgrT3JMOUhWL0NIcklzME5WdjViTmQ4ZnhHV1Zi?=
 =?utf-8?B?S1dlOHNUeWZFU1p5M01HbDc4akpaSm51LytTUkNBSzNuTGZPanFmVlEwWm5h?=
 =?utf-8?B?Q1c3Wkc3eStKdjY3MnMrcUZVUUR6Q2dXeDd3TWVFbit1eTc1WUFPdmFUTVBU?=
 =?utf-8?B?L0lKcExhbkhYWHRWWlc4NURRdHIzL2Y4SStXSldKZGtDdDQrNUw3YWNYOTkr?=
 =?utf-8?B?bXpJQUpUdDFzUmFtMVdCV1NvcHpROWFRbEtlYVBkbFVEOXpaN29HNHUycmtX?=
 =?utf-8?B?SXl4SjduSTcydjkrd2Y3UUsyQnZZR1JtdnNZdzA2YUNadXNuWnhOcjFPdnhi?=
 =?utf-8?B?RFVPazBBZWNBcTlSTCtOTUhHOEZaandLVWNISC9tb3E0eTdNblduNTRvc1h0?=
 =?utf-8?B?NEdtRmNsdEQ0dGpxWGdJOE9hV3hQN0JmdTA5azhPRHBvVmJ3Skx6SEZzdVpw?=
 =?utf-8?Q?0imFGCKqAHxod7xR1/P8WtM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MWmdAwTM0in0LPtqv8vNcOnSoRvr/CkdIt1KE76YibutFVqea6I5eiKOC3/4ZTf1bDybq6XDXn4iqeUroW+u52HWW30H52NIadBk5j2W4d5GEetHFFSsyCgIqu9SFH+iYdHnfQ/jqN0uWjBg7R39YlBeHgJmp+u3+q/RQ1+U2r+9POwrwWLq0MbUCpYCyWM6J5o0oqiLRuH7VTBahbo+IkSbpL5iNGoq/70prwfJS40XwBQGkpl+ikBIG7YRQm+xxzLL+R6GGBdc0TuC8cuu/lt+t+v4bW9EIgwZ09rOFZy5xbe88mAVBLgLaqDgNRYqeW9HlhOSrp18iUFzU/2FWE1EX1MtSHET5K/GHY83OSvnWIMDh/K0FzmB6bxxhGpTcTs0bH/trpQTHCr3wi02q4mEHL7t7h0HSSNJUJYlT28uMvgzdL8cCHRADvhUdnIvWN4nkYu/E1Ita2pZ/OGvQKWEyZkHSynX88OMamJHlNeYg+cDsKUwhh8wQ1HAiff+JX517KVXQdIUkgPBjbobkWw+oZjhWghnr9HAQZmX8mxMntUpiwOIQWggUt98QNGU7rdbEfZnQB65+1Oh21T3nDBy2nyVYhvbbvwA8Z8nguY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310469a1-48f5-4f7a-0f68-08dc58cf32cf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:56:51.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4RESvzfOLMkTnrCiCTwFMKJmI1fwNoRJinmsOXwomIdJpQE87aHiCuX4oc1AJt3vix8IeF+9mExP5etNIBaGYL2u48bYyu0y8P1V78NF/QrnSe6oqxCKbGF3jr5kMJw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090133
X-Proofpoint-GUID: 4ZI5ALwPIKNYNtY6pcVcAPw0wfCxYdUH
X-Proofpoint-ORIG-GUID: 4ZI5ALwPIKNYNtY6pcVcAPw0wfCxYdUH

Hi Greg,

On 08/04/24 18:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

