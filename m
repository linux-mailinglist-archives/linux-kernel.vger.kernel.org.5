Return-Path: <linux-kernel+bounces-56725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD3284CE2F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C801F273E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F4480023;
	Wed,  7 Feb 2024 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hFvEgM7G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QD8ll1dQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B345A0F7;
	Wed,  7 Feb 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320236; cv=fail; b=SExX7z246ZwzMuPkCZu6NE95i/0Le+cT15Fc4xxO8XdJJrVrKJ7RVM8kpY8r3FbBsQN/mfDb3ABa8216JQlrZaeG/C0UpuyaygIOT8rVvVvuoAnNAPFhOnVcVy1dLWZbUTXfs78z2iMWn/qwu+Ry5Ny1vwdKP1xOzbxIHxdJyvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320236; c=relaxed/simple;
	bh=GlbCsCyg3Bn1vEfjspENT/DF4NokuX7/vmNvLPNba4w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=APBkKbzaOGx/RHW3GQXlwOQ2qV/qucZRgGHa0dyg56ofdpGcnxyu24eoQHcQMgyV1QezC45VwLC1Ms49mI647ikkkUrz6apv3uyPA+7fENsGz2GJBFnz88wZrm6clF2u0EcZypt7I+I9XU3w+I6PbL0EXIlwEWOLHRndCFV3WbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hFvEgM7G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QD8ll1dQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417FQGg4009161;
	Wed, 7 Feb 2024 15:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=U8xgiM2eTvaokoo/hP8QrQ3bGsNXJC+6+Id2aTG9vGA=;
 b=hFvEgM7Gvf/qymzjdAiEPZb5fNGzrWnT/Cl01IeASMUybFmWrPrFNdLAgpIRQjHM7ddK
 8bAVdJy0EuVarUfiW230EIbSLxLvclZw0l587U9QaYf8LCMXloDDZ+zh8VEAFtCu95mm
 URw6Qj7wongxbLtt2LaICIwBDBCU1K+vFu0ptFCt1hILCrGheBi9amUQ5cCDnHtsQT8i
 rC/dcY86B/2R7t05uxUOsOfJfk/R2W5Jw/zztjfQ/6Dgkc47L7QUwYeUvDB0PUiSRBd5
 40rlH2gK7Z075rdutdt42NxSdXZchJeFNHfWCPs2h07IPNH1cl4KOctH19AD42z/bleO 0g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdd238q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 15:37:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 417ETfCT019657;
	Wed, 7 Feb 2024 15:37:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxfewmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 15:37:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReQJv7L5aGMAxlK+/GevuMLLl3QXcdd3JFvbGwZZ5Frc/cXG24kO5WWzgIOzSskOCI1Y93mxNIbNAmUwGHKFrKEu5+SKXM+iHxGQD1fW+hm1KXIjKyD4R/1rkanmAGEDcF7OsYEBvy5SAclZVzvOwbOHcG8oiBXx+vnf7GbTzMswPBx3lz6tASFlPrjlIPylYzQWiLB52kyF/3Jm3Cdds+yKp1sd8Bj0anEktOAfWSmJRHpVovAADnijfDM2v+dij8t/PoVlGrkfaslGTnQtZIeTYA9n86Mz1mSQPUIhS1+ciNXc7wuPRo8QlVjDA8VeXCczxAOorPd504tEFXtlhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8xgiM2eTvaokoo/hP8QrQ3bGsNXJC+6+Id2aTG9vGA=;
 b=kegMxMoPFUeAH2zg4cjo0rMZnC+VktLjmM2h6mjZDW7c++RIfuydih3UziHvDBbKsH0kIMmhPPD97TU/VXKIbP+IGoT8XBMax+zMLO/bOrhm+vNb+PnSQ+wS7RHOlGiWtFoFNQfX4ip0RccIl59/AMpcRAC7ogLXdFvO6Vomx5Lt4RRSg0DN+IW+sFHwgadg/eiVFBzjLrwh2IgGmsXTEAQBVRe1eP4GjWsr6hmAd8EMUPYiO5DCHgbaUSP2TnCdRGiqjYfg2f/CAKSUHVwOrRJpNBhMgQr5AoTkUox7i8PNFyQMJfFTZu4iROrpH08EGke/yctGswMhTqBQivNaTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8xgiM2eTvaokoo/hP8QrQ3bGsNXJC+6+Id2aTG9vGA=;
 b=QD8ll1dQ7FyfCAnHdabAW2FuWaT2QgLFSSH5JpHllX8mfyml3HR8y4tXzMNDOne10Y5QQ40nbrI3lGGIWdQ1gtQGoxchoK0OUk2aIIXUxmY9wJ3Y6ncyNTjxxHmWKo/Rx2OYhn6XDVdo9+TAFeXIBlQxsvNcokc/TGxj5gfR9Jo=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SN7PR10MB6641.namprd10.prod.outlook.com (2603:10b6:806:2ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 15:37:04 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::45f0:7588:e47c:a1ac]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::45f0:7588:e47c:a1ac%7]) with mapi id 15.20.7249.038; Wed, 7 Feb 2024
 15:37:04 +0000
Message-ID: <82889f67-adf3-4643-902e-2c8f581eb05a@oracle.com>
Date: Wed, 7 Feb 2024 09:37:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: core: really include kunit tests with
 SCSI_LIB_KUNIT_TEST
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240207145603.15680-1-lukas.bulwahn@gmail.com>
From: michael.christie@oracle.com
In-Reply-To: <20240207145603.15680-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:5:3af::25) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SN7PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: adcf56e3-23e1-462a-f455-08dc27f2a261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NOepomioAgDFIe+fOQR9qPP9+KvAl3vUxqhj6bEQ/y+GnQSD/yPXc2rn8puXuFh8C2W5remYl7NP0lTTqSnKAQd+VsXS4V2ylIZU1fe+SOqUGHIroJPwoDSyRR7UGOM5nHYVwtoFsINCdSrP1XMh/1lEUUXzlnfXsFJUk7zYGMUp7SSS5XnaOJ9J9MFa7pDssVTyidHcp59nSq3bq6oavXydNX7gKO+YadvWbuQlPqVeOA6F+5cne7RHb9jkaGimTSjnQ/AA0xvozPt4ldkpM2B4ZWHeLsbFUz9QKLsDSVYntdXpYnRQnjYc/am3KjBUlNQQoUFClFP2EQlrhwOeu7GE2wDQrvzAN346PfKhGjfNOPnaL4g/n610YmLgSpnrjcDWrI+IClKGQHecgJ3EMNGGTkVGb+6osdEw4XvBYM4non9SPjwSm9P3EOfVSRSUnHnBBbMAYm4N2SaTyHnLuTdzSPKfLWuGXFPN3zV8c9UL99IXOYbdp0ePczq5Y8m76B4+0rckorSKJ+79C0/o5jK/Tt4KfTGYkuSvnzQPdOWPRxev0+3IcRyIHK+m8mT6szDs1ce7BQBlFTeHcsEo1WjQ+GHJJ0WkWDcXzxkukG2/oUbu/ciAyVzDKygK+e9P
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31696002)(41300700001)(36756003)(6486002)(53546011)(110136005)(9686003)(8676002)(66476007)(6506007)(66946007)(66556008)(478600001)(8936002)(316002)(4326008)(26005)(38100700002)(2616005)(83380400001)(6512007)(86362001)(5660300002)(2906002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bFprOWhtQ2lmREs4ZnZGMmtGd0VBRWtFc3d3QU11a3FHKzdkSVdpcDFWVzda?=
 =?utf-8?B?eGVqcVQ0Wm9TY0owQk9QdzhONXp3Ymp3VE1xbzdJOVdOSHBYdGx4d25UellT?=
 =?utf-8?B?cXNtQXk1Q2lwQ2JLTHFLUkNsYjhVZHN0SVlIZ1p0MVBzd29OZE5pem5GNHZU?=
 =?utf-8?B?eTI2cytheU5ndTlaRVloOUlvTmMyaXJuQmo3YXhHZHcxeVZlaTRHN1g2LzhW?=
 =?utf-8?B?WUpleXo5WXA5UFFWS2RVZTNzdzlPcDRFWkdBOElmdU5hVWttb0RrUGtvMjJq?=
 =?utf-8?B?TjZVSGtiN3ZNK25HVWtyMmU0T0pqb1RrbnZhSGRXT2VzQzdsMlNWazNZWTlk?=
 =?utf-8?B?ZUhiQ0syS2ZhZHd6czBVRElKTDJmbVR4UjNpRUVTRXEwSWNUYndLcHNzYUJE?=
 =?utf-8?B?VVJSU0FGR3dpZEJkNXBaTzVlL0YxRkdSd2wvV3JrQ2RBU2x3QW91QnZGUy9H?=
 =?utf-8?B?S1RIdVJ0THVXWEVWb0Q3b29BM2wrOGRxbVdKTW1vK3hURkNlTlJnRVN0MmZa?=
 =?utf-8?B?N3RKOGROZkNITlUwc0FqTVowMnJqRy95cUQyMHZQQ1FSczIrRjdmaTNPMUZq?=
 =?utf-8?B?NXJwRzVGaGtwdjdwdytndENpdG1FaHYycUpwOWlidDVnQzJrcFJXK0JCTDAz?=
 =?utf-8?B?RFlnTmNPQ1pqTjFPRy8xbFc2TmVpcFlYRkhEYzhrR1lSeU9hMElOTDJqWFdF?=
 =?utf-8?B?TzhMek43K1VKNFFaN2FlR3N2a2R2TXIva2d6NlhGRW5IMnlMN2E4NUE0TDY5?=
 =?utf-8?B?Y3pTaytsWmlQK3VJcjJoYUJ0NTZCOTZYb1hmUXlJc2xTeVZ3UFNla3pES0Zq?=
 =?utf-8?B?eHhXVjJaSDhpcksrcVlpTjdsZTQzMVhneW9qWG12RUt6Ung2aFd4a3lya0th?=
 =?utf-8?B?b2JOUFQ3NWZXN0xXQXp1a2ErMU52cFlqM09QdTg0NWtCRlgrWE5QTEhyeDlT?=
 =?utf-8?B?bWJYbTNWeGR6QXFhSnZnRGhBN0FHRmx2RVR4eWNDRTBzVkYxUmxkMDhXU2pp?=
 =?utf-8?B?T25UYnFRZmpVcm96UjNqeG03cTlTNzhjK3FSVzVRMkdUT2EzTUc0eTBodzlt?=
 =?utf-8?B?U01mdUxLWXpNNG0vL1dQaVFQL2JCQS9DMlBibzNZN0x6c1Z3RzdHUUtTeDhx?=
 =?utf-8?B?NGFmWkt3ejJOMjQ3ek5ReXRkRXZHYzl4cWQzTkpVVFBLYkFyQjg3WEVNUXdL?=
 =?utf-8?B?WlkxcDl6MFROQjQyOTAzSjlHNEtjVEZlcVhFUTZQWTl0eDlnNDFLZmhNMXYz?=
 =?utf-8?B?eENkU0dib0hDY3Y1S0dYems2ZkRiTCs1c1VLQTZhR0VMUklNekNMU01JLzZr?=
 =?utf-8?B?TFFQUVJOTk9KRGY3NkFscXlwZSt1L3FCdEJPcHlRZ2ZZaElTRGJwb1UvUGdp?=
 =?utf-8?B?YnNxcTNsZkRJeXRieXZuZWhIdCsxQW55bXVaYVpsb3FHRnpzbE1reE1GNTE3?=
 =?utf-8?B?dER5ZUhiU3FaWGN0NTllS0w4akhZUUxkMlZoYy80enJJVDZrZlo1NTJhVmM0?=
 =?utf-8?B?NjJUWFI1TklHUFBSVmVZclBVUExWakVuQkhFSkU3QzBiYVhWS3VVbm9GMjJQ?=
 =?utf-8?B?bENxSXN5MzhTVUozL0hSbG41emg1aFBNdjlJYWRBZjI0dGkxU3dDckgvUGJq?=
 =?utf-8?B?a01VcU5JM0o3Q2dybUNkK3N1LzM4Y3BKT3RacTBmb3I3dzR5VUZWTWtGNTds?=
 =?utf-8?B?ZzJtcjg0OGR1bWRpeUxoQVNwV0FNMmZjZTdzdmJVMVBZWVRFeHU2RWpjYVQ2?=
 =?utf-8?B?dHBETll4a3RWUGM0RGV3RHBPaG9xcTFmUzFXdS9LSFlHbURLKzRuZko4ZG5z?=
 =?utf-8?B?MmpkVitqa1BmaG9LemR5bDVhc3Q4K1pHSG00dmJCR3puR0FaVHZuUjdhMDZj?=
 =?utf-8?B?RWF3dGJ2OUs4ZWs1cUhWQjFaam1lYXBXWEhOWmR1U0FGL2F6aE5sYVh4ZmlJ?=
 =?utf-8?B?RXF1eTc5NkpaWGk4RlVGaS9GbmZLemFkOGJsckI5d2E5SFFxQVZha0Q0UWpE?=
 =?utf-8?B?VUpuZkZ1bkdKK3I0UzZ0VjBPVkQwc1F6KzJTWlhITFBQNDEyWmdydUpxNzQz?=
 =?utf-8?B?SWZ4QWhFL2dSRTh0THhDeS93T2JMMGgwZ0pEd3l0N3F0QVR4SHU1dmc2TzNu?=
 =?utf-8?B?ck52WXNkSEM4WnVKZWdqa3B2VEdXOXJRaGkrSjV2S2ZramFxd216UkEweHRm?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oj5NUtAgAZbps1yyAd0+KJooDjZSkndPoIgAlA9eDV+AFHqWdejpSKRc8Wi+InF4MTEJnAcoa/eTg7CJyKomti68wOiw3GgwmijyWQoNAAFb/E07LNUQiXZ+4cNdmasB5H9RoWUg0OMW23xkWYyiESvV/c/iReYOkfpG2/BQNp0zGDB3bDyoTOatRoE87xe46BxBXrcgTAcGYs3OhoI1ZFoqnqllkF9waMohhi1d+yJy8UsbWMZ7qSI+q/k9OJcxVQnkmn2WyYhinZeVYXgg0OlqjavbwyXPhpPfQzUUgi5IcGftk5r1fxFKwoyPJ81hkE+mg+/X8ASPUGWIfNonkmJa0KRxo0UfNcdPYFNMioHm18303QBJy9iUpD353gEG2fEur70Yp9jyaEWTMkaUmzymEYF9xA4+5N80vVerKqEdlZbunMY3boxHK0cLAEGK0kGLIXuiwzJJsc7yV7rzkXBYd7qwJAqFKC1Ooo9FKD1jWlANaLUqyO2r/GxviqMGTK7iYiISCN7M/iGoAHJmUgdgRytl5Te7ZTn/NEb7+11p2EYucWik9T6eE5Y+Kb1nsE4LgdLOYlE34pgr5NGNOiogzkI5LB4PQ8XVTG2CkJA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcf56e3-23e1-462a-f455-08dc27f2a261
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 15:37:04.0552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dW5fift0K7S0zSiTV6Lr7XZ6PHhLCwuKpAzt7URnp3xeVo/y4NPG15nyuR8qs02+SSYmcyfCWob70UdQnLQnNqsp+TQ5+LDeTuUaq9bdtfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_06,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402070115
X-Proofpoint-GUID: 6sPQMxUNN9C8NfQvScVwn7rH7gA56UWa
X-Proofpoint-ORIG-GUID: 6sPQMxUNN9C8NfQvScVwn7rH7gA56UWa

On 2/7/24 8:56 AM, Lukas Bulwahn wrote:
> Commit 25a1f7a0a1fe ("scsi: core: Add kunit tests for
> scsi_check_passthrough()") adds the config SCSI_LIB_KUNIT_TEST and
> corresponding tests. Due to naming confusion, the actual tests would only
> be included when the non-existing config SCSI_KUNIT_TEST is enabled (note
> this missing 'LIB' in the config name). So, they are basically dead right
> now.
> 
> Adjust the name to actual existing config.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/scsi/scsi_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 23719b903259..0315a0dc3406 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -3428,6 +3428,6 @@ void scsi_build_sense(struct scsi_cmnd *scmd, int desc, u8 key, u8 asc, u8 ascq)
>  }
>  EXPORT_SYMBOL_GPL(scsi_build_sense);
>  
> -#ifdef CONFIG_SCSI_KUNIT_TEST
> +#ifdef CONFIG_SCSI_LIB_KUNIT_TEST
>  #include "scsi_lib_test.c"
>  #endif

I tried to sneak a rename in last minute and messed that up. Thanks.

Reviewed-by: Mike Christie <michael.christie@oracle.com>

