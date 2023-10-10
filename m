Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B2E7BF034
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379273AbjJJBYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379251AbjJJBYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:24:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AED99E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 18:24:49 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399NxIZC016164;
        Tue, 10 Oct 2023 01:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=d2F1NmNmUprzJxbL83t+V0Ca+ssv40qgBp6dteYUhac=;
 b=cumuAEA7b36WHw6xmJiYZXF3ley5qjRl+7FFYmbDe9QTGhRhBJWXoVqJ0cJYm5R3+f0Z
 7KOhbSEunC1lSS3jrN0ADb8f/Xz9c8H4IS6izZqjA5GgoG7QgsubsdHYxthNLNvxDW8c
 DYGmQ1lxJPlZiZQBW6weiXof2mxXdfCoS/gsFurzdUw3va2Kz+ktWW8dfYU55CfYZjzC
 5YKaJx0CxnZdX+qNLOkVuJWRUEcnuzxdUAGcfJBid0MG8pRdTHTJQVV5LFOcvv7WYsWt
 QA642RTwzlV9K41dbRBxUEzCxXM9Lw+ECy0c82RDGRz8vCdrTVR/+Dq2hwJ4S4asHU6A Hg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx8cc0vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 01:23:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39A1Ha0A016364;
        Tue, 10 Oct 2023 01:23:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws608wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 01:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMleT4Gv7U/xRg/dBxenFT8b1JluQCuptEXPLmUXDLNcHgeWkhG2Tguw1M5NGPOXZdE8zZK/CIckEC1wvKld2Ykz9RHl5nTHgtNcwcc3lUiDJSL62C/NRtajRiObFeLXJoEDLG0JJn96c1pFiRxhCUF0WOPymuXnW7S1fy+uVB1Mg74/mTlRblqW01mP56AbpQPEIZeOC/KNbSbO7HlVFtLzX+cU7KPHT05fSYNDxZwGoaoTGnI3W+x2Nexlj4arDK6Kl+Etndh2two46mffzrQ8qNiyBGjpnXJya7pId9PibrVP4oPCBNBAKTL4e29Sxmz4dS/Pwd+J6Cu2ztcWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2F1NmNmUprzJxbL83t+V0Ca+ssv40qgBp6dteYUhac=;
 b=FCD9BxcGR8g9tk9g0E/qJal+WF5exbyAqwDVV3ROqWdy28VxOXsDFL+LFkfFOJWaTjownkNiXrkT/J8t3zu1vKAMc8RXZbltGsY+/OjP0MOr1I9OLXI5DT0kpdHV8WAvmNWixqrOM90rCjMdu1oIOa9YRJfu3BanQbIE4YmqpG71DOsllvw1cLLgkkXwQSx/9vYjIrZBX0OoAo8dXylbaVj9cX5XSNCYBLmC+1kqBvOtDqivOIwrr0ihVurBglm4WdJLkQYbqHpLCvHrYy7KYBXKrs/EohFfPcKVV6W7MRhnsc3JkiAGAANl8TJF77A0Fduu+JhlkH6E4fS2J62WBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2F1NmNmUprzJxbL83t+V0Ca+ssv40qgBp6dteYUhac=;
 b=v1w8tdeTYP5pH1MHaBGf0z3Wb3yjjv7VxURQ/nFU6W6CaIYmfu2jRYkTkhS8dA7cVgJwx/jCOdykJQI9a059gNaUXNO1QTu/iO1xxvFZ1nGBJb2MszYLlL0ww+4dC/5DEepiZaCuKW4Jgp52zOVLMM8qvNFspyp25KYFxidNq2Y=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW5PR10MB5825.namprd10.prod.outlook.com (2603:10b6:303:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Tue, 10 Oct
 2023 01:23:49 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 01:23:49 +0000
Date:   Mon, 9 Oct 2023 18:23:45 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        songmuchun@bytedance.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] mm: hugetlb: Only prep and add allocated folios for
 non-gigantic pages
Message-ID: <20231010012345.GA108129@monkey>
References: <20231009145605.2150897-1-usama.arif@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009145605.2150897-1-usama.arif@bytedance.com>
X-ClientProxiedBy: CH0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:610:b3::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW5PR10MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e83be6-6e65-48e4-168a-08dbc92f8e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k27H54fCHjTtNpjO2w5gJgRh8u0oSxbg64mntiah8Mb6ybDtfA0JRqhvk655caU43OU2Q9gIFyzCkFwTzONTM5dE8eTAfDKKrXQ6GmdAtF0jl6OVtREe8RKVkDwIwKo0CRGFFRaQICXZymjrwZIwdXFZD37DMJDsh9oGwHCuHoOuvDqYNMtYjEoPtpczhxmGNm4h1KAHtuYjNgdJVSevn5R48IBTEU1S3J+im7/oeMI/zzR8rLF/vhMWp4TOyoF4C9Jq6/rXTHnU0YHJdSfdMdCvGCehVGl4B1HeGTPkPsMSnFeW4/2bxkaqqFUcieHYUtjhDrF3rmYGhRql+1gcIH9dntGf+0tLDKDHjq247EuuzzUM/Pzy1apybLeoT6kfRx43B5O4ThBeukP1faXqrNYgdToFaKuimFqW0y39Z5D727y7/bO92+Eu+fWkrv7PhIeIojjKR2kvMebefqJTst+2jVVxoSnZt3qj+QY5l/GCjhMD//BaFgoDv9CIQYZbrL8NUgTJWk0OYk4z4ODjkjSALHOCob4Hr4eP7f5X2r+YFwAvZWRPRKsuiHn10TRn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6666004)(26005)(5660300002)(38100700002)(53546011)(33656002)(9686003)(45080400002)(83380400001)(478600001)(6486002)(7416002)(8936002)(4326008)(8676002)(41300700001)(2906002)(6506007)(44832011)(33716001)(66556008)(66476007)(66946007)(86362001)(316002)(6512007)(6916009)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tq//HbHFv2FmTylihptGohpBTrrMTVaNuVDlo90GGf5KaIyj9UIQffnUYdeP?=
 =?us-ascii?Q?MAn8D1V1Dm2m7lVmFKgfnm9mZ1OF0Ey5X8bdkFVn+VZ8CrAjEB9OPIEjVBSa?=
 =?us-ascii?Q?EwKVLqkRiJD/JNolPmdE8kKvmOWDNmMhjXVe3gsZGVWtaVOu6ton5JJUxxYJ?=
 =?us-ascii?Q?7zF7/pNtLF3A8W9kMFYcbd58VfbohlnRTK3AON/F1GKzSM4PmeVrPyQHHkfy?=
 =?us-ascii?Q?F0vGG7ZRZJryfYLZ7uDjoBhyz9xj6J49CL9QZv4tm/XaGfRmo5oIOMww/LNz?=
 =?us-ascii?Q?MHT46QnAPs8WDwtwUSUZPKLWETfAzPr405/+EeuYYzcdsSn3l+XqdtB+v921?=
 =?us-ascii?Q?5FuLvduMXf56lhzEZs5dOqYFZztgL0hfnxvJbFSgcYO0Bw9zYbcKIYcGqa/7?=
 =?us-ascii?Q?LHsmpibKo2WpucZ4bdO6icdBKbFLHbfffFF/yH57A+DRzKneF+byWx5+S5NS?=
 =?us-ascii?Q?VQKQX0NCJa6qrBs4mmB1MrDaLRgLhg9ZJ0o+cfCMCrMaG7TQ92Y2F+IMUxzr?=
 =?us-ascii?Q?wgJ/DSnTWxMSxQwSiSoiQZE/kr6lAL71niMiEYtmKtHvpRZxjQNHyWJQ+aQG?=
 =?us-ascii?Q?8GiSoQagR/21pul1inNNxlUO5nBtNJ+ssj0GaYTYVn/7cgORM0ZY/qT6ei+u?=
 =?us-ascii?Q?PaC7GH2VBpafWySyVDz9HtNTfSzoifCaWHZgbYJM3aTQ9y0TWknP1Lbrmi5n?=
 =?us-ascii?Q?6rpR/7tZMnLbq0Bd0iH1TilprslHYwG5UiYUSEJBOsj4QdkJ2/BHE/13+7VE?=
 =?us-ascii?Q?yaez0A26UK6baQy0QvvsRgSutmCE93LT/M03PjryFmPJ8IwSlqUKVpt/Qyq4?=
 =?us-ascii?Q?YUkQLWWxrlcaREgOhq4HZ31OayhXzpiMh5gyG9WeP/ol1sMqDZC/N07XFoBX?=
 =?us-ascii?Q?61Tt7pbFO8qRCktowvDOdNPWt5Pfz1JAFVQ+Cv2roHLB2FAvq0s0R1nOEtr6?=
 =?us-ascii?Q?DG2XtUcC1cBIxZQC2TVlewpHUBcRgqayYI+i0NFKoJWJH4fv9EZJnsLg9+ns?=
 =?us-ascii?Q?4nXD7BlfMt8085tgRv5alQNV2sVEDeSlgA04HDKTSWuEk/Td5rnwKql7AVY8?=
 =?us-ascii?Q?AKU+KbB7qrGn0aNsC2WUKVokNf5n8aWPJHmC7TniejuFjvr41G0RpRgUDeTu?=
 =?us-ascii?Q?ohlcK3MaDKt8R1Jlsd380S85aDQFjV00F9jxPPBuCvcDs95KnKlBwY2GsSoB?=
 =?us-ascii?Q?F3HUPTE4whGGtVczy8uxgIMT3LGXtSwB44T4yYPowd4j6Jo+F2QFCzLwSlPc?=
 =?us-ascii?Q?nZmoJZASyTARv2tyGR88rHr2wCFsbQhNxKCM297eEReQjaVEs37Q7hSVLNUI?=
 =?us-ascii?Q?zCAYLYZiDLJWHM6ZefgaJMeg0PmHVLNqWxa03TLJZ5Hrfg5uNdpaSwQ7OC/5?=
 =?us-ascii?Q?EwZhtBp8rFkD+ol0qy62Nc2ZHzuCsFX75zCjGBAP/SmGQh4XPQpULaCuqvHg?=
 =?us-ascii?Q?XC5oiwy+kuy+OzNPByzbuH1+l4zwixOp30VfQcxQSI0FvFG6kCo4zRXNNqDU?=
 =?us-ascii?Q?Qd+epFdcULYsQt+fMHR9Lue+pLVm7H16ppcBpbPpKpThnWoBL3HEg1pCJAMS?=
 =?us-ascii?Q?okvVnpHOq58tV+cWf63VcbDy7pZiQftcdGM9mZbydfW1Ej6J9P5EUGSRx82k?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ww3/emoCr4n9vbMdzjUZwmeykUm8lOpLU394jYLcEGyE+1Rv6SLMDiZs69V3?=
 =?us-ascii?Q?+kVgFklHsehTxOgIyu/SKwZ5yggl9GiEJx+NR+XRO/i0L3u9zL4Pl6TwZDim?=
 =?us-ascii?Q?wqhqMxetMIqBz+RsHKJ79tqrfnv3U00MhcKEG5qNAX7pHzwfrG1W7HBbqfW2?=
 =?us-ascii?Q?bv0k0O6I7CSi8fWlHXwuANDubLLESg9ujHMIABTtFKMq0wzOctWfthUgmjnN?=
 =?us-ascii?Q?PsbMm/KZ6M2nMYvDE0Qir4AHnDM3GJwhLzLJttku0tPBQSpA56t+IFtedEeW?=
 =?us-ascii?Q?MUuNG68rrKP2nyz1WEiGAjTDTfuksk4wWU6yZHxHx/jUjePvMfbsoaaMr5UL?=
 =?us-ascii?Q?2rgmtTOymWTPU0Ldy3W6dbCpF8baUe6RZU1b22SlXAgdjrdaZtfg9FDf8eOY?=
 =?us-ascii?Q?1jU5utiiJ0+QH4u8dN2BqFmf7KfYiwLmbJHJzQE7DnSf23n8gDixw6BIcrz4?=
 =?us-ascii?Q?R/15xOlJF1IdSl7hhrK7j9ku4aDqwwUXAduJFro+DPTsDETvDGpcM5Oa1on5?=
 =?us-ascii?Q?UqDK8g7inMFISHqXSZ/ac1VTEdKuDfesFglB1XiyvpEq2VxAATZ0rO/XhwbT?=
 =?us-ascii?Q?ZNXXWmKEzdMBppi2vy7+UXb6P3XX1ADpDadsA7kIPrDHnI4E93PWhY950DXH?=
 =?us-ascii?Q?jiBimYGZtNqUY6pyeM3QRokdyLnhawTBoOnGGeoX6suMyMsoWeEsgS1QTUpG?=
 =?us-ascii?Q?6grdzJ/uM4kIWRmkE66g0pVSq2aaAPOE37Y76x0SVaiZjtDrZC68kUhtRQx/?=
 =?us-ascii?Q?ivLelIAjbdIbnDax7iw5M5e3gwzmjogWtjTHfmHeUAkgqwv5yp8dWnhEANAX?=
 =?us-ascii?Q?CWllhs3GyZl/+gwfkj7JGaKT4toiWAFPQ3ptvP/+r72PZJLJ7mGSUA+APaX9?=
 =?us-ascii?Q?EApkFwLcp8VMdocaYkpfsGhLMcwVTKZ03CpaXkkB7W6+/FLztWkND8jGrY/U?=
 =?us-ascii?Q?gXFHJHP/JQqARR9Y+mtp33gAsQsOOMD7pimuRLqNdEI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e83be6-6e65-48e4-168a-08dbc92f8e2e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 01:23:49.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqAom6LcBuZtBg+O7v/ubO0jPVvaaqf2goFNBlwSF2D/DOfaaMImNB9OEmtpLn6hay8n4h6oWHkdWbPjiGKdVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_01,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=771 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100008
X-Proofpoint-ORIG-GUID: oRkKYSl6bnz_Ja9W4DID-HkqMV9UatzR
X-Proofpoint-GUID: oRkKYSl6bnz_Ja9W4DID-HkqMV9UatzR
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/23 15:56, Usama Arif wrote:
> Calling prep_and_add_allocated_folios when allocating gigantic pages
> at boot time causes the kernel to crash as folio_list is empty
> and iterating it causes a NULL pointer dereference. Call this only
> for non-gigantic pages when folio_list has entires.

Thanks!

However, are you sure the issue is the result of iterating through a
NULL list?  For reference, the routine prep_and_add_allocated_folios is:

static void prep_and_add_allocated_folios(struct hstate *h,
					struct list_head *folio_list)
{
	struct folio *folio, *tmp_f;

	/* Add all new pool pages to free lists in one lock cycle */
	spin_lock_irq(&hugetlb_lock);
	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
		__prep_account_new_huge_page(h, folio_nid(folio));
		enqueue_hugetlb_folio(h, folio);
	}
	spin_unlock_irq(&hugetlb_lock);
}

If folio_list is empty, then the only code that should be executed is
acquiring the lock, notice the list is empty, release the lock.

In the case of gigantic pages addressed below, I do see the warning:

[    0.055140] DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled)
[    0.055149] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4345 lockdep_hardirqs_on_prepare+0x1a8/0x1b0
[    0.055153] Modules linked in:
[    0.055155] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc4+ #40
[    0.055157] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
[    0.055158] RIP: 0010:lockdep_hardirqs_on_prepare+0x1a8/0x1b0
[    0.055160] Code: 00 85 c0 0f 84 5e ff ff ff 8b 0d a7 20 74 01 85 c9 0f 85 50 ff ff ff 48 c7 c6 48 25 42 82 48 c7 c7 70 7f 40 82 e8 18 10 f7 ff <0f> 0b 5b e9 e0 d8 af 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[    0.055162] RSP: 0000:ffffffff82603d40 EFLAGS: 00010086 ORIG_RAX: 0000000000000000
[    0.055164] RAX: 0000000000000000 RBX: ffffffff827911e0 RCX: 0000000000000000
[    0.055165] RDX: 0000000000000004 RSI: ffffffff8246b3e1 RDI: 00000000ffffffff
[    0.055166] RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000000
[    0.055166] R10: ffffffffffffffff R11: 284e4f5f4e524157 R12: 0000000000000001
[    0.055167] R13: ffffffff82eb6316 R14: ffffffff82603d70 R15: ffffffff82ee5f70
[    0.055169] FS:  0000000000000000(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
[    0.055170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.055171] CR2: ffff88847ffff000 CR3: 000000000263a000 CR4: 00000000000200b0
[    0.055174] Call Trace:
[    0.055174]  <TASK>
[    0.055175]  ? lockdep_hardirqs_on_prepare+0x1a8/0x1b0
[    0.055177]  ? __warn+0x81/0x170
[    0.055181]  ? lockdep_hardirqs_on_prepare+0x1a8/0x1b0
[    0.055182]  ? report_bug+0x18d/0x1c0
[    0.055186]  ? early_fixup_exception+0x92/0xb0
[    0.055189]  ? early_idt_handler_common+0x2f/0x40
[    0.055194]  ? lockdep_hardirqs_on_prepare+0x1a8/0x1b0
[    0.055196]  trace_hardirqs_on+0x10/0xa0
[    0.055198]  _raw_spin_unlock_irq+0x24/0x50
[    0.055201]  hugetlb_hstate_alloc_pages+0x311/0x3e0
[    0.055206]  hugepages_setup+0x220/0x2c0
[    0.055210]  unknown_bootoption+0x98/0x1d0
[    0.055213]  parse_args+0x152/0x440
[    0.055216]  ? __pfx_unknown_bootoption+0x10/0x10
[    0.055220]  start_kernel+0x1af/0x6c0
[    0.055222]  ? __pfx_unknown_bootoption+0x10/0x10
[    0.055225]  x86_64_start_reservations+0x14/0x30
[    0.055227]  x86_64_start_kernel+0x74/0x80
[    0.055229]  secondary_startup_64_no_verify+0x166/0x16b
[    0.055234]  </TASK>
[    0.055235] irq event stamp: 0
[    0.055236] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.055238] hardirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.055239] softirqs last  enabled at (0): [<0000000000000000>] 0x0
[    0.055240] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.055240] ---[ end trace 0000000000000000 ]---

This is because interrupts are not enabled this early in boot, and the
spin_unlock_irq() would incorrectly enable interrupts too early.  I wonder
if this 'warning' could translate to a panic or NULL deref under certain
configurations?

Konrad, I am interested to see if this addresses your booting problem.  But,
your stack trace is a bit different.  My 'guess' is that this will not address
your issue.  If it does not, can you try the following patch?  This
applies to next-20231009.
-- 
Mike Kravetz

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f3749fc125d4..8346c98e5616 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2178,18 +2178,19 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 static void prep_and_add_allocated_folios(struct hstate *h,
 					struct list_head *folio_list)
 {
+	unsigned long flags;
 	struct folio *folio, *tmp_f;
 
 	/* Send list for bulk vmemmap optimization processing */
 	hugetlb_vmemmap_optimize_folios(h, folio_list);
 
 	/* Add all new pool pages to free lists in one lock cycle */
-	spin_lock_irq(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
 		__prep_account_new_huge_page(h, folio_nid(folio));
 		enqueue_hugetlb_folio(h, folio);
 	}
-	spin_unlock_irq(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 }
 
 /*
@@ -3224,13 +3225,14 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 static void __init prep_and_add_bootmem_folios(struct hstate *h,
 					struct list_head *folio_list)
 {
+	unsigned long flags;
 	struct folio *folio, *tmp_f;
 
 	/* Send list for bulk vmemmap optimization processing */
 	hugetlb_vmemmap_optimize_folios(h, folio_list);
 
 	/* Add all new pool pages to free lists in one lock cycle */
-	spin_lock_irq(&hugetlb_lock);
+	spin_lock_irqsave(&hugetlb_lock, flags);
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
 		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
 			/*
@@ -3246,7 +3248,7 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
 		__prep_account_new_huge_page(h, folio_nid(folio));
 		enqueue_hugetlb_folio(h, folio);
 	}
-	spin_unlock_irq(&hugetlb_lock);
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
 }
 
 /*
