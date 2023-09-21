Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E856E7AA5AC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjIUXfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUXfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:35:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9468F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 16:34:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LIslBF031507;
        Thu, 21 Sep 2023 23:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=sJMR6oWLAkwu90R2jgiWTMEGHaP/Cc6FTgJT31FrccE=;
 b=aMjm2Bg3p9Ugyv6QQ6KdA8Jb1e+piybHWKicZTwXKaZpC9hX/1ddnAQJ8nnOkqhVq6mr
 kye6zw/Vf8wK44FWTZGmwbbdgqBmZRWXnicOdCxo/ZbRfKl2185n8MLl9gWAqoXMUk1W
 TTtLoFwMaPEXfQ0vT5T5cEGeb0YWT4ejalriI+TiaRDfvu9nrRIOZmP/TZbFy1zco8ua
 sIu/9XMzEhQVb+K5S5oTScQFvYX4rgHpSowv1X3iF6mB8e5l1RNfIUsoIP2HroADasDy
 5Kf4msW9+RMTXxEaGMTLZh2J3y8ytwv95HyqrO7HHLHAl2q2f1MnGFxDqMjOL+w8W4XC Ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt08g0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 23:34:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LMeEZg015636;
        Thu, 21 Sep 2023 23:34:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u0u9h72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 23:34:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt1NT3zJ1iVMHpolFg+t8w5mf9iVxkbs/HgYa3birLkBCSXunF8ceeJM1lVNWnIxy9PVS0iUVmYvBJCo0TJH0x6aOO9kJGvEX6qIX2edQEgpPXCb5S81u0bqWxKgxezrR46KscQyWsNAFJ31lwwRa/KdEnOM4eTFNL02f1xizi1a3wHpxsrOgyWHHJpyTgHzE+sjT5LQCTY/FaKEUxT3Th3fEMQuw7jQF06OJ8vbjaeJEp5XuJK1bru1rq4GWTsslgItQJeVcrZc7lPQN1u8qLf/tXvFV6n5yOekrv/ZmIDdKR9uMNDxa6xzXt9UGPfJdrRmcixVU0xUTj4UqNCxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJMR6oWLAkwu90R2jgiWTMEGHaP/Cc6FTgJT31FrccE=;
 b=gSy2DS19USJ72P6v5jSXDcI9GLaBD+ly3LdgRzZ/YpEzDHQQzp92Uvoys3b1EcPWn2YyIlYohzQmIS0KJD0E7DzTougcPjpzR6zmWBlA2oz/trb7i4s2vzwfb9hKAvNwHXUS3AYWh1z49VBzs9wKIvkarrIpFhFkYwkUHF+p5kw2lmBtjZqx4jVI5XMTMlcf964SlUmBHzHG9bu2pDvWNlatRiSZoT7uYtcdM1vCBpiTF0DmYHOADA6xC0ifAzLSpZazkSDLvQKUDy2uhc4hlPjccK5zmZk7aDFQQu/6OtPjZTHKq+MtTKQMWGZeEXKP2r794a3XKsF4V4Bj1gRaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJMR6oWLAkwu90R2jgiWTMEGHaP/Cc6FTgJT31FrccE=;
 b=S+YW8xOiwunbO6yoNcpDeJcFNl/yXsrbe6AdrGh5NsL0B9XHUnGvelwi9AEwYZdjn2d6S9I2Cpl97l0E8Qg8E1Sm64NxTK30keZtbDKqOoJiMED4K2VBdnSEhkKBwTEdtAPYEluSjPSMELJEqeP899FTf0S+ufulxo4Tc2Hu5Pg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4988.namprd10.prod.outlook.com (2603:10b6:610:c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 21 Sep
 2023 23:34:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 23:34:25 +0000
Date:   Thu, 21 Sep 2023 19:34:22 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>
Subject: Re: [PATCH 0/2] maple_tree: Fix mas_prev() state regression.
Message-ID: <20230921233422.kv46hm4lddhp6rgb@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable <stable@kernel.org>
References: <20230921181236.509072-1-Liam.Howlett@oracle.com>
 <20230921112521.fc07c658804f4e188179da77@linux-foundation.org>
 <20230921185330.j5jw3oms4tc6crkf@revolver>
 <ZQyYH+5pnDc1KYj0@casper.infradead.org>
 <20230921162748.a85eb5af766e0662e4f22a5e@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921162748.a85eb5af766e0662e4f22a5e@linux-foundation.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::11) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB4988:EE_
X-MS-Office365-Filtering-Correlation-Id: f130fefc-a06f-4c88-8f25-08dbbafb4a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80mL8VXPEQO2aQ2+bZUlXHbkY0w0PwHCep4Kk9Tv3Nf7opXhe8ECqnbxBgSYWx1QzFySkb5vkoiR1BlqX6dzwmamg0QETO+1QyIy0VVjwdBLNUSfhaBXAIKmuxi8S7NjR2eVfhbXh12GT0kYrctP08W57Qrg42l1r/pIbF6KMAyp7frynmv/Jt1hE6kQJSy57h/rKakjQEgM6Bs+/sdUmtRxUU7pxfbzl7tM+DHrg2uGPgMSVHy/MVe6QjLi476SxrMm4jqKLwBtxkH3jtHx0SK2ZeXb+NUZDtKt4i3O8J+S4IdVmpSANhKK42iHQOa/WjZ3TKUdKRkf2amnxggUKZgVFiAuSGOXF6AYEAdDG7GoimC2G+hMPp3zpg9BSBrdhmGrVi/5c8SfLAwtSSg4CSZ86+FwlXrcIJlDmejfQSLm8bWO8QaEdbPofsdR7zKiiUfzVivkApYEzXwQPbOjloyJBfENoHJ4S2QbBbCGJTlSW1EC0JShyo1kHDRfjcNegp7OVs7DYaYFei1xuZ8qCNslx545r0HGhNF+62TfRwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199024)(186009)(1800799009)(6512007)(9686003)(316002)(8676002)(4326008)(41300700001)(6916009)(8936002)(2906002)(5660300002)(66946007)(66476007)(66556008)(54906003)(33716001)(478600001)(6486002)(6506007)(6666004)(1076003)(38100700002)(26005)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E7y+jTjXMpKZlvKkez/z47m6ye+betnGT21smyKa1HO7LldaweZKx1EnXpiT?=
 =?us-ascii?Q?Ue08iVlqDHyHaQuoST/6xOi+HkaU+asXLAT5JuVsfbuJNSK8F4LpYjQtgP0Y?=
 =?us-ascii?Q?suyH6Zq8b4D2GTOXOo19lpEDxLOYI1JD2oGsfIxa3STKNQggsq44E7GY5yR4?=
 =?us-ascii?Q?Mr3vz0lv55ablrfs3SPVKcuLTYJPKeM7JU4qE4QSinffm4ZKmHpiFMZIyZ1B?=
 =?us-ascii?Q?Mk1b/wS8ZEEU/XKZ4brhB03LGjfxXbCyfvUG7NON7Jgie381b+IQgwRzv3vF?=
 =?us-ascii?Q?ZGnSmd/9tLi79FEAM8K1i5C/3bxc6inOXUDuY1mni9sb/jgKLrb3xkgrOx19?=
 =?us-ascii?Q?2ss8wyKGIyZFMmfiX8uT7WRxZElV4gGv4506MZnwFqWnJN3AvOCZkmQR36Nu?=
 =?us-ascii?Q?ekp90yWZGFzIECQweQPXdzUxZ8Kw5CVY04YUscsYiGktIacfLvqMzOz/BtyD?=
 =?us-ascii?Q?SlK0ZDFaqK8dcKnAkd1jisFqTA2vAWQGIpn/11HlFOq7rh6q3gn/RdBPov4E?=
 =?us-ascii?Q?Gh0pSx/YX4Mz7hG7puB5gE0tPBeepO5d8gG9MqGYjU8JPOmGCQD3JFA7I7Rm?=
 =?us-ascii?Q?fcnMC6Npn3L7AeUr52kGnEotWBZEj/udkxrPIyg2ClJ7dvJjlC4NxcbOlysn?=
 =?us-ascii?Q?1yMgBph0TjUBG1zrQCoW6YnnrO9AlMVzlWAzpzG/1hYTU2ejo8jnGLLH3U6b?=
 =?us-ascii?Q?yl3Xe18xBnGipdoGGsvQWomsJCJe2frTQXXuOVPnclMcC98rb/+foRV9gClT?=
 =?us-ascii?Q?ZYBWDgAwZvOmLv65t5NxFAFqIRM+RfqwMVuF9HOsmw1cGoL7sfw0ZAuoVW+E?=
 =?us-ascii?Q?GgRIr45fLGqmZpL0DR7fr5tNPSRm0sutTClfFR4phIZRBULi1QmZ7bevOrBv?=
 =?us-ascii?Q?x1rxTxXj8juufR053XjPMm3tkQQ7T03wZzImPPe6HkAlmr0K6S79y1/10gRt?=
 =?us-ascii?Q?xfY91cSwPG4Pd/xT1cPMEndfoZ6h4Polf60ufOlZT9wfza94HDmJxytkO4Va?=
 =?us-ascii?Q?yBhvrpjo4YKpl18wEoG9djsZTxL+6m8ogJ+RXm5mPRxCyApWHVbzXwrvYquZ?=
 =?us-ascii?Q?kfSCCjh3zn92vleh1SIt1zfsSXCaNJspUe6FY/UhX58L6HtHG3OA3bUg8Pb3?=
 =?us-ascii?Q?tdQ4odgA3gy2u2LhDDN7wjfXG55BWbd8z38DkE2IPsuGDczOxL5j1S8EdVeA?=
 =?us-ascii?Q?JEYZJ+TbKZR9KEOvo7IHPSjgVtn+/HjBZkkVpVmjpU8RUoE0E15ZVI0VLRn7?=
 =?us-ascii?Q?9r//SK6vq6gqI71dzR7QVrunZCCobgDpWh99tPpSyI+nd6+0TvExBOg81s9M?=
 =?us-ascii?Q?7BNI4Kp/Z8bv2rL1/u272aDHV+W1fFGIw1j0Zk4M/XOJsMxL1j/4sqUg6CN7?=
 =?us-ascii?Q?4QmEIkAYGLVvcFf381iMOUea5t1gAteI2P7I6NqtRsntKBrT2JW3EhX9RZ9C?=
 =?us-ascii?Q?/VqZMf4LLIuNWjQTxrsEiR4EdirwCfW6LvDsm/M84iGNRsXFAAW/DFssZjy9?=
 =?us-ascii?Q?A5Grl9KIdr4sRMFc1ICvIUxeHV31rmF9fOfjDSwVL14RL9PtKDhARHCej3ey?=
 =?us-ascii?Q?kB8J+01P72DksVzCSt0rVLIyYUi9ettc3B9nkTmF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qQj55Fx65XN1bO5li4EcKwYCBRWVE0EmMgfMVEkoFcbleGV3LJx1/Yt2Jdpi?=
 =?us-ascii?Q?2EoBphd3mncCoof6kJChLm/9Tal6n+FkiERS2olSBl/26galm+LQqfMXUoE9?=
 =?us-ascii?Q?iLmsI3IDwxsZfHpoJv2natReOGsfLrVqS1CGhhOcYBazSGlMtDuzqxXGB6eb?=
 =?us-ascii?Q?pEakA6Gn+G3AXF3rNM8uJm5kSRl5au8HrImwdUJM1GOvKmgJHueuRN8oAOYH?=
 =?us-ascii?Q?/Dsug5BPVpAoHEGaui8ZcSignxwbl4PpNkNWUwRUO3+XXTx4mvuDqkalMmk4?=
 =?us-ascii?Q?kw3j5cez4oO6p9XbbcMQhUFXe3S5KEfMXMFCmAxaWmYanfS7cFvslX6LZudM?=
 =?us-ascii?Q?5/a86ts2jhyGFLe0a8WOygVmQ3Ltou6S3tLqLyz6ycYvxjI+YnlgAayYAwJo?=
 =?us-ascii?Q?S6o+K4dYWHHslLVB3I12yT2cJyCu60BoMnzbVCe6iDBFFMk1UpEU5XFU8n1U?=
 =?us-ascii?Q?rncou5gyM2pZLMD43ST06mToGFalQ6T3T0ndwhQAnBmScbflPAPg+HldRVlP?=
 =?us-ascii?Q?0jvdZbCJXExaq3B0Vqo8TZ7phjI2rsPYI2uZDHkXYjf8fruxBZdpF5gt6XMk?=
 =?us-ascii?Q?G1gwUgq+h/fX0KXcXxGkmHjzJdWq2gc7Xm6Yq/Q2dWj4utTBUH7Jmt5xiCSF?=
 =?us-ascii?Q?BRElCggka2sgLW5LV5lkL1fH/qfiMVC9Bs9dFh58mYvHIgWLQLIBk8NLsrp8?=
 =?us-ascii?Q?xv5woGf5yZVM4n7igwfA+gh3GJ7Oh7L/YrlisYn++nxl41lIPZL8JNj77dCV?=
 =?us-ascii?Q?1NxTwxDsOGwvSRjCu5VniI5UQilkV3RyRZCYvRLjGHzgEtS/3953siv9ayo2?=
 =?us-ascii?Q?j4LDphA7fuNFTzMbSXt3bVkN0sbYHIbAgG3WJkiNOk4plx8i+a9sT0QcEb8S?=
 =?us-ascii?Q?Up3GrWpk8Sjs98yKdjJ2iYw0uB4uWufccoPSIFk40vgErkQac3m0Eg7g7s0Y?=
 =?us-ascii?Q?gXTrT0clWpdHkot4hgeaFJ8hWdXgAf/5RmpDSgWgNew=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f130fefc-a06f-4c88-8f25-08dbbafb4a76
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 23:34:25.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NH8sR6rM0/QRa6iSO1IQNQh2uZVmTdGTztIgBPvEJZaIK7+RAvmCcVtMwmy4RKSeBeNzXElLQFdLXUOgdMpUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4988
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=844
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309210205
X-Proofpoint-GUID: 2kbLJ2FSvz2A02wYvHtxgJQxrjTqh655
X-Proofpoint-ORIG-GUID: 2kbLJ2FSvz2A02wYvHtxgJQxrjTqh655
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [230921 19:27]:
> On Thu, 21 Sep 2023 20:23:11 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > > It isn't clear what are the user-visible effects of this flaw?  Please
> > > > send this along and I'll paste it in.
> > > 
> > > 
> > > User may notice that mas_prev() or mas_next() calls that result in going
> > > outside of the limit passed to the call will cause incorrect returns on
> > > subsequent calls using that maple state, such as mas_find() skipping an
> > > entry.
> > 
> > When Andrew says "User visible" he means "userspace visible".  Not
> > "in kernel user visible".  What are the _consequences_.
> 
> Thanks ;)
> 
> We have a Link:
> (https://gist.github.com/heatd/85d2971fae1501b55b6ea401fbbe485b) but it
> takes us to the reproducer code.  If it took us to Pedro's initial bug
> report then the sun would shine and birds would sing.
> 

I don't think the irc channel is logged so I'll respin with a cleaner
changelog for both patches and the subject of patch 1.

Thanks,
Liam

