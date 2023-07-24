Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF89275F667
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGXMff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGXMfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:35:32 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2076.outbound.protection.outlook.com [40.107.241.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE935E67;
        Mon, 24 Jul 2023 05:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0ZFkKtDvpCpcqKFs/aTw12xcyUrdxBxMrt6drNTKyhAdgEMjff+hvNor5Rvipe736Jn6AFFUdUqyrCl4ZN6hizNWyYQXnSSV2y0zjQskwyWT1FT9CnftGlU5Q64Um9mEE3JIL17F9okXYvM3+yoCTw2CYW67AC/XYPIAIxV242Rrjro+YvUSsM9FPyod3xlWJ3VzsHQQsJJrHQoNniSyPWa1c1TVevDkE3I821c7dBSmkt+fdCzxfB7e+ME3BNwk176f2wEKjbl32nxxl10BHwZap0SKAzQ/XPHdGnq5EJqWUbvYWx4vDkrv2stB1HkQOu3kC5BB6aEtGLydAV9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVr0Vi3XWCXAPAYd4yqD3TTZBlg/wh05kwc9vM7z+F8=;
 b=ALRtNcRakx/Xko1Zd7MQR8sPdr3aaXg2iPQpVpWOp0HphxlVWYOBeOhfNMAoCzdoUl34w1LL8noHMI24wvczglBehpj2x6H78wEgKF7UbM0knZwV6AsStilG2iN9CuHoYrIwP1vgfNt+eGYaXS6KSbx/9mhRIBXhE8Yz/qtDR4hg2RBXrfdCzM+/qzeUz/okBwYeHFhJr4L/AXAkJMvot4SSjnjk6c7uPxy7p6z0uaH/EAbv/dVuMdHJvEQcJiy1QZTM3Yqdd1aEiNZXNrqjfLY6tdhLYM7J7Xc6GvOLYa3pmAkYnJHVXMREdjeaBuU9QU6CruF3NXqfZABKMAtNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVr0Vi3XWCXAPAYd4yqD3TTZBlg/wh05kwc9vM7z+F8=;
 b=E6j8nBfxGfj8O9Ge6QuJ3vG+CK0gJG52pTer09ElnHbtfZfkhEEu2GeMj4738GRMAhmifl4kFmh+LFxBu6va6UNb+4uD6JJUE/W4jn2Nrr+rm7XRSlXCzoJZht3AeDD0wNsgTeRRqSVBzJ0u/ooMD70LBePVXs65JVE3CB/rw1F81m10ox1TvCf/7vorIlJJf5cPCAAeSYNOXOp/ajSopFQNAqCK1IUpu2QM4l/58tU0hkvpgRw3v2XeyQGi14KQSpikpISNdyJgkqgkCEZh//8i15UxW6Fd1BVN9bNbt59aOy/PiEaXt4MLEYl2kMeG+y2PjNw4/+8EKs5i/PHrPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 12:35:25 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 12:35:25 +0000
Message-ID: <c586a9c4-a51e-b870-c2c3-b0c7ffec0064@suse.com>
Date:   Mon, 24 Jul 2023 14:35:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB:bugfix a controller halt error
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        liulongfang <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <c3ab029f-f6ab-4b09-b2b5-1cc6a5370d0d@rowland.harvard.edu>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <c3ab029f-f6ab-4b09-b2b5-1cc6a5370d0d@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AM9PR04MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 03395b4e-a219-4152-3c94-08db8c427440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBIlnksfqsy6J6+PGuhlu+0ZXapT47SIpvDwsZiDK/U363yagIf3GbyIQzD6kjr21by4Xv9uH2M3m4CrH64RLKTa18rVsjBDHNm+9kXCkdtSGw5RkVU5Rx3+WqcC/ijQjVISfA855LrHi+tFgtPii5dtVwcGG0dfvsvlOB+9Wmu+E6jLizbkIJSDzMGeVCLq8zJTnneZpSVI9QTG17RXJZNztBoGH452wCSg3/ZbndxAPIM+G5ot8mMAKNVUbLurAL2M2PCrboglC4po6QcQLF1kvPMQyRFlDY3i8BURAZbbo1XGXDKAnVdyAakrWb7kLV5NJx17oCuvT+SaclOjlYUyuIAbRYxM1CNN4xHTdw15w8rW4jeta59MlACgcz60WPGgxJpAS0BuNWhCapL7kO2fplOOuYcPD4u6UY9F5RDwbWiMOAbj3FH+UkJglEyIJt2SYkw8z7G/bNZ1QgmHKLiR1065Vyz4pvLJ17q9ZTZ9mc7ZJ7vpVqPzPRI2NbgUMNLEsyaJ87LvsfZTl/gMRQpb2FepqS308WFMyOsX91Tel5Irsuh7uEMxNSHDzF/ORRjf29MWrqonwPxwijDuwObLOVsv3D917Rwt1UHJ/OcYRQdoWAozc8YqTlllA0u0/Uu4JzsceIEjMyMOOkASAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(31686004)(2906002)(4326008)(6486002)(4744005)(36756003)(8676002)(41300700001)(316002)(66476007)(66556008)(66946007)(110136005)(478600001)(38100700002)(6512007)(53546011)(186003)(8936002)(86362001)(31696002)(5660300002)(2616005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3pKeXFSQUx0NW5ySVF0Z2xNUjV3d3kwemE1cFgxZnBjaU01VzR1MFhadWhI?=
 =?utf-8?B?d0xRK0tJVVF5MW9ac0NxQk5nS21PRkVIdUFjTjRnNDA1dnF1N296dUJ1WVBz?=
 =?utf-8?B?MlNZTFd6ZXc2eTMyV2xRa0x3ZEdHdVpGTUE1RklCLzVJRHh3YlhHK2lxbkVj?=
 =?utf-8?B?dnZxRHIxS084d25ubTZxUnhicFNLS2xybFh6LzAzVitCNmRmL2RmNVpOY1dU?=
 =?utf-8?B?cUlHK3REQk10TXNlL21KeFQra2tmNW1TR0ZNMjdIdWtyMnlXSDgvNFNUdTVj?=
 =?utf-8?B?cmZOOUR2ZmRtbEdFZ3pQREt6Wm5Gc3dVVzAxZmdLZVJaS1ovTy9wamx4VjVJ?=
 =?utf-8?B?d1lkQVJtWUdlRGkxc3ZLN0NRMGl4MHZCOS9iOVcvT3RtS0NLWVlDbnZWRCtt?=
 =?utf-8?B?dEZ6OEg3NUpkaEo2ZVhXazE1L0tWZTkxR0Y0TTU4b1pZMjJwWlNTNGN4R2ZV?=
 =?utf-8?B?RHJ5T28rbWxRam9UVndpeXhZRjJvV2pXai9PSGVwWldreGpDZHJJU3lzTmQy?=
 =?utf-8?B?WDlCVmhSU21PR3RuRFY0NVhPbUpsOEV4VWdmU0RVdis5bDcrRTNDY0c5eWFp?=
 =?utf-8?B?NFhiK2RGa2tla2RtZC9hc0UwTDEvdlI2M0RoRHVaY05zZURVMG9aRXY4b0dZ?=
 =?utf-8?B?cWU4dER6clJSSXI3ay9rZC9qVTErSXhYSjJOK09Vd2xYYXFuUDBNUDVTeVhE?=
 =?utf-8?B?TnBSc1E4cHNLT1JSbVZaaVlQOGNyT3gxdkZlNkwwOGR4ZE9mYVplZmJ1MzFY?=
 =?utf-8?B?UktSQm9TZTJrZmM5dUwrRFMrbFBVLzZvelUzazQ4OWNZTXlLZmZyMm10dlox?=
 =?utf-8?B?TGlRNkpPVXYvQnlLQWxrNzJyeFZLWGlDelBScEYrVjMrZndYODlsTzJhY011?=
 =?utf-8?B?Q0JVWmFadFF5QjNtN2JaVUtROEZXeWRKclVqZDRJVmpYNWlGZnpoUnBJdHUw?=
 =?utf-8?B?bjZBbzY5MzhIQWNSRjdWYTB4dzR2UEtQK3QxYzBxbDcvUVgxdG5Ga1M4Wjh0?=
 =?utf-8?B?ZmxZVHFMZ0Vha0tIeDNPTUJVZjdOMWdnZkF3RTh1VkFqS2ZQUlYrdFlVUlYr?=
 =?utf-8?B?M2dsZmF2RjBJY21VYmhURGNNL0JnZmpuNHFFV29aZzFxMlBJVjdXanpUSTJw?=
 =?utf-8?B?SUVUTW1GV01lZ0RSQlhyRFF1cDVEUGFNa3VUUlhjRGJMMWs0RTFxbU5wdHU2?=
 =?utf-8?B?TldmdjB2WTVaTEpwdnRXQzFPVEZOYWR0ekFGVTk3YzVHWGlwa0JxbHMyWEhL?=
 =?utf-8?B?a29TYWU0RERxM3EySTQwbTR0WWx4OUJnOExWZE94aTd3N3Z4NU5WN0NMV0JS?=
 =?utf-8?B?KzNqZ2w3Y1M5SHFEWHNqZms3N1R5OHZjWEJtNnN5Z0pTc3N6c0c1UkRGeVVN?=
 =?utf-8?B?R0NQZ3BGZlNDMHFjMDVWbEtvR296bnhBUHFHeGREWG94UFNadUhxWGV2bEpX?=
 =?utf-8?B?YjBuM0YwUGJSV2tHdG1WNmYzWkxIWXZqVkNzOExtbzVnZUlqQlFzalIySUNL?=
 =?utf-8?B?V2VKWitMNG1PeHkxT1V2bVpkM3BxazBUR0lkUHE1SFRNNkRZM3RTRUJsZVZp?=
 =?utf-8?B?MnFaazhrUHpUNDVRY09Wa1YvMUgzZ0VENGovTmVOT29CQmtKWFYxdGJHTytn?=
 =?utf-8?B?amhheXFHVnhyYlRrQzg4bHZSNFdGN1h5cFZpa2xrWlc4K0dwK25VK3RtN2lN?=
 =?utf-8?B?YzVCZkVlODV4eGdMRlVPbnZLejdvMGZPL01BUm1teUcycFZZOXZiRmd3L2sz?=
 =?utf-8?B?aTJJeGw4bkdkUnZQenowZkdhcG1Za0RXbjBlRS9FWUprdkRtSWgrZ0dWMG42?=
 =?utf-8?B?dlFnZkNIeUxwK2tKNnN2aTI2OE9JWXMyZEw5OFFESmlYdENWMWEwVFNzUnhn?=
 =?utf-8?B?WThhUm82Qnkvc3IxbkJmYlB1VTFET1N3RUthOC9RVW9WNmRSV3QzdlFtWVcz?=
 =?utf-8?B?T1dIdnZrM2VUUytMeXVEdjJWVWQ3ZDdCd0RLQms1MzhCcTBNT3c1MWJNK0JI?=
 =?utf-8?B?TUlqUXA5dDRqZ2pMK1NiRHU5SHE5SVZYQWJhOVd2YTEvNkpsWkZObHNubG1K?=
 =?utf-8?B?c1BIM0krZDQ1dk1tdUNGTDFxSk50aG0vRk9DQmE1Rm5NaEp1R1JOdE9qS0g1?=
 =?utf-8?B?L29raGE5RWoydkdvZnVjRWozNjNDV21UakZtMlBYN1RLdTl4Si95MFBEY1J0?=
 =?utf-8?Q?ipW3zMwvHO/Ib6rvgLAeFYA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03395b4e-a219-4152-3c94-08db8c427440
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 12:35:25.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uz67IbTsHBZCNuCIzeYeiPL40K3z0IZ3bzHc4OOzE4lIhy7TXhg54t7Y2iFsyQaOlfejKCDglmhqwz1W9KZhvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.23 16:57, Alan Stern wrote:
  
> There is a flaw in your reasoning.
> 
> The operation carried out here is deliberately unsafe (for full-speed
> devices).  It is made before we know the actual maxpacket size for ep0,
> and as a result it might return an error code even when it works okay.
> This shouldn't happen, but a lot of USB hardware is unreliable.
> 
> Therefore we must not ignore the result merely because r < 0.  If we do
> that, the kernel might stop working with some devices.

Right. However, we must make sure we are operating on controlled results.
As is we are operating on a random buffer without checking an IO operation
has been performed on it.

	Regards
		Oliver
