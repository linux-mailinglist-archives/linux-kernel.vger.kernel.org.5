Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21F37E34F8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 06:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjKGFqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjKGFp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:45:57 -0500
X-Greylist: delayed 579 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Nov 2023 21:45:53 PST
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA847120;
        Mon,  6 Nov 2023 21:45:53 -0800 (PST)
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A6LqPYe020270;
        Mon, 6 Nov 2023 21:34:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
        message-id:date:to:cc:from:subject:content-type
        :content-transfer-encoding:mime-version; s=proofpoint20171006;
         bh=9wqybZuZquU8tD2O6qEuyxOOVGkHv7YmToX+qHbbKeg=; b=qBoQLrMYut/W
        wsNKAn2PBw0wbHabKG1WcM3XYz+xAcefOL+OqmJoXxNPotsiYY7nz8My0qgiwELO
        HF5yp4rSedD0emm9J8Ye/VTaSgxIp2GqRoj9DCONeveRibf6gYXSCaUu+BUr7FuK
        EEtz4rtz6b/gA9X1UGyTX66b99Bj9tRNP/EtIzIAplAKEVflBnRy93NqNEKnHopI
        jgeHkIi6vOs1k4e+6lnGuOzFpSTHZj7OE5LN779Lbyv7Fg4C/05sqK2CQPJ0TCtS
        ngGn2fQJD61KN0wa2QK0ITX15kUKee3yxbeOTt/1LLaIw3wdparC2qh7lxVqPZAy
        VsZTgy+g6w==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3u5hv4msxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 21:34:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXVGz2npZ35hjY4kfChaau5+qdRGnQCHhVg3/Rjdn6Sg8Q9ClcIlyckWMAbaP/wlO3HvuMglWBwoNHz6onkwoaRQ4sLOz+U1H3vD7Tj1zkh0BWjYdGZXgQ/wUBE6O91r0P2+pGg8qh6LJQRwer5Rnx4HGTaAa9+/YjG9RnEtFXrKHg0fEvZV1d7JT8OT5JNob//4ZXVVtDuwYvBDYIHOszt5cd6ZOWlOgliyUiGOEa2ssxyTzQ8yhfZWeOvyacsYqVSBQnS8sBCC+pNKwuyaJz4edesOjBF8K5/6PV66j32p19+xadvqdhDlrlopmZr+6WoIZqS94GZur71r2hfM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wqybZuZquU8tD2O6qEuyxOOVGkHv7YmToX+qHbbKeg=;
 b=D05pvdLec84xZZ7i4S+h95hQrsln4ZtWUVXkYW/6hR056leZ46pL9i2IrcRGuDwjZVmpFl02gDxUve18hFpPeghHlJrAIfUGVkVll2gIZfH4vRcdbQs+PiqNqobaEo3HwiHdr9sRBA/oBnxaHXzZZWIIxYckkkAIbkupU1LQf09RJ6f8E9wzkzH2uKj+dw6fYgVvGjnfPDr+9+gX1Fxr1aLJ9Kqlp9KYJIqbJSlRImeUizrscdK1OXQ1hLMc1tQX/G7pT3sREl7njJcSIJCYkvCDD10R7jbbICjKwfspsziDsuQT/2Jaa6Bg8wWpD4km3w5GWH1ne4Xaom+xJ18s0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wqybZuZquU8tD2O6qEuyxOOVGkHv7YmToX+qHbbKeg=;
 b=hbrDBthaucYGa5kG75WcdM45p8x//JloJlVRKBh+CVhTDeXi4udXLjkoXz8BFA46GDh1gliM96NLwOIoNRWPz3ld7rYQP+YndNeFtwCjw++jUMAZTkYdLO4AbMBCMlfDv9DWwG7MU6iWOqTJcPHf4pWfEapUOIiWDomqsLCoSNYtp14/phWPCfrX7oNznEiyvdJpKNkIbgeOPfiCld/nZJ7y8cK2H+MLKXNygsHY1AOG2qS/jAQF8QLKX4xRNQYbuxOFMs4Ot2g2nKuwaNRnB13tcRCimlYiuPtd3HIGXgpc9rf066ibuvV3MJdlWtzFb5JqBIlV40qjSRMDS7vfAQ==
Received: from CO6PR02MB7555.namprd02.prod.outlook.com (2603:10b6:303:b3::20)
 by BY5PR02MB6755.namprd02.prod.outlook.com (2603:10b6:a03:205::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 05:34:51 +0000
Received: from CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::e06:3641:96e4:a0b5]) by CO6PR02MB7555.namprd02.prod.outlook.com
 ([fe80::e06:3641:96e4:a0b5%5]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 05:34:50 +0000
Message-ID: <5cc50864-9096-497b-a86f-e37678dcb105@nutanix.com>
Date:   Tue, 7 Nov 2023 11:04:42 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, aquini@redhat.com,
        jeremy.wayne.powell@gmail.com, clemens@ladisch.de,
        pwalten@au1.ibm.com, joe@perches.com
From:   Shivam Kumar <shivam.kumar1@nutanix.com>
Subject: Question: Earliest kernel version with FIPS-compliant DRBG?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::8) To CO6PR02MB7555.namprd02.prod.outlook.com
 (2603:10b6:303:b3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR02MB7555:EE_|BY5PR02MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: e29c8a5c-a548-4de6-4b65-08dbdf534330
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhpCBuongDXezUvYrScncaV6akTDi6zw0HQ1Dx/jC8LSm3nALNMZUthbRL5a7X1S7ubDi4f2hMbJwe6uWTpsJuJs/LWhPeoa0OGrF6m14nrr5bw+TWKQjiTZxb0ZTuJUx7qB2hesSoSlNb3URmpcvWlV2eY49Kv21reB1aIirEDmCG0+JMkt7WE0nWMzQZQp52FaOpYKkvEvsi4t4imGlbuwYSy9Meuo8DIYlQDQt/lmkFVIYWFI7rDpigW6p26mQcUJ4xKSf07X84vhK0xU9wDZ8WDcOyLh0u9TBxOga/ywWE1Lr+Zz7JIEEf3psmsOn+ohcR50UZwhNrEAk6ZYzEVMzviAs3uGwnB4HsgiQHcXgfIPER+vxyCTSjE4mG/RoqTSb0MHASFlEZoaatiAHHYmEjsLuKZNUV4ITCXDs4kAioQyHYYBxGkkesW2plcp3dJg0BeRfDej+5c+ux8BAZnGzaRDrnNzoZ+6bdUoSGC/GyzYjhwNTKkrLDFMa6B2KXWvvxR9c42i7Im3MaTY/Fcqyu1b22ykofuK9Yt3aainAKM81/GIkBTkecpBeDDOZ9UEcS6bnssSRtZVbwnHnRYcCr1D8ZnNjEfloT8eGDkbJBe7BbNkLUqV3LI5mUwHmaGIuxA11ElgdN2SnQeOKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR02MB7555.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(86362001)(38100700002)(31696002)(6486002)(6506007)(478600001)(55236004)(4744005)(8676002)(4326008)(66946007)(66476007)(316002)(66556008)(8936002)(36756003)(31686004)(5660300002)(41300700001)(2906002)(83380400001)(26005)(2616005)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3F2R1lYTk9vbjgzZUFSc0xJOGx6ZlRieWg4bmJlVHZVZmlNc1BaQm9jNXJp?=
 =?utf-8?B?WGxoTWpDZ0lCZzRYVEtKZEFhUkxBT0p2SGU2QmtTOUJMTno1OEVPeEZXdW9Y?=
 =?utf-8?B?MUVQWS9SVVNBd1BmNzRUMFRQQ1d2akJmcDhJdjFDQ2Y1Mlk5aGF4UGpCYndu?=
 =?utf-8?B?ckNqVGl3NmU4ZXJWb2hkWktqS3o3SVpZRGZmbTdrVm00blhrVURmODVXTmRM?=
 =?utf-8?B?UjZMOWpYYTRHbUlyL1BpNSs5VkhJenI5aWlFdE1HTTlyRGsxY3BNOHA3OHV0?=
 =?utf-8?B?ZzlmZU9VZjhRdFZ4N05tR3dnanhzMGIvSEttbm9IZVNjMjJrMXZmQTAwSmFD?=
 =?utf-8?B?RzhBQXVpRkJ4SXc4MmV5WTJxWkhIdnR5R3AreXRHV3dER3laTXZqNG1vaDdr?=
 =?utf-8?B?VHFLY1RuRjRjdkZRUm8zQU5JSTZkLzNjUHdYK3prS0c1UitJMVdyK0dHSit0?=
 =?utf-8?B?UGsvaXlhOVhYYnFDMjVTMmMzTzhWOGkwdlpucnRFWXlHZEppQkt0QlVBMWtW?=
 =?utf-8?B?c0RXTHdoUzBFd0FvZm55U3RZVGhTWVVMa3lIRFdUdmlWMm9Ea1FCdVVxelQ2?=
 =?utf-8?B?U3BaMEFyeUFVUGpOdVlEUzlFVnZRWGhsZVVQZDQ0aG1QeHh6VEMxN3JTVElW?=
 =?utf-8?B?WmpSK015M08veStibld3dGliSnlpd2QycC9VVHNzdS85ZVpRdjBId0p2Tmhp?=
 =?utf-8?B?Z044djdTNmNnQU5zTjJFUFRBdUQ5UmJ1YXhWbWVkd1V3dUhJb2ZWZW9hOVFq?=
 =?utf-8?B?R0pYZjRTQzMyQWpadXRzaXNWeFI2ZXBHTWFrUFF4N1dMdEFCLzN0blFtV0wz?=
 =?utf-8?B?bXBmdVJJdC95a21mMHdTalU1akZpL3hlVkN3emVQYnA3MW9jNWYzQnhvWkZP?=
 =?utf-8?B?OGc4aUc4Sm5jeVltaDdXSGIzNHh3M3ptTThjeFNCT003dUJTVG1CLytjZHVO?=
 =?utf-8?B?UWMwMUtFcldqajNYdzJwam5NaWZWRkE5MzdkaUxFS3FxWTgxSUJnamExL2l3?=
 =?utf-8?B?ZzlqQzFGdVp4VkFEUmI5RERvYXBlaHVkSnE2Vm1EaXlhTjJYN0xObm1zejFi?=
 =?utf-8?B?RnNzajI1NFh2WGRUNVBDM0E4ZS9VTmIwZHpOcmtHdXdPOGFBS3B1bnNXRGtN?=
 =?utf-8?B?dTFBY1VuWGVTUmIydlI1MzlJSHRHbGM3ZUtBTFMxMExib2FVSURFTHdtd2Q3?=
 =?utf-8?B?cGlpa1ZDN1lKZUQ5bGRmbHIxMDgxTDRYRUZDaFBYKzQ1YzB1Ryt0MzYvVE55?=
 =?utf-8?B?UFI1MmdzRWlYd21Db1d6WjYzN0cvZ29yZDV6aEpCZ25lQ1BYVElsSkdzbzJ1?=
 =?utf-8?B?emN3ZVNKTmM3cU41Q1Jxd0RjcStMMXF5QW04UEZqckc5bEh5TFZZVXBXTGJS?=
 =?utf-8?B?dlJhaklQUWVKdktrRGRPOGlncWJKTHdUOTZaS1hPbkM2cFBScTg4anlSUHc5?=
 =?utf-8?B?WmV6RVVWVml5NVVrTEg2S1M3YTVyZDBGMC84SXhFckt4SUlveGF0aytYWDlu?=
 =?utf-8?B?dUxyYjVWU3hMVXY1Qk9BdE9VaXc0OSsvbzBDTUVUTXFXNGtRV1dRUlE5RE81?=
 =?utf-8?B?QXN0TGc4dHVHK01aYU9BVWVTWWlKVWhqUWJiSXJod0pIUm9KZ1lBUmhGWG9E?=
 =?utf-8?B?UEtJU1ZMTlhqWGZMWHI0MUVVbmNrVUtuLzRLR2hza0xjbW9mSjVXWk1jbHh5?=
 =?utf-8?B?VUUyMW1iekY4dzFROEhjM2E1NGY5TWdvbTczb0JtbmRITDRmWlNPallFbmRF?=
 =?utf-8?B?U0lFT25XWWdydnFNUEREcDZTZXlnenV4OWkwanUyVGNES05EN0NnSEd5ajJy?=
 =?utf-8?B?M2RJQmsyeE5DQTZGWEZpSW50U1J5THRwNEZEYVR1L2NDa0F4elU4RkkwbGVo?=
 =?utf-8?B?U0l1V1FvYURjRjJGaldqSHhhN0sveGdJV3YzYVpNQXVuWk5NRGQ2T29zdEZQ?=
 =?utf-8?B?NlR0eHRxL2t3eTdVelU5b0s4NG80MUV2d1k2elhDcklkYXZJS0hOUmorY0w0?=
 =?utf-8?B?NStITEhxcEY5emFzZWxDRnFyT1F6WEhqVE9UWkRjZzhneGM2cC9kQXZlOFpk?=
 =?utf-8?B?MWtOQkUwQjJ4YjEwYkQ0ZHNLWS9YWXBvRXR5M1duaHp4dE5WVHQ2b0thRjlO?=
 =?utf-8?B?N0VscERHWDRRekxtNk40L21CaElzVFZsWVpkRHpMVHJ3elh3d2pnQkhZYWdI?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29c8a5c-a548-4de6-4b65-08dbdf534330
X-MS-Exchange-CrossTenant-AuthSource: CO6PR02MB7555.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 05:34:50.9043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kK/gFWOLFJKieP1gMJreBF/Vsp0dL8AMNVRlhHe9t/kApGCojJDu0PwJJL9pMfygcUMXW0iGAY181/cnEpSgz6tFbUwOkVa6+BR6m2h+hCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6755
X-Proofpoint-ORIG-GUID: M93Rz-giwhK9W9Qu9cVOLkaH5DMmmCye
X-Proofpoint-GUID: M93Rz-giwhK9W9Qu9cVOLkaH5DMmmCye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently came across a discussion on the mailing list and noted some 
Linux Kernel Mailing List (LKML) patches pertaining to the enhancement 
of the kernel's Deterministic Random Bit Generator (DRBG) to meet FIPS 
(Federal Information Processing Standards) compliance. However, I am 
currently uncertain about the status of this endeavor, specifically 
whether the kernel's DRBG has indeed been rendered FIPS-compliant.

Could you kindly provide clarification on the current status of the 
kernel's DRBG in this regard? Furthermore, if it has been made 
FIPS-compliant, I am keen to ascertain the earliest kernel version that 
incorporates this FIPS-compliant DRBG.

Thanks,
Shivam
