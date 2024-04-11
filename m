Return-Path: <linux-kernel+bounces-141244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CA28A1B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBA9282DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E925F874;
	Thu, 11 Apr 2024 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TqLy8hR/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0M/k9Ugv"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6F5D479;
	Thu, 11 Apr 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850991; cv=fail; b=kwkWrNmeM/iaDrK4BRRpzgjUPEQHmeGiro/Pj2JzXoGowKqtUg5zfYvaObJU39V6Fd/NSErAXpzYMgExxM5GjricMDBUWu8hSmmI/+vVINjBUNW0FTdZ4hSEkGQjP2QV6soNKPwgls8hrV9OMz48/TV67dPgooxQ0zrsdw7u08U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850991; c=relaxed/simple;
	bh=ZL2JF8kPmeY8m5EZaPFKafMSqR1lSuaJfXVCjGfqrj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GYgnHg6qcN6vFV6YPoyWXbkJJxUKwnm1I3EEV+j35uHfkb19pyTWE3rm1I0TJeNjZ3ENi9hsSrDiI6DaMwvDCZ3wK9hYkK4XtYHJljZ9gIAwRsMM/QdOEzo+xp2fxOuWD+aYlpcLnTlVmfWxX19SH7rx33W7i37AhnmZi/jYz+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TqLy8hR/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0M/k9Ugv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BEx89G007671;
	Thu, 11 Apr 2024 15:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZL2JF8kPmeY8m5EZaPFKafMSqR1lSuaJfXVCjGfqrj4=;
 b=TqLy8hR/3xGjztCudXxc9X05qiwhf1AKpAloIVYJXXwnlIYf28V0n5Q/tDh3ioJdvUkG
 6MkeAQP4wL/jChdHxzQBCq3b5Ue8oDWE46rT+ayOM9lMfXKm5QJI1kVb5XLbJbcQQgw1
 tqvAtcrnPZbrGDJqh87fs0OutBi602OL+GRpMFkzOpMG7D+whAnn+php5583AqoUY/e8
 PJ+L6SISJtGW9MPWB/sXahOp8bH3NA4usga9PLdsUE3fO5jIFePa18zun+gqlEsBx6Gi
 VjQvpwwfIJM/DDx81TLLVBntkIphePiv2O7PLWf8nLYGAFwBsBocAetGE0tMIMGDDFvt ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtf9s96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 15:56:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43BEwbLr007881;
	Thu, 11 Apr 2024 15:56:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu9qg8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 15:56:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2qkvNeSxvP2rXcfWfcVztx4d4mvgis37DFuMTlETRzjOuuGMv196o+QMhe3KQY2WOf0bgZCWjzFg0Z/sv5vqAEghkImfpizEmW+u8i4lTGpvbKppmeX6YalXroKd8RigboaH7V02qkjPomva7eSOsuSAfNAIKWsLep3pTe9pHHPh01l6V30gn1UcDKQEiTtS3a7kIjj5pFq4Um+vnCQi8TlOIpZpSLjO0AfPkRTWqvAPnRXegiibaArj3YyyngUGOm7Y5iAAkqkEgGUw6VIBFMBdAnFci0En/HRKKVwb5y/WGgnNtzruh9avuXK/R5n8f3fppt/xObPtZHhg4jUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZL2JF8kPmeY8m5EZaPFKafMSqR1lSuaJfXVCjGfqrj4=;
 b=T2p+d7vMRg7AVi7fhCmo44JeAZ7Xa1nfvIOb7+KUjwIvr5F4BiaNFZrH0AAcs9sNelXHcd05y/YsEv915X8HG6McBT4Spky52uhqeRaviX+KznJsUjRyDJgV0pdfsCVo1WKO6+35QuMLUGzTpBx5RihnszDew+OFTWPAXPMj59BenLSHHPSvG55r7sWYu8dqeaw5FDCQKs5IDTLiU0EOL9tW6U7WsYlbeNZpc7TBr526nB6+5BEuHVJOiTTJpffJVroe3KwWTu2Bkp5yP1ljBcICuoOef+0Ph81KML2gh58DG9/5eb6Uc97WXY+Nvv1ieijyowlowKDAn8CHwP+0Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZL2JF8kPmeY8m5EZaPFKafMSqR1lSuaJfXVCjGfqrj4=;
 b=0M/k9UgvqHQUOo0AI4UJG8LUf0OzV01Uqr8jjHjHBO90JszIgBhaUTGLakyHOh/uArlXx4y562EdEp3PtQxnSlMewI6No5kAPbEie5xQ6UaHOuiZS+QGNMFgeBaBmoHe9UMI6/LuSWZ4Ht5lbQu6lpI0asKMylmSSw13gWi5y7g=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 15:55:57 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::ee66:40c0:bcee:ce7%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 15:55:57 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [RFC PATCH 3/4] ACPI: processor: refactor
 acpi_processor_get_info: isolate acpi_{map|unmap}_cpu under
 CONFIG_ACPI_HOTPLUG_CPU
Thread-Topic: [RFC PATCH 3/4] ACPI: processor: refactor
 acpi_processor_get_info: isolate acpi_{map|unmap}_cpu under
 CONFIG_ACPI_HOTPLUG_CPU
Thread-Index: 
 AQHaio+bKzbJEucF902Gmw2yADhKgLFhf5GAgABVT4CAABTwgIAA/Z8AgAAzyQCAACEXAA==
Date: Thu, 11 Apr 2024 15:55:57 +0000
Message-ID: <B5D6188D-97F8-4EF4-9EC3-9D4B8AC57830@oracle.com>
References: <20240409150536.9933-1-miguel.luis@oracle.com>
 <20240409150536.9933-4-miguel.luis@oracle.com>
 <20240410142359.00003dea@Huawei.com>
 <AC422669-2869-4C05-B8CD-4C94BDE24012@oracle.com>
 <20240410204415.00005597@Huawei.com>
 <11AF41A3-05DD-4100-B327-295EF74FE7F6@oracle.com>
 <20240411145720.000056f6@Huawei.com>
In-Reply-To: <20240411145720.000056f6@Huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|SJ0PR10MB5694:EE_
x-ms-office365-filtering-correlation-id: df86bc5e-8978-4210-1f3a-08dc5a3fe041
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zdeW7eGYsnOBr+8kJuJJVSL9+0e/V22RPOhYNPl6jM5opcMexcVDO6h8b8D9WXqMzGO2ggOhlmIsRMtjVYP17a2Sv1zge6q31dKS1IO+SQltnA0qXHQ24oeURWaSgof7FeLwRXbyHKlIF+adem5Qq+qIEXED/nFgliQ6VvbYUHY8Bf2H1pFvydi2zBpcKpu17kPGIl9Yi+sZKgxAgkyax6nMUwhHp3toRntwnGywSS0VWwa0IbGYX6QbIV5SfDYsYRTk/uhSaxX9FkckxHSlAjy9U57DK2VEbv5zCMe5rb4S42uzHYMLrNVG0FvnnXBU8Yzh/RToGKgCHaMVuIJBVh4DzSSUpq4cQs5lHXkC/QXUc4L/r5/rp1SaQDU8mPF9fOV520BeeSoqICG2cfo6zq0J2sFL46CyM6kgHHhXkV46BiHX29QbAb2SO2NhLiFFNT1jFV2V3Eh5jqcFTXGMap6AZlVnNjgBp5FlVHJ3lLFstQ2zmVh7F23W7XItuUsvkM+YXeXBh4uylw4R5wEvmJMtBACUB3uHGoojgcaDQ9CXrphaFf0yYs6vCPq+Hu1ZRHMcMyn30Y9dpvbC91qCGgioraxgdp98GusjPvbd3ghbZeot1/jrmdjXdWDGKBQfc+N5JeD5UGKTjIWFK/OIJprA4OsVLplwI9gsogbI9o+ZqXdJVcc15UKe9oEGAxIA/jyxnTlzpf+dG5bgUI7PAQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NUZiQTVVNUgySUQxZ0tMZndUYWJ1Qk5wRm8yUUJoblhSN1Y2ZVRqRUZ1ai9V?=
 =?utf-8?B?MEU2ZElrWXo5b3pnUThxWVoxbkRKNWtXa3pvc0txSFlaVWdPRElYYVNKSEY3?=
 =?utf-8?B?SkFybW9qVkxJQytudFNaUVlDSWR1Q0IwQU1KeVhqUUNrNmFhcE0reTZmOFZL?=
 =?utf-8?B?bVFTazF5ck96QklsK3RtSFp0TnVvTkpIMXhPcG0vaE1Pd1l6OGdDemJPaTVl?=
 =?utf-8?B?OGRHQ01JQTBKN01BVXBOemE2VnBGTm01b1crbUZyVTZXRVJleFQ2bVR3Yjhm?=
 =?utf-8?B?Z2JNRUVNTGhiUWczaEJWdWNKdlAxS3hRRm1LYThLL2NXMHdZQXd4emtBcFcx?=
 =?utf-8?B?MTF4Q09oTk80Nmk1VG1tVzZPM05EQW4zejRqcEVBRmprUTJDcTJReThxSCsy?=
 =?utf-8?B?YlgwQVdGYTJXbU9Oc0dCT0RSTDhld1p2KzU2U0pVcmlMa3o2VXNhcFlERGVH?=
 =?utf-8?B?WTV3YWhPZGpSQ0E0U21QOE1lM1lDVDZuWU53ajNaRVVSTlRSbnJGLzZ3K3VF?=
 =?utf-8?B?OFpnRUZLWWd6VktaWlA2MVRRaHdkY2FBK085Q1l4ZHhQbUZiSkkvR0NUOGQv?=
 =?utf-8?B?MzZGenhmVkdzd3g1eHVFRkoraTBDa1BjZ2wxcUttSjJYWTdyOU44UjJBcHlh?=
 =?utf-8?B?a1JsemZMcE5KZmRNVUppSS8zbXg1WnBlK09OUTd3Sm5GT2g4ZFo4QmhaTUZ4?=
 =?utf-8?B?eUFMQnh1bm45b2JuRlRUKzUvamo3WjVDTnhNbnR6cTBxT200M283N20zdEJY?=
 =?utf-8?B?V05hcC9kczNvT1ZDVXAwVmRRQkhGRHpUNWZvV3p3NlBvbWtwR3ZURHdKWDNn?=
 =?utf-8?B?WFgwSEdXV1RiRVp5SnlLQldEaE85QTJsckJYZ3B5ZzE5WWpGR1V2a29QYm9m?=
 =?utf-8?B?aC9jVU9Kd2lzNWw2T2xkeFoyemE4M3dWdVJtUTdnaDd5aVVoOEF4cmU2RWlq?=
 =?utf-8?B?T09reXBYcFc2QU9HZnN0eGlxcjMvNG40SnhSZDAvY2lMOWg1MGRDeThIdFhW?=
 =?utf-8?B?NEpUSnJENXRkOGgrNlFhSDI0UHQ1bDkxQk94ZDNEWHpkbWw1UWtIMk11Y1B4?=
 =?utf-8?B?dDR5M0hkeWdzVzhmQWVYNnJWa0pTSFNORFI3ckNTNjI3UXBhZFYvbFFlbjZZ?=
 =?utf-8?B?M2E0WWRaV2swVlFYZ0NmV3R4TGNKUGFzYTU2Y2VMS0xsU3NLQm5uTStVaUJD?=
 =?utf-8?B?YTV6RlI0K0JRYVFvNnBiYzFtMVJ1STU0SGdjaWNpdW9IVVhyR2xmVk9WQmJx?=
 =?utf-8?B?VTBZUmxnakN0VWIwOFhvSitlZ3hOaFJjYzJkRVg0aDdxZUtUYldLemtCOUNY?=
 =?utf-8?B?dUNKemJSR0c0c05uMmdMa3p5YmZQM3p1S1B1dWs1WlIrd08wdlhCbk5ITzhV?=
 =?utf-8?B?VHlFalI1SjI0STBMWlYzNzdPZUxJQldYRkxXaHY3c0JVT0dpQ21WQlJhalla?=
 =?utf-8?B?eDI3clg0MEc1UnZPTldXb3RXOGVOYWMrZ2RQSnhuM1JUbjFjdTlnSFcyc2ZL?=
 =?utf-8?B?amY5WDVBaUpGejE5YW85RklGOStrNWwvM1dkYWFHdTN3dHNUZEcwT0xPSEk2?=
 =?utf-8?B?b0tHckxqUWUwVWZLYXV4NWZwdVVRVjYwL2RtMTBQdWsyMEozamJWOVZubS9B?=
 =?utf-8?B?SGU0cmdoaG5DWlAzVjJPUlk0d25QLy9LQTNhcWo4NHBpUXlJNWVNQWYyYVdo?=
 =?utf-8?B?VEJ0WGpOaWViZXc2b2FuVGJuazRMZWEvdmVsb2tGRHFSZ1hHaFZHOXZLSHk2?=
 =?utf-8?B?dHYzdDdUeTFPSXVvRUpPbFQwam5FUHJrbHJaV1V3eDBsNHRYUEpZbld4eG10?=
 =?utf-8?B?emhraGdraWh2RUJFenhpaDBOVEJsQnN3bVFjeUFvUklhL0xXT05hQ1E3NVJj?=
 =?utf-8?B?dDhiWVFqU1NkeXVqZFhFdkp4TzJvcWcxUEFJZ0R6a1BSalNMMCs2Y2NieTVq?=
 =?utf-8?B?TEYyV3RVbm1taVYzc1JSSHhOWmNLSjUzUmJMVmhxRTBRSTZDZUpiMTkyQXlK?=
 =?utf-8?B?UFdROXovUzdkd2dOWno3elJ0cTF5L0p0elFKNExoQUgrK3lRUE83MndmaXVo?=
 =?utf-8?B?OWtKUGNFZnVBTmlyd1pQUmtVdVlTT3RIOGQ0Qm5tSEROTjNyTUptaFo0anc5?=
 =?utf-8?B?QnZ3NjFGQTF3aDNMQmx2Q1liMmQ3L1FERmlNeHdXM3ZyOG5UTzBaTE1MdWo4?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C10F0D7C3FF2714B9B2AC1B8D8369832@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	s+cE8+9D1E5aEI8ORNUGrmLSnMIb2l6LoOO86xWFEyhRo0ajDWcfxTOqqmAQuRQ0rSsjSmieC5gp3qOwKMZ0MVivz7ogk5v8wEIgo7lPNDQPAT3gXeSit6iqXEvED7t0l/pOEcLuUc6UyymEsG/R80BuBlyzv2pDrsxsf8MKOc+7+WY0KF7xMu5PK5jkmvkY4wfYFISy4AcEuGcycOwb4CcjQ/H0gjnVDQyD3sCRgnY7A9gCW7guPM2n6Rk/WO/9iKfck8uJx4BC0MmWbyeLejAmIVjoNDla/os2dI2PzZ1fRpHgfP6gIjsVwp1ncBz5Bpi1vK7ep/3ffAtXTB3DbTzh3bqlRhzBfqAhujQ73nxv5d3r/0Vik4c9u8WVNlQ4rEZk89HkG0Z6jADNa+3KegusC39boVrH4hQUEK7EkKhCgspM1us4RLDlypHFMCYuIkKgLNZYz6TwWtOFXsKabZHX2i+5B3LXAlqVkIXeEylVBkj7qUuwLebYQVGTI+OIfYPY2E0MIhBymKYBF9a4U0HqSv8nJmgqa7/0Iw5rYQQsFDUlRnPXtlBZdwAGZq7rVVbfNSS4aqnmiS7t8rFTB2OFs7oqQ3C2eDqWz9J18y8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df86bc5e-8978-4210-1f3a-08dc5a3fe041
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 15:55:57.1127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cs1QzEHqoPZgOsCNbHttzZRwqnmIeEOBdcauNVpwQn5J60j1rpe0SYzLA8te5G6RapBwQnoEayLusLMbgT744w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110117
X-Proofpoint-GUID: 5WMpkRfSe8LfUsYxFlqqbG4j4UrnQf5j
X-Proofpoint-ORIG-GUID: 5WMpkRfSe8LfUsYxFlqqbG4j4UrnQf5j

DQoNCj4gT24gMTEgQXByIDIwMjQsIGF0IDEzOjU3LCBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhh
bi5jYW1lcm9uQGh1YXdlaS5jb20+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAxMSBBcHIgMjAyNCAx
MDo1MjoxMyArMDAwMA0KPiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4gd3Jv
dGU6DQo+IA0KPj4+IE9uIDEwIEFwciAyMDI0LCBhdCAxOTo0NCwgSm9uYXRoYW4gQ2FtZXJvbiA8
am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiBXZWQsIDEw
IEFwciAyMDI0IDE4OjI5OjM0ICswMDAwDQo+Pj4gTWlndWVsIEx1aXMgPG1pZ3VlbC5sdWlzQG9y
YWNsZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+Pj4gT24gMTAgQXByIDIwMjQsIGF0IDEzOjIzLCBK
b25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQEh1YXdlaS5jb20+IHdyb3RlOg0KPj4+
Pj4gDQo+Pj4+PiBPbiBUdWUsICA5IEFwciAyMDI0IDE1OjA1OjMyICswMDAwDQo+Pj4+PiBNaWd1
ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+PiBt
YXBwaW5nIGFuZCB1bm1hcGluZyBhIGNwdSBhdCB0aGUgc3RhZ2Ugb2YgZXh0cmEgY3B1IGVudW1l
cmF0aW9uIGlzDQo+Pj4+Pj4gYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHdoaWNoIGRlcGVuZHMgb24g
Q09ORklHX0FDUElfSE9UUExVR19DUFUgc28gbGV0J3MNCj4+Pj4+PiBpc29sYXRlIHRoYXQgZnVu
Y3Rpb25hbGl0eSBmcm9tIGFyY2hpdGVjdHVyZSBpbmRlcGVuZGVudCBvbmUuICAgIA0KPj4+Pj4g
DQo+Pj4+PiBTaG91bGQgd2UgY29uc2lkZXIgcmVuYW1pbmcgYWNwaV9tYXBfY3B1KCkgdG8gYXJj
aF9hY3BpX21hcF9jcHUoKQ0KPj4+Pj4gdG8gbWFrZSB0aGUgYXJjaCBzcGVjaWZpYyBuYXR1cmUg
b2YgdGhhdCBjYWxsIG1vcmUgb2J2aW91cz8gICAgDQo+Pj4+IA0KPj4+PiBOb3Qgc3VyZSBhYm91
dCB0aGUgcGF0dGVybiB0byB1c2UgaGVyZSBidXQgdGhhdCBzZWVtcyBmaW5lIHRvIG1lLiBDdXJy
ZW50IHVzYWdlDQo+Pj4+IGlzIGFyY2hpdGVjdHVyZXMgZXhwb3J0IGFjcGlfbWFwX2NwdSBmcm9t
IHRoZSBhY3BpIGludGVyZmFjZSBhbmQgZG8gdGhlaXINCj4+Pj4gdGhpbmcuDQo+Pj4+IA0KPj4+
PiBRdWVzdGlvbiBpcyB3aGF0IHRvIGRvIHdoZW4gdGhlcmXigJlzIGEgdXNlLWNhc2Ugd2hpY2gg
ZGlzbWlzc2VzIGFjcGlfbWFwX2NwdSBhbmQNCj4+Pj4gaXQgZ2V0cyBjYWxsZWQgb24gdGhlIGNv
ZGUgcGF0aD8gIA0KPj4+IA0KPj4+IEknbSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFuIGJ5IGRpc21p
c3Nlcz8NCj4+PiANCj4+IA0KPj4gSSBtZWFuIHdoZW4gYWNwaV9tYXBfY3B1IGlzIG5vdCBuZWVk
ZWQuDQo+PiANCj4+PiBJcyBtaXNzaW5nIHBlcmhhcHM/ICANCj4+IA0KPj4gWWVzLg0KPj4gDQo+
Pj4gSWYgdGhhdCBpcyB3aGF0IHlvdSBtZWFuLCBJIHRoaW5rIGl0J3MgYSBtaXN0YWtlIHRvIGFs
bG93DQo+Pj4gdGhhdCBjb2RlIHRvIGJlIGNhbGxlZCBmcm9tIGEgcGF0aCB0aGF0IGlzbid0IGRl
cGVuZGVudCBvbg0KPj4+IENPTkZJR19BQ1BJX0hPVFBMVUdfQ1BVLg0KPj4+IEl0IG1ha2VzIG5v
IHNlbnNlIHRvIGRvIHNvIGFuZCBzdHViYmluZyBpdCBvdXQgdG8gZ2l2ZQ0KPj4+IHRoZSBpbXBy
ZXNzaW9uIHRoYXQgdGhlIGNhbGxpbmcgaXQgZG9lcyBtYWtlIHNlbnNlICh3aGVuIGxvb2tpbmcg
YXQgdGhlIGNhbGxlcikNCj4+PiBpcyBtaXNsZWFkaW5nLiAgDQo+PiANCj4+IE9LLCB0aGF0IHdv
dWxkIGJlIHdoYXQgbm90IHRvIGRvLg0KPj4gDQo+PiBhY3BpX3Byb2Nlc3Nvcl9lbnVtZXJhdGVf
ZXh0cmEgY291bGQgZGVhbCB3aXRoIG1ha2VfcHJlc2VudCBhbmQgbWFrZV9lbmFibGVkIHdoaWxl
DQo+PiBhIHN0dWIgd291bGQgc3RpbGwgYmUgbmVlZGVkIGZvciBtYWtlX3ByZXNlbnQgc2luY2Ug
aXQgZGVwZW5kcyBvbg0KPj4gQ09ORklHX0FDUElfSE9UUExVR19DUFU/DQo+IA0KPiBTdXJlLCB5
b3UgY291bGQgbWFrZSBpdCBkbyB0aGF0IHdpdGggYSBidW5jaCBvZiBjaGVja3Mgb24gdGhlDQo+
IGNvbmZpZyBiZWluZyBlbmFibGVkLCBidXQgY3VycmVudGx5IEkgZG9uJ3Qgc2VlIHRoZSBvdmVy
bGFwIGluDQo+IHNoYXJlZCBjb2RlIGFzIGJlaW5nIHN1ZmZpY2llbnQgZm9yIHRoYXQgdG8gbWFr
ZSBzZW5zZS4NCj4gDQo+IFRoZSBkaXNjdXNzaW9uIGJlZm9yZSB3YXMgYXNzdW1pbmcgdGhhdCB0
aGluZ3MgbGlrZSB0aGUgYWNwaV9tYXBfY3B1DQo+IGNhbGxzIG1pZ2h0IGRvIHN0dWZmIHRoYXQg
aXMgd2FudGVkIGluIHRoZSBtYWtlX2VuYWJsZWQoKSBjYXNlLg0KPiANCj4gR2l2ZW4gdGhleSBk
b24ndCBkbyBhbnl0aGluZyB0aGF0IHdlIHdhbnQgdGhlcmUgSSBkb24ndCBzZWUgc2hhcmluZw0K
PiB0aGUgY29kZSBhcyB1c2VmdWwuDQo+IA0KPiBJIGFtIGhvd2V2ZXIgaW4gZmF2b3Igb2YgcmVu
YW1pbmcgdGhvc2UgaG90cGx1ZyBvbmx5IGNhbGxzIHRvIHNvbWV0aGluZw0KPiBtb3JlIG1lYW5p
bmdmdWwgc28gbm8gb25lICd0aGlua3MnIHRoZXkgbWF5IGJlIHJlbGV2YW50IGluIHRoZQ0KPiBl
bmFibGluZyBvbmx5IGNhc2UhDQo+IA0KPiBKb25hdGhhbg0KPiANCj4gcC5zLiBJJ20gc21hc2hp
bmcgdGhlIG91dHB1dHMgb2YgdGhlIHRocmVhZCB3aXRoIFJhZmFlbCBpbnRvIGEgY29oZXJlbnQN
Cj4gcGF0Y2ggc2V0IGF0IHRoZSBtb21lbnQsIHBlcmhhcHMgc2VlaW5nIHRoYXQgd2lsbCBtYWtl
IGl0IGNsZWFyZXIgd2hhdA0KPiBpcyBnb2luZyBvbi4gIEkgZ290IGRpc3RyYWN0ZWQgYnkgZml4
aW5nIG51bWEgbm9kZSBoYW5kbGluZyB0aGlzIG1vcm5pbmcNCj4gYnV0IHRoYXQncyBub3cgcHVz
aGVkIG91dCBmb3IgYSBmb2xsb3cgb24gc2VyaWVzLg0KPiANCg0KVGhhbmtzISBMb29raW5nIGZv
cndhcmQgdG8gc2VlIHY1Lg0KDQpNaWd1ZWwNCg0KPiANCj4+IA0KPj4gTWlndWVsDQo+PiANCj4+
PiANCj4+PiBKb25hdGhhbg0KPj4+IA0KPj4+IA0KPj4+PiANCj4+Pj4gMSkgZXhwb3J0IGl0IGFu
ZCBkbyBub3RoaW5nIC0gaXQgd291bGQgYmUgY3JlYXRpbmcgdW5uZWNlc3NhcnkgZGVwZW5kZW5j
eS4NCj4+Pj4gDQo+Pj4+IDIpIGV2YWx1YXRlIHdoZXRoZXIgY2FsbGluZyBpdCBpcyBleGNsdXNp
dmUgdG8gdGhlIENQVSBIUCBwYXRoIGFuZCBrZWVwIGl0IHdyYXBwZWQNCj4+Pj4gaW50byBDT05G
SUdfQUNQSV9IT1RQTFVHX0NQVS4NCj4+Pj4gDQo+Pj4+IE9wdGlvbiAoMikgaXMgdGhlIGN1cnJl
bnQgYXBwcm9hY2ggb24gdGhpcyBSRkMuIElJVUMgYWNwaV9tYXBfY3B1IGlzIHNvbGVseQ0KPj4+
PiB1c2VkIGZvciBDUFUgSFAgYW5kIHRoZSBzYW1lIGFwcGxpZXMgdG8gYWNwaV91bm1hcF9jcHUu
DQo+Pj4+IA0KPj4+Pj4gSSB0aGluayB0aGF0IGhhcyBjYXVzZWQgbW9yZSBjb25mdXNpb24gaW4g
dGhlIGRpc2N1c3Npb24gdGhhbg0KPj4+Pj4gd2hldGhlciBpdCBpcyBob3RwbHVnIHNwZWNpZmlj
IG9yIG5vdC4gICAgDQo+Pj4+IA0KPj4+PiBJbmRlZWQuIFdpdGhpbiB0aGUgQ1BVIEhQIHBhdGgg
dGhlcmUgYXJlIHRoZXNlIGFyY2ggc3BlY2lmaWMgaW50cmljYWNpZXMuDQo+Pj4+IA0KPj4+Pj4g
DQo+Pj4+PiBBcyBtZW50aW9uZWQgaW4gcGF0Y2ggMiwgZmFpcmx5IHN1cmUgdGhpcyBuZWVkcyB0
byBnbyBiZWZvcmUgdGhhdA0KPj4+Pj4gcGF0Y2guICAgIA0KPj4+PiANCj4+Pj4gMiBhbmQgMyBk
ZXBlbmQgb24gZWFjaCB0byBiZSBzZWxmLWNvbnRhaW5lZCBhcyBDUFUgSFAgd291bGRu4oCZdCB3
b3JrIHdpdGhvdXQgbGF0ZQ0KPj4+PiBDUFUgaW5pdGlhbGlzYXRpb24gSSB0aGluay4NCj4+Pj4g
DQo+Pj4+IE1pZ3VlbA0KPj4+PiANCj4+Pj4+IA0KPj4+Pj4gSm9uYXRoYW4NCj4+Pj4+IA0KPj4+
Pj4+IA0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pZ3VlbCBMdWlzIDxtaWd1ZWwubHVpc0BvcmFj
bGUuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+IGRyaXZlcnMvYWNwaS9hY3BpX3Byb2Nlc3Nvci5j
IHwgMTcgKysrKysrKysrKysrKysrLS0NCj4+Pj4+PiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+Pj4+PiANCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9hY3BpL2FjcGlfcHJvY2Vzc29yLmMgYi9kcml2ZXJzL2FjcGkvYWNwaV9wcm9jZXNzb3Iu
Yw0KPj4+Pj4+IGluZGV4IDllYTU4YjYxZDc0MS4uYzZlMmY2NGEwNTZiIDEwMDY0NA0KPj4+Pj4+
IC0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpX3Byb2Nlc3Nvci5jDQo+Pj4+Pj4gKysrIGIvZHJpdmVy
cy9hY3BpL2FjcGlfcHJvY2Vzc29yLmMNCj4+Pj4+PiBAQCAtMTk0LDggKzE5NCwyMSBAQCBzdGF0
aWMgdm9pZCBhY3BpX3Byb2Nlc3Nvcl9ob3RwbHVnX2RlbGF5X2luaXQoc3RydWN0IGFjcGlfcHJv
Y2Vzc29yICpwcikNCj4+Pj4+PiBwcl9pbmZvKCJDUFUlZCBoYXMgYmVlbiBob3QtYWRkZWRcbiIs
IHByLT5pZCk7DQo+Pj4+Pj4gcHItPmZsYWdzLm5lZWRfaG90cGx1Z19pbml0ID0gMTsNCj4+Pj4+
PiB9DQo+Pj4+Pj4gK3N0YXRpYyBpbnQgYWNwaV9wcm9jZXNzb3JfaG90cGx1Z19tYXBfY3B1KHN0
cnVjdCBhY3BpX3Byb2Nlc3NvciAqcHIpDQo+Pj4+Pj4gK3sNCj4+Pj4+PiArIHJldHVybiBhY3Bp
X21hcF9jcHUocHItPmhhbmRsZSwgcHItPnBoeXNfaWQsIHByLT5hY3BpX2lkLCAmcHItPmlkKTsN
Cj4+Pj4+PiArfQ0KPj4+Pj4+ICtzdGF0aWMgdm9pZCBhY3BpX3Byb2Nlc3Nvcl9ob3RwbHVnX3Vu
bWFwX2NwdShzdHJ1Y3QgYWNwaV9wcm9jZXNzb3IgKnByKQ0KPj4+Pj4+ICt7DQo+Pj4+Pj4gKyBh
Y3BpX3VubWFwX2NwdShwci0+aWQpOw0KPj4+Pj4+ICt9DQo+Pj4+Pj4gI2Vsc2UNCj4+Pj4+PiBz
dGF0aWMgdm9pZCBhY3BpX3Byb2Nlc3Nvcl9ob3RwbHVnX2RlbGF5X2luaXQoc3RydWN0IGFjcGlf
cHJvY2Vzc29yICpwcikge30NCj4+Pj4+PiArc3RhdGljIGludCBhY3BpX3Byb2Nlc3Nvcl9ob3Rw
bHVnX21hcF9jcHUoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikNCj4+Pj4+PiArew0KPj4+Pj4+
ICsgcmV0dXJuIDA7DQo+Pj4+Pj4gK30NCj4+Pj4+PiArc3RhdGljIHZvaWQgYWNwaV9wcm9jZXNz
b3JfaG90cGx1Z191bm1hcF9jcHUoc3RydWN0IGFjcGlfcHJvY2Vzc29yICpwcikge30NCj4+Pj4+
PiAjZW5kaWYgLyogQ09ORklHX0FDUElfSE9UUExVR19DUFUgKi8NCj4+Pj4+PiANCj4+Pj4+PiAv
KiBFbnVtZXJhdGUgZXh0cmEgQ1BVcyAqLw0KPj4+Pj4+IEBAIC0yMTUsMTMgKzIyOCwxMyBAQCBz
dGF0aWMgaW50IGFjcGlfcHJvY2Vzc29yX2VudW1lcmF0ZV9leHRyYShzdHJ1Y3QgYWNwaV9wcm9j
ZXNzb3IgKnByKQ0KPj4+Pj4+IGNwdV9tYXBzX3VwZGF0ZV9iZWdpbigpOw0KPj4+Pj4+IGNwdXNf
d3JpdGVfbG9jaygpOw0KPj4+Pj4+IA0KPj4+Pj4+IC0gcmV0ID0gYWNwaV9tYXBfY3B1KHByLT5o
YW5kbGUsIHByLT5waHlzX2lkLCBwci0+YWNwaV9pZCwgJnByLT5pZCk7DQo+Pj4+Pj4gKyByZXQg
PSBhY3BpX3Byb2Nlc3Nvcl9ob3RwbHVnX21hcF9jcHUocHIpOw0KPj4+Pj4+IGlmIChyZXQpDQo+
Pj4+Pj4gZ290byBvdXQ7DQo+Pj4+Pj4gDQo+Pj4+Pj4gcmV0ID0gYXJjaF9yZWdpc3Rlcl9jcHUo
cHItPmlkKTsNCj4+Pj4+PiBpZiAocmV0KSB7DQo+Pj4+Pj4gLSBhY3BpX3VubWFwX2NwdShwci0+
aWQpOw0KPj4+Pj4+ICsgYWNwaV9wcm9jZXNzb3JfaG90cGx1Z191bm1hcF9jcHUocHIpOw0KPj4+
Pj4+IGdvdG8gb3V0Ow0KPj4+Pj4+IH0NCg0KDQo=

