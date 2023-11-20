Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7A47F17B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjKTPpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:45:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F52CA7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:45:12 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKF2fAm027329;
        Mon, 20 Nov 2023 15:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Sr5CYOjhWlLzuvceADxmCAWnyoDT1B4LMcPB7a2MXnc=;
 b=D/1Nxo3Qb/sLRMx0n18BlpfB3bTrlB/7UVP0Onol338XkitSdbnoKj5YdxIJ4+fUf1I9
 YaObm2dwZEjd6LEUi1LG1G8vjco720HRcI92RtHSC2LoMMHi4yQbeyNdgUeXbz67rFkc
 sZnRhYqZ1V/YVPuMCqf2fo72l1TVjBbb2+WNJnl5+cJq5N1QHn5zKlXgTD/0fm4NIvc1
 Gy2seUh+uebLo23hJe6ktn3BzGNMf5LC+Bi4OMEpl6nmu++I5PXpCHcvjQRed5yEBYWF
 GB1GlcFDvZ/OCIEdS1l6FTiM535fHeeAjVlB/tcBkuyfXvQCqEdxonsD5+Jg3hNOrt6x hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem24tyw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 15:44:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKEahSo000621;
        Mon, 20 Nov 2023 15:44:00 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq5akts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 15:44:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkHRN/K0MbCEnvgRfE+0DtwbM5vgJLZFVXT0hWrLAJTPYJ51X4EPc0tBLDvfG0fgRuoESfFC9atfSxUkpwdsnlpc5LafNAA5Ziua3z2BYHNnAuQ8wXsy0uDcf6TyciqHwmCmo59Ub/Bg0ymDTL6cLhdWGoA4XIVWISRFOJg0A4f/OCLlwiWF213V51jTmpXSWgWaFvyNnxHsr46e60wW+Ajq7vsGhl0IaQnlG5Kiojsl3kofFDro8rQCviFv6kO9oBhc/dFx9s/FzIM6rtdzQihdfeJ1OUS6QUTcSTNs+DtjYRtIqhQVF02BCAhq5S0Rs8TiVH9t30OTjfQS+CJqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr5CYOjhWlLzuvceADxmCAWnyoDT1B4LMcPB7a2MXnc=;
 b=m12686P6jmRpr+kAgG7qPqGJ29Ygs2ZFCFZqwhjlvEfQ7kxll94L4PhQTZqtDJ9W5ir9jw3AlAJlT4ALSIia2nvruQ9h205wbLXfbncywGl30Getk9QknxyP9Wvnio5SRWSRCFJmipMRpiqQV/Qm1jlu6DJGdN6fcCwedvdJQUlnLEf/ROtk8JR2c4FGLcLsbBccoLTgonh8S5yhlY8lckTj8F7Sh0b9I0SkearSTn65KsXAGXGiFuCi3JCXfOy2igGQ87J4+XmKUeXhHJVPse6REn+S6cEdfKDs3zPEDq0fELyqB3h/4g0Pr6xWU/e/k8RZilSCHPxtSTh87agYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr5CYOjhWlLzuvceADxmCAWnyoDT1B4LMcPB7a2MXnc=;
 b=NoS+uMouqhCAr5X9KevAwzRNNE6fQhVNWjl5AxbDAswzRiIW7O00wRSQRDPYDXKu3JNFCgsOwpkFT03eRZplqDEWj4t+dWYjgLPyNRIykgTC1LA6NKFXfErJJBEqEEqcEGyJD0zhrlLj34XQlqGCmyoSl0O7OaAh1zgKt5lQsnI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN0PR10MB5288.namprd10.prod.outlook.com (2603:10b6:408:12c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 15:43:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%6]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 15:43:55 +0000
Date:   Mon, 20 Nov 2023 10:43:52 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     dan.carpenter@linaro.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 0/5] Some cleanups of maple tree
Message-ID: <20231120154352.z2cn5vgllprnnkko@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, dan.carpenter@linaro.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, maple-tree@lists.infradead.org
References: <20231120070937.35481-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120070937.35481-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0480.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BN0PR10MB5288:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5b9910-a713-4545-1e22-08dbe9df80b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+UKIZqT17mihDlC9E2DBQo8SID6WlelUyXrpU30x+PbVdE54Mj1D6LYIhaUTKFT6/BAfJwpzJ1xPWawK30guyH13925j/YfqTO57evNFlJr1wUrU+O3dA+21hdBcbKN6iCZIfN9maWTBAdSBKqmXN4gRxZ94DxFQuLCujnGivJTZAg6guegd8TS1cC2Uh8JemamEIpI/m0Dh4qT0lTlECNYjKnX1lwN43owTyWb+Ww8k9DzukW68zPOpRdiNOw4VdZU/aN94k/LI2MuSpaoZLkj47c2mis9GNsSTVDlMu944FLemcgH75vI5USjVMF/3VFm3+dnByb8fMiJHbiIm3FcRH6Viv/TZ6vELS9OsAqt9EO5nzCxS4OhZICkba5UuGZjLvvi4WwBYoZzpoEm+ZZVbf10jWwccfbs+kvQJlKZ9WAQ3s/CHiBTjvekfuUsfePYJl9CN54NKzcnfXo31H2PgmiGhu1tDMWDz/h2wbaE3VqUj6iOKd7aqOanMKpHB4n7L3AFrxBTjdk69dnFae8oqM+Y0dZoJQ0N0oWEEhP/R1OvoRloD+FV34uT+njD7NOyDNfOZyFQXaKGT4AlGn+XkocJojQx/Ojrif8yxL1X6Ibzcfz4vtlTC/ySNH9h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66556008)(66476007)(66946007)(6916009)(316002)(6506007)(6512007)(9686003)(6666004)(26005)(1076003)(478600001)(6486002)(966005)(38100700002)(33716001)(83380400001)(86362001)(5660300002)(4744005)(2906002)(41300700001)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0XDi/fPQKRdkGBgvUQsHtK76CuGtPqaMa6vWmBA5yV90SFO8lPf3MVCyVUGs?=
 =?us-ascii?Q?IPCb36t/oLzAMG5Asw0CLwi4wq+zo4NsmXkNUfne2Bdlcs405MjhZy+QdisK?=
 =?us-ascii?Q?Lb1363AV4/PK4UT5gt/lPv4btiRCXkAxVYYed99VsPVb3xNNE0ui4bts+iR5?=
 =?us-ascii?Q?sQa4m9WYNexWIgbdHU6+TTh8ZEOjO4Gqs7wt0yRrntgB7HVdgkEGeFb6J6XB?=
 =?us-ascii?Q?srNXsaebfskPBlJqti4PEut1FLZLRJ93ubAwQCUgV8FhvG1exmlVXAXps3gU?=
 =?us-ascii?Q?Mx4LwRRTXsIty7vN4bhZohQjgpDg0Ka7g0xJKWKUpJgU0vBgtHEn/iAB1ynC?=
 =?us-ascii?Q?wCMvWTUTqwzSYv8nrL6mQmVGKj1j/XIyrFBL8Sg1b24ydAqvUHBsOpP31gQ3?=
 =?us-ascii?Q?+tUJ+evZDO/0XR6+iXwJ84kv49U6h6eHdqH99YRYzKoiPrNsoURawkOgz5xU?=
 =?us-ascii?Q?iB2S0a2cu798flRbgHSnnF6j5Q4O4Y9DovrS+NHXKFwjGMSqhHGmiaSU/FKM?=
 =?us-ascii?Q?zq1jga2sO2cP6xRL3YP4azN9JKrpDJ9bzYq+ua9TnP2S2redQ9gFnV3kKwux?=
 =?us-ascii?Q?w6Hq1QWN6o+F4XVkfrS0XP7ekVjdL1zNG+767/qJsSYNads+fqREx1MxEbed?=
 =?us-ascii?Q?h/KUzLTJaA7i0SE+huOCWEgK/KxOppdOyOom+fq46DYAPRmYJJFvZT2X+cMR?=
 =?us-ascii?Q?OFuYv2URKGi1oXz02f0wkpn0PUppYnOowLQhIneoZR+yba+iKY5+PJmXn30Z?=
 =?us-ascii?Q?VuC99fSxryBsdMz0DUSuFj3wnMNdQGgRaRrdgjWuLa+5w/C7WiX2tJuLno8+?=
 =?us-ascii?Q?VDz5nlFleUjSQlyQsFj0D5B7njfW5XRcOlUc0gVG26PYjJGZRowHgndr70JP?=
 =?us-ascii?Q?MHXBI7gEGVJjodQFvU/mTXYbBHBUWA9kc9W6FqTUKXgmKv6RL+emC7z407A7?=
 =?us-ascii?Q?eoQIu2G032tnY7npRibzBLg4gwApjvG2n65hLD+AoFmOVljNS0kXCt4HDSe/?=
 =?us-ascii?Q?jNI7k+7yLuK4UpnSL/RQhKp3fUIlZ20Y1yXYNwnfdFI61YWFdZ5ncXxvzwHV?=
 =?us-ascii?Q?bqBTXn+nsESnpezpzzW/QI0HhRu3/hkMb440GK9GUESxcLsYN63ZuvmGQ8nB?=
 =?us-ascii?Q?ZeSg4xMRjFl6eb+uWb4qGLyUXyHXrZQrVvkGvVRSwrxbHFAQsgbtuRSSPwzT?=
 =?us-ascii?Q?yo3Qg+NGlMd5P1tZYn7roFvmAnWSmfHF84hng/QBGnF/xbXrxfatW2p8gJet?=
 =?us-ascii?Q?y/5GE5AWejxZjRXXAx/fE9Qov5MrIB7leXGP7fU8atKTzfkx2UoYvX2Kizo0?=
 =?us-ascii?Q?6Mgbpn3oI7OYBiBOJCNeHkSZKXB5l+g2EA1YKbkQVTeqf/rX2zAf3ZgeKx6G?=
 =?us-ascii?Q?cLvkebAoe+vVb9H3bZMXjlzMNnBB+pUg9fw9ESwsIaemN2+NcenR8tyUb4f7?=
 =?us-ascii?Q?q3gvnI07ftwA/MhwvXATjk4Lnd7eVwNdPv84Wu6gEw/DcTYapSM0Z/BzoIdv?=
 =?us-ascii?Q?lqO0Mnjj7o2W5ezez8/h7zivO9fwcigzhzZtx+Lw75nFmUNvfvMuIO6y98BZ?=
 =?us-ascii?Q?mX0ruxJRs8iwoOSNmUt61f9h5Wireb8UCXALnlW1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CqbyvaEOa087EEcOQZfIzTwX+1oYWhjr5sjvdBJP7SMyUefDZBTxQYmP1NfQ?=
 =?us-ascii?Q?LIrYgf7oRjFmYgjOex8YpLbUC+gYwgw7TsG09MrXdAFRmXjaYLD/MpAIe7GU?=
 =?us-ascii?Q?CMHvaZ0o22d9eZXgO+myU2lJepDJx4HjjDfl2ly9dciRI9ePG6O3tp1Rq4Xf?=
 =?us-ascii?Q?IpjiQOLtqCqDdQIDp9wbZEL9rWdYjGTyrF4Apes6Jd4HnsiKJodKPDZVggQg?=
 =?us-ascii?Q?wEYG8pIpc4mWkzLxGX4szSyboW6279ZQAXSfuIJuWraDd5lseLurHGgnc5MX?=
 =?us-ascii?Q?fm2iMxhHGf7lV0lpMzQTDKbDO8DqTi2jX8R6YFGLnofRXm0D4GuENhitWH84?=
 =?us-ascii?Q?pRRbMlN/OGbP6z3svq6E9QLzX2wyuO47ixruChj5wNPkpBwDtWDVEGa4R0cc?=
 =?us-ascii?Q?hmWtw4k7tw1bohIHpxGJhHrq4LUIVwMegwziGW/kzcKCe6piPS4VjF9xhwTW?=
 =?us-ascii?Q?87huzWnNRG7vBHoCMUizVXvNSud/kJo/UsvvjIkY8DkbH+JpT+9QlqJJHIt0?=
 =?us-ascii?Q?i+ht3abqQa2hEfUclfvLxaDc/GcNsmUHT8y34PFGA7PrS//1EgBXr+RmyDAP?=
 =?us-ascii?Q?cLIdRma+aSLJux0bOjjSBaTSl6UQk8xm4z5TAldDFiRR/dQAiOI6wm4BRinQ?=
 =?us-ascii?Q?4g0xryf12RpF4SjksXEskq9dDrSNLT6SjHoPMRHpx5hzlgJJnshTxc2UzQZl?=
 =?us-ascii?Q?w0JrLlnUAzDn2QN/3c/yY17CQ6kQSM/pf6vIh3VtipPfSaGxUjLfvJxfdDxk?=
 =?us-ascii?Q?CXdExwjEWINERdyRSUAP8pMgSJ9g/txkA4TNWSUjdTuxcgXQVH7nQH37mW0k?=
 =?us-ascii?Q?b03lFZsFg2qhysdtBVYejO++tykTBGMC+YSLBbRPNUQaDsxFKE1NcViatH/6?=
 =?us-ascii?Q?o9eNcDJR8Rnr28E4YbRpdz08a1FdwtQhydTMGTNMIsVbXV9xgkync02frum1?=
 =?us-ascii?Q?pFH+5rZE2CXLI+hoYk5NZQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5b9910-a713-4545-1e22-08dbe9df80b3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 15:43:55.1208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjevmt+RltgAUtaC10gQ3nig/2X25uqmTW+U1QMOJ/oKAegCQH+0ByH8rFQxwjUNwqM3VhYFzCG1yUYrmtuf8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_16,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200110
X-Proofpoint-GUID: Mt2bryQTEg662mBIebYB3SqvbQdp7prs
X-Proofpoint-ORIG-GUID: Mt2bryQTEg662mBIebYB3SqvbQdp7prs
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [231120 02:09]:
> These are some small cleanups of maple tree.
> 
> Just to mention, in v1, I forgot to CC LKML, but it has been added in this
> version.
> 
> Changes since v1:
>   - Removed the 'return' statement from [1/5].
>   - Made slight modifications to the commit log of [5/5].
> 
> v1: http://lists.infradead.org/pipermail/maple-tree/2023-November/003047.html

Thanks, they all look good now.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> 
> Peng Zhang (5):
>   maple_tree: Move the check forward to avoid static check warning
>   maple_tree: Avoid ascending when mas->min is also the parent's minimum
>   maple_tree: Remove an unused parameter for ma_meta_end()
>   maple_tree: Delete one of the two identical checks
>   maple_tree: Simplify mas_leaf_set_meta()
> 
>  lib/maple_tree.c | 45 ++++++++++++++-------------------------------
>  1 file changed, 14 insertions(+), 31 deletions(-)
> 
> -- 
> 2.20.1
> 
