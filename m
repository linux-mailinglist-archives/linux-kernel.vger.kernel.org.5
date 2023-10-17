Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420C07CB767
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjJQA2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjJQA2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:28:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5A292;
        Mon, 16 Oct 2023 17:28:34 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKOBHd013099;
        Tue, 17 Oct 2023 00:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=9tuy9uBlgaTFSE9NdOq4/TrqwGJbQ7E85LVIvugzRdg=;
 b=RUM8yymecT8FcoCtu9DFfJLbIUZSkXe0evSdlZiLZuYb/7+2MOKxzbdcltlylB4dc6lQ
 6UgeguAX7U/wf3jI1VTIbsqbRt+3jmb5eMnJ7NrBml1X9UiUxKndsurFBlU7R+MkeFq/
 Huhxi0Rj5GkupzF8zSGDHKm0IV47V7QWRaEQ3HBGx/5gLFIFOuakJXUwZvvMwlMNDrxQ
 4dVDn2ltADLJX57SR0DTHb57tkimpAIAZr77+Tgrw+ihqnq0K4XRSjjuSp4b6MN6r/jr
 2yEgCHHLNPEKdiXSQDqlIGiIPXeQg4cAth2/CahrRb+m09/Ny1ldIrOSp0D+wk4ZmgAS 4w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jm0y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 00:28:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GN8qWW027119;
        Tue, 17 Oct 2023 00:28:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg5350tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 00:28:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7DBJ8L3ANJidM/Rc8Mihhae7Bte/0WEo21Rxhm14WBGKvgDWdle63+sKuqbn0MaKv7SPqrggaMk+0PPAtd0y23BqUytjbvm+gKM0Zpj+Z7W5/VbwLTwAIyVUzb6KwGeyWQqBZushtsfudzn4OvALyrnil9Q8TyGEerM4NiWvw0F0KLR4R1fFUo5aCqTkNsgJU3sPmoYpHqeZlvuCKPzFNM9kjeQIsN0tp29TzGOcaxCoApkrwyUJ77MDuqkz3k4/w3/4tVqN9abctGvq3obKFph6PXNFIhy7v2QhJ1wNx/E8tWjOVVgJ23ISmRJZ0oPVtP65sGQxsVIBDmBzm3Y0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tuy9uBlgaTFSE9NdOq4/TrqwGJbQ7E85LVIvugzRdg=;
 b=BP/HwaexPlrLwgSlgD/mRN1+T0TpOtdJckZYuMrCu4Q1k0ELYBu1OlLUrCYVZbhbd/L3ZZ+Fod11ZXlcOnDUDEUHcjQWMPvQoh5KjWJ8iP18R/n3/kwQK9LAOGEPOALMJsuF/Q1HukVwa9F8hnw8hRbJfEqSs/Vbmdd90Mkz+fMiiwXBy5atJh7xF0bWb2C/OKwaC4Go/vF4jUm28pG1OYYKI5l71AkamoFk/T4J2FJdtJci7qinBx3im/6upLU5TeGlULQ0K1bpNr+zQ6gN7/1+PBrOOfaSCEGET8HbxLumRgtKgip8EB8wOiX12pdlg8ifYORxluKgdfMA3oujOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tuy9uBlgaTFSE9NdOq4/TrqwGJbQ7E85LVIvugzRdg=;
 b=AHkecmsIWum7+XmeeWnsTQLw81YDmY7CfIShdihcYZy5rJ8STuHwENKenlz4p6MXEKbyLFeXKI4ReQEcQgN8mMoOnVi4kthPJSqk7HN6gSLIQMMcywNbqfAI5mNh2SdsoC+WbBonkGd4QZ/XSLIngYZjQwgbjRzuPtE+N2ZiLY8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB7681.namprd10.prod.outlook.com (2603:10b6:806:375::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 00:27:59 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383%4]) with mapi id 15.20.6863.046; Tue, 17 Oct 2023
 00:27:59 +0000
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the scsi-mkp tree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8b6hz4f.fsf@ca-mkp.ca.oracle.com>
References: <20231016160616.0286cf0c@canb.auug.org.au>
        <1676c7c1-902b-4604-b411-b313c529c3de@oracle.com>
Date:   Mon, 16 Oct 2023 20:27:57 -0400
In-Reply-To: <1676c7c1-902b-4604-b411-b313c529c3de@oracle.com> (Mike
        Christie's message of "Mon, 16 Oct 2023 10:25:14 -0500")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::31) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: c8060bef-3782-4945-6453-08dbcea7ea8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGTlQP9eFhG2x9HeNzPUbOmysBiZ5WFS1tiPTFLJr3J4hF62BqK0NxbWEkGxmiy5ISvRRVtu2xoNCfAeOs58uy+RnrUsqOuevbDOih7kRoUwJvuf0ueEBisTZ5FxFsh5D1AFZaYMbRrvQznKDYn/KWHqwTZU9pEAOOfAqkO90DHL2iNUaIwMSecknYwbsTor0DsUvquBWcrnjotl1XjKlzgWpNhqWC8nl3NYZUp0vpBLPNmeAdGwnPGaiSZldbkNQef1YkAzw6fwkZsWxnX66vLIdm1moUQrmGYsTRKfgZDUVDERnwcocTDiK22p6WFJm5rYxks5h7+t5nzr5Xvw64w5MxMncj9jGFQzUxCt+qg1B31c7hXVKAwZOU4qYMeKiFJL8G7fRlcgPy1zLolMHrgnIqDOchDDxxTG0WHUsfsvZ9d8vKYsLijqIJBvcm2c2gDNgnZtNdyiA1O1fEKJv0F6cTXlGjmg7dBYVpHzq6j+Ayr4iBsWvZ6A0F0lDOuT0es87emGtRIFNnOvc3hDZPwCffDuj1OJzO2+/k947gtYytbKfEjcOwMctemeZEnR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(86362001)(6512007)(26005)(2906002)(36916002)(478600001)(6506007)(558084003)(316002)(6486002)(38100700002)(5660300002)(4326008)(8936002)(6862004)(8676002)(6636002)(66946007)(66476007)(41300700001)(54906003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mV/kSDEjdKNl2zwIJlBaai1DcpyXYyDkgTUFP7/ZdvwuDr5gvB650nCXZHET?=
 =?us-ascii?Q?+unKfWAFN0eLJtLXvSJFV6/BW1lVevAxC+yiv+1OksRsRpZMev6OhRJW7QYx?=
 =?us-ascii?Q?Kcjq51COmIKpqduOnRevX4N5Tlp72Q4xV5vgl/Jc1MHbZd98Dmm6FpM2etEL?=
 =?us-ascii?Q?smewcBCaeph/UkIzCYxGJQkfExNXSUmGANUmvwG5dVgu71HqnxpafAq9L01s?=
 =?us-ascii?Q?6A0sXclX7fwQSxihj317NiPH/hoAS3meNxRvYlDe0WlsyWsEuWsnOH58Dv6C?=
 =?us-ascii?Q?xWGEhoakbAMYCB6F8YIpXwmRyVam0BsQiz0W+l33u9AO+biVhIGt6kzo0zGI?=
 =?us-ascii?Q?69wA5DIxW6TpWoKV5E3i8Ub4izD3nDc310u5zk3BFhYYfxz/BRSYTRTTrkI8?=
 =?us-ascii?Q?UmUreZu2f7dxjN96EgwZLg9jq6SChLuwKrHXyT6hCRPUZUDo7Vy+zr0GvXL+?=
 =?us-ascii?Q?iyvaALF2UDcP18rZl1oyjUPi3gUB18NGm07dspndG9DtLZv6uHrS1/3azock?=
 =?us-ascii?Q?hIjqZMX3BtsZsFVqJ4EYb1xx+OdKNpKhSmJr4jfob6CXEJsqBi9R7M7j/pZX?=
 =?us-ascii?Q?pS4icGtxYlqUMBAEN+TcTODToOJxPvqO51PvesivmbnAJFDP/dfmaepGWsEP?=
 =?us-ascii?Q?Vx2DwX4uU1hhDFxvTkJ2nhM4oXvQvHNf/4gE8GUAFHPXF7Sa9i+FOX9yvxEz?=
 =?us-ascii?Q?kqXut19RwrsYTEBa8jPV3/DE6myxDANVNKXyJOFViPl+P0OXUl+BiM+Te+38?=
 =?us-ascii?Q?VBw55tfuq5/IYtOXmXahCBfMupeyDDOoeVQEEElhXgJw/FNOIf8N5RYA1sAR?=
 =?us-ascii?Q?XPwy9JDGCi9EHPyIHCTLtGero0FHGvjqG50BwQxDiG6J1Mzft1tG/r/j1wIo?=
 =?us-ascii?Q?Eyb6WLPeDbzWPWMy9UTZTakYYxSGWqzev1S88i4MI5IKLSqcb2M/C8WNYEbC?=
 =?us-ascii?Q?hCgrj/QCdMxzb6OBweejK5SfjqK/wSN819lNbozD+wim8pwvmT7/0qjEzmCM?=
 =?us-ascii?Q?yeT5enDCmuDoVFYZz9rBfHm61vhG3p/wUOgu9rvKfMu3Sna60473cbwulUo9?=
 =?us-ascii?Q?W6KqrNewadbmuwWrwr+Di225YFcV+oh4iJZQUxG1PuwndAqIYkP73NrPSZyW?=
 =?us-ascii?Q?89YjfxD4qHZL0xg4SqP5o1XguQf0kGsLO3Vkldv48mNXcqFDqBEEBwgvBx4x?=
 =?us-ascii?Q?chKr0x+EJ9bCFv26DKqx3s0UdaQErXkA6vzUmzYjc5rMLuUc+vc1w2K3nUZI?=
 =?us-ascii?Q?8QgSJ/x/eB14Q6RfD5ma1JRLOSBCCLcAZjuuhtlZr+p4sJXH5IEscV4NvwV0?=
 =?us-ascii?Q?lqRVv9HwUj3qEX30zjOsE6pTAA9D4iIbKshR+ZDfI3JnOGOiY3ejQTVrD7Ex?=
 =?us-ascii?Q?bkTCuJ44GcNyVTMI0GWTjjtFeN7JVxm6tp7z3ShkkVJKDbdJQpOGwGCqru2i?=
 =?us-ascii?Q?L+KkVYF5Q/PRMko8716eRZo8dIyZHv2SkJH35Z6LjotVxHCfC5IsvHvn/ZoB?=
 =?us-ascii?Q?wl/yoX4bns8tVX4M8uw74efnKnDiWqKGCM4a/m8NrGzj1KenrmF7JRkmq5yV?=
 =?us-ascii?Q?JkRXwa2NlFBhmyaNrerujdgLsJNcRz+nHa5trujodC3P7Z0jmLYY1aWMiaJo?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SBNY7OVDNDrjJGSRVkd0tkO3SK+1IglHmMjQpxDW3PHplAW4CG83+f6huRUMuyjpebvqZnEaMDqrVjKDYwPpY1Xx+kLetbYP3GmM8rLCuCQ24PJHDU2/NzPJcA8eUBC0vg//dlJbr9Fz6um2JV8RS0K6feHmZaqNoNzJH+TgNF4aCZuQVrgFBklrLvM+/dXJFZ9l8faCxIjbEE5J2jjcWm4nOktoi38Qz1RwEUsCLVNEbCqysjK5vnXVinB5l460YccnBtrc1MPblyr8tQfRXCu7MN+1yTfH4CJg1SdS4jc+KivfMILo00NGel8xQXePu0I6hFDkEJlu9X0SmD15hmYfqm1LD+bdG89tXNkhDwWd3jITaiBrWJhxT57JVYOGSjGHPrL3Pb6GT76y5S57xi67/lx/qqVPljgjOVGPYiVdDi6783f8K6K4t1xJoUFWEDOe+5lieqhmcSXClcYiD2XZwF0cdgTHqj4xRiHuq0j3q35zb+RilQ8H/cgBrYV+qDJF3EuCfUm0VqplLVVukstUHhqkoYcGVR4QDhGiVuwY13rKxyyEsqO4usMa8bGB2J2c+cr8mvymIE5AsNKSmL048RElAgNul21qzKI+1+4W/x7b342smIuYyPxh/eg0bp+ozvehKxELSxpgQ1dWC1ND3puypz3LNMgTMlFmJMcB/TGBUYNc2B5oA7RQdoi+KBOr7aJVBUbjh+Hv79ZtPm23rJP+Hmk9TyZ0mrmPOjp/FiqGi2wmINrp/jqOP+Sh5fhiW3Rp2YD0r3JS6qhBbsqrmKgaIhSTpuD1LiTxfMtckRCGtvIYupnguu/10R3p
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8060bef-3782-4945-6453-08dbcea7ea8f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:27:59.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuUeLmY646aOPjPwXfT4aeMT5ucOlop7pmVYUx7LWxMeKq9rE1HNt4kxPXHMPgDgi6Cp6zdEFiwKe6KdBnF0QQn1iTmh2eC/e4wEKU8OST0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=730 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170002
X-Proofpoint-GUID: M7H5KcmqA53zx3_dw73PJlp6anRo82L7
X-Proofpoint-ORIG-GUID: M7H5KcmqA53zx3_dw73PJlp6anRo82L7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mike,

> Or do you want me to just send the patch below against 6.7
> scsi-staging?

Yes, please. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
