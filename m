Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8AF7CE89A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjJRURA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjJRUQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:16:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5429B8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:16:54 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIn0SP011250;
        Wed, 18 Oct 2023 20:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VJLjX/cgq9KldEr7KIx053ywp2361d86FalNYloQN/g=;
 b=i5hBsQUMDKU5pX5grmMPSsU6x1IHd+ILd9/CzOOfCN6o9shNZJkW1w8v1D0SWIUvOJku
 Y++y654zeviYElrsg/KVP2GQz4jVYCUK+acAD0Vtg9Lj4T2Yw6dZ/c4mLdxObmG8vajk
 AD5PnGVxTlJrdCaHFPBZHDKkW3bJvqMR3Z7r8tvhAyU5PdvQ/Eu/K9gCj9SSlMR0/f22
 qGMWk9j8R/80f4Lr+1b7deQ1/9Xi6Jz5g/F/Cg7F0NDMtl5AoYn6E2A1bn/P0NAVRJlG
 kMMpkgIvDvqImwXcdABfxvaSHa+JkBKNiX3Nrmw0QO7a8LeTa+FDtOruONev4SCES00s cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cgmwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 20:16:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IK9TpS028611;
        Wed, 18 Oct 2023 20:16:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trfy5htkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 20:16:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elPSu/wVDrVQ79u6Gtczl2KF21qhbntqTv4PsfnzAiZg086bSuo2j7EHH5oVGaLQZFuqy+gkwUXjsU+0c6QTli8rBWkF7biGXczQB/6JEcs+nT5j7AihEyHcSj79H+1ZuT5xwOgP7ix1w6FKg1Ij9zXCjVX6oJzp7Z80FQux8yo/6WA4/KmwK1XArrmE2qcrIG+Ea+O7NprUSar2SNBhKdo2kOdQQhueAwfzq+GLAL7zV2oJNLc+DXMFkJT4yd3fB4r55Ql5Y6Gx7xwJ9NWCeFAfsURZZ2lXL0aVrTi1yFpnYnRX7O9/zl353DyUfC+Vts0B2CRuwk0B/6k4+s4JHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJLjX/cgq9KldEr7KIx053ywp2361d86FalNYloQN/g=;
 b=cuiXYF67Tfaj2ZWsY8kM/coQEMMsScWfYRRoRdh8TQ4yXUn+XDVFaRpZB2p4rf9NKbFnRFb2IJPBg9RHWoqTHqYgWM5IxN4/W9zFXPXr+WJRYdBKqQvH/xnmQ6SDv2ufKOzjD1rlX90LrZPpntYwhW7vs1+fXC3hmHuirsCdabqyAjjA500zGMSFgRSM+eAQ+gthCVEiCYvzGbse4jFgFVGtDKZkr5sc7N7JUVn+7lJTn1jlEA0+94Dr1Zvk/FlHgaJKdRYsIA+PMjJtuh9zVCzAidm7uqYeHtBre/5tZ9MeUZi8Z9PO6Hl1MC51cdSaryR67Y7R+l9JvtO12+pbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJLjX/cgq9KldEr7KIx053ywp2361d86FalNYloQN/g=;
 b=tRch5wAkwbEF5nDtjGPdmzcHMkUJ/9YA3NyydJyXQvRslHOWEBrCGTksBauDY7cLyeeELzKrXkQOhlKVXx0lUvaYF1YuwJOnUna0i2AYcu7HpFxwPOlEXAZxIFQXW5bVGNbJSxgj4fzD7bP3DtCL8SoJcaH9NoWcjnhUYJC4HMg=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 SJ0PR10MB5836.namprd10.prod.outlook.com (2603:10b6:a03:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 20:16:41 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::45df:6d4d:83b4:40d]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::45df:6d4d:83b4:40d%5]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 20:16:41 +0000
Message-ID: <8ad28ad3-7f8f-4bcc-8ec2-bc5e9e998d2c@oracle.com>
Date:   Wed, 18 Oct 2023 16:16:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Do not flush IRTE when only updating isRun and
 destination fields
Content-Language: en-US
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     joro@8bytes.org, mlevitsk@redhat.com, seanjc@google.com,
        vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
From:   Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20231017144236.8287-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|SJ0PR10MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 3776e9c5-cb42-4213-381a-08dbd0172439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S20mJsznsAo9N300O6F9FDkMalyJFiUf/xVd7NbE8WO78GO2f2aeqjqs6ddGRdh90JVSQqM/b9UlH2sKvCoI1l6aog3DqFLCHSl6N0LUhCmpQF4BLZNLECjCO0hGrmyMFdgAWufSqzeBQFoP5IZcnINpYGHndUFG7OGZYJa2RRO3O/tNRA4Fk+L2wvz5DSu3HLFfHdK1sBwld2cQrF1ux5eNPSk/sKoJVhZet6jG/ZcLY+C1+bIFgxuknIG+16YEKBNdkBmQhVx7qW4KAsvIWSjx4sVHOg9NeDe6wGKSXZgZZXa2MxBc78sm9bow+z861gZbTyH4z8IpZ/nsopDgqKAnsOGOrltCkNHf+/KpJIs9BXozsB+foWKJLNk1Z98fPGdvaYl5I7pTYKGuyDkN7FiD522YTPWCUqGNmniqBKpCgAH0C1GX47GF1e0PgF0fpjFtXNXmf2lJDevsaE3o4g+HnqayHcMtcRuQ7w8ZMdWqig0OpjNtp75fFyxwTDWz+3Qz2gKTjBHVnRxx2vjQlDwFOPTfcdiw+9QymhGycCdiJS1AhlsXZsgq2C6qbRzuAE73vNSuV0EnjYUwFDV7FinkrtbiPWztv3HQM/+I1Xvtmoxb6ZGixljqH64y9ztKEv+Qjqya7BRuWLxuOlM4XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5280.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(36756003)(38100700002)(6666004)(8676002)(83380400001)(107886003)(6506007)(6486002)(26005)(66556008)(53546011)(2616005)(6512007)(316002)(66946007)(66476007)(86362001)(5660300002)(4326008)(8936002)(31696002)(2906002)(966005)(41300700001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFFhNUQxcGpmSmFqQnN0UHRhTUVzL2FLcjBTTjhybkg3N0p1WW9QY2NVZGhy?=
 =?utf-8?B?cjNQenZNenZsRUJseGtjVjJLYnY5Z0FDbzdRek5mbnYzWUwrbXNHLzREV0FW?=
 =?utf-8?B?LzFvWlBnaXZHdXFJRlNkZlc1VTBTSHBuMW5IUi9vakxUTlp3c1JCaGt0MTNu?=
 =?utf-8?B?dkVkSlo2blRsWFZqakx1R2Z4R1J1WGJJWENJdk5CMkNjNzE1TjJOczljNHJP?=
 =?utf-8?B?VFpNVnFZczV1UHQyR2FKR2ZuSWJOQXNETVNsY2h2dzJaTk5kYU5pdzQzLzlo?=
 =?utf-8?B?ajI3dnh0bm45UnRzV0oveWJoM0RLdzR0bGQvbENyam10M3NBRHNyQktnRUZ1?=
 =?utf-8?B?eWJlZVFqUU5IVWNiOTMvM1J3clJFY2JWbnloTnFrWWIwNlpNVkNlcUFFL3Ex?=
 =?utf-8?B?MHRBRlRHek1jSEZ2UzNFSzVId1BzaFZrM3RGRWttY04yN21qQmdVMVpYUUVz?=
 =?utf-8?B?Q21kT0ovbzV5LzNSSFltMnZRUkp4OU1Qd1lqc25TckU2YWk0V0tERzUvTmJI?=
 =?utf-8?B?ek9zcWFBdHdVaEh2TlE5N3p0NXhhc2lZTjR3Q3NrZklHUjM2OGRzUFltVmhU?=
 =?utf-8?B?RUM3eUVqMkMycllHNjhkcEIxaWc1RVFlOXRhcEFYM3M4MWdpMG5TRCtMVFVR?=
 =?utf-8?B?bGIzRWd0cmN6M29aQXNMN2dEQ3A1VjM0bFIveHpBSWNCZDA1T1E2RlFUclBG?=
 =?utf-8?B?d09INy9Pa3paeEU1VjhJMytuclZDYkVCNmIzTWRnT0dycGlOS3JNUVNGZnRJ?=
 =?utf-8?B?RVREVmFadEJsb1lLNWg1N08wQlYzQkIwNGRONFpGL0lMK0FvaXZTZ24yM1Yy?=
 =?utf-8?B?NDgxQm0zc0hNcGdxVlZ0ckVlL3Y5czNhRUM0akRkVkY5SVZuam5WT2wvNzFH?=
 =?utf-8?B?Zk1RUDNuT1dlZzIvVVhvMGdXUGdjbjlFNXdGTCt4c1JmbFo3dnZPMHBySVNq?=
 =?utf-8?B?bzNweXRZZTZqRm1tYWQ1dENNanIzS3RkRHpLYTNuRU91SmhpM2lMYnRvNjgz?=
 =?utf-8?B?WTJ5NWhQWURtczBvT1BDdFN6V0dCQTZ1NUMreFJRdXZubVc5V2huNUNaVVdM?=
 =?utf-8?B?Ulk5Z1M0N2JYTmN0MUhTTmRGbkNhcWxWcEFBVGRKTXp3U2ZpVDIyN1FLcFg0?=
 =?utf-8?B?SlljenhSSXBpTGM1Vlg5a1NoK0JsVnBydklaT3VnNDVOUHlpeHVjSm9YQzJV?=
 =?utf-8?B?UXgrVWJlZFlXRU11M3J3SUwvRUtxYk1PQnpFZVF3eGxEVHgvSitMUjlzS2Fa?=
 =?utf-8?B?SmxtcUs5VnF0UjhKTEdRN29BbllWZWdvUkpQc2x2YXdvRkJ3c2ZJeDRFNkJq?=
 =?utf-8?B?Wmk0RUxPZG4zNEFYRTRkK1Z2WFdZMTdoUGU4bDhPYnY2MVhIdFBlTm5samU4?=
 =?utf-8?B?KzBCbVNiRHBXTkhNQjNPdlF3Q3lodlRlRnlyR2hJQUNpRFg1M0lYQ21MelVM?=
 =?utf-8?B?cXJIVVVlZGlnTytLVFQxbGZaanR1Sjk2amRZYXgyT01qU2xXcnNFWXFkVXFt?=
 =?utf-8?B?SHROWmRJYk5NTFMxRWhaV01DQWNEUjRvZnlCU2FSRDNNbFhobG5EK3RpemlY?=
 =?utf-8?B?Z0ZOMkE5TVdKSXJOSmx2bThMS0crbXByVzhwcDFBMmROZWpCVFVrNFEzcGIr?=
 =?utf-8?B?T25UaUcxOHAzRVJZWUpEbjYrREZ6U3dLNE80NE94U2NJSlpkUWxKNVQyS3BS?=
 =?utf-8?B?MDBSbk9xdzg4anFJZ1FKOXhNTjIyTGhydnp6aU1DczZZaW02dFdrdW9IQlJp?=
 =?utf-8?B?TWg0T1gveTdqd0N1dFM4Z01QWWRzbG4rc2ZIZGZMMDY4aEZ5R1IrZWZWWUFQ?=
 =?utf-8?B?cC8yQm5aSlVyTFVib1VuZU5Od0QvUHJJZ1kyNklSZDJDVnZJTVd5S3JrZ21u?=
 =?utf-8?B?d2lWbzBnNFR1blRTWUZYZm0wQzlnb1Y5Y2hOK3FHYnVtZUFia2lKVGhhWXRl?=
 =?utf-8?B?VDM1bS9TYllVc1g0YzhETkJCWWNvcTNLRlR1eURPaHJmVVdtSmdKSG9nb2I5?=
 =?utf-8?B?TUlnaENFRFZSM2g1UVllWE5mRU1IYUg2OGoxU2R0V3lHbVhpM0dHZWs1QTMz?=
 =?utf-8?B?RlNVY3Qxd3c0S1FZb0NRUFZXekpvM0pNMlRYR25EYjZVbVc2a0dlYVQxbkdu?=
 =?utf-8?B?ZTFpcWFMM2J1SERMMnFQVjRCc1dqYjlVU3ErVzJDcDdwUGNtRlVFVzlQbzJO?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6IwSTSMhHsxqyLBR31FMXHnIjQAN++AywgasgamEqlH8L5DijtfHuBXA/65li4N4ohzf7rKXKIDFpblh8O3qsWpUNykzS8e7drZdmrpkk+7O8yCSxdIBQalIShMjwhgHc/gUGsjh4h22ssg4bYU95HzL4KV5mUKvlH6AaehBmZpjXU53vVho8Hd5hJrqLnSy0fEPNN7waY0KTj9CKH5pFp0A3O1IiYMI+DNBysmpAzycKXvcZ0JFzrdgpeWzIfvFN7GWzAqtfkOcx/igF/W8K1Mc80k1ozAgDOLr5ZOxt886d5AF24CXYHGUiLaWUh3auEjRoG8mHZ8IsND3TK+mXCSJX+4PAI17CDciBJxqyVJp+oMx0G2euRrYU8qqJA1MFEx1/Rjwb3uK8qqvUdkiZSUz5oqH7KlQTHI45b7XOmgnEcBMG3MQCMLDcIg5xXiYSgb4F2pqVJsM1sBQt5itnv5JATeF9c4NNR4NSf1VIGcQGSqPlnJpG6+ra5kuaHSR6k2AE5ZyYpm8oAdPlBc66LEzmRrOdOfZkfm2C7taS49WJk5p+ieXe5rN3O52gMkjU8JQ7IJL9z96mNJYREZ5824YdNMeEGlG0AkAUdnxTJn5kZmYAqfwRZ2myJGBQu+M2ohp8zFJgaJDS7PjqbiFL9BETlhSB0f4YqKAALq/7yc/s5UUZsu/bs+ovN9xjnjbJp5hN2d2BAecKc892+Jq+c5IWbk/xzzjjQEE2IovpOCyczsWAfUiFbQuMTt0oKsunLlik/O+ngaaH+3b9k52i1gvO+QXUdJMs5DcJb01A4yKlIc3gMFiff6n9+xSQwthspUJniOUy9THiBuIbL9Qd1aYx2+CR5UWWGnUqJm7UfV5WEY+9B3xK0R6gJ3no5b5MJinteO3gSi8IKrkizuG3oDDq8xX7mEpiVY7uQpQ7ls=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3776e9c5-cb42-4213-381a-08dbd0172439
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 20:16:41.6087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwB8r5yVk0kTCONHx7SLHy2/psl3Vil48CCfi2J70HOScn3BfwH5rHRat9UiPApaqQH9kuJKFCuMYamrirW3IahjZwBdRQeIc4N8YSH0g70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180166
X-Proofpoint-ORIG-GUID: amzVVrVUwG2eEcGTWOzJuaOqwpVMv2Fm
X-Proofpoint-GUID: amzVVrVUwG2eEcGTWOzJuaOqwpVMv2Fm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/23 10:42, Suravee Suthikulpanit wrote:
> According to the recent update in the AMD IOMMU spec [1], the IsRun and
> Destination fields of the Interrupt Remapping Table Entry (IRTE) are not
> cached by the IOMMU hardware.
> 
> Therefore, do not issue the INVALIDATE_INTERRUPT_TABLE command when
> updating IRTE[IsRun] and IRTE[Destination] when IRTE[GuestMode]=1, which
> should help improve IOMMU AVIC/x2AVIC performance.
> 
> References:
> [1] AMD IOMMU Spec Revision (Rev 3.08-PUB)
> (Link: https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)
> 
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Built on top of v6.6-rc6 tag, and booted on EPYC Genoa host. Launched 380 vCPU guest with AVIC enabled and 16 VFs, and ran rds-ping workload that uses all of the VFs to send traffic. THis workload has been used in the past to stress IOMMU AVIC code paths. No issues found.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

> ---
>   drivers/iommu/amd/iommu.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 089886485895..d63590563d3e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2970,8 +2970,8 @@ static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
>   	return index;
>   }
>   
> -static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> -			  struct irte_ga *irte)
> +static int __modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> +			    struct irte_ga *irte)
>   {
>   	struct irq_remap_table *table;
>   	struct irte_ga *entry;
> @@ -2998,6 +2998,18 @@ static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
>   
>   	raw_spin_unlock_irqrestore(&table->lock, flags);
>   
> +	return 0;
> +}
> +
> +static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
> +			  struct irte_ga *irte)
> +{
> +	bool ret;
> +
> +	ret = __modify_irte_ga(iommu, devid, index, irte);
> +	if (ret)
> +		return ret;
> +
>   	iommu_flush_irt_and_complete(iommu, devid);
>   
>   	return 0;
> @@ -3681,8 +3693,8 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
>   	}
>   	entry->lo.fields_vapic.is_run = is_run;
>   
> -	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> -			      ir_data->irq_2_irte.index, entry);
> +	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
> +				ir_data->irq_2_irte.index, entry);
>   }
>   EXPORT_SYMBOL(amd_iommu_update_ga);
>   #endif
