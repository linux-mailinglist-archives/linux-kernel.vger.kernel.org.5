Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011CD7BFA73
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjJJL5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjJJL45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:56:57 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B0D94;
        Tue, 10 Oct 2023 04:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqcCxxeRIPE/umL86w+cy2zgbS53ICF1DV92aV2L7XTfLWQe2vbGjm3SxfH6fVGaC/C+yOud6M36esFZkqrEZTrEMrwzowhIJHbp8mC39Qqe02sVMsyvM/d8tUHp3TAai6RDAs03WoDSDcr+tVYaiC/E48j3dqDjDSeXx+y71Jeqdem0/TdBfic61e2ogj69ONahWeyCofFQMYInX2HIDNGdA21YjJlQDn9T/sLmY5+ipEbWU/TMJ641KF/6u2vHqOHA9p8L6LmnMrg3FC6rgtWV4oomptv0FFTjoadtd9Qwi/vKl8Gn4bGjhbF/X7jrzKBo5KTvlWBCDZAfUccBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpPzFjqYkw4TlpQ4SwUuQ90dD1Pw+kj0Ts2ll7uaj3s=;
 b=D7ihmYYONtjI+xeVCsS1EtYRWkfDF13iew0sTOLA2r4Tah+0h8/UxE7Xwg488t6/ChF6SoLRot5fcVnmY5OsffoaCq2YDWVWN5jt5CbLVQa33wnrfXDlxLrPw+pQKTnU5ZS5flWnSb4kFAUXrJaGPl8yUN/amqYdWEaE3sxRqyspJ9EbX3Xg3rzWTjDNM6Ma/cRUzzQThTmBk0ZaqesFEQkJ8F/p/veU2k6NHT7E4RUMZULmFKQeUpo3lDCofRMhoTi8PpGm0oEc1ChJUOUZqjqnILskCf/YiLwPFLRokJBZ8Zvk5AhuTb3EltLNJCYFBjVuA6FdyYaIgpE3jjLV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpPzFjqYkw4TlpQ4SwUuQ90dD1Pw+kj0Ts2ll7uaj3s=;
 b=XNVliSxa7RN7DlCg4Txq4jvKd0C26eZ2ztziynxkhaM2+PJ1nYBg8rXtf3UMXKriVoGcGciAgR0VUSU6FwqV2ZH89pWpHBeU9BXiuQ6hHds6ETDI7dPiFmTJdI7xlKDiHRPUI48oRxvI1/h5XCDAMkCwGMZDc8TnrzCcNyRSkOs/woJ2d9ddUmo1N1JJ5KAeWaenNt2ldsvM9gw7hStDmlj9CbsJSgGamX2gYAGq2crZt0AOVkSUK8LPf0slNPPWE3jlHRIht/Se0O02U97uD5ZauSnBPLcAS6DgGwRYrGHkgL3aLAv14BltP57OGltUQ7BwPKp2RfCalb3aD2dtFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SI2PR03MB5943.apcprd03.prod.outlook.com (2603:1096:4:147::8) by
 PUZPR03MB6965.apcprd03.prod.outlook.com (2603:1096:301:fa::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 11:56:08 +0000
Received: from SI2PR03MB5943.apcprd03.prod.outlook.com
 ([fe80::c088:78e7:87ab:dd1d]) by SI2PR03MB5943.apcprd03.prod.outlook.com
 ([fe80::c088:78e7:87ab:dd1d%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 11:56:07 +0000
Message-ID: <d4f3e1fb-e419-4bdf-8fa9-47e60f596a85@amlogic.com>
Date:   Tue, 10 Oct 2023 19:55:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: meson-gx: Remove setting of CMD_CFG_ERROR
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20230927072544.764285-1-Rong.Chen@amlogic.com>
 <202309271651027503622@amlogic.com>
 <1jil7wkl39.fsf@starbuckisacylon.baylibre.com>
From:   Rong Chen <Rong.Chen@amlogic.com>
In-Reply-To: <1jil7wkl39.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0191.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::16) To SI2PR03MB5943.apcprd03.prod.outlook.com
 (2603:1096:4:147::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR03MB5943:EE_|PUZPR03MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6aa105-fa08-4a39-4adc-08dbc987e2b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbxpel9tDGJntKRUuvEP02hj3DiD1F6LCs5O/OCbqW9e8qKET7ea9rIcMrDdq/vjlzRshKh8lN4we0nQObTgtSwXJMr6nAVoxFmkvUIu45+azahmxGTrY69Ah2qPs0QgFW5O3Yo519BY+Rju5QB7Z9IWGqvFvExbI4a64S28uukiOiKnyTcG1XsxJvTylb8KaxOaTL5Lkmw8XtSt8kEwmENZn+16eq7e4J8uEo8FH/1NagJoCyHkiu6ayO1Ce1Hnkps+zgppRg/PUUP1Tks/iBuppcbB57FfzQ5n9FcbZrmjFZUurtM77GTwleFft0g9c+mEELBFQrMx2St7fVyb2u3coIBSGs6vfKStzT6j2f1/fGUzqN2KpuCkI98V2TbAt8DPC339fNBKsupy4mSSbkJvUoFkSp0oKXSTgyADm2Ey9ZyieryKiEJFytjLZqRLqYvUFgSeNDVUkTc0tJxGvs6syN+FX12A3X3nIgMr58o5pCjXQvBKUpQurx2O0eH3sPgki04Sn/GLz2qmTNHkl3RMnf5VjcyMkExIP5oGeqFmRKlK0sS3ZqGU2jXxo1QhDxW1EfMn4Ts15x+ihiHtRoCHD8Iu5rSdqljSFT3anGKTzhnQfZ9Rwn9EYA+yowvPTw5H1JUGDO7nDWa9OschiO2HVOoQCgEWGoJnWl7+okab2ZoSvpNyaeSsyv7IBj7+67kIgpMwiKTbYK8X155GB0GuzITAI8sXc681XzTcfLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5943.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(396003)(346002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6486002)(83380400001)(478600001)(6666004)(52116002)(53546011)(6506007)(6512007)(966005)(26005)(2616005)(31696002)(66476007)(54906003)(66556008)(8676002)(41300700001)(316002)(66946007)(8936002)(4326008)(110136005)(38100700002)(38350700002)(31686004)(86362001)(5660300002)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDZXeHoya2tkd1JVeitPWGZrZTNZR3NKVmdOUjBDbDcyY2pQU1B6VWV4U1Jp?=
 =?utf-8?B?SVJOOWpIb1B0VTNlZkgyNWowbEtuNDM0NFM3M0lUOXNpZ1FqWkVYTnRyQWVk?=
 =?utf-8?B?MkxRQ3pGSThhcVdVSEdQQ25kWXZYenVEM0hEVGVzN1hlVnZjeVIvbm40Q0hp?=
 =?utf-8?B?MHdpZ2wyQTNPUGtPRzdmeVYwLzVja1FUaFdPemVZQlFpT2hFdnhBUnJ4YXJK?=
 =?utf-8?B?RjM0a2VwREZSdk5veE94ZllDdy9FVFRwblJmVHkxRXZac09ZZFkvdktxQ01R?=
 =?utf-8?B?LzBMRFNXM0ZkNUd1Vm1aQVR3ZHRSQmtpMktMVTRlNGMxWDhJWEtPN212Wi9u?=
 =?utf-8?B?ZFQ0b0JTZ2dXTFo0ZGE1Ky9ZZUZvWDhYaldGOEROS1Z6WFphdGN5NGkyay9I?=
 =?utf-8?B?dnpUOUdHaThPam1RNlI1cTJHczMzeVo5Y3dzWVEvakhsekFROTJnT3Eyckc0?=
 =?utf-8?B?eUxzc2NXQ083K0Fsd2JxRTJtQkpqUUZJWDJIMjFxWWtvaDJQV3U4Wjh3Ymd6?=
 =?utf-8?B?ZjFqWC9KUUFPeHZwcXVkQ0JSSEE0b0d5dVUwUTlQcGJXTG1KZWtMSTBMR3ha?=
 =?utf-8?B?QVhMVGlaWWpiWGIzanE0MS9pQWxNL0I4ekx0ZWIzRjhNK2tYeWZUN0ZjRk43?=
 =?utf-8?B?SmpvYjJIVzV5NTEra2JwV1Vvb3l5NUFqeDZ5MEFhSVBkMXg0RVYxc2dvaWh2?=
 =?utf-8?B?VURPWnlWeWJHTTBKRS8rdzYyRXlIM0ZyMUpHMUdxYVdPSmhZKy9ORjdzMndJ?=
 =?utf-8?B?RU9MUG9aUW5FYWNOc0p6ZzJ0UDYyUzVteVQ5dzR1ZGpUbUt3VXJ1SkxVekg2?=
 =?utf-8?B?SXNjUTVKczZObXhMcGxvV3FGamEzMzlZR0tJSEl6ZXFva1h4bGhDNTgxL0hz?=
 =?utf-8?B?ZTcrQ3Ivd0djbXJ6UFZycXMzVjB2QUsySklqejU4NUE2dmhvY1paM1JHMWlB?=
 =?utf-8?B?ejdpTVFSaW83dDBzNGttdG0yUjBzclFyb3dOcFJnR3hwNE15SmFKQUIzVG5u?=
 =?utf-8?B?WHZOaThoRWtUdzFSSmtwSmxpTTZTako5Z0V1b0orSldDcjdYQzZEcVRqTUNN?=
 =?utf-8?B?TWNvK1FLNUhFZkVDaFNqWUxaci9oQmdsT2dMNTc5cnFJbnVIVUpTbGFWUkdH?=
 =?utf-8?B?M2xmTGFsYjVTRXdsMmFDaldMbGpYNUJXcngxNU90cFBWSThWUVovY2xZWW8z?=
 =?utf-8?B?ZHVpV0dZWUx0YmxaV1F3NmI0aXFyQkFsRE9FQTVEdklMTHRpcGZ1bkhjdjMz?=
 =?utf-8?B?T3VFU1lrQUt4dFd4ZnRzRzJOdkZ0dllHREVacWc5d1dFNlZXNGM0ckgxZ28x?=
 =?utf-8?B?djlnSmFjTDQxTnNoWmNLcWI1VmIvejZZZmwvWEhiNVhmV3BUaVN3bzZzamVS?=
 =?utf-8?B?QlFRUUdMRU0xOWNTMFRYdEV3cnJvU2E3eDlRaThwTVRxNDlwTzJGYmdmcEx6?=
 =?utf-8?B?Y0tMVER5UDVyazV6V3I5TS9XV0tSOThNZlV4c1Z5WmI2STJmUGprSElZVENJ?=
 =?utf-8?B?TXNkM3FkcTlNNHM2OTJtKy9xNjQ5ZExHazhqNDdheGx3RUVNMENCUkUwOW1Z?=
 =?utf-8?B?MXVaa3FZWnhjWTN2bzFnbllYblNrYlBtb0ZaMEttTUtaeGYrYVZodFNtNlZC?=
 =?utf-8?B?RWlaTW9wSFgzSGhYeFZYdWlCMjlyVlBCSFpndGh4R2Y5Y0R3cTRRaFBKUU5u?=
 =?utf-8?B?SkZMNEh4WnFIc1NHYVJZc2lzOTBRdjJmczRyRzRQWG1JMEZJa29HYyt2cWh1?=
 =?utf-8?B?WGhKcWNOTnd3SjlDMk5YMHNpVnViNlBBS1N0c2NXS25mcDBWVUpWQ0JwcGxp?=
 =?utf-8?B?emVCQ1JjZmZHR1F6aFBJUnFFSVRLeWQwbWEzMjdSbUVuU2d6WnFOMHBJeDE1?=
 =?utf-8?B?bUJHUTBYWmlicE0waGNkcHh3bnlCOFFzL1dPcVZEY1M2WnV2YTYzUWxIdUF2?=
 =?utf-8?B?bnN0L2pSc2J3YTc1dDBHcmFZTkhGWlc4SVpxbVdCQnBrbWQ0ZVllTmp3anRu?=
 =?utf-8?B?VmRTVXlUNTdrNEJjd0hxMkNUMnZOZ1NlZmloblM4TkpEYUFVMXErLzJqNm8z?=
 =?utf-8?B?UGIrSmlrdjY0U0lON1hzSGMvdVg2SXNNUHFBRVg1aFQxaXI4NytJUVV3emVk?=
 =?utf-8?Q?JxyKXaQi7xv90qVFRscoyPMj9?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6aa105-fa08-4a39-4adc-08dbc987e2b0
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5943.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 11:56:07.0854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sT14UKKGj/QBii5+vzwSDyCt4DSTOdLOoTXCQSl3W+aqXJ8bqAC7rDMT3ixarEy41dOFCsoZ+GIMbjMO4yKB+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6965
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

For the t7 and older SoC families, the CMD_CFG_ERROR has no effect.
Starting from SoC family C3, setting this bit without SG LINK data address 
will cause the controller to generate an IRQ and stop working.

在 2023/9/27 17:30, Jerome Brunet 写道:
> [ EXTERNAL EMAIL ]
>
> On Wed 27 Sep 2023 at 16:51, "Rong.Chen@amlogic.com" <Rong.Chen@amlogic.com> wrote:
>
>> Hi Jerome,
>>
>> Socs containing previous controllers are gxl, gxm, gxbb，g12b，g12a，sm1，axg, a1，s4 and t7.
> That is mostly all the SoC we know of in mainline ... This why the way
> you explained is confusing.
>
> And below, you say 'on latest controllers', okay but which ones ?
>
>> The bit CMD_CFG_ERROR is used for selecting SG LINK of data address on latest controllers，but
>> data address don't use SG LINK at present，so it will cause an IRQ and stop working on latest controllers.
>> Therefore, remove this setting.
> Not totally sure what SG LINK but okay.
>
> While the change itself is fine you really need reformulate the description.
> Based on your explanation, something like:
> ---
> For the t7 and older SoC families, the CMD_CFG_ERROR has no effect.
> Starting from SoC family XYZ, it will select SG LINK on error but this
> is causing a problem with the data address ... blablabla
> ---
>
> Please expand a bit on this, try to make it clearer.
> Also, please insert the proper fixes tag
>
> Last, make sure tp reply with plain text emails, otherwise lists will
> drop your reply and please do not top post.
>
> Thx
>
>> Thanks.
>> -------------------------------------------------------------------------------------------------------------------------
>> Rong.Chen@amlogic.com
>>
>>
>>   From: Jerome Brunet
>>   Date: 2023-09-27 15:43
>>   To: Rong.Chen; Ulf Hansson; Neil Armstrong; Kevin Hilman; Martin Blumenstingl
>>   CC: linux-mmc; linux-arm-kernel; linux-amlogic; linux-kernel
>>   Subject: Re: [PATCH] mmc: meson-gx: Remove setting of CMD_CFG_ERROR
>>   [You don't often get email from jbrunet@baylibre.com. Learn why this is important at
>>   https://aka.ms/LearnAboutSenderIdentification ]
>>
>>   [ EXTERNAL EMAIL ]
>>
>>   s
>>   On Wed 27 Sep 2023 at 15:25, "Rong.Chen" <Rong.Chen@amlogic.com> wrote:
>>
>>   > From: Rong Chen <rong.chen@amlogic.com>
>>   >
>>   > Setting bit CMD_CFG_ERROR has non effects on previous controllers.
>>
>>   Which previous controllers ? v2, v3 ? Can you list the SoCs please ?
>>
>>   > However, it will cause an IRQ and stop working on latest controllers,
>>
>>   Isn't it desirable to stop on error ? seems like a sane thing to do.
>>
>>   > This bit is used for selecting SG LINK of data address.
>>   > Don't set the bit CMD_CFG_ERROR anymore to resolve this issuse.
>>
>>   I'm not sure I understand the actual issue being resolved.
>>   Could you provide more details please ?
>>
>>   >
>>   > Therefore, remove this setting.
>>   >
>>   > Signed-off-by: Rong Chen <rong.chen@amlogic.com>
>>   > ---
>>   >  drivers/mmc/host/meson-gx-mmc.c | 1 -
>>   >  1 file changed, 1 deletion(-)
>>   >
>>   > diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>   > index 9837dab096e6..c7c067b9415a 100644
>>   > --- a/drivers/mmc/host/meson-gx-mmc.c
>>   > +++ b/drivers/mmc/host/meson-gx-mmc.c
>>   > @@ -801,7 +801,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>>   >
>>   >       cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
>>   >       cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
>>   > -     cmd_cfg |= CMD_CFG_ERROR; /* stop in case of error */
>>   >
>>   >       meson_mmc_set_response_bits(cmd, &cmd_cfg);
