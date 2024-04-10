Return-Path: <linux-kernel+bounces-139085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A2889FE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07AC81C20F93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE4C18411B;
	Wed, 10 Apr 2024 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jHoC+CE7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UNc+LhEv"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4975D1836D9;
	Wed, 10 Apr 2024 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769620; cv=fail; b=NfuslIJrI2kHnpPso6whl+/KtfAwaLeQOf9poC72KFDnIQrxzMaAGXYBCZXSIg57lRdbmnEivkVMefSs/BHl2rdYOqANRl7Vy3twi5GTki2l0Imwx4MVzcJc0ZzEcu53LAYVng0J5VPbizGAdE4eaAvcDbfohkerE+5fUWjf/pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769620; c=relaxed/simple;
	bh=MvK8zRGUuRA3VznL0irP6jVyUEojKXtch7SlLtnezS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R1sqplNDVFfggS/Et5bh7T1K5q4P3W/qJgCL3rUd4H0xWVtFp+2LJcQuWLwOYjG6U9TPluw9tspzlNztAKefDaQwNC6dmouB7YlyDzMUwJPqPgRkz0OlTSRC6cxaDE5bqSDFmuy8Pxc2Ns1+qfWu4I8S0FU2EiZdDlPLjHmrkLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jHoC+CE7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UNc+LhEv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AGi53P004337;
	Wed, 10 Apr 2024 17:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=MvK8zRGUuRA3VznL0irP6jVyUEojKXtch7SlLtnezS4=;
 b=jHoC+CE7LHOgUy3VR2VtOCt7t9tXvihWYE47G/d40B/Xunl3y059g2UtYJab5W1CTZoJ
 6ykNn4bpG99xsCROt9HFeqittAlAIXd0+ZazcHTOkSbg7cTDKmgQmfx91G3Mwg0/ycLb
 8/7tFejSukSw3qT+NtZVnG5q1+BzFkjOtMSHkk2FG04LMqhzYJxevy01IxRXbloG4Khl
 M6L8CdFoKIp4PEsfvQxVZu7vLwwGTZfqmpXJfIq5yI+mp1QqH2kQTjLt+PgornUDvMYi
 Xgsbmttpm6mwj0yWprpR1eBx/JiwaAo5UzhAFtz3N0eK5QwQBbqzzRLl0R3CT/OSQy0N pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawacqwvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 17:20:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43AGfcC4026436;
	Wed, 10 Apr 2024 17:20:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xdrsrhuwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 17:20:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrnGR6zLU4vGOm4G0ha/0JBLBXiqrT5GyWzqk3j7PQMT+cFWSEF1fNuRZ416E0zoFnlP8AQ2Mx/conIkj+mAUSiSjryU0zEGezDqj8hOy1Yhx8/58VygrgFmVislGXmRjyIURp4Zh6d84Kx+WL3IaasLekc+3pag8Pp2pE94QG7lZ5c9M+2/Qzzhsy2kElwZsPiKitd1UTicbZpC42XgYch3Ky52ec8/QLdy4dwWn4/X2NmcXeoOhzcOl9YBuCMPQASwQK8UDUv7FL01Cr+e24DNhoONFQCm7pQ4neap3NbT0njXc7YnipjO4USzO0XJObWosHGb61Wq8P0RwtswtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvK8zRGUuRA3VznL0irP6jVyUEojKXtch7SlLtnezS4=;
 b=kAU9VVHsVqAKIIWTetaXIjgEavzDg8FaFbsh10LKzV+P8tammYAa8R1GAbazitnYgOC8o2f2LRW4FfIqgGwptgmHhjqeMSNRy4CkgPMe6nIMOwCpsCELb4uE1VdxXYEtMvr70gSb00j8roEbjucM/N20wDYGc2dp65IHnhFnJj4pxJuxqA/HcvxRFFz0qM5ONhbBBRo4BryAv7FE7FqF/eZNcLwPA3tj+fxJmxOL+Br/5SEr5c/CWaBjKKf0mta8ZLw/YDJIXpjYrB3emU3HtLGB+jjnU2YZAH3T1Nqama/EyEdHJ6hbxkOCUpfcF7BCPzUr7LwmB2l/n/8UfljMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvK8zRGUuRA3VznL0irP6jVyUEojKXtch7SlLtnezS4=;
 b=UNc+LhEvMhMKXIKiCRBmYX7Exq4MGAvkrIDx8enzQ9n5KoBTvYRVdXHPpa1uW9ERtxgNLO0HPg8/7NvDQULEXoHTsioGXtOk4wV/92SDC93TZ3+p27bQK/pDprWZKnzgRakPt/t1kWHUNMYGkAsyCdjHkCN4w7HA/VdxQ305sPc=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by IA0PR10MB7623.namprd10.prod.outlook.com (2603:10b6:208:493::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.48; Wed, 10 Apr
 2024 17:20:01 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 17:20:01 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 2/4] ACPI: processor: refactor
 acpi_processor_get_info: isolate cpu hotpug init delay
Thread-Topic: [RFC PATCH 2/4] ACPI: processor: refactor
 acpi_processor_get_info: isolate cpu hotpug init delay
Thread-Index: AQHaio+WpMbWeOfdE0KVTP4pKAhxUbFhfpmAgABC2wA=
Date: Wed, 10 Apr 2024 17:20:01 +0000
Message-ID: <BEF140E0-C419-4A27-B2B2-6EB24F48B3C1@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
 <20240409150536.9933-3-miguel.luis@oracle.com>
 <20240410142031.00007036@Huawei.com>
In-Reply-To: <20240410142031.00007036@Huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|IA0PR10MB7623:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 bCZi3Q5AW7zDIIalKYkZrcFcOa8urpq0JsyNrdwuEsTckc0hbmoPiKvWIbA+kiTTDuhx+3d5hFQ9dz3/fnh3XQQvI3B+MAPzNIH1UgUSMB7K31SSmk7B48MzAFu3mT2zRej5m5aptE6UdlXRReQtFiMsbg/LhuXFbC1Tu0WSXgEC8HJTFtMSWK6KH/bMBCkWl6dOwx/CMj1cQP4vLSmE5MVUY+PwH6Pt8Kc3Yau2YVtwdaBK8dL77LwLVErzmLZsK7IiscFMorv1v0zlBte1y2uMCQdC/uowRFT8+YalG30p+bqajIP2b4ETrhk7bhdoHZ/HRAZzO0g1xvM/6nBQ30ZsLAmcFlTnjaxUndtkUbuDCOjKuMAheAnNACo59M964v9rbX4xXky1UeFYvwRE8XM6Hb11uvOanNmJQGIZzHGHyIQBG994m6IRzutpqCBHAUISA5wauFuC9Eweh67UhfvUdlG5Q7MCt5awPFqZSGKTwsulo3LcjOUxlhpeLYMqkcAuayfp3fulZm6ukj/LING3Od27ap93qGNbj89QfmPkBmLjqYEj9QnkpFVAfWOt0+2S0kzXmDm8pnwE3e+Z+L5fLA8fdYpVlv7NpBjgVBpXLn1f/EdxkECOqpo0Hkqm5nnufyERLKrqKoaCMGsNMtif8cVDp7i1kIDPJdQvLS4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TVBKZkpmVlZ1ZHFYTTZUc01jZEt5cTZZVGc3WEZJL3NaT2tEOVBJdzErOEpX?=
 =?utf-8?B?Mk0xdEV2SVhGUlNPYXUrZHB6S2x4Zmh0SWdnOC8yWDU0SXVhTnFWZDlmM0Jx?=
 =?utf-8?B?alY5V0ZRd0JmcldCYzFUR1g5Zk8xb3NMN2ZzeEU3RmVFaXdicThFa2JYam13?=
 =?utf-8?B?cEtVSTV4RkM3KzF3N2ZNMWFua2trbW5UbHRSZzZ3b3F4SlVBQ3VIcEJCYkRy?=
 =?utf-8?B?UEwwUkhWSXNoeXBMbkk1WXIwVHVJNmlNOFU5aHBhd2hxUlJtdWYweVVwUU5m?=
 =?utf-8?B?RTFuYWZ2ZFMrSytpU2lqZ3JRTUdiZnNSTmg3ZTZhazVvZnUxVkY1dlhmSGNF?=
 =?utf-8?B?Rndrb1V0TE5Ha1dDM0NxTDJtbzB3WlkrR25pb2JsZ1ZBMVlUaGk4RWFueXha?=
 =?utf-8?B?M1VUT2JHYmt6MmdObXJTaWY2UlVBYlhEUmhWWExsYkozbXVFRUJvTXNZcGUw?=
 =?utf-8?B?THEvQUNEWkRGY3dSbEFGbDVaOUxrS0JkdmIxR1R1VzNYSzJJMzIrOWFab3px?=
 =?utf-8?B?WmhjYlJCUm02SzhCS3MvK1VibWwvbHl4RUFaSjlKUGxONVJsU09KNFAxc242?=
 =?utf-8?B?UWFGZmFRajFVU084dnhRckw5dGdtb1g3eFp5Q1pwZUZ3eUJMUEdNbUN3VlE5?=
 =?utf-8?B?V0NPMUtLV0UwSXByUlNyeHVLamdnYnZYbmhTWFVOcjRsbHljVzViVlNwWU1p?=
 =?utf-8?B?cmZmQ21YL3VmRElybUk1V1huR1Noc0dHQ0lJblB2ZnFLdkhxZEdXTGJLQVBu?=
 =?utf-8?B?bURXWDU5aUNKR0RXMWJmUmh5NkRHd1VYYzVGYXNqYU9RSnBnZlU0UUVXNi9a?=
 =?utf-8?B?akw2OWYvaG0xM0lvOXh0MlIrbDgxMXZvcDRwbFNZOGJtY3ZGR1NyTnN5aHFR?=
 =?utf-8?B?UmEwYTA0bmQ4Uy9UOGhDNTJmWHE4dHVmc1kvL1lTdWN4Z3czMUo2blMxUkFn?=
 =?utf-8?B?bDZBY3kzOFZVRzFqN05XU1NXTGFYK1I2cUdJTWcrckZ0bk5DeEhxNkxlOWdr?=
 =?utf-8?B?UmNHZklVOEdxeFUybldSZ29nL2ZMMnkvM1pTTUZvaHdac1pTNDQ4NFRpSkpy?=
 =?utf-8?B?enJoYzBocHNUc0t3NzVGWHhxU0RBS1lZbC9KUHdQVTcwZ0lZcGsrdjM2a3JU?=
 =?utf-8?B?ZlRkUU1ITWIvNExKWUJqejBZNzhDZGJOQm9JcEE2d1oxd1JSdUxxV2EyRVA4?=
 =?utf-8?B?cmw5MEQ0UU5yMzRaVW1QZnB6UFNnMlNtYXl6Z0hqMzh3NURZakpxU3JoRGtK?=
 =?utf-8?B?WkJZQzAvQlV3aCs1bTFMSnNVaHMrQ2VyTUd5RDZwUzhMaytyUjVPRHJWQU14?=
 =?utf-8?B?c1pwNWZSS2NaZUVyUElqT2dLWlYza1JpSndLQkJZN2hLenV4dExGcWVKV3B0?=
 =?utf-8?B?SFJDNFo2SWN5VXhmV1JIWmhKZW5xdDJ3aUFGdXhRZ1pEd3VYb0ZrTnF0c2F4?=
 =?utf-8?B?U1BrSzVLcTlQejlGMloxSHdjUnF2aE9aOEU1NC9PZ2ZMM3MwOHFaNnJYakJW?=
 =?utf-8?B?Y3oyVEZFeCtRVUJ5R3ZXdUVxdHNxeHFHVWtRRWVkeW9IMlhDYzhobE1Ydmo1?=
 =?utf-8?B?RWNLVWJMUlJ3Zkg0TUlsS1BzR2t4MFhvU2x1VldwZVhSZExjK1Nibi9jV2gz?=
 =?utf-8?B?OVBCcm44d1JzTEgyZ2JObC8yNTdpUXFqV04rR0VQcW9HUXlvWE5qb0sxYi9L?=
 =?utf-8?B?UDZZUTUrbEtRWWtMWUxxdGVNNVNzMzRjMk83UzBkcTBCVzl1WlZ0cE43VFNp?=
 =?utf-8?B?VllGRDA4L0JhRVRpdTJxOEhTaFpGU2VpOE9GY1NGUVFKM2g5UDhCSVU3d2VB?=
 =?utf-8?B?d0pDZ3V1YkJMRklnMXlwMy9CeElFaEpwM0VMbFZDdXNyOW1SZmpkMGFLclBp?=
 =?utf-8?B?ZmYrNEtRMjJHdmdMR0ViM0dLS2s1cjc2Q1ZHWnBHUGJNTXJ4WE04ZU5IbGhx?=
 =?utf-8?B?ZjEvWndUdXdnNmdkRVJFVGo5ZUtvSWZBTmZkN1JhYnlNT0p2Ymx6enhMbDBM?=
 =?utf-8?B?RXZhd1pRZ3BOTUZrT2lFcFMzYmJ1RlhwWVZEUmxXWUs4b2VQYkdvVWFuOVI2?=
 =?utf-8?B?S1cvd3lnMW0yeGo5TWZKcDVJWkZWUko4aDhlZlQyR2NJalRIaFFvdkxNWHR2?=
 =?utf-8?B?VXR0UkhHcERxVkVMTWVYVWFZWGFBdUwzdGxEQk10dGsxRGJobW5TMEduc3pS?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA252AA08EC34C41B5E15A28390CE419@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	klPYYt/VvbUpA/GxTD9iV2VMD7pCRbgrKv6rL4xGFCrx2F27LNsOD5tMCDGFsut0uko/cFW32xTcwt6MTFv0nubARbP1lRWHYOddCsZSkBJyGmyvJo5E6mtEpd8O4np+tE+x3XkJsm8d4AjmV68shygRetAJuTEXSX+MROkgmiFx+GQT6G8ZPqWN/pOH/li7qfTGcjUk0ShVKwDy1P3wyJNqbWTOnlkAS3bZtG8sOFLQuevLS5a20hCGSHhn0MaE28UQPo7JS2yZ1TOymCIpFwgfkkc0Iv8OS4iNP5P2N5taPBh27D+FZiBpQ/2Q4rHVPZHixFFZZgmMgYC2EieNAhPOLO9wrnzMcLQQ4cR763UP5mfxqySzXAtmrFNmJAJY4hRoVlzYi3DKkLBH388wivGsYM38KRHoFTfRSVXAbZYVVV2rxv3rsyXWHU6kpsKidxHw9KnIM90ddkO0RZ2GtkENX1uGCT4Bb/KN16XNHs/gsc0BUqvpa8RUqWG6w989h+60d/m+Mxzf9G7WGnfxmm47iYAS4CZf4Xky6G3KRl5G57KA/q+b0mXaB65/0WPey259RPBRmKjV/9PydJapwY4KfIlE1GuAIOScClXrwlI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960eae1b-43d9-4bad-ed80-08dc5982745c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 17:20:01.2403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WCupjhq+f+TLBY/V5tjL7TWq3JqAZVU+sKVpHva0JIg4yJ+ZCdTCSimLKQEXBYkj6PmUfyskTtSvHI0v1tq9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=789 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404100127
X-Proofpoint-GUID: xYWZZb3LOad0PDb56qk1HcmUxWpcEs3c
X-Proofpoint-ORIG-GUID: xYWZZb3LOad0PDb56qk1HcmUxWpcEs3c

DQoNCj4gT24gMTAgQXByIDIwMjQsIGF0IDEzOjIwLCBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhh
bi5DYW1lcm9uQEh1YXdlaS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCAgOSBBcHIgMjAyNCAx
NTowNTozMSArMDAwMA0KPiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4gd3Jv
dGU6DQo+IA0KPj4gRGVsYXlpbmcgYSBob3RwbHVnZ2VkIENQVSBpbml0aWFsaXphdGlvbiBkZXBl
bmRzIG9uDQo+PiBDT05GSUdfQUNQSV9IT1RQTFVHX0NQVS4gSXNvbGF0ZSB0aGF0Lg0KPj4gDQo+
PiBTaWduZWQtb2ZmLWJ5OiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4NCj4g
DQo+IEFnYWluLCBuZWVkcyBtb3JlIGV4cGxhbmF0aW9uLg0KDQpJbiBhZ3JlZW1lbnQuDQoNCj4g
UG9zdCB0aGUgZnVsbCBzZXQgd2l0aCB0aGUgdjQgdkNQVQ0KPiBIUCBwYXRjaGVzIG9uIHRvcCBv
ZiB0aGlzIHNvIHdlIGNhbiBzZWUgaG93IGl0IGlzIHVzZWQuDQo+IA0KDQpJ4oCZbGwgZ2V0IGEg
bGluayB0byBhIHJlcG8gZm9yIHRoZSBuZXh0IHZlcnNpb24gYmVzaWRlcyB3b3VsZCBsaWtlIHBy
aW1hcmlseSB0bw0KZXN0YWJsaXNoIGFjcGlfcHJvY2Vzc29yX3tnZXRfaW5mb3xyZW1vdmV9IGZp
cnN0IHNpbmNlIHRoZXNlIGNoYW5nZXMNCndvdWxkIG5lZWQgdG8gbGl2ZSB3aXRoIGFuZCB3aXRo
b3V0IHZDUFUgSFAuDQoNCj4gSSBndWVzcyB0aGUgYWltIGhlcmUgaXMgdG8gc2hhcmUgdGhlIGJ1
bGsgb2YgdGhpcyBjb2RlIGJldHdlZW4NCj4gdGhlIHByZXNlbnQgYW5kIGVuYWJsZWQgcGF0aHM/
IFdoaWxzdCBJIHRoaW5rIHRoZXkgc2hvdWxkIGxvb2sNCj4gbW9yZSBzaW1pbGFyIGFjdHVhbCBj
b2RlIHNoYXJpbmcgc2VlbXMgbGlrZSBhIGJhZCBpZGVhIGZvciBhDQo+IGNvdXBsZSBvZiByZWFz
b25zLg0KDQpUaGF0IHdvdWxkIGJlIG15IHVuZGVyc3RhbmRpbmcgZnJvbSBjb21tZW50cyBvbiB2
NC4gQm90aCBwcmVzZW50IGFuZA0KZW5hYmxlZCBwYXRocyBkbyBoYXZlIGNvbW1vbiBwcm9jZWR1
cmVzIHVwIHRvIGNlcnRhaW4gcG9pbnQuIElJVUMsIGZyb20gLjENCmFuZCAuMiBmcm9tIGNvbW1l
bnRzIFsxXSBhbmQgWzJdIHdoaWxlIC4zIHdvdWxkIGJlIGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBj
b2RlLg0KDQpbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1rZXJuZWwvQ0FK
WjV2MGlpSnBVV3E1R01TbktGV1FUem5fYmR3b1F6OW09aERhWE5nNExqX2VQRjRnQG1haWwuZ21h
aWwuY29tLw0KWzJdOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0ta2VybmVsLzIw
MjQwMzIyMTg1MzI3LjAwMDAyNDE2QEh1YXdlaS5jb20vDQoNCj4gDQo+IEltYWdpbmUgYW4gYXJj
aCB0aGF0IHN1cHBvcnRzIGJvdGggcHJlc2VudCBhbmQgZW5hYmxlZCBzZXR0aW5nIChzbyB2Q1BV
IEhQIGFuZA0KPiBDUFUgSFApIG9uIHRoYXQgdGhpcyBmdW5jdGlvbiB3aWxsIGJlIGRlZmluZWQg
YnV0IHdpbGwgbm90IGJlIHRoZSByaWdodA0KPiB0aGluZyB0byBkbyBmb3IgdkNQVSBIUC4gIE5v
dGUgdGhhdCBpbiB0aGVvcnkgdGhpcyBpcyB0cnVlIG9mIHg4NiBidXQgbm8gb25lDQo+IGhhcyBh
ZGRlZCBzdXBwb3J0IGZvciB0aGUgJ29ubGluZSBjYXBhYmxlIGJpdCcgeWV0Lg0KDQrigKYgSSBh
Z3JlZSB3aXRoIHRoZSBhYm92ZS4gSXQgcmVpbmZvcmNlcyByZWZhY3RvcmluZyBhY3BpX3Byb2Nl
c3Nvcl9nZXRfaW5mbw0Kc28gaXQgY2xlYXJseSBkZWNvdXBsZXMgcHJlc2VudCBhbmQgZW5hYmxl
ZCBwYXRocy4NCg0KPiANCj4gVGhlIGltcHJlc3Npb24gZm9yIHRoZSBfcHJlc2VudCgpIHBhdGgg
d2lsbCBiZSB0aGF0IGFjcGlfcHJvY2Vzc19ob3RwbHVnX2RlbGF5X2luaXQoKQ0KPiBzaG91bGQg
YmUgY2FsbGVkLCBhbmQgdGhhdCdzIG5vdCB0cnVlLiAgVGhhdCBzaG91bGQgYmUgb2J2aW91cyBp
biB0aGUgY29kZQ0KPiBub3QgaGlkZGVuIGJlaGluZCBhIHN0dWJiZWQgb3V0IGZ1bmN0aW9uLg0K
DQpBY2suIE5lZWQgdG8gY2hlY2sgaG93IHdl4oCZcmUgZGlmZmVyZW50aWF0aW5nIGJvdGggcGF0
aHMuDQoNCj4gDQo+IEZpbmFsbHksIHlvdSd2ZSBwdWxsZWQgYWNwaV9wcm9jZXNzX2VudW1lYXJ0
ZV9leHRyYSBvdXQgb2YgdGhlIENPTkZJR19BQ1BJX0hPVFBMVUdfQ1BVDQo+IGJsb2NrIGFuZCBJ
J20gZmFpcmx5IHN1cmUgaXQgc3RpbGwgaGFzIGFjcGlfbWFwX2NwdSgpIGNhbGxzIHdoaWNoIGFy
ZW4ndA0KPiBkZWZpbmVkIHlldCBmb3Igbm93IEFDUElfSE9UUExVR19DUFUgY29uZmlncy4NCg0K
WWVwLCBpdCBzdGlsbCBoYXMuIFVubGVzcyB5b3Ugc3F1YXNoIHRoZSBuZXh0IHBhdGNoIGludG8g
dGhpcyBvbmUsIHdoaWNoIEkNCmRpZG7igJl0IHNvIG9uZSBjb3VsZCBzZWUgdGhlc2UgY2hhbmdl
cyBwcm9ncmVzc2l2ZWx5IHJhdGhlciB0aGFuDQpzZWxmLWNvbnRhaW5lZC4NCg0KTWlndWVsDQoN
Cj4gDQo+IEpvbmF0aGFuDQo+IA0KPj4gLS0tDQo+PiBkcml2ZXJzL2FjcGkvYWNwaV9wcm9jZXNz
b3IuYyB8IDM0ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCj4+IDEgZmlsZSBj
aGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvYWNwaS9hY3BpX3Byb2Nlc3Nvci5jIGIvZHJpdmVycy9hY3BpL2FjcGlf
cHJvY2Vzc29yLmMNCj4+IGluZGV4IDM3ZThiNjkxMTNkZC4uOWVhNThiNjFkNzQxIDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9hY3BpL2FjcGlfcHJvY2Vzc29yLmMNCj4+ICsrKyBiL2RyaXZlcnMv
YWNwaS9hY3BpX3Byb2Nlc3Nvci5jDQo+PiBAQCAtMTg0LDcgKzE4NCwyMiBAQCBzdGF0aWMgdm9p
ZCBfX2luaXQgYWNwaV9wY2NfY3B1ZnJlcV9pbml0KHZvaWQpIHt9DQo+PiANCj4+IC8qIEluaXRp
YWxpemF0aW9uICovDQo+PiAjaWZkZWYgQ09ORklHX0FDUElfSE9UUExVR19DUFUNCj4+IC1zdGF0
aWMgaW50IGFjcGlfcHJvY2Vzc29yX2hvdGFkZF9pbml0KHN0cnVjdCBhY3BpX3Byb2Nlc3NvciAq
cHIpDQo+PiArc3RhdGljIHZvaWQgYWNwaV9wcm9jZXNzb3JfaG90cGx1Z19kZWxheV9pbml0KHN0
cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIpDQo+PiArew0KPj4gKyAvKg0KPj4gKyAqIENQVSBnb3Qg
aG90LWFkZGVkLCBidXQgY3B1X2RhdGEgaXMgbm90IGluaXRpYWxpemVkIHlldC4gIFNldCBhIGZs
YWcNCj4+ICsgKiB0byBkZWxheSBjcHVfaWRsZS90aHJvdHRsaW5nIGluaXRpYWxpemF0aW9uIGFu
ZCBkbyBpdCB3aGVuIHRoZSBDUFUNCj4+ICsgKiBnZXRzIG9ubGluZSBmb3IgdGhlIGZpcnN0IHRp
bWUuDQo+PiArICovDQo+PiArIHByX2luZm8oIkNQVSVkIGhhcyBiZWVuIGhvdC1hZGRlZFxuIiwg
cHItPmlkKTsNCj4+ICsgcHItPmZsYWdzLm5lZWRfaG90cGx1Z19pbml0ID0gMTsNCj4+ICt9DQo+
PiArI2Vsc2UNCj4+ICtzdGF0aWMgdm9pZCBhY3BpX3Byb2Nlc3Nvcl9ob3RwbHVnX2RlbGF5X2lu
aXQoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikge30NCj4+ICsjZW5kaWYgLyogQ09ORklHX0FD
UElfSE9UUExVR19DUFUgKi8NCj4+ICsNCj4+ICsvKiBFbnVtZXJhdGUgZXh0cmEgQ1BVcyAqLw0K
Pj4gK3N0YXRpYyBpbnQgYWNwaV9wcm9jZXNzb3JfZW51bWVyYXRlX2V4dHJhKHN0cnVjdCBhY3Bp
X3Byb2Nlc3NvciAqcHIpDQo+PiB7DQo+PiB1bnNpZ25lZCBsb25nIGxvbmcgc3RhOw0KPj4gYWNw
aV9zdGF0dXMgc3RhdHVzOw0KPj4gQEAgLTIxMCwyNSArMjI1LDEyIEBAIHN0YXRpYyBpbnQgYWNw
aV9wcm9jZXNzb3JfaG90YWRkX2luaXQoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikNCj4+IGdv
dG8gb3V0Ow0KPj4gfQ0KPj4gDQo+PiAtIC8qDQo+PiAtICogQ1BVIGdvdCBob3QtYWRkZWQsIGJ1
dCBjcHVfZGF0YSBpcyBub3QgaW5pdGlhbGl6ZWQgeWV0LiAgU2V0IGEgZmxhZw0KPj4gLSAqIHRv
IGRlbGF5IGNwdV9pZGxlL3Rocm90dGxpbmcgaW5pdGlhbGl6YXRpb24gYW5kIGRvIGl0IHdoZW4g
dGhlIENQVQ0KPj4gLSAqIGdldHMgb25saW5lIGZvciB0aGUgZmlyc3QgdGltZS4NCj4+IC0gKi8N
Cj4+IC0gcHJfaW5mbygiQ1BVJWQgaGFzIGJlZW4gaG90LWFkZGVkXG4iLCBwci0+aWQpOw0KPj4g
LSBwci0+ZmxhZ3MubmVlZF9ob3RwbHVnX2luaXQgPSAxOw0KPj4gLQ0KPj4gKyBhY3BpX3Byb2Nl
c3Nvcl9ob3RwbHVnX2RlbGF5X2luaXQocHIpOw0KPj4gb3V0Og0KPj4gY3B1c193cml0ZV91bmxv
Y2soKTsNCj4+IGNwdV9tYXBzX3VwZGF0ZV9kb25lKCk7DQo+PiByZXR1cm4gcmV0Ow0KPj4gfQ0K
Pj4gLSNlbHNlDQo+PiAtc3RhdGljIGlubGluZSBpbnQgYWNwaV9wcm9jZXNzb3JfaG90YWRkX2lu
aXQoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikNCj4+IC17DQo+PiAtIHJldHVybiAtRU5PREVW
Ow0KPj4gLX0NCj4+IC0jZW5kaWYgLyogQ09ORklHX0FDUElfSE9UUExVR19DUFUgKi8NCj4+IA0K
Pj4gc3RhdGljIGludCBhY3BpX2V2YWx1YXRlX3Byb2Nlc3NvcihzdHJ1Y3QgYWNwaV9kZXZpY2Ug
KmRldmljZSwNCj4+ICAgc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwciwNCj4+IEBAIC0zNDcsNyAr
MzQ5LDcgQEAgc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9nZXRfaW5mbyhzdHJ1Y3QgYWNwaV9k
ZXZpY2UgKmRldmljZSkNCj4+ICogIGJlY2F1c2UgY3B1aWQgPC0+IGFwaWNpZCBtYXBwaW5nIGlz
IHBlcnNpc3RlbnQgbm93Lg0KPj4gKi8NCj4+IGlmIChpbnZhbGlkX2xvZ2ljYWxfY3B1aWQocHIt
PmlkKSB8fCAhY3B1X3ByZXNlbnQocHItPmlkKSkgew0KPj4gLSBpbnQgcmV0ID0gYWNwaV9wcm9j
ZXNzb3JfaG90YWRkX2luaXQocHIpOw0KPj4gKyBpbnQgcmV0ID0gYWNwaV9wcm9jZXNzb3JfZW51
bWVyYXRlX2V4dHJhKHByKTsNCj4+IA0KPj4gaWYgKHJldCkNCj4+IHJldHVybiByZXQ7DQo+IA0K
DQo=

