Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9D47BB084
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjJFDWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjJFDVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:21:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FD5D8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:21:42 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3962Pdhg002406;
        Fri, 6 Oct 2023 03:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ts++G+BYdmdUFqdAtNKLn3GW8JSwEPzR7WlqhqbkpgY=;
 b=W4L9YpjywekoEZjjH0n4FHcRYLam6SSCpSinxXSFhbpAD2BBVvWOYIu8rFOzNdskjVjK
 YTE+Mut1YdouHqJJ9OArvuFyCAuh3wVynhNiHUERSMM0A2fu0X2d6MVLvOKxAf40KdNH
 ZcaY7egjo+yaX91/KxPl3+TScufb6Np9W5nMRk09ZqI0IDPDxIFWh1iX/dm2TN7K0aqJ
 icug3BoAQ0ssyvqUhCNjc8dH5xUiV96nNuW2y+lZQ/zeSKB3rbz0i1f9UhHPNBetO2b1
 RmaULL/02sfLMy74XNEObMz74l/ZSVfI5NviQ0frJ9EciM9WGj4Os2UotRqfDgZ35CPU Kg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakck2e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3960toAS002971;
        Fri, 6 Oct 2023 03:20:46 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49yq0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSO9hTXC0YBw/ofp/+LUk16b+mwsW4t+kUFA8uCgYFPWyusK9En9SBgKazaWHwH5c07pdtc56lUb8wNrrWl/xyEra2C/c2LZ06jepVXhuDhNaIcdwet2jpXQm0qNjfIsQLJ9+nBT4j3AX+PDodNLEU4gjTHizjZRiAfhme+bct8sTm27mrVAyFivXZ3UeOTSX3J3Qftg2bscgDbNaxZu76coGfSUOd/UGGXQFQRvJ0aWTTz2qhEi+2NfXpIZ0ne0KP6GRNc4m0h1XsLZ84qK18v9V0Qr+m81IJY0Lg7bQiYezBYZAjajOfBYkM7UYl/2ADgR8upx3ordJXeaRwE+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts++G+BYdmdUFqdAtNKLn3GW8JSwEPzR7WlqhqbkpgY=;
 b=ER6CjpJ+4Vs9KKv92IfWbfZeYFlWzUsfu1IHCoIP9SxjHgfSFNtKwpFU2w/sUkVGv41gridE2e/9/waTpC6cWb7GcrTMGX5d3eMZmrAa1KU71FgVX9RtTZ51NrOCd5ycWecwPhsxfgkIfcLSsH/Vw7vMuak/2wflK/KmD4lset6J3O1dsy11ZTJnFuVGAj9Z35oFrkxbozLj6z7M0sM1RKRE3R+Mk/iTmOFz+hNcVNo8wSQfEHjUnZcvAjUdT4RMK0HJUc9YZ7nv/a5843Trmz/bP605edVh0qI6ZilDxSX0RA4p9B+ayPil9tbUIRAIjNPBC6r0tUu5LdrMRrGj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts++G+BYdmdUFqdAtNKLn3GW8JSwEPzR7WlqhqbkpgY=;
 b=DECk5jqGuq+T4ojIJKIEAZe3DxoCRzIX6wuem4Q41tLq15H0EGRX1gFntkJSZc9T3VcSHGnmhqgH0X75wQC0ms/I4iw5Rb/v0OJpeHHrOg9v9UYU53Zxv2pKsNkq3LF88SNBuDvPyzCcWll4wmN4Lbu5Sq1aaWJDNaBuDmnX68g=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5391.namprd10.prod.outlook.com (2603:10b6:5:3ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 03:20:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 03:20:44 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v7 8/8] hugetlb: batch TLB flushes when restoring vmemmap
Date:   Thu,  5 Oct 2023 20:20:10 -0700
Message-ID: <20231006032012.296473-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006032012.296473-1-mike.kravetz@oracle.com>
References: <20231006032012.296473-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: f4302c32-2a9a-4014-55c5-08dbc61b39f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDUhy576Vei0M6EPV4/DzehaHW8FWsqFhiFJDWZ7swelFl9XFE5xsthi6SkoOLIdxgjYYOVNc2oBa+daIl8tqfbQw26zqX5z1jIqn0P805kRepK0svoKTyajO/3tU+pP/N5keBF1XbKeH8XSpXSEB5pERCQUhbIGQ1KSSagAKNL8jMOoCqpzD4Nj79bxIu9hGXta0ZGmqsQhlzTCTWgihH0YUAHTNSsxTT2qj/DQxtdnOlW2owMV6J2xDChH6axCk3INhnVnAo6CM7kd6OpLxsUcp5a4+OHUuXDzJl4mB+cT7c3Cjvjx9PvQ6RPid96AWW4nuFXJixd8hAjumr0JBD/tbPHDZnO1INRhO0P81f3kxm8lhlUvuTtX4jXa5kapwA4G3x7moPvjxGyfIhctbpCZow+s11aHHOQ8aQSsff7OCQI/gl5xkUZoylmU34XrENPt51g7ZETKzeOa3hDp62K7yEXUvsW2hwvmUyyzzbnJsnURL6s6ILioe9LsnJAKsQDBmvmyF3IzU77gHfDaKi1ZD6mwUQrD3SEHsSs2rsGbluSfR/tgNHcAARKzaqVF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(6666004)(6512007)(6486002)(478600001)(38100700002)(86362001)(2906002)(7416002)(316002)(41300700001)(2616005)(83380400001)(1076003)(107886003)(26005)(36756003)(44832011)(66946007)(66556008)(66476007)(5660300002)(54906003)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vkGV686udWlCGJwfKCCS7dwnslBcyl++oKGE0APluLZRGOQXYNFU475kPzKC?=
 =?us-ascii?Q?s6vAiB/anYlKA3gDN248A53XPuyAwiQkjypkfV7mNdqNacU9lCkUO951+kSA?=
 =?us-ascii?Q?z3wCBIBgfXZunLJok5vqXvY7LNzdYdfS5farhwhsUmJUpcbUY9dXSCfN1QPf?=
 =?us-ascii?Q?ThusVqM/opa3+BEqnx892OOwZPFWP/hKq/FK6rARvP33RgAAS8y3N0H3GRTz?=
 =?us-ascii?Q?OFe1prXAdwj+9a4HxI1BQuJEcSSmmuP4t58ueff09joyNOi8lEb9+2bDRuUY?=
 =?us-ascii?Q?CCOV+HkKdg6Pr1Zh0V2TD0hRiGAhP8VvM1k07l3vCmuKdfNvAN6le5Nj1RC+?=
 =?us-ascii?Q?zqB70XlT/RzizSoygdIZbLHMc0g0bNx6TVR0djQjelT+xCL0+jGmf2A1j9PF?=
 =?us-ascii?Q?McGByNUOAdahh46TIXfUFG0+Uq0DL4X7MtRNKb4OzgYOz+1eNgfRTH11fkpw?=
 =?us-ascii?Q?KmfOQcDEeslllwLF0yHbTdpFzy+t5ayCFO382xO234ymySqs1+l1e8ZQIjBM?=
 =?us-ascii?Q?Jg/KTlrAt59jNuYt0ywnoCUSExsZZkhQARCunh2ZILiBM6taCpHCtkHvsBBC?=
 =?us-ascii?Q?7KFBg80gmSP9ig8leH0Z3xnF3+ePa9GugQnFwr8A3vPsxCJs+olOousSSJ/e?=
 =?us-ascii?Q?I+49EH6KbP7WaOZeDb1sxeY9+aszMthJbZs7go7XFTBQ7gGeCteJpz/JUMKl?=
 =?us-ascii?Q?vRJtnolGXrv9xZ9K7+Xqj1DphmpXeMM8rrQVMSHv8nk/ioLWHG5uSsK2vyed?=
 =?us-ascii?Q?tZ4D6kAlPaGRryRQ046wK0tINmAZfg0S+DwS/aDLwgUm9vwzbyr2Yth8WpL+?=
 =?us-ascii?Q?lBdAxA30rKhTokv4Qo5Qfe0V7+MAzvKpRKk+nIhao3pvUlkFtgcFEJWJoNAM?=
 =?us-ascii?Q?3Kr+Hj1nxU8xbu0MQ394T2gyFKirUWPduWSc1YbKGPbxe88sTXO9d0K5f+W3?=
 =?us-ascii?Q?SnYYwwNBNcjbaeFCvvyUQUNM5+Iu/giKgknphCwJdLjfQEhQ9Ixb5lvayhpD?=
 =?us-ascii?Q?7AW27eEYo3zYUvLANo2K38827YFoP/46c4xqPUhwRRku1dgrgZcb3Zp0ZHgR?=
 =?us-ascii?Q?B5ZORz7Ol7v3x70sls52hy9OWC/DNeQkw9tcuBfvDb4GCH62PFkVUm8mQg4c?=
 =?us-ascii?Q?FwCySij0F/YW/3jsgOW/Q7infv/qqPu3QDRLMYQZ3qse5Hm8EJyeKFEIhbOw?=
 =?us-ascii?Q?DqOjLNhLuERplkfJUpTDIB03I/ojXqStfzKhq6lL4kkKHOLiFFXOxRTAD6k9?=
 =?us-ascii?Q?Wg4/9AqtQk/HU+cZzrsX0wJGvShb3Zy5qISMYXuRJ0gR6z+2Eqar0V8kWLyn?=
 =?us-ascii?Q?FC6VpIrEVOZIyKxQVc5AtMUhnu9VnD263ZJaLZHuKnF4aUQjFc/RGK2+fKrz?=
 =?us-ascii?Q?K6ZDWQP9jqLFr2x/SmRijbMOH7dYykffVETMjqBnykC2kmqGeqRKtIfz237I?=
 =?us-ascii?Q?N6/HglwhUXaaLcEnSntZnS5La8F7cJKD0NOCzoJ083BjEl7b6vyQ3gYdUHzG?=
 =?us-ascii?Q?YlbDaG4e0Orddpt+tqgPieKZEyoBZ87GMs/aHfI3aV5zHu47v93DgcDQBCjx?=
 =?us-ascii?Q?U2fnxrh2RFja2Ekc192R9Q1nJYhG3X08SpRNHfP+JQeg8U1eOoyK0lKdDIob?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sYWOesysSsb4uk/T4Ws9ERaH/CmViu4yJMGmLm+c9AxdhWRg0ncyzobQ+C3f?=
 =?us-ascii?Q?lwf6tWserEpAVLhtDDL679NdDnkSGIB0sRev4yaSoRYUIAfatXOocFDnwCrl?=
 =?us-ascii?Q?7y+ZFt4pOIM5dW/oc2f0n8bTi1vpfuZKHAFXJvv/DEypx0ERn0FGPSp7vGgm?=
 =?us-ascii?Q?gbzU3W9yQ0hwh/avxlkl9afWWt0DRC5y9L+oAWsYEtq2eswKJXTZtmVKruLW?=
 =?us-ascii?Q?c8lv+FSdnpHgVIV1/5z5d6dAgMgB0Vp2XY3q7hmb/xk6QVHh5gVZcpa6GYDc?=
 =?us-ascii?Q?LvmxXlfLHP9D/B97c3gDi7Z1GMmn/Mf9hqrYJS5LOnq5+ogL6mT+CMW54IKy?=
 =?us-ascii?Q?4XxTPApseGCotLqqPrhUb4TNEK2sJNVGADswKeRTPRfUw5biVAb5kl90AY9I?=
 =?us-ascii?Q?izTcjggtBuU64Verd7OHiptlXZ0to6+B/GZW8PKQPfut8y1WZRBrX7ANgRfR?=
 =?us-ascii?Q?s3G//xDolKtk7KE0nkpoIn9XaLnhHqwbSksO+rXuTY2Hcia/1k1HvuxYQB1Z?=
 =?us-ascii?Q?TcnlnDqQhy15xbwv8lUV/YjIXECNgwbjadi2JCst3GnJuhG7YLBs72IXuL0s?=
 =?us-ascii?Q?0mlQFy4kH7R7ZhGY9rYdKKW9kiMxHRzJ/w6CDPok2kpcpgkYbuRToZOf22Jz?=
 =?us-ascii?Q?ZmHBRay9xHqeHgX6t2KVhzHbALzShcxILt/44672ERu3FGVpKnG18F/ULD7E?=
 =?us-ascii?Q?/n7i6mRnPnpc6IP/R1EdobjMhWDun965LBNq4CNEiFSmHqcRfiecWY/Q3rwO?=
 =?us-ascii?Q?KUdE2EPq/vfYAmMrutAZldfcpK9iHJwz74I+nlkJYGJH9jj6QBsFXenmJvfX?=
 =?us-ascii?Q?yITTI/4syjgRcOcJA1ailbM9t8FxKf/s+mFFYYLM7lahWeoxubzzWV37EL8j?=
 =?us-ascii?Q?dhF8yTm/E7bEMyehc4wBO5EmcVFySAzn0/W8WRtH85gPf7OIyjDYzE6vlxIN?=
 =?us-ascii?Q?+VTTuMKvvb7tSldb11hqwj9AP1bv8lXL+aAPThl2VNQQ6k9EMIV0RtAZEsOk?=
 =?us-ascii?Q?SjvfNLXnjKoyJRyVK48obbF0aAq5hbmktAtZqaYXHXPfMz3weoTP1AXD3PYN?=
 =?us-ascii?Q?hwAxD3aKVE/lMrnHK+ax2yXsOa3SZdteQ9jrR6UfEaw8GBMBokRyNOWDgvID?=
 =?us-ascii?Q?GFeqIehvCP8SWSJhDLQw7wQr3J29W9RO8Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4302c32-2a9a-4014-55c5-08dbc61b39f3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 03:20:44.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QhQSvPVReA668Q/6dI4PtjJ+ySQzzt9C+CMWRMNeMaEZB4RFRjwNdZdVDABz8GJa1l4vwjdTA/UL28uXLIoQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060024
X-Proofpoint-GUID: hGyZmpWMRUcFCQu6hR3LLaKda783hnLa
X-Proofpoint-ORIG-GUID: hGyZmpWMRUcFCQu6hR3LLaKda783hnLa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the internal hugetlb restore vmemmap code path such that TLB
flushing can be batched.  Use the existing mechanism of passing the
VMEMMAP_REMAP_NO_TLB_FLUSH flag to indicate flushing should not be
performed for individual pages.  The routine hugetlb_vmemmap_restore_folios
is the only user of this new mechanism, and it will perform a global
flush after all vmemmap is restored.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 9df350372046..d2999c303031 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -461,18 +461,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @flags:	modifications to vmemmap_remap_walk flags
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
-			       unsigned long reuse)
+			       unsigned long reuse, unsigned long flags)
 {
 	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
-		.flags		= 0,
+		.flags		= flags,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -494,17 +495,7 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
-/**
- * hugetlb_vmemmap_restore - restore previously optimized (by
- *			     hugetlb_vmemmap_optimize()) vmemmap pages which
- *			     will be reallocated and remapped.
- * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be restored.
- *
- * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
- * negative error code otherwise.
- */
-int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, unsigned long flags)
 {
 	int ret;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -525,7 +516,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	 * When a HugeTLB page is freed to the buddy allocator, previously
 	 * discarded vmemmap pages must be allocated and remapping.
 	 */
-	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
+	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, flags);
 	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
@@ -534,6 +525,21 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore - restore previously optimized (by
+ *				hugetlb_vmemmap_optimize()) vmemmap pages which
+ *				will be reallocated and remapped.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be restored.
+ *
+ * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
+ * negative error code otherwise.
+ */
+int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+{
+	return __hugetlb_vmemmap_restore(h, head, 0);
+}
+
 /**
  * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
  * @h:			hstate.
@@ -557,7 +563,8 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 
 	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
-			ret = hugetlb_vmemmap_restore(h, &folio->page);
+			ret = __hugetlb_vmemmap_restore(h, &folio->page,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 			if (ret)
 				break;
 			restored++;
@@ -567,6 +574,8 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 		list_move(&folio->lru, non_hvo_folios);
 	}
 
+	if (restored)
+		flush_tlb_all();
 	if (!ret)
 		ret = restored;
 	return ret;
-- 
2.41.0

