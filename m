Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62F6791201
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbjIDHYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbjIDHYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:24:23 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2096.outbound.protection.outlook.com [40.107.215.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F31199;
        Mon,  4 Sep 2023 00:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQsWwqDZb0EhC8KPYdmSXFhwwuPMFJF7prw/cWIstMAqPypg9nPfXtZ+65ENrF9JZjMkiqNGFkBoFn529gM3lMLubQdu9l0nVL3RPb08R0dPO239Z1JYciELXnrGf4HHoBxIz9XVjeK2QevFnYA11OVmTicQRPLB7OsuEMDzX9Xz7fRyi6NPBJ3dLqeyatX9/yp0hpPMBlmszpYZ3eTRUz3x7FWjgA06kxc/3K0KsAH6RP0jsozukSQrhEiV5INKvfNkgQjqeclWwRxDZG9sRyBR0u9PoNLP5vut9NSdkFdHh4n6K+ybn/WswIJLf2Vfa1i3swgtqEdov/ngD0Bqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rudY4xLbhVkBA8Fsl3YEm0FQtdRdNlGeQFsv9xym7bU=;
 b=UdK0x+zM2FiMwnJHY+pn0kixotfX9g1zXTkkrKYJdl79lK4BlfXICRs5Cx7TthYL3hQg5F7PUaXmTt55EDXMOK6bjwlgxzvw5uQyGryf4U/ITHSTAsGH4+4yShKDh2HoZOors84IC+jdflSgopv2yGxecu0V0YtjvRh91CASog5ER8o0Jrqwa/5MyP+XplUzT91ty1wOoFycJI4ATxSv2vRnB1Sg2/aGQEXEQPalTd79NxubrjtXjpx5azlXHbRmxIu7ksjymscbN+tmQRq2AzLNJBTq830UpUmKDLL0VWhvDpsrCLxJjW3EB1DOJswT2fXyYKKKfNeJQdXz0NyWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rudY4xLbhVkBA8Fsl3YEm0FQtdRdNlGeQFsv9xym7bU=;
 b=n3qhH4ihSaWqgDM0mXVHqOR+ckuKnqdzP9w9+y+kY1ildJcAmNwaw494E96V5f+Jxf3it5WzKopWHd53yfNCpx/ys6yYKU6OakmWzlYoU2SMMkjO3Jka826jlv9gOW9k3ASPAcIhVmGqo4sPKarL6z8ngvKEQNfqKLc3MCef48vk9CEd5Wv+MT/B35ysmIvC7dHESiaOsl7wzr6Vip4EVz6W3Zw60cZbpmCSTnGln54xtAohGhC2u3hReZ48oc++YT/0+xF2ebLqBSXSpo7GF8hwMR/vQE2shTMGTYV2OPj5P+MhDxRrM/m2xZVlkHYoqbyEw7C06HrCIUWm0lhAbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com (2603:1096:404:fb::23)
 by TYSPR06MB6412.apcprd06.prod.outlook.com (2603:1096:400:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 07:24:15 +0000
Received: from TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::60d3:1ef9:d644:3959]) by TY2PR06MB3342.apcprd06.prod.outlook.com
 ([fe80::60d3:1ef9:d644:3959%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 07:24:15 +0000
Message-ID: <08d3c0a5-7f5d-4054-8bfb-7767aacd47c3@vivo.com>
Date:   Mon, 4 Sep 2023 15:24:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: export symbol blk_flush_plug
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "chao@kernel.org" <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20230904042243.820031-1-guochunhai@vivo.com>
 <ZPV15I09CTC/Dfww@infradead.org>
From:   Chunhai Guo <guochunhai@vivo.com>
In-Reply-To: <ZPV15I09CTC/Dfww@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To TY2PR06MB3342.apcprd06.prod.outlook.com
 (2603:1096:404:fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3342:EE_|TYSPR06MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f1189f-ac24-4450-7eb0-08dbad17f1cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVO3Ic3Xn9fhs25mCGYfR7aN0q6QdufFdBMftLlEyBHPS/nTZ9nE8co+I/cCyF/IY1QAJXb0aw4zURSlGHwPZp+/HhfqOpK9YpCdLlTxejfpx2QRrQcCs86A3pHr005VFSxNmd78r8heG1AnpkhNFRkuk6D4vyVDry/rqnttycU1bekeF0Pa/aJXqqbkJhnkcVwuUxU9pmf0Hna2MHJ/OJhgCg09WooVa7XtGO8/Mhbg+K9Oh+2Hq7qtILugcADcTgDGQM6tQKdWyXaTwCSeMV48lF5U+Y3HKZQ/Al0GaP1dS8RiZ/TUzHBIwJhCOclTQjb0IM5gESnDewvBby8LBE4Tf2WBbI6EU/QGpQ+AFrW3o/Gav5rYdmhZOGigjVAQdKaKjifKlAFcx5Ro9o2Z9zFpUXscbVW3d/gVLl/oD0J2GLZgM0Y4tt3oKqFTdQd4/5c8zZ/0b6jrFJV3XcFeUzIj3tGPpJTnoJ6ftXKI9J2f3FAfpVOk63E8m5davYVOhyRIu+BBwQaigIFXOZ092h5fv/odH3PH/P+nfKCETUfTUvRS9pogZcgLb/9+tHrIaothvqDg08Cus5WqROSl6XNPcBPLPzROMcqULKrLlMh2nNz+Z5E2+Ru2e5W+4NwnZ2U+edMZGyzUI+ew1caaJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3342.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(186009)(1800799009)(451199024)(6506007)(41300700001)(6512007)(4744005)(2906002)(36756003)(966005)(31696002)(86362001)(38100700002)(316002)(6916009)(54906003)(478600001)(66476007)(66556008)(66946007)(6486002)(6666004)(8676002)(4326008)(8936002)(26005)(31686004)(83380400001)(5660300002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bCtEOVJ5b2tKWjU3SEkxYnl3OGtvN3ZkNC83VGsvWXhIWUVDYXpqbDk3NDJM?=
 =?utf-8?B?bHY3OHFTb0RtaDFnak5pWjhzS09XNG04OVlaRFl3eEJZYkFsTUhQYkhrbGt6?=
 =?utf-8?B?Unl6UEJ2d0Y3T0Vxd1ZIQkl1S3hIL1czTTNYcytHZEdZVzBlU0wvVEdycTRl?=
 =?utf-8?B?em9nK3d6WU83L1dtOVpENmk4aUczRld6RTFZZStaUVdCMUh2ckNFN0pwQ0lX?=
 =?utf-8?B?ZFR0U1pRa2xENTRwbm95QUIybkZSYnBNekFKbjV1RWlsdkVBbXNRK0JxRnBK?=
 =?utf-8?B?aWczNHUxdjZ3SXJiWHpMdWdaaU4wRDV4WndCV3FOVVQ4V3BKZkVFUC9SOXZF?=
 =?utf-8?B?OHZlZXplNjN1RDFlWGNGKzJOeENvYnhWdExaU3VzWkFyenNFV2xvUkJxVk5x?=
 =?utf-8?B?czdnMUhjczNEMGJpbUNwdDZmWVp6Ukd1T2JyZm0vRyt4SlR4VndiM1VUUWlk?=
 =?utf-8?B?bVBoYm5Vc3VPNFhaWE1oeDlWZW9YdVNjUWpiMCtHQzhaR0Joc3BQMVBseks5?=
 =?utf-8?B?eUk4MFNsVkRmRFVGM1Y0dGpBZlJOVmx0TVBFU0ZRRUw0NWs3MVFhYmZtOVJK?=
 =?utf-8?B?ZndFWjRMdUQzOWV5eUpOZ0pDdkRuSzN5SEd6VEIvdVlJdWdna2hYb2JrZHhz?=
 =?utf-8?B?TDJmNE9mQzFUeEJJczJFb1B4eEppQWlGMGtFdSt1S3JqOVNCd2xrNE5ibzF4?=
 =?utf-8?B?SW04NXJ6VGZqcXlET3lzWTJ4WTBJRlZnYUx1T1FqcjdFTk0rb3A5bk90QUhX?=
 =?utf-8?B?UVI4cVBuUE9VcnkrUkpxZEhMNmJiWVpKRW44V1lDbDR4bUhrWHpMT2N2QjZT?=
 =?utf-8?B?QkNJbmFHbzdVVHNYV1p2T2J0bGZNeU0xK0txQWYrNnFYRVhlOXFXOHI1QnRr?=
 =?utf-8?B?bmZpcWlYZCtFUVFtWjRIeXdJdTFyNmduMUU5Qlo2SkxxNXdkd0p0NWR3VHpX?=
 =?utf-8?B?UTlNekhjUFZ5cXZlTlZxYi9PM0psRXlIQ2RoWmU1SkdrMTduRzJrRzVIMStw?=
 =?utf-8?B?a0pwR2dFZk5CbEpvMGlLQXBrRWpMejJGRGt2MzViK3hLNzcyZ2Z5K3lEa2g3?=
 =?utf-8?B?MFFvdGpLZW5vdTZIYzE2VDRpcWE4c3RvYkV3SkVRcm5lRlc0SnpTa3dUZDFX?=
 =?utf-8?B?dUR4OG81WmxxOXhkTm1BeVlIV081QThYS1V6djcxSWRKdUJzbDJMK0hBTHpF?=
 =?utf-8?B?eFdIT0pFZVZ2Zk45VTcwTHdSYVFLenRNVHo2bkpsVWFxbVBKMUxTZVd3citz?=
 =?utf-8?B?Q1hLYjcyTTNGQTNqRjAvTC9FOCttMTNDTEg5d2hOcjhRSnZObWFQNWc3eXZk?=
 =?utf-8?B?MGVxWHdPNXQzMm5BdzJLMU5HVHJvMTRvR21zdHdsaHM3VTBJSEN0TEp1MjM2?=
 =?utf-8?B?cm9JMzJ2bmZlWjE2TUovVkIvSzFmTmMrNE9Lc2pIZ2FmRnBwdUU2dzRadkpS?=
 =?utf-8?B?TjE5R1lGeE1xbERjdzFnOFM2dlVxdlJjT0VycWxDSlVSbnZpZE42azZyQ0pw?=
 =?utf-8?B?cnhiVlJYWWFZTk5SWEtIMWovbHAzak9xajJYUHBQa0NsM0o4dWFPNkNHU0NH?=
 =?utf-8?B?QTJMNWUzSUdIY2EySUNyZFBLOG5jbGlHZ085NHZ3MWI5NngyRkdkcVVZcUtR?=
 =?utf-8?B?c096aDNpdEt3SjdXdjVTSjdaZzlxVHRtbzNWbk5ROUpwZzhSVFJ3ZVc0d0pu?=
 =?utf-8?B?YWNMbnpmbmExcG1OVk9kbU1lR2pYa0NhZnIxZFZxQTg0cWl3bi94S1E3OStJ?=
 =?utf-8?B?bDZCaTBtMnZZckh2elZldWIyb1V5R2htSGoxeDNQWkVZTnlDaFB5Zksvb0pB?=
 =?utf-8?B?Vk9iZXdZSUpjT3lMb2JWN1VpdE5mOFZSM0JNMUxMdkRVZHNubkJuR3BHbVdI?=
 =?utf-8?B?K0hYTFRneDUrdXhzUzBhY01aUGtvQzI2M3ZYYTVSYkd6aUpYYlA5ZjlNSFRr?=
 =?utf-8?B?bXVoaGNUNHM2aHp4cTYxNTVGUzl3dUFRczlyKzJCTXRpcmFpWXl5L2xFR2Nt?=
 =?utf-8?B?aHViY3JzK3cyZnIrVlhKYlpza25tV1FVL1Z5N2hqZ2lZM1BKTUh0YThUY0xQ?=
 =?utf-8?B?bkoxeDVSZVRoZnlsWTU1ZlZJd05CVEJZbzEzTitZSHRINkk4Y1AwekdtbzQv?=
 =?utf-8?Q?Fju96rVxn1XFyTgo40hbjkFG8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f1189f-ac24-4450-7eb0-08dbad17f1cc
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3342.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 07:24:15.7685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzWpMxUuuzVwUDErb/z9PBNxXQXvN0hxmN+ktRyBJ7i5pUM9FTZuvuPQi0qh5kekOYjArNFCuHIH7ur9ZsdoTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6412
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/4 14:15, Christoph Hellwig 写道:
> [????????? hch@infradead.org ????????? https://aka.ms/LearnAboutSenderIdentification?????????????]
> 
> On Sun, Sep 03, 2023 at 10:22:43PM -0600, Chunhai Guo wrote:
>> blk_flush_plug() can be used in a filesystem module, without it may cause
>> a link failure, as shown in the reported test.
> 
> It should not be used by a file system, so please revert the change that
> started using it despite it intentionally not being exported.
> 

Hi Christoph,

Could you please detail why blk_flush_plug() can not be used by a file 
system?

Thanks.
