Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C52E7B8C91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245274AbjJDTJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245319AbjJDTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:09:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65533FC;
        Wed,  4 Oct 2023 12:07:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FIvSC014481;
        Wed, 4 Oct 2023 19:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=hnTX6JrAqH3NtQ0W94+mbSxCrgcHLBYOxmuSdrmtfuo=;
 b=dOEjxqbxaek1GsTfu3NHWxN8B1QbmlCS9fXJ8Kec3qQUlPAptb/uc5HLBPKQXFudpnS6
 eRIBkgsbRLvRvmar3l+jAgj6YLsOKXlzoWp9S121EShgC4km64rACgYEsaFIfwyte6fK
 3yKR6MWdF5RJCLTEPe7HxMJWJ058ZBjAkjE9cuYpgmnU3Oto8bfuhU+94iNgX0qVW605
 C5o45cCsW2ub+Ekjfbjo1GN6J0zknp7CFEqpQMb+XJZnqivzD1uFbVWaGXqZLTR0biKW
 NUoFhwbsZXhkk5u97bcMTP6U47+GU3V+sXopbhDdxdeSdi4D6JN7e+jhqs2qCw3+Um2r Iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea927vp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 19:07:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394I5nAO008769;
        Wed, 4 Oct 2023 19:07:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea48hpgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 19:07:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWnCbA1rlaqmccy40RR3a3npWvpGA6lYV8j6H9ViizVMdyfSMlBWDpIOESxqVUdPtdUYmFBiNZDjZ1O9hAQMrtkvxJ8zONi1TPggwickN1gWdJq/2Uxkdg1ut9+a9KQbvgWaSuuvZDhslhlUjPFyhboY428LwCd8KDDdXZHbeMR3ZedsBqR94MK/ER+NzDTq1ZId2/KnfQs2PjlcvB+jje7nsdY4HZJf6HWsaaP7+JaWLHERLIdae8+OLoSqEc5+1/4gGz+xrMREd73ILSm3amdF1jMkQZ5FoYR37jQ7qnTVJP75JUYbEQsU0s7nEGQ2aPuU2J/G3FSvBDDh8vq55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnTX6JrAqH3NtQ0W94+mbSxCrgcHLBYOxmuSdrmtfuo=;
 b=S7zN6ian7aveP4dM6Z2nNx40bbf2c4djOkdzG9t1oypthiNg5dYhcunuFeXseZofw2fwxLC+9VifcKk6O/faskTINpTp13WgJoLwviOfcRXNM8lI8X17+Uq4jXsFv2HCcrwCMiXVd2An6Uy3hQHGHYliXsFc3MxUxrELMX3yKm5NNOIRkCmNQERm9VZVz6/DDjja/2tRUCcEHp+mVfe4kQTjHH++7GID/VQrmsAy+MLxP03IyQSxiY1iMv6g4VzBorYC5LZMYAwblbeVVBJK6G6+5x8zaPlGgal8R7zTJYhRfhC8/Dh4jezUmCV13SIA0rfJiF1APqSQTVuoKWd55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnTX6JrAqH3NtQ0W94+mbSxCrgcHLBYOxmuSdrmtfuo=;
 b=rBcz8cUTfgfRbk5f9qfuPEsLz1D96IFxJAu4XaJRHrWNkAi3SMxGcCHCEnj6WYWDLpo5aqcRRfIazThVkodpTFCZ+Tn8Ad8bV9xMl1N8Eet+iE0odk3GymglO0tLFZCnRR3xIn08TgULw6nKVbnWTU/75VjlGmTO0UIyRiq74tk=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by IA1PR10MB7357.namprd10.prod.outlook.com (2603:10b6:208:3ff::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 19:07:18 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48%4]) with mapi id 15.20.6792.026; Wed, 4 Oct 2023
 19:07:15 +0000
Date:   Wed, 4 Oct 2023 15:07:10 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] padata: Fix the UAF issue related to parallel_data
Message-ID: <paajlxnnp6isq435i7w2onndi56xpwahq6tl6hbjwqdhta375l@kqgpf5nkcsog>
References: <ZRTLHY5A+VqIKhA2@fedora>
 <rjayevj3rwpj6wt2uq2jc7c3oqbewnobdqhs5bkrjte7fxzkct@k5rpt4g6tnqh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rjayevj3rwpj6wt2uq2jc7c3oqbewnobdqhs5bkrjte7fxzkct@k5rpt4g6tnqh>
X-ClientProxiedBy: YQBPR0101CA0350.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::24) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|IA1PR10MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f029be5-b6fd-4ba6-0117-08dbc50d1f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPIpfEpupZaYwgNOSZZgeIZ8lV+Q2fkEtsXWrA9IGP9tRoGdL1Xmv85vUbYp7vZ6szOjKfrRQvxCXyXu3hh85rwkRhnlBdpbmUlaFHvwtKsP48Bg5vcv+5zDAbCTBNYPDgS+UiRViAiTy5JlULSlTCr5OzpB7PNYcq0qm4Ah1BDMbG6xm+0iuuRMhwrb4LuO7gBsKWl2MHoPifRYinSew1IIQk24qCJYY9HmoiNlI2cvyfZuxP5JO83WEYOX/OKBgrGx2pw8nBNlNsFpptgLQ0SJQ0tNrdRnEQjdzCtQuonzaQVkjSHyxk8jqmFw7V/7DQlDwGyFSomQ13WmpU+xnYuLqR/GklJQrH0UVtEdUJX4XYkK1yXR3rJrtpGqSykhiJkix7L5RV4MsDZJBCKGc6biEXPWW1L5O5ZPRTf8aIEuxYekgNCbhw2r6odL3dHfaK9QQLkT3wByz4QThIv82RK6qs+BIWNqPcqUHY680EgqvrVrfHj3myCmX93oz4OVtHMsYWLuWr9NYcF8xiwQYWrK9xHPRwFkp311AVZWxsIYOFm29YRB9nCuNRE3lz7RTuWt6dmQ5QYMh3bUSVc/gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(5660300002)(86362001)(8936002)(8676002)(4326008)(2906002)(966005)(33716001)(478600001)(6916009)(6512007)(9686003)(26005)(6506007)(83380400001)(6666004)(6486002)(38100700002)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gcMkMenA2oqUMjlZ1gF9XrDoUEV47Pf9VWMvVR10LS6ignvgnMExo2Y4tsge?=
 =?us-ascii?Q?tnAJCXMbcHcA4CtA577S1ugSl01KVa9Ea4eKeYyQ1pQyZE7rep1D1zuwG7V3?=
 =?us-ascii?Q?gtvu/FqDWsYFoIs3v2IO9Ygl/UjJhGmcWGchYMrxoLIXu/q1aHZKoynn9mmR?=
 =?us-ascii?Q?cLmrRRLvyXMWxs4MMKPFasvZvYF+0yjfNFwF/+TUZlRdExvl5sZ2zU1rp7pX?=
 =?us-ascii?Q?xu8rGD4WZm+v07jsjBwmPFOBvRFA6Oz1Rm4K9xR8pkzZ+f/5hOob/MXPn/Aw?=
 =?us-ascii?Q?NfPvt3XDLICx8+TgRAjrMUDnb2/hW+bi7wZq8Ry5+C88GdXjSlX411HHmgAT?=
 =?us-ascii?Q?uU/RwFK6rIjBcnLulzwXJnAet5/JoePRomoeyLxv5Tj7cTlD1RHfgnLpegng?=
 =?us-ascii?Q?pzQGEZCPBTUzkna6Dt5HMwlEZctSt5I4gBuxhHjwoTP17SoN4/QhGeV3SkZH?=
 =?us-ascii?Q?AtjJMBk9e2ozCagLKPICX8qg3DAwE/xpatidUE4CTsIBhhpaCSuEDe45irPr?=
 =?us-ascii?Q?owVHZ6zLLtrcVKhYSIsPHVbLxyYczraDBJRZ587XX3kGQhLkFOaAFMriJuW+?=
 =?us-ascii?Q?MkQzIQognV8OgXG+V081KJ9mDf7B9btCQOW10J3qIy4kIucuD1fCZ2U1l04l?=
 =?us-ascii?Q?xjhTnKApW8M6vsJP3esfWp2fpWtmm01EsAW2a6MXp6EO5HW5IZlNpbEyf+Ej?=
 =?us-ascii?Q?npiE3R8McFT5WSPUP7wFHnIfSqaUxB/GgjIaqRYMBHzBAfiCROsQjiEpAiKM?=
 =?us-ascii?Q?4EN7a2DGOmpBmmIBk5/HeUdUgZAWALytOASjUnoCBUhk7FoPBdzCeHSRNCvB?=
 =?us-ascii?Q?S5DpWOpDJHTEu5QRBHOBXstR4waNxSRn0NXuMUWCf8FhI2M2HytYjRl/cKXO?=
 =?us-ascii?Q?DOPmLq+tpfsV/7Qjex/D3DfO/90d1eyk8+DX26KfNVp6alhq4pSyl5LuUnN2?=
 =?us-ascii?Q?S3qN2DMbvc79ZKSXYpDsDaJ4LW9jh8wFWBp3f+tSB+irxvqn6Japon/+z6Hm?=
 =?us-ascii?Q?gjENPCNbMji6BXC9aHZNP1J1vvs1oCH6XwM72VtEzJWeucUAtWFrwbiBYHDR?=
 =?us-ascii?Q?eDQlftcuT1bH9BxbFbZuyXr2G3sO/e/WwGaQzdgtKtdsIjd6iVh1VqV8aw6+?=
 =?us-ascii?Q?/5lxOwouV1NpiOgjABOhX2TooRMWzbGUP+D3GRwycEuHLk93JnINAf6s6n4T?=
 =?us-ascii?Q?LVEaU2nxRtYlIOmQVke2xIr4rlteoYjCW7KJk+3W+PEB1AjPy8hCXnS3ybsP?=
 =?us-ascii?Q?CIy278gnJrnQW1lA09aYvzi3AJsX6tWzLqzF811SvsZsNm2plD+Jvlf1IZlP?=
 =?us-ascii?Q?FWypba81cx1n9bYzp/C56hfYZYZ0WgYkJbLBolJEJl1pwEUp7773Uf/r8trV?=
 =?us-ascii?Q?LOQSga+le0OfExZ/OT/DhxlkHfJT6Z92H8ezMV0ylKZLFsqSoetO0k59nC8b?=
 =?us-ascii?Q?Jwn+Q1tteBvJ3KZ7O2uUhQlGyP2q5BJuO+KNX2Y4tqA+QIt7pQvwoF52O7k3?=
 =?us-ascii?Q?Ts2BhmaDAIpHvoKhsPA5d4aT+e0YeDyAtqjqINZz8pj68FYSuWzmrz9xviF8?=
 =?us-ascii?Q?CD0Qpr1BQ3NOrDl65RS3KSvDEnmPXCRXHlVOMkLgGmdyOOgITcMEH4APbyBm?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IN76x5uC8jsg1oW0qc3FYCJrDIH+FYWvIOdD24ASOyJGb1fSSmr4bOVDxc+WPpfnD14aSI9yf3Oxll+jwpQqERjkpURPqjycok78VGlSTRajx8bgXpdCS9z9pBdT46OSUmMvBYjaerSd4BISogLniO5LE1dIVdWpLyyYuprGK4um5Ai0clR8ZgqaF2EeziZCiTYUR/BeawpH8dA0JLfk1evYxR04NdYQG50XNJYlKyfTtznpJuxlGjGWKKEjnCpscv76v7FlJU7hboJbFAVOOxBuy8jKYkzcXSmje5Qqfn7SeuQjoWNUW5Ews8rdBV32/Ul+sDeS4mKt0Pxx06Pxynerar2dyiUGyAiVPv7CyI+btS3FTNqlVN/fRYBdtYNtBxuJP5tdQXTVlzByVxWlTGsZMQHN/+fiO6+mgLp7ntWZw8fxg4Kv877k3AVgPh/gNWWrE27wquCIa/7PjHxgy9Cor1p4bJ/5P+juqkn+O+cpAZ5iYGNEq4TaaI3ub7rZEaibMgf8mvY5w8dCANLIkrKRMRoo0HAA1FxPQd+fZwns/5LSdtkjZoIJNR0O1Broi2RcPrObYSkBlLCd4IGlwN6NQOQWZg1R5xedmrg456bHPcyuQHsqwSzdZOlmcDTq544I1GJGJVrE1uC6qEcK3sefkEKwRHBE7cLUyRuz9aSks+oUCdj+VIRSdufWoADB77GeOLNp90eeF3qqa1D0LmIsaVTFOQBdruQ224tPscD9HyIKPnRsMLhJ935ekIqH19sME1iWTKBE1ysMX4ZSLcCWSLQYPJYD7h7XOzCPiE8K0vyKLP8WT0IsWwhGwx5FWsfCjhabnRgQxCxkF1iGlQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f029be5-b6fd-4ba6-0117-08dbc50d1f6d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 19:07:15.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1j5Roa1iEozPIWyvgsqP3eirkEEWwmFGJFckwnhilrTCNA+n76ch0kHsUFOHT6yLQXuf5znI7f7SN4pAA87hGTYj5ynHtIJrLNXI99FZgJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7357
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040140
X-Proofpoint-GUID: umZOYrxAwSsRBTlMFDhAwuKHrOjEpKX0
X-Proofpoint-ORIG-GUID: umZOYrxAwSsRBTlMFDhAwuKHrOjEpKX0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 10:54:29AM -0400, Daniel Jordan wrote:
> On Thu, Sep 28, 2023 at 08:38:53AM +0800, Wang Jinchao wrote:
> > In a high-load arm64 environment, the pcrypt_aead01 test in LTP can lead to
> > system UAF (Use-After-Free) issues. Due to the lengthy analysis of the
> > pcrypt_aead01 function call, I'll describe the problem scenario using a
> > simplified model:
> > 
> > Suppose there's a user of padata named `user_function` that adheres to
> > the padata requirement of calling `padata_free_shell` after `serial()`
> > has been invoked, as demonstrated in the following code:
> > 
> > ```c
> > struct request {
> >     struct padata_priv padata;
> >     struct completion *done;
> > };
> > 
> > void parallel(struct padata_priv *padata) {
> >     do_something();
> > }
> > 
> > void serial(struct padata_priv *padata) {
> >     struct request *request = container_of(padata, struct request, padata);
> >     complete(request->done);
> > }
> > 
> > void user_function() {
> >     DECLARE_COMPLETION(done)
> >     padata->parallel = parallel;
> >     padata->serial = serial;
> >     padata_do_parallel();
> >     wait_for_completion(&done);
> >     padata_free_shell();
> > }
> > ```
> > 
> > In the corresponding padata.c file, there's the following code:
> > 
> > ```c
> > static void padata_serial_worker(struct work_struct *serial_work) {
> >     ...
> >     cnt = 0;
> > 
> >     while (!list_empty(&local_list)) {
> >         ...
> >         padata->serial(padata);
> >         cnt++;
> >     }
> > 
> >     local_bh_enable();
> > 
> >     if (refcount_sub_and_test(cnt, &pd->refcnt))
> >         padata_free_pd(pd);
> > }
> > ```
> > 
> > Because of the high system load and the accumulation of unexecuted
> > softirq at this moment, `local_bh_enable()` in padata takes longer
> > to execute than usual. Subsequently, when accessing `pd->refcnt`,
> > `pd` has already been released by `padata_free_shell()`, resulting
> > in a UAF issue with `pd->refcnt`.
> > 
> > The fix is straightforward: add `refcount_dec_and_test` before calling
> > `padata_free_pd` in `padata_free_shell`.
> 
> This could use a Fixes tag.  From Nicolai's patch[0] we agreed on
> 
> Fixes: 07928d9bfc81 ("padata: Remove broken queue flushing")
> 
> With that,
> 
> Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> 
> Thanks!
> 
> [0] https://lore.kernel.org/all/87educb7rm.fsf@suse.de/
> 
> > Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> > ---
> > V2:
> >     To satisfy Sparse, use rcu_dereference_protected.
> >     Reported-by: kernel test robot <lkp@intel.com>
> >     Closes: https://lore.kernel.org/oe-kbuild-all/202309270829.xHgTOMKw-lkp@intel.com/
> > 
> > V1: https://lore.kernel.org/all/ZRE4XvOOhz4HSOgR@fedora/
> > 
> >  kernel/padata.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/padata.c b/kernel/padata.c
> > index 222d60195de6..acef1e703a8b 100644
> > --- a/kernel/padata.c
> > +++ b/kernel/padata.c
> > @@ -1107,7 +1107,9 @@ void padata_free_shell(struct padata_shell *ps)
> >  
> >  	mutex_lock(&ps->pinst->lock);
> >  	list_del(&ps->list);
> > -	padata_free_pd(rcu_dereference_protected(ps->pd, 1));
> > +	struct parallel_data *pd = rcu_dereference_protected(ps->pd, 1);

Oh, I should've also said please move the declaration of pd to the top
of the function like scripts/checkpatch.pl suggests.

> > +	if (refcount_dec_and_test(&pd->refcnt))
> > +		padata_free_pd(pd);
> >  	mutex_unlock(&ps->pinst->lock);
> >  
> >  	kfree(ps);
> > -- 
> > 2.40.0
> > 
