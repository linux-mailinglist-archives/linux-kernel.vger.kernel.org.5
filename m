Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CAD757DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjGRNjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjGRNjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:39:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF4E97;
        Tue, 18 Jul 2023 06:39:17 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ID7slG007275;
        Tue, 18 Jul 2023 13:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ItRmxuPK1XGyIiZ4nHh/fmPsCM/XpjnTmRZnt1v9dLU=;
 b=b+OZ2+Cq5u8IyQkVawxB7xgXP/accCpFnSTbsOwdAY2HOFs3HTDR8pDPH8DTkfhZfxNL
 4LguaGMIlXikZqQFpxaKn0NOMiYXSS+jaD3HFSHHXrJ9eIRe/eaC5/YPGRP2KWSVImLU
 Gc19KuJbm5IT7rf7yE3/ItvmuZEF3uahwoglQFDJnJaiomNg+tBvbatLioz6xnpTex2o
 o6v0bgAo5L5t24Exuct5rprHgZSAfNaV/+06mDvKI+tjBd7PphLF8tFS6GwsfdFzMkSi
 c0bOQX2W6oZG+Z72e3WkisdQZyRCCbXBcRMO+RWEW1j3V0DfKbOJiC25la10fyD7WSCF tQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88n4e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 13:39:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ICWFeo023907;
        Tue, 18 Jul 2023 13:39:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw5btfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 13:39:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzHH7sAxuN22bH78Pgox0f4RnJT7n4UMCqNgeQl6gneOTOlJFnW3VBg/lWYEtFd0hiEc4mVw8HD8vLqLPY07DriFMS94/ckM9piXvMO36EJ0VKKApjOkLxXV8012gOVJLwNV7Wg20G65t7g1068VPu19Kmba1k/7uFMpJwUSmBPRDcyYDPn4l35xHATQQfVn5YikGaEXgl7xqBmNm83Fs/LBmugZg+T9J2oiiZzrfVghbatikcuqLOC6Qr10ZmsgKhUmpuxeejTJNCkhuuIBHMM0FZ8KzWWramfjI+CMAWV24KS6Hg17U2vb7p/brBkeKEWgn+oWnFW1VEHXEvz4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItRmxuPK1XGyIiZ4nHh/fmPsCM/XpjnTmRZnt1v9dLU=;
 b=LWIfo26bypYB7j4opxztZf1AtDvyQm7HODHAOqcIZ7NTUPbTOPFnMcnhvir0lYyKP2M2TDQa/56y9BaAx3lHxqdvBcIGJD8xedhMOGuXYjHlW1ML9xD0JxRJkubOg36eZasySOkbFv+Ph298+F2vAChEXgUlgaOMTKjySheNkYtV0ajRZyEzC184NUgJWlNoN5TNVs1OjQVP3iqyiwJjaPBuPUWPpALsU+mriPB7skYwvbQnJdmF9e013Ub8TA5LHgj77o5W3TZm0QGIVQgi7S8jFaxmxzDaxiGQiE+5tBb/Qql/hguVhKxdWBtMHoEKlUZq8X7ydxhQYi7tqvbGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItRmxuPK1XGyIiZ4nHh/fmPsCM/XpjnTmRZnt1v9dLU=;
 b=f9EbiitBMLn98QwWIIsIcZEnyjGqGDHr6cedQmj2aeYpXVj+cFD7UgSrlREE3LWIgVBpXG6vCgIUOxUD4+Q4KfLv9bEYpT/7mjA7sLXlQVuKK9qZ2pLctlVTha5GWw8hiGI8Fc1oWESS4vK9QQKH5WtxPpA3atiPdiH/kOHW8oE=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS7PR10MB5037.namprd10.prod.outlook.com (2603:10b6:5:3a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 13:39:00 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e28:d652:3a4c:b1b8]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e28:d652:3a4c:b1b8%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 13:39:00 +0000
Message-ID: <ba1652bb-4bf1-95c0-683e-474d07edad75@oracle.com>
Date:   Tue, 18 Jul 2023 19:08:48 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH next] media: i2c: fix error handling in
 ub960_rxport_add_serializer()
Content-Language: en-US
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20230718085846.3988564-1-harshit.m.mogalapalli@oracle.com>
 <159ca9b9-0702-b347-3e4f-66272dfce55e@ideasonboard.com>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <159ca9b9-0702-b347-3e4f-66272dfce55e@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0184.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::28) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS7PR10MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: efc5a723-90f4-420a-9e15-08db8794579a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCV0oH9ex+OMQ5M0O0738EhZgd0gCS1Nh/TABTJ+KY98S7M3qvu0ah3dkzvjbm7jpaJbe2cQXe9qIklhXdEWlm3SIdMiwEGXfz94FfHqFdtxOF5D18fLVsDJ2r+UfKvJiWjlCmNAb1xJo7K6CKkCXTvPL9A0hW1N1BfblTnkH3Xtes84lDuYfHY3azJysjHCTb4DmuyPq0kk7ZNIgAxtRENg6oupAJP4H27zCU+Jlocv1QxTfFxrbF7VfpRdeMH57FqQ7I8s788t5FK1NkTO+XmLT/PIQ66QjJH3B83cbNvSOhM/V09FD0tRxYzM6UIjs1AnbNrcSQ2MMfmBLcr82wsM+9rMQRJs6xKWdxPfRUuqQRzPgeJ6lBHpkiWdAPjZ8KH9OJhouVCZYToLQScBVTfP22xg81PQWHJtnT1aQXya4rBHhNyXf6OEct0A733qA2/jaoApz69nvW6uBWasgeEGLtbLRUmIFsDQHQoA/r2PQGCcEM6Ptla7rOQHVi6cIxDR8MSxCyvduDi4bo7xFtDYBHgzFi2onxAs+UzlYqrL4LLJs6nGfF0I/ZzhO9GQ85BF1dpb2J/XkIdK7GQLsis5NgzQqzH8HVGo2dPOpY+HRC7tm1m2c8ETplxUsbjUBVVNm6ncJTnXBaRzO+FcoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199021)(2616005)(478600001)(6666004)(186003)(31686004)(83380400001)(6506007)(53546011)(6512007)(66946007)(41300700001)(66476007)(66556008)(2906002)(316002)(4326008)(86362001)(26005)(6486002)(38100700002)(110136005)(36756003)(8676002)(8936002)(5660300002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1Uzc1J6dHpYWldFQWtqQW1Kb2txdmUxVExCaGdkTUNoUFBBeHdjcFg4UkR1?=
 =?utf-8?B?UFE1YzgxL0V1bTlvLzd0bm4yQXluMm9QSlp3MTd6U2RNeWwxVWs4TVh6bEk4?=
 =?utf-8?B?Sm91d29zL3lIU2NUQ1BhWHA0d0hRSWhpbXBnNkNLT0tGaHFHSjMxUWVtZXZ4?=
 =?utf-8?B?ekVBVnRncWJ1VEczTFJDZjdzMUN2K3I4YmVLd1FZYTg0ajlidmFNSkNrY1Fz?=
 =?utf-8?B?cUVBSlhNVVJBdWljZHJVZWVrUGJEcG5odHBJaU9WZG52eHV0VUNRNXhpU1RJ?=
 =?utf-8?B?Wk5JVDduUUhKR2ZtT2xWc2RvTlFlbnM4dFFtTWM2bzVaZjJlcHRkUm5pVTNO?=
 =?utf-8?B?MmFZcGQraWVOUW9VNTNDdmhUZnZDa0xHaXZOcmJHWWVzTXNTSEJZTzJ1RmpQ?=
 =?utf-8?B?MmNqL1VOOGlGWi92cTBmNjVuWXBQU1JzZXJDUm9ZUE94YnFwemV3V1dHU0tr?=
 =?utf-8?B?ZGVmM0o2ckFJYWFqUVVRSXArQzNYQ0hGaEkxYzhEWFR0NlVaUFNPMi9JVEti?=
 =?utf-8?B?ZGRxU3l0QU5lYjJmYThFbEZobUJ4TmlIaFNiN2F2VGxqMzBtWmpPTTlFKy85?=
 =?utf-8?B?TzVQQWF3WU5iSG5MWmpidDQwc0dzTDZaM292dGtsbTBPcllQdDNleTB3T005?=
 =?utf-8?B?TmFiSXhEK3lqb3drV1VDZVNwWllsM1FRR0ZXN0d4QjNwUUtSZUlLbC93V1Fo?=
 =?utf-8?B?V2s0aU5UbngwK01RNUttb3BBemhVR1RaYTZVeUpLeUh6REd2OHJuTHBJKyts?=
 =?utf-8?B?N2ZGZmVIM2xsNHM2WHUzcjZJazY4OXFhMUw5bXdRMlM1MVU4ejhsNEh2aDAv?=
 =?utf-8?B?QVBMc05NYVAwa3hnVndHSldya01KVmx1MTVJV1Z4a21TSFc3SkVvMzlOWCs1?=
 =?utf-8?B?SHBkMllYcFBxRko1UG9VNnBpdm83TzZ4QklXdjRDV2VhODBldnBLVkRVRmVO?=
 =?utf-8?B?SlA0NUNYYkhqUFJhTlZCckoxT3dNeTE4L3JDSEhscmtWd054SjFoVkN1UUlh?=
 =?utf-8?B?YmRoZTk2Q3dDOEw2NVp4Q2hWOEpRYkRnbDBpbU5jT09OR3FoUlZBV0lYa2ZZ?=
 =?utf-8?B?bmQ1MURFbXg3dzkyb2xUamJ6Qk1JUWliZ1NHOVlPWDNRSFB4ZmdNZVBNK2ly?=
 =?utf-8?B?cnlydnFWcC9vWGxkZWRqOTdOWTJLU1hTeU0yb3RQTGRjQkFoRmhJMWpjT09U?=
 =?utf-8?B?OGxoR0F3eldVQUgzdDE5WUo1RTFqUlgxMDZGbzNOV0t0dkp5RzJ0Uk4yNzZJ?=
 =?utf-8?B?UXZjRkRSczRMUWs2Wit1STh4ZHhLTUJMZHUzNGlCSjZuTjZKSllmK01sWU81?=
 =?utf-8?B?SXRwMG5YUEdlWnRodjdoKzI4NEc2Mzk3TFpoZ0U5aWhvdTlLdXl1TzAwZERu?=
 =?utf-8?B?VnE0UHlsOXROR0VFMkNMeVBEQmpYa0NHYVV1MHpHVUp5aWJjci9yY3I5bkVB?=
 =?utf-8?B?aUNvaTUxQXZ5T1FmSW95TTRDOXcvQ0F6SmI1WmxCbytyM3ArYVhuc2xYU0VF?=
 =?utf-8?B?Nkk0RWlEN2RwTVVNdEloOWl0NlJUV0orK1J3TEZZMXl1UGR6R2JOOU1RcmZ4?=
 =?utf-8?B?SkRmeFJmVFlmejNVNUVaK3hYMHZXYTU0dys0cXEvdGtLT0pRaFNmdEE2SUZF?=
 =?utf-8?B?UmlRNlFyNmhKa0tFZWJBdVgrTGhTT3dGSy9SUlh2Zkc1N3c3UnMxUmlzTE5l?=
 =?utf-8?B?SXloRTN2YnNhMVdrNWxiWDBKczFFU3k4Y1B2TjcvaS9tMU9VeDRmV04xdTBk?=
 =?utf-8?B?OXEzZm9pVEthenRvOEhCNVlpMURkdk5pU0NIMDU1Rk5GRFFjd29jb3JaOUVs?=
 =?utf-8?B?Z3lSVlVkRmQzNldTY3BNUk4wZ0QzSDFvYnp2M0xkWGhPQnVUYTRaZ2lzVlpB?=
 =?utf-8?B?M2xVS0Y5VTR4ek5MSmpYTkdGUnlSekx0eVZFNE1tMmJxUVo0b1dCUkgrekp0?=
 =?utf-8?B?eHJ5cG41UFAxWTNUcDBjM0c5UnA3VWxNR0ZjL2x5VGpEWHovZnlMMURVTHdJ?=
 =?utf-8?B?b0djRW8rTmQ4Q25FSVIzSkRjcnRFa2x5dVFWd2l1SllGTHJ5ODk1RzNoc09D?=
 =?utf-8?B?Z1lWa0xxYWtOU3BDWnR4cStMS3BSZGZTVnp3dVFFRTBIcEQrd2dMUE9qSGov?=
 =?utf-8?B?Zk9xQ1NscHBiaDRmWEYwTlBPQ2FmMTI2ei9FVjBIcTVuTDAydVlTNWl2dUdq?=
 =?utf-8?Q?kqxyrOFvaGsRDRqK8QI2cVY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dFFNQzhCaWlBVURIVHpPcXhwdEI4enhicXlCb1M2emZDbzBZaVVGRnVGTFdX?=
 =?utf-8?B?ZnZ6VW1vclRDSkt4RXpQZ2NrMlJJNzBuTVF0MTRDRDNma2x1aStLcVBURjc0?=
 =?utf-8?B?aW9ya084S29ZajJOU2x2VXhQK2tOL0hIcC9BOGdJMEdSdWZpWlFHZm9iYkRj?=
 =?utf-8?B?WkpqUC9kbzkrMjdCalVOQzVGUk5qTjVUOVVORTRzVENKbkpiNHJJSE02VU5p?=
 =?utf-8?B?RWRTaFBJMzh6aEd5eTVSalU0ZHl4Z0o4N3p3VDlYMDVmOTVIZmFiS1ZzalY0?=
 =?utf-8?B?S2RrK0hsb0VoNGVmaXZoN1ZHZHJaSFlXa0RGSUxDSlllVnRjRytaUnhMSWM4?=
 =?utf-8?B?Z093SXEwZzJGT2lJaTRMRnZQRXVINjAxb3AvbFNkNzBBNGZoRXlzdWFOU1ZB?=
 =?utf-8?B?OG1xNE04N3pKVWVFY1cycU1BcC92YmFkYVM1R0ZZNER1WU40R1dzVEMxTmZt?=
 =?utf-8?B?amszdjNWbm1XSmtJTkM5bUFXa2RvcTI5aFRYRUpSWjg4V2NJQkFNbEZVcXNi?=
 =?utf-8?B?Ym1zbGkzNWFRRjd2T2EzN0l0MlJHVEVPcElrN29ZSFlBUUppZnk1WndNWFl2?=
 =?utf-8?B?NElFbzJqL2x1cTh2SlRnWWY5K0EyZTZvK3UraEdXSTgrODRBcE80UHBhWitK?=
 =?utf-8?B?TlMxNUcrSGE3SDJuZTNxYTJZeXJSOS9NdGpFNzIwQTRudnA4N3M4NnhtNXJN?=
 =?utf-8?B?WDVtUWt4UW9qWVp4eldzOG5RVmhITG1JVTNUM2hSWHNrbjBpc2pmWW5iZFpT?=
 =?utf-8?B?a1FTb0pJQ04rdFlXRlJzNGcwM3FKTjkyMHBKdHAvYXVvcmhiY0VWKzRJTC9U?=
 =?utf-8?B?N2dJS3JxL1JjUzdXMERNYXdmczVmbjdIVzgyQkg5bGRRZUpHUWVxTEoxZnNX?=
 =?utf-8?B?Y0g5M3p1b294cFp3VHFEMlQyK2dPZlFqeDdRc3ZkeTZVdEVDU2szNjBJVmY0?=
 =?utf-8?B?d3VZemU2eCs3a0FlWTVXN3VXMlNiUHdmK21iM0N0TjRieEtjUHVGTndwc290?=
 =?utf-8?B?Y0RhYkpGV3h3WGhsOFkrMll4eHQxTFF5NmZ5SDhmZ2hIQmFZUEZFZUMxQzAz?=
 =?utf-8?B?Q0Ixc2dwbmgyUlJ2RnV6VWp6bStCT21pMGRqZ1IrMTVsVnZxakNLdWpicnUv?=
 =?utf-8?B?WVRyUDhkazVBT1JJV3ZWQUZLbkxhTWx4TnRqRVJYRjFlOVNhdExxVWRPTDBN?=
 =?utf-8?B?VWtUWVlkQ0o5UFZjaFFtRnloeVFUY3ZQeWdMZUJXUWV6VFJaVVVQVkM1YzE2?=
 =?utf-8?Q?NQKEUjiA6AYpeGo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc5a723-90f4-420a-9e15-08db8794579a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 13:39:00.0457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TY3MrxG14NcpNFTA6+E/ZX929aZTGjYhKkO+YU8ASXlwObQieXLbH2kV+/8F8IkZX4tut29SDxxneBNA9+wKKkh229JpOqxYHsyZZciWqR9PBS91ASh2B4yLZ3B/FRZa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_10,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180125
X-Proofpoint-GUID: 2eC6ZAeO3BQbBh83EGhZ83j4By26YBmK
X-Proofpoint-ORIG-GUID: 2eC6ZAeO3BQbBh83EGhZ83j4By26YBmK
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On 18/07/23 7:01 pm, Tomi Valkeinen wrote:
> Hi,
> 
> On 18/07/2023 11:58, Harshit Mogalapalli wrote:
>> Smatch warns:
>>   drivers/media/i2c/ds90ub960.c:1671 ub960_rxport_add_serializer():
>>   err: 'rxport->ser.client' dereferencing possible ERR_PTR()
>>
>> i2c_new_client_device() returns error pointers on failure and in
>> dev_dbg statement we are dereferencing error pointer which is a bug.
>>
>> Fix this by using IS_ERR() which checks for error pointers.
>>
>> Fixes: afe267f2d368 ("media: i2c: add DS90UB960 driver")
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>> Found with static analysis, only compile tested. Although in
>> drivers/media i2c_client_has_driver() checks are present, IS_ERR() would
>> probably be sufficient here.
>> ---
>>   drivers/media/i2c/ds90ub960.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/i2c/ds90ub960.c 
>> b/drivers/media/i2c/ds90ub960.c
>> index e101bcf2356a..88144e3ec183 100644
>> --- a/drivers/media/i2c/ds90ub960.c
>> +++ b/drivers/media/i2c/ds90ub960.c
>> @@ -1662,7 +1662,7 @@ static int ub960_rxport_add_serializer(struct 
>> ub960_data *priv, u8 nport)
>>       ser_info.addr = rxport->ser.alias;
>>       rxport->ser.client =
>>           i2c_new_client_device(priv->client->adapter, &ser_info);
>> -    if (!rxport->ser.client) {
>> +    if (IS_ERR(rxport->ser.client)) {
>>           dev_err(dev, "rx%u: cannot add %s i2c device", nport,
>>               ser_info.type);
>>           return -EIO;
> 
> Good catch. I think this should be modified to return 
> PTR_ERR(rxport->ser.client) instead of -EIO. Do you want to update the 
> patch or shall I do the change?

Thanks,

I think it is easier for me to do that change PTR_ERR change. Will send 
V2 with that change added.

Regards,
Harshit

> 
>   Tomi
> 
