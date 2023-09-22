Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617F07AA642
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjIVBAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIVBAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:00:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F9CF5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:00:35 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LIst5f013433;
        Fri, 22 Sep 2023 01:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PBmMLnVY+RCRDegttix1UpMDz8GMoHaa6RuFTo5kOys=;
 b=tIdApx424sxnPODS7PlQW+c6MBkimRGPiCovXP4IAl8wYE8hNp9Q9rM1BJ5ynaapmRKr
 3RWDRCfInDbtT78aheyI1By0AyNflXotnECfA3tfjpuBAypsWFiS4hmLiQ5kDXyOJD7p
 WE8Dmm8xKsC1fOagxlVDQYCsTBy/hdXRf1lb4e2oJ6ADvAzoHKF0Wma4uMY1rDEUMTFT
 P35TySWltn9kvHc2ZzIWagUj/hX+8ynPN1u/TeUUwVGdvGfWQpwCgNKJPVDp8RmQjW/j
 u/R4Dh+Y5GqpAziucs2OmQSiXdoSWgYqhvmCzLXal4cdXV+9PsXLufsost5SgT7h5nRo +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt1gjhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 01:00:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LMi6Pg040535;
        Fri, 22 Sep 2023 01:00:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u19bfbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 01:00:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hruwrNJ/6e/gxQRLZLhid0K3z2odOnP1GOzs/YbbcuNjZXlWnrAKqqccz/8k+gx5EeY2JbNSbiUPjuHLNdUpp0xr9oXsF6e/cjOW7SpGq6mbeSM6fsOFts/qmvW2jNlK7/r6UyoTOgx6R+I/8ewlvemHBSbXM1mQHPuKLyMVNw4G/4lP0MbiE/gUQXxmRfHrMvua9/NgGTEwyzQF2CLrHKPp31v6dQx6zW91DGMqHF/3UWyHqv+8Vi3bQ4vs+Abj/TM9xkcRvvtPlT3VXkFv4zUzIBYcIPZl9DKV3h1Nc66JTOZQRdtH5+xoa/DTWUvMsa3X9UW0WGXdS54vF2+IFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBmMLnVY+RCRDegttix1UpMDz8GMoHaa6RuFTo5kOys=;
 b=KSamadO7ZSB3d4MdhDp1pDTVY6dH8L1JmkreuVpjDSa3ZpwAmnkDkNYl5AjBFXpP4NI73L95lKTf4rjdeyVJ9hM2yWb4XiXOogtpeB6PEqJpl3VydIPTlWC3VqzeFPF2s7dfrkhsNAx6eWZrDbdtTyBGVhHaWITmlKk7tbD6rp7BLtbTTLC6z1Jr5VQ31CAh9uKzRXouavraiz7lLdppx2JQleAZkTPoup2V2TnYjoDvvpT9lwwztqXPKVIPFBwQc2Db8VlSFvZ5f8AvgI1GG/rYXOJcPgFtMgW+/CmJhaa9XMHBwyDHK7gt+NwfhQ8nb8pKz9dc1dV5n2S6iYNAMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBmMLnVY+RCRDegttix1UpMDz8GMoHaa6RuFTo5kOys=;
 b=GSga+NXaE/mFvDL7TtPbpZaSOdiYqoXOSFIE7VCHMgbKSHJHqZiIUbib1QuTkPnEaaRGSupAl4TG1Lt3lXUbRueUDodivbFFYLnfqZUuEoe7Oui/JP7DjbyzLzEH0dm65kALWpxoY0bf4V1V4yfaMBzY3vOQJos+QEk3l7iKA3k=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by PH7PR10MB6457.namprd10.prod.outlook.com (2603:10b6:510:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 22 Sep
 2023 01:00:18 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::cf08:500b:afd9:981c]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::cf08:500b:afd9:981c%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 01:00:18 +0000
Message-ID: <48c5e937-f9c2-327d-c823-a91826ed146f@oracle.com>
Date:   Thu, 21 Sep 2023 20:00:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, ebiederm@xmission.com,
        kexec@lists.infradead.org, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230921215938.2192-1-eric.devolder@oracle.com>
 <20230921172243.d86a649d7afc835ff2caac26@linux-foundation.org>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20230921172243.d86a649d7afc835ff2caac26@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::9) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:EE_|PH7PR10MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 151e7b1f-f69e-4b36-b2b3-08dbbb07499e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6YlwpfeNXptpGx3Wyg089oWc4R4zdiOyzermT6SyGoH3CeC5hhOA70V70HpQg4LoE1V6Ph7pQkLe5lRY5iQyIL61bxw32k5LepjM+B7r1mcxpHaHLpL0PmMOCw6LVHE25/xayV5dDkrHN/hYL36EUQamB0vfrmRA3fz2K0kTeMe0PDKfiVgYGBCeELm0A2oBEbFKj3B5IF4NCt9/r19DPx2PUoCJBMw4T+JTibxEOG9Ayc5cAuKdTHNQlp6kEOiqy5yOyFqLafieXqJnM7dVncfMoc2cWHfmUlYtPxMOw+AB+yArI+L68yJXQ+w06hwaK858d5Whg4xSGPSdIWFWTywk4JbL1RQ1Xmd/BYi/Vgks5qF1S7Qh+RLFjmZa9k8uf2HIEMJRmWodmQJRPXCuI6FKw9f2dj8vXLjNXsPgJCVeH+Zqetw5IzepIVlF4BGZETr6nPNzMH6RB9TeydIFI+ERLW++6wSgKond45AzQ/7ybLFQUsCJeYcQPeVHyymzRvQsFnbKsB8/EfOTDrfZ66SebKySOPdGjqI6herihKfenase0RcM9QXZezSKiowmqhPuJaSkPt5hv4RajP4asagFeYIXyH/ktO7yVublEg2ppM6faddYzFj4gjMTZAMj37qVt2b3N+HwK1U/jq76A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(186009)(1800799009)(451199024)(83380400001)(38100700002)(6512007)(2616005)(26005)(31696002)(66946007)(4326008)(6916009)(8676002)(107886003)(53546011)(8936002)(66476007)(316002)(41300700001)(66556008)(2906002)(5660300002)(86362001)(4744005)(6666004)(6506007)(36756003)(6486002)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJ2b05CMFlJV3k4Uzl0U21TOWZOQ040cXNXQlVOTWhJbFVDT3RRVWVnbHFw?=
 =?utf-8?B?c09hQjVobmdNQUtlaHB3R2JLeGs0QmVzKzlBeWtFVHIrWjU2ZEtOWHB5UDR1?=
 =?utf-8?B?Ry9tRGQzYUl2ejliNXAzWCs0VGMxTFdta281VHBZdnVjYVdRWVd2WnBQYnpV?=
 =?utf-8?B?WFFscmwzOUNBTE9QNWRHdTU4MG0relQ5MGpLNmwyRk45dWpNaWNvSkN5Q1A0?=
 =?utf-8?B?dU1KODcwYlRDQjU2ZW9lOUhWeFdGRWtqQlZBS0ZGckdzQW5DZ1hPUlFyZVpk?=
 =?utf-8?B?ODV5TlIvakdDQ0RXQkd1Uk9zQlRLZFFsS25IQ3BVWjBkSVpOZTFlTkhZMXBh?=
 =?utf-8?B?UVN3UFdjYThQL3c5K2IydzRlcEQ1MURzVlpwd3NXWU5WRXNibVBCZzNhTGdk?=
 =?utf-8?B?Q1Z5UTh0RmQyOWtDM3pOb3d2L0NvWE9ncXJqSzdyU0poZmdKdG5MMUVDSFBJ?=
 =?utf-8?B?aWVxL3pabWNPU0Q3NkVQQkNGbXltbjNqRHF0SjNUQzFCWDN2dHlvcDJ1engy?=
 =?utf-8?B?MTdKK3FXcjZsUHY0UFVDd0lyNjBQclhOYkhBbm5hRDh3ZjhxY2VHNW5rQUEz?=
 =?utf-8?B?THlJanZwRDFEZXp0alJ2UW9XSXVRWmZFR1RQV0ZBcXhPZ1VaU3dzcnJXWGZq?=
 =?utf-8?B?WHdDVTJMZjZmTEsrUVRnYzUxSS91R01kdnNyOTM0am14MUFTcnNZUUtHTG5P?=
 =?utf-8?B?WUp4WHpoVFhDQTJEdXZWYnhiSVUyKzdWKzRLMzc5SmVKYllPSzFmZVprZTg5?=
 =?utf-8?B?VWNjRlZFdnZLbDZFUDdCTGRhdWhKTEVmV0pPOXhQc2hCbURnMUw3SW9lRlRB?=
 =?utf-8?B?bEhPWTBGdDV3R1ArOHFlTVM3UnZoclBxMzZLdlUxOWRuS1dDRlJQVTlTZm1k?=
 =?utf-8?B?QVlXSXRWRjRWV0VOVXpWVWszU3I5RHhvMnBKN3p0STkyM3VzdE8vTEJDbWhU?=
 =?utf-8?B?SU5Da0pFcEg5SXJlOE9JdmV0UGF2MzQySEphSDFXY29YNTF0VWd5b2puMURD?=
 =?utf-8?B?YzJST3ZDWjN2MWhFdzBFdElHclhKQ1pmZ2tHSEJmRHZSbGxkdXNsaGJVWEdm?=
 =?utf-8?B?QzF3MWI2cjFVbHdZenNVL0NndnIrc2oxUlZ3VWN5MTMzeFJ4T0JRaVdYUnlu?=
 =?utf-8?B?TzNYU1lLOXFWZ1I2bTZGQzVMVVNCdUpFelB6V0Q4b2FITXJsTjBXNjYybWM2?=
 =?utf-8?B?V1VHSjgyV3BKWjF4M0pGRUpuNVBvZ0ZRK21NM2xreVJjbC9vUm5MR0dGN2VE?=
 =?utf-8?B?WUhGcFVheFJOUGZOdnE0aUpyVXRaMEtIbnJ6QzBzenVRN2dTemZ5SmxOZzI0?=
 =?utf-8?B?SFh3TGZaTGZydVMvOTdzN1RIcGVrUHZ0VEl3VU1HUVA1eDA3UzZhK1BQb3Ax?=
 =?utf-8?B?R3ljdGxOT2JzYlRGOWxQWENPMnNTMDdxd3NMaExaUmthaFcrUnB0SFhXNWwv?=
 =?utf-8?B?Y3ZESTlObW5nL0cxanpJdEgwZjFSeG9teGZDSmNWSW9TK0d0RTUvZ1lEdWh6?=
 =?utf-8?B?QkVJQldNb2hNb1ZmckFyN3VDRFV3blhrUVZUaTlOeXMzQ283dnBWOGlaVDJV?=
 =?utf-8?B?WDE0TzBpaUNZTnZZbHk5STNuNnB5R1p3TkYrNEJOZlpqM2lOd1NxN2wvMmdJ?=
 =?utf-8?B?QWNPY3pJcDI3RUxRR3YyYzdYbEpFUWl5YUZrOVh2OU1uNlN3NmpmRHBYcWFt?=
 =?utf-8?B?cnRzaTJhcitSUGxKKzZnamNsRjRxeDZNUHFZSXZkdUI3aDkxbW5Ha2xWNmJS?=
 =?utf-8?B?aUREcjhHTXl2UGxLMThXbnc0ams3RUVVeWlmVW8yc2hHeU1FbnhIRWVieERn?=
 =?utf-8?B?SHNhOUhZMWlUMyttWHJEV3cwN3RFV3pQcng4eGFTdUI1R2RSY3ovR1JlSkg3?=
 =?utf-8?B?VnRKMVd0SHhQeXNYWlliRy9SMVMyNjhxZXBUaDVHdXJYd09UdTF1dVB5TlFB?=
 =?utf-8?B?ZnV4OGdaaUFjbFEvRXV6eVd1bVdubk5mbm1sYzE5TzF1aHFkNmF1cjhRTmRB?=
 =?utf-8?B?bEY3Nmw2bXBxMlZ6MmRJTTgwTHJheEpiRithUVRnc1BHbnFPaEpTbmJtdEtS?=
 =?utf-8?B?ZTg5eVQ3NlRvNlZaeWVoRzJ0YS9EYW9ycDhYSHBwS3J0VGpkWUZMODVMTE1z?=
 =?utf-8?B?VzV1YUlXSjcreThwMTFya1R6WjBjT0V4L0JFSncxb3B0UVRNckJBaFlnRzl2?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SnM2QnRRZTI2M0NlNkkwKzRHdytPK0ttZ0UrWVNiUDI1MDN6bE1xQzliSE9C?=
 =?utf-8?B?dTJLQyswY1VsL3NZcm5QQVo1SElIMlQyaWs4UUVpWFV3Y3Zkb0RUbUhxUXpY?=
 =?utf-8?B?aVJpQlJyYUQ2MUdBakRsYlUrRHJUTHp2ZDlhL1VrdHJjMzRqdEZQNGZ2OGNw?=
 =?utf-8?B?K2lzZTVsa1l3SU9WakErOWRQdUFiTVM3YmtINlhMWitEU0xpKzMzV21yV0ZQ?=
 =?utf-8?B?VU44U0ZmNTBHbGg5RmJROStLWUYyVm4zRHFyMWxrN0VVS2hvenE0NXRJTUNs?=
 =?utf-8?B?eDgxd3N1TlRISFFCaHBEM1UvYTM5eWxtY0Rya25nY1lCUmR2RE9iOWIzdlVX?=
 =?utf-8?B?TytOVHdxY0taRFdXSFJNSnBscmF1TlF0WWF5UGZVSk42bk8vamtNbEZmVWdQ?=
 =?utf-8?B?VjZ4VjVPa0FhSXBaZHRhVlJMamU3N3dkUzdZVGQyV0Y2QkNrdjNNOHlCS3JB?=
 =?utf-8?B?QVRDMGFQV1kwYnlac2haRHZSNXpLbjJLVXlNLzhKZUdLdjJraDA0cHc1NFl4?=
 =?utf-8?B?RUYrQzFUcDltSXZXdUdUeGlQeHVCTTBuUFJlcUVzUVV6TTNXQnp5YmN1bTUy?=
 =?utf-8?B?S1prVXFGa0pEOFBsbGZLUmo0aEpJWk9GM08wdXc5b0lDQ3FMWjdKakM2T1Vs?=
 =?utf-8?B?QUJhVm1neCtwME9HK3U0RzMvVHJ2VnliYWxJOXFFTlhhb0wvNlhISkFpTzlv?=
 =?utf-8?B?YUcybmxyTTl6eWdxb3MzQldaWWNIRVZlUjNUV25xRXpBYTRjYVMzYzZhaWFW?=
 =?utf-8?B?L3o4ZE96clUvaHlXeGtyeEd1S1RQaFIzeUloWFFqSmR6L1o4MWVqRlZESUtP?=
 =?utf-8?B?SlBoUldMRHlKQWNOb2QrU1dJYkJXYmcvcVlrbnd2QUFxZFQ5dzFRZzhqMEVp?=
 =?utf-8?B?SW9BeTZTQkw5SWpLSmp2V0JOYVpjc2VuREdidnBxTk9GZGZnclhjL1J5WVJi?=
 =?utf-8?B?amxDUUw4UkRoVm1pR1JRcVJUZWZac3FwV1h3S0hLSVlNSVQyb2Z1UFUvKzNr?=
 =?utf-8?B?MEpoaHNDV2ZLN2gvY1ZENGtUeFE3ZmRpeDZ1SHZ4Q1hqWnJtYWFPMEdpUmV5?=
 =?utf-8?B?UzR1cm1wYnJlMDRSSVZmQm55UHN2SjYwaGtrRjRDWTRQcVZBcTFhdDFZQUVM?=
 =?utf-8?B?c29BeWhWTVNGZnBkcEJMeFhqWmRPeVk1UFRPNTlDeHlpRC9ZcFAvM1c1b3JN?=
 =?utf-8?B?VkJmSi9PejdPRGtNVGtrSnB0czhzblpTMTVEeVEzdXQ2Q2ptdnEzRXpxVURT?=
 =?utf-8?B?dmg4TER0Skt6VE1BT1dBVTlqYnAxVDY3Q0ZMT0RrRnJkRnR2UT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151e7b1f-f69e-4b36-b2b3-08dbbb07499e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 01:00:17.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2xUv1uyxmyKsSDzWH11MmomQ5PEFLgfaqPGgdYC193kco8E0mtbgWceGRk5LZGUUZAWGOke4JkObyadMSobAPoUZ2Mklas/kQVSFSqmwNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=832 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220007
X-Proofpoint-GUID: b-grOEAUxUg4VA-SmHnFbKc0MsYa_W3e
X-Proofpoint-ORIG-GUID: b-grOEAUxUg4VA-SmHnFbKc0MsYa_W3e
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/23 19:22, Andrew Morton wrote:
> On Thu, 21 Sep 2023 17:59:38 -0400 Eric DeVolder <eric.devolder@oracle.com> wrote:
> 
>> Scaled up testing has revealed that the kexec_trylock()
>> implementation leads to failures within the crash hotplug
>> infrastructure due to the inability to acquire the lock,
>> specifically the message:
>>
>> ...
>>
>> Convert the atomic lock to a mutex.
>>
> 
> Do you think this problem is serious enough to warrant a backport into
> -stable kernels?

I do not since it will be the lock traffic created by the crash hotplug infrastructure that will 
reveal the weak locking mechanism. Until this crash hotplug shows up in a stable kernel, it should 
not be an issue; there isn't anything else that easily exercise it to reveal the problem.

eric
