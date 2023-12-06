Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7192B8064B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376659AbjLFCF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376654AbjLFCF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:05:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20923181;
        Tue,  5 Dec 2023 18:05:32 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B61xN3i009943;
        Wed, 6 Dec 2023 02:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=1XJatTrftw2DrWuEV7+zjbvEEDIRuJ5Swc1yNvWg5F0=;
 b=N34P2tY3IQkQjk8HzNzSFuSjcDdL491AnLC82H2ALZFwM5Ik53gyswB6Cn908s2i8dzN
 OPiefkidQ3gTXVS1YG67qdf9LP6Q+s8WZbBmfzXM+Fnzboxvp6EnhzdGwe8l3OCFZS3K
 ryJaSHgpHMK7tV+VOVeZnvnC/UShQqysaGxE27Pyvi0Rn+kos9o2Zj+5/XnOTVBVoAps
 LULHtb6gwrEXBLb9tFT714EwD296IET0AsYql3kizo8z8dDZgyq1VfDAkFo+6o9FnpkA
 /s9FEQMatOkzhKPNDDJ9illI+07W+gw1PTHsIgAIDXZH/IZtMqsfwE5kBOH/csPfox0F Sg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0hg69y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 02:05:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B602Ojm040024;
        Wed, 6 Dec 2023 02:05:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan54a79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 02:05:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9HzPXec52UgMEloHL38Kp4ahQAqvtffNF/9wWeK3v3h6ttBhh0oXjL4iDetkL/zRmVCdamDpjJFgwHlSmlbEJlrHD7CnnAf6PmyKAsP/H3Cf1/rQyLHskmKoc7ZjGemDWOaPWXTn9UCtnDxyCCCAxgM+3ggCBkPJpRNSz2GvVy5vRMa0YJkPP+hXZpdv9qrccwIzF/uwq4+1Y25wHZpQsftYnb1LVuZOee65/q5TflbkNkNLXSzhSLu7j54WwbmqC6Yz8QYDMmpmOwlIQkn2mfsd7Lyssz83cLKq1lyedomz401hFj0LLnny5xmmedC1mXos87BA8Tnt046Z+HTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XJatTrftw2DrWuEV7+zjbvEEDIRuJ5Swc1yNvWg5F0=;
 b=FbRfbkI7OoUpNg+bbhjhpBQRHpa6fI8C+bikY9/tBE58rcWWQ8h2pjHaCu10gWBPGpGkDqK5DU5BQCvr35C7ST2SaJHwxJ8if1bbJIsNyLtKvge29qMU+opWyupq4E/fH+rqQHL2fNhnSS7hWN+L316YMTuMxUPwXRGdj9dMAc12jAqJ/8MJh/IwXx8U4DAtkD9fCrEc3DJmtUK3S1RC1UD9Bkbz1wvpHSA1WosXusEOeHjH+bez1owzjGzFo/9VhVgciyiVsCayczqApl0uL+p1HIk3DSU5TyLGEQ8KD0kAJV/Y7a79bQ24MmjWoL08maklNWyVOz3B3WEYDCBTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XJatTrftw2DrWuEV7+zjbvEEDIRuJ5Swc1yNvWg5F0=;
 b=GEXsIDaoxtSz4w/3CV/Rld59ODear3qF6x2EUV1b3Mz50XfDKS3uhPEk2LkgjPPzSRsY5/2cor5a8LT6FNxZS3SbW81u6U6pd0aXUX1McGNFGJQ5MtU99q04GtyQUS/B0PkrX9lvMxT8p0L4l/DFlmU4Rjme3bl++a9OlOXLlUM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB6769.namprd10.prod.outlook.com (2603:10b6:208:43e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 02:05:21 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 02:05:21 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     brking@us.ibm.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ipr: Remove obsolete check for old CPUs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edg0nl0n.fsf@ca-mkp.ca.oracle.com>
References: <20231127111740.1288463-1-mpe@ellerman.id.au>
Date:   Tue, 05 Dec 2023 21:05:19 -0500
In-Reply-To: <20231127111740.1288463-1-mpe@ellerman.id.au> (Michael Ellerman's
        message of "Mon, 27 Nov 2023 22:17:40 +1100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::11) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ee01c73-81c8-4557-56a3-08dbf5ffcd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTyzBESXTSGZr+kYi6IvlX/Id/V8nP5qp+kgLlUPSCVNmip+EWjbsA7mXxQgU8nuG2+QVtIWZum9zYcLPNn4UTVaAQnv4sc8MPBPiesA6vLv9JoNoaGofixbaAFdmw+H1fE5/HeC9WuQkL+/s71aKGEwP5kqty0qcetKBMHcZxS13fJTJKpvOV9e4ktk+gLqNPT1rSgLtola2qHhYWYjtiWlxK80XOQr/x4Oq5VON2qYwxJ+Dv6KwAdH2UQMrDR1qpy4/x43SBxf04Tin+d2CqwS/zmASsvyswmnpqLfNRfNHFk+XRjXbjpdXcJ68au0ioFkd0eSPAJaLcaOCL0rIuVILx0j0eactEreLuUi95hRhz6qWujS/fYXiZnu/6WzuO7fx8mdbmSa/Rbzi/csYI1UGpeiHFAwW3SCIC9hp97Nfv6LeM12Vjpv3EyoElN4MxB6rGlNc442TLxygvROO0c1q5HTlXNMmzVnprsTzyoydKQ7Hnc9eVK/xvhj2sZxq8cYClSQyqnLnUSDTRRqF2cEBs4Vom+b8SLvNkIWcHd1AXNmgA+e2PvfEjdEkAjJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(26005)(558084003)(36916002)(6506007)(6512007)(41300700001)(6486002)(2906002)(86362001)(66946007)(66476007)(66556008)(6916009)(5660300002)(54906003)(316002)(478600001)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0msEexM7rwwKjYGc3+0+HwbFJulQXAzFN5tksYx6p4kHiq1jBY7jjy0LGgFy?=
 =?us-ascii?Q?OAikKO1tk33DTVATo+FuOnxqAiXFW+yW5ftJQ0mUmwGlmK4p4ADrCSv/lTaO?=
 =?us-ascii?Q?ZJnA/rmqa0HXpkVcXWaecPtYJF6IXF4uPHvQzY0TQId4HwRBU/Xr6O46HWCN?=
 =?us-ascii?Q?JkJ8V1W2yb94mnKRYrfe7AMlhlbS49RVaCCqAkpDBOq50y0Wdi+TvrmFrMtK?=
 =?us-ascii?Q?5yWBjK5jW8HiBnN6F+qz+HGfwho/flQfRWnXj+Pwn5uPSikZiC6yA44ARGEz?=
 =?us-ascii?Q?1mhPlad7sxcn52Z2K7rqe3ADudwhdedbhtFeWEThYAkPm5zyu0L2WLO/dodQ?=
 =?us-ascii?Q?j6xdIcDDPO/yniH5PBq7J+3GUSAw0lRGfl8vkfMT0TMzElKll+OQOq1UKJbb?=
 =?us-ascii?Q?caWpHihyB8yXkARU+tZEVubyvDl/GwvFjXJ+GA9oeEtch1oEfvSUjmEHkh2o?=
 =?us-ascii?Q?J8Ka3CQZ8E0VGkwI/L4ogQRt7txRQr3aHyTT3RqYwblOBUSS59CBlDF5lTkU?=
 =?us-ascii?Q?+KQJ1eX0iIW7Q7IG8x3nHGkXt3p8ah0pzycXOJlGfZqXC2zgIGrlLA/Bi0EO?=
 =?us-ascii?Q?d3mr7Z+ylRqjHRyt02VlrxcEGxNao3MIErrSRjGkg2oxydtBAMGDPjinx49o?=
 =?us-ascii?Q?ia56NRstIDWFPHlz1ZCnmuoTCSoxQ6iqSJ9roFm73kUk05W6T/DoyoysrbAN?=
 =?us-ascii?Q?ZbVWxEs+/+1pGjwH1MMOpLYf7d6x3c7Jg9Blvzk6nAaGwR44aDqWcPmsBoCZ?=
 =?us-ascii?Q?ktOK45VBkWfk2wjwY7KN3GA7po1+g4WjOijapWTlHqDYlLCs8mgFtbM6/OZr?=
 =?us-ascii?Q?N0uvrn2TUtazMZOCwcxvbrMnh+G05puyvjZ3COKVrIoXRoplS4Sp5Yu70B1v?=
 =?us-ascii?Q?vudTw5gw2zNXb2MhjDnx7r71W5e6yHWjroXVEvw9PSo4MwjyvhR+D6vbVVQB?=
 =?us-ascii?Q?E8eCotak7ku6crSjVLHlD0kQcS0esD7W5ifzqZhQOTc+CM0mSf+A0y5pyNKE?=
 =?us-ascii?Q?zWWAOS1+TOHaz84XmdhiQp6BY4Rlsn3IVqnsTZF4qf7IcsJIOCastA1puveG?=
 =?us-ascii?Q?flQZgExi/6OGu1p+vn3ZmfkrzFTbYEOe454xwbjZ2x60WW0zhJxJFHA2nu9Z?=
 =?us-ascii?Q?ur+w2EpXhpdB87RNIPtqkB+Tkt8D07t6T9UxOBB05WUS19fb98yVC5FlXlQN?=
 =?us-ascii?Q?nL9+lENxmpj32paKT6OYVlpIxjKxpupjy8ODqGRcrWof9zjXGbfpe5vUREVr?=
 =?us-ascii?Q?3ITK50ZswI8iVwEPvW4/3bjqrPU0QYuk1LXhjccClr9f9Wf/ojSKuJkVYZkK?=
 =?us-ascii?Q?qLWrfDk0OIybsUxDA8rfJoWr/AAMMsdujPTJs+mOxOWBTWBARfzOIZCzK/dc?=
 =?us-ascii?Q?wYyhf29GxpB6PPlqnRWj4XGc3QYQtvvYYDY77n76sj01zX0E/nVgVW87PAQ9?=
 =?us-ascii?Q?ha9AqXwpZ3NhnDwuLtUjo10gwsRuRHyZH1LVZnXADVeXk6pSAAwgOvB92r8r?=
 =?us-ascii?Q?A9JkXsE3VdFhpUu3Dihdo7/A1W6h3p1TiVMscJ7k+XGTLA83MRV3P3BosH1f?=
 =?us-ascii?Q?L/NZcU4KksthNuexkja7ePs2bGO27MyhQIOd0igmtP+nb1Cext381HqFnINF?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y6BxIyyxWK88j6zVODLMsucUc5bo9t08V//VsTFZK8WwPdBF5SVCUhmJ7r82McXa7QtFnpq2xcnUL4tgyys9fGb3d0C7/xTynAVqBjkhxa2EgRNkTfv1w4z8LtEFhRQx8mvKio6ON6qPQabWHIg8JJZ46mGA+Xz4wx6HE9UUa03OmrvnCPbMo67HZxixnyRAPOk+v0VOk2b1njN67DKFeB3tTPYeaF82SZiuJHWs/h8f7ixNnCxC2Q9/keN+bnLlXQSBBZAuoWKIIkkp8rnjj0VfXfZak9Ioymd3qFSmPCOsscrUIRpricxaFE4Z3/rTP8PRivt1vFA0wkjBKyoXAM6I1HbKjoaxhOIdGs/7bxGe2q3D2d8QEVSQtT+PFy9lVAq3nHWNrnzWBlfAm56PZFH0j+MaGlXNb+zvCKW6BPBykDcCv2vNu4VQSmPw142sSWireyRHDKrrbWoZT8cw7ZAARtbm2vwR330m1ej1V5WzC91eOx/auPzKPQveuHGJhagYTmr5G0Y6fsqYACrhZts3k+iApGWjUmZfp2Ym23m9qzRIc/9wK2zaRJo6KTWEM4yH21pyAMteg278j2Rw7xG57D5QmLEdfifasda0sL0kkBIUYv3y4WYCGAfQoxgMX9L8swb2PDTskQNXUkTque/XfwgKqKBZE5i6wCOFcwKZn4+GMsrKwqY+Zt19MOxDI8RYp1zyhKh48ZjJGEF+iKyHJXy4RfRxLOMEFyTSowWOXt25DF5NBR7nL4/OXH9P1N1ZHhOSDeU6f4iNZn6UNQPiPUhJk8NjQ5pryh/Luh61wQqE0d0oVVpVrkcEpgcQUFAJS++eF5/UkOhCts0V+paBkdL+Wd9wIMQhhayCUgAjlEgk2mESo5bqg9mFvqGSfOG/tBXelj6eWKLkRGy5B1c+Z1I3Trvwq+P/YILhs+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee01c73-81c8-4557-56a3-08dbf5ffcd35
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 02:05:21.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezMKrHl4UIcHoXb6ZbqqMUtaT2k9nA0XS0MmKpnaLcMC0x0jaCLVDHkQQ01dn29ELgwttK5dj1Q3tqIexm/47Vpga0prPTMuvBz22G62G8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=858
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060016
X-Proofpoint-GUID: w3On1zy5oFL0sZ7T5_UdU0-_UYVtdfNf
X-Proofpoint-ORIG-GUID: w3On1zy5oFL0sZ7T5_UdU0-_UYVtdfNf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michael,

> The IPR driver has a routine to check whether it's running on certain
> CPU versions and if so whether the adapter is supported on that CPU.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
