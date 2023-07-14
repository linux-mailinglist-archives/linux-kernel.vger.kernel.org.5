Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD592754421
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbjGNVLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjGNVLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:11:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69783A8C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:11:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EL4i9d005183;
        Fri, 14 Jul 2023 21:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=tqRNAnfS60TVyk9jO3N5ygYcKz55z4jbDZ17TlqWt08=;
 b=FgHtOYU88Re8hvinimiJfezP+LZ0umoKpDgVXsrLOU2uSy01oyKevhZbKQAyRRiegJhE
 T0S85B609HpucQWRQVtDa249O0g4wRaV93dammCMNQhuiLvtFMvOCpco2nLlrmNIpSdN
 sCp1XrRH3+PkvaYlcQvmqAJ/oOt9YPBNWVMKjAzFE/2lxtlKuIc0Wl6Ho4tH7io97qlm
 VKn97LpFTW7XaGVmwajT51jYVmR8VL2VSri2XNNp08SwIW4BHArnuB6veC5hxQezpZHB
 pn+4nQrfAH9g1TBtsE0+JPet3otKG0B4i/QYyiZe4+1dBq4ONpkLjNyBkiAa9L3W+ekj qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtq9tac83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 21:11:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36EK5Ptj008920;
        Fri, 14 Jul 2023 21:10:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rtpw0gfm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 21:10:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/2/KHk4UNWxMS+eQpDphZemOZKN3/EhAjjgOGFMh+hbWEo5kPKOqVOxuC4c7e803TV755x74MuLtJhgQ7jWuR7GkOBLYZd38xFVQorR9c9+LfEQmWYYHgNkBIZu1DBwAzPqXNFtcXBNKYUqFzd0egC8qzi9XSohUW/ocDSP4xcemURIpryYAV4IGsrJFT0jVXalK8Nt+NEDh/tILkUIVYoToNvtV8W7smoYd9Ezy25t/D32LSRE+AvS7bPfNitwb5N+By4E//mRe+qDP082l4dZjcr8SNjxDg2pd1mjE/kGMbpCrlKxFsjXk2utm9rBXa6JQlqhv6HiYGBnAa0CGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqRNAnfS60TVyk9jO3N5ygYcKz55z4jbDZ17TlqWt08=;
 b=is+C7AM2HA0S0nJWe2E2cwt4tKioRybRHLuGYzp09gKqaRkoja1cN1Jb9luXj1BbXn6vUbFbxHrPC1KGY7wUs4yFqKPqMI4aSfRok6tSyyDOBQN1fy6b5cu8iFISM7jJ6kDYutyRvhMOfV/xbJcsB0iVRgcsCdmqoMynjEr9Xr3rp0e3WPNPU1QiwQVeAk6ksP2k69Gn3+Mmrr2ifXKw8qcQnG9ozgeRJq83kGTFdv5nB0+3uZoXCWvoAyq1i8U5GmSELuqa1JKHyOVIJjIzY0qGZP3f7AscJ3yOtlgnYVc3l0yjHa6w4lmvtmRIskeTx8QGYMtoTVO4nb8S7NxBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqRNAnfS60TVyk9jO3N5ygYcKz55z4jbDZ17TlqWt08=;
 b=s4HkYlggu46N6C+14NanBAcu/YTmGN7nPDA/92yYxLWlO6xNDCSLSmJJpDe7W2W6wQ6+0/ebAKtEAGvkxYsNtyP2OiszlaehkVVmYFr5keqJjvbFqupx0c49UXJBc62UAwLzYtXAUp14tYfkwro5P0bW3Pgi1GFY8zelG7P9Kxg=
Received: from CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5)
 by IA1PR10MB5948.namprd10.prod.outlook.com (2603:10b6:208:3d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Fri, 14 Jul
 2023 21:10:54 +0000
Received: from CH3PR10MB6716.namprd10.prod.outlook.com
 ([fe80::6344:5ba3:2adc:be33]) by CH3PR10MB6716.namprd10.prod.outlook.com
 ([fe80::6344:5ba3:2adc:be33%7]) with mapi id 15.20.6588.028; Fri, 14 Jul 2023
 21:10:54 +0000
Date:   Fri, 14 Jul 2023 17:10:37 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        vitaly.wool@konsulko.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kill frontswap
Message-ID: <ZLG5zZl8C5ZIHuva@char.us.oracle.com>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230714194610.828210-1-hannes@cmpxchg.org>
X-ClientProxiedBy: SJ0PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::20) To CH3PR10MB6716.namprd10.prod.outlook.com
 (2603:10b6:610:146::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6716:EE_|IA1PR10MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: 16dff1fb-947a-47c8-eda1-08db84aecf55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Lu5AKO7N8NJ3J+tW+OjlidqPOe6Xet0VPtyPAQEbFPtGJNBC0w4JJwS8n/GaBNHSj8KhKyUJvsQ6Yvg1s/yUpbgc57BiqFC3miAkBCQC70t46L1EOKAzEQyalz8EcxaKqB4vxwG6CheTLIMgD6FNxovR0uX7Hv5NIqE84hs9UNB/NhFc6khbfKinqLckV6AydiJ8LOy+ef6amWp4+8TxD9HjOecRyiKEpPMqFrFkp4syvEpyLWX1VBHwCLV+iUMvaXC6VULBcxbaGvaQl//nnLFRezFYRnT42COMF4sybk3bwvoaFqQcrQwRWHQFB1NCC5+sfKrZz65EqFLmE363v2ICqh0EMjSX0cT2JJek+gt4zfpxSbXJOHPQR5mj0Wq/xOmeQYN6Pzl/VyiL2TBMlKNmoVZw+ZFx4uWNWjYaU17ZgIlDYu1KKD7wFARtAt2dJwlcw8GOj/CxUcHhgUcY6tqW0QUol0HYQNXl7eIdeJ16eTpC+sFyn7EaJGteRVMH9CudtBMZ50hKaUZoFU99tJ14dng9oGNhjkrlMbkO7UK0mQQsxAvgXn7vydf9Y+g3zf5VF00R4jLCncpq8UmsA44kLVBydWTe3fZvdryQZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6716.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(478600001)(86362001)(38100700002)(6666004)(6512007)(8936002)(8676002)(966005)(6486002)(2906002)(5660300002)(41300700001)(6916009)(316002)(66556008)(4326008)(66476007)(54906003)(66946007)(567974003)(66574015)(66899021)(26005)(30864003)(6506007)(83380400001)(186003)(21314003)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkp4ejRrbGVQSmVkWDV3V3hmZDJSYk9TanpxSGJrRUxLRDBVem5mV3pTVm03?=
 =?utf-8?B?S0xzUkxNem1TR2g0WEJxZUtjSDNnRjhFUnNHTnRHUFk3LzJKWi84UTFvZkRF?=
 =?utf-8?B?bUg1RUdyMUlWMTZBOU9UWVBoT01HTkoyMk1QMXFYRmZjdWdlNmliQ2NPeDg3?=
 =?utf-8?B?Q2g0dlEzaVNJVVIwK2E2VW9zb1JsU2RZdWZWamtCUnNkcWp0dmZOWkVUanBt?=
 =?utf-8?B?U0NwS2RZWGpSZzF0VzlzeG1XQmVmRkpySGYwVnJFQ0dIRlV4RWNRWVhXKy9P?=
 =?utf-8?B?NmZRbDh3TUN0T2N2M1RrbXVTbUptV3h0VXJUZjQxQ2F5VlRLdGdrQ3o3NzBG?=
 =?utf-8?B?TUp5ZFNMb2RLZUhxM20rUUluY09DMnBwcEl5RjZVU2I4NFVnK0I0dzk1Z2lC?=
 =?utf-8?B?eE50RTQrakRNS0dTTEFsZlhSOVZEQ0YySmtOZndFVS8wNFd4THQ2WUNkeUZm?=
 =?utf-8?B?RkxGbFRraXR4OTQrRjdNOXdNelRGT1NnNGlObHJiM1RmWktOWnNQdTR6UE5p?=
 =?utf-8?B?ZGxxMG1VcVVGdGhqU01SUE9hclhoY2c0dnhOTmFmZWt6cnB2VmI0N003aUNH?=
 =?utf-8?B?ekpINk5MaC9kNjJTbE1INi8rV3c1c2M1MnRjYUJ1amJiZEZlTEZoc3d4eWZ2?=
 =?utf-8?B?eit4M2ljcFRQcDBKMjRUamkxYmRQV3BaTFVJai84N0RUQXhxdDh4TzZ3d3Ny?=
 =?utf-8?B?cU5CTENKUjJkNVZQcmFlQXRqM1lCdWk3dFdybC9kTGpESk9xU25aK0VaZ1BI?=
 =?utf-8?B?cWdBYkhvcy9uZ095ZmhxNlZHSTRFOE1YZFA1aGg5Y3NVYkFmUUJZdTRkeGcz?=
 =?utf-8?B?UzZ3RW16MlhBMk9Ja3dZNkNpaDV5RnduaURmRlZybVZ0YmVlM1pFbEdzeHRx?=
 =?utf-8?B?Nnp2bWlMbGRRYnZiT0xnalYrRG03SS9uVEpFbHBRdjN3QU9iT3hVd21rdkta?=
 =?utf-8?B?b3VMYmUvVE14QW1QNi9pK0s2Q2dvd3hsTlQwVXBVeG52aDlIVnFvV3pTTUlW?=
 =?utf-8?B?SlZ2dnJJbmFIVjFTeVRnMlgwd2dNS2RwVnFSbDVwVkVYVVNUWnBYMmlmU2Rw?=
 =?utf-8?B?bCtHZVl5dzhyVE5EY3UyMjdVR3BnZXZEanFPMUtueTZOUWxyTWlSM3FOSFk4?=
 =?utf-8?B?Zlk0eXFlQ1ppS3QwT1B5ekx2b1hYd3p0RE94TlY2cWJ6anBhZFFEcDFvc1lZ?=
 =?utf-8?B?cEtqOXo0aHdTU1ArOTdzamlKZ1d5L2NtRjNHMndJRWxPcStMWFMxeUdOSkE5?=
 =?utf-8?B?Y3BValBzSkUxbndBRFByN1ZOM2hZWkVOV3lWclpxTVVCbUttZnpTZys2NHZS?=
 =?utf-8?B?TWdzR3hndzhYSVJTa0JaVjZ2WVpCYi9HbjF4dUZGOHVFZmlVWkxtYkY4andq?=
 =?utf-8?B?WmY5QVprSDRvcHFqOVFjcWlEWThNdGJjeE9weWFqOUxUOTc5NVdvK09QV29j?=
 =?utf-8?B?djRNOXRiWGZsblpBcENvbkZsenpTL3RmWmhKbTlsUVY0WnFlZzJneXl2OTBu?=
 =?utf-8?B?SDRyV0ZkS1YxU1dJaGNTM1JjUmhURFN1cGdweHZocUc0ZStaTFNuc3VieUpX?=
 =?utf-8?B?eVNROUw3SjFiQlhsd0xtVVM0K1pLUHVxb0F3Tysyd1Y0azRSV2JXV0hGb05X?=
 =?utf-8?B?UXNwV0Q4Z3hzVk02dzdZcjI3ZDJPRDRrQXpPNkE5YjlmdWU4WklyVTNEZU1V?=
 =?utf-8?B?MzA5QUtxc2pTZCtiRks4MG0rNVVVSGhhWXhrMFcvRDFxU3h1LytwK0pkdG0w?=
 =?utf-8?B?QUh3a3hQMXJBMzMrYnFXaXcxMVhicmFzOGc2cjBJeEFvR2taOFBHK0pSS1Ji?=
 =?utf-8?B?WGZ3MC9paEcrbHJnbzFHSmJkSnZDUk9SYWR6MjdVMldsWm1wYy9XblBLL0ZX?=
 =?utf-8?B?VEQwRXROazZSU0g5VFVNRzdiMFlZamdaT1lyS2g0Sm9BT1FqNGpXSE1NRk45?=
 =?utf-8?B?ejIrbWlJTE53dGxWdWJjeS8xdk0zNGF0Y0RMRy85NmdEY1FFTW00OU5IS3Jh?=
 =?utf-8?B?d2lrMnRtNXZvdXR1OTF5ZHZZU2VBUUtIRm1hbXcvNmgyb0t3eTlIdWVGYk5k?=
 =?utf-8?B?NkFWU29laHkvejNNUG5sNGk3WEVRSU52b3ZzYWRPM0FXQmVHVFlMTTlTMUVa?=
 =?utf-8?B?SUI2VHhqcGFxQXhYeTFFcWZqK3Foa1BvMGY0eWxCbk5oM0M2SnlEaFAwaEl2?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aTYzUThENFFWWThhejYvcDR3MGlNbjg1YjlYcXhjSGtjY0ZUbzcwRDd2ekJO?=
 =?utf-8?B?QXZPaGxQeVhNOTEwdkhJTFl3cWx3UFNpVS8vc2RYVDR0bWFscC85NkYvMVZR?=
 =?utf-8?B?SG80aGFNSGJKMnl2QkFoRmdCbktXK0UyM0k4VWk3cHVQVHhRaHB4b21WOGZk?=
 =?utf-8?B?eTE0VVJsL090YjVTL2hkV3A0UVhaRTBtTjBqTHRoeGVXbjRUZGFaSnNFL2dF?=
 =?utf-8?B?QktKMUo4ZDZkMnd1N2ZXdHpmZVVpNXZ4REZvcFZZaWIxc1hnZ002MHN2YzB0?=
 =?utf-8?B?VS91QkVpU0FUWkp0K3F0RWlBWlFPbzFBZk56NjBWNWY1MkZ6QVV1bVJpU2hj?=
 =?utf-8?B?ckVxTkVhcHJCYXp4NmxXVlVrTDBnRlFnTVlhT1pUeWZQN0praFcxdWtrc05X?=
 =?utf-8?B?WnRZb2c2LzhxSUhOSjZDdDlWV2FUbkNzY3d6QTNDZnFJak5LK3VGRHVyTWxh?=
 =?utf-8?B?QzRDM2ZtSFRxNXMyZ08weG84Yjh6U1BwOFBVMzlLYWMvUHBMUlVKbHdJems4?=
 =?utf-8?B?Ymt5T0FYWjExaGNMK3VFWGVNNEIwQlRZZlFmS2ZSb0ZHbG8vV2NCVGV3NElF?=
 =?utf-8?B?UEZyU25uZHgwSEQvdUJ4cWNYVGJKb0pJOEdHY0VFUjUwaklyOXBmb2FFRDhO?=
 =?utf-8?B?YzFUODZ6ZEsydWNFVW9reTd0ejJBQkloN3hkckNaS1N2RkZXMnVhb3V2T2lI?=
 =?utf-8?B?b2tiaksrUTVBNEEzcXdZd3VzZyszMlF3Y3lmb1lNRkZucDNRditkUmZ0RWlS?=
 =?utf-8?B?QVVSaHZoVnpiM1hhSlFDNzI0eTNlM3VOVk85MGdKZXd6bmRMMzg2YWRsQzhL?=
 =?utf-8?B?dGhCWk83ME5Hd2VhcEd4RTAxVWdjSUpFN01EN1h3NExTT01Jdi9GYkcyb2c4?=
 =?utf-8?B?NW1HUGUybERRbk10MjBpUk50WGhibjFLYXE0eXZZM3BUV2NWRjZRTC9kcks2?=
 =?utf-8?B?MlQ2bkxXMFE0b0ZtbmkreUdiOVJRZGMybGJFM204M1oxMWJKNlppQTFvRW9C?=
 =?utf-8?B?alRPamhUNzJqdTkyTEpMUDZQWkJkMlErTjdiWTFSU2Fna055cUMvWnRWTHM0?=
 =?utf-8?B?WUxRbnlCR2xNKzgxU3pOODh2MWp6TjJUU1UyN1MvaGdYcFVxOExDbExlQ0dq?=
 =?utf-8?B?czFBdUNCMnRGY0dZV1RsTDcrRG9OdEhEQ2lwaVE4WlFGcXBUbjhYem53RG1M?=
 =?utf-8?B?NGZ1YmcrV3psSERFU3dSUUROQlJ6bk5wZnkybGRQRWxLcGErWE14eEFlQm80?=
 =?utf-8?B?b3F3UXpsNjd3akVQdHRQWVBqa1BBeUYyTDhXdDllR1MxdStzVUE2OUQ5cDVR?=
 =?utf-8?Q?lHzxKpFcsHXG0Nw1ASy7jSpHxwe6wgWnKg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16dff1fb-947a-47c8-eda1-08db84aecf55
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6716.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 21:10:54.4480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXQ1xHEpezR0HG2wmlV+SolviEY2IafefEp5BnUhn0zKFMdydZbebwYBdlzCuGaDMUOKRR5Q3j0kblSY4x1KeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140194
X-Proofpoint-ORIG-GUID: 5WwGDDdWPKIEu9BGSdaSpi1xYk8C6tUY
X-Proofpoint-GUID: 5WwGDDdWPKIEu9BGSdaSpi1xYk8C6tUY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 03:46:08PM -0400, Johannes Weiner wrote:
> The only user of frontswap is zswap, and has been for a long
> time. Have swap call into zswap directly and remove the indirection.

RIP.

Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>


> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  Documentation/admin-guide/mm/zswap.rst        |  14 +-
>  Documentation/mm/frontswap.rst                | 264 ----------------
>  Documentation/mm/index.rst                    |   1 -
>  .../translations/zh_CN/mm/frontswap.rst       | 196 ------------
>  Documentation/translations/zh_CN/mm/index.rst |   1 -
>  MAINTAINERS                                   |   7 -
>  fs/proc/meminfo.c                             |   1 +
>  include/linux/frontswap.h                     |  91 ------
>  include/linux/swap.h                          |   9 -
>  include/linux/swapfile.h                      |   5 -
>  include/linux/zswap.h                         |  37 +++
>  mm/Kconfig                                    |   4 -
>  mm/Makefile                                   |   1 -
>  mm/frontswap.c                                | 283 ------------------
>  mm/page_io.c                                  |   6 +-
>  mm/swapfile.c                                 |  33 +-
>  mm/zswap.c                                    | 157 ++++------
>  17 files changed, 121 insertions(+), 989 deletions(-)
>  delete mode 100644 Documentation/mm/frontswap.rst
>  delete mode 100644 Documentation/translations/zh_CN/mm/frontswap.rst
>  delete mode 100644 include/linux/frontswap.h
>  create mode 100644 include/linux/zswap.h
>  delete mode 100644 mm/frontswap.c
> 
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
> index c5c2c7dbb155..45b98390e938 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -49,7 +49,7 @@ compressed pool.
>  Design
>  ======
>  
> -Zswap receives pages for compression through the Frontswap API and is able to
> +Zswap receives pages for compression from the swap subsystem and is able to
>  evict pages from its own compressed pool on an LRU basis and write them back to
>  the backing swap device in the case that the compressed pool is full.
>  
> @@ -70,19 +70,19 @@ means the compression ratio will always be 2:1 or worse (because of half-full
>  zbud pages).  The zsmalloc type zpool has a more complex compressed page
>  storage method, and it can achieve greater storage densities.
>  
> -When a swap page is passed from frontswap to zswap, zswap maintains a mapping
> +When a swap page is passed from swapout to zswap, zswap maintains a mapping
>  of the swap entry, a combination of the swap type and swap offset, to the zpool
>  handle that references that compressed swap page.  This mapping is achieved
>  with a red-black tree per swap type.  The swap offset is the search key for the
>  tree nodes.
>  
> -During a page fault on a PTE that is a swap entry, frontswap calls the zswap
> -load function to decompress the page into the page allocated by the page fault
> -handler.
> +During a page fault on a PTE that is a swap entry, the swapin code calls the
> +zswap load function to decompress the page into the page allocated by the page
> +fault handler.
>  
>  Once there are no PTEs referencing a swap page stored in zswap (i.e. the count
> -in the swap_map goes to 0) the swap code calls the zswap invalidate function,
> -via frontswap, to free the compressed entry.
> +in the swap_map goes to 0) the swap code calls the zswap invalidate function
> +to free the compressed entry.
>  
>  Zswap seeks to be simple in its policies.  Sysfs attributes allow for one user
>  controlled policy:
> diff --git a/Documentation/mm/frontswap.rst b/Documentation/mm/frontswap.rst
> deleted file mode 100644
> index c892412988af..000000000000
> --- a/Documentation/mm/frontswap.rst
> +++ /dev/null
> @@ -1,264 +0,0 @@
> -=========
> -Frontswap
> -=========
> -
> -Frontswap provides a "transcendent memory" interface for swap pages.
> -In some environments, dramatic performance savings may be obtained because
> -swapped pages are saved in RAM (or a RAM-like device) instead of a swap disk.
> -
> -.. _Transcendent memory in a nutshell: https://lwn.net/Articles/454795/
> -
> -Frontswap is so named because it can be thought of as the opposite of
> -a "backing" store for a swap device.  The storage is assumed to be
> -a synchronous concurrency-safe page-oriented "pseudo-RAM device" conforming
> -to the requirements of transcendent memory (such as Xen's "tmem", or
> -in-kernel compressed memory, aka "zcache", or future RAM-like devices);
> -this pseudo-RAM device is not directly accessible or addressable by the
> -kernel and is of unknown and possibly time-varying size.  The driver
> -links itself to frontswap by calling frontswap_register_ops to set the
> -frontswap_ops funcs appropriately and the functions it provides must
> -conform to certain policies as follows:
> -
> -An "init" prepares the device to receive frontswap pages associated
> -with the specified swap device number (aka "type").  A "store" will
> -copy the page to transcendent memory and associate it with the type and
> -offset associated with the page. A "load" will copy the page, if found,
> -from transcendent memory into kernel memory, but will NOT remove the page
> -from transcendent memory.  An "invalidate_page" will remove the page
> -from transcendent memory and an "invalidate_area" will remove ALL pages
> -associated with the swap type (e.g., like swapoff) and notify the "device"
> -to refuse further stores with that swap type.
> -
> -Once a page is successfully stored, a matching load on the page will normally
> -succeed.  So when the kernel finds itself in a situation where it needs
> -to swap out a page, it first attempts to use frontswap.  If the store returns
> -success, the data has been successfully saved to transcendent memory and
> -a disk write and, if the data is later read back, a disk read are avoided.
> -If a store returns failure, transcendent memory has rejected the data, and the
> -page can be written to swap as usual.
> -
> -Note that if a page is stored and the page already exists in transcendent memory
> -(a "duplicate" store), either the store succeeds and the data is overwritten,
> -or the store fails AND the page is invalidated.  This ensures stale data may
> -never be obtained from frontswap.
> -
> -If properly configured, monitoring of frontswap is done via debugfs in
> -the `/sys/kernel/debug/frontswap` directory.  The effectiveness of
> -frontswap can be measured (across all swap devices) with:
> -
> -``failed_stores``
> -	how many store attempts have failed
> -
> -``loads``
> -	how many loads were attempted (all should succeed)
> -
> -``succ_stores``
> -	how many store attempts have succeeded
> -
> -``invalidates``
> -	how many invalidates were attempted
> -
> -A backend implementation may provide additional metrics.
> -
> -FAQ
> -===
> -
> -* Where's the value?
> -
> -When a workload starts swapping, performance falls through the floor.
> -Frontswap significantly increases performance in many such workloads by
> -providing a clean, dynamic interface to read and write swap pages to
> -"transcendent memory" that is otherwise not directly addressable to the kernel.
> -This interface is ideal when data is transformed to a different form
> -and size (such as with compression) or secretly moved (as might be
> -useful for write-balancing for some RAM-like devices).  Swap pages (and
> -evicted page-cache pages) are a great use for this kind of slower-than-RAM-
> -but-much-faster-than-disk "pseudo-RAM device".
> -
> -Frontswap with a fairly small impact on the kernel,
> -provides a huge amount of flexibility for more dynamic, flexible RAM
> -utilization in various system configurations:
> -
> -In the single kernel case, aka "zcache", pages are compressed and
> -stored in local memory, thus increasing the total anonymous pages
> -that can be safely kept in RAM.  Zcache essentially trades off CPU
> -cycles used in compression/decompression for better memory utilization.
> -Benchmarks have shown little or no impact when memory pressure is
> -low while providing a significant performance improvement (25%+)
> -on some workloads under high memory pressure.
> -
> -"RAMster" builds on zcache by adding "peer-to-peer" transcendent memory
> -support for clustered systems.  Frontswap pages are locally compressed
> -as in zcache, but then "remotified" to another system's RAM.  This
> -allows RAM to be dynamically load-balanced back-and-forth as needed,
> -i.e. when system A is overcommitted, it can swap to system B, and
> -vice versa.  RAMster can also be configured as a memory server so
> -many servers in a cluster can swap, dynamically as needed, to a single
> -server configured with a large amount of RAM... without pre-configuring
> -how much of the RAM is available for each of the clients!
> -
> -In the virtual case, the whole point of virtualization is to statistically
> -multiplex physical resources across the varying demands of multiple
> -virtual machines.  This is really hard to do with RAM and efforts to do
> -it well with no kernel changes have essentially failed (except in some
> -well-publicized special-case workloads).
> -Specifically, the Xen Transcendent Memory backend allows otherwise
> -"fallow" hypervisor-owned RAM to not only be "time-shared" between multiple
> -virtual machines, but the pages can be compressed and deduplicated to
> -optimize RAM utilization.  And when guest OS's are induced to surrender
> -underutilized RAM (e.g. with "selfballooning"), sudden unexpected
> -memory pressure may result in swapping; frontswap allows those pages
> -to be swapped to and from hypervisor RAM (if overall host system memory
> -conditions allow), thus mitigating the potentially awful performance impact
> -of unplanned swapping.
> -
> -A KVM implementation is underway and has been RFC'ed to lkml.  And,
> -using frontswap, investigation is also underway on the use of NVM as
> -a memory extension technology.
> -
> -* Sure there may be performance advantages in some situations, but
> -  what's the space/time overhead of frontswap?
> -
> -If CONFIG_FRONTSWAP is disabled, every frontswap hook compiles into
> -nothingness and the only overhead is a few extra bytes per swapon'ed
> -swap device.  If CONFIG_FRONTSWAP is enabled but no frontswap "backend"
> -registers, there is one extra global variable compared to zero for
> -every swap page read or written.  If CONFIG_FRONTSWAP is enabled
> -AND a frontswap backend registers AND the backend fails every "store"
> -request (i.e. provides no memory despite claiming it might),
> -CPU overhead is still negligible -- and since every frontswap fail
> -precedes a swap page write-to-disk, the system is highly likely
> -to be I/O bound and using a small fraction of a percent of a CPU
> -will be irrelevant anyway.
> -
> -As for space, if CONFIG_FRONTSWAP is enabled AND a frontswap backend
> -registers, one bit is allocated for every swap page for every swap
> -device that is swapon'd.  This is added to the EIGHT bits (which
> -was sixteen until about 2.6.34) that the kernel already allocates
> -for every swap page for every swap device that is swapon'd.  (Hugh
> -Dickins has observed that frontswap could probably steal one of
> -the existing eight bits, but let's worry about that minor optimization
> -later.)  For very large swap disks (which are rare) on a standard
> -4K pagesize, this is 1MB per 32GB swap.
> -
> -When swap pages are stored in transcendent memory instead of written
> -out to disk, there is a side effect that this may create more memory
> -pressure that can potentially outweigh the other advantages.  A
> -backend, such as zcache, must implement policies to carefully (but
> -dynamically) manage memory limits to ensure this doesn't happen.
> -
> -* OK, how about a quick overview of what this frontswap patch does
> -  in terms that a kernel hacker can grok?
> -
> -Let's assume that a frontswap "backend" has registered during
> -kernel initialization; this registration indicates that this
> -frontswap backend has access to some "memory" that is not directly
> -accessible by the kernel.  Exactly how much memory it provides is
> -entirely dynamic and random.
> -
> -Whenever a swap-device is swapon'd frontswap_init() is called,
> -passing the swap device number (aka "type") as a parameter.
> -This notifies frontswap to expect attempts to "store" swap pages
> -associated with that number.
> -
> -Whenever the swap subsystem is readying a page to write to a swap
> -device (c.f swap_writepage()), frontswap_store is called.  Frontswap
> -consults with the frontswap backend and if the backend says it does NOT
> -have room, frontswap_store returns -1 and the kernel swaps the page
> -to the swap device as normal.  Note that the response from the frontswap
> -backend is unpredictable to the kernel; it may choose to never accept a
> -page, it could accept every ninth page, or it might accept every
> -page.  But if the backend does accept a page, the data from the page
> -has already been copied and associated with the type and offset,
> -and the backend guarantees the persistence of the data.  In this case,
> -frontswap sets a bit in the "frontswap_map" for the swap device
> -corresponding to the page offset on the swap device to which it would
> -otherwise have written the data.
> -
> -When the swap subsystem needs to swap-in a page (swap_readpage()),
> -it first calls frontswap_load() which checks the frontswap_map to
> -see if the page was earlier accepted by the frontswap backend.  If
> -it was, the page of data is filled from the frontswap backend and
> -the swap-in is complete.  If not, the normal swap-in code is
> -executed to obtain the page of data from the real swap device.
> -
> -So every time the frontswap backend accepts a page, a swap device read
> -and (potentially) a swap device write are replaced by a "frontswap backend
> -store" and (possibly) a "frontswap backend loads", which are presumably much
> -faster.
> -
> -* Can't frontswap be configured as a "special" swap device that is
> -  just higher priority than any real swap device (e.g. like zswap,
> -  or maybe swap-over-nbd/NFS)?
> -
> -No.  First, the existing swap subsystem doesn't allow for any kind of
> -swap hierarchy.  Perhaps it could be rewritten to accommodate a hierarchy,
> -but this would require fairly drastic changes.  Even if it were
> -rewritten, the existing swap subsystem uses the block I/O layer which
> -assumes a swap device is fixed size and any page in it is linearly
> -addressable.  Frontswap barely touches the existing swap subsystem,
> -and works around the constraints of the block I/O subsystem to provide
> -a great deal of flexibility and dynamicity.
> -
> -For example, the acceptance of any swap page by the frontswap backend is
> -entirely unpredictable. This is critical to the definition of frontswap
> -backends because it grants completely dynamic discretion to the
> -backend.  In zcache, one cannot know a priori how compressible a page is.
> -"Poorly" compressible pages can be rejected, and "poorly" can itself be
> -defined dynamically depending on current memory constraints.
> -
> -Further, frontswap is entirely synchronous whereas a real swap
> -device is, by definition, asynchronous and uses block I/O.  The
> -block I/O layer is not only unnecessary, but may perform "optimizations"
> -that are inappropriate for a RAM-oriented device including delaying
> -the write of some pages for a significant amount of time.  Synchrony is
> -required to ensure the dynamicity of the backend and to avoid thorny race
> -conditions that would unnecessarily and greatly complicate frontswap
> -and/or the block I/O subsystem.  That said, only the initial "store"
> -and "load" operations need be synchronous.  A separate asynchronous thread
> -is free to manipulate the pages stored by frontswap.  For example,
> -the "remotification" thread in RAMster uses standard asynchronous
> -kernel sockets to move compressed frontswap pages to a remote machine.
> -Similarly, a KVM guest-side implementation could do in-guest compression
> -and use "batched" hypercalls.
> -
> -In a virtualized environment, the dynamicity allows the hypervisor
> -(or host OS) to do "intelligent overcommit".  For example, it can
> -choose to accept pages only until host-swapping might be imminent,
> -then force guests to do their own swapping.
> -
> -There is a downside to the transcendent memory specifications for
> -frontswap:  Since any "store" might fail, there must always be a real
> -slot on a real swap device to swap the page.  Thus frontswap must be
> -implemented as a "shadow" to every swapon'd device with the potential
> -capability of holding every page that the swap device might have held
> -and the possibility that it might hold no pages at all.  This means
> -that frontswap cannot contain more pages than the total of swapon'd
> -swap devices.  For example, if NO swap device is configured on some
> -installation, frontswap is useless.  Swapless portable devices
> -can still use frontswap but a backend for such devices must configure
> -some kind of "ghost" swap device and ensure that it is never used.
> -
> -* Why this weird definition about "duplicate stores"?  If a page
> -  has been previously successfully stored, can't it always be
> -  successfully overwritten?
> -
> -Nearly always it can, but no, sometimes it cannot.  Consider an example
> -where data is compressed and the original 4K page has been compressed
> -to 1K.  Now an attempt is made to overwrite the page with data that
> -is non-compressible and so would take the entire 4K.  But the backend
> -has no more space.  In this case, the store must be rejected.  Whenever
> -frontswap rejects a store that would overwrite, it also must invalidate
> -the old data and ensure that it is no longer accessible.  Since the
> -swap subsystem then writes the new data to the read swap device,
> -this is the correct course of action to ensure coherency.
> -
> -* Why does the frontswap patch create the new include file swapfile.h?
> -
> -The frontswap code depends on some swap-subsystem-internal data
> -structures that have, over the years, moved back and forth between
> -static and global.  This seemed a reasonable compromise:  Define
> -them as global but declare them in a new include file that isn't
> -included by the large number of source files that include swap.h.
> -
> -Dan Magenheimer, last updated April 9, 2012
> diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> index 5a94a921ea40..31d2ac306438 100644
> --- a/Documentation/mm/index.rst
> +++ b/Documentation/mm/index.rst
> @@ -44,7 +44,6 @@ above structured documentation, or deleted if it has served its purpose.
>     balance
>     damon/index
>     free_page_reporting
> -   frontswap
>     hmm
>     hwpoison
>     hugetlbfs_reserv
> diff --git a/Documentation/translations/zh_CN/mm/frontswap.rst b/Documentation/translations/zh_CN/mm/frontswap.rst
> deleted file mode 100644
> index 434975390b48..000000000000
> --- a/Documentation/translations/zh_CN/mm/frontswap.rst
> +++ /dev/null
> @@ -1,196 +0,0 @@
> -:Original: Documentation/mm/frontswap.rst
> -
> -:翻译:
> -
> - 司延腾 Yanteng Si <siyanteng@loongson.cn>
> -
> -:校译:
> -
> -=========
> -Frontswap
> -=========
> -
> -Frontswap为交换页提供了一个 “transcendent memory” 的接口。在一些环境中，由
> -于交换页被保存在RAM（或类似RAM的设备）中，而不是交换磁盘，因此可以获得巨大的性能
> -节省（提高）。
> -
> -.. _Transcendent memory in a nutshell: https://lwn.net/Articles/454795/
> -
> -Frontswap之所以这么命名，是因为它可以被认为是与swap设备的“back”存储相反。存
> -储器被认为是一个同步并发安全的面向页面的“伪RAM设备”，符合transcendent memory
> -（如Xen的“tmem”，或内核内压缩内存，又称“zcache”，或未来的类似RAM的设备）的要
> -求；这个伪RAM设备不能被内核直接访问或寻址，其大小未知且可能随时间变化。驱动程序通过
> -调用frontswap_register_ops将自己与frontswap链接起来，以适当地设置frontswap_ops
> -的功能，它提供的功能必须符合某些策略，如下所示:
> -
> -一个 “init” 将设备准备好接收与指定的交换设备编号（又称“类型”）相关的frontswap
> -交换页。一个 “store” 将把该页复制到transcendent memory，并与该页的类型和偏移
> -量相关联。一个 “load” 将把该页，如果找到的话，从transcendent memory复制到内核
> -内存，但不会从transcendent memory中删除该页。一个 “invalidate_page” 将从
> -transcendent memory中删除该页，一个 “invalidate_area” 将删除所有与交换类型
> -相关的页（例如，像swapoff）并通知 “device” 拒绝进一步存储该交换类型。
> -
> -一旦一个页面被成功存储，在该页面上的匹配加载通常会成功。因此，当内核发现自己处于需
> -要交换页面的情况时，它首先尝试使用frontswap。如果存储的结果是成功的，那么数据就已
> -经成功的保存到了transcendent memory中，并且避免了磁盘写入，如果后来再读回数据，
> -也避免了磁盘读取。如果存储返回失败，transcendent memory已经拒绝了该数据，且该页
> -可以像往常一样被写入交换空间。
> -
> -请注意，如果一个页面被存储，而该页面已经存在于transcendent memory中（一个 “重复”
> -的存储），要么存储成功，数据被覆盖，要么存储失败，该页面被废止。这确保了旧的数据永远
> -不会从frontswap中获得。
> -
> -如果配置正确，对frontswap的监控是通过 `/sys/kernel/debug/frontswap` 目录下的
> -debugfs完成的。frontswap的有效性可以通过以下方式测量（在所有交换设备中）:
> -
> -``failed_stores``
> -	有多少次存储的尝试是失败的
> -
> -``loads``
> -	尝试了多少次加载（应该全部成功）
> -
> -``succ_stores``
> -	有多少次存储的尝试是成功的
> -
> -``invalidates``
> -	尝试了多少次作废
> -
> -后台实现可以提供额外的指标。
> -
> -经常问到的问题
> -==============
> -
> -* 价值在哪里?
> -
> -当一个工作负载开始交换时，性能就会下降。Frontswap通过提供一个干净的、动态的接口来
> -读取和写入交换页到 “transcendent memory”，从而大大增加了许多这样的工作负载的性
> -能，否则内核是无法直接寻址的。当数据被转换为不同的形式和大小（比如压缩）或者被秘密
> -移动（对于一些类似RAM的设备来说，这可能对写平衡很有用）时，这个接口是理想的。交换
> -页（和被驱逐的页面缓存页）是这种比RAM慢但比磁盘快得多的“伪RAM设备”的一大用途。
> -
> -Frontswap对内核的影响相当小，为各种系统配置中更动态、更灵活的RAM利用提供了巨大的
> -灵活性：
> -
> -在单一内核的情况下，又称“zcache”，页面被压缩并存储在本地内存中，从而增加了可以安
> -全保存在RAM中的匿名页面总数。Zcache本质上是用压缩/解压缩的CPU周期换取更好的内存利
> -用率。Benchmarks测试显示，当内存压力较低时，几乎没有影响，而在高内存压力下的一些
> -工作负载上，则有明显的性能改善（25%以上）。
> -
> -“RAMster” 在zcache的基础上增加了对集群系统的 “peer-to-peer” transcendent memory
> -的支持。Frontswap页面像zcache一样被本地压缩，但随后被“remotified” 到另一个系
> -统的RAM。这使得RAM可以根据需要动态地来回负载平衡，也就是说，当系统A超载时，它可以
> -交换到系统B，反之亦然。RAMster也可以被配置成一个内存服务器，因此集群中的许多服务器
> -可以根据需要动态地交换到配置有大量内存的单一服务器上......而不需要预先配置每个客户
> -有多少内存可用
> -
> -在虚拟情况下，虚拟化的全部意义在于统计地将物理资源在多个虚拟机的不同需求之间进行复
> -用。对于RAM来说，这真的很难做到，而且在不改变内核的情况下，要做好这一点的努力基本上
> -是失败的（除了一些广为人知的特殊情况下的工作负载）。具体来说，Xen Transcendent Memory
> -后端允许管理器拥有的RAM “fallow”，不仅可以在多个虚拟机之间进行“time-shared”，
> -而且页面可以被压缩和重复利用，以优化RAM的利用率。当客户操作系统被诱导交出未充分利用
> -的RAM时（如 “selfballooning”），突然出现的意外内存压力可能会导致交换；frontswap
> -允许这些页面被交换到管理器RAM中或从管理器RAM中交换（如果整体主机系统内存条件允许），
> -从而减轻计划外交换可能带来的可怕的性能影响。
> -
> -一个KVM的实现正在进行中，并且已经被RFC'ed到lkml。而且，利用frontswap，对NVM作为
> -内存扩展技术的调查也在进行中。
> -
> -* 当然，在某些情况下可能有性能上的优势，但frontswap的空间/时间开销是多少？
> -
> -如果 CONFIG_FRONTSWAP 被禁用，每个 frontswap 钩子都会编译成空，唯一的开销是每
> -个 swapon'ed swap 设备的几个额外字节。如果 CONFIG_FRONTSWAP 被启用，但没有
> -frontswap的 “backend” 寄存器，每读或写一个交换页就会有一个额外的全局变量，而不
> -是零。如果 CONFIG_FRONTSWAP 被启用，并且有一个frontswap的backend寄存器，并且
> -后端每次 “store” 请求都失败（即尽管声称可能，但没有提供内存），CPU 的开销仍然可以
> -忽略不计 - 因为每次frontswap失败都是在交换页写到磁盘之前，系统很可能是 I/O 绑定
> -的，无论如何使用一小部分的 CPU 都是不相关的。
> -
> -至于空间，如果CONFIG_FRONTSWAP被启用，并且有一个frontswap的backend注册，那么
> -每个交换设备的每个交换页都会被分配一个比特。这是在内核已经为每个交换设备的每个交换
> -页分配的8位（在2.6.34之前是16位）上增加的。(Hugh Dickins观察到，frontswap可能
> -会偷取现有的8个比特，但是我们以后再来担心这个小的优化问题)。对于标准的4K页面大小的
> -非常大的交换盘（这很罕见），这是每32GB交换盘1MB开销。
> -
> -当交换页存储在transcendent memory中而不是写到磁盘上时，有一个副作用，即这可能会
> -产生更多的内存压力，有可能超过其他的优点。一个backend，比如zcache，必须实现策略
> -来仔细（但动态地）管理内存限制，以确保这种情况不会发生。
> -
> -* 好吧，那就用内核骇客能理解的术语来快速概述一下这个frontswap补丁的作用如何？
> -
> -我们假设在内核初始化过程中，一个frontswap 的 “backend” 已经注册了；这个注册表
> -明这个frontswap 的 “backend” 可以访问一些不被内核直接访问的“内存”。它到底提
> -供了多少内存是完全动态和随机的。
> -
> -每当一个交换设备被交换时，就会调用frontswap_init()，把交换设备的编号（又称“类
> -型”）作为一个参数传给它。这就通知了frontswap，以期待 “store” 与该号码相关的交
> -换页的尝试。
> -
> -每当交换子系统准备将一个页面写入交换设备时（参见swap_writepage()），就会调用
> -frontswap_store。Frontswap与frontswap backend协商，如果backend说它没有空
> -间，frontswap_store返回-1，内核就会照常把页换到交换设备上。注意，来自frontswap
> -backend的响应对内核来说是不可预测的；它可能选择从不接受一个页面，可能接受每九个
> -页面，也可能接受每一个页面。但是如果backend确实接受了一个页面，那么这个页面的数
> -据已经被复制并与类型和偏移量相关联了，而且backend保证了数据的持久性。在这种情况
> -下，frontswap在交换设备的“frontswap_map” 中设置了一个位，对应于交换设备上的
> -页面偏移量，否则它就会将数据写入该设备。
> -
> -当交换子系统需要交换一个页面时（swap_readpage()），它首先调用frontswap_load()，
> -检查frontswap_map，看这个页面是否早先被frontswap backend接受。如果是，该页
> -的数据就会从frontswap后端填充，换入就完成了。如果不是，正常的交换代码将被执行，
> -以便从真正的交换设备上获得这一页的数据。
> -
> -所以每次frontswap backend接受一个页面时，交换设备的读取和（可能）交换设备的写
> -入都被 “frontswap backend store” 和（可能）“frontswap backend loads”
> -所取代，这可能会快得多。
> -
> -* frontswap不能被配置为一个 “特殊的” 交换设备，它的优先级要高于任何真正的交换
> -  设备（例如像zswap，或者可能是swap-over-nbd/NFS）？
> -
> -首先，现有的交换子系统不允许有任何种类的交换层次结构。也许它可以被重写以适应层次
> -结构，但这将需要相当大的改变。即使它被重写，现有的交换子系统也使用了块I/O层，它
> -假定交换设备是固定大小的，其中的任何页面都是可线性寻址的。Frontswap几乎没有触
> -及现有的交换子系统，而是围绕着块I/O子系统的限制，提供了大量的灵活性和动态性。
> -
> -例如，frontswap backend对任何交换页的接受是完全不可预测的。这对frontswap backend
> -的定义至关重要，因为它赋予了backend完全动态的决定权。在zcache中，人们无法预
> -先知道一个页面的可压缩性如何。可压缩性 “差” 的页面会被拒绝，而 “差” 本身也可
> -以根据当前的内存限制动态地定义。
> -
> -此外，frontswap是完全同步的，而真正的交换设备，根据定义，是异步的，并且使用
> -块I/O。块I/O层不仅是不必要的，而且可能进行 “优化”，这对面向RAM的设备来说是
> -不合适的，包括将一些页面的写入延迟相当长的时间。同步是必须的，以确保后端的动
> -态性，并避免棘手的竞争条件，这将不必要地大大增加frontswap和/或块I/O子系统的
> -复杂性。也就是说，只有最初的 “store” 和 “load” 操作是需要同步的。一个独立
> -的异步线程可以自由地操作由frontswap存储的页面。例如，RAMster中的 “remotification”
> -线程使用标准的异步内核套接字，将压缩的frontswap页面移动到远程机器。同样，
> -KVM的客户方实现可以进行客户内压缩，并使用 “batched” hypercalls。
> -
> -在虚拟化环境中，动态性允许管理程序（或主机操作系统）做“intelligent overcommit”。
> -例如，它可以选择只接受页面，直到主机交换可能即将发生，然后强迫客户机做他们
> -自己的交换。
> -
> -transcendent memory规格的frontswap有一个坏处。因为任何 “store” 都可
> -能失败，所以必须在一个真正的交换设备上有一个真正的插槽来交换页面。因此，
> -frontswap必须作为每个交换设备的 “影子” 来实现，它有可能容纳交换设备可能
> -容纳的每一个页面，也有可能根本不容纳任何页面。这意味着frontswap不能包含比
> -swap设备总数更多的页面。例如，如果在某些安装上没有配置交换设备，frontswap
> -就没有用。无交换设备的便携式设备仍然可以使用frontswap，但是这种设备的
> -backend必须配置某种 “ghost” 交换设备，并确保它永远不会被使用。
> -
> -
> -* 为什么会有这种关于 “重复存储” 的奇怪定义？如果一个页面以前被成功地存储过，
> -  难道它不能总是被成功地覆盖吗？
> -
> -几乎总是可以的，不，有时不能。考虑一个例子，数据被压缩了，原来的4K页面被压
> -缩到了1K。现在，有人试图用不可压缩的数据覆盖该页，因此会占用整个4K。但是
> -backend没有更多的空间了。在这种情况下，这个存储必须被拒绝。每当frontswap
> -拒绝一个会覆盖的存储时，它也必须使旧的数据作废，并确保它不再被访问。因为交
> -换子系统会把新的数据写到读交换设备上，这是确保一致性的正确做法。
> -
> -* 为什么frontswap补丁会创建新的头文件swapfile.h？
> -
> -frontswap代码依赖于一些swap子系统内部的数据结构，这些数据结构多年来一直
> -在静态和全局之间来回移动。这似乎是一个合理的妥协：将它们定义为全局，但在一
> -个新的包含文件中声明它们，该文件不被包含swap.h的大量源文件所包含。
> -
> -Dan Magenheimer，最后更新于2012年4月9日
> diff --git a/Documentation/translations/zh_CN/mm/index.rst b/Documentation/translations/zh_CN/mm/index.rst
> index 2f53e37b8049..b950dd118be7 100644
> --- a/Documentation/translations/zh_CN/mm/index.rst
> +++ b/Documentation/translations/zh_CN/mm/index.rst
> @@ -42,7 +42,6 @@ 结构化的文档中，如果它已经完成了它的使命，可以删除。
>     damon/index
>     free_page_reporting
>     ksm
> -   frontswap
>     hmm
>     hwpoison
>     hugetlbfs_reserv
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dfbb271f1667..f2bb2f9eaccf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8394,13 +8394,6 @@ F:	Documentation/power/freezing-of-tasks.rst
>  F:	include/linux/freezer.h
>  F:	kernel/freezer.c
>  
> -FRONTSWAP API
> -M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> -L:	linux-kernel@vger.kernel.org
> -S:	Maintained
> -F:	include/linux/frontswap.h
> -F:	mm/frontswap.c
> -
>  FS-CACHE: LOCAL CACHING FOR NETWORK FILESYSTEMS
>  M:	David Howells <dhowells@redhat.com>
>  L:	linux-cachefs@redhat.com (moderated for non-subscribers)
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 8dca4d6d96c7..74e3c3815696 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -17,6 +17,7 @@
>  #ifdef CONFIG_CMA
>  #include <linux/cma.h>
>  #endif
> +#include <linux/zswap.h>
>  #include <asm/page.h>
>  #include "internal.h"
>  
> diff --git a/include/linux/frontswap.h b/include/linux/frontswap.h
> deleted file mode 100644
> index eaa0ac5f9003..000000000000
> --- a/include/linux/frontswap.h
> +++ /dev/null
> @@ -1,91 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_FRONTSWAP_H
> -#define _LINUX_FRONTSWAP_H
> -
> -#include <linux/swap.h>
> -#include <linux/mm.h>
> -#include <linux/bitops.h>
> -#include <linux/jump_label.h>
> -
> -struct frontswap_ops {
> -	void (*init)(unsigned); /* this swap type was just swapon'ed */
> -	int (*store)(unsigned, pgoff_t, struct page *); /* store a page */
> -	int (*load)(unsigned, pgoff_t, struct page *, bool *); /* load a page */
> -	void (*invalidate_page)(unsigned, pgoff_t); /* page no longer needed */
> -	void (*invalidate_area)(unsigned); /* swap type just swapoff'ed */
> -};
> -
> -int frontswap_register_ops(const struct frontswap_ops *ops);
> -
> -extern void frontswap_init(unsigned type, unsigned long *map);
> -extern int __frontswap_store(struct page *page);
> -extern int __frontswap_load(struct page *page);
> -extern void __frontswap_invalidate_page(unsigned, pgoff_t);
> -extern void __frontswap_invalidate_area(unsigned);
> -
> -#ifdef CONFIG_FRONTSWAP
> -extern struct static_key_false frontswap_enabled_key;
> -
> -static inline bool frontswap_enabled(void)
> -{
> -	return static_branch_unlikely(&frontswap_enabled_key);
> -}
> -
> -static inline void frontswap_map_set(struct swap_info_struct *p,
> -				     unsigned long *map)
> -{
> -	p->frontswap_map = map;
> -}
> -
> -static inline unsigned long *frontswap_map_get(struct swap_info_struct *p)
> -{
> -	return p->frontswap_map;
> -}
> -#else
> -/* all inline routines become no-ops and all externs are ignored */
> -
> -static inline bool frontswap_enabled(void)
> -{
> -	return false;
> -}
> -
> -static inline void frontswap_map_set(struct swap_info_struct *p,
> -				     unsigned long *map)
> -{
> -}
> -
> -static inline unsigned long *frontswap_map_get(struct swap_info_struct *p)
> -{
> -	return NULL;
> -}
> -#endif
> -
> -static inline int frontswap_store(struct page *page)
> -{
> -	if (frontswap_enabled())
> -		return __frontswap_store(page);
> -
> -	return -1;
> -}
> -
> -static inline int frontswap_load(struct page *page)
> -{
> -	if (frontswap_enabled())
> -		return __frontswap_load(page);
> -
> -	return -1;
> -}
> -
> -static inline void frontswap_invalidate_page(unsigned type, pgoff_t offset)
> -{
> -	if (frontswap_enabled())
> -		__frontswap_invalidate_page(type, offset);
> -}
> -
> -static inline void frontswap_invalidate_area(unsigned type)
> -{
> -	if (frontswap_enabled())
> -		__frontswap_invalidate_area(type);
> -}
> -
> -#endif /* _LINUX_FRONTSWAP_H */
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 456546443f1f..bb5adc604144 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -302,10 +302,6 @@ struct swap_info_struct {
>  	struct file *swap_file;		/* seldom referenced */
>  	unsigned int old_block_size;	/* seldom referenced */
>  	struct completion comp;		/* seldom referenced */
> -#ifdef CONFIG_FRONTSWAP
> -	unsigned long *frontswap_map;	/* frontswap in-use, one bit per page */
> -	atomic_t frontswap_pages;	/* frontswap pages in-use counter */
> -#endif
>  	spinlock_t lock;		/*
>  					 * protect map scan related fields like
>  					 * swap_map, lowest_bit, highest_bit,
> @@ -630,11 +626,6 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
>  }
>  #endif
>  
> -#ifdef CONFIG_ZSWAP
> -extern u64 zswap_pool_total_size;
> -extern atomic_t zswap_stored_pages;
> -#endif
> -
>  #if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
>  void __folio_throttle_swaprate(struct folio *folio, gfp_t gfp);
>  static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
> diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
> index 7ed529a77c5b..99e3ed469e88 100644
> --- a/include/linux/swapfile.h
> +++ b/include/linux/swapfile.h
> @@ -2,11 +2,6 @@
>  #ifndef _LINUX_SWAPFILE_H
>  #define _LINUX_SWAPFILE_H
>  
> -/*
> - * these were static in swapfile.c but frontswap.c needs them and we don't
> - * want to expose them to the dozens of source files that include swap.h
> - */
> -extern struct swap_info_struct *swap_info[];
>  extern unsigned long generic_max_swapfile_size(void);
>  unsigned long arch_max_swapfile_size(void);
>  
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> new file mode 100644
> index 000000000000..850c377d9b6d
> --- /dev/null
> +++ b/include/linux/zswap.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ZSWAP_H
> +#define _LINUX_ZSWAP_H
> +
> +#include <linux/types.h>
> +#include <linux/mm_types.h>
> +
> +extern u64 zswap_pool_total_size;
> +extern atomic_t zswap_stored_pages;
> +
> +#ifdef CONFIG_ZSWAP
> +
> +bool zswap_store(struct page *page);
> +bool zswap_load(struct page *page);
> +void zswap_invalidate(int type, pgoff_t offset);
> +void zswap_swapon(int type);
> +void zswap_swapoff(int type);
> +
> +#else
> +
> +static inline bool zswap_store(struct page *page)
> +{
> +	return false;
> +}
> +
> +static inline bool zswap_load(struct page *page)
> +{
> +	return false;
> +}
> +
> +static inline void zswap_invalidate(int type, pgoff_t offset) {}
> +static inline void zswap_swapon(int type) {}
> +static inline void zswap_swapoff(int type) {}
> +
> +#endif
> +
> +#endif /* _LINUX_ZSWAP_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 09130434e30d..4ebc095590f6 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -25,7 +25,6 @@ menuconfig SWAP
>  config ZSWAP
>  	bool "Compressed cache for swap pages"
>  	depends on SWAP
> -	select FRONTSWAP
>  	select CRYPTO
>  	select ZPOOL
>  	help
> @@ -870,9 +869,6 @@ config USE_PERCPU_NUMA_NODE_ID
>  config HAVE_SETUP_PER_CPU_AREA
>  	bool
>  
> -config FRONTSWAP
> -	bool
> -
>  config CMA
>  	bool "Contiguous Memory Allocator"
>  	depends on MMU
> diff --git a/mm/Makefile b/mm/Makefile
> index 678530a07326..e6d9a1d5e84d 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -72,7 +72,6 @@ ifdef CONFIG_MMU
>  endif
>  
>  obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o swap_slots.o
> -obj-$(CONFIG_FRONTSWAP)	+= frontswap.o
>  obj-$(CONFIG_ZSWAP)	+= zswap.o
>  obj-$(CONFIG_HAS_DMA)	+= dmapool.o
>  obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
> diff --git a/mm/frontswap.c b/mm/frontswap.c
> deleted file mode 100644
> index 2fb5df3384b8..000000000000
> --- a/mm/frontswap.c
> +++ /dev/null
> @@ -1,283 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Frontswap frontend
> - *
> - * This code provides the generic "frontend" layer to call a matching
> - * "backend" driver implementation of frontswap.  See
> - * Documentation/mm/frontswap.rst for more information.
> - *
> - * Copyright (C) 2009-2012 Oracle Corp.  All rights reserved.
> - * Author: Dan Magenheimer
> - */
> -
> -#include <linux/mman.h>
> -#include <linux/swap.h>
> -#include <linux/swapops.h>
> -#include <linux/security.h>
> -#include <linux/module.h>
> -#include <linux/debugfs.h>
> -#include <linux/frontswap.h>
> -#include <linux/swapfile.h>
> -
> -DEFINE_STATIC_KEY_FALSE(frontswap_enabled_key);
> -
> -/*
> - * frontswap_ops are added by frontswap_register_ops, and provide the
> - * frontswap "backend" implementation functions.  Multiple implementations
> - * may be registered, but implementations can never deregister.  This
> - * is a simple singly-linked list of all registered implementations.
> - */
> -static const struct frontswap_ops *frontswap_ops __read_mostly;
> -
> -#ifdef CONFIG_DEBUG_FS
> -/*
> - * Counters available via /sys/kernel/debug/frontswap (if debugfs is
> - * properly configured).  These are for information only so are not protected
> - * against increment races.
> - */
> -static u64 frontswap_loads;
> -static u64 frontswap_succ_stores;
> -static u64 frontswap_failed_stores;
> -static u64 frontswap_invalidates;
> -
> -static inline void inc_frontswap_loads(void)
> -{
> -	data_race(frontswap_loads++);
> -}
> -static inline void inc_frontswap_succ_stores(void)
> -{
> -	data_race(frontswap_succ_stores++);
> -}
> -static inline void inc_frontswap_failed_stores(void)
> -{
> -	data_race(frontswap_failed_stores++);
> -}
> -static inline void inc_frontswap_invalidates(void)
> -{
> -	data_race(frontswap_invalidates++);
> -}
> -#else
> -static inline void inc_frontswap_loads(void) { }
> -static inline void inc_frontswap_succ_stores(void) { }
> -static inline void inc_frontswap_failed_stores(void) { }
> -static inline void inc_frontswap_invalidates(void) { }
> -#endif
> -
> -/*
> - * Due to the asynchronous nature of the backends loading potentially
> - * _after_ the swap system has been activated, we have chokepoints
> - * on all frontswap functions to not call the backend until the backend
> - * has registered.
> - *
> - * This would not guards us against the user deciding to call swapoff right as
> - * we are calling the backend to initialize (so swapon is in action).
> - * Fortunately for us, the swapon_mutex has been taken by the callee so we are
> - * OK. The other scenario where calls to frontswap_store (called via
> - * swap_writepage) is racing with frontswap_invalidate_area (called via
> - * swapoff) is again guarded by the swap subsystem.
> - *
> - * While no backend is registered all calls to frontswap_[store|load|
> - * invalidate_area|invalidate_page] are ignored or fail.
> - *
> - * The time between the backend being registered and the swap file system
> - * calling the backend (via the frontswap_* functions) is indeterminate as
> - * frontswap_ops is not atomic_t (or a value guarded by a spinlock).
> - * That is OK as we are comfortable missing some of these calls to the newly
> - * registered backend.
> - *
> - * Obviously the opposite (unloading the backend) must be done after all
> - * the frontswap_[store|load|invalidate_area|invalidate_page] start
> - * ignoring or failing the requests.  However, there is currently no way
> - * to unload a backend once it is registered.
> - */
> -
> -/*
> - * Register operations for frontswap
> - */
> -int frontswap_register_ops(const struct frontswap_ops *ops)
> -{
> -	if (frontswap_ops)
> -		return -EINVAL;
> -
> -	frontswap_ops = ops;
> -	static_branch_inc(&frontswap_enabled_key);
> -	return 0;
> -}
> -
> -/*
> - * Called when a swap device is swapon'd.
> - */
> -void frontswap_init(unsigned type, unsigned long *map)
> -{
> -	struct swap_info_struct *sis = swap_info[type];
> -
> -	VM_BUG_ON(sis == NULL);
> -
> -	/*
> -	 * p->frontswap is a bitmap that we MUST have to figure out which page
> -	 * has gone in frontswap. Without it there is no point of continuing.
> -	 */
> -	if (WARN_ON(!map))
> -		return;
> -	/*
> -	 * Irregardless of whether the frontswap backend has been loaded
> -	 * before this function or it will be later, we _MUST_ have the
> -	 * p->frontswap set to something valid to work properly.
> -	 */
> -	frontswap_map_set(sis, map);
> -
> -	if (!frontswap_enabled())
> -		return;
> -	frontswap_ops->init(type);
> -}
> -
> -static bool __frontswap_test(struct swap_info_struct *sis,
> -				pgoff_t offset)
> -{
> -	if (sis->frontswap_map)
> -		return test_bit(offset, sis->frontswap_map);
> -	return false;
> -}
> -
> -static inline void __frontswap_set(struct swap_info_struct *sis,
> -				   pgoff_t offset)
> -{
> -	set_bit(offset, sis->frontswap_map);
> -	atomic_inc(&sis->frontswap_pages);
> -}
> -
> -static inline void __frontswap_clear(struct swap_info_struct *sis,
> -				     pgoff_t offset)
> -{
> -	clear_bit(offset, sis->frontswap_map);
> -	atomic_dec(&sis->frontswap_pages);
> -}
> -
> -/*
> - * "Store" data from a page to frontswap and associate it with the page's
> - * swaptype and offset.  Page must be locked and in the swap cache.
> - * If frontswap already contains a page with matching swaptype and
> - * offset, the frontswap implementation may either overwrite the data and
> - * return success or invalidate the page from frontswap and return failure.
> - */
> -int __frontswap_store(struct page *page)
> -{
> -	int ret = -1;
> -	swp_entry_t entry = { .val = page_private(page), };
> -	int type = swp_type(entry);
> -	struct swap_info_struct *sis = swap_info[type];
> -	pgoff_t offset = swp_offset(entry);
> -
> -	VM_BUG_ON(!frontswap_ops);
> -	VM_BUG_ON(!PageLocked(page));
> -	VM_BUG_ON(sis == NULL);
> -
> -	/*
> -	 * If a dup, we must remove the old page first; we can't leave the
> -	 * old page no matter if the store of the new page succeeds or fails,
> -	 * and we can't rely on the new page replacing the old page as we may
> -	 * not store to the same implementation that contains the old page.
> -	 */
> -	if (__frontswap_test(sis, offset)) {
> -		__frontswap_clear(sis, offset);
> -		frontswap_ops->invalidate_page(type, offset);
> -	}
> -
> -	ret = frontswap_ops->store(type, offset, page);
> -	if (ret == 0) {
> -		__frontswap_set(sis, offset);
> -		inc_frontswap_succ_stores();
> -	} else {
> -		inc_frontswap_failed_stores();
> -	}
> -
> -	return ret;
> -}
> -
> -/*
> - * "Get" data from frontswap associated with swaptype and offset that were
> - * specified when the data was put to frontswap and use it to fill the
> - * specified page with data. Page must be locked and in the swap cache.
> - */
> -int __frontswap_load(struct page *page)
> -{
> -	int ret = -1;
> -	swp_entry_t entry = { .val = page_private(page), };
> -	int type = swp_type(entry);
> -	struct swap_info_struct *sis = swap_info[type];
> -	pgoff_t offset = swp_offset(entry);
> -	bool exclusive = false;
> -
> -	VM_BUG_ON(!frontswap_ops);
> -	VM_BUG_ON(!PageLocked(page));
> -	VM_BUG_ON(sis == NULL);
> -
> -	if (!__frontswap_test(sis, offset))
> -		return -1;
> -
> -	/* Try loading from each implementation, until one succeeds. */
> -	ret = frontswap_ops->load(type, offset, page, &exclusive);
> -	if (ret == 0) {
> -		inc_frontswap_loads();
> -		if (exclusive) {
> -			SetPageDirty(page);
> -			__frontswap_clear(sis, offset);
> -		}
> -	}
> -	return ret;
> -}
> -
> -/*
> - * Invalidate any data from frontswap associated with the specified swaptype
> - * and offset so that a subsequent "get" will fail.
> - */
> -void __frontswap_invalidate_page(unsigned type, pgoff_t offset)
> -{
> -	struct swap_info_struct *sis = swap_info[type];
> -
> -	VM_BUG_ON(!frontswap_ops);
> -	VM_BUG_ON(sis == NULL);
> -
> -	if (!__frontswap_test(sis, offset))
> -		return;
> -
> -	frontswap_ops->invalidate_page(type, offset);
> -	__frontswap_clear(sis, offset);
> -	inc_frontswap_invalidates();
> -}
> -
> -/*
> - * Invalidate all data from frontswap associated with all offsets for the
> - * specified swaptype.
> - */
> -void __frontswap_invalidate_area(unsigned type)
> -{
> -	struct swap_info_struct *sis = swap_info[type];
> -
> -	VM_BUG_ON(!frontswap_ops);
> -	VM_BUG_ON(sis == NULL);
> -
> -	if (sis->frontswap_map == NULL)
> -		return;
> -
> -	frontswap_ops->invalidate_area(type);
> -	atomic_set(&sis->frontswap_pages, 0);
> -	bitmap_zero(sis->frontswap_map, sis->max);
> -}
> -
> -static int __init init_frontswap(void)
> -{
> -#ifdef CONFIG_DEBUG_FS
> -	struct dentry *root = debugfs_create_dir("frontswap", NULL);
> -	if (root == NULL)
> -		return -ENXIO;
> -	debugfs_create_u64("loads", 0444, root, &frontswap_loads);
> -	debugfs_create_u64("succ_stores", 0444, root, &frontswap_succ_stores);
> -	debugfs_create_u64("failed_stores", 0444, root,
> -			   &frontswap_failed_stores);
> -	debugfs_create_u64("invalidates", 0444, root, &frontswap_invalidates);
> -#endif
> -	return 0;
> -}
> -
> -module_init(init_frontswap);
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 684cd3c7b59b..32afc2a52982 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -19,12 +19,12 @@
>  #include <linux/bio.h>
>  #include <linux/swapops.h>
>  #include <linux/writeback.h>
> -#include <linux/frontswap.h>
>  #include <linux/blkdev.h>
>  #include <linux/psi.h>
>  #include <linux/uio.h>
>  #include <linux/sched/task.h>
>  #include <linux/delayacct.h>
> +#include <linux/zswap.h>
>  #include "swap.h"
>  
>  static void __end_swap_bio_write(struct bio *bio)
> @@ -198,7 +198,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>  		folio_unlock(folio);
>  		return ret;
>  	}
> -	if (frontswap_store(&folio->page) == 0) {
> +	if (zswap_store(&folio->page)) {
>  		folio_start_writeback(folio);
>  		folio_unlock(folio);
>  		folio_end_writeback(folio);
> @@ -515,7 +515,7 @@ void swap_readpage(struct page *page, bool synchronous, struct swap_iocb **plug)
>  	}
>  	delayacct_swapin_start();
>  
> -	if (frontswap_load(page) == 0) {
> +	if (zswap_load(page)) {
>  		SetPageUptodate(page);
>  		unlock_page(page);
>  	} else if (data_race(sis->flags & SWP_FS_OPS)) {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 8e6dde68b389..38cd4dc4b2e7 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -35,13 +35,13 @@
>  #include <linux/memcontrol.h>
>  #include <linux/poll.h>
>  #include <linux/oom.h>
> -#include <linux/frontswap.h>
>  #include <linux/swapfile.h>
>  #include <linux/export.h>
>  #include <linux/swap_slots.h>
>  #include <linux/sort.h>
>  #include <linux/completion.h>
>  #include <linux/suspend.h>
> +#include <linux/zswap.h>
>  
>  #include <asm/tlbflush.h>
>  #include <linux/swapops.h>
> @@ -95,7 +95,7 @@ static PLIST_HEAD(swap_active_head);
>  static struct plist_head *swap_avail_heads;
>  static DEFINE_SPINLOCK(swap_avail_lock);
>  
> -struct swap_info_struct *swap_info[MAX_SWAPFILES];
> +static struct swap_info_struct *swap_info[MAX_SWAPFILES];
>  
>  static DEFINE_MUTEX(swapon_mutex);
>  
> @@ -746,7 +746,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>  		swap_slot_free_notify = NULL;
>  	while (offset <= end) {
>  		arch_swap_invalidate_page(si->type, offset);
> -		frontswap_invalidate_page(si->type, offset);
> +		zswap_invalidate(si->type, offset);
>  		if (swap_slot_free_notify)
>  			swap_slot_free_notify(si->bdev, offset);
>  		offset++;
> @@ -2335,11 +2335,10 @@ static void _enable_swap_info(struct swap_info_struct *p)
>  
>  static void enable_swap_info(struct swap_info_struct *p, int prio,
>  				unsigned char *swap_map,
> -				struct swap_cluster_info *cluster_info,
> -				unsigned long *frontswap_map)
> +				struct swap_cluster_info *cluster_info)
>  {
> -	if (IS_ENABLED(CONFIG_FRONTSWAP))
> -		frontswap_init(p->type, frontswap_map);
> +	zswap_swapon(p->type);
> +
>  	spin_lock(&swap_lock);
>  	spin_lock(&p->lock);
>  	setup_swap_info(p, prio, swap_map, cluster_info);
> @@ -2382,7 +2381,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  	struct swap_info_struct *p = NULL;
>  	unsigned char *swap_map;
>  	struct swap_cluster_info *cluster_info;
> -	unsigned long *frontswap_map;
>  	struct file *swap_file, *victim;
>  	struct address_space *mapping;
>  	struct inode *inode;
> @@ -2507,12 +2505,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  	p->swap_map = NULL;
>  	cluster_info = p->cluster_info;
>  	p->cluster_info = NULL;
> -	frontswap_map = frontswap_map_get(p);
>  	spin_unlock(&p->lock);
>  	spin_unlock(&swap_lock);
>  	arch_swap_invalidate_area(p->type);
> -	frontswap_invalidate_area(p->type);
> -	frontswap_map_set(p, NULL);
> +	zswap_swapoff(p->type);
>  	mutex_unlock(&swapon_mutex);
>  	free_percpu(p->percpu_cluster);
>  	p->percpu_cluster = NULL;
> @@ -2520,7 +2516,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  	p->cluster_next_cpu = NULL;
>  	vfree(swap_map);
>  	kvfree(cluster_info);
> -	kvfree(frontswap_map);
>  	/* Destroy swap account information */
>  	swap_cgroup_swapoff(p->type);
>  	exit_swap_address_space(p->type);
> @@ -2987,7 +2982,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	unsigned long maxpages;
>  	unsigned char *swap_map = NULL;
>  	struct swap_cluster_info *cluster_info = NULL;
> -	unsigned long *frontswap_map = NULL;
>  	struct page *page = NULL;
>  	struct inode *inode = NULL;
>  	bool inced_nr_rotate_swap = false;
> @@ -3127,11 +3121,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		error = nr_extents;
>  		goto bad_swap_unlock_inode;
>  	}
> -	/* frontswap enabled? set up bit-per-page map for frontswap */
> -	if (IS_ENABLED(CONFIG_FRONTSWAP))
> -		frontswap_map = kvcalloc(BITS_TO_LONGS(maxpages),
> -					 sizeof(long),
> -					 GFP_KERNEL);
>  
>  	if ((swap_flags & SWAP_FLAG_DISCARD) &&
>  	    p->bdev && bdev_max_discard_sectors(p->bdev)) {
> @@ -3184,16 +3173,15 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	if (swap_flags & SWAP_FLAG_PREFER)
>  		prio =
>  		  (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_SHIFT;
> -	enable_swap_info(p, prio, swap_map, cluster_info, frontswap_map);
> +	enable_swap_info(p, prio, swap_map, cluster_info);
>  
> -	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s\n",
> +	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
>  		p->pages<<(PAGE_SHIFT-10), name->name, p->prio,
>  		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
>  		(p->flags & SWP_SOLIDSTATE) ? "SS" : "",
>  		(p->flags & SWP_DISCARDABLE) ? "D" : "",
>  		(p->flags & SWP_AREA_DISCARD) ? "s" : "",
> -		(p->flags & SWP_PAGE_DISCARD) ? "c" : "",
> -		(frontswap_map) ? "FS" : "");
> +		(p->flags & SWP_PAGE_DISCARD) ? "c" : "");
>  
>  	mutex_unlock(&swapon_mutex);
>  	atomic_inc(&proc_poll_event);
> @@ -3223,7 +3211,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	spin_unlock(&swap_lock);
>  	vfree(swap_map);
>  	kvfree(cluster_info);
> -	kvfree(frontswap_map);
>  	if (inced_nr_rotate_swap)
>  		atomic_dec(&nr_rotate_swap);
>  	if (swap_file)
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 62195f72bf56..1b0128060792 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -2,7 +2,7 @@
>  /*
>   * zswap.c - zswap driver file
>   *
> - * zswap is a backend for frontswap that takes pages that are in the process
> + * zswap is a cache that takes pages that are in the process
>   * of being swapped out and attempts to compress and store them in a
>   * RAM-based memory pool.  This can result in a significant I/O reduction on
>   * the swap device and, in the case where decompressing from RAM is faster
> @@ -20,7 +20,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  #include <linux/atomic.h>
> -#include <linux/frontswap.h>
>  #include <linux/rbtree.h>
>  #include <linux/swap.h>
>  #include <linux/crypto.h>
> @@ -1061,7 +1060,7 @@ static int zswap_get_swap_cache_page(swp_entry_t entry,
>   *
>   * This can be thought of as a "resumed writeback" of the page
>   * to the swap device.  We are basically resuming the same swap
> - * writeback path that was intercepted with the frontswap_store()
> + * writeback path that was intercepted with the zswap_store()
>   * in the first place.  After the page has been decompressed into
>   * the swap cache, the compressed version stored by zswap can be
>   * freed.
> @@ -1201,36 +1200,33 @@ static void zswap_fill_page(void *ptr, unsigned long value)
>  	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
>  }
>  
> -/*********************************
> -* frontswap hooks
> -**********************************/
> -/* attempts to compress and store an single page */
> -static int zswap_frontswap_store(unsigned type, pgoff_t offset,
> -				struct page *page)
> +bool zswap_store(struct page *page)
>  {
> +	swp_entry_t swp = { .val = page_private(page), };
> +	int type = swp_type(swp);
> +	pgoff_t offset = swp_offset(swp);
>  	struct zswap_tree *tree = zswap_trees[type];
>  	struct zswap_entry *entry, *dupentry;
>  	struct scatterlist input, output;
>  	struct crypto_acomp_ctx *acomp_ctx;
>  	struct obj_cgroup *objcg = NULL;
>  	struct zswap_pool *pool;
> -	int ret;
>  	unsigned int dlen = PAGE_SIZE;
>  	unsigned long handle, value;
>  	char *buf;
>  	u8 *src, *dst;
>  	gfp_t gfp;
> +	int ret;
> +
> +	VM_WARN_ON_ONCE(!PageLocked(page));
> +	VM_WARN_ON_ONCE(!PageSwapCache(page));
>  
>  	/* THP isn't supported */
> -	if (PageTransHuge(page)) {
> -		ret = -EINVAL;
> -		goto reject;
> -	}
> +	if (PageTransHuge(page))
> +		return false;
>  
> -	if (!zswap_enabled || !tree) {
> -		ret = -ENODEV;
> -		goto reject;
> -	}
> +	if (!zswap_enabled || !tree)
> +		return false;
>  
>  	/*
>  	 * XXX: zswap reclaim does not work with cgroups yet. Without a
> @@ -1238,10 +1234,8 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>  	 * local cgroup limits.
>  	 */
>  	objcg = get_obj_cgroup_from_page(page);
> -	if (objcg && !obj_cgroup_may_zswap(objcg)) {
> -		ret = -ENOMEM;
> +	if (objcg && !obj_cgroup_may_zswap(objcg))
>  		goto reject;
> -	}
>  
>  	/* reclaim space if needed */
>  	if (zswap_is_full()) {
> @@ -1251,10 +1245,9 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>  	}
>  
>  	if (zswap_pool_reached_full) {
> -	       if (!zswap_can_accept()) {
> -			ret = -ENOMEM;
> +	       if (!zswap_can_accept())
>  			goto shrink;
> -		} else
> +		else
>  			zswap_pool_reached_full = false;
>  	}
>  
> @@ -1262,7 +1255,6 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>  	entry = zswap_entry_cache_alloc(GFP_KERNEL);
>  	if (!entry) {
>  		zswap_reject_kmemcache_fail++;
> -		ret = -ENOMEM;
>  		goto reject;
>  	}
>  
> @@ -1279,17 +1271,13 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>  		kunmap_atomic(src);
>  	}
>  
> -	if (!zswap_non_same_filled_pages_enabled) {
> -		ret = -EINVAL;
> +	if (!zswap_non_same_filled_pages_enabled)
>  		goto freepage;
> -	}
>  
>  	/* if entry is successfully added, it keeps the reference */
>  	entry->pool = zswap_pool_current_get();
> -	if (!entry->pool) {
> -		ret = -EINVAL;
> +	if (!entry->pool)
>  		goto freepage;
> -	}
>  
>  	/* compress */
>  	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
> @@ -1309,19 +1297,17 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>  	 * synchronous in fact.
>  	 * Theoretically, acomp supports users send multiple acomp requests in one
>  	 * acomp instance, then get those requests done simultaneously. but in this
> -	 * case, frontswap actually does store and load page by page, there is no
> +	 * case, zswap actually does store and load page by page, there is no
>  	 * existing method to send the second page before the first page is done
> -	 * in one thread doing frontswap.
> +	 * in one thread doing zwap.
>  	 * but in different threads running on different cpu, we have different
>  	 * acomp instance, so multiple threads can do (de)compression in parallel.
>  	 */
>  	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
>  	dlen = acomp_ctx->req->dlen;
>  
> -	if (ret) {
> -		ret = -EINVAL;
> +	if (ret)
>  		goto put_dstmem;
> -	}
>  
>  	/* store */
>  	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> @@ -1356,15 +1342,12 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>  
>  	/* map */
>  	spin_lock(&tree->lock);
> -	do {
> -		ret = zswap_rb_insert(&tree->rbroot, entry, &dupentry);
> -		if (ret == -EEXIST) {
> -			zswap_duplicate_entry++;
> -			/* remove from rbtree */
> -			zswap_rb_erase(&tree->rbroot, dupentry);
> -			zswap_entry_put(tree, dupentry);
> -		}
> -	} while (ret == -EEXIST);
> +	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> +		zswap_duplicate_entry++;
> +		/* remove from rbtree */
> +		zswap_rb_erase(&tree->rbroot, dupentry);
> +		zswap_entry_put(tree, dupentry);
> +	}
>  	if (entry->length) {
>  		spin_lock(&entry->pool->lru_lock);
>  		list_add(&entry->lru, &entry->pool->lru);
> @@ -1377,7 +1360,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>  	zswap_update_total_size();
>  	count_vm_event(ZSWPOUT);
>  
> -	return 0;
> +	return true;
>  
>  put_dstmem:
>  	mutex_unlock(acomp_ctx->mutex);
> @@ -1387,30 +1370,30 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>  reject:
>  	if (objcg)
>  		obj_cgroup_put(objcg);
> -	return ret;
> +	return false;
>  
>  shrink:
>  	pool = zswap_pool_last_get();
>  	if (pool)
>  		queue_work(shrink_wq, &pool->shrink_work);
> -	ret = -ENOMEM;
>  	goto reject;
>  }
>  
> -/*
> - * returns 0 if the page was successfully decompressed
> - * return -1 on entry not found or error
> -*/
> -static int zswap_frontswap_load(unsigned type, pgoff_t offset,
> -				struct page *page, bool *exclusive)
> +bool zswap_load(struct page *page)
>  {
> +	swp_entry_t swp = { .val = page_private(page), };
> +	int type = swp_type(swp);
> +	pgoff_t offset = swp_offset(swp);
>  	struct zswap_tree *tree = zswap_trees[type];
>  	struct zswap_entry *entry;
>  	struct scatterlist input, output;
>  	struct crypto_acomp_ctx *acomp_ctx;
>  	u8 *src, *dst, *tmp;
>  	unsigned int dlen;
> -	int ret;
> +	bool ret;
> +
> +	VM_WARN_ON_ONCE(!PageLocked(page));
> +	VM_WARN_ON_ONCE(!PageSwapCache(page));
>  
>  	/* find */
>  	spin_lock(&tree->lock);
> @@ -1418,7 +1401,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>  	if (!entry) {
>  		/* entry was written back */
>  		spin_unlock(&tree->lock);
> -		return -1;
> +		return false;
>  	}
>  	spin_unlock(&tree->lock);
>  
> @@ -1426,14 +1409,14 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>  		dst = kmap_atomic(page);
>  		zswap_fill_page(dst, entry->value);
>  		kunmap_atomic(dst);
> -		ret = 0;
> +		ret = true;
>  		goto stats;
>  	}
>  
>  	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
>  		tmp = kmalloc(entry->length, GFP_KERNEL);
>  		if (!tmp) {
> -			ret = -ENOMEM;
> +			ret = false;
>  			goto freeentry;
>  		}
>  	}
> @@ -1454,7 +1437,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>  	sg_init_table(&output, 1);
>  	sg_set_page(&output, page, PAGE_SIZE, 0);
>  	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
> -	ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
> +	if (crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait))
> +		WARN_ON(1);
>  	mutex_unlock(acomp_ctx->mutex);
>  
>  	if (zpool_can_sleep_mapped(entry->pool->zpool))
> @@ -1462,16 +1446,16 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>  	else
>  		kfree(tmp);
>  
> -	BUG_ON(ret);
> +	ret = true;
>  stats:
>  	count_vm_event(ZSWPIN);
>  	if (entry->objcg)
>  		count_objcg_event(entry->objcg, ZSWPIN);
>  freeentry:
>  	spin_lock(&tree->lock);
> -	if (!ret && zswap_exclusive_loads_enabled) {
> +	if (ret && zswap_exclusive_loads_enabled) {
>  		zswap_invalidate_entry(tree, entry);
> -		*exclusive = true;
> +		SetPageDirty(page);
>  	} else if (entry->length) {
>  		spin_lock(&entry->pool->lru_lock);
>  		list_move(&entry->lru, &entry->pool->lru);
> @@ -1483,8 +1467,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>  	return ret;
>  }
>  
> -/* frees an entry in zswap */
> -static void zswap_frontswap_invalidate_page(unsigned type, pgoff_t offset)
> +void zswap_invalidate(int type, pgoff_t offset)
>  {
>  	struct zswap_tree *tree = zswap_trees[type];
>  	struct zswap_entry *entry;
> @@ -1501,8 +1484,22 @@ static void zswap_frontswap_invalidate_page(unsigned type, pgoff_t offset)
>  	spin_unlock(&tree->lock);
>  }
>  
> -/* frees all zswap entries for the given swap type */
> -static void zswap_frontswap_invalidate_area(unsigned type)
> +void zswap_swapon(int type)
> +{
> +	struct zswap_tree *tree;
> +
> +	tree = kzalloc(sizeof(*tree), GFP_KERNEL);
> +	if (!tree) {
> +		pr_err("alloc failed, zswap disabled for swap type %d\n", type);
> +		return;
> +	}
> +
> +	tree->rbroot = RB_ROOT;
> +	spin_lock_init(&tree->lock);
> +	zswap_trees[type] = tree;
> +}
> +
> +void zswap_swapoff(int type)
>  {
>  	struct zswap_tree *tree = zswap_trees[type];
>  	struct zswap_entry *entry, *n;
> @@ -1520,29 +1517,6 @@ static void zswap_frontswap_invalidate_area(unsigned type)
>  	zswap_trees[type] = NULL;
>  }
>  
> -static void zswap_frontswap_init(unsigned type)
> -{
> -	struct zswap_tree *tree;
> -
> -	tree = kzalloc(sizeof(*tree), GFP_KERNEL);
> -	if (!tree) {
> -		pr_err("alloc failed, zswap disabled for swap type %d\n", type);
> -		return;
> -	}
> -
> -	tree->rbroot = RB_ROOT;
> -	spin_lock_init(&tree->lock);
> -	zswap_trees[type] = tree;
> -}
> -
> -static const struct frontswap_ops zswap_frontswap_ops = {
> -	.store = zswap_frontswap_store,
> -	.load = zswap_frontswap_load,
> -	.invalidate_page = zswap_frontswap_invalidate_page,
> -	.invalidate_area = zswap_frontswap_invalidate_area,
> -	.init = zswap_frontswap_init
> -};
> -
>  /*********************************
>  * debugfs functions
>  **********************************/
> @@ -1631,16 +1605,11 @@ static int zswap_setup(void)
>  	if (!shrink_wq)
>  		goto fallback_fail;
>  
> -	ret = frontswap_register_ops(&zswap_frontswap_ops);
> -	if (ret)
> -		goto destroy_wq;
>  	if (zswap_debugfs_init())
>  		pr_warn("debugfs initialization failed\n");
>  	zswap_init_state = ZSWAP_INIT_SUCCEED;
>  	return 0;
>  
> -destroy_wq:
> -	destroy_workqueue(shrink_wq);
>  fallback_fail:
>  	if (pool)
>  		zswap_pool_destroy(pool);
> -- 
> 2.41.0
> 
