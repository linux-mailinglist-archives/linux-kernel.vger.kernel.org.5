Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0476576A095
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjGaSoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGaSoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:44:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9995E9E;
        Mon, 31 Jul 2023 11:44:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTGn0014514;
        Mon, 31 Jul 2023 18:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=p9gFEzrVvQwA3+SUflp5pYhZgJiHL1O45UCmwNCIiyc=;
 b=B6bRH5+94AVmJmki3Jyw2Wd7sqQFp8J2Mso/0kFUro1Qebfd6KSPfM+0mihsZr3jl2hz
 aZRT4tfCn3u688dTgpZBQqoWn3hhy+Q65KTbk/gpj4fypNf4ORdTSAA5bRlcRENNEB30
 6Go2vu8XrdLjPsLXcMP2kgau8cmuB87/j9qvy1f5nMwVcyiJiha43cHuVNXaY6jC2v3g
 wf9kBmDokEXZCWP9VCqDzFIB3lbWumzA0lKewtfQNijLILhAltnNE7HEtpREbQsigy1A
 QpC/m30imyAXzlpc+pf9PW0KcclGEvDqf3nbUIUy3lBLPCp+Mq9fWpZuPM3zZRakkPhe tA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6e3avg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 18:44:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VI7YVS008582;
        Mon, 31 Jul 2023 18:44:04 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7bjfmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 18:44:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnsGTluZU95HLxIcbRba35EPT4n6WlNi2GLiZ+oA1eNsM48PC6RHrDoB9XTpedcHGtLNdXs478VG4nwbm6E7XcIK6aHEsjmrTbf9gMxPNJ4HdPZjEFkcBB9GIffhDvFpvgIaivcfph2m71N+RfiYoBZqpEmZCBRp1Ad2DIgpFlhTOh8TY0HeSpBUc2bz7CP0OVohV0f6/vgCCscA2YpS6pRaeQ6qxf8t4cwx0lKUWpxyrL/5argmuhnt9BoA0mL6sGKhOyb7z2svwV7aTsGDg7JeGfcLfb3Q4brBkmmRqgbd4txzZtXYGSdb3iZC4WKT5f4+HUNt2IxkvaQ801ANLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9gFEzrVvQwA3+SUflp5pYhZgJiHL1O45UCmwNCIiyc=;
 b=APO5lAUgKQdCJFiUaAWMh3zEvt+oFHns2C1tYcL7ZLR62Fv5JmyBjV4Pn8qSjtQlXE9JlRJkT91JLpYDUM9whVTca1cSUNwNj4k3hEoNO4husVqhIxH8cM3mqY0nR0Vw6e38vxTarRGbQ7lXzonk08Ob+wch6Tb+EneUTKuvNy/xSdxiRtgAe73nbJrwmhWAi3VfDdJ7xxW+2rZdFEppo9bjFlKes7dfwV5DzcxOjgqYx4I7NI6DjA7bjiUL3TDB9jIKw3hXvXHUCtH2iVB+fJON2Z5HDRyrQoG/xExxQZuwIPkCvBQCtFEsUibsRtSxK2alUcsj7b76EECbKShZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9gFEzrVvQwA3+SUflp5pYhZgJiHL1O45UCmwNCIiyc=;
 b=e6oPlWyPGgdIQz9v9KPJ0dAZ3depMDmxxnjns418bWWGsDrv/bsQ8kpXKLaTOl+69DlGPImC8tSsaNZegzo88eTy8qMJtnHbUXMAfSCsIhfmjTMEOJFhAIy3pC/CqtGUeXd2fJ7U09Ogf0ERClAHTaeW9Z0YExkY+gueeVwn8tM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6608.namprd10.prod.outlook.com (2603:10b6:303:22e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 18:43:37 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012%4]) with mapi id 15.20.6631.041; Mon, 31 Jul 2023
 18:43:37 +0000
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Saurav Kashyap <skashyap@marvell.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Laight <David.Laight@ACULAB.COM>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jozef Bacik <jobacik@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Rob Evers <revers@redhat.com>
Subject: Re: [PATCH v2 0/3] scsi: qedf: sanitise uaccess
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edknrkfk.fsf@ca-mkp.ca.oracle.com>
References: <20230731084034.37021-1-oleksandr@redhat.com>
Date:   Mon, 31 Jul 2023 14:43:34 -0400
In-Reply-To: <20230731084034.37021-1-oleksandr@redhat.com> (Oleksandr
        Natalenko's message of "Mon, 31 Jul 2023 10:40:31 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: bb21c468-954b-437c-dfbc-08db91f60d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAWObGLlQF8KjrradMzbFPVoMxYnLdBlNenS2LpjdX2nSh8wzObcF2GYym4krhxppH6lW6caYFOwAH92wG5I+9BBxbFL8i5qw7+gaSZ3OUMv30GUe0icfAYVCJzBfz4T22kH92R02QnoG7W4Y9DqZX7swbfV5n3mz8BcDwP2GqSnA+1ylidGBAyuqjl92R04uB1o4AORBYUQgoC4U9lXqwrn2eG33WMiHEV5l91GB//5IRhdVtXUjCbVdFq30hT5Pdf7wyo7f7qWk8kU8DMWtMSohgC2r3SYbhlArxjNyiCQVEwYUVqWvdTkrRB0WKopzOIKMolzarOX7Hxlhwab3BotSpIk7OUNbXWhLQvxwX8PswRbz2qhsMNMI9GCs5B1IKNftjpPKyrSANR2ojOxdAAyxOVXOiivLtj6rGWzp7/715BE1mHMjfSeEIWJsw7mVgYcEkmgDYmpgSPc4wXEHgjhasR/Fy02JVIohov3tV9/RtrbDCDGcri2GQEf4osAe4Ak1D510joYgeEM53o2uTYaWAhQ1v9HM8b/8DDWN6NfESgou8eab5W8n/OI5zp6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(2906002)(8676002)(8936002)(7416002)(4326008)(316002)(6916009)(66476007)(66556008)(41300700001)(5660300002)(66946007)(26005)(38100700002)(186003)(36916002)(558084003)(6512007)(6666004)(6506007)(6486002)(54906003)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GaXGu78n7Vmb8mf/D3jvQr4miezecl7g0Mbzw/dBNmdoSYJzOTu6ShePCmsq?=
 =?us-ascii?Q?tLU87jUhTHUG3ohaJR0DhmqzpFtQcUYwocQBzBZjpBGXFRXofp0wZrTdG83l?=
 =?us-ascii?Q?fgqHs7YW9FMeBeX3CzPLfaXw2MkwNZvhQ048ulWWtc8ahjehk6Yajz36aXXX?=
 =?us-ascii?Q?XjXqwq6QbUrfBLrWr9p/fDN3cXy1LdM4Pdkykp2gvVyyNlw8TiZ+YIBV9fps?=
 =?us-ascii?Q?muD/yL98VyQj96hlOZwfR77eVI5SkkAY0WOLLt70hhlxNoCOYGWR19hgkY+d?=
 =?us-ascii?Q?7jcS8GBtPPK7GSNwrivXT2l10NqYHOnHSJEUjJPdTb5Z/qL/7C6EsB5v4ItY?=
 =?us-ascii?Q?3SXRuua8wLgu8p7pFkqJIksvcaaAeh48WS8XLz/YZVq8sJJ5jrSB80EIBstg?=
 =?us-ascii?Q?gUKTprrltKXha+NSwAH83/mrjAxP/gpcQZzsQddZYIMDhTKvSckCS6MP+B6Q?=
 =?us-ascii?Q?YVmUyxeIqQ1R5dNMZgzYmuuJqz8B4oEgg7cGqTiHuXgBN0urU1NnuTLQ1x3E?=
 =?us-ascii?Q?pM+rSgQZ3IfVwFfBHGLAEupAeJTWElU0vkf9pS+mXTxkIv1UThZKDduabL+x?=
 =?us-ascii?Q?bgFOyY35Tzd5dxlUjjsmdFtouG/XbmoLTRRk6jtRUK0cIWmnG4fWPhqdI2K0?=
 =?us-ascii?Q?RFv4z2y/y8FrasVB6Bg0yUHs/S+oLreFKOc7ahojDNtyiqlggnoLcTCX32xr?=
 =?us-ascii?Q?Kdt3dK4CKPLR2qSwUUuN7gNBsZS/9NWVUGDuC7aSgCBmwyQJE+VgTWJxp9vg?=
 =?us-ascii?Q?fk123nrrLsQyIUn35rZAweZEolEJufIqPDy8L2OhioY90ler1MCWkGVv0cH3?=
 =?us-ascii?Q?7mMYLBe4J5FlK6hNuiOEpriOUAkJdaIyt/zMxw3KEZNIlTIoJ9y/N2LtnwbE?=
 =?us-ascii?Q?eHcJKiS7daMYBXHaKESlZJ5l7ZkieMYb9z74tl2aLr9ZRx7kUCQ9lcHWGQBd?=
 =?us-ascii?Q?27fYZ6ExsjdxXP1pPdS9mrtKZKqaf5GJIn45A3h1h5LUj6Ea4vPYMM2veDVg?=
 =?us-ascii?Q?rYx34K21MY5vg00VnXAm7HiLo3TuUacWUpa4YCHESMsgKHvseW7l5GuhYaNh?=
 =?us-ascii?Q?Y3nUNEK6HzVjyLgnobS+UQ7kr6aprHIFEzmBKCT4nVeAhnrdnG1/z89A3fQ/?=
 =?us-ascii?Q?39rXW+yLwcrRrHJAYSqNstE6mHYd7h8zI2mtM5Al2RC3pqKwCfNW9n/OSYhC?=
 =?us-ascii?Q?LCyBpkZc3uuaRmFBxgIxpTb8CHFgmOiM6cY9XKBKtNoeQbzYhgzeCVCHCDx+?=
 =?us-ascii?Q?eQpDfPYczLec/t1kOkTBMkHe5TBz075CgjslRpsQnFV/ISreDXUW0BiUsgXO?=
 =?us-ascii?Q?zJdEedB4th2RegBU4RoQB4XNpIYSTrbqtPS7URDl8HsMTGchFrHO+jIFu5pc?=
 =?us-ascii?Q?HjUIxRw7CzrQgvssGgXqUZsHlJA/+6qk0LDoPVnUEAmLdAK6eAwjUWmjRutx?=
 =?us-ascii?Q?SyrrqVnYMqUDo548x9bgcd+xxH9boicFrBg+pt1gkSW+Jgi7VFTaR4me1+Hj?=
 =?us-ascii?Q?0LpIffij1WlePcD6SLzDmG26Lu7e76X9jhRC39jlWpPKKow5tLP3QDgCNFP1?=
 =?us-ascii?Q?Ec8MH4t6UQwp+KYhrRtCpX6A5cOJy/8dJlE1zyHGdd+ytReMsLB3DA4C25+p?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RRGbc5oDcmLbVo+UjFlSKL3feazMWKcqCtqo50UiC/jAv9X2Le1YORUHvHOHJrzoiDwpgvxFSj95azZwNDGVOtSvhAJdPKRSl8T/NOFnsddmbRDqWtPRY3h3aVPI43G0rcv8IqEQb8kl/27rdm8cvRPzIXJ26jK7UBXTSX57lOFvCaxwOToiSAQvhtGAdEr9iq4RzW3RsTeg3KQ6DOCnd9HUzKJOvXbrkJJ3UWcx218EikfYLFlr4uXY8ctHcAOQykO3fB85UPUrpEK4FGF+LE8yT+IpE9MhkZ3s4CVzT9nhhwoY/+MIEBPL6IhFoh4b9jSKzEOYRW8ilN/Y/6iI6KSC9c2/zAorcjah0H7LBA+3XlC1bAI+ti4vNd85BsMW7S+wEmMcr9Ct+beD7l/ejntLfqsYgQBOzzIwBnxFTJRQWYFge2asZXmYGAuNZhmdSEzo4n6EtIUJweqwPbqCfQTL/iawt9eqelsur6pz9KzCYh8G1VwKlXDUednqLF6gW9VE0zWrBGXSxVq2pXTEArdN2p6nJxjxiNrw7fhmsI3ZOegkmHGXuQOKhHP3ofFRrCmPmnqx6WiV9dRUFijZ+I8TKFKLfxXwW8pr+kgzuN4SB8xftR4/XCKc0CgMdQMQkQrfzQqQDjJc0DLb2L/wPb3R+bbt8Kvst6+9iQy/zvXW1GjSi/iRZSbpmwrk8sxQa7GRKHLP3HYucqxNZ6N6McvzYrc7qT/3zpbchdNIYs7f4ddeEgfwBvQlU5E9FQSqzhvZZy6gqJLJmruIzG5RdwGSz0tDuHzDSN945cvWDf/8p1jvZmVCyVM9DUjIIl5i5Ba0nDd0Dz3qnq7MX9RnHWJ0eQUU6saVHxNVQa2pJEyfaHxuzSJE5F7bypvyOT0ydUxH9Ap4u6f61lq1O1AsuS3IzF4n119PUfL9x/Vid1I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb21c468-954b-437c-dfbc-08db91f60d3c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:43:37.4333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKXsM23L02hw2bMS/2TJPDsLxswo8pynw8Ixgfw472vHCjSXj6jXUBpUktMoSpzqxnGZpqZCuPIb6PIaCLUf7ca9eTWNUBP9vvZ5ZasLqD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_12,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=884
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310170
X-Proofpoint-GUID: i1bhtFCm2gvxMYGnvSUwncxiQGeVWg1x
X-Proofpoint-ORIG-GUID: i1bhtFCm2gvxMYGnvSUwncxiQGeVWg1x
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Oleksandr,

> qedf driver, debugfs part of it specifically, touches __user pointers
> directly for printing out info to userspace via sprintf(), which may
> cause crash like this:

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
