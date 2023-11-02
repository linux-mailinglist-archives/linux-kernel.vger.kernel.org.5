Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5055A7DF8DF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjKBRjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjKBRjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:39:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBB91AA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:39:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2FkVn0010208;
        Thu, 2 Nov 2023 17:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=kYxNKZkzB5u4PMifGTCpnWcO4j2zOuZAP9VaQoNk36k=;
 b=Qqbayr4fFxUkM6QEBOSoJIZJdGm1ZqnBJ8KQH6VBri+WwnJWK43FyQ06KuMF5hoa/gFh
 NfIMJJbaY5zbmWwdNg4R/fQ1SjvJU3tcdGzrMdulCrCw3oz4C0EtFEESsV4erzyiPDik
 cKgY6zz2uFV/XPgHXjag6W6MIatac8hC7vL24ZBuCD/DPbA9Li6D/mdQ5HNSa59j/8KM
 hcrnAKLy/HsxGghLfzrLbC4bE4BdC5bm2mKP8KJ73tQGp1Y6Kc8ENYorKBVDu+XGgvkE
 4tuBMzw5TwGw3z+Rjxfo9FxfR12TctZ3fXO3eQkt3E2ASIx86yYhvzHC49nzBB3xsBOe UA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tuuja23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 17:39:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2HWIT6020096;
        Thu, 2 Nov 2023 17:39:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrf5j5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 17:39:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXazcPJT0arROzrwYW94u0XEPgMXuKL70vmJkGvNugRN+IWjeo3Zhr9Yjp6xqUW23emTwVMa9lSenyY1h1tT9XR4twTy6v82LqRJORWuRZdU9aP7kJTV1UBY+lTkFxIX7phHhYNTdCjSQHeW7e3VbP44U57/49KzAiLcmzHWSg4n9iC9WB7fR4aOIkrZpUHYEdtW1z3yDrELcKPOF8z4zsNB3s+ocmigZLcoTiXMj3gNkrq59M4V0DNtMox7rB7Zu7QB08qkgEnDB/HCRq4fTy0dO3s/C+gCqa0B/cow4aeTk9Hdpd2X/fjSQZIE1HSm5NTw+arlf+aURVuPwgYSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYxNKZkzB5u4PMifGTCpnWcO4j2zOuZAP9VaQoNk36k=;
 b=QH4DI56fXdr/9OkNNcpxx8V7EFR1+zGv3sTFr0o2uZXG2WBYE5DqUK680SZc+KBeGpRCWAZgQLZCz0rb7Oh9ydYcQsDl/T1e/9iImH4tVpSR8miqx5/yh/oMdbTwohV9exHijHbHZrhzUD1CzwRaJS9xzGOaqpt1VumWxmoh2lM0GeboK3Fj/bV4KpKh/Aw2BCWq5bJ71Rlo0OopLp2ZTNgdfBlXW89FnNSpuPWoR8l77gTO8YfyknVl+0MkoUTdKjAchzjWirhbUVzQw5xMBPns1YseaNIxMN9qoLk//TKvZab6RVLxUqO5HtNkCMhTBQ+zurj1WYnJ7fx31TEWDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYxNKZkzB5u4PMifGTCpnWcO4j2zOuZAP9VaQoNk36k=;
 b=LfKs5CS0JRHrnh2AJ1v3/O5421SyFfzlYFKjBZiSFebFvewbFqg+yXbNEWxDQh3SIPn/dSIRrbikDEtZWK14ljkkUgH/01hbaehKHvDOL0hYi1qUmCBx+Joa/iJuSFxZlOQ8xnuqgY9XdeOl7IEL/hKmXOcvmth+pTmM+bs1Wd4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN4PR10MB5589.namprd10.prod.outlook.com (2603:10b6:806:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 17:39:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Thu, 2 Nov 2023
 17:39:05 +0000
Date:   Thu, 2 Nov 2023 13:39:03 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] maple_tree: Separate ma_state node from status.
Message-ID: <20231102173903.f4uizdrh3shj4b27@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231101171629.3612299-9-Liam.Howlett@oracle.com>
 <202311021622.6KoUHJP7-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202311021622.6KoUHJP7-lkp@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN4PR10MB5589:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd45237-2f68-480f-398b-08dbdbca9c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uggG2jPECta92D2ynRYt/FO16CVAKGabvHMBfbEVD1edDgImWJrM3wSwouLJtO7i2CaYMw2Oj+ir1D+o72i9m3UIiaCdAGUXVQ0gc367LUtplXnNELpqfFxdkNgys2GkHPJNnvigN9Zz8+qpRxBQsI4/LKC5VRXgpE5oWVUNBIspE0zBKKBxZKK2+Lk8w05h61Yi5OaIjoQYx5Ic/oNtWmAhV2BoQlBvlYSX3+XdVBYLuw+JebSaA60kVcEbIL4BlMrkl7PbSn5vcyhRhTxE+sGEe63ogV3rLW7/XQYw6YcEpVNlztlDy1M90kwVmCO9JP/sAanE0bXpBls6RDedYMXFDdNmKj5zlfABCDtorkaReYWxe0br5hldCG5Q+VpoQtiBi7TxU7YdkAAEgRBgSOs1L5XeaxckEjE8fj6KbqngCrGOQlpyHuxe0zEIv9A8ZqymbwD+aMUQLcWOUIZ6SNesghHIQsgANQu3dbpSXsgxMx273/8Aq/HzvKaHzkUjTRkm7W2FuXaXHL+MkV86IPN7jy6VEx6NYHOchiFwQZaLzCxjyu9r4djtrAswdNRfgMglFhL93IQdOFgjUzCEorTvhKq9e6cct9e07erFVlput5jQSHsu6/7Ej1AFO9HEOM8Q6SsgIU6Aec6b+cqNmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(39860400002)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(186009)(1800799009)(26005)(1076003)(9686003)(6512007)(38100700002)(86362001)(2906002)(5660300002)(83380400001)(478600001)(6506007)(8936002)(54906003)(6916009)(66556008)(66946007)(316002)(66476007)(33716001)(8676002)(4326008)(41300700001)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GjVwxzcafup0x6UxVEdcNuDBuIdQPt63TvMz5wYw5R55FXknrm6a/sCQCh8G?=
 =?us-ascii?Q?3oiHq5y4yJBxYBAF5XdM8vdYjZ3HxVLD5yI/4qBS33ulSmfWifv/+40SMHSG?=
 =?us-ascii?Q?nsJ5AcpRZso2w9EgNSCS3C4RXcxx5mEq0F95zzCFOucfZQjtvx/kobJa5uAu?=
 =?us-ascii?Q?wc01z1/YOlMjJm+7hKxGzMwlti2aWY4lBGAZU2prLsT1G/XNLtRR2GFu3MjT?=
 =?us-ascii?Q?kwcxtCTGVLpwBfln8tGds+RvjiPAtgJVxJjoAj/ADCiwchWAS0Eu/Pv2Ffdg?=
 =?us-ascii?Q?wARmz3ton5qDoC/4FSO0yNgHBEojX5UJqPjPZpT1/aMl3I6doIHKAUFBak9H?=
 =?us-ascii?Q?hdgvIutJLCSZ5ZHWMr1rkpA8J6JIQ+qiiNoNRvuFZTBIzyU0JG5uR0eWiAdY?=
 =?us-ascii?Q?9lyuNK5m3f1VAPyMBQjghZy7/4N5hokSwpVPqRY+N3ZG/64His9BT/wEHdl5?=
 =?us-ascii?Q?YS4c5U8BoC1WPZ3HZdb2MlQMxTt9V6koFiIObMn893SwE3l6tjShTrvk+Og7?=
 =?us-ascii?Q?3UDEdoscX/6/YcNGR1LmN52sBAjnUSB+AXDXuh5tpMY0XF2gTzlPcmgUIoUk?=
 =?us-ascii?Q?8LwXdEme1lsEejETBY7Arij96VcYgWbrfR3oOATEUstkJwj9KrYlaTvIf5XP?=
 =?us-ascii?Q?Ru/fW46gF2Co3lRSMV5rC4M82x25F7g7L6r39cmFsAmvf/BhIm83juNBIgEy?=
 =?us-ascii?Q?7zMAh+CuWQeTAPOQi4Gsu+dqo/Eyxo4theijMF5CYx0Rh9IPi5E0NTSEJ4HC?=
 =?us-ascii?Q?epzBcPBKQz71IECFjLW/6aTxxht8eLNPQ7FOz04ihqhIE9gyOhFFeVCWGiCk?=
 =?us-ascii?Q?Zpab0K5qi5QmWHO6xmS00VT6krH8d198+q3lc8AiK3JWidSQaMPnZaBk/UJa?=
 =?us-ascii?Q?zJGvX9KYXEsINZ9sUrBDZBBPQExolLm8SFp0HBphui4HCLNY/BVubxck6Ree?=
 =?us-ascii?Q?VxXvvFEM2WrKovM5ZZbkw+FBEXAo0mOqO6W65sh1wQhSUqCnoexB8NxlYVO0?=
 =?us-ascii?Q?vzEaLHf8l45g/YP8pq3z989Pd9ZYl4jDxEWNyYwHZwxi6nYJcs7MnmvMs2M8?=
 =?us-ascii?Q?0lRwmv1EndH1aTSI24bF0OZj+7ZAGddM2EM4AV2J23Mo2aYPOd4A9DK7tKwS?=
 =?us-ascii?Q?Zan05N93m/L9ji0fdgfl2xlXEca4X1RN90irBThYS17fb8XYPhwqobQGt66M?=
 =?us-ascii?Q?RvqByGtLRGMpDsyf2aoiS1H/QggH+NTbZTN6JFQrKVmAewmQ629q5dgMkyy/?=
 =?us-ascii?Q?eJoIQdY/kyhKY1Ycb5fZdUDQYyn/AJtlStau2lxQjjFtUR2JK3CR0HWDaqHr?=
 =?us-ascii?Q?a2zW6GFFvKb9bGRsUpqXIX2w4f22fMeAA3ciAVYwzq6vFJfbb0iOEEVHBM/B?=
 =?us-ascii?Q?JMxSch7i5A5K5G2ShgKwiYy80S8Cq5Q18tc2t5Dj+Ai49P3r1wRGurNf3j7Q?=
 =?us-ascii?Q?x9qXM7T6u6j8kBdeZgY4cGxgZrFeoxK/X8QiKw+SkWy+M4MGoT5q+a3RP2+g?=
 =?us-ascii?Q?vfDpK4HphJW0LSeLETeA5PUNxR5hzCaFn4S+1Clzo9M/akLIJgtLOnuzp1KC?=
 =?us-ascii?Q?WfXXZzTZkZFOjR4YxhlBm/gygnu3+oZxsNPeTq9t?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CevUnE/HBFBGSBQA84r2TsAARfg5vmosWKCzoESfeD2gB6k4yLDY9n9N7DTS?=
 =?us-ascii?Q?NADbJWwVWtsLKoNsrdALGl+zGZgWQ4taTvy2l9EPgjh/KnT3oP54AXQAxza5?=
 =?us-ascii?Q?IfAtihZeffxGhL8JRhYPILfH9+Y62QVymXyIwLpFjtXsZ1cXrvgJE43JTk1O?=
 =?us-ascii?Q?HnFE/CCFHEuP6tqG371vq8nUZTpBP52od/lIFwcI+6Dnz1qXszZvODmH0nCY?=
 =?us-ascii?Q?2agRtk3AAu/UiDBkgqS45GjGs2W3PQH7M0xGljyjfDt+W4sRhmfm9DY9kzR6?=
 =?us-ascii?Q?BroacPWgiXcwL2/1nyspMTeE7SsRprJ/Etk/sp1J+B0Q34wEXk0UsvPoPhjg?=
 =?us-ascii?Q?tOAz+/sU+dtJgezHCwfJPkgFXykBq7cGBvodPaycI9Ee15GLiF0urwoJRiSb?=
 =?us-ascii?Q?1rTk3CVcyIoeRBCP4MKejP6Fs84KVoxwZPNcCwPqWJC/HHYKRBJ7OmlpZSdr?=
 =?us-ascii?Q?c8yEgxSKghau2R+hRSK2XMCPHSVuA+eGSuXe3mRw46uOksUyxv4E0OQOCH4o?=
 =?us-ascii?Q?FJoi7w9W5p2gRImup4zjJciiZGL9AyWgmMPvcNpnA5N0prirSSceTKgzogkI?=
 =?us-ascii?Q?sc+zCssfuphv/OakBODm/DhLRTX7rL82UOFEEZlxvBKYuYmOCAkoipHZ6+uo?=
 =?us-ascii?Q?F3MygTeDkRQX8/ejV/bKUx3U5V1JUldCHcvQ4W7PXIY8GxFAe/dnx+n7QFl0?=
 =?us-ascii?Q?YY70aqGWxJh+HpoCq6lRnETruBKcs3Sn0qHceSBbzz5J3GoIlF9dvA1konpd?=
 =?us-ascii?Q?hQfIq0Oh4xQfdPJu8Mv3U/oqAeRVDUpfGfy1xliKjqCP3uTRW7uzQQiwhb0q?=
 =?us-ascii?Q?Bom2Hj/G/Ix9/HNTNIsNoVM5Bfjs6gxMIAy2FX6Th6novqZ7B4q4Y5yR3W8j?=
 =?us-ascii?Q?9WW3adUXtMlRHW6+i+kAqIOv64ZxtfxdIO7lMSKTc5L7KcBsVn4wMsbPXGHP?=
 =?us-ascii?Q?zxILGKdVkirtgheDnqaGjg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd45237-2f68-480f-398b-08dbdbca9c3e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:39:05.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyQ7N96G+V104tO3fxMqSgdsBVN6jXnR/WCBcwbgZK/2TIMQIxvorWLWvRSIt1WzQu88CwVHhYfryCbDzIWIhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_07,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020145
X-Proofpoint-GUID: xgWHdiFjxA3qO7SP10eeXmwqxd2JD2E2
X-Proofpoint-ORIG-GUID: xgWHdiFjxA3qO7SP10eeXmwqxd2JD2E2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <lkp@intel.com> [231102 04:43]:
> Hi Liam,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master v6.6 next-20231102]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Liam-R-Howlett/map=
le_tree-Remove-unnecessary-default-labels-from-switch-statements/20231102-0=
33618
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-ev=
erything
> patch link:    https://lore.kernel.org/r/20231101171629.3612299-9-Liam.Ho=
wlett%40oracle.com
> patch subject: [PATCH 08/12] maple_tree: Separate ma_state node from stat=
us.
> config: arc-randconfig-001-20231102 (https://download.01.org/0day-ci/arch=
ive/20231102/202311021622.6KoUHJP7-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231102/202311021622.6KoUHJP7-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311021622.6KoUHJP7-lkp=
@intel.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
>    drivers/base/regmap/regcache-maple.c: In function 'regcache_maple_drop=
':
>    drivers/base/regmap/regcache-maple.c:113:23: warning: 'lower_index' is=
 used uninitialized [-Wuninitialized]
>      113 |         unsigned long lower_index, lower_last;
>          |                       ^~~~~~~~~~~
>    drivers/base/regmap/regcache-maple.c:113:36: warning: 'lower_last' is =
used uninitialized [-Wuninitialized]
>      113 |         unsigned long lower_index, lower_last;
>          |                                    ^~~~~~~~~~
> >> drivers/base/regmap/regcache-maple.c:114:23: warning: 'upper_index' is=
 used uninitialized [-Wuninitialized]
>      114 |         unsigned long upper_index, upper_last;
>          |                       ^~~~~~~~~~~
> >> drivers/base/regmap/regcache-maple.c:114:36: warning: 'upper_last' is =
used uninitialized [-Wuninitialized]
>      114 |         unsigned long upper_index, upper_last;
>          |                                    ^~~~~~~~~~
>=20

From the above git blame, I can see that I didn't write any of this.
How did the bot blame my commits?  It's interesting because it cannot be
randomly selecting the author of the data structure being used..

Also, I don't see how the bot is correct.  Did you upgrade your bots GCC
and this is a false positive?


>=20
> vim +/upper_index +114 drivers/base/regmap/regcache-maple.c
>=20
> f033c26de5a5734 Mark Brown    2023-03-30  106 =20
> f033c26de5a5734 Mark Brown    2023-03-30  107  static int regcache_maple_=
drop(struct regmap *map, unsigned int min,
> f033c26de5a5734 Mark Brown    2023-03-30  108  			       unsigned int max=
)
> f033c26de5a5734 Mark Brown    2023-03-30  109  {
> f033c26de5a5734 Mark Brown    2023-03-30  110  	struct maple_tree *mt =3D=
 map->cache;
> f033c26de5a5734 Mark Brown    2023-03-30  111  	MA_STATE(mas, mt, min, ma=
x);
> f033c26de5a5734 Mark Brown    2023-03-30  112  	unsigned long *entry, *lo=
wer, *upper;
> f033c26de5a5734 Mark Brown    2023-03-30  113  	unsigned long lower_index=
, lower_last;
> f033c26de5a5734 Mark Brown    2023-03-30 @114  	unsigned long upper_index=
, upper_last;
> f033c26de5a5734 Mark Brown    2023-03-30  115  	int ret;
> f033c26de5a5734 Mark Brown    2023-03-30  116 =20
> f033c26de5a5734 Mark Brown    2023-03-30  117  	lower =3D NULL;

lower is null..

> f033c26de5a5734 Mark Brown    2023-03-30  118  	upper =3D NULL;
> f033c26de5a5734 Mark Brown    2023-03-30  119 =20
> f033c26de5a5734 Mark Brown    2023-03-30  120  	mas_lock(&mas);
> f033c26de5a5734 Mark Brown    2023-03-30  121 =20
> f033c26de5a5734 Mark Brown    2023-03-30  122  	mas_for_each(&mas, entry,=
 max) {
> f033c26de5a5734 Mark Brown    2023-03-30  123  		/*
> f033c26de5a5734 Mark Brown    2023-03-30  124  		 * This is safe because =
the regmap lock means the
> f033c26de5a5734 Mark Brown    2023-03-30  125  		 * Maple lock is redunda=
nt, but we need to take it due
> f033c26de5a5734 Mark Brown    2023-03-30  126  		 * to lockdep asserts in=
 the maple tree code.
> f033c26de5a5734 Mark Brown    2023-03-30  127  		 */
> f033c26de5a5734 Mark Brown    2023-03-30  128  		mas_unlock(&mas);
> f033c26de5a5734 Mark Brown    2023-03-30  129 =20
> f033c26de5a5734 Mark Brown    2023-03-30  130  		/* Do we need to save an=
y of this entry? */
> f033c26de5a5734 Mark Brown    2023-03-30  131  		if (mas.index < min) {
> f033c26de5a5734 Mark Brown    2023-03-30  132  			lower_index =3D mas.ind=
ex;
> f033c26de5a5734 Mark Brown    2023-03-30  133  			lower_last =3D min -1;
> f033c26de5a5734 Mark Brown    2023-03-30  134 =20
> f033c26de5a5734 Mark Brown    2023-03-30  135  			lower =3D kmemdup(entry=
, ((min - mas.index) *
> f033c26de5a5734 Mark Brown    2023-03-30  136  						sizeof(unsigned long=
)),
> b0393e1fe40e962 Guenter Roeck 2023-07-20  137  					map->alloc_flags);

Lower is only ever set here.. but lower_index/lower_last are also set
here..

> f033c26de5a5734 Mark Brown    2023-03-30  138  			if (!lower) {
> f033c26de5a5734 Mark Brown    2023-03-30  139  				ret =3D -ENOMEM;
> 451941ac1ee2be1 Mark Brown    2023-04-03  140  				goto out_unlocked;
> f033c26de5a5734 Mark Brown    2023-03-30  141  			}
> f033c26de5a5734 Mark Brown    2023-03-30  142  		}
> f033c26de5a5734 Mark Brown    2023-03-30  143 =20
> f033c26de5a5734 Mark Brown    2023-03-30  144  		if (mas.last > max) {
> f033c26de5a5734 Mark Brown    2023-03-30  145  			upper_index =3D max + 1=
;
> f033c26de5a5734 Mark Brown    2023-03-30  146  			upper_last =3D mas.last=
;
> f033c26de5a5734 Mark Brown    2023-03-30  147 =20
> f033c26de5a5734 Mark Brown    2023-03-30  148  			upper =3D kmemdup(&entr=
y[max + 1],
> f033c26de5a5734 Mark Brown    2023-03-30  149  					((mas.last - max) *
> f033c26de5a5734 Mark Brown    2023-03-30  150  					 sizeof(unsigned long=
)),
> b0393e1fe40e962 Guenter Roeck 2023-07-20  151  					map->alloc_flags);
> f033c26de5a5734 Mark Brown    2023-03-30  152  			if (!upper) {
> f033c26de5a5734 Mark Brown    2023-03-30  153  				ret =3D -ENOMEM;
> 451941ac1ee2be1 Mark Brown    2023-04-03  154  				goto out_unlocked;
> f033c26de5a5734 Mark Brown    2023-03-30  155  			}
> f033c26de5a5734 Mark Brown    2023-03-30  156  		}
> f033c26de5a5734 Mark Brown    2023-03-30  157 =20
> f033c26de5a5734 Mark Brown    2023-03-30  158  		kfree(entry);
> f033c26de5a5734 Mark Brown    2023-03-30  159  		mas_lock(&mas);
> f033c26de5a5734 Mark Brown    2023-03-30  160  		mas_erase(&mas);
> f033c26de5a5734 Mark Brown    2023-03-30  161 =20
> f033c26de5a5734 Mark Brown    2023-03-30  162  		/* Insert new nodes with=
 the saved data */
> f033c26de5a5734 Mark Brown    2023-03-30  163  		if (lower) {

Only used if lower isn't NULL, so we know lower_index and lower_last are
set.

> f033c26de5a5734 Mark Brown    2023-03-30  164  			mas_set_range(&mas, low=
er_index, lower_last);
> b0393e1fe40e962 Guenter Roeck 2023-07-20  165  			ret =3D mas_store_gfp(&=
mas, lower, map->alloc_flags);
> f033c26de5a5734 Mark Brown    2023-03-30  166  			if (ret !=3D 0)
> f033c26de5a5734 Mark Brown    2023-03-30  167  				goto out;
> f033c26de5a5734 Mark Brown    2023-03-30  168  			lower =3D NULL;

lower is reset for the next loop.

> f033c26de5a5734 Mark Brown    2023-03-30  169  		}
> f033c26de5a5734 Mark Brown    2023-03-30  170 =20
> f033c26de5a5734 Mark Brown    2023-03-30  171  		if (upper) {
> f033c26de5a5734 Mark Brown    2023-03-30  172  			mas_set_range(&mas, upp=
er_index, upper_last);
> b0393e1fe40e962 Guenter Roeck 2023-07-20  173  			ret =3D mas_store_gfp(&=
mas, upper, map->alloc_flags);
> f033c26de5a5734 Mark Brown    2023-03-30  174  			if (ret !=3D 0)
> f033c26de5a5734 Mark Brown    2023-03-30  175  				goto out;
> f033c26de5a5734 Mark Brown    2023-03-30  176  			upper =3D NULL;
> f033c26de5a5734 Mark Brown    2023-03-30  177  		}
> f033c26de5a5734 Mark Brown    2023-03-30  178  	}
> f033c26de5a5734 Mark Brown    2023-03-30  179 =20
> f033c26de5a5734 Mark Brown    2023-03-30  180  out:
> f033c26de5a5734 Mark Brown    2023-03-30  181  	mas_unlock(&mas);
> 451941ac1ee2be1 Mark Brown    2023-04-03  182  out_unlocked:
> f033c26de5a5734 Mark Brown    2023-03-30  183  	kfree(lower);
> f033c26de5a5734 Mark Brown    2023-03-30  184  	kfree(upper);
> f033c26de5a5734 Mark Brown    2023-03-30  185 =20
> f033c26de5a5734 Mark Brown    2023-03-30  186  	return ret;
> f033c26de5a5734 Mark Brown    2023-03-30  187  }
> f033c26de5a5734 Mark Brown    2023-03-30  188 =20
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
