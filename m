Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C2F79D788
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjILR3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjILR3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:29:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF7310E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:29:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CHJVVG028541;
        Tue, 12 Sep 2023 17:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-03-30;
 bh=mvcv1Ik+e8D0iIccvyilac7howgFIjChKi1sIT1VYAA=;
 b=BAS+625yA2sFy/JukAzTRSwfgKq7R7UBsLw4IvlV6NvhX0VrNlRGtv4yIrNJ4gmQ5kDN
 feHAmzSiBWopqe56Ht5QmxuqdZXamcbz6VNYNJpiNT9gNcuwU0qiVKD4jPVxuSqhjGv0
 16+FLX7e9Rvcv8YWq3bC/KraZnYgtlb3xtQSBsPGk0UXIUWJsUBeZzn1asECmdArsoRB
 QNgSDcdU7os31A8RaJK6dNyVOEflGsL8N82xZdJmZW1AUfHNT2J/OtPeMRiTQIRb0qHe
 qyHlrzBDjSqk21yoynqag8MKHCtGcdgVROBp+2MObo/Xjm8VYZiEtuARz7i2yeczyYGZ Rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jp7cj6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 17:28:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CHJJSX023178;
        Tue, 12 Sep 2023 17:28:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f56b3th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 17:28:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHsehZgKdWgefHzcMFpITIzAczt+2Rx1YEH3erPOWk9KaN50ZgQ3rYkZSAEeoqEl8njXOxybpEHbWWVn7ts/4R9HI4wPv21/FO70LOt+ftTL7We0Gg837s/F3evLKj1iuadtH0GuRDfshx4Ir0KdLjTWacaMIs79KaUgQYSTEUdQn2QBa7HOAiDW3kmP4aFRIHTE65cNQH2OFTbM9wAU/nxzrclzU9VjHN5Q2jjHtJuPhK5Q4VDDn5Vprz0NBgkM/ftxJI7Z9Y/S3mliPdljtJ6F+VctED9UBlCVgp2E7/gOIQDbb0LLreRTfqEWCFVkO4IlUvdEqQyaF47uSxdYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvcv1Ik+e8D0iIccvyilac7howgFIjChKi1sIT1VYAA=;
 b=Ho9jWd39VPkmGMYjWkFrMjvieCSVaJy/2FKG5WahERvQ92IR60RRGF9c2vnTUoojpMjgDEj6kK+Z9eZHvxKfEnvz8tnz1k5dUntiF8nPXysemerBieLQjN86x0cAmGw7QqKoXkYVaHzMwlTduWzBXKVTrnLd8C7GQwlP8paV3/0SNXGXXOZshw9UZpWs+jTOlUC0e5gtueil+gMCMlz0FM2cx4Ey8mvEv2aVLnwcbsfnb759RF+WXf+PR3gw6Byf34BfnxzqpOnWsLPbL8lCSK+9gx7iSlh6H3to15LOrvgodlxZgsAJRibRO8NLp7IqIdADAyGLs1HL42EmoX9+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvcv1Ik+e8D0iIccvyilac7howgFIjChKi1sIT1VYAA=;
 b=IPXriEUpYIDCyKcT/jK7V/jI+4QBxkd2uIGPTjw4KJwKiQ1KACaJEfwwVZEPnDzoZl25FVY3kqGwKcjJnMtDFiE0x+bdZiWLb554HPnCSUfGFZNl7KL99uNGUmwI1PPmuhz3WhHCakPvX9085uLfsd1Ov1l/3m2wQJMaAk+kDkk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6152.namprd10.prod.outlook.com (2603:10b6:8:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 17:28:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 17:28:48 +0000
Date:   Tue, 12 Sep 2023 13:28:45 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     maple-tree@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Maple Tree Work 2023/09
Message-ID: <20230912172845.o54szwf33hc6p7ee@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 2720af2b-0033-4f78-6562-08dbb3b5b93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1n6Z9fp4flJ1wcLHedG2MSgf4cnhbv8NWCFR6PXf4e8YZvNB7DxyChQG8KcEwNXCsaOferzhQsIxyFc6xmsq3ioFuDp7G5NUstBg6JQVUwN6kqknYp+DyrDm9pjKm/H9dvjAafKPBoaYKjbXt+HIS4TMox72gSkTsPH9q+OF2t5mC0Mxs9gF4k/qJyNxx1eGkqSzojAOwx1BGhPA2IpwGlEfMg5wCgCs07bTAikehXgSTcJBc+ngKiJ2g0X4Sdvd2G7b335aTeQEbPkybPtXhpPva30ICKL5kJP+5t6pcPMj/KAPRZGAPXsfOum80QgDFYZOuieEbrMoVhsVxEm9SKb25JwK7cYWL7jltiNOf86FV8B4W7Rs2vrRdpo61Sglo12sGd2w7o0YCvaVCtGbo+33i3vnA8EIlv+GiS42vayrPStohQf+dsz/CENLsK9PRhMKing3cFf+6kOdrizqjUidMudvaAdtHlyWH/iqY65CGyY0L4Mjj09T/oMRPQr2nX7zpJn5rq4p5B65yuJcG1PgOAMt8N1/wE3cW2Ru+sCsXb1MbKYQshskTLBY4yw41AZ8ip/hXsRlClIfxlh9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199024)(1800799009)(186009)(6916009)(478600001)(4326008)(8936002)(1076003)(66556008)(6506007)(66476007)(6486002)(8676002)(6512007)(41300700001)(9686003)(316002)(26005)(966005)(83380400001)(5660300002)(6666004)(66946007)(2906002)(66899024)(33716001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oLV0VvxzLROGFtA2vI+/9P1wpNcPwP2Y2mN1NcxuMpJd4nXlvof45xitS0Nm?=
 =?us-ascii?Q?zhdKdDsEUZ5O8/w3pCOCC/3FUBU8+Tgkc5Z+uJZdQDbYg58yAH4kIvpfRl+r?=
 =?us-ascii?Q?Jq87MgILB0RO4Kz716xa/BF1Uw9CR9f3ieFvg7O0Jw0eYMQd/LcswXdiYulv?=
 =?us-ascii?Q?k6qwwnYptqi1Jof29v2GARiTrRzZF7bvvxTVOi1Bv6lTx9cX3fTLLg9NNaOF?=
 =?us-ascii?Q?3Jb2OlUP+IKvhA4/lIWB5/dekD87sIHIFC6xcXeCALMosio1mx/ooR0ZsnB3?=
 =?us-ascii?Q?lzz7WOgo/ULRBJgs+p7fmnftsfplrWDYpOrhXM4bMhfuxvxD6rbfqKWKh7s/?=
 =?us-ascii?Q?fAzQOWzfVUwShxH3kuCBY8axDN6s/3bJMjLHfGqH3jawWLifpCgXu+GkinrP?=
 =?us-ascii?Q?g838aWry1VQ3mWXmt2NK44+pRqkQgYXiU7LjZSEVRXAYijnHnzbuCA+1nJ8e?=
 =?us-ascii?Q?nl00Cv4FGnCK3miN6hN4IbPTOnkXoz7bJBpCe6MNUTe3BuQt9X4uoR8wHVdW?=
 =?us-ascii?Q?SpaZ5yUN8P+NOp+Fpu3+1ogwEBZLjWJjOWRdy9dNlirp81orQRi9C5PtBDxC?=
 =?us-ascii?Q?dm5/3kSFGcjuleOS0fDl47A0sMqV2fxmbLBNYmW4O66Jn6QV0r6V8PyH+DFJ?=
 =?us-ascii?Q?d3KtPoij3vUiUpO21ep3spfFVWzvaMAWdMjhS2V5LfQO+CQ5vK7YPRNmEuNa?=
 =?us-ascii?Q?bzd7fxtYvRaK9+od64RmXJfGlHWoD5GGaRtkGsZnucUCCeC6JPJUKho7pTIC?=
 =?us-ascii?Q?KE024C3ZUFBjILgPWCDJCCg2Q/xpm5DHSWyjsllWbwAAEvtN6OHbB8cFrKXJ?=
 =?us-ascii?Q?84vPTlJ5Qi1Wtk+IZXyA8HZ2h79WjkFynBW/h2TlWUuRSVPMxb5scTzyquMo?=
 =?us-ascii?Q?iim2wbX0UEQmweYXpaK3asDJCzI8kHYqXgoC5U/DsvkS7D++HUkcGOmmkqe7?=
 =?us-ascii?Q?blQvCx450vdHQxr3GiyzcyTEaDg0lCcHh9hVObnGD7Qf6Rux3U5tbTa1xaho?=
 =?us-ascii?Q?AUBBmc4ysg6ZI1YM8IEVHhwjpbNJA0QtQhcdZzLzQrYpeGNA14x5MoNsnY8E?=
 =?us-ascii?Q?59kFUqklG8rrDS6ungTbV3uScmByro1zs7UjKY7fwRNsLbjawnLhch61b0Dc?=
 =?us-ascii?Q?3B3/5uVswjn7GFI8CHMohzP4OlO+aj4wik8BinD+KN6kWX9firQm9kcmmMqW?=
 =?us-ascii?Q?JVYSxW5L+sJYp2XXeAme9DxnZ9WRSGbsxqOBVmvcBTqVOnkON6PmMKpDYpT5?=
 =?us-ascii?Q?X3qdgx3XfQxCLJIWQ63VdoFEt6klHK2a+IIAxA0wJ18GMRlYdgzXWtS/AcYh?=
 =?us-ascii?Q?rEPvq19zYTc5gnsVO+PYJ46noWMORak+rZkK+dEV+05vGvegbui1Jy5lQsMR?=
 =?us-ascii?Q?3GS+ib1VVWPRwVX3htJh6dSt8oeYAujKNGg3mgkMKUQj0NK8Me6nwyHYDk8U?=
 =?us-ascii?Q?dHeBsWDnnOt6CthaeylCs7ZElXZB4iTOtj51HM6ye42Ag5oIEo8NMeL283gh?=
 =?us-ascii?Q?MkNhCUL4brydRTKg4fioBuveCWkUk8eL+rUL7rTw+NG9YnuuW9Pz1AIJTxcL?=
 =?us-ascii?Q?KehN6dD8JxFDaoVvUbUY6rZ4WDxIKTW4CGtmfBxDQIH4/MPfWcMOqE2sH1H5?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: baAoxeq34FrweB7d8cJ1vUJ16AzwqAxn199OTS+VHWUp8O2NPfFY+oHYOr6wyVfM92PrKe2HK9e6KVMEffpJBeAbeVFkeOGZfNNC9TqZ2uq2OKtMeo1oe2Xn5SiYeVQt1wrcm3NC3HkMfNiW3iT6Gz+eGgMfwVbqphbIc+QE2h6/DVjkR93THBUA4R6qXb5GlxxT+/ASvXg1DpsoWMPxGtgDE305mZ5AoqZ+uSIdVv545KrvQ6HaJRGgukTA4N9kFfZDkmMIJrfUBSR0mEa7tks0V4XkpuZjisEO5miTjI8htKT55G4c54ptBcc9nLd2JP55w3cDu+lHzSFWAP3J+nLO9e1Hj9t4GKPhittWyf0jYoyL7xuuqMQTVfWA7qQSwtsZzBh0G9xfmkZrcAj1qKBxOVC/4wa2O/YzACm8f3GbjkW1b6FkNb1CFStAhA65rYv3KegR1tuVt0R9jvLgTFLV/oB4A8/XS/4Q24BUiYPigVnvEkBE1wCP1UB0R6fHq/Ocr07rBqD0p5TxhLC1jgf16WmpAn+yGMyUQ0Z7qtw202l8YmU77yzaSOHqaCnI2PCZQVYDz/Wdr5j3+wJQwrYLBp7F0K2X9uizGxva4ywH2Irsh60CyOQQTamRwAr+y1XmzTawB1VSGLTYYBFsnmsjlJES+HLsz5uA7s10RAGVhHE9RFuk6yX9a49fmZwsB7SpvCe9mrA+NrLSMSGDz7JOTXinnQG7azynFcNAvZkQ8PpeGZ8GWyLxmBOQpJR6KgC1pIbFecZSGDTsk0x/fe8oBzYSQsoBxrL91nTQarJAm0lW6sy7Hips2BFX0l3i17eLnQoQlOiRMWJRgyrPoQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2720af2b-0033-4f78-6562-08dbb3b5b93b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 17:28:48.2961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Zo+HbVtOrqt/NCwE8JCx0CIAy9MsnPgWINoOn1cUbq8VDw+L2d6iI6t39xE3Kq3c8elHpDb51bh8+93VHcSHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_16,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120147
X-Proofpoint-GUID: lNjS7GeMgSDRG5v-Tpp9bZp_PlTOus5Z
X-Proofpoint-ORIG-GUID: lNjS7GeMgSDRG5v-Tpp9bZp_PlTOus5Z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This months update of the maple tree development and work items follows.
I send out an updated list monthly with peoples names against work items
to avoid work duplication, so please don't work on something with a name
next to the work item.

If you want to work on something then please respond to this email so
everyone knows, and I can add your name to the item.  Feel free to ask
questions to clarify the feature or discuss directions.

Likewise, if you cannot work on anything anymore then let me know so
others can.

If you have any ideas, then please email the list.  We can discuss it
and I can add it to the list.

Please sign up to the maple tree mailing list [1] to get all updates.

Features:
 - Better preallocation calculations - Liam R. Howlett 2023/07/07
 	Without tracking the tree status on the walk down, we can
	partially walk down to figure out the type of write and which
	'worst case' a write will cause.  Using this "write type"
	information, the preallocations can be a better estimate. v3 was
	sent to the mailing list [2] and is in v6.6-rc1.

 - mas_store_gfp() align with mas_prealloc()
	Right now mas_store_gfp() is going to allocate once it figures
	out what to do and it does the worst case allocations.  This is
	inefficient and can easily be done better by doing more of what
	mas_prealloc()/mas_store_prealloc() does - or at least will be
	doing once the 'Better preallocation calculations' lands.

 - Tracking tree status on walks down
 	Track in the maple state when the last minimum nodes, space for
	2, or space for 3 slots occurred (height in the tree).  This
	will allow for a better estimate on how many nodes are needed
	for a write.  This can be complicated on next/prev walking, etc.
	It has to be done in read mode since some walk may have been
	done before deciding to write - see mmap_region(), for example.

 - Store type (enum for store type?)
	Extending the "Tracking tree status on walks down", the
	information can then be used to determine what operation is
	needed during a mas_prealloct(), etc.  The operation can be
	stored in the maple state to continue on a mas_store_prealloc().
	Obviously, this would work out well if we have mas_store_gfp()
	using the same functionality as mentioned above.

 - Full count/flag & Dense nodes
 	There is a bit that exists in the pointer reserved to indicate
	there is no NULLs in the leaves below.  This feature is mainly
	for trees that are non-alloc trees.  We can then know there is
	at least one singleton that can be stored below this entry.
	This is coupled with restoring Dense nodes as a potential node
	type.  The tricky part is deciding on when to switch to dense
	nodes/back from dense nodes (all entries to dense nodes must be
	singletons!).  See mte_set_full(), mte_clear_full(),
	mte_has_null() which use MAPLE_ENODE_NULL.

 - Fork & Dup tree + Delete DONT_COPY - Peng Zhang 2023/07/12
 	This is to optimize dup_mmap() in kernel/fork.c, but other
	users may want faster duplications of a tree.
	This should be faster than building a tree in bulk mode.  The
	idea is to just copy each node and replace the pointers in,
	probably, a BFS order.  Once the leaves are reached, the VMAs
	will be replaced by the copies made in fork, unless DONT_COPY is
	set, in which case the VMA will be deleted from the copied tree.
	DONT_COPY is not common and since the tree isn't visible, all
	nodes should be available for reuse (no RCU worries). v2 was
	sent to the mailing list [3].

 - Push reuse parent
 	During an insert, new nodes can be "pushed" left or right -
	see mas_push_data().  On a left push, it may be possible to
	reuse the node by making the write like an 'append'.  This may
	also be possible to be done during a split operation when the
	write extends the last slot. This needs examining to ensure RCU
	safety.

 - Contiguous iterator
 	Some users want to iterate across a range of items, but only
	contiguous items.  Sometimes a gap within the range is
	considered an error while other times they are not.  Good
	targets for this feature are mlock() and mprotect() system
	calls.  The goal is to provide an easy to use interface that
	reduces the complexity of the external code that keeps track of
	the contiguous nature of the iteration.

 - Remove BIG_NODE
 	maple tree nodes are rebalanced, split, and updated using a
	maple_big_node struct.  This structure is over twice the size of
	regular nodes to ensure there is enough space to contain the
	data.  Ideally the same feats can be accomplished by using
	regular sized nodes.

 - Test & Fix destroy_rebalance
 	Destroy_rebalance needs better testing when it occurs in rcu
	mode.  Currently it is not used in this mode, but it should be
	supported.  This part of the code needs better test coverage and
	fix any necessary issues that arise with rcu readers during
	updates.

  - More userspace testing - Liam R. Howlett 2023/09/12
  	Add userspace fuzzer testing to the test suite.  There was a
	patch sent out to create a basic clang fuzzer.  Using something
	along those lines, write a fuzzer to test the maple tree.

  - Live locking with delays for testing
  	Add some sort of functional delay operation to work with testing
	to reduce potential locking issues, especially with CPU
	contention.

  - mas_for_each caching of end of node
  	Adding metadata for the end of node was a big performance win.
	Extend this by caching the end of the node while iterating (to
	start).  Later this could be expanded to other iterators.

  - Add min split span to parents
  	When nodes are split, the parent node splits by number of
	entries.  It may be better to split by range as it would help
	avoid splitting more frequently on inserts.

 - Search Marks
 	To complete the features that xarray support, the maple tree
	needs to support search marks.  Marks will replace the gap
	tracking in a new node type complete with searching for a
	specific tag from the top-level to the leaves; just like the
	gaps that exist in the allocation nodes.  It will probably need
	two new node types (range and dense). Dense with 29 pointers,
	range64 with 15 pointers.

Larger Features:
 - 64 bit stores on 32 bit arch
 	A number of users want to use the maple tree, but cannot because
	they need a storage medium that supports 64 bit stores on 32 bit
	arch.

 - wr_mas with alloc instead of mas
 	Internally, we have a write maple state, but the maple state
	currently holds the allocations.  I'm not sure if this is worth
	it, and it will probably need "Tracking tree status on walks
	down" so that preallocations/allocations can be accurate.  Other
	considerations are how mas_prealloc() would work with this
	change.

 - Big Dense Node Type
 	There are various node types that could be added to the maple
	tree.  One of the most useful is probably a 'big dense' with the
	node being a 4k block of singletons.  This would have to come
	after the dense node type as dense enables more users and helps
	scope this work.

 - Judy Array
	The Judy Array is another fancy data structure.  Mathieu
	Desnoyers has enquired and spoken to us about incorporating judy
	arrays as a node type or other features he has in the judy
	array.  This is in the early thought stages.

Please note that any new features will need test cases added to ensure
they function correctly.

[1] https://lists.infradead.org/mailman/listinfo/maple-tree
[2] http://lists.infradead.org/pipermail/maple-tree/2023-July/002736.html
[3] https://lore.kernel.org/linux-mm/20230830125654.21257-1-zhangpeng.00@bytedance.com/

