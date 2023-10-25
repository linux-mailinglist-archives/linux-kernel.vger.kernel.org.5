Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2917D600E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjJYCq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJYCq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:46:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D60ED7D;
        Tue, 24 Oct 2023 19:46:56 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OLUScg031882;
        Wed, 25 Oct 2023 02:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=tqo/Pgne67yIUCVG7FFtnL/ezSEfpLTa79dnNubIMFw=;
 b=WZ+3ZP8rIGUSdzL9iEoJc+pCubV8+cM7mHRz5W6Q0utZab3G7yJwiMfE9896lzFsShKN
 H5F7XyFHEnX82hw1XbJ2wce3Pm8472OG1acOHstXt4cg/1yqZuW4BVVNImCfXiT+XexA
 /XYMUpGEk+7TlMl1NxhhvxTVHfn0kMsFeheX5BIw8l/Sxgh+W/4CYZKhT6VkV+AucMgA
 OMXs8IflyoPeXObzES8ZuRFfQVXXBYAUlL21zt2erIIlKEkaY0LZMHGB2Ck3YTik3Ig4
 6kkcV64uTxtfcUe36zve962buwthTtoFU/kX36TtYi5j4Mt4XvervKJHAZJmjgoOEp95 bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6pcxs95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:46:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39P10ulH001509;
        Wed, 25 Oct 2023 02:46:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53chxfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:46:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3/kRwmVv4kXEIoWKkALVgvsXWZOpzCR66KVCOYlJT5FEwaRAfzQC3LIb9/Gmwvtyq4PHoGELcfbXE4ml2KIoOnMug7wBbRa0mbxt9EAxaw3ZUXNBPsw5GciKPDszqD/iUSA+eRmUgYLSA8zWI+ngSh94x+VxKUwULL/6X8mlma1XNXoJ1SouNjswzyMlI6fTubEddeFCHOKYzG/QaNcSL0ahfhr2pId2IiJX4mXDg8z3LD/WqYP3Xi+oBHbfv3NWK8GyF1xW4utk/5AuuwQ4zywZ1nV4LvqUQ7z9hS2ByDkln9sF54d5ENODQ/zmyFvgX+aQN+sOt2t/lWjZuIwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqo/Pgne67yIUCVG7FFtnL/ezSEfpLTa79dnNubIMFw=;
 b=C+RxyUoUPwqmCDAqWxlHioCLos+nkUiUKbHsJBw5eR8y7N2T/UO3hsK/O6sBn0DW+yntbN2JkfgmdEjS7kdwaCGr7aGq7ni1tuXMlljcj3szdPQziZaNAh7KpU7uy/y5zOj3XYQyXfsmmS4xszx0CmYnZvUxD+AxZbBfqVxDZ1oFa82VZ3rzuxocBVH6nqJkHI94tQmhrz6tkPcnlKF0GJGUOl42w26iPbwX2qNaANqCtSCIjMt2+OSDOqzgy0Q/j7rm9MflKPmUrrDFVRGKikrz0CkH/kJXmEmQ5BlRYfN8DuOLjoRLD9My2MTUNuiawYqJ36saezKwrxlhqQRbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqo/Pgne67yIUCVG7FFtnL/ezSEfpLTa79dnNubIMFw=;
 b=kOt5b4ntu7CD26x/2b4n+ISfp6bUqFnl1YFTq8g3OQZlubsvcnfpTCCDdQodMSI2PhcLg+rA9DNXtw39YdLukN6CziRqJQqaMg0bkBUY2OqOnkJsqkdILi0mGgimsjs6W4S/ubIGS2ul9WZWwMpJwhtt9zRMT8zmhacUDJqLuUk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CYXPR10MB7924.namprd10.prod.outlook.com (2603:10b6:930:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 02:46:49 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20%3]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 02:46:49 +0000
To:     Daniel Mentz <danielmentz@google.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mars Cheng <marscheng@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Yen-lin Lai <yenlinlai@google.com>
Subject: Re: [PATCH] scsi: ufs: Leave space for '\0' in utf8 desc string
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1msw7ctbi.fsf@ca-mkp.ca.oracle.com>
References: <20231017182026.2141163-1-danielmentz@google.com>
Date:   Tue, 24 Oct 2023 22:46:47 -0400
In-Reply-To: <20231017182026.2141163-1-danielmentz@google.com> (Daniel Mentz's
        message of "Tue, 17 Oct 2023 11:20:26 -0700")
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:208:32d::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CYXPR10MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0c9b37-4902-41f0-c391-08dbd504a2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZSYKTaAjWZx/LIqS5MNTx9NBxGhvQqQLv3c0NflUE9MERG0TPcmRZi0OQlikqDYJJJQqJhKhjUkIs5bRtM77lQLLK5zdDBckMeHXkgBBVZ30lJopu1lcOeW+DHSy1k2EMEb2FJ0TdmCbUxVWM3pEcGkqH/B6ogYTLxNvAnkCZy0J9Wl6h1YJF3r6RFs001mDiimXr+q5GGrfszlFJBVMko3zo92EYzc2sqGr6Z12yRlNU1rwdgGCziHCvpZkIkTTtqzRY3QL/zV71gcf7hOKhf5lBjggO6nkgmhu8sEv0HFXJz4eEmrfT7HgklhasqC7YYiNqae+IiPb/5sHyCU+xBivRn53h3wVg44dFF1j0xj+aU+HVDjkMHiHbJBKCcx/dRKDzHJ+YMqHazM8T0yQBNZNiL9rlLPnBNwtdgiXK0ndzgR/RY90A4KVILyDw6bjpun5hziI6Jzk4tFCjvoU6I33lt0CiiNI/pm5M24mFJ8L2T/HRummK2+Jzfkf7oBtwrY0Bh3elCrJfoGh+bPZsJ9HOxCpfcxU/X+laY4c3owhdwfrXYNnh4mLsH3c77D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6916009)(66946007)(66556008)(6512007)(5660300002)(316002)(54906003)(66476007)(6506007)(478600001)(41300700001)(4744005)(4326008)(8676002)(2906002)(86362001)(38100700002)(6486002)(26005)(8936002)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KUHimVItSbQQZLGs3J8MqCqMMcgOevWEiNRIVJLEXdTuEJ9HVEHNWvXos+3N?=
 =?us-ascii?Q?451sYv4jndqUkReRKSi2D805kzxEUwmRjnwaE4Dy/wKwaDGXAhVhq24vM8EG?=
 =?us-ascii?Q?3iQauoxWyPg8zvxaWwmdXfY+22tYdwO0E/vPIKVsbZR932DrvGFHthmlXMXs?=
 =?us-ascii?Q?AtVuUQoeZ8mN9ZUQSTcJc5U+Wo/XL7p3bF5H54TmidNFiwJZDZZgzYoIZ1xE?=
 =?us-ascii?Q?lhU8l+9LKG/i1SUAbbuwRgVXw8fHdzbKv1M26d4UtsA0i//4+m0MQi+GE0Jv?=
 =?us-ascii?Q?vVQux4ImLRvGQ4FoTB/1/Nv+nogZ6pN9oZHzpPdFm5G4kcf9obzmV/+U5Jwf?=
 =?us-ascii?Q?vQnEh3zCmjgNB0QTCgqPTFZmIDn3u5YkGKoewCE6pbGpjOCPAKnb/DaMigJx?=
 =?us-ascii?Q?r5UM8MIKOerEaxyD7RX+ftTeMHoChnRKUbQhrYkCIei5UKWkF8upU150Cbn2?=
 =?us-ascii?Q?44m3EwJ52GKzfl7HPT2xVZ6+kfuAPhkmkF3u+DFplorcv5oZwnUNLyHsEWDL?=
 =?us-ascii?Q?gWe7WZ5RWxl1IkaEyrJARm9dTuq/vAkvZ76LTUmx0WRUGYSrgcAvkFRyDas0?=
 =?us-ascii?Q?GMGgd57VhE49osPxAAI/rDe8+vo9uYmfJVJMya19MHbbAuLRmTQfka62/BXQ?=
 =?us-ascii?Q?zYUAG4MRl69qh5azIfdtNKxdvjbbknKmVUlupSSX/PYxZw2AG00rUAoKLbk2?=
 =?us-ascii?Q?hzH3tbmxiySMEx+q4fkSwOIW2EdMr9yFZGK+Rg+3lXIN0hZqcKY7R3AmPyLz?=
 =?us-ascii?Q?MLAp/U7/H2fMLdsgWkYGz/pft3UTCPAnO+M2tS4w2+ADv7s7ixHhHbuEKa1l?=
 =?us-ascii?Q?O2QMLS/vVsmrZ+KOP9uJvoQC1iKFiGFHzq93GYHCmZrWhsf5v9Av6LirLJFh?=
 =?us-ascii?Q?MCxWzDW5yUIJ0WjpOnif4EJc544DPG5waAGq8TwLfyLKiL42qgIEgCMHXZJC?=
 =?us-ascii?Q?IGujpN1PqHvqSentKXhIBhpYZ+H/MdfPfznU28rJ0ooaudzu3GvDfrA286rK?=
 =?us-ascii?Q?ML+MBbumuhKv5+/do4gsSqI/RZL7DWKWJ7bhFOqVLxdmtY099Epy5/mp9T+f?=
 =?us-ascii?Q?OgL+tjuzzEwG2hNd7HdfEHk2L0AGaSjAP0q8Z4P8F2jO7mb5gZmj38YgL4s4?=
 =?us-ascii?Q?B5xyWNHOmo7r34QRFwnJ47DklgUYV/6xZLJtSahqC0A8fAUaIRtQNV12QrDz?=
 =?us-ascii?Q?JgHkCoi1S77MzQdYJgrinMmOu6K4HqUympesySCpl/oGOZfVRnR94N5ZdSKl?=
 =?us-ascii?Q?B33BdYBYSjv61Znx1qZCAHsOLAFu/IskGfqEdvtMCs1LCBrRknL8+zrhOjLj?=
 =?us-ascii?Q?BbaojjfxtjylIfG2/9pm3KtYNH9mQDUk7XkKsOuK+C02TagtWCfDpgYdjaoJ?=
 =?us-ascii?Q?hgganFDVVWQqhchCx5aJ5+TjjEv1zjFFXU8gykMvaOaO+tusmu2pRY6hMq4c?=
 =?us-ascii?Q?h3mIJEGwUuiX1tcd2/3wbSZknAoJhpu3ZaoK22O80K1DUza8vG6n/m2h4Q+C?=
 =?us-ascii?Q?hlMMJXQ+t5oTR6yk7iKYlUjkr0Z/pt+9RhcZDZ9ATtzxKf045+HPpqhPlZae?=
 =?us-ascii?Q?O5ffDFqbh/yiH6OSteFdUlla371bleccolOnwGyGtHnW9kTmqdtiF8pQ4HRf?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QApFsEyOZc7Z0VFcrO2olarkcRjjZ3GjZnsfCVYHDOhAxidmJdZicv/R8jISQMXc3SIHB275qFMVvSEBHLec5S8oeU1DFWNoWFkuiUzNX76PwcaiJFhjJCfG8QCL17BjTV2t/5ZJcXYy/7j6FoCG9Ot4LFcX4m4x3Q5L9dmtw5vMAFXP7BgiN91LLLa3DZp8MutEiQq0kcOOmyvcnHfmdNDUA8SBJPeR+s+XRGbBYqggHSzDdqaWeZDFn2LZHVunvZ57IaEEef0JkPZFd5x8+Ls+BRZ++yXSdUHDL5/XbSL6VXrEOeTRA+A2IOi8q/6jes2k2H4KMtzYtmWE6NLu8IewSmF+i6rDPl/iZpnvWluI0i2Pil6dMRRf6So546bjJA6FrNq9T5Rqbj6U3YDENJDjoNPlw0C80WiDa52KX+GsD3eJL6SOhzO5MAYN73XpSCm3ZOSFo92eLIKCjVXYyJBSnV+0Rl44F7V1sbN4jNt5ZRTo8IqobE+GVak3MYNux5kNJtsKMc+AWhG0J+YOA+Z934VX+GbzXhnzF6zUot4Uh0Mh2vdZ7IYOuQLV7XmQewV9Y+54pcxB+xQIM4MEkHVShKoAdmJFI+LqaKYY6Z9L41pNWzseAeK9IdPyXeXp5vuGBlMRF1ZXJpJglm3NG06RRlkGpRjnhF3FJidep9TJ+OCZiXbAIyHqismM0QPyrUH4OOwPeLAT8DR21rfWYDGhZ7ZBhN+VZnjFnXOVfIqDp2KqMiU6ouSBK+EI/Hr6sCc6ngo8YDsKF/5yQlIs2OYMUsw1vw7bWF2U1/dWqlXeThuSJlS5Mq0eo9v01pUlTbmZ3rbwd59hUPfsFGnaIJhgxN9/H8yO4otYw4slPMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0c9b37-4902-41f0-c391-08dbd504a2bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:46:49.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLqdukAjmJEy+XDm1SDt4QVTwDNnqAO+0fpWRU/gCrw+eJvwmON+jXoKxVRfQI+YJ97Thz3ASY5HCA2JPMX3n1aBiWDCr/XP4d1Asar6mWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=861
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250022
X-Proofpoint-GUID: QCkA3xUdhLWZX4URy5X9GnwjmKt-zWJG
X-Proofpoint-ORIG-GUID: QCkA3xUdhLWZX4URy5X9GnwjmKt-zWJG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel,

> utf16s_to_utf8s does not NULL terminate the output string. For us to be
> able to add a NULL character when utf16s_to_utf8s returns, we need to
> make sure that there is space for such NULL character at the end of the
> output buffer. We can achieve this by passing an output buffer size to
> utf16s_to_utf8s that is one character less than what we allocated.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
