Return-Path: <linux-kernel+bounces-94441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57629873FE3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4171C234AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C974F13E7C6;
	Wed,  6 Mar 2024 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gsiqlZZ1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n+bG2PIb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29212CDBC;
	Wed,  6 Mar 2024 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750619; cv=fail; b=hIZewdLaYd9JaOlGUyxSEiMG3SNaRkjkDnTQ28iGWgoQTw/xF+ZGZ3MrgoAVs06dEyEcHQMauzaveTbut4XfzAR8xiHKaoD5pz6mfp89k3dkjYYZEflxKkELhE7kF3gF1nfvroHQ2a41pQTi/t6e+hwqN2nCYV3rElXSt0vNuMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750619; c=relaxed/simple;
	bh=81qIiLtdzPz7nvRbSvCOmd+MZzHwfgxit568EHRBSJM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s0XutJs0BQgLnKqtx12aLfPFbFJCijXYbDJo2Snkw1zSV3q+Leh4YxQpCmI4MjZjWztLFtJEja8bJVypZ5F1b8ZVBVRlfXbdklRJo7+VH5mfYhTYtCwQlUcah0aHlPomT+zeQr99s8wHuQf9Zrbih7H3M1Ri/aLzqZWlx7U7phU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gsiqlZZ1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n+bG2PIb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426H4lDm006067;
	Wed, 6 Mar 2024 18:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7qn3BP9q/rCd+8pX39eBdlhTusuJmGj4nqYA1ZJPRSs=;
 b=gsiqlZZ1A/PuGKMeVnVf2XXdg5JkGWCdb3gFH87kcbQJXYrGTMpPyePEOA7lu2ACt1Z5
 BWSYwhLYUpiX9mkoEA7veH07R/bPmWap9P5r9MCdpHeQ4uZ5iQirC8dGGN7F1THbfv7h
 oWgZ8nIgA363efh33FNhCQVHoIaCeu0CcmPyHY5wGsG21IUyYCmoxPbpNKDKgNqaDvsA
 K++WJ7xTASYQWEATlprB6hDTVY3HaaH6BvApdmT1c6C09B7ljzsMGQ/gplZ7XuDXGyQd
 vTKdkOJuC9XCBKva6GmzX8UbxoL/JJrnIpV0A/SisKGta5JJIwK4dGllFYB+G7Z8DL30 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktq29vy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 18:43:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 426HqcML031819;
	Wed, 6 Mar 2024 18:43:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktja050n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 18:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7gPWW6B6srqwdQHp3NKZ3ZA7/icWvvIZjEr0PWd21W5boe13VCI2IvYH+QARvX0Y4AfaOuQ7Qct5nFPYU97uPrGO2dZQxmqH7WpkLI4n80OQEIxR0RbttjCfkXlSXl3yXBfk2ws0oY7ixFUmPMuRnG6zTBMeRjRH4ekvi5YIrN43ZcFlBTh/yYGh4Jlccv6PU5T/CuDBuqgHj6YAX1cx9gt9x/FYIn5i9OnU5vrxtV3u5g2nNGRZ2Ure+/XKO4JAYxUPy7KBlmUWlo3yJmAWj8lOIbGoKwQB+6DjwKxIEWoRICRUoftO8Xa0KgvpUYA0rOfWrIuZ1iummJRXIevTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qn3BP9q/rCd+8pX39eBdlhTusuJmGj4nqYA1ZJPRSs=;
 b=hq/AKfoJrh5QaIBX4zzIhfy7BT2I7zAC5MzB3mQgppgE7vKx1pxHbxTWEET56RWHcUKMqbpoGBL36hG0AJCVrJR2DFb0ut95Iqp2/CJaWTfCeXt48vbseQBeD0hJNOoBu1Tummz92s/rUzSMMrhQx5jZBzKXxJ0Y0aBBNPlHILIBbiEckUw2C7X10iC40fSTkOZtQAvzXGY0+2TswcINvA2pUUUDN5xLsleIyhf1kEp9uf8paYhZc/gqIk13q9l+q4NAE1PLtskKwEm1OattcxFB431SuDfgNUyAJ3h7IJhuzrZp+/2otS3ELnE04JDS/VUcXMGzRZ4HcDxw3Uu+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qn3BP9q/rCd+8pX39eBdlhTusuJmGj4nqYA1ZJPRSs=;
 b=n+bG2PIbuNdFJEMdSFanTrw5rQX2czngxLXxqxkZpDyJk4yxtE7Zyl7JzR8E/ghf9vw7XTJczQ5nLq5dwcAA5e2X/gUrD0CWLb/U5WoQSrIZo4BKH3aKwhiJoB0Id/iernTUh1zu6XvZVWPotlMQJlq8Ktx5SHaCalepKX3lV/0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6009.namprd10.prod.outlook.com (2603:10b6:930:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 18:43:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 18:43:17 +0000
Message-ID: <f8de67cb-8d0c-475d-b3f3-bc38ff097823@oracle.com>
Date: Wed, 6 Mar 2024 18:43:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: libsas: Fix disk not being scanned in after
 being removed
Content-Language: en-US
To: Xingui Yang <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        chenxiang66@hisilicon.com, kangfenglong@huawei.com
References: <20240227090149.29039-1-yangxingui@huawei.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240227090149.29039-1-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0076.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa561a9-945c-4b52-bb2d-08dc3e0d49f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	M/IgUvafY3X2B0VFFXCOoDaNgRJ/WE0fbt1VRaxGKRrIqM590MqGDYb6kmPlRcQunCLwsniI0y+hEf5IRojPKgamPBTPzSCg2Z75maiHIL9y1UpJk1mC83f2mZjqrECmzqtdSJLn4KkvQAJnui4MzbtTJbeKA+v/1OKsBSFOFZBHeYikmMeZt0GZrNgauR3LcIQKxllBd+7/oNxSgKA6DfCoztDIIX3BBi/b5ae1Gmj53d7/8PMrAY9lYvyt66A1yhehu0HLOruy5l9OR1KNyo2UsWTDWgrJ/WS56mgAOqKsFcJ+iWlYOy0GdcsEcLnLausGcohrrEoZtBDvIqhy+vWYyy7/sz2ydqYKYIsgQ+G3OvO4QH0aLpo7D1IY1fp3mMsu/SCIDbpwja+YbxOcWvpsADNPJ/cxnsMFC3rq7zTBCYXiX5oybG2MXCjUYknB/b3EchXuCDLPWaiXLnAJQrsQ7WmP+av446qaS6jnfRe3RLLLDlkWaFSIdZ87X4Erzx04WuGX+yDDt4DEwXE54eJtmrLcwnOEJQKYyipALozSlbz0oVcg3vP1oD01L/TMir/0PxHUzv05J14h3EAyVeyw2ueqrC+dd9zzjV+sxYt97dR5DqEwSOqz4gZKjluZfcu6Qfvur5syVBg3RqnR0ryEtU2JxosXnE+cIY7jPHg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VzltWGxPVXNKWmNBVnZVZ2txOVJCSVhScGVudG1PbDJ5REY5WnJJbGVMazdC?=
 =?utf-8?B?WDIxejlIOVkwNVhVa1V3dTdjNlVKNHZjT21sRzhyU1R4TUF0MjZLVzNOY0hP?=
 =?utf-8?B?UEl0YTZ6aGdDMStJZjM4NmlZRmJDY0RldEdLTmh0YTBBNUg3YzF6K3czcTIv?=
 =?utf-8?B?SGJhL1prL1EyKzlTZXpJb3M3QTZtdTlaWWlGcXFEd0gvb0hxcTl3UEcrN0E0?=
 =?utf-8?B?OTNMQUVRWnRaRUUvNXFDN09MemRscldMZXpaWDY5T2Fmck45UUlwRXZTTkN4?=
 =?utf-8?B?dlhrWmx5bVRPdWJHN0VON3BvYU5lbzdDMzY5b2g0Yis0YjY1L0VFQjVzS3l4?=
 =?utf-8?B?aWR2c1FqdjVyMVV6cTRBbTRCMmQweDcxdERHSTkwWUtJSHdaNng4S0lLb08r?=
 =?utf-8?B?SkFHcGgxMmxicTRFcE1ac2pVWmF5YUswK2x5TGUvMUhUaGcwQTg5alprVFRJ?=
 =?utf-8?B?dExSTE1KRUN4bzJPeEk4VDIraXpvMlR5TGg3ZnBvYit4elFtbjEzeldFRm01?=
 =?utf-8?B?czNuRGpldXQwN1ZTdUxsZGZUTG1sOVZyRm11Sm5GN1lkS0ZPUGNhYWk3eFQv?=
 =?utf-8?B?L2VGTFZnak9DaEQ4RGhQaXJYRHB3RnFzMDR5eEZuOWl2SjkyV1NpSnJ0aUVh?=
 =?utf-8?B?WDg3aHZnT3VyWWc5bkhlaXRVaFJ4dFNpdGw5dFlLcnFmSDJTa1JqcEluRW12?=
 =?utf-8?B?RTZ6UjZtMW5qWkdRZktlbDA4TlliZ0UyZ0VReGlBU3pqS09Zb2RRRjhSVlpS?=
 =?utf-8?B?ZTE1QUxBcmIzNG9lN0MyVUNlRzlNS2tidnlwdUFlWTRyVWF1dnhtVjRLL1lO?=
 =?utf-8?B?S1piS0JFaVVldDFRcUR5N01LeWpreTRXdEROQzJ6MENML1M1MHhoV0NqZWQ4?=
 =?utf-8?B?c2VOSmNtcWRGWHVyTkYxSzBEaWxhdjY2QW9keUR5MVlSR0VyMFcxWlBaMFIv?=
 =?utf-8?B?VkIrenRjTUZMU29VWndjWVc0cEVXMlVTVnlrdXNubnYxcG5xOVprS29PUThx?=
 =?utf-8?B?SUVYZUd4YkhBY1FEdmxEZzJ6WnBFeU1GUkZTaXVmU2hDREJERzZ1OXlKZUJi?=
 =?utf-8?B?S0pLYTRvM1dUeVJSYkp5TEZWODZjUCtGOFo4Ujh3czFxcUhzZ0hrdmpNcWVI?=
 =?utf-8?B?U1VqTjU3azI1WGxFUEhBNmxxck5GQnV6K1VGRWU2UzdmNllMRUk2dmJrSzBm?=
 =?utf-8?B?OS9Gd1pLcWhBVXBWYmdIVmZ0akg0NEJDVUJVM2xrVnBESnBTUWJWcUR4NWlY?=
 =?utf-8?B?ak12Nm1tZncvYXhzL3FVWDdJWTJmTEdGazFSYXR1Qy9QUzFPRy9iMGpvTDNR?=
 =?utf-8?B?WGFQVG1wTG1LWE9RbU1Oc0gyZllrYmVCS1RwOXZ6dDNJVngrb29RcCs1eVQv?=
 =?utf-8?B?VWgwVTNwYTUzcG5BSWwveGdpcFMrVCtkWmxLcVBIQ0xjTnFMOHJoeDVJTHpl?=
 =?utf-8?B?aGFqWk9oUEJQSlBlRndraDBFTUt5MGZoSDJMdkEzcm96M2JZQzZka21FTW5T?=
 =?utf-8?B?ajNrVlcrcXQwamttWnVDa2g2QTBHSEQwY3V3OVRwcENNb3JBWlhWQ1RLWVkw?=
 =?utf-8?B?U0M2VFpyMTZNeEtsVlR4MVV4STlMMW00eVBDN0dBS2x6UTlDOHZ1a2laTEQx?=
 =?utf-8?B?UUVXQmZMWEtpdHVsSDM1RmV0ZTg1bmVIWVZwc2I5dHNNdTNRK2wwQzhMQWRP?=
 =?utf-8?B?WWtEZloyb29Ed3c1cEU0S1laYXhhcHpIeTJWQVVhSjdjR1ZqMUFHSXBwdXYr?=
 =?utf-8?B?UDV3WDVUNzJ1cGlPWHpJWXA2djFpU0kweWNMeUM1MHZyVFg0MHVPeHNHeXFR?=
 =?utf-8?B?aEpOSjNJOXY0N1FPNEhTS0l4Y2dnSTNZL05jWnJIUlJqYmVOaU5BbVFJaHk4?=
 =?utf-8?B?bXQ5N2QzYnJzTmJBSmZlRGdtYU8vdDVUUzNkTkZMbzQwbStEVWlTZG1tTnQ2?=
 =?utf-8?B?dlBTSG9BbVk3UWI3NmRuY2dkeDN1cWpVc25DdDNvbnBkQkg0bXJ1ZjVkVUNx?=
 =?utf-8?B?ZjNzNmFIb2FHM3NnQ1hTL2Yyc3FDY0xQM25NTzA0Yk5vejlaMjFhRUFvM0Jj?=
 =?utf-8?B?ZFZERmJEb0czQWltMElpNW44OEsxekc3WUduSWdqUmJnVkFUR1NpajVrczRZ?=
 =?utf-8?B?UXNuUlJxTjVONFlkVUMxYlpKOHoxRnY4SFFKMnIyRTYzK3FWRUNwZVFFVmlN?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/BXNeVNbWDgEXisgABIAqcB4gT6BAbBJqht4sTQszqAHd8xn4+w0rpsdZcP5MiN+1zLEzqqI0wfUmXv298We5rHldTzqj1GQHXDqn37Smco0DEfw5O8+uAAmBaOabXHTkXuOESNBBNtOGjKJT1n+39Vvwu35IOszSuYND9ZdKeIODCtLPbVa10+avGh9ABcKGQxTWN5tl6hetIqQMrbAzda+vlqsjm9YrrdhaJVVIOcfJ91IW9+NNztQx56u+YpKxgOq3DpkSJP5NVHnz7/dwe08GiZ0TbnpYmHSGuMM5fGRCJjO+P/TasIaX18FilM8se+arHRpKvTD5PAYCQ/32Tvy0eGDZ9DycXMawCGUw7i3UxC3qnJpD20pEiwxpHBnqV1rudDdZ3WLR+KX4m2u46hXiuB9+ZsCyKEa+JQEoEwIUdOXNt9vvvcj6eZCkm5RjiPqbTrI2rfLzqzPj1XwpaaBvtMJzWRHAUUbGEwjFDGyXnDE7rUIwpZkTbg62C/WoD83QvKs8Iiz/X+/yz4sWqQ6s+74QiO89iDlYJSX+o5pt+bHB9HR8XfZHV8oLjMHFUAJwb0JoqRujnPXqKjGKRQwTIDNdB36yL3W9pqcZYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa561a9-945c-4b52-bb2d-08dc3e0d49f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 18:43:17.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqghIt/fzK4x5Yx9oVI12pUJPchbqGe2SKlwWHRD2MS1VgIJAb/JQaZqKJPwYeqApApS/cH3e8kxylS7qvtPIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060152
X-Proofpoint-GUID: 5V1t9EcWxA0vVRUdsfqgy1zk1KZHEMnw
X-Proofpoint-ORIG-GUID: 5V1t9EcWxA0vVRUdsfqgy1zk1KZHEMnw

On 27/02/2024 09:01, Xingui Yang wrote:
> As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
> update PHY info"), do discovery will send a new SMP_DISCOVER and update
> phy->phy_change_count. We found that if the disk is reconnected and phy
> change_count changes at this time, the disk scanning process will not be
> triggered.
> 
> So update the PHY info with the last query results.

Please mention that sas_unregister_devs_sas_addr() should be called 
before sas_set_ex_phy() for this case.

> 
> Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to update PHY info")
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
> v1 -> v2:
> Use sas_get_phy_discover() instead of sas_get_phy_attached_dev() in
> sas_rediscover_dev() and use disc_resp to update phy info.
> ---
>   drivers/scsi/libsas/sas_expander.c | 37 ++++++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index a2204674b680..a75dcce7a9ba 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -1940,6 +1940,7 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
>   	struct expander_device *ex = &dev->ex_dev;
>   	struct ex_phy *phy = &ex->ex_phy[phy_id];
>   	enum sas_device_type type = SAS_PHY_UNUSED;
> +	struct smp_disc_resp *disc_resp;
>   	u8 sas_addr[SAS_ADDR_SIZE];
>   	char msg[80] = "";
>   	int res;
> @@ -1951,33 +1952,47 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
>   		 SAS_ADDR(dev->sas_addr), phy_id, msg);
>   
>   	memset(sas_addr, 0, SAS_ADDR_SIZE);
> -	res = sas_get_phy_attached_dev(dev, phy_id, sas_addr, &type);
> +	disc_resp = alloc_smp_resp(DISCOVER_RESP_SIZE);
> +	if (!disc_resp)
> +		return -ENOMEM;
> +
> +	res = sas_get_phy_discover(dev, phy_id, disc_resp);
>   	switch (res) {
>   	case SMP_RESP_NO_PHY:
>   		phy->phy_state = PHY_NOT_PRESENT;
>   		sas_unregister_devs_sas_addr(dev, phy_id, last);
> -		return res;
> +		goto out;
>   	case SMP_RESP_PHY_VACANT:
>   		phy->phy_state = PHY_VACANT;
>   		sas_unregister_devs_sas_addr(dev, phy_id, last);
> -		return res;
> +		goto out;
>   	case SMP_RESP_FUNC_ACC:
>   		break;
>   	case -ECOMM:
>   		break;
>   	default:
> -		return res;
> +		goto out;
> +	}
> +
> +	if (res == 0) {
> +		struct discover_resp *dr = &disc_resp->disc;
> +
> +		memcpy(sas_addr, dr->attached_sas_addr, SAS_ADDR_SIZE);
> +		type = to_dev_type(dr);
> +		if (type == 0)

Please use SAS_PHY_UNUSED


> +			memset(sas_addr, 0, SAS_ADDR_SIZE);
>   	}

Any chance we can factor out some of this code with 
sas_get_phy_attached_dev() (where it has been copied from)?

>   
>   	if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
>   		phy->phy_state = PHY_EMPTY;
>   		sas_unregister_devs_sas_addr(dev, phy_id, last);
>   		/*
> -		 * Even though the PHY is empty, for convenience we discover
> -		 * the PHY to update the PHY info, like negotiated linkrate.
> +		 * Even though the PHY is empty, for convenience we update
> +		 * the PHY info, like negotiated linkrate.
>   		 */
> -		sas_ex_phy_discover(dev, phy_id);
> -		return res;
> +		if (res == 0)
> +			sas_set_ex_phy(dev, phy_id, disc_resp);
> +		goto out;
>   	} else if (SAS_ADDR(sas_addr) == SAS_ADDR(phy->attached_sas_addr) &&
>   		   dev_type_flutter(type, phy->attached_dev_type)) {
>   		struct domain_device *ata_dev = sas_ex_to_ata(dev, phy_id);
> @@ -1989,7 +2004,7 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
>   			action = ", needs recovery";
>   		pr_debug("ex %016llx phy%02d broadcast flutter%s\n",
>   			 SAS_ADDR(dev->sas_addr), phy_id, action);
> -		return res;
> +		goto out;

is there any way to get rid of all the goto's? Ideally we would have 
just one location to call kfree(disc_resp)

>   	}
>   
>   	/* we always have to delete the old device when we went here */
> @@ -1998,7 +2013,11 @@ static int sas_rediscover_dev(struct domain_device *dev, int phy_id,
>   		SAS_ADDR(phy->attached_sas_addr));
>   	sas_unregister_devs_sas_addr(dev, phy_id, last);
>   
> +	kfree(disc_resp);
>   	return sas_discover_new(dev, phy_id);
> +out:

Calling this simply "out" is odd, as we exit in many places

> +	kfree(disc_resp);
> +	return res;
>   }
>   
>   /**


As an aside, could libsas - and your changes here - be simpler if we 
changed smp_execute_task() like this:

static int smp_execute_task(struct domain_device *dev, void *req /* can 
be on the stack */, int req_size,
			    void *resp /* can be on the stack */, int resp_size)
{
	struct scatterlist req_sg;
	struct scatterlist resp_sg;
	int ret;
	void *_req = kmemdup(req, req_size, GFP_KERNEL);
	void *_resp = alloc_smp_resp(resp_size);
	if (!_req || !resp)
		return -ENOMEM;

	sg_init_one(&req_sg, _req, req_size);
	sg_init_one(&resp_sg, _resp, resp_size);
	ret = smp_execute_task_sg(dev, &req_sg, &resp_sg);
	memcpy(resp, _resp, resp_size);
	kfree(_req);
	kfree(_resp);
	return ret;
}

We need to use alloc_smp_resp() and alloc_smp_req() as we can't allocate 
these memories on the stack for calling sg_init_one(). But if we changed 
smp_execute_task() to memcpy from/to data on the stack, it might make 
callers simpler. I'm not sure.

Thanks,
John

