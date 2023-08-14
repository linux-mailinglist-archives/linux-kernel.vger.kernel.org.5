Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A677AFE7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjHNDOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjHNDOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:14:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F7BA6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 20:14:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E00EMk004769;
        Mon, 14 Aug 2023 03:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=b8uJpl2uq9DqnckI7hs24bmSgkeekSFSNigMRY+xKtM=;
 b=uNdgiEA6RI+azJK4RNejJFvO3S1alM+mPOihDomVQtoFoZj7mmvX1xO0aAt/p1qTAteF
 5S4m3bpDTsqcufB8pn4OC7sSdf4Rv8Eb2JQtHOohMK9w8NauvAt2fk3SrL3kc0GBkBku
 70E+4Xjj1Sb3ItnQCQDMy2JNyU2W31ab1NYeJE/MjECBmAnEMddoQcvwFBASVbm/iB8U
 Xql7x4r3TfQu+zNPnHLj8Q/4FF2N5j2aNNkZPzmElx7Mq6ILCG5ZnRkyCOWq4LXq8ARM
 CTylHF/VIKz3umuEnxdL4uAJJ0/v4WkOGkFUSRxaIA2My0Wexet2f5vRsnHPvP8piaFw Ew== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwhpt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 03:13:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37DMrMMO019874;
        Mon, 14 Aug 2023 03:13:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3tmsdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 03:13:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEcKKjmNsj4EcxK7q/gm5FPesVKzGY1NjTUrKXoBeh6kIX5/dL4hyLJHw80C9qXP/DepCqtV6Fp/iZUuZUa5yoOENqd1WgmnKYEPQ6DolnzO8CzueWGxqk/tOhYZSUtItjEgiWwG+h+19xyr6zI673U9bOszLFWrbNI+Zab6G4wWnwk3g3riS3O4o3HOZ3hQR8QeknvLU88KTIMWgq+2rUG5qwRduA0X0bkm8lFNkqJcziDXxMJxoJ87NTiAphNKOGPOXp1ttGNSNxWrEUYAjxBHgG2m0KVEGbVV3qc/oxQRipI28OEROB1O85mS+H8Q+eJTUa3v9SxuqfBNOls+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8uJpl2uq9DqnckI7hs24bmSgkeekSFSNigMRY+xKtM=;
 b=f3g65o+8oEcqjOLnKkflRwzuWQAUDVK9EVZ4v8RxFrrSG6cAkMMSG8pRA9mFBcz1T8oXhiLvhI2UOGkyFEcsmMbJyj0RTgcPRDqYMe/17V8Uq9Daj2LtEP4liWuj9hCHWKIZ7ov0hdA3OSgvy2k8gl8gu2R19aWj8tUDLP4ZfAgRPg94t1V7ykSy/s0PKdSx6j+jsDcTfUPwIYYiOa1KZ/XgBH+nyJE+r7dTxM/dF7E9AR7oowD/+LLp8z2AYjI8Z8kQhRf5iWrsh/AbMXZ2jY2kEJpbrHQOXOmz+ZGRNmDIckeUP9Dnwww0ZoUr9Exl5jKFtr28IG2RR7NYdCwajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8uJpl2uq9DqnckI7hs24bmSgkeekSFSNigMRY+xKtM=;
 b=UYi+Ivj4u2FUio2wbsi9Ina87mjqjHAZyU/+WRSc/s3zFv21Qp4gZO3yZMVdQoGdNoH1dbGJZCAn/+S4OHq0CuF1FKPsRhRVoOH0kak9K1eXR3V0LnHSr9raWDtQkTpl6W3nTUbNK4/FvIezlEf4+y8Tw+3Xnl8xerdhh348bw0=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.24; Mon, 14 Aug 2023 03:13:48 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 03:13:47 +0000
Message-ID: <03837ec6-e0e1-4ba8-4b1d-0a125c059f23@oracle.com>
Date:   Sun, 13 Aug 2023 22:13:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <20230720090415-mutt-send-email-mst@kernel.org>
 <dcd74064-7617-c895-4f78-cb46ef1d582b@oracle.com>
 <20230810145528-mutt-send-email-mst@kernel.org>
 <b2b02526-913d-42a9-9d23-59badf5b96db@oracle.com>
 <20230813145936-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   michael.christie@oracle.com
In-Reply-To: <20230813145936-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:5:100::17) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c9b5dc-2efc-4e82-a5a6-08db9c7479bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAcl8TxMv6cMOcGCRjzgECyBlMkvGm05nUYFSAJEJ0NrPvK3XjevUMXRxquIoiDxJmUjBLHxikUZohkGjxYYRKOM0nlfPV5PxGx8dWHqqtb0n7p/H+wkQMFaqUR7LwujXV48kAe9i5c2ZysMi43EETq40s3CfShitV8Mz+bCOjKyzb0ywMNdjM8f+5GukIm0IAp+Wh4utGOd8p26aiQ9typ3RHwoUuX7gF8lHXSg1EVVowYyMtGc6Zza0+indYiZ0ZxYVOPpqUGmAjximv2d+blE8MqrModjIAzF85s5TFpNOfhxotbzU26g4NOqOQmYOqwevwbusbVP7SMqWIk9LkINmm55Yv9nlIvMAsqfvNzjxxdKjJ/2Wk2YDs/PW0ooTgtcDFZ7CZdHIs0MsgGyyCmmOwgZlVdCMFHC6t/P+P8Emfl6WyC4f5jwlSYIGJG+54u9Ztq0+3KKjdP0UsIpWgBted95qTThRYs58J2IlQ7OlObgF/lHDnxBmx8syqnzxIoeHXopMZprXRq8tWMAy3FSsOI2yAoP1JqZfAjVtshUkJWisTzMnMFgDhd5nYSB3H0DgwXSD8xSW2hB23jwbYrbydfVeB+sYTRUH+wwDOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(186006)(1800799006)(31686004)(6666004)(6486002)(966005)(6506007)(478600001)(83380400001)(36756003)(86362001)(31696002)(2906002)(7416002)(6512007)(26005)(66946007)(53546011)(2616005)(9686003)(38100700002)(316002)(4326008)(8676002)(66476007)(6916009)(66556008)(5660300002)(41300700001)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1hVRE1HOXNOYW90SFdGNEw0bXMrUFVUOFdiWUUxTm92NEpMSkYyNTVXN3l4?=
 =?utf-8?B?Y29NWnhKaDYxcnYySVVyNjhLa3RvWENvSDVkTHkxM25MKzhsMCtmVldqMHc0?=
 =?utf-8?B?VUMyY3o2RDRMTWpGTEdkaXBLcUFha2ZOSVdlMFowZlVvbE1RcFI4aEt4ajY5?=
 =?utf-8?B?QkNQZ2RIaGE3ZHZOT3d5Z0xoTVZuYnRKTFlocHJqUktBZlA1T0VPUmNyWTNq?=
 =?utf-8?B?anNCYWowbDk3dmcvdFp6VWMwbFRoR3E2aStuTkRSSjRhUHAxR1p0U09rSU1i?=
 =?utf-8?B?V3BXcnBOMmRMSm55cFRVMWtidVh5YWEySzkrUVpYdjZBQ2l5b0JYbFp2OHps?=
 =?utf-8?B?MmRPQ3ZmelJPQThvVVJQOEZ0YUd4U0Z1WUU2ck5XdEtBRWRGK0lsamwwdkVY?=
 =?utf-8?B?dUpJZkU0R3VrWk12SGJCRnQxem43VmZrUjd2YS9uVitRMU1LWFltOHp2UEpy?=
 =?utf-8?B?dlpKZUloNC8vcEZWdzBtUWtsL3ZTR1QzYU9NWjd1dXZqK0VWWms4b1p6ZzlK?=
 =?utf-8?B?MmRTeHgvd0prVk9tSGg3K1l5bnFtRWlaUHltUHUvTzhzYXQ0YVdkVlliMzFu?=
 =?utf-8?B?Q29WcjlSdGE2Vk10Mm5meW9lcGs3NGJ2UmVDSUIvZkJCVDM1TVZJb0hQWVpr?=
 =?utf-8?B?VDRoWWFvbTlHSE91cmdmcncycTUvdm82anZvUEJsOFpPcTR1Sm8yTm9IZ2xk?=
 =?utf-8?B?c1NlaGx1SXkvaGxqUCtEeTdIOHVheGRTbVV5eG00YXR4T1Fya1NyV2NmVjc0?=
 =?utf-8?B?Z3hwWTNkMzZsbUdRTHlIbExnR1Mrc0htTlA5U1dxMEtlaVVlYjVTRkcySW5D?=
 =?utf-8?B?VEZpUFNXMEFzNTVYeGg5UU5nMVhrMVphOXJLVzRTTm4yY3NmTjJHMDlNbWNz?=
 =?utf-8?B?OFo4MXNyY1ZVWmNadmpzM3lFQWRaYWJUK0NtS21jSWZFYk9pMlBDOXJ6TXh3?=
 =?utf-8?B?Q0toeEExdnYxcmRQMG9qV0dXOFZYdkROLzR1dHhuZ0IxTEpjZFdmU1UvYThp?=
 =?utf-8?B?cDB0c1NSOWxWOGlSeWdMdlZ6aHkvN0YvL1VJeGNHd3RjQ3RVV3U4WEVMOW91?=
 =?utf-8?B?SDFEeXNMVEtUVGpxYWMzTDJTZXp0RW5FUWJsaXpmMFNBaXYzZ2NOaFNyVkZu?=
 =?utf-8?B?amVoSnJLUURhYjl5bkFsUlVGM01ZV0hqd050dERMWUlmL0lvR3hTQUZ0TmdL?=
 =?utf-8?B?ZVcwMmE3WEtURWFJTmFMYVo4ckVhUEdLSU5WT1k0eXl0RWltN2t2U1hkSmJj?=
 =?utf-8?B?YklkUTBPa2FPOHFqbk4zblg5K3NaTkdPNHkvaW5kV3FadEhkZy81Z1NFQXNW?=
 =?utf-8?B?UzJJaEdNNzdrV3hRMFNTWFR4RXFUSTVvTzh5a2pHZWl5ZTc2b2tFMVJZZFpl?=
 =?utf-8?B?SmJSSUZKeVgrMlRMSDB5aldybG5ObHpiUEdZRmpWMWg5dm9CaFBtZnVpMng5?=
 =?utf-8?B?Tk9DZWhzTEkrY0dsS29PYVVieEVQTlc0ZjVtUWJkcmRjNEp2U1ZsK09BR1h6?=
 =?utf-8?B?SHN6YlovQW8yUkk0QzFYc0l2anFKZmQzVWY2R2RSSGRJNThCYjdLeko4OTJF?=
 =?utf-8?B?L2NwU2h2N3dsVGREMi93ckoweFJHNDYrdHNZNVp0ajRrZTJZUEVpMW9EK1dR?=
 =?utf-8?B?QTdGNzdkOVA0ZHpReXZSSE5UTmMrM2p6RVBVdnk2YXVSNVdJbU5OZTZUalF6?=
 =?utf-8?B?bFJ4V2RWYTUrWXZwcnlEaFFTbXdIeWlYUGdMODRiaTExRWhjQVRIbnJSYlQv?=
 =?utf-8?B?VXo0ZUxIZHQ3MUdvUU5Fd0ZQU1FqcE1Od3JiTUtmb05zYjd3KzhOSndHcmhV?=
 =?utf-8?B?c0NrY1JCUHlJeUJ1RFc1QlZpN2lRSVFOMXhJdHBsYTQ2T09ON05NUHh2dTVq?=
 =?utf-8?B?dDVPR25RanVabFUzMnFVTDU5WGc0QUdxZkpxNWFUZXJNdTluMTQwbjRYL1Vi?=
 =?utf-8?B?OHMrOUI2enhGUkgrSmwrR3Ztd05BLzAzSXZ3SmZuVVNiOURHRllYNXR1QWNy?=
 =?utf-8?B?WlBrNisxNmJnbjVSczRWOExOaUtFUjlYZ3FQN1BlN29QT2RzQ0FmNVhBR0Nw?=
 =?utf-8?B?NWR3czkxcGw4TXVmSjZZUzc1dGRsMGUyVkFZaXZ2UUdBK0NKQkxXb2N1M3pq?=
 =?utf-8?B?eFlOcERVbEJaZHl2T2xONlY5bnRrZHI1dGNOaFk0bVJGVmNzZkxSUitiTFJU?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SmhhOXM3azNHdVZWd2s1aCtIQmszM0tXQ0xNN0xuTUUzVnNMeTQxK2lXWXVN?=
 =?utf-8?B?MTJsTVZMVGpyRVBFMXJkYU90b0U2NHZ1RDVnbU4vRVZiN3F6aTM1SkFKdUVX?=
 =?utf-8?B?THVGaXBtWExaL3lvQlJhcXBra3JxQVFMMDJVRHM2SDZiVEZ1MWdSaTRSa01n?=
 =?utf-8?B?S1VKQ09GOVlkSXd3dVhNWVFJNVczeHhvM2RpUEhUTHlub2F6STVFN2ZLUVlw?=
 =?utf-8?B?eDVmU1I0ZWp1bGlzckhadkc0L3NEWWNoZ2cxOGRVQm4xYkZ3SXM2MThES1o4?=
 =?utf-8?B?c1BVbUtmRDl3Q2Vaci9SS05CMVdTaTA2czh5VEVhVi8yRzMwV1ZVa0FRRnMw?=
 =?utf-8?B?UlUvWUdmV2tCeEdQQm1DZk82c2VrRzhXb1dKR1J0YmdWTXBjZlBmWXFhTjlX?=
 =?utf-8?B?cTVmNnNmR2Raa1dRaGRjUjZMdGk2OHk0Ukc0dEI3Zm5TYnhoZmo3SzBrd2M4?=
 =?utf-8?B?SDlYTlhIeCtZMHJ3NlpUNjVpMGNSVDdQV05xNXNSdVMzOERDY1JKVVlPcTJ3?=
 =?utf-8?B?OXBIelU4V1BBTDlEUFVjeTBLTFRTU29lNVVlaGF3Tkk4OC9XK2FaQzlPcnV1?=
 =?utf-8?B?MENoT1FGak82TXBiNEhFT0M5SWJDQjMzNHF3eVBqd0d0QnY1QW1aR2pubGsz?=
 =?utf-8?B?SnIyUUVZV24zWEV5MCt5TDFBeGcwYzJGWk9MeGYzT08vVnBZRVVUMlJkaFZl?=
 =?utf-8?B?UEEwcWtIVk81cEFUTEJIQ096NU0vUUhrZW9TbG9mcTUzdEIyR0pINEpVQjhM?=
 =?utf-8?B?a1lQTE9QS2ZQM1lOWi9SSjNzT1BJTjRybDNYbTk5MytxcUx1ak1hMXJzL1dQ?=
 =?utf-8?B?SStQdGpoTFVvK3daZncxOHhZWmZRSXlWWkp2SXNEdFVwSXJvNjhkUldsTjY3?=
 =?utf-8?B?MVBWT1FxS2tsWHI3TkFMbEVKM2I5MGhjdW16VnZmVG5qMDRGRW9MVTFiNlFa?=
 =?utf-8?B?M2ZwZHZjUGIzaGREaUZXS0hycFN2R28zbEFEcm1oZm5FcmVtd3RGcmpSVytj?=
 =?utf-8?B?ZWkzS1pvWjRXVWM1bHQxcTNLYVk5WCtibld3L2xxT2hubzl6UVNHc0FRNk9B?=
 =?utf-8?B?c1NzclVIc2NQSmdQZ2NFYnRVL2grMXNhYUFTYUZYNS9RWHFYNW1JVmFMNHdv?=
 =?utf-8?B?TkNiUXVONzlRb2wvSW1VVi9RWExwYmpqcGplNXFDbXdkL1B2eEZ0Nnh0Z00x?=
 =?utf-8?B?WXM1WmdubDY0WjBXWno4MnNtM05LVVlLNWEzZ1dHN2JxcDVGeFB2Y2NHcnd0?=
 =?utf-8?B?c0IzTVBNSkNrRXNzdnpaVi9hUVJCTWhqeFpBeWtJUmd2RHlnaTAzS1pmZ3M4?=
 =?utf-8?B?dW85WkgzUkxPT2N5alY3dmxRcU8rTmY3RzZGSEo1Z2dNRkZ6Tmt3U2pKRkQ4?=
 =?utf-8?B?YlZGZ2lla0dXZVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c9b5dc-2efc-4e82-a5a6-08db9c7479bc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 03:13:47.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKaejEoBZOZhGLoKsyKzerQek3WruDFjcU9pm5HvHOBGKNz+9hV1Z8/zmzEMpANga1VR3nMWIQ4QjMAlYm+ylbrZm6NPnwpXqQVQu24dKd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140029
X-Proofpoint-ORIG-GUID: TUI2uYFXLKQ0bPG7LAf4kOBHzSMtiI_z
X-Proofpoint-GUID: TUI2uYFXLKQ0bPG7LAf4kOBHzSMtiI_z
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/23 2:01 PM, Michael S. Tsirkin wrote:
> On Fri, Aug 11, 2023 at 01:51:36PM -0500, Mike Christie wrote:
>> On 8/10/23 1:57 PM, Michael S. Tsirkin wrote:
>>> On Sat, Jul 22, 2023 at 11:03:29PM -0500, michael.christie@oracle.com wrote:
>>>> On 7/20/23 8:06 AM, Michael S. Tsirkin wrote:
>>>>> On Thu, Feb 02, 2023 at 05:25:17PM -0600, Mike Christie wrote:
>>>>>> For vhost workers we use the kthread API which inherit's its values from
>>>>>> and checks against the kthreadd thread. This results in the wrong RLIMITs
>>>>>> being checked, so while tools like libvirt try to control the number of
>>>>>> threads based on the nproc rlimit setting we can end up creating more
>>>>>> threads than the user wanted.
>>>>>>
>>>>>> This patch has us use the vhost_task helpers which will inherit its
>>>>>> values/checks from the thread that owns the device similar to if we did
>>>>>> a clone in userspace. The vhost threads will now be counted in the nproc
>>>>>> rlimits. And we get features like cgroups and mm sharing automatically,
>>>>>> so we can remove those calls.
>>>>>>
>>>>>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>
>>>>>
>>>>> Hi Mike,
>>>>> So this seems to have caused a measureable regression in networking
>>>>> performance (about 30%). Take a look here, and there's a zip file
>>>>> with detailed measuraments attached:
>>>>>
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2222603
>>>>>
>>>>>
>>>>> Could you take a look please?
>>>>> You can also ask reporter questions there assuming you
>>>>> have or can create a (free) account.
>>>>>
>>>>
>>>> Sorry for the late reply. I just got home from vacation.
>>>>
>>>> The account creation link seems to be down. I keep getting a
>>>> "unable to establish SMTP connection to bz-exim-prod port 25 " error.
>>>>
>>>> Can you give me Quan's email?
>>>>
>>>> I think I can replicate the problem. I just need some extra info from Quan:
>>>>
>>>> 1. Just double check that they are using RHEL 9 on the host running the VMs.
>>>> 2. The kernel config
>>>> 3. Any tuning that was done. Is tuned running in guest and/or host running the
>>>> VMs and what profile is being used in each.
>>>> 4. Number of vCPUs and virtqueues being used.
>>>> 5. Can they dump the contents of:
>>>>
>>>> /sys/kernel/debug/sched
>>>>
>>>> and
>>>>
>>>> sysctl  -a
>>>>
>>>> on the host running the VMs.
>>>>
>>>> 6. With the 6.4 kernel, can they also run a quick test and tell me if they set
>>>> the scheduler to batch:
>>>>
>>>> ps -T -o comm,pid,tid $QEMU_THREAD
>>>>
>>>> then for each vhost thread do:
>>>>
>>>> chrt -b -p 0 $VHOST_THREAD
>>>>
>>>> Does that end up increasing perf? When I do this I see throughput go up by
>>>> around 50% vs 6.3 when sessions was 16 or more (16 was the number of vCPUs
>>>> and virtqueues per net device in the VM). Note that I'm not saying that is a fix.
>>>> It's just a difference I noticed when running some other tests.
>>>
>>>
>>> Mike I'm unsure what to do at this point. Regressions are not nice
>>> but if the kernel is released with the new userspace api we won't
>>> be able to revert. So what's the plan?
>>>
>>
>> I'm sort of stumped. I still can't replicate the problem out of the box. 6.3 and
>> 6.4 perform the same for me. I've tried your setup and settings and with different
>> combos of using things like tuned and irqbalance.
>>
>> I can sort of force the issue. In 6.4, the vhost thread inherits it's settings
>> from the parent thread. In 6.3, the vhost thread inherits from kthreadd and we
>> would then reset the sched settings. So in 6.4 if I just tune the parent differently
>> I can cause different performance. If we want the 6.3 behavior we can do the patch
>> below.
>>
>> However, I don't think you guys are hitting this because you are just running
>> qemu from the normal shell and were not doing anything fancy with the sched
>> settings.
>>
>>
>> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
>> index da35e5b7f047..f2c2638d1106 100644
>> --- a/kernel/vhost_task.c
>> +++ b/kernel/vhost_task.c
>> @@ -2,6 +2,7 @@
>>  /*
>>   * Copyright (C) 2021 Oracle Corporation
>>   */
>> +#include <uapi/linux/sched/types.h>
>>  #include <linux/slab.h>
>>  #include <linux/completion.h>
>>  #include <linux/sched/task.h>
>> @@ -22,9 +23,16 @@ struct vhost_task {
>>  
>>  static int vhost_task_fn(void *data)
>>  {
>> +	static const struct sched_param param = { .sched_priority = 0 };
>>  	struct vhost_task *vtsk = data;
>>  	bool dead = false;
>>  
>> +	/*
>> +	 * Don't inherit the parent's sched info, so we maintain compat from
>> +	 * when we used kthreads and it reset this info.
>> +	 */
>> +	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
>> +
>>  	for (;;) {
>>  		bool did_work;
>>  
>>
>>
> 
> yes seems unlikely, still, attach this to bugzilla so it can be
> tested?
> 
> and, what will help you debug? any traces to enable?

I added the patch and asked for a perf trace.

> 
> Also wasn't there another issue with a non standard config?
> Maybe if we fix that it will by chance fix this one too?
> 

It was when CONFIG_RT_GROUP_SCHED was enabled in the kernel config then
I would see a large drop in IOPs/throughput.

In the current 6.5-rc6 I don't see the problem anymore. I haven't had a
chance to narrow down what fixed it.



