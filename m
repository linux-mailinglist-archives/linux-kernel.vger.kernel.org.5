Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F255C7A899E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjITQhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjITQhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:37:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D2FC6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:37:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KFxpgo008103;
        Wed, 20 Sep 2023 16:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=i+qDtNJcw4HCsa9ilv89VYJ3yaEH9fkCW0DsYmBakno=;
 b=septd/rWkyKvBnSNFAq7B8UgSdjVuVMkHxZCU8fOdn2rZr5xQECstprZ6jdveVmcof4Y
 Xdz/bxsHaL7LPfkxlBC/9C4FMYUpGKbUvSS6pYPWvLdpYQgMtK72ItHZIAZiW1c08yaQ
 bCCViE0ih9gi20eRAHWKWoHTQx1Gi+Zy7XDD4Y/bC0AuD72LOLX9fSrKjswTxepdggef
 cgUZ/Ef1ELyK+e9uJ1M8EB20wV6zrjVAwBs4dFDXYGcjVd2AA2ydFOZ7r9yW4EfMTcQ9
 jPCOcSoVDI10LTQ6pl/QFa47yY4bzZ/otk7W6/6YAlGN29jvPkLxM4vyvlqRYt+g+voe JQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t539cqwr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 16:36:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38KG57c6027348;
        Wed, 20 Sep 2023 16:36:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t7kjps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 16:36:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXmpQQU6GFrv+cUwFybjFxRS7fBEGKlUAT9EIzNsgtdoP6Skrk9yCBdbD9cdNEMYHRuSXQIhtTqd68HWqYjBTkIPgoB7AmCY/qAvGUdW2MLy2iu5BxY7BMUlfUrW8CRb1gVyNI6TgtBwAdvhgV12w1Z31pIBHIwChtdrxZ9QmCA2KIQ9hkEczQpnVSoleg4bvRK39IVdXUVrCkg0r0tvvaOocaaohCD9E2ECNHWvTfxHu0T6CATleg+58D6qcp6RKQlNVdE51xhoSzk34fal0c3WZsx9cEGwZr8X79YXMKgtmzn4PMLsxMAT/ls2jjOsxIs0gZ/KGSnrPaAjpLKaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HViWx9NznodUBk0EkcH3pEi6U/gkic/iKsJE8AzTkiE=;
 b=f/z2bBeKZzAhoJ2Y7t2cShj4VA95J9RWItoiBAOX4M6J/PNh1HqWSc7E2n0qULU52IkHucbuLS2vCR+wHnXzIkNoruZa9D0F2IRCyHQSFgmAgSEOf5M7tbQLIeS07j47ITUJwM7QHsA3jlNdp2d6PZpm7jjMOJiI336DX0WfAe+TOfJ+8X8yNKo0KOfGYBuu66bhBdFk9RBbvfjzgxwF50KG+rVRLpSEWgv7+lcWNabfq+BtX+mdwe5t0D3jKCYD9pcL89YzwDBGeRl5MsTpXL1/QeyZ+HdWK3Rw2HZUybXC+kE0VPx+trvtSPRGO37AV3xzh4uVkVaFUPl+zfbL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HViWx9NznodUBk0EkcH3pEi6U/gkic/iKsJE8AzTkiE=;
 b=RjOFxpExOr0oH2tjToL/TaUYm2BUvm8ry0FAN6WjTKGXtO3aOe/rbaZucRuUdOy3VYlRcdFKd7e3RLF8K8awhLQ6dBY+/IUlELeotOuD1nh3bGCtzRFu00urgto5588UQQMWaubcz+Xmq/nOcfvtMLcDIxnF+FySkUtbnVrfhNI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by LV8PR10MB7918.namprd10.prod.outlook.com (2603:10b6:408:1f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Wed, 20 Sep
 2023 16:36:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 16:36:54 +0000
Date:   Wed, 20 Sep 2023 09:36:50 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, muchun.song@linux.dev, leit@meta.com
Subject: Re: [PATCH 1/2] hugetlbfs: extend hugetlb_vma_lock to private VMAs
Message-ID: <20230920163650.GA4065@monkey>
References: <20230920021811.3095089-1-riel@surriel.com>
 <20230920021811.3095089-2-riel@surriel.com>
 <ZQptrdK69wvJ2NXP@casper.infradead.org>
 <7ddc6ba18b3fef3ed637dcd9a85e90cf4ca6ca7d.camel@surriel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ddc6ba18b3fef3ed637dcd9a85e90cf4ca6ca7d.camel@surriel.com>
X-ClientProxiedBy: MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|LV8PR10MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0307a7-03f6-4128-3683-08dbb9f7cc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JO14GoXSlaCar5ih6bdvlkmSpYQL+V5JLTO2oBtWeK95wfX7TA679kajGkoKw/IIJYZZCq6CN9OJ2XOvYYY9/fq1x019PkE9wRJYnQL0pAzeZbmX0XYZqwlvkC9KCVu5202d7raBQFkuYbiV1kIfWcCHhoSRv0f0C2mN+SOkxwZGyqtU45irmhX3GGiILR63DZv8RPhm2gohx0bN7UjMSdagTQhmr81gSzP5rv3yi7jH+/PhHsWcVnGdME82YX0v6vVFv8KPh4LlTNtxLVbjFbu9iH/9ZcKj8n/2lWgg0j7tZSa5ACjjkXbo+P+kd1zwFAc4ldSSYoW9h9ML0PnBzmEn4AchzFWD15X8bthiH7hIrvEVjf696E2mDBLm2AQdb1G1iRKBKYGYJ1J0DCl8BVaZOrpOYyz3faI9dbelaHwZNtvv66VnhWnjjXVG3ZiaVUmGQfraWcGuN63bzoYocLNrJ1Bh2E6k1qLLlWyN95lw94KQqksoymw9DY06cykBJ6aG8GeCg0OO/MmPPWiQjJM8ha54C+SwfoJPdxZC7tDhCaaFlXacFKGcY+cW25sM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39860400002)(136003)(376002)(346002)(1800799009)(451199024)(186009)(33716001)(38100700002)(33656002)(86362001)(6506007)(6666004)(53546011)(6486002)(44832011)(478600001)(5660300002)(316002)(4326008)(1076003)(9686003)(83380400001)(2906002)(6512007)(66556008)(26005)(6916009)(41300700001)(8936002)(8676002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/uthZ2Lh4WhcUGS+YwVx2N/UQcjBuuQ6QOQP9jOo9md1IrlMA6OgADWKG9?=
 =?iso-8859-1?Q?HXcal6eFhmj3awxQRCIg39B4sR/Emg7MHl/Uhobw5hCdr105AAi6dL1iqA?=
 =?iso-8859-1?Q?KS2tqUpKb1ZtUjHSslC9eWvJexFJFuPGFSIaNBH+7JdIJrDGv9ucG6vHUz?=
 =?iso-8859-1?Q?Y68T0etlsA/ef6i4VZQ2c3kiD9o0iZV+5LJIi4mYF41tLookbLbHo1wnOO?=
 =?iso-8859-1?Q?6jS13ruMRgcW5UJAWg9RTrYNIdauFRdN4u9dTclFWOIwEL/8O2q5w01YFV?=
 =?iso-8859-1?Q?/25XE6G2JNLz/ZU3uBaxGd8q/W1IrZGtWgcHry6YfvKOD+NtcpAf3nA6lG?=
 =?iso-8859-1?Q?bp9KGX+cKuPOF/fSJhy84a5Qwr6vLTWOCQFwlTx+Ac3VH/s/qo0G7lLfym?=
 =?iso-8859-1?Q?xN2Lk0H4IEtc2bt1Htns0jEi1LqE4uHjbKXvtOIOwBUSajoRmGUE/Zw2c5?=
 =?iso-8859-1?Q?9yjdk4CQs9XYpAqGE3B0PK1TGgtvj1ZSzpS2VrPWLINeQBdC+B+lJHaqLe?=
 =?iso-8859-1?Q?U1Y1QBy+cr0IFUVZEjp+j4e30bG5jdNgry1TnaAUBwtZd5abFHoiL/hUmg?=
 =?iso-8859-1?Q?Cp6b12EDQDojjNfdVSBjZy13kv7ZGQ4qD7CA05L1ijk+TUH2fTLah2nZ7b?=
 =?iso-8859-1?Q?+SOnJBXL/Pg8kPtCwqX4iBvGUV1wO7vSQQJWtMHrnTmInaXSOf8Ue9l9UF?=
 =?iso-8859-1?Q?j301cIuUpn3meXOMJ8jd054V6a6Bym0PuUZCj1osMcw+s3JHw/5u1NdpLE?=
 =?iso-8859-1?Q?0fJRf+o2E35Mr4N2J3XcgPWlhGJpGc3e/cRnZrtlfeLQ+ihmuQmSyUGQTX?=
 =?iso-8859-1?Q?PY+YP5MZ6Murf4pbJbJZLeMp60Cdqctm3U3H4dA1Gn5K9SgjCI2MSD7RfM?=
 =?iso-8859-1?Q?c6lFFZf4gc/mgJL7+eB7IGCqVZh1HjCUViHU9XuAckz8knrCJgaPPy7ZfO?=
 =?iso-8859-1?Q?6g0RAz7DME4ruL/e8DIKdR2Sbg4NFpudyBbKAaTg/DsKZVZnCquKh/j7Gy?=
 =?iso-8859-1?Q?pkRAjCwij9HgEotZXZfMbUB0KZg4bdq67BcULkkuxgmXOPbsPHbANwGr3d?=
 =?iso-8859-1?Q?zjvNrCtQGbiJ+bshNc3OONrlTYirGXfmo/Qw9LlQjPCz54feyMPKyEpXfZ?=
 =?iso-8859-1?Q?c3GYAoOF2Ca6B5ItQ6VXYB3iqCIC+ucGefncrFSvLxAOktWFk+XgdLj6Bz?=
 =?iso-8859-1?Q?0mzX1pU7lpdf9Dwib3xk+OABv31FIKNwU1zNfpgxdELCMyQZ0VILrblZkA?=
 =?iso-8859-1?Q?KbhqgpvVnaief86Z1ETqYFe2tx9dL21Mp95pKtFblW9XR4jq6la6G4UN+O?=
 =?iso-8859-1?Q?9vbEm4WALJFkaTHJTang/UfEa3IFTCW23cjMIDAZ/flg+8U6SRUvenWssb?=
 =?iso-8859-1?Q?wjFkU/Dv6hV+GyWTLQ2t2bGO6AOTnGt5CkBBqDRmqqAa9NWZ1BSsPDSFB6?=
 =?iso-8859-1?Q?LoeQIVtSWmXoa2A5DeXi45PpwPcmFU49ZGTxsdaePkcxRHBRnusa6r0HAe?=
 =?iso-8859-1?Q?ZlwspR/sa38AL675DqERr0+V0ay7+PNR/Imdr9XKvBp+9aeNE9KvMwJpjp?=
 =?iso-8859-1?Q?lmkcZanRy6CFMkLnugkEyX9qjfAsLU7pRAViseSK5a85pWUxwb86wvPRsr?=
 =?iso-8859-1?Q?DXrTjPXjC+b5br2zijGhfYm7x2Ri+kWOuX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?ZEKLuCixqjHVMhohxrvaxA1oYUZ+WcYGc6v1GHl7dUy6ZkQFgi78zMwVem?=
 =?iso-8859-1?Q?WdpMb4Itt0+HBjG7nSIp0c+aVhQnEySZjAtLZ/So+A2CmqPpvoMJunNlrA?=
 =?iso-8859-1?Q?AckuhHTAvzTBwvmswcvC0OxNq81E23zcQi/+aB9o56IvxTsBai4dgefYTE?=
 =?iso-8859-1?Q?ddEhMwwEf27MLsQ7p07jNsuVf+2l6ORPIRYFntQHGVybFLYu5geF+K92ro?=
 =?iso-8859-1?Q?fgSsei4bSYw4eLmEBre6a/ZfADVQu8BnUL8dgUZr7AeUJ4ZLtGTcYPh+Gt?=
 =?iso-8859-1?Q?QiYFj+3etMoMQ2VpCAgLN1BjKPlif2cfYRCqIeY4qEVfc/6pcOtg85Mf9m?=
 =?iso-8859-1?Q?zvazjyBikEXcuM8G/1j2sR4OiE+YhNrQd/QbPjI73UQyA4c4cIYbY77Ygl?=
 =?iso-8859-1?Q?Tzf3g2J/hgoTkHzdIWRl+I7N1qJX2cvCwXJEJf1r2Wk6CEF2qsmWe2Omjb?=
 =?iso-8859-1?Q?5c0UNf1+aALlVXI4UPvW6IcsQodI+xy/DWNJ83CqBLcu06yD0SOCelcA+C?=
 =?iso-8859-1?Q?t5Vke2DlUehzqsxAB+GgeUJdt8CcPBEeeNfPGQVogzi4idT2s9VpZnYS8C?=
 =?iso-8859-1?Q?Y9O5mUknAgmVe/QCgl1iGo7Kz/ifMKOwskrsnJnDLVjZffIYesN9uCtKZn?=
 =?iso-8859-1?Q?OKLKTPXaf0bBfJi5lhFRx0HthyDx4jIoPk1s1+HRRBUCT7U1+3ov1lWX7W?=
 =?iso-8859-1?Q?lnJInGZ9L/0dqy0/XRd7dR0OsheiLdU9aOR9mP1sQT0oNMeAPYUDOkQZl1?=
 =?iso-8859-1?Q?GcApDzkDA7wFL9xvxOIOk4sh0SHttwfiBLyY1s0Sx2554re0blE60o4CLD?=
 =?iso-8859-1?Q?N1dN5omvTVphC/2q3BnjHb+abQ+YF6nqUIJU0SeNBuIcw91Txy04do3AL1?=
 =?iso-8859-1?Q?uPEVbP2jimHdmpBRF+JQ5AnKmu83T3mP1qPjoCcCpI/d0C++rmRMQa2+Jr?=
 =?iso-8859-1?Q?CNiKm1Skk7SRhT7SfgO9g8Y+IId5pQhVeeaDQ8vSeL2ne/0testWdg=3D?=
 =?iso-8859-1?Q?=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0307a7-03f6-4128-3683-08dbb9f7cc3f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 16:36:53.9711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIWecJ5tp8qU5cA8Ss+OD1tzATklC/D0Ys9TtbuHT5CBgxNfoXg9VGfDNR89BnL0Dyibnv1zSWlxxbOVPNL3Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_06,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=813 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200136
X-Proofpoint-ORIG-GUID: c7mwLSQzor3fgLot-z3nQap64LOPSrEU
X-Proofpoint-GUID: c7mwLSQzor3fgLot-z3nQap64LOPSrEU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/23 00:09, Rik van Riel wrote:
> On Wed, 2023-09-20 at 04:57 +0100, Matthew Wilcox wrote:
> > On Tue, Sep 19, 2023 at 10:16:09PM -0400, riel@surriel.com wrote:
> > > From: Rik van Riel <riel@surriel.com>
> > > 
> > > Extend the locking scheme used to protect shared hugetlb mappings
> > > from truncate vs page fault races, in order to protect private
> > > hugetlb mappings (with resv_map) against MADV_DONTNEED.
> > > 
> > > Add a read-write semaphore to the resv_map data structure, and
> > > use that from the hugetlb_vma_(un)lock_* functions, in preparation
> > > for closing the race between MADV_DONTNEED and page faults.
> > 
> > This feels an awful lot like the invalidate_lock in struct
> > address_space
> > which was recently added by Jan Kara.
> > 
> Indeed it does.
> 
> It might be even nicer if we could replace the hugetlb_vma_lock
> special logic with the invalidate_lock for hugetlbfs.
> 
> Mike, can you think of any reason why the hugetlb_vma_lock logic
> should not be replaced with the invalidate_lock?
> 
> If not, I'd be happy to implement that.
> 

Sorry Rik,

I have some other things that need immediate attention and have not had a
chance to take a close look here.  I'll take a closer look later (my) today
or tomorrow.
-- 
Mike Kravetz
