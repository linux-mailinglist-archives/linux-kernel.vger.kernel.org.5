Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357917863D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 01:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbjHWXAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 19:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbjHWXAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 19:00:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3681E50;
        Wed, 23 Aug 2023 16:00:17 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NKwUmr008253;
        Wed, 23 Aug 2023 23:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=3XlZ21Q37itgoCBlPU+uBio8Ybf0mfsAOfRmN/0VygA=;
 b=4N2yZavhjonkvLyVL+yjkPQsE4H8FZ4gblB+6qZAf+a1/JDtn+psP+8aI3GBUgGdPq1W
 rifeZDd5LrcwN22SnZtZgfzIiOtHiu4DClXumKJJ/Mnl5BhVaEdF3L3SR47qftDS+i8G
 Gq2WA1W1o5rCXST0ohirhTlo6xdoLfJMQj6d0wjjUVxsu7Ud4epxFfLV62vZQU+aQbFz
 RDhJJMIz9eZ1RA9bDjow5BDSVuvbohoazW35FIENITlJlxOIYAXVkNAdZBfHX97K7AhV
 T26MixqcUtVPJA+sZnHBZ6RLaWTSP6usaqWZFJY5NsoTXNZVv70M65uhnNmbrdKTu9ZS oQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yv30n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 23:00:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37NLIN57036051;
        Wed, 23 Aug 2023 23:00:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yv7ux8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 23:00:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEffGPyNUznynp2Zx2GrVWgYLq8dMcm7lRd9bxqjCiMt0lSRjvNMOhWUEORb1+AC3XKyjbm8JuOmhjJJwoqS/DBhn8wfX6+1/+9lZ90tmpg83WBckFYFBGiV1vL/XRKLNXl7GtulXVE0Ea4I+fzd5N+HmzHSvUm4S3jo1xNbfwec6kLmSK2s/Xy9hayTHvgEGYfxWcELNhpAapkKkM4XTFhr+/BqPo/qoj7NgOq9cZ6U4lPd2t8fHmA5maXym1H2r2WHXKBthFC9uNX8d81dIyH787lpC6f18w7tOI4mp1EoPoh0UzeKvFJdk+jg7UCcLzIMW2U3GAf3D3xOFBlJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XlZ21Q37itgoCBlPU+uBio8Ybf0mfsAOfRmN/0VygA=;
 b=FjxifuDRstwuDvDvpRPx7VsJBDXh8rwjFwslnukUYOfI289ovWjafcyuPD5skZJgYmfVw9AYd/nlegMP2yXUtFqTKV2BJTqOrJBIJFCl1MsJwWlvwM0Wz8AoowUcKoYHZAi5oDQy0ph8xZDlDh7YYc7gb/0mxiM9AvdhdQ7FFBKeaVbl8I0ShZkk3UBdFIbAXufgnm/e9B+9HjgyRNm9GieI0AMJn66LVvN9oZRHOCLcA4rX6ARkA80+HtG2g+orX7FE/b6bxpHfuAvKyWS7Kxb36KwmNrxxmyJomuREyqlnexjEwJoM6+MH0urjGmCW2tmMWNWIaN/hRBq/BkAsRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XlZ21Q37itgoCBlPU+uBio8Ybf0mfsAOfRmN/0VygA=;
 b=yYo3AcgJuOZO5XpujQSdY9o14EA2XhYkN/4JbPkPpOTpC+n6X0w6gYW8DZzkITVm8TrGK90DgeehIwDIfzv4eVGmljfZUby/SbeYKE365XMYA9HtVkWgz8i27dnc2/6NJoZBQdu2aPmEikLngIrvJOe/T327juMd62PHH4bkN/g=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CYYPR10MB7608.namprd10.prod.outlook.com (2603:10b6:930:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 23:00:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 23:00:00 +0000
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sf894b8p.fsf@ca-mkp.ca.oracle.com>
References: <20230822153223.0a497697@canb.auug.org.au>
        <20230824085523.165db2d0@canb.auug.org.au>
Date:   Wed, 23 Aug 2023 18:59:55 -0400
In-Reply-To: <20230824085523.165db2d0@canb.auug.org.au> (Stephen Rothwell's
        message of "Thu, 24 Aug 2023 08:55:23 +1000")
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CYYPR10MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 2951327c-d0db-4c00-716a-08dba42cadb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oGuWU+4V/Co9uwywvFSrjD1RiFAqRMoChFo5B0Fm3/NjMOQgU3TO/oqXNhKJqp2wS4dR57FybsUS6befivxFryQkJ/3Ayg90VeX0Ehxh+73yjgLhv9yESvJVcIJFtvm5PMSXSTxF4AuWYjgNT8D0k937/hqeD2vvSODYbVzs+42Y12lwBLfATtCFhMK3BaAbvMIIwPMz/CutUf6S/FveB26lytSkfdfkp6UbfB6zlRGkFTP1zzBlI4wTzyMpQTAPx9IqaG62g9QtQKRQMGODhFtS/0OBC1A3yVAzvsC7xM8TGLC4PdxXk07O4aeWGCgDl86OuckbQgCtN0V35BFWIbcXjD6SKugDZsAURTvaNwtz+dUuRja94C7RGfvMQGuIvuFLjvdMs8e7r25kQ8gnPGpwVe1t0BA8N+f+RF+/qrv7bTGkKvl4TlbeyiYxwYbsMdEkYOIho+F70PmpsC4SF40H3e1wetyEcuX5OFJzE/fsUmD8ar/KjHiG6tRaRv9peVl7tSFp/bFrXSvXSXR1XBBS2F+2+NM91uyP2rCIKu7QnAsaanevdchKXFoh/obp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(1800799009)(186009)(2906002)(6486002)(6506007)(36916002)(558084003)(38100700002)(5660300002)(26005)(86362001)(8676002)(4326008)(8936002)(316002)(6916009)(66946007)(6512007)(66556008)(66476007)(54906003)(478600001)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sBfhfd+3Jdm48W1F4pXBEVXoyKM4l/bWCitIymEZy014Ajpv8mA6qgQL60Ge?=
 =?us-ascii?Q?n4T2SPaU6UqrnaduatygLUge28P2kOzBtQFoC5T+u8rJZDmvgb3dfHS9UKnC?=
 =?us-ascii?Q?UNGbkg8bfbWX9SC++bn6JLtLqUpg0WEFoY7T3nQTjcmABoLX87g9PH3TyqZ/?=
 =?us-ascii?Q?FGDBXdbujF1hGOZcpQZJY+Wbxnya2OuFFXUI4Qh+htPcJgV3hw/fb4y/wzhQ?=
 =?us-ascii?Q?ZBIzP1naqKYLPphzU1D04MiiAoXw3z9qQDChqL+gPgZZSE8ylXZey5fz9qoL?=
 =?us-ascii?Q?1IEym/YFbmZOEJleYZUeW4dEI2k0b24J9vQSVku7lPNmjKgputLG60dutBN+?=
 =?us-ascii?Q?g10PvjCCTy44qz9ONPDXKq+4TnPJQTmYMiRxDA3qDh+oH5e4v9Z9/bWUj/Zl?=
 =?us-ascii?Q?fExrQz2cfLo2BO93ZyD1Ncc+6o/M0JTDZBVDu11WOgcBCdICaEr/sc6N5yqE?=
 =?us-ascii?Q?mOOhDKUpabjcXCSA5z7EGOY6sJ4G26NoLYwYwoWGwhDnVDOck5737u0W5FAs?=
 =?us-ascii?Q?dkRG75XOeG6Lzx2+fcwCWh9O9Xhx51qnLHzTDN/pr04+xEJ9pNNmPr/PZort?=
 =?us-ascii?Q?zBJq3Rxj9VBJG9BluNMBlx9C5lWeIdLWeljmCakrt0AKptRnNp2vtASpprjz?=
 =?us-ascii?Q?qwk3ZP3fzFTP9+L5xFxMdHngUsSYvcPVu1hM+LRex+zx0ksY2ID4nEnDN4eE?=
 =?us-ascii?Q?4ZUppOkouaXu0eiQ6eyQcSgdKKI6Tf7BT5zzooM2uA2T0V8+/N+ch3PBSZtf?=
 =?us-ascii?Q?uW1pUVFCCsXqCvFkCIqr231hzsNpjt9olDBBaLgl68Zc9SkM8T0ujOR8LUu4?=
 =?us-ascii?Q?fZ2KAOb7OkQzf7WMmcB7sdU4LOOEOctAvDmTZaEqFqnsuL0EDquYonbJmRhg?=
 =?us-ascii?Q?ATo3S1xmwr4Oky858dvr0NvuIwgWyQUYjTHI7YYTv++2vjh8toO4rV3XOytd?=
 =?us-ascii?Q?k8r6zDW9TNtGeEfhRc8rXYkmCgTjxhq7X0dLHNRlW/ItA41Y/nCQ2DI/FFiZ?=
 =?us-ascii?Q?8Y/qQo1tdU7JSoEArwFtIiKgxSWykHZGfdCbeYGartlNOGX7FX8DuTtKCVE2?=
 =?us-ascii?Q?/J8heK0bm+fcX3SkIkbsqBJ2QMtMv/6TxxKiJb1pMd99379e4GVcYPAr89m6?=
 =?us-ascii?Q?9ez7n1fROK+27Kx7mxtmy/MwGAF3cgYqhIUWGmxGeFjzvec7xNB1LLp7Tl6O?=
 =?us-ascii?Q?GBeeQcQ3FShc/rybxk4X/U3cynk4t7X1JYDAmzQSsq0Y4YleAzLW9W8r2hgZ?=
 =?us-ascii?Q?X9z2dVC48585CGGwVT/P9P6q2YxMDrIWaSnjZUWh+I6RCQjklmxuinRFulN8?=
 =?us-ascii?Q?3yQfeA2w8ObkvGl+9X/fManJL75QjKMZpE+GeaqhZWJTZjzIzbcq/oBTlQLH?=
 =?us-ascii?Q?eM5Db0qiMOxy5cnyxDhymRrOQPr4O7jWDT05sf4MPT9Va9oe4NEhjIUS4prV?=
 =?us-ascii?Q?FgwsB/NaAXV9FwxuxXB/c+SPxiu6ruSuLY6xrBg8gewSuKiwRGbna+cR+t8w?=
 =?us-ascii?Q?6AsWVnwnCKC5iB6EBw+lltctz8CV4ZIUVEL2Aic/ZUzxq/Ae5Yyr9QuNN0eO?=
 =?us-ascii?Q?t6UsHDpOuF4gfMw9P/wBSVTkWmonHG1+f8n0M3M7KPedfFka7mgCY18xQ1Ti?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MrM5+ULxMGsK8uuiKV+aPU93TAxWEZ2I38XL7kcagg2GTnfeWqUtK8spL+Bjr8dBu8kysvz1DyVU3wILhTeNxn+qZ/ZLAi9755IsI62VYqlx6xHoYzA/18EB9lNCZMC45bVcYoKmhGldsydeT4yuVnGPLwJ+UlLq/F9wBJlkDe6nwbxMoc8+H9szMhQKSVolO3WvMxy+vblJZoDr9t7Yv/1Eb4PWoFwVldU54E1RxU7LWx2twfrdknxlJYhnO6CB6x5zGuRPYzLWcGM8yg5SiKHGqcGSNQHjhRZwwEpYyoZDPU3A1bzKuBVQmjsCHtjG+5+5QobeWQX6szJwnncgU4u4MU2gOL92omGARbxm2G2BkTm4ioeAeQ8Hi7RVBI1TooYdNT2MjxzVoPz4GY9+EBby+xnQbudtPMXS9WGytQP2DNxUy6CB+BXTXQ6GnDPoCQmHaCpyK25XcXtGbnopRdf3Ztj2Bic2bWcQG0r9dK478HwPcbltTM/4PFMg2k6HdeVqwpXx3cWIsfDMa+Vc5bfYN17HSPaVKcCNveTs9z9AjdX7SoooadN5lxvfzTkB+eW1mL3Zi2MD0abJJ7t8Ehnqfi3BJIr/rW57imAXRroKomok+PLuzI+AlxzYdj0OisY5CJh3kMUXNK3E3UPfS6COiXLu4WSw4Q/oSyi3zpneMlqPLIch7HuHULYojalvqdYGv9GAYe1VaTUj20EKH8Hsd42fw/oKgG77MSVyL6fYJSmWeEx4OXTWwZt0ebj1J0fedSQpjKYI/uSx9SAT1N6uAOXWhTTdijhuwiY5oIlFFGXljpScV+nBkVJy+8g684R9EG/CruLmT9YCjuIJ9g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2951327c-d0db-4c00-716a-08dba42cadb1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 23:00:00.4042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmuWQCYBXc1WXrnnHFEnV09BM3DfSB2FesuLfqQgS1+fEn5xc795tQj363umrSam51yJzAv4VZA2rKSXgTj0G3vdPPNh4ows2CwI5oNMvSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_15,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=701 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230206
X-Proofpoint-GUID: WDbmG-BzTRgvyRNPFLdXZzCvr-bLXavn
X-Proofpoint-ORIG-GUID: WDbmG-BzTRgvyRNPFLdXZzCvr-bLXavn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen,

>> I have used the scsi-mkp tree from next-20230821 for today.
>
> Ping?

Since it doesn't appear that a fix is imminent I'm going to drop this
series.

-- 
Martin K. Petersen	Oracle Linux Engineering
