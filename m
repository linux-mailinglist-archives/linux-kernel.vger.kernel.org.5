Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C413F80AC8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjLHS6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHS6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:58:53 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C08F11F;
        Fri,  8 Dec 2023 10:58:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUTHGyDWZAHBfigRi9Blv72unEypgJfsbIjFLGzwX5D9GY8P2oWI5m6L1HAyU05osvVhxQkoczXxvb2JGwo3SQsTDHambezRtPLhAjp4Tr8Y/9pU8sWLiS4dJAId5rpCT/iooq6Z0jsTAI3bkhd5H1ZcK0PXlV4ZCeNcl14tIf1MiPqITPB7TK28pW3uEQwz/f9lDP0uqIXI8aLHslml4aUFx31cx6PB+wbLFex1FmUmdm39Yv1K7fEnaD6bX6E2rswokMI9eCNcTJ6JfISGhqXuZfALUtiLP4j6haEHCJMIewA81sy03p0nbg6rUhxWW8SlMge2nsoi08sk2VmrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ8jobPVJU6CaJcwzT3M1NPnIh0/Cahtdr1H3dOFEpM=;
 b=D6xB+v0pt/mLoKpp336tSBx6aKbHcpQnqgONYQuVNSSx21JjatsVENJd1iB5wBXyEUgOlVzpWbYSmn2H8VBQgDQmcj9dD8u4ZVvkr7lFIecb/U3QTaqMCsnOnVAr/+yugzph7CKdbfrHeNYZa8WeDZTBLzfYs8zmDiBCnNFhu1ZeeymXNLXpoH4A8UPJFTih9T6CV1SwrLCSAuME5v7wdZLI/8/K/8ITsIzfvnJiSxLj4+GY2nE1InthSWKo7GXym2hEhOERUgVGP5TFPDRQ7RC0kGZVYWStCPuFOgXUBUDHXDkkpcGSUXqU9u4zhPf7PW7dqtycAi3SxgR3JrfJRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ8jobPVJU6CaJcwzT3M1NPnIh0/Cahtdr1H3dOFEpM=;
 b=Jul6muvcO6pPKwHHohBk5J1nIvOZS9E+HRHdxqdN6rAc3HYTVG2PVsWUivXZ0ZD8B2+1vopaHU4+nrLc3LX6xYtOPceem9PSinhPCkDCEP/HrHTM+FbepO8nFjgVOnK0dLD2YjDfkrxT/HpafTO+Z0v/5x3siN5UtC06l8VJSNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PA4PR08MB6160.eurprd08.prod.outlook.com (2603:10a6:102:e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 18:58:56 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7068.029; Fri, 8 Dec 2023
 18:58:55 +0000
Message-ID: <196acb44-fb0d-45b6-a9c3-b5a289a41917@wolfvision.net>
Date:   Fri, 8 Dec 2023 19:58:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] usb: typec: tipd: add function to request firmware
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net>
 <20231207-tps6598x_update-v1-2-dc21b5301d91@wolfvision.net>
 <ZXMudF++A9/y4TNk@kuha.fi.intel.com>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZXMudF++A9/y4TNk@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::12) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PA4PR08MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c833b9-6182-4699-727c-08dbf81fb9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKOQMYzKPrgWJZBNYkBy6CJZdF2A7X4iE8stw/LddQZGxzjiEReu4n9M0UA74cNN1gR+2za450jUpJMOJHzSm4/2UveUowAom14HUtkQksyrkqcMjNcRUPpNDByFBcUs1eVrMwGrXMaEtk9mTqlsvo8sPJL6bw0VICBEs8uXv7EgXjKJMA16YrPtAjNvwPE1XYg7rJB1+eWEyXDz9PyV/jIB8w0XV2OQ4fmyvxySt7UT1aY6OeQrm40Zu8V6IIB3JEI7dKZKyLAq1GX1omR9S+O55GIlMh4SFaO3OYMjF8xC5XmxMZ90Q01oTNorcanY7KIECjFq+ZHkjxf5tIhBrG6jyS9FAIdPcFUGjQGG/xtYOzjxVhp4nTHrE+a9JlWml7BuDZ5UQ8RkKLiemkVc67Nu4U1OlPpyiUo0NH31G4ilcdriiBvV6CKqYLLGUuLCi680USf1DoSqHuO9fZ3i3OLO+aI87kv9Aj0T+/0cJgTZyPTAvosA5NYFdHO8AVyV9E6j8j4wVZcYZSZSmVv/QBWP1ImdUZYUOHRFIjwGE/fKTby5H4KXKKSLC+djqw6AqCfq/C6ijmvoq4a0zRF79GbGT306TfkojW4UzI+2rtX8ydSnel+B6kVuyvj9YdeD6dSl56TNjaE0BxAnxVMCSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(41300700001)(2906002)(38100700002)(86362001)(66946007)(6666004)(6512007)(478600001)(2616005)(66476007)(31696002)(8936002)(6506007)(53546011)(83380400001)(6486002)(44832011)(66556008)(8676002)(316002)(4326008)(36756003)(6916009)(66899024)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skg0dlNvV3Z0bXVuWmNnbUQ1ZXBER0RBK3BWQkNFVmdWSk9adEJ5UTB6MjlB?=
 =?utf-8?B?WTFlQkMrb0VWbnVqRFVHS3BBTVhUbG9Tc3F2TEFscnJ1ZHlCUWZQL0R4cUMr?=
 =?utf-8?B?MmtEMDBUY2NVeW1PdFluWEFjUnorU2pudzBURzk0YUxjWUxKQS9mRWg4STZN?=
 =?utf-8?B?U01jL253VHFJMEJ4OFd3eWtRby8xYUNVNHd1dkRtdzNWYy9XT3V6NDFubXJm?=
 =?utf-8?B?eEFGSmJwWlZFSlJMSVYwK1pqNXdKYzZKcS9jOWMyOERWR2wrdm8vRXN0UDNK?=
 =?utf-8?B?YW1zU3RNZ1ZOZHhjZmxwWkxOOUE3VWs5U3NVKzgzM2JsN0pzTzduQTBtZUNY?=
 =?utf-8?B?Zkg1cXB5dVlCTVM4RXdaODRLaEMzTHA5NnhadmRseTl4N0NOWjdYVmlKMy9X?=
 =?utf-8?B?SFFuOG1YTE9hbDQrUkdRQlFGcWpPclg5M1plNncwdC9oV09vdVVvbk5aWEI4?=
 =?utf-8?B?YWZsVmI5WU5kWGo5Z1I3WjdZRHU4b21OOFBaTUp5L3ZuN2VCYTZFRTd2aDBm?=
 =?utf-8?B?dmR6U0NOTGl4eVFUWlZsMGhaUVA1ZXNCMUNUeGs5NmNuQ0t3YVRhYys5U0xa?=
 =?utf-8?B?RTN4a0tWVGVRQlVXWGJzVW05ZEhnQlhQS0k1LzMwUFcxUmx3azRMekYzWGJK?=
 =?utf-8?B?WGFWMmR5L0prWE4xWDJWVTJzdDdnR2NWUkMyeEU3QVNyejRYMHREVjJEcFIv?=
 =?utf-8?B?UjNPOXY1cDUzY29KTC9CT3JjSUtwbVBNOWdLQ29qYkNJeDRlUkUrQWU1TVk0?=
 =?utf-8?B?Mm9oTFBvaTFKc09WZWtlQXliN2hDcXVkeVdzZFZvRFJNMW43bnNZU3Zsejd2?=
 =?utf-8?B?QjJuOXpmZnQvdkxRNEk2ZzB5SzV4eldoK2hlRGJiQzErRlVrc3YvRlhPTUJ2?=
 =?utf-8?B?cmlnRER1R0gyUFRJTjE3bmVDelBTYVE2Y2xwTHlvWkZmTDM1UW9uVTRycmRJ?=
 =?utf-8?B?MXRBQlhZVzZ4Y0RZQ0ZjUkpSWTNVUDQxMHFJVmR1elk2OUt6aFRHK1A2MHo2?=
 =?utf-8?B?YWlFZEpaamFJS1RXdW53UDBxRkdqNlFqb1hhczdDV21icWZ5RVRscVNOcnNr?=
 =?utf-8?B?bzd3SEJoMW5YTWhvbUtyRFF3T2YyK1h3WXFXb0NqOTJyQ0QyU1R4VmtBemo0?=
 =?utf-8?B?OGZWZ0hadTQxdHRRZGk3K0lDaTBGZjhIcHhnR2x2Z2d1ck92djl2UlBTcDlI?=
 =?utf-8?B?U2Nta1luSXF4UTBCMXhZaDVEdUNKeTFaQTdRN0VnRkJFT0tQZW5qeWhabVE4?=
 =?utf-8?B?aUd6RWszUkJBT3Y5NU9yU2xxSWpEU1pqZmpZNXpTS3pYZmYxTnlJTWpHeHpO?=
 =?utf-8?B?Um1kWVY0eHlKWWg0Y2lWSCtrMUV3SElSRS96eHFEMnN0SDJmU0ZPOGJZWEpr?=
 =?utf-8?B?Y21NUVNYNGZlL0dOMnFLeVJ0a2oyMmNVSVdDWGdIb1BTeWJQbFdiMkdIbmdo?=
 =?utf-8?B?cU9XUHo3aHdlSkl2a2xIUDE5dzRPS2pvSmU0V1pTSVZaS0ZvVEo0R1A0TUp6?=
 =?utf-8?B?NUhDdVhXUk1qYnVUdmw4MUoyNWQ5MVl2MTdEZFZyMkdONHpYOE5IU3lKdlZk?=
 =?utf-8?B?S2dndzhDRnBZajkwU3h0YkNKMEU5LzNBSHhWdDdkcjJydXBycUIxdGNPbDFa?=
 =?utf-8?B?S1ZJaVYzK3grOEF6ejVXYjdDcE53bGZuWmd2LzJYODRXWU1tTkltb3JHSVlL?=
 =?utf-8?B?Y0pzeGFoT1NPL1dnTTdTWVd0bW9XcUlNbUdpWU5sVzgveUFMR1JvK1NUNEtW?=
 =?utf-8?B?TDlWZXQwek5ISmtlbEpLQ1NUQWowRjVvOGJxL0xuaUZCSW5ZSmd5TGd0SEdN?=
 =?utf-8?B?bnFuN3FzcWVVUG5KUGJyZVVpVzEvRXNpSjUxUEwrZkRiYVRkcm9EOVcybXpQ?=
 =?utf-8?B?Mkc2alpPUDlGRG1Ub2dKNkxjU1BWVWlxc3hWSjlEeDNGeUlVdjRaWW1lSG51?=
 =?utf-8?B?RTlWMDBLVEg2UnI1a0VBWGhNbmpxdGdBTUptcFk2bEc0NFA3NFdZV2FUSDNk?=
 =?utf-8?B?YTNSaTlYS2VYajhWUVI0YTNkcVdTTkM2dGxEaVdJVHl4YmdQUm9ITEhJM3Fa?=
 =?utf-8?B?OFE4cDZOcTlJSllkRzQ5R3hqQ1Vuc0hlZlJocGQ2WUhpVnlQV0ljK1ZlR1Na?=
 =?utf-8?B?aitCdlFUc2V1d3pYdERnRm9ldDM2ZC9CdFVSY1dEYVU4MUZLNHUrSXhJOTRX?=
 =?utf-8?B?aTBDQ1JBL2NiMmsxMEtEQ29nMzAreitENGVEQnJEZ1lSNGtWRzE1VWM4YTNY?=
 =?utf-8?Q?q1wEtOVBAeDMaQp0MiDfDA6r/mCNRvX6n+JeDY41rc=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c833b9-6182-4699-727c-08dbf81fb9b5
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 18:58:55.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4XtbKa0c6iVI2vlDbU0yKA4W6DHrbxG7fcnX2AKlfx5DzUEPeydh3yiSqAmS6KuxwTavNEwV7JrW3dIvRWlrKGk5vXk0XPxq2pFuZbP2p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On 08.12.23 15:55, Heikki Krogerus wrote:

>> +	ret = request_firmware(fw, firmware_name, tps->dev);
>> +	if (ret) {
>> +		dev_err(tps->dev, "failed to retrieve \"%s\"\n", firmware_name);
>> +		/* probe deferring in case the file system is not ready */
>> +		return (ret == -ENOENT) ? -EPROBE_DEFER : ret;
> 
> It's more likely that the firmware really isn't available, and it will
> never be available in this case. I think there is only one place in
> kernel where failing request_firmware() can lead to deferred probe
> (drivers/tee/optee/smc_abi.c) and there the code can actually see the
> system state - that's actually the condition.
> 
> So just return dev_err_probe() here:
> 
> 	ret = request_firmware(fw, firmware_name, tps->dev);
> 	if (ret)
>                 return dev_err_probe(tps->dev, ret, "failed to retrieve \"%s\"", firmware_name);
> 
Thank you for your feedback.

This solution arose from a real use case: in the system I am using to
test the tps65987d, the filesystem is not ready when the probe function
is called. If I just return on -ENOENT, the device will never get the
update.

Note that we are only triggering the update if the device is in patch
mode, so a firmware will be expected for the device to run and reach the
app mode.
In that case deferring the probe and keeping on trying to make the
update makes sense because otherwise the device will not be able to
offer its functionality. If the device is not in patch mode, no update
will be triggered and the firmware will not be requested, so there will
not be any unnecessary probe deferring.

I see that the driver you mentioned checks if the system_state is still
not SYSTEM_RUNNING to defer the probe.
I have not tested if something like that would be possible in this case,
but giving up on the first attempt if the firmware is not found makes
the assumption that the filesystem where the fw resides will always be
ready when the probe function is called, which in my particular case is
a wrong assumption.

If the firmware was updated at any point during normal operation, the
assumption would be definitely right, but maybe not while booting.

Thank you and best regards,
Javier Carrasco
