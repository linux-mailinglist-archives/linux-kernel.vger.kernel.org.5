Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EFF7869E6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjHXIVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbjHXIV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:21:28 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2071.outbound.protection.outlook.com [40.107.14.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A9E1718;
        Thu, 24 Aug 2023 01:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA8cRnaddnPRukg1ywetSxgUqPL7Fi+/ZhpdkRrWXOimJwhp6eYEbo2dNBHKbfkZgKF/KGiEP1+BW5xzowxogrmZx6h64aBAKrTDV2uuuidhwttBVbgKfws1SQFyxVtsmANPpg0veP7v9o7NLql2JEh5av7fGFKebQVsHiI5lGaCCtOWbcIG4my/uBwR/xhoTKDi+Z+Hfe6I06GlghJemx0JGo/RDsy7nqm1L6ierLlbUwLqLWNI4nkq1dQVwjDdXZuXV8/CshDFMgiYQYwdEsn4Wwi55ZVL4up5y9LQSLQq5OTWve66IrkRF9GdxRfizZPuIK1Fz/lkUpm65w9fRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5inOPk9JVWXagoRNOXOtaf3Ti+JjqImdoUAJ+MES5E=;
 b=OgyQjk9gj6n9Zr40nzK3u5/ISEVWvoPRYfFFhE5TZfInBf/Au+2RXj0U3KeuPTk8ytYXSZZTYY+0XAl9tn3lfEo8F7wC4Jy7RchH1H2U8es7IhQkFYGCzyCcP6117qRkEM96hwPhH1rGHrQMzf0JuI6lF6JGXdw6zjYZzX261W2wwAFvd71i0HwwY4+JMcuqFN2wnY2QQzHW3sUlJFU1FPqm/Tq/1B1yP0ITQd51Ti9URUSOOEt9AFfq8yGyYnI04kXk84td29iTFA555AXp5qzUUkJKBm339hKPy4r/gUuMnIytLx5tW8McUXwu2OKvLZKAt6bNLkA25ZLsVv9XmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5inOPk9JVWXagoRNOXOtaf3Ti+JjqImdoUAJ+MES5E=;
 b=CyCzx6bpG7pB9cqWSR9AmxpcVM2drmwctnXsY5Mc9s6yEFpd+zVj8NiiXSyH9uD3i7Ww37a3MWy4DNyIRRbpyh/jfDbRqb30Q3r6g6Q2NzsXsAk9BiVNKDiPqzLa/V80InfKLP62TTxsYaiaB4dvsZ0ijMVGMXxt4UILujCqkDfOKaDOS9hw0wbe4cDA9/4mXnN1n/h9r2eXbZw7Fk92WpINlIAQwjCsyoTnJkYsVYAQooku65GdxITgP/VNgIxff35isoQZIu/YkORCps1da+t4oNAVrolulfcLJKhLZhSjTCnOSIybq99gtEBvXlLd0G5H8gthyA25oa4wtOfPFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AS8PR04MB8103.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 08:21:22 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::51fc:914:29f5:a420]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::51fc:914:29f5:a420%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 08:21:22 +0000
Message-ID: <6db3bf2b-b284-7e17-8c42-582a5c7addef@suse.com>
Date:   Thu, 24 Aug 2023 10:21:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] USB: cdc-acm: expose serial close_delay and closing_wait
 in sysfs
To:     Simon Arlott <simon@octiron.net>, Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ea1a13ad-a1e0-540a-e97a-4c44f6d2d33b@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AS8PR04MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a4afa1-4992-43a5-3d95-08dba47b195c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7Ep2qSbQdpzEtHIGJMGlbo8/dLXHc3frvJNq+ur65MVvoK95SsBh9TbMMR69+Ki23SROji4yULKBm6p3ceMWWUZOie5O5FQy9B8RRzxIq7iFmPTWNj70WbrS8sfiEXb2R4c/4hpHHfRW9+stnJI5cS92gmFixZUu2ct//2K3aXM5wKQSnsIr35OkIvqsJBuPsau1dCp2mE0uKp4FvXt0AY2lgNOP5wzH1rOZfJQtXOsPP09OSti6vKbK614jZteVwkzjcZqeBSxpu5+tfCoYTnalwRZ1wKcivccsgI7/JPW5aIKtJRh3BSK244xLRkXL/0sl6a7mCVcGK7rQtJmBuX9ndSaUNCzol5lCkKC0WR6lpnU4t8ynNfA7rNZFvKfO4KkVz7khEP3gXWXBVridlr15pHKJKo+dxr+zpdD9J00XjFx3G8Buxz+h3wQ8bayqIRx/6WYw/ZrD6mS4/qRBhw5waRgezKbnTo0hnew0k+TwwGO38TWxm+RupT4n1SGTsP/leKXGtl7B2opbpmoLb4zpES1DIpo4yB+ByWNm22c1VspmkGAA7bN9t454CqbrdNxjsyqmNVNZITfYMkjxqZSb6dmIt2KkG1prMDHJ/5r7IYVHyZCGK3SItJs9yUczwBHX25KhShD98JsEhy3Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(2616005)(66899024)(5660300002)(4326008)(8676002)(8936002)(36756003)(83380400001)(6666004)(38100700002)(66556008)(66946007)(66476007)(316002)(110136005)(478600001)(31686004)(41300700001)(6506007)(2906002)(86362001)(53546011)(31696002)(6486002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkczWXpDSWh2MmJzMmNlQk5Zem9YUHk3R2ZRN1lzeEo0cG14cUY1a3BGRFlE?=
 =?utf-8?B?ZHZPejdSZUs5QXB2UkZVcld2MVhxbjFJQUpFazNYQUtzWXp4UHlDRUpaQmwy?=
 =?utf-8?B?TDBKQmhlODgwVnU5QkZYazdFejFOeXlRZzNXYXBYYVZXd1U3M2c1V08yNjJ2?=
 =?utf-8?B?ZVFuOXE0cHZFL1o1cEp0ZlduQ3Uvc2MxcFEwdm1DbVNzMDRkaVdGT3R4QTkx?=
 =?utf-8?B?U01rMnQvUEJJYTU5QlVsdkJzLzZLN2FFZmxpRFhLUmlwQ1NQMENwVGZqdnhD?=
 =?utf-8?B?YW1QV1dqdUs0MVNQZGhYOUZkQjVLbjhrN2hLc2owRHFkL0c0R3QwUU5HZVBr?=
 =?utf-8?B?bkpxc0ZTZnh5UTZ6R05KUVl0QXlOaDBIalF3TU5PaGtHU3BGREJrdXowTDk5?=
 =?utf-8?B?aDRCUzV6eS9PZlB5WGhxR1dySWx5eXRLdnZiZysrRmJ6U1dRam55aHNtQUg0?=
 =?utf-8?B?bDBqUVEzM2xndkdURkFrTXN1OWw1akZ6SFBISVZEaUk5SWwyMHJGUnZwYnhv?=
 =?utf-8?B?TjNDbTB6aHppc3Q1YTZqbmhGWis1Q2pVY0lTZWJHbU1RTXlKSG1GZzNQN1Ji?=
 =?utf-8?B?dk80Q1BKWDZyS28rS09NUk9sMzRYVHVZY0IzSmJXOGN6aENyd0RFeEEwUzRk?=
 =?utf-8?B?WTBqVWxZbU1XcWhveEFIL1BlRlFYNVNNZ2JhZEF5MXNRVXo2cmpOdnVWcEg1?=
 =?utf-8?B?Q1RYdWI4WkpTT1IvMWh5QjhnSnBLVmdnWFMvYlY1N0xiYTg0NVF2OEJVM0d4?=
 =?utf-8?B?TFByempoQkJBaGhxa0ovU2NEMFp1VzIwQXRuWXJWMkdvbGFPYXQzakgzOFBa?=
 =?utf-8?B?dkhQZWVEb0NOZU4xREloUGxMREZQZHYzS1pRakdGR2F1TGZOZ0tQNmNkS1dw?=
 =?utf-8?B?WTJEODNjS08zUGZmNjdhTjZGcjhEbmxLVjlSdG1zZlUzb2RkMzdUTC8yMDAv?=
 =?utf-8?B?blY4TUttN0ZCL2JWc0xFOGNOTVM0eXh2Mm1ZbWVrbGdsc1NIeDRSRGtENEt5?=
 =?utf-8?B?SnVpci83eVY0ZU1yZnhJNUVteEdqU3gwL0NIaldwMUtYYngrZWp6a3NRVFZq?=
 =?utf-8?B?SzlnQjlNUExiSFgyWXVoV25yaTdwMjdOdUpadTgrbllueWQ4OUY2ZHNVZmFY?=
 =?utf-8?B?WjhSVHA2L2VRNEdiSTZqMGtYbVNQSm1PcWFvYXZTalY0Smx3ZzFkcGk4dWZ5?=
 =?utf-8?B?QlkzL3JuZkZ5Z2ZUWG1FcnYwWDZ2UzJOb3BVZk1VSGkzOFFWN2t6T1djTmh6?=
 =?utf-8?B?dU12VGxhOW4vY3FROFNCVFNyR05Dckh6ZDdzQ29aVXBDWUM2U3FScUNPV3Vv?=
 =?utf-8?B?dmRvSUVzMmRabytwaGVlZC9jb1l6SERNZTFXMjRtRU5VczlMUFZCeGdCWU0v?=
 =?utf-8?B?d1grdExYMFlUSUIrSmdzRnBrelJvMERNcVJkanl6ZHhYY25nM1B3ZUgzaUI3?=
 =?utf-8?B?NGxwSVc2a1RzdnFnZ0hsWnEvamRraGkzQ2R2WVRVZTZMMENBU3pldnNLM3kz?=
 =?utf-8?B?UW94aCt4L1lwREFjTUlhMUxSM2U0cmFmR2NtaWZjaEVXdFZBV2UzRW9kc3l5?=
 =?utf-8?B?RU1NSnhNaHRHZDArM0N3aW5JZytycUQvbGpnRnJqcFpwdWxuRkNOUWNWd2lO?=
 =?utf-8?B?cURkQkZxT3JXeUorVThwRGVtY1BYVG45VTFhaXA4b1RuNTRvNVB6bk9CTEtq?=
 =?utf-8?B?VThXWkZTdUJhY2J0Y2dnT3NUK3pFVGFuMjk2SEZLTnVtdnNETGJRUXhaTml5?=
 =?utf-8?B?b3psOFVQNjFBQ2huZGxRNUFXYWg4SFVRRGFrQTExOWZYdW15dEVHdWZHQ0I4?=
 =?utf-8?B?TGpDNUplRnoyY3dBMHRhdEFiWlRaL0xaVGNhajFNSXN3S1hpeG90Yi91UklV?=
 =?utf-8?B?czNnRVZIYWpCRG82S1NFV3p6dHhBVVg0d0RhVGpvY0Z3VmhmeGxMRlZSNGdM?=
 =?utf-8?B?dlJSUmdUajdzQzBXNFhkeElCd1J0SXVzUWkxNFVhT1JsTGF4MlkraUxCdnND?=
 =?utf-8?B?Y1RNQk1lbnVEQjFrZDMyclQvTG5yanhnaHNkMDVtdjJKYm8zOHp5NnQzK2Zx?=
 =?utf-8?B?eXVqQ212R1huWXdQYzlFbnhmSXR6Yk82ZklMRzRqZnpFbThvNXd6bVBVMmk0?=
 =?utf-8?B?dFBYYzlYREEvZXlDeWV6YlRBUEVDL1d3N1pwQlI4OEFPbTk5WWx1TkR3MUJZ?=
 =?utf-8?Q?i2MNaOosa1Hp+YOpw/bDtkwbqO2+aam6xrZSndZyOFHe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a4afa1-4992-43a5-3d95-08dba47b195c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:21:21.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ap01eNjMGHDpZcomCbTRHk+b3lis1zA66cG/uKkLYHsw6U6f+Woe9hNEp84JvbKt19gSXE3HQv1SuLu8YwtaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8103
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.23 22:37, Simon Arlott wrote:

Hi,

I am terribly sorry, but this has to be a hard NO.
This patch has an unsurmountable problem.
Reasons below.
  
> The serial_core driver (ttySx) exposes its supported ioctl values as
> read-only sysfs attributes. Add read-write sysfs attributes "close_delay"
> and "closing_wait" to cdc-acm (ttyACMx) devices. These are the same as the

If the tty core does not export them as writable it presumably has reasons
for that. We cannot circumvent those reasons in a particular driver unless
there are very special circumstances that make the driver a special case.

The correct way to deal with this issue would be a proposal to change
the generic serial code. Even there I am sceptical because we would carry
the code duplication forever. ioctl() is the way you set the parameters
for a serial port in a Unix system. We have tools for that. Adding a second method
is problematic.
But that is not for me to decide. As far as CDC-ACM, however, is concerned,
I must reject this patch, because it fundamentally does something that should
not be done, definitely not at this layer.

	Sorry
		Oliver
  
> Signed-off-by: Simon Arlott <simon@octiron.net>
Nacked-by: Oliver Neukum <oneukum@suse.com>
