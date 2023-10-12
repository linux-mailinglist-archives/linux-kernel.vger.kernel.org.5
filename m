Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0867C70C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379120AbjJLOyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379089AbjJLOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:54:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF72D7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:54:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CEONHK026266;
        Thu, 12 Oct 2023 14:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=sbyZfwNrybXnrgs62rmohlpl9mRwh0T/nfeLoZYztYA=;
 b=FbGVuENDOCPCLJa4gO6fW8eYZxq2FeG6VJ0NydOlhEgh/N4KzsVVvrDnRCPY9eSUpgpD
 dEXSM9A8twNwGGNy2qTXwZfbS4qmdpcw7c4LXfBYjkaYJ4i9uTx03Z2P/5t6oeo6r1Q9
 WzaLTxXLywr5AazsAtGdw+PjJTaFWkFS2fjTsxtYJhrio5aYAmo8Hsc5Fga9PUE8Kd8o
 /TUkMakyF1K+gpgx11Ja3tgIPy5MSF6hrcEhQrAaIpW4uL1XWVV4ZYdoZ22ahk3dADy6
 J0xSHvoXyUYWthlyv0lX32VQd+UyEvso0OA+jTOSrY2jI0ttr2veyxEpglMgUpSUEBJb bQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvuu06f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 14:53:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CEXmlQ010641;
        Thu, 12 Oct 2023 14:53:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsagv0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 14:53:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cASGVPQVCV56PgzO/PJCUplE3KGzqjB7Jvv+YA+ZWGPJOhJTUEW74M8EVWQx991ZmSze7IHM6/HaLLjlpmPBxxeZTan/ad+qeO1EzC3CmWsHoYKLDkEdFJsYhBDIyn7qNNdRZwQKohk7AdI51i0Q/QeeK7OumFz5Gq3Q7+DFG5u0ojLpGqawdSB0uDf1yuF2gZ5SnKgtD5PHYl+dHtwX/penn+rY6hNWVhIK4f3e+zR3H2Rg9hQaYm4oUFXqRiKYWky0vfC+dQ+EwHZ+3PTPX2BFmxJ4NlecuPC7JIVEkn9qn4IBE3+a6G9AgYiEcOAV6twX7Mj2tIt5pt37z9B3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbyZfwNrybXnrgs62rmohlpl9mRwh0T/nfeLoZYztYA=;
 b=QyftUUpCGT171CHPP1eKsYyft7MPOcAOXlaoIt+bLcs3duXvD1kgUCERFaIlKRrAOaEJAdlhEZOzU+brGjV1EFSc2USt0nWznOS7byp76i3CQ2VxIqqHV86SbNDoDGuxcEFJ4tRDV/indQrb4LKuFLLcSgVNjkAAt1DqvXu1SaKECQ/Tkj1Thdznz16UTRQRxcAtiHUrMnrdwYsC+/Xld/rZrCztb0BNUyUXXMJYtKbspt3f09anYOLnys48yxrd/v1Jqzog1iqEiIeHnpOyzNakCqF+Qsj8ITRuGELtaWvyW23kYjDPXsguBJwFmCIIKgnTb47N5AMo4XRWeBdq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbyZfwNrybXnrgs62rmohlpl9mRwh0T/nfeLoZYztYA=;
 b=wSZ2uD3Sdbdc0X12wdy+xbzROwhXIJkakBL/6HgMUOXy9StnZu0dyP9xymqmmty5hyjCPDFZ5CFtmGPAl+/5aKzg2eiExBrdEjjopBbYDRDDsRmvXb+waxtqBiLAOTFAEj4B2lRRpC5pojUdjuKJ20lertKNCmepoCtEMD49AB4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7172.namprd10.prod.outlook.com (2603:10b6:930:71::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 14:53:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 14:53:21 +0000
Date:   Thu, 12 Oct 2023 07:53:18 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] mm: hugetlb: Only prep and add allocated folios for
 non-gigantic pages
Message-ID: <20231012145318.GA5127@monkey>
References: <20231009145605.2150897-1-usama.arif@bytedance.com>
 <20231010012345.GA108129@monkey>
 <20231012000327.GA1855399@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012000327.GA1855399@dev-arch.thelio-3990X>
X-ClientProxiedBy: MW4PR04CA0345.namprd04.prod.outlook.com
 (2603:10b6:303:8a::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d14475-40b0-44e0-e347-08dbcb32fa63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YKyotJhfER+kLR3AvapypVfkqT/IC1ILLoXRO4o8P8LO0fHPdOutiWM0rnEfEQtdQFjHUrfxUwvsANhzkxDH+CsRVibbV4bTotzgG22BgID3jNRez5cY4MMfKOdDQmDeagpzCUwrA7h4mxBlLO2QpEtWpa8WridOmNb9c+OCm/PtAZcEXqMz0M47PpIlBPA13I4z0VTQa71VKWUQoX7Lc3HrNySSBudHbujjOSKrdBn1hu5GmdUAxjrQJZSzAOe8Ubg1CAoqF1wn6CXLejEjVNZ769yOYh6CtddNfWc3R/2Gndrf1T12Lwx06hccmiJLh34E6ttWYESuBsDspfTg5JBQf2QvUCPLfFWCTFf9/dMhjwsm9OXZGGwDGL2/SPqRqwSo/G0QPk4fi0gFC/KXwTd4y5waUHWyHJ6oNdGWBELqRqH0AxYbTGXcXzC4wcWjON42U+mQu9iPnAzPx7Lw8Rz92knAmHn9kQ/gQR7+7UneaRNzWAh3MqhzC8wWPjv4NrNEjFIjb6XhhTwTsDOhldCACba73prTlNzg9pIrX7yEnow/NHl1bFHoNdBZYbIKnZEJrSqgmgZeUXB9Yw15JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(7416002)(26005)(33716001)(966005)(478600001)(2906002)(83380400001)(44832011)(1076003)(38100700002)(45080400002)(86362001)(6916009)(316002)(66556008)(6512007)(54906003)(41300700001)(9686003)(33656002)(6506007)(66476007)(53546011)(6486002)(66946007)(6666004)(8676002)(8936002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4M2BYz3UQgh2/eaYZN8GeDplYVo64LUWhX3hl2N8sFDnwuIATEW1eT+QlLil?=
 =?us-ascii?Q?jKSx/Nm8F7ETZvcuWxqAU8eshUyd6mfWgE6t/n55aLmfykab5jKRMrrvdwCI?=
 =?us-ascii?Q?A0LRPEq5Xgp4xcfQMs5IMO+/S+VWLFFpG8YWIF0QCrXKkBovMacAyGgeHCV0?=
 =?us-ascii?Q?cP1YkGVjm+/A8Ceqi19dfeumWUUHl774QGBTN+f+SB2w4GOpZd1I44Qhq4II?=
 =?us-ascii?Q?9ryhqOZcGN0pCOjvCHfXISgkLNiH3QjHSVuZ6Ux8Jq/CD3iEIPY36Cx9dvu0?=
 =?us-ascii?Q?3xzzUE6u2zeYyX3uyGFxEO6PWArA3xXVjlEu0YXbjPiEwFdjExLl0dTUEi1B?=
 =?us-ascii?Q?bOWYrHmAQW+uIfrv6eMECcfeF/ZSKSLNSSW/ay3GW+QVr6qxmLM7gm0vJ23E?=
 =?us-ascii?Q?j+GECM+xqpg4QwJkOMN3om1Jgv5r4On8qYafoiz3nlTACR0Czy3H3/qOLXIl?=
 =?us-ascii?Q?rgkSSDceuiI/ZKZn5/RYTmQsj2DmgK+OeBITtvBLD2cGoVoyQCJymg3kCDtL?=
 =?us-ascii?Q?ARaFc2CWJzuEvARqCcJgRirG4jU8hepZ8yB3Nagv+PIZlRPb+IcdC3QPWX7V?=
 =?us-ascii?Q?Om6SBxZOR2HLHfnKeJ+bG5Tpvbcv8YbhAIQ5IeBzHG3wO+wc3SfJ/VRPHzRn?=
 =?us-ascii?Q?wPXbeJrSP4AuZzMeZXzTHdmsVYa6AXDgSlwmKwFBhE1b7ph9qYfe5r1QmMmm?=
 =?us-ascii?Q?GC0O35pPb4jiFymzwG1R8jt0tEnhQbbYAiKHHZnI1wiQUuVtShUaW0s7XGOZ?=
 =?us-ascii?Q?karZ58TyqOhBi8pQb+ZBrLVJoMvaUz/6F5spM9zVxfdivOYup3QtWAwo6x8Y?=
 =?us-ascii?Q?CGtuZCuLPGEjr3+A4PZc/ofyzqEomMjMesGFytrDs0BqiJ41JGDAQGEzMjC7?=
 =?us-ascii?Q?kOeJgVMmOSpy4Ezbc0ui4CR6Z3XOzvQlZna5PJXoCXZpbMEE8SqQAyMwflLG?=
 =?us-ascii?Q?gTSJDepcgTyl0n78fDElo7FVEsRyMSiBbm3aN9pT9wcia3nKnNcUTTWzTc5W?=
 =?us-ascii?Q?Szbico9YrQIPBEVFl1+kJJpIA0oxOhvz+gQRy6myAcp8KhCvY+ngnEJiQ9PC?=
 =?us-ascii?Q?FBdcX3h/iHboZ0jUDp4VKAMHH9KXLUxlAiDCY/LZtPyYz121lckaxjCy6xRr?=
 =?us-ascii?Q?csnfu8xcDhxHJDjqU0+UhKaJdnFTF7hFLLCSWaCehLmXfaKcQNYoK26r7JHv?=
 =?us-ascii?Q?2MgiGUP6IfFSgxEHWKl2c9eo9GyiZIRL1x86Tzy91ogL8G4ArxX/sDE+Uljx?=
 =?us-ascii?Q?5ngTxOtXQF7V1NiMv7+7IOd4/2qtTczsA6lF/3Yleif4RNLSN5oxu+J/Zy5Z?=
 =?us-ascii?Q?qVt0azuDlr38jC79vsP9brxn+PCIYEif8QsDPLDs6rnZgstUFfn+lmSw1XyJ?=
 =?us-ascii?Q?n7zUYC4h16ymM8lah9fjLFNFI588UQ8GcYRkrFZAmwMEnxiquLkkqw4I/q0j?=
 =?us-ascii?Q?/zETeHbcRGmrNTCeKT2NhngJzUvZRuP5ntnXrhH00TMGuWb8AvMY9UnF2bwS?=
 =?us-ascii?Q?dSiIsIef2+2ey0EQYOjfzUdyh6dl78vDV2Z2EDygVM11buHrATl5y67tBvrv?=
 =?us-ascii?Q?1BFH30XCbLjr4gXRrlJs4soMhxdN89FNJwA23B5W?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/Dc7au3xZo80HaLwSNJ9KoiE/zf7N4UIaFT+ukXvvtXBLBoG6nbpWkg4GlO7?=
 =?us-ascii?Q?0oeeXR9rVckn+ESMWjub329WgCAj7HaIXEwrHaf5KQ1VMxa8BHpxaPfP+RBd?=
 =?us-ascii?Q?ebIeyWI/XQin9EkvYzA38Uhf507hgWfB3wNhJGtaUpkMJJ2XILMcY5g1Ed6h?=
 =?us-ascii?Q?sAhvOEARM91yFm3A0SO/jURoMbuPqI9LlACt1Q/elCw/DI7xc+0qVAqND5Yw?=
 =?us-ascii?Q?yUG2tvceJ0mzGHN7FpiCSZR6R/lKoHmrxVnDNKW1Cg808Lsxerz02Wopulmd?=
 =?us-ascii?Q?va3viqNJHiUbiVVpVIIiix5MDM1ARddHtR0EqHPWeWe1vXBZwF0N3iEnhTe5?=
 =?us-ascii?Q?szUpOmGHcv4k0qXfEzJuNfdVBCye/vHLkSyUXwSCwspAkt8qYw7KKffFqeHp?=
 =?us-ascii?Q?3s4EUPTwnGSAkexi8czTJhTDfoyz7I2SswnyQNGlCP3UhYyYUte2VgIpMwns?=
 =?us-ascii?Q?OySZxYxbEdq6FCqULhyRmtlwqjk7KGQf4DTlxL3P5cwtOa0BtM28ZiO3U+be?=
 =?us-ascii?Q?Wes353GovIBx1BVu0qeZ5NHYzd4Ci1kJ7HVH3O24HeE/PIpfuvonDEZtKK7U?=
 =?us-ascii?Q?DcZEJUESxMV0J+oaxN4bFJyKskeDo568XOgrhfvsJF1jazLLEfI1Y+8ma+iK?=
 =?us-ascii?Q?IgiapSm0spJp17pmWAvOZfjtHKgXoeZi/QPr2A3uQg6UMSJLb0nvmaUBWymT?=
 =?us-ascii?Q?w24T3W+9SXZ+i27ZUy/dodqj1XYvjXCrsOzOZuWZxcgWg7rHNQNS4K/5V4HK?=
 =?us-ascii?Q?DoYWfUQx40z8Jrs+i7e/9bBQtgSjl4xF4JCrw0B19kpk5Extvz/uwHkcC/cY?=
 =?us-ascii?Q?hUqLDwKqLdQiQZKSd6mZcAFupEjExZmIHnlXIrOGRowUQvQEGjZB8hbslKxw?=
 =?us-ascii?Q?3Ix5Bla3M635OWn79ZrmUpV83JabMI3Uu9aNmQxnEAQ/n9nWlLwgwnWQgRIU?=
 =?us-ascii?Q?Em46l3zkVEzUg00r0xXkDATY6tDtbisiRVj00buQoTDyi3BI9PhBSuht5xV/?=
 =?us-ascii?Q?YiNOs2HI3dIKQsB6oG9SE8bDq+rUaOy5IGh9SUpQaiGfmks=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d14475-40b0-44e0-e347-08dbcb32fa63
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 14:53:21.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpc323ec1bcY6FVEGJWUzFmf2M7hssWVvgG7g8OWIU8DJATzKwbem74Lum2K8LniEoFRUtrWwl4VY24ZLIWITg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120123
X-Proofpoint-ORIG-GUID: xWo_fL85kqdEyXO9-YgQ6F9xzUHnqj02
X-Proofpoint-GUID: xWo_fL85kqdEyXO9-YgQ6F9xzUHnqj02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 17:03, Nathan Chancellor wrote:
> On Mon, Oct 09, 2023 at 06:23:45PM -0700, Mike Kravetz wrote:
> > On 10/09/23 15:56, Usama Arif wrote:
> 
> I suspect the crash that our continuous integration spotted [1] is the
> same issue that Konrad is seeing, as I have bisected that failure to
> bfb41d6b2fe1 in next-20231009. However, neither the first half of your
> diff (since the second half does not apply at bfb41d6b2fe1) nor the
> original patch in this thread resolves the issue though, so maybe it is
> entirely different from Konrad's?
> 
> For what it's worth, this issue is only visible for me when building for
> arm64 using LLVM with CONFIG_INIT_STACK_NONE=y, instead of the default
> CONFIG_INIT_STACK_ALL_ZERO=y (which appears to hide the problem?),
> making it seem like it could be something with uninitialized memory... I
> have not been able to reproduce it with GCC, which could also mean
> something.

Thank you Nathan!  That is very helpful.

I will use this information to try and recreate.  If I can recreate, I
should be able to get to root cause.
-- 
Mike Kravetz

> Using LLVM 17.0.2 from kernel.org [2]:
> 
> $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 mrproper defconfig
> 
> $ scripts/config -d INIT_STACK_ALL_ZERO -e INIT_STACK_NONE
> 
> $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 Image.gz
> 
> $ qemu-system-aarch64 \
>     -display none \
>     -nodefaults \
>     -cpu max,pauth-impdef=true \
>     -machine virt,gic-version=max,virtualization=true \
>     -append 'console=ttyAMA0 earlycon' \
>     -kernel arch/arm64/boot/Image.gz \
>     -initrd arm64-rootfs.cpio \
>     -m 512m \
>     -serial mon:stdio
> ...
> [    0.000000] Linux version 6.6.0-rc4-00317-gbfb41d6b2fe1 (nathan@dev-arch.thelio-3990X) (ClangBuiltLinux clang version 17.0.2 (https://github.com/llvm/llvm-project b2417f51dbbd7435eb3aaf203de24de6754da50e), ClangBuiltLinux LLD 17.0.2) #1 SMP PREEMPT Wed Oct 11 16:44:41 MST 2023
> ...
> [    0.304543] Unable to handle kernel paging request at virtual address ffffff602827f9f4
> [    0.304899] Mem abort info:
> [    0.305022]   ESR = 0x0000000096000004
> [    0.305438]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    0.305668]   SET = 0, FnV = 0
> [    0.305804]   EA = 0, S1PTW = 0
> [    0.305949]   FSC = 0x04: level 0 translation fault
> [    0.306156] Data abort info:
> [    0.306287]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    0.306500]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    0.306711]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    0.306976] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041cc3000
> [    0.307251] [ffffff602827f9f4] pgd=0000000000000000, p4d=0000000000000000
> [    0.308086] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    0.308428] Modules linked in:
> [    0.308722] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc4-00317-gbfb41d6b2fe1 #1
> [    0.309159] Hardware name: linux,dummy-virt (DT)
> [    0.309496] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [    0.309987] pc : gather_bootmem_prealloc+0x80/0x1a8
> [    0.310673] lr : hugetlb_init+0x1c8/0x2ec
> [    0.310871] sp : ffff80008000ba10
> [    0.311038] x29: ffff80008000ba30 x28: 0000000000000000 x27: ffffd80a09fe7db8
> [    0.311417] x26: 0000000000000001 x25: ffffd80a09fe7db8 x24: 0000000000000100
> [    0.311702] x23: fffffc0000000000 x22: 0001000000000000 x21: ffff80008000ba18
> [    0.311987] x20: ffffff602827f9c0 x19: ffffd80a0a555b60 x18: 00000000fbf7386f
> [    0.312272] x17: 00000000bee83943 x16: 000000002ae32058 x15: 0000000000000000
> [    0.312557] x14: 0000000000000009 x13: ffffd80a0a556d28 x12: ffffffffffffee38
> [    0.312831] x11: ffffd80a0a556d28 x10: 0000000000000004 x9 : ffffd80a09fe7000
> [    0.313141] x8 : 0000000d80a09fe7 x7 : 0000000001e1f7fb x6 : 0000000000000008
> [    0.313425] x5 : ffffd80a09ef1454 x4 : ffff00001fed5630 x3 : 0000000000019e00
> [    0.313703] x2 : ffff000002407b80 x1 : 0000000000019d00 x0 : 0000000000000000
> [    0.314054] Call trace:
> [    0.314259]  gather_bootmem_prealloc+0x80/0x1a8
> [    0.314536]  hugetlb_init+0x1c8/0x2ec
> [    0.314743]  do_one_initcall+0xac/0x220
> [    0.314928]  do_initcall_level+0x8c/0xac
> [    0.315114]  do_initcalls+0x54/0x94
> [    0.315276]  do_basic_setup+0x1c/0x28
> [    0.315450]  kernel_init_freeable+0x104/0x170
> [    0.315648]  kernel_init+0x20/0x1a0
> [    0.315822]  ret_from_fork+0x10/0x20
> [    0.316235] Code: 979e8c0d 8b160328 d34cfd08 8b081af4 (b9403688)
> [    0.316745] ---[ end trace 0000000000000000 ]---
> [    0.317463] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    0.318093] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> 
> The rootfs is available at [3] in case it is relevant. I am more than
> happy to provide any additional information or test any patches as
> necessary.
> 
> [1]: https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/6469151768/job/17570882198
> [2]: https://mirrors.edge.kernel.org/pub/tools/llvm/
> [3]: https://github.com/ClangBuiltLinux/boot-utils/releases
> 
> Cheers,
> Nathan
