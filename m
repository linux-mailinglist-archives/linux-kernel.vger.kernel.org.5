Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8150475A8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjGTITq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGTITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:19:44 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CDC211F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCoazZU7RM1bZMzigwa8VTVCIZKZrdO1aIopAj+PN/BFXRU9JrpzjVfuua3Jk04Baq+m81PFpN55Ahhezi2i48ingj8/V+xbRB6/A8JWxNcQBHkVC42k7VGO9/ie0nlKKWbzuQraL8XIK1zOdQXQZ7zMa4AEJBA1aFb60/JudJYwkMfR09SwlVYJBg/vN7HLmebwCJ4hH2V3LqwBrszyy/b6VJgo3sKVN7INfTpbGJGiaIprVQaA0sEP9aFU45GpZg/QI3ihhdb5fl6FaG78VwBaqPW6xWK2y+9+RRM2bX9uMrbtXNJvWfOtWWcCGZVzZ5cS81ysBd+bdxG+vsVGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qh/+af0hOpGVpriCPmLnk02ftaf7neHPnlzAqQTvFgg=;
 b=H3JMqTebD4LQFBRb0fH3YPb76RcTRNlNq5oKOSi6i0j9M/4lOG6or2kOy34dm4DyXGdbJgp0ihroNkFk6tSRa8ZKUcE+qE+itO6CuwJdwgo9j3CkmGGDyAK4mbOTTQwMh+3K0T/pMnddf+a4S4UmwGHRYf8KemNOBVQLoVyNhi/Qw5FYGM8M8dN/yl14gseKR66gVk27G1mr/ZEqBWoDJfUz+Y9T32Vw8n+t8jLRMsQVItyzWhPheO6vlAX5dp8NQ9l++QAKfNBWP3HEacS2xfKyaO3E0reCGhhsmQW9jb6rdLKVitzv+/mqmgnBdey7uHQOdE+QiXCVVrzKS4qn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh/+af0hOpGVpriCPmLnk02ftaf7neHPnlzAqQTvFgg=;
 b=N1JTReHhXax7lMesAVkUHUpHNYGN4Bik1iQ0r+vk5GkOmKrtJA6ijSOqTkVXjArQG722+Aj5/Bi7aOsCHLCsyb7pb6gn8IH+/YPyIbBTufyU96snJOYfdZJVIfCI+VHFJ6uKybk7pBE0mN4Fbl8BZ6JRlStGSn3APtanbguQuMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB10060.eurprd04.prod.outlook.com (2603:10a6:20b:676::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 08:19:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 08:19:39 +0000
Message-ID: <4464836f-dc7a-371c-1bbe-99110257d69d@oss.nxp.com>
Date:   Thu, 20 Jul 2023 16:19:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/7] firmware: imx: scu-pd: misc update
To:     Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Frank.Li@nxp.com, aisheng.dong@nxp.com,
        marcel.ziswiler@toradex.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20230714090936.937344-1-peng.fan@oss.nxp.com>
 <20230719070022.GH151430@dragon>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230719070022.GH151430@dragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS5PR04MB10060:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a54cc1-c2b2-4e47-3ae5-08db88fa0fd6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6S/zJfkH9LNYu4MzzwUYM5E67me51YGapYFOzab47pmZQGZXC0qcoiXA8gEQ0xDJTZn2gpMmWEzS/zHQnrmdKxEqkovr1hDwsH8pleb1GGCvavt8pSImYt9Uhl9dsRC9aC/mcmrwDVSLUJTh6G/rTVmVlQOuRw4xF3xCJnK8wc5dRIfGIsRZM/ffSBcabqIwkznSBmcl3jgFI2+G2DDNjDbeYBEZ8DMK8y2dnBbT22tAEjHysh4eU7CSfY8NYt8ZU2Wltun+0R/FRlsWC3sqkX99DiBBjX535xh83PkGEbTbEVXWwUp61VRmeCDGLZdGHemj08A+Hb0RyEy+Z4hcr4vZRUHlpC6zijBdiwpZHn2UKvXfF6VcweS2XYHVAKDT9gAMw+parH5nCeCdKEqDUVb9ugftVTInrf3cKpTwHRfmO7Kt0kwXSHFDWQ6DDxoY53+/dKnYgRyYELdXrNpLEVn7GT2Ul8v/bHvgGhBcoPvuWedGwFnOtV28Symy7LK89/y+EbG5RHnmRhcXmILP++a8UkzfS8hIngvbYx8WrCGg6yqXK14BAfpPymCq775nl9pOdgtfI1eXXOPgEpmWYnszv7MLvK+q7YFDd/wdZVrwwYt5ctRnvC7HMtzm/lNAk7nmxc43rbwAJPjD0JkSWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199021)(86362001)(110136005)(478600001)(66476007)(66556008)(66946007)(4326008)(53546011)(6506007)(26005)(6486002)(6666004)(6512007)(966005)(2906002)(15650500001)(41300700001)(8936002)(8676002)(316002)(44832011)(5660300002)(38100700002)(31696002)(2616005)(186003)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWpPK1ljcFFpeG4rNHIySmR6VHJ1bCtPR0xlYWExYmQveDdqZW1vYVRZSzgx?=
 =?utf-8?B?RDJQQW1WTE9CcHgwSUlQODdONkdLaWVLS0U4RTVpR1NvSUY1d1FKRlZHSEF3?=
 =?utf-8?B?R3EwWk9nWVAvZTJjeVN2SExXMTMwQ1pLQ1BWdW5Db0lDaTBiTXJrNWRnOVZk?=
 =?utf-8?B?WGpHVU0yMGpIZXZ0ckpzaFJhWWJna01lU1ZMNUh3dlRiSjZlWHdMSmNtQlJ1?=
 =?utf-8?B?TWs5aTJxbTVkZEVwMXdodllVeEJJUmFuRmNrZnZWMmRjTmxtcW9Qem5xRWR5?=
 =?utf-8?B?QWM1ZHhXb1ZnQjVMeWQvbjNTZ0NQZm5LODVOUE9oNlRScXU3b21GRWlEMndo?=
 =?utf-8?B?ekdPK0JJTWE4cWtodktXTVRIYUF0UUZ3ZzJmQXhxazBabEdoaUxUd0Q1QUU4?=
 =?utf-8?B?bjZQMWRyamRrK05NRVF6aGUvY3VTU1JRbEtuWjRNUDNnaGQ3NXFTd09TeGpF?=
 =?utf-8?B?STVKWlFIM0VEekFFSmZmdVFHeWtDNDdCY2J1OEd1RDRGeFJBbWErZjJyaTk0?=
 =?utf-8?B?WE9UK2U4QWY3YWpmWVpmR21mRXcwMEFTT1FBa2I0cEl6UlhKSjU4NzNROXdH?=
 =?utf-8?B?OXBZZXptdC81WVFiM2FvbTVUbG9oekRpTFhXdWw3czNVMCtZTlhWR2dWS3ZS?=
 =?utf-8?B?L3lFcmJ5UmFjK2hiSUIvRUUvdVlGVjJma1dxVGJ3L0Q3MlREaFh1d2RzVFQ4?=
 =?utf-8?B?eWsrSTZuR0dYQzg4OHl6UFpOMzRyMU81WjhPbVh5SW1tSVJ1eUttbitUaGVn?=
 =?utf-8?B?UGZnNU53RCt5S0JXSFhURVh1Wng5ZmZtM2ZZdzhqMTdzbTI5bUhGRmtOb05p?=
 =?utf-8?B?S0EwZjQrcHpxekF4SEw5MjMySEFyTHpiaFpLQTRNb0ZocDRBNTVtUnlmM0FU?=
 =?utf-8?B?YkdPMUxnZ1JkYVZiWmFLK0htSjBabTFDZWlzNGQ1RytITkp6N2hVdXQ5OHFa?=
 =?utf-8?B?dVZtcHB5OHN2bENlMjZ4bUFMNGYrRVE4OVBEejRQOHNTYlo4dU5yRm8wSHo3?=
 =?utf-8?B?dTZ2aCszRXFtTmI1WHREa0tvZWVVN1dTQTFSSS9zM0VINGV3UU9RcjdMUXJy?=
 =?utf-8?B?Z01IVmJNTC91SUhCWVV0dUdIaWlaaUgyT2lrWUlZSnVGUFhOOEpwWStpVitV?=
 =?utf-8?B?Njl3Mmp1amNYbkc3d1hIU3pGZFNPN1RwK0t4ci9nZXBRYUxneldxV0ttSUFt?=
 =?utf-8?B?RmpLVFpyWWdpTUJkNmpxS1ZtYnYyTjJvaXRTY0I4L0VUMGs2WmtmdnNOSVkr?=
 =?utf-8?B?aVJISFpWMU5sdTA3MHZzbXU5WVpaSTNJTnJPNm84UFpraDRwMmI3S0RWVG1h?=
 =?utf-8?B?bEdWRE5QMHdFcnZtakVERjFFSmVBSmpCV3lHRFFwd0NLc1p2dEUvekFmUEJT?=
 =?utf-8?B?VnQ2WEpoQXg0OGdEM0JvMUhSRi84dFYwUXNEZTFKdmF3Z0UzcUVSdFNRTzhJ?=
 =?utf-8?B?dEVCenVmeHNpSEFKSmswQnRnaVVsRXN6Ym1pcm1ZZThBTkJVdUcrN25lL3RR?=
 =?utf-8?B?ZDZySWVJb21IVGNncWRiNlJBN1pvc2w3WDJ0cjJ3REZ2OFFSMy9JbldoZjB0?=
 =?utf-8?B?TGJLVDB2YTFPTmtOWVpDZ1JEYzVRLzhNTXFkR05zUFZRckhvUEE1RytvVHVR?=
 =?utf-8?B?ZlRDSE1POTczME1Wdk9EM1FCeWgra0k5bjZlT0o0aG5CWStSN1dyM2RsMGgx?=
 =?utf-8?B?V3dGZU4xSHNiVVB0NmpRYmhzMUo2YXBJTHg0QnVUWUhNNWcxeTBNY003dWhJ?=
 =?utf-8?B?V1NxYndxQ29UUmVvTU41OXFsajBLTGdtWldoYUw0ZWZHc1pWZHk1V3VUYnpW?=
 =?utf-8?B?QVVBanZKOFhEdlFyU215eUdldDRFS2ozVG1Wb1cyZzJ3eS92ckVBdWZydnNZ?=
 =?utf-8?B?L25CMUtWencvNjkxUkxZbVBRQmszc1RpV2Fub3hBVm1jZmNyajB4RVdvUkVR?=
 =?utf-8?B?YjRyWThmL2VuOXgxSE5HRmxUMFhaUzBHYXRNeHhvdmJlRm0rQTdBNFc3TzZB?=
 =?utf-8?B?bHBqWUFvdzRENlBJK1BmVEZTanEycTB2YkpZQmo2eGhXSkxSQkFrRm9kWHdz?=
 =?utf-8?B?clZGbkFzNTQrc3pXbGtjdWJSSFQwZFZ2Tm1udlhPRVBTclN5eDljRnZ0ZWI4?=
 =?utf-8?Q?338WrXLYMPg+Wq659k9npnbjl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a54cc1-c2b2-4e47-3ae5-08db88fa0fd6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 08:19:39.5978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU1hp/0TZof9DWMDpna1t/JtpjOSsxKOFkCApxtsOU4ZfKOmAbZfdhgUfcJlWJ8pCvBGePfzErX1+Z30ZSX5aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/2023 3:00 PM, Shawn Guo wrote:
> 
> +Ulf
> 
> On Fri, Jul 14, 2023 at 05:09:29PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> This patchset is to upstream NXP downstream scu-pd driver patches.
>> patch 1,2 is to support more PDs
>> patch 3 is to not power off console when no console suspend
>> patch 4 is to suppress bind
>> patch 5 is to make genpd align with HW state
>> patch 6 is to support LP mode in runtime suspend, OFF mode in system suspend.
>> patch 7 is to change init level to avoid uneccessary defer probe
>>
>> Dong Aisheng (2):
>>    firmware: imx: scu-pd: do not power off console if no_console_suspend
>>    firmware: imx: scu-pd: change init level to subsys_initcall
>>
>> Peng Fan (5):
>>    firmware: imx: scu-pd: enlarge PD range
>>    firmware: imx: scu-pd: add more PDs
>>    firmware: imx: scu-pd: Suppress bind attrs
>>    firmware: imx: scu-pd: initialize is_off according to HW state
>>    firmware: imx: scu-pd: add multi states support
>>
>>   drivers/firmware/imx/scu-pd.c | 193 ++++++++++++++++++++++++++++++++--
>>   1 file changed, 182 insertions(+), 11 deletions(-)
> 
> We have genpd subsystem [1] coming.  Should we consider to move this
> scu-pd driver there too?

ok, I could move scu-pd driver to genpd.

Regards,
Peng.

> 
> Shawn
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20230714092301.28690-1-ulf.hansson@linaro.org/T/
