Return-Path: <linux-kernel+bounces-40081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E809B83D9D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09B3B2946E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D5618E2C;
	Fri, 26 Jan 2024 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ON+XTvDj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WV8uh2GC"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98017BCC;
	Fri, 26 Jan 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270356; cv=fail; b=WvtiXEiGhihdILFzP8sYgEkjG27Qb6ZYyFqiSKrmIe1n0uEf8xCE+SYCHc4VpaWMDT4Ld/Kf+bn7i75JhBySSip8O0lxmCyv4gQGBRuqQg4Kbg0EK+hK5Ogblwo+C5xjnFDSZ6yKB/C3U7Ywt5QZoVUree+tfLVjyFCnqRyQwsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270356; c=relaxed/simple;
	bh=S/qPhAm5NrXmCqgDclLZQHDqqJTsBLiFuPhTPh3Hktk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eZrxgPDYvGtpghbYiERsOnvMZz5zhuN6aygUhUFY+d58GjezlmvGrf/o71KJt8mKJXKRg6MY+eQAcPeaYacn6oNKxVSy1UqaNyR16d7z8Pf3wX/RGJItzi/Ml0Xt+hX9b5m48p5pXeWjrBRo1A02Z7jGmcLD1k9CZ+Fj/GngSqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ON+XTvDj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WV8uh2GC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QB7Eob012793;
	Fri, 26 Jan 2024 11:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ZDdQzoc2Hs7bXTea+ynHzH57mK5xxEOaLyZlAlVDO4U=;
 b=ON+XTvDjqcB9tsDkm9+I++JrfmQAKdgbnfw+/zkmiT7bFRfDSewgqXB9nZWdL20m2A/J
 K1KItoGPOSnm1XMxViRno5rc+vZt4rT5/ODSKHwOBDyaV+Hn5yu3wwDsDvMgN8z70/2Z
 havsN+Mg4CQr/jbQyI/4omTYyma6Vkm7RBW/Bu+/IBrp0qFQji6Bkr3PviOQhifxLKK/
 vOxwA3DBM7ZKTYjqPGkHPIK5M2WwG2/nwtd5VWJ0UUQtDZdPkho3S8CzU0Ioz2a1i8TY
 QXdrrreDL5d2HID+Gmh7TM45C/lr7WRSst9bUKyH4SStHLqy4h+Z/HoNvlA7V5kyP9FB GQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cv220b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 11:59:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40Q9v5Nr015300;
	Fri, 26 Jan 2024 11:59:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs375tykc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 11:59:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlVGZ5d2ETsy7p2XAN7oLZe1SaNe0VJWb4TkKkAXQjDtKrZycrNDVTbLlV1FVa8odc3peSiBcQIWimZHq+psaExYd1ztM1OmZ6EaCSkrnnxLRodScja3TbIhx5DYT0HA5nY32B0ZrFSRBLaPdMgkb/y8mPTGQGHpYm5OKTiWke9DcsOh1sM9urEU/hgaE5SKFow2a2+duFM/l9Sxia+6NYKeVa6IS/5D4RLwBchUVSpGnVrYPyFVhGUWAUjUR/biimenctBiy+o9MH8GeTcxrEsTZB9Q9WQJLDRBucMAuXmGC1O3C7Ii0t1/GpghgtCBHDRo2wWdMr60ZawjHZkoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDdQzoc2Hs7bXTea+ynHzH57mK5xxEOaLyZlAlVDO4U=;
 b=ZkGJFHLUJobLIko43J8uMTlP2nk3j3sCZeJCLIuhI4v3byTAW5tH5E1Y4jSzq9+YkbddXJvnrYTYxc9dvCq52pYQgl6MELhmyjBo0edhAmRUiYOtWgT33+rR/5OmuzeLp/36R7Yrru48kAHE90GK5okk4w97vZm+QNjBPsBV7t2MAmA6b1V+FFZZCGdAH9jCDEGG+DfoC8NBZ1E4p01uyUlmaGhSS5fg4FPAeBlsrMsx7BZBk05lzcvM96qDNpqMl1ytt6E/QSjHGht99BBwUkN1S8HHnESpQlYBBqYEzDSyawo9l5rTu+JrUw8mNtzZypPSccNDMRZ7lncfxGbowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDdQzoc2Hs7bXTea+ynHzH57mK5xxEOaLyZlAlVDO4U=;
 b=WV8uh2GCRZYuLMeAvXxziNHixRoV9qEawEkEpxsuxBic/du0Tn5MDBQa6if1lbBMyvVYDxrVgx1srysiOQCmhIHncN3pq8p6mHGlTI/VlkYyXqXhXJhHoO9fgmEZAFDGdZ+yNQvx5+qj1GvWjxZv/jsZhCXmWaS4TOWKkjFtDS4=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by DM4PR10MB6814.namprd10.prod.outlook.com (2603:10b6:8:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 11:59:03 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::c6e9:8c36:bfbe:9ebf]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::c6e9:8c36:bfbe:9ebf%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 11:59:03 +0000
From: Liam Merwick <liam.merwick@oracle.com>
To: Kim Phillips <kim.phillips@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller"
	<davem@davemloft.net>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mario Limonciello
	<mario.limonciello@amd.com>
Subject: Re: [PATCH] crypto: ccp - Fix null pointer dereference in
 __sev_platform_shutdown_locked
Thread-Topic: [PATCH] crypto: ccp - Fix null pointer dereference in
 __sev_platform_shutdown_locked
Thread-Index: AQHaT+QfPqruLvwcB0yilXsp9IybTLDr/UUA
Date: Fri, 26 Jan 2024 11:59:03 +0000
Message-ID: <91b75885-26c0-4697-b5dd-3ebce922dd44@oracle.com>
References: <20240125231253.3122579-1-kim.phillips@amd.com>
In-Reply-To: <20240125231253.3122579-1-kim.phillips@amd.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-imapappendstamp: BN0PR10MB5126.namprd10.prod.outlook.com
 (15.20.7202.013)
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5030:EE_|DM4PR10MB6814:EE_
x-ms-office365-filtering-correlation-id: 933b54f3-2cd0-447f-9c19-08dc1e663106
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kJmBWQx4jkJiC5z0mFzj8461i7Cq9g926Put0ZaYuwR9iTZWTj9wbWhGVL4sTRC/3mTToXpC2n+Pl8EdPbNe5IvD6nfujG6SsK71Kssu5HskDzRuGkdJILSqKItUJOfhLcKl3l3Mo0N0vV4jKQR1gEINnv2+iwz3jGCbft1FxecD8YvtLtKZj6YYBSDgDqw6B8N9I3Mi2OdCMeIWaNvc5pogsXIpcOfkQrQXPUCEizIk4swFRBJnGIJyEEM3zcoFVhRryW2vvcbU9owWLMIToTmOPhtXe//u4FBXQjfIYLDJv28Q8ToWZB42wrWQzLN80xW7Y63j5a1YmmYqF/4jJuVGdkfovdKUgCAL47c0DlJ4rnEiW5Q0wyKMuTj3O0oWsoRMGACK5ubdZwWyoFBxEcQrLPkIPgF+Ery2P7pVdgfqIcJ4fpEm2epCYWSXWvW/Ov/0wk7eZODV6b91Rr5tK1AGqg7ze8PtKUwjn0NPmKuphaIlMF9PmFELh5BniHEbZQaebQmj1T+JQ3ts0b6xhYe0dqLZAyA5gPLb4MM2uqQnuKGyP8jbbzobAFKu65w6zxMryEdZjW0wsSclBIwVusf64BQzcSQiZujgD7Bir2Vorh2p9952mTas9W5ViAIhwlFRRRKB3nYYvOwYY7DhfKIXyZ2pwS24c/t1FryfqB5lG6VyjBdFNmvbg0GEfial
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(41300700001)(83380400001)(91956017)(36756003)(31696002)(38070700009)(86362001)(6486002)(122000001)(2616005)(6506007)(38100700002)(6512007)(53546011)(66556008)(45080400002)(2906002)(110136005)(66946007)(478600001)(8936002)(76116006)(71200400001)(316002)(64756008)(66476007)(54906003)(66446008)(44832011)(5660300002)(4326008)(7416002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?33TVUbh76vyKRF3zHliXuKsciHV94T0qlRzvPMfLDkId1ucuAF4NXwDYbM?=
 =?iso-8859-1?Q?3D/TzTKsm7/Ceg3oe3pNMkrP+rU4yEtwzv1ltgwtQMcAaqEiCIOFHyVzoZ?=
 =?iso-8859-1?Q?hqgjl7RU44SmyFp3KQT4VDvXHf8XqqZ4PQpuvLzHDvuP9IV7YKRecBtCmL?=
 =?iso-8859-1?Q?ox2sm//pgMt7dV1/FMdzfwy1T2zGAjsVfRC8a63YO0rb3vlJgB3qbc9ZWO?=
 =?iso-8859-1?Q?cfYTBs9gX8IY3fvZRjiqCfmTbMot00QqU7oMWuXblaWNZu3ak1+3Db3qlR?=
 =?iso-8859-1?Q?DYKeW4qCBJxpnQmwi7qaZHVGP+ueFBSSqfw9mOKJC97Jrp/FBjwZSikQd4?=
 =?iso-8859-1?Q?T/x1bzD/YtD3lkK/MyyQE3l943EIGMIdyNx7uWbVqDmtcrmM6H8YzltJOG?=
 =?iso-8859-1?Q?4+cV/a53MGYhcW0wTtRjPqzCdI2AmptDVBakR6Gw5j19tXny7VJRqHenDx?=
 =?iso-8859-1?Q?l+Nm16MOEPp1vwaUOMEw62fMawD4VYAPla6Mx47GGSg1TOuWIHHmLzq2BY?=
 =?iso-8859-1?Q?KcvNBiqd8BwS3r8P2V5N29/YOGaoihqsRrEo/X/c0QL8s+DQPv4Cz7qYbS?=
 =?iso-8859-1?Q?bRmxr629KvKgbfcyFCNxQWp+dn+UxvhTrO4fZ8IxV/9sJlayuIJiUbC36y?=
 =?iso-8859-1?Q?wohzPnSW60rrbbQ3tz7dGusNFuC+TWs/TimaazMYaCkvr9Wk79bbwSmyn/?=
 =?iso-8859-1?Q?a30ooGu0fHwwvQC0ejqZTSJUvRlLTQ9yUVkkB8neFmgLP8c0z1Hko5TGHS?=
 =?iso-8859-1?Q?rN4OYsTACQeuXQ6yESxkTGG3DkWHQZ9JSpZl5jsYwDYkSK84Q7VSDsOJVw?=
 =?iso-8859-1?Q?8YdQoikveAHmKimpaXe8CAamrnkqOJwIEZ7mPZkro3ONjG1ZKjL7b+6sb9?=
 =?iso-8859-1?Q?U+diYduLJtlzkexOQx7j+UbzMO1X8laPxcgsmnbvorqJ2Jqi2EnAH+NDUB?=
 =?iso-8859-1?Q?u+vkBxBD1I8QQXwg19WEoeImK6sjQ8PXA2oMM0gCDPTLQ2oLaOXuzUu18r?=
 =?iso-8859-1?Q?uNz/dFjYAfupMvdxVnRrgxlsvJ9PzF9gSYE+YJYbRTze3CIMCXWraytgzs?=
 =?iso-8859-1?Q?ZxFB558VpJHoUhnx18ifSA4R85bY6W5mWSWsOa4tDP7500IwJMgApKVfdu?=
 =?iso-8859-1?Q?ONtz5HKexU6l6iQPPO/QL8Cu7z4Bqwjer9YHtf4YmPCc/NHMf+yjUe4tQL?=
 =?iso-8859-1?Q?M+oYXBXwZLBj+H+Tj7sV8TSS4cc0A1LSKM/jmL2NXjkuLYV2d+TlRWc+Ti?=
 =?iso-8859-1?Q?MNqSZhRYzf+zZ3pMJyuupaK1vUMctc9EqngQaYekiqZj0gQ9ixhFHhH3A4?=
 =?iso-8859-1?Q?4w1EiyUKPXMvZi9hvLOSzf43PZz9pKYw9RDgxGAe643MtykA3SYTFwByvk?=
 =?iso-8859-1?Q?vMKmhbt7evjETAqWR6LXJI7YDRT/niOYPmztHgovUR/cq9xLpCITX1ClCb?=
 =?iso-8859-1?Q?YGHNbUucOHPnQ6NHO34W7RH65D+Qv5uBcaHNKunbAqDdK9xa4wxRrs7Zol?=
 =?iso-8859-1?Q?VEu247gnY2IIKguGW5zdCRs3LSkDBVwRfOcsP36oRokep5FeN6MCAshrO7?=
 =?iso-8859-1?Q?0L+A24FU41vLL3QrAgVIL35BApRC+Q7CKXvZaboxtNSrxBNgJ9saznecu3?=
 =?iso-8859-1?Q?B1c51FBT1++ikafpG8lF3UgP1QINUyN1i52cyGjjaFpdJJhQ1+PpVcdg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5A59DF2B31206A45800C546E43176C7E@oracle.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yU/UVXEu3sUk2sJD0AQbCLUaKyrs5x4QWP5G65OK7XBMr7KFFbAiXh6z5rc3AzoWXqK6X1i1x/uebXB7AmAf/+hzNn9GMy2hRgYdUuva7OkTEvQ8f46B3KN5TTF25qu5unxa9TvMLD0L+ROgOgOLKo5V4PKOGieMTID8+wcLNXmRr+LCAQKcqQfekojMxdnmOIbjrll4dI7+gzl6uAXeU7G/O6xw1zzvRDQ1jRNunhSs5P6tHiH3unfSDFvbc8VQqpQVZegybOsU4nW4u5+YR6MAJKeq5SA1GEw4Zph06eFG8BV12vIDzF/zuybX0JeUyz+brPhZThsrM4QzhZQkYyfIOpxDm92bKm16dmjy74MJP+992IJmR9hQILizcmhzgnYFQVEeCHmp9J6rF7Kcc8lAivKeENTDALXXLfKFxohXb19S9sbFWyYx6SsQIIBeOFjpfbh1hcvmh4Lf4hBEAoKG3Ie36HSRZoT6tBemV4Nc0Jm1UWkMqx/SfQ7sW7QxmrNN+szREvcZsaZ5AMRX3xIxOlbNWnJq8nEVSMgIZlzPm+H49L5AXKwtJ6A5VaLSs0I9fv52//9S4y2+XlsI922d6yyifQWj9it4aX4LWCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933b54f3-2cd0-447f-9c19-08dc1e663106
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 11:59:03.7236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hbnle4tV68h8ximjjYp+i0VMnGMq5yv0svFv2S816Is4RZRZvShS993b45ZpzPc7FCSYiQwFnBqa6JbO4lQXXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260088
X-Proofpoint-ORIG-GUID: sTcV21F8a9MzWXwGSlS7TTZ6q3pBnSwu
X-Proofpoint-GUID: sTcV21F8a9MzWXwGSlS7TTZ6q3pBnSwu

On 25/01/2024 23:12, Kim Phillips wrote:=0A=
> The SEV platform device can be shutdown with a null psp_master,=0A=
> e.g., using DEBUG_TEST_DRIVER_REMOVE.  Found using KASAN:=0A=
> =0A=
> [  137.148210] ccp 0000:23:00.1: enabling device (0000 -> 0002)=0A=
> [  137.162647] ccp 0000:23:00.1: no command queues available=0A=
> [  137.170598] ccp 0000:23:00.1: sev enabled=0A=
> [  137.174645] ccp 0000:23:00.1: psp enabled=0A=
> [  137.178890] general protection fault, probably for non-canonical addre=
ss 0xdffffc000000001e: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN NOPTI=0A=
> [  137.182693] KASAN: null-ptr-deref in range [0x00000000000000f0-0x00000=
000000000f7]=0A=
> [  137.182693] CPU: 93 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc1+ #311=
=0A=
> [  137.182693] RIP: 0010:__sev_platform_shutdown_locked+0x51/0x180=0A=
> [  137.182693] Code: 08 80 3c 08 00 0f 85 0e 01 00 00 48 8b 1d 67 b6 01 0=
8 48 b8 00 00 00 00 00 fc ff df 48 8d bb f0 00 00 00 48 89 f9 48 c1 e9 03 <=
80> 3c 01 00 0f 85 fe 00 00 00 48 8b 9b f0 00 00 00 48 85 db 74 2c=0A=
> [  137.182693] RSP: 0018:ffffc900000cf9b0 EFLAGS: 00010216=0A=
> [  137.182693] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 000000000=
000001e=0A=
> [  137.182693] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 000000000=
00000f0=0A=
> [  137.182693] RBP: ffffc900000cf9c8 R08: 0000000000000000 R09: fffffbfff=
58f5a66=0A=
> [  137.182693] R10: ffffc900000cf9c8 R11: ffffffffac7ad32f R12: ffff8881e=
5052c28=0A=
> [  137.182693] R13: ffff8881e5052c28 R14: ffff8881758e43e8 R15: ffffffffa=
c64abf8=0A=
> [  137.182693] FS:  0000000000000000(0000) GS:ffff889de7000000(0000) knlG=
S:0000000000000000=0A=
> [  137.182693] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
> [  137.182693] CR2: 0000000000000000 CR3: 0000001cf7c7e000 CR4: 000000000=
0350ef0=0A=
> [  137.182693] Call Trace:=0A=
> [  137.182693]  <TASK>=0A=
> [  137.182693]  ? show_regs+0x6c/0x80=0A=
> [  137.182693]  ? __die_body+0x24/0x70=0A=
> [  137.182693]  ? die_addr+0x4b/0x80=0A=
> [  137.182693]  ? exc_general_protection+0x126/0x230=0A=
> [  137.182693]  ? asm_exc_general_protection+0x2b/0x30=0A=
> [  137.182693]  ? __sev_platform_shutdown_locked+0x51/0x180=0A=
> [  137.182693]  sev_firmware_shutdown.isra.0+0x1e/0x80=0A=
> [  137.182693]  sev_dev_destroy+0x49/0x100=0A=
> [  137.182693]  psp_dev_destroy+0x47/0xb0=0A=
> [  137.182693]  sp_destroy+0xbb/0x240=0A=
> [  137.182693]  sp_pci_remove+0x45/0x60=0A=
> [  137.182693]  pci_device_remove+0xaa/0x1d0=0A=
> [  137.182693]  device_remove+0xc7/0x170=0A=
> [  137.182693]  really_probe+0x374/0xbe0=0A=
> [  137.182693]  ? srso_return_thunk+0x5/0x5f=0A=
> [  137.182693]  __driver_probe_device+0x199/0x460=0A=
> [  137.182693]  driver_probe_device+0x4e/0xd0=0A=
> [  137.182693]  __driver_attach+0x191/0x3d0=0A=
> [  137.182693]  ? __pfx___driver_attach+0x10/0x10=0A=
> [  137.182693]  bus_for_each_dev+0x100/0x190=0A=
> [  137.182693]  ? __pfx_bus_for_each_dev+0x10/0x10=0A=
> [  137.182693]  ? __kasan_check_read+0x15/0x20=0A=
> [  137.182693]  ? srso_return_thunk+0x5/0x5f=0A=
> [  137.182693]  ? _raw_spin_unlock+0x27/0x50=0A=
> [  137.182693]  driver_attach+0x41/0x60=0A=
> [  137.182693]  bus_add_driver+0x2a8/0x580=0A=
> [  137.182693]  driver_register+0x141/0x480=0A=
> [  137.182693]  __pci_register_driver+0x1d6/0x2a0=0A=
> [  137.182693]  ? srso_return_thunk+0x5/0x5f=0A=
> [  137.182693]  ? esrt_sysfs_init+0x1cd/0x5d0=0A=
> [  137.182693]  ? __pfx_sp_mod_init+0x10/0x10=0A=
> [  137.182693]  sp_pci_init+0x22/0x30=0A=
> [  137.182693]  sp_mod_init+0x14/0x30=0A=
> [  137.182693]  ? __pfx_sp_mod_init+0x10/0x10=0A=
> [  137.182693]  do_one_initcall+0xd1/0x470=0A=
> [  137.182693]  ? __pfx_do_one_initcall+0x10/0x10=0A=
> [  137.182693]  ? parameq+0x80/0xf0=0A=
> [  137.182693]  ? srso_return_thunk+0x5/0x5f=0A=
> [  137.182693]  ? __kmalloc+0x3b0/0x4e0=0A=
> [  137.182693]  ? kernel_init_freeable+0x92d/0x1050=0A=
> [  137.182693]  ? kasan_populate_vmalloc_pte+0x171/0x190=0A=
> [  137.182693]  ? srso_return_thunk+0x5/0x5f=0A=
> [  137.182693]  kernel_init_freeable+0xa64/0x1050=0A=
> [  137.182693]  ? __pfx_kernel_init+0x10/0x10=0A=
> [  137.182693]  kernel_init+0x24/0x160=0A=
> [  137.182693]  ? __switch_to_asm+0x3e/0x70=0A=
> [  137.182693]  ret_from_fork+0x40/0x80=0A=
> [  137.182693]  ? __pfx_kernel_init+0x10/0x10=0A=
> [  137.182693]  ret_from_fork_asm+0x1b/0x30=0A=
> [  137.182693]  </TASK>=0A=
> [  137.182693] Modules linked in:=0A=
> [  137.538483] ---[ end trace 0000000000000000 ]---=0A=
> =0A=
> Fixes: 1b05ece0c9315 ("crypto: ccp - During shutdown, check SEV data poin=
ter before using")=0A=
=0A=
checkpatch warns about SHA1 of Fixes: having more than 12 chars...=0A=
=0A=
However, although 1b05ece0c931 is the last commit to change this=0A=
functionality, I think this issue exists prior to that.=0A=
=0A=
5441a07a127f ("crypto: ccp - shutdown SEV firmware on kexec")=0A=
might be more appropriate so that it'd get applied to linux-5.15.y=0A=
(where 1b05ece0c931 and 5441a07a127f have been backported to also)=0A=
This patch applies cleanly to linux-5.15.y.=0A=
=0A=
=0A=
> Cc: stable@vger.kernel.org=0A=
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>=0A=
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>=0A=
=0A=
Code changes LGTM, so=0A=
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>=0A=
=0A=
=0A=
> ---=0A=
>   drivers/crypto/ccp/sev-dev.c | 10 ++++++++--=0A=
>   1 file changed, 8 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c=
=0A=
> index fcaccd0b5a65..53b217a62104 100644=0A=
> --- a/drivers/crypto/ccp/sev-dev.c=0A=
> +++ b/drivers/crypto/ccp/sev-dev.c=0A=
> @@ -534,10 +534,16 @@ EXPORT_SYMBOL_GPL(sev_platform_init);=0A=
>   =0A=
>   static int __sev_platform_shutdown_locked(int *error)=0A=
>   {=0A=
> -	struct sev_device *sev =3D psp_master->sev_data;=0A=
> +	struct psp_device *psp =3D psp_master;=0A=
> +	struct sev_device *sev;=0A=
>   	int ret;=0A=
>   =0A=
> -	if (!sev || sev->state =3D=3D SEV_STATE_UNINIT)=0A=
> +	if (!psp || !psp->sev_data)=0A=
> +		return 0;=0A=
> +=0A=
> +	sev =3D psp->sev_data;=0A=
> +=0A=
> +	if (sev->state =3D=3D SEV_STATE_UNINIT)=0A=
>   		return 0;=0A=
>   =0A=
>   	ret =3D __sev_do_cmd_locked(SEV_CMD_SHUTDOWN, NULL, error);=0A=
=0A=

