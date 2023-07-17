Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F22756AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGQRcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjGQRcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:32:43 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2058.outbound.protection.outlook.com [40.107.241.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1909C19A4;
        Mon, 17 Jul 2023 10:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmJfR3T7ec56i+afW37dSxUj4Z6UA3HcIxko03wC5gLw9nHMXG7D1O9L+C3n4KpiwOiOz0BzzqcB2i9brF5UjnxwYKNZFVNDmiNhKLY3jb2J70f+bxrpcY1undWZAEJmtH5LIkmZ/PNq6kAU5Zfam1B2Y92BqLTaV6b6m29onU7kFzOxfPqfcYQthdsPZa0VRztKYEjHxrMQw2/uNCHPi8NMF5ZUg1aLDsXecWJziBSS0bGsPJ59ctcpcn2/iZs4EFUp+294e/jEe4/LjhTKvfnLAWOcHjufNZS7eNq+AfVV2cq9YiNeyFosjvk67glsqjipGUeHdXN1AgmrtYlUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pn7yuhtjLzYa1zDLRLIshNwTkj6xp5R0LDYkfFYpI0s=;
 b=KtbxUCrQBuQDMQVGrG7uK8Tr6DfFNK0BjOiO7u4isT6+7JWZfFG7VnU7Mk5fHw/T9tW6zMXOkUHQjOPAb+co8xr0M0x7qjdJv4EMQ1xzcflm1XNGd/9r9SQBht4uYQX9Xnu4bNaUUioW/QzaSER+8dlLTS/h5+2lUxrvbXofgjvWEnGMKAoqBNqVlqDKZpg9FnxoXN3KwHeuBwV+HxcHl5JQJSIvTa8CUsPbCkMRvBBhZZN7as6Es3ml7S3y1kUTxGqKGXbfzTBQqcUAoqGMxXUSM4ExoUlUvoJ3NXPeyr2n2dFsJTCf50DwPO8mvvC1qSTskZJWAYBZNUivvpF3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn7yuhtjLzYa1zDLRLIshNwTkj6xp5R0LDYkfFYpI0s=;
 b=IU61qMwGNquCkf3aHLbGjrPR7+Y17a/Zb/Suiw03hAf/YJkAAFh1Cji8HpNoXvf7ZRgjtXEn4odvvDnYlzvrUKymoOpGXQ9Bin5kjGFRmF6PYAFKvActA9nb0Y1tSp4UQAPp4o+JQenjLv/uVMmU27IKkJtyCiYXWl49UC20cjkC9JLR2ER+ZzoaJ6OhX6+QGplL7IIiYe6+EuAQpFGh4sr2sYTq1jVKSK61nnaleNqypMCwn63K9swyusHwxAf3tnkpCC7ayv0HulWZasFR9voaTaJfM00RhLH3s60zrXIDSO4XYhKGXM4h8YvuS1hiG6xkGID+CfMO/BgsMgyBew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com (2603:10a6:206:b::28)
 by DB9PR04MB9817.eurprd04.prod.outlook.com (2603:10a6:10:4f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 17:31:57 +0000
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::f717:71b:d561:3313]) by AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::f717:71b:d561:3313%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 17:31:56 +0000
Message-ID: <cf71648c-eed0-cefb-ddff-1b2f7809dc3b@suse.com>
Date:   Mon, 17 Jul 2023 10:31:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1] scsi: iscsi: use kfree_sensitive() in
 iscsi_session_free()
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>, Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:ISCSI" <open-iscsi@googlegroups.com>,
        "open list:ISCSI" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230717092657.9776-1-duminjie@vivo.com>
From:   Lee Duncan <lduncan@suse.com>
In-Reply-To: <20230717092657.9776-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::16) To AM5PR04MB3089.eurprd04.prod.outlook.com
 (2603:10a6:206:b::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3089:EE_|DB9PR04MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 645d84c7-a058-42ee-76c5-08db86ebb829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMe0jXiUFf9x+WTYbpliGvucbQZFZ1howBK3oX89ZKQT24yZ57wGp6Vmo4XSnC++doPNNImFb1NzDDyjJVN0YKwyZpEdY2psHVJF5/2C44s78QJDQtXNA1ZM7k/CcXnNhVFnpj8YM1fOfxVbCM/WY04+cFPXXlI2946DLCzubuIvDi0aCeWNjYQh3qT0zbJC4qM1m7jbeEXUX9yLHNdCbvlfR5y46U41Q/4NQbEEyrIh57aRIEGoKjS2nZZkiZGWhTMZ1+37HPcWwRCm2ZylMfx0tt937jWQHhXiGxgNsFqoCCiABrl/ioD0DPsn90vdttc7XpDaRExahkxMhvG4IwpTqBAdnhtPkagVy4fgFjvNpG8XRFtqdv1MnjFTx03Dxm71L5mXnu6vzjggV1+mxw6n0SxBMPmoiQtoJRW1ehesN1oca3Y+uJlm5arbO0WTDPMJNFwqwmWe0W3H8/c3H2w2+VXH5AGSBRL3T+a7qeNLQAEdw3hiSKsINebjhJxQnJ8vdlzWjSKQdOufOwQaBP2WMyQn0LB0eAuWiw8q0DrRb34/eediP65cR50b+OPXfbv/50mVvjWdF9onces1qsxt8Uo+VQVCf0JPjgRHKob3Bp/WQk3LfyAxfe5xRCJPP2/qGva7ZzAZ++NqFhO+5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(478600001)(6666004)(6486002)(110136005)(6506007)(53546011)(186003)(36756003)(2616005)(6512007)(316002)(2906002)(4744005)(4326008)(41300700001)(66476007)(66946007)(5660300002)(8676002)(8936002)(26005)(66556008)(38100700002)(86362001)(31696002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODZ2VDdFZ041akFXMnpFMHdvZlE4U1BHZ0Njek5nbXpOZ2FhL01oT0x0M2Fu?=
 =?utf-8?B?aStIZDg3cmhLeVN4WkU2QmEwY3JBU0kyanRIZ21KUmFYeGdpUFBrU0dZeUw5?=
 =?utf-8?B?SGZjanZwa1VkTFRHUmtBcU9uN3V2bU93Y05IdU9Wc3NtcVRkNFlKYnk1eVpO?=
 =?utf-8?B?ajBjYjdsOVZNeHhIbHVDMUh4WVcyeStrbm9YK2hSUEg2MnhvM1YzZU5paE9z?=
 =?utf-8?B?THFhWGJvT3E4Q2MrVXhwckVvVTQxMnpTS1prbEtXdTc5eHpIeit2dmg4RnY4?=
 =?utf-8?B?Mi84S2VBK0JmYW5kcHU2djMwNk95RGNRQmIzeGJ1NDkwOElIYWJ0eFJwWjBh?=
 =?utf-8?B?K2FtaXZ6cit2YUxNTXc4VStCVWFpWkxFazErZFBha2lmUGtrNDNQbDFNb1Fi?=
 =?utf-8?B?VjdYR1dGbEJxZWVVOERxbDFtcFBYSHhUbWQzSUJ2aUlaeFoxY1hoYWJITHU4?=
 =?utf-8?B?akFJd0xVUjBDTGVhQlN4TVRkbDRMdVEySVpFdTQxa214ZVp1WjJ4Ulk4SDFv?=
 =?utf-8?B?VXRkL0M2cXAxc1VvbDVtU1VzWlZFSWhMRURacnJhRUtBZzV1R29ySHE0ZTNX?=
 =?utf-8?B?TnE3dkJhd1JWTGY4ajg3WVE3ekUxWVpiNEFHcTJCc1RISzh6aFRIK2g3SVdB?=
 =?utf-8?B?SGh1aCtQMHZvWkI2b0xLaDE0WFM1N2IyT1BUMURoY3NESFk1QkdmZUVwQWp1?=
 =?utf-8?B?VENhaEF1bFRKbWFWMVNTdHFIQ044NGdIamZ0bVFxYnZvcGROaElkQ0p2bEcv?=
 =?utf-8?B?YnhtN1BUeXV4d3dwQ2QwOVRWNEcxaWhJbEp5ZUIxbW1YMkRLVHBFbURFMmZw?=
 =?utf-8?B?ZEljSy9iTk5pVWl1WWdOTm85SlVRaGE3b09FUCtZV2RIUmViRnpYZE5IQi9Y?=
 =?utf-8?B?UXB0Yy9qUTdtZnVzRXIrd1JGUU1ZVU12aVZkRUlHM2gvcFNVTTlKVEZjSDBB?=
 =?utf-8?B?RDg1ZFdKa1NLNkpaV1JwNnNndHdrWS9jSGdSdmFjaWI0aUNPa2x3NnhlSkZJ?=
 =?utf-8?B?OGI3aEpnQVBtR0NzT3NHTlZiSWl1aGl5alVnaUhpMkNMRDdRNktzbTJCWVc4?=
 =?utf-8?B?LzBFcFZRUmdtZmZXL1hqNXNicm40anoyQk5pT3pVVVFYbXQxVHhpT0gxRE5G?=
 =?utf-8?B?eGoxbmNrR0hJSm82eUk3WHVjaUxJb2pEMGZWR0R3TDJLZDhXdXRGeFd1RXpa?=
 =?utf-8?B?djRtMWZLMUJGa0JYZXN3UHc5d1hBUjlyRVBBU0pFY1hGZ244S21EeXJGa2lv?=
 =?utf-8?B?T0p5WVVZRVJYdWI5Sk81YU90amczTUxHRHpNY0s1MTY2RElDNkZMUE5WL1pG?=
 =?utf-8?B?Vktya1cwb2JBbGEweXF6TDFuL0R4WUdFTVY1YnZUTVJ0VS95YkJ1c2lXbWhY?=
 =?utf-8?B?YjY1Zmh0U29rZ3d6VXg4ZWFmek9odlVoSGdZKzNKR2hERDBnZFdybDJZQzJR?=
 =?utf-8?B?Z09OaEs5L3dXSE5CSjAyWENVZnkvcHdUWHZ3MWtqOHhRaXpiZVc2V3dDREJj?=
 =?utf-8?B?UElHQ0ZZbkJSeXdWbkUvWE9kc2U5L0JqekZIc2dvUGhMbjBHM0dzWjJEbDgy?=
 =?utf-8?B?dm5VdjI5SFV0clA2OG53dFBMUGNnWCswL1lhNEtvTHc5bHlxUTVUTHlONlNT?=
 =?utf-8?B?a293WEp6b2c0ZmFuN0o5Z3dDakZ4U2lWY0tGOFVjeTh0SlVnVVBTbGovcEQr?=
 =?utf-8?B?Syt2THA5cjIzeDd4U0pLcExnL3VPbnVKdFJiR0FvMDdtT3BEdkJuYm5aYXdN?=
 =?utf-8?B?S1hWVXM0aitaTmJobndPVmxMYnF0VmpMZFYxWmxqVzFBaldUa3VuQmFldmR6?=
 =?utf-8?B?UUQ2aWlXWjhmRjBUb1hSbndaMWk4VVI4WS9odWVsWEFOZ3V1KzlVNVV5Zmxh?=
 =?utf-8?B?NnFHMysyaHVMbm16Y0R1Rm1yb1ZwNzlFd0dTSmNsdHJrT0pMWGtyZUcrQmtl?=
 =?utf-8?B?aG0xMmhTR0xaNTZueDVCZUd3a2prOWFqL0R4SUJNSEFKdmpPQml4S0l6WkJH?=
 =?utf-8?B?Wm9hbTVtUk9vMDFNQ3JXaThYbHgvdC9oekhxbzhKUWRvSkcyanhkVGVXWGdm?=
 =?utf-8?B?azdOem13Vll5bmFOQUFOQ2d0ekptbGIxenJ4ZHFxNDNVSC9TQkRkMFMwTlhJ?=
 =?utf-8?Q?AcAEZijTnK+OfSHJfiD75g6ju?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645d84c7-a058-42ee-76c5-08db86ebb829
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 17:31:56.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWA/qGrosL4BP08F3cQWMaOsJMBO+TMs0EhrZ/hrFZ2GFtrUFSomwhNMVs0LvoH5R+uaD56lP9MLDnzrV+0bHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9817
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 02:26, Minjie Du wrote:
> session might contain private part of the password, so better use
> kfree_sensitive() to free it.
> In iscsi_session_free() use kfree_sensitive() to free session->password.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>   drivers/scsi/libiscsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
> index 0fda8905e..2f273229c 100644
> --- a/drivers/scsi/libiscsi.c
> +++ b/drivers/scsi/libiscsi.c
> @@ -3132,7 +3132,7 @@ void iscsi_session_free(struct iscsi_cls_session *cls_session)
>   	struct module *owner = cls_session->transport->owner;
>   
>   	iscsi_pool_free(&session->cmdpool);
> -	kfree(session->password);
> +	kfree_sensitive(session->password);
>   	kfree(session->password_in);
>   	kfree(session->username);
>   	kfree(session->username_in);

Reviewed-by: Lee Duncan <lduncan@suse.com>
