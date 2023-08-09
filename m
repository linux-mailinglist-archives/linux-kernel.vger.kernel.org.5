Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1417D77607D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjHINTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjHINTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:19:35 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1A2C1;
        Wed,  9 Aug 2023 06:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1691587175;
  x=1723123175;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WXFlV4I7SADXiSgWdW2XHqolRiqvSTrR54BxtWYUzJ8=;
  b=jzj9b3vpD9YVgFWHuY4Pc6npXNUeNkOqYwTg+vSnGBkBoBDdEyI15XVt
   1bJJ11NMN/66CPa4aBskXUXw0BMX+fAhP4FdlLP+zsbgaVX0kV9mQQCCw
   3E+lucLw9FmMPdJ9WNNRuxXdkT2h+3RXUfuKCIN61fCa7e753Xb2rGGmm
   tmM8R+DcQR9GaQrkN4XNrCE+9uFOg/tCbW5SRFEEZm9XITCGWkW3Fh2ZN
   QOCiYRrbt0PenQhmzRsVLKy4b5wB7dXu9kWzhMvVw2DtWYWgBwu1T79FL
   YX88YsKxesssyYnVTNNIpNKE8sI7mfFADUmZHj1N36/7ByHF7AFdtaHBQ
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfXQBMN3dvoAAOu7pv7cSKTVCO0T0x159iK1r8DKgpDBRHLVhW1K1YukLIIoMx5nSuYyErhx4+tYYIig4CnBdF3eIlLIFvDDSlc3uP2Sta7w0aDiKd/FF168DvLdjTb1CsxYCcfDPGXGLij1NvhHTMIyKeKKM6p5x+khdGcYaK84BZmm7x5rDb36i9/BaNCF/avHnUhWW0q1edmq8XTChofFsIUVrBay9y/ebrrw6ZVbZQ8c/lq2d5urOxWPXN09NyGgk7sLBR50JvW8s22hGGV+DgChe7M2VPiDAvP/77IH3Mkdkq+nnTJPfeSGABmbsUly/Tyka+On1Dk9xwviIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXFlV4I7SADXiSgWdW2XHqolRiqvSTrR54BxtWYUzJ8=;
 b=VhCMcosoEEaznYEIKCEGB9CxFjGGZtZ1XQZa0Jsnrv5qXQaEcWpPEh4NJapRFybnFoTYviGie0tjs4BvXjxOVGb+cijU7tweHQAShvFKiszHQmol9WfwmfZ96ScOwfj4KlSH5pdHXqRktX80abm7+IijpJKFKFETqyvLRf8Ni6bzKs7EZqhFgj6X5lLqvqI3rE46YrIXfo+zvLhSpOw7cqf5fkxUoqSAlC6ltGBSobr4dCjxsJahWJYll1v5oyrQ8BjqGL7F2gbr8oEG5pw7YqlE6G3oxwjE0nrz97gzDiSAbpzi2P7LWBqUJgyj/fI6sgHFqakwIeloIOR83ENOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXFlV4I7SADXiSgWdW2XHqolRiqvSTrR54BxtWYUzJ8=;
 b=V2XIOQO2EtHRbRYoOm0IP8/TialO0bA04X55WbtDmxZL81r/uW0wATuwm1qnOwUZyNypVbqkBgDN7Th4LJsfDGHIFrSRC4LRo/vLulEl2LGQhJ2F31MYAIEtnK9JuI6UOiD9h6nPOUZUp5AwvVQb5XztXpWh8Qpw9tkKeJ3NUT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <01a3c57a-bef4-9a9e-3f8b-0231653232a8@axis.com>
Date:   Wed, 9 Aug 2023 15:19:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tty: serial: samsung: Set missing PM ops for hibernation
 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>
References: <20230803-samsung_tty_pm_ops-v1-1-1ea7be72194d@axis.com>
 <9967fa81-f3f4-04c4-a837-d507a19989cc@linaro.org>
Content-Language: en-GB
From:   Anton Eliasson <anton.eliasson@axis.com>
In-Reply-To: <9967fa81-f3f4-04c4-a837-d507a19989cc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0051.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::35) To AS1PR02MB10348.eurprd02.prod.outlook.com
 (2603:10a6:20b:473::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR02MB10348:EE_|PAVPR02MB10009:EE_
X-MS-Office365-Filtering-Correlation-Id: 365b516d-c897-458b-b189-08db98db4339
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YSY0D2gMfox+TdkK8YfxKyIk5MjyaoibMaAVNK1zo0QiaUgKMwspWLRbIno3WX8B2Co6vCpEl4Z8uP9Rr+FnicyNoktk7nLvgQi/XeeZSMh7AKuZ7t/iW2NYI9J5r/Oa+ixbE073xTG3atvxBR4ujHC+5RyQ9pAvK/qgWCDwbbtv3+PdUJQakePA1oz6J2gVWs+kpCgDPXu/s5lJz7Lj0JeTZM9YREoUjGdRjTHzeVG4PMFmU9XM1kW9Rxiacni2IlLQ+mB+PwGRffOVfb9m9eLlKmlQODvDJMnCifZ3i7e9JxcS1eHAyzq2eMCDgmYGuOgN/HHcku7cjuIlFBC5XlCsmCElcgle0VhWMz/d5ft6h0XYeuvR+l7VBl/zwok4YwCZm7g8vtMVuFIFLx24PG6oX8f9WPGuFVvqh0ksI1Px6LzAC9yX09f1s+1ZzJFm2EIVt1QbIiFIoeIh66GiXEAmopCSzomMl6ioN7PzSU6gshda1QYqm0eIJuNmrpRBM4VlDJRzVSEs6TPR+umwj3APu3CFOiIQHJJxFmNUPizbXmXB4QbP4LEoGUKTs1N0y0RJAklx7VFC+Sru03TRwkCb6h08bTUUWo/7ZL+DoSVqbHvKatNeB79j4LWwGB2yJpfGNE7SjMWLYS6aqBslw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB10348.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(346002)(376002)(1800799006)(186006)(451199021)(86362001)(31696002)(31686004)(44832011)(5660300002)(2906002)(4744005)(41300700001)(8936002)(66476007)(66556008)(8676002)(316002)(38100700002)(110136005)(83380400001)(36756003)(2616005)(478600001)(4326008)(66946007)(53546011)(6506007)(26005)(6486002)(6512007)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MENLQzJaYVhabmxYVysxUXF6eTVzT2p5Tzl5WUFvVllwYS9XTkhlSFNtWThT?=
 =?utf-8?B?OUFWSXBGOHAyZ3QvZElheVo5b1dvbXhFcUw3Y1RpL1ZlNUQ1VDdkUjJNanBh?=
 =?utf-8?B?YVFaUURRc2YzVGFZQ1hKb0g4Q1RLcG9EYnhWeTdGYzRJSTdQOXpaWndLd3Q3?=
 =?utf-8?B?bVFUcFpSYXF6c2NLUTd1ZVVIRlVWSFMyaXZpRTdWVVEzNjVWRERNdCtpYTNO?=
 =?utf-8?B?QU9vcTdSaFp1QWlMMEFZNi9XODZTM3E5RmhMZ0pWVXc4dUZWbnBvZ2hMVDNI?=
 =?utf-8?B?Z2JEbnlqTFM1RWg3VXBwakZ0NisrVkQ3cTlwUXNDUVZrNnZ0WEVnQXZoaysx?=
 =?utf-8?B?SHMxUmhPTDJ2ZjdQWE5hVHBZdXFIY2pjeiszczNHVVl3YnFPd2RKL05xM1o5?=
 =?utf-8?B?dC9URFl4WmM0SnpoZys3R0V6SDBNdGhIOC9Mbyt5L0tIYnJQMEw4WTVBeWZ3?=
 =?utf-8?B?Vjc3SGt0WHNRQ2hxenZ3TjNkaUR2Rzc2aXlQOU9ocHNEQzR0a2xGeDd4WkRo?=
 =?utf-8?B?blJkSWN1dXhiK0dTb1lvMzhrNE9Ca2tIVFNiVnBnV3RmUStoSllzQmE1RkxI?=
 =?utf-8?B?RksrL1BrRVlwa0R4cFNQREtLWXNWc2xhUXp3ZE1ULzliaEJMRGVzbmlpYXBv?=
 =?utf-8?B?cW1TVGFaRjcyNm0wSFhhYXlCblc5R3UrN3lmNFZXdXFMVVJ5UzRpMVVldjJy?=
 =?utf-8?B?QXMyRlNPelFUc3JPZUhzNmZqRGk2R0NKbEpabWpQRS9aaEFIR2VuTVhDNTN1?=
 =?utf-8?B?K0FSZkIwdUh3cWo1bDFCR2RZV1ZDVHdzNUlpOFhJZ0lQYmdLOTQ3bmZFOWJr?=
 =?utf-8?B?T2VtVytKMG56VkNyZ3ZPb3pucXdkdGdaSnFhallIWkhPSlN5T2gxVlJ4N0gx?=
 =?utf-8?B?Nmw5WFV3RmJwS0pWYXVOWm8ydnpBWG84WE1CaUZWYjBXeUJ1N1ZlbGRNUTN6?=
 =?utf-8?B?RUFwcVhTL1F5QlNOR0k4dUN0Z0hEQVE1UEpvelh0MUV1SFgzUFlkcmUrL3lI?=
 =?utf-8?B?VDJkY1hYTFIrWnc3NDlmcGdUbk4xV2IxL2JRRitzMVo3QUpoVVQwTTZEL1JI?=
 =?utf-8?B?dzZNbzlnRkZ5am1mUTlVaW5lUEtBSXlkUzZ6ZDM2ZDlNbHh1bWtGSjVta2VV?=
 =?utf-8?B?SmxCTDZqRlpzaEx6YmxDa0NTNXVpdXNzQ0tsSjl0ZnNCWlYvQkpIbXQvd1JZ?=
 =?utf-8?B?c1J5SWVELy9LYThXVHpMQmNNdzJUSTJyeFNQaWZadUVwOUNMTVhXaTBYZW5q?=
 =?utf-8?B?dWUwMlBpN2RBT1hwUG5ONVl5ZWpBQy9NVTFFRlZtcVovaUpGSURKcWoyNktZ?=
 =?utf-8?B?M3BxeGJNVjJxUGxFK1BZZEVKNFBpNG9seklMenZXcTNsaGVPak8wWThoZ05j?=
 =?utf-8?B?UWFOcWJFRFA1SFpyRC9HcjFBcjZScGEwdUFINURsREVrdmJuV2tNbGx0VDE4?=
 =?utf-8?B?dWM5ZHRTc003N3E0anh3UU1UZDN5cEhxQTYvWWE2enF1T0UyN0xSZXdIVEZD?=
 =?utf-8?B?dGZpZW9BQ1Q5elJiVWFJd2ZhVUduL251anhjbGlIOFdBc0o5MXcvNWwrekd6?=
 =?utf-8?B?VzJMWW9WajNxdzM4Wm16UTVxS0c3QzBacTZHOGNCMFVVVGIvb2trZVJQbXpV?=
 =?utf-8?B?UVFiTGs3Z2drQ3RPU1JySEtDczZkWkdjaHpTUElySk5vMW0zTlBBVjJJMDYw?=
 =?utf-8?B?R0c1eHRhRzN6TUpFUUxscEEvRUtZODg0WVJZQjM5eTFUOS9BcW1jdmJoUmYv?=
 =?utf-8?B?SkNoTTE0S0RwcWNPaCs5S1hTcHdCaVlVMXNoUFVhS2QyT2Z3YnU4S2I5bHZM?=
 =?utf-8?B?c1N0YllkeVdhUXhYSWVBM2NmbmJZcVc2ZHhKQkNzQzFHcE1ZdjlCcGJQVGdM?=
 =?utf-8?B?Wk10ZGJYNjQ5MXJmZk5Xd1V4VnZuNUhIUXNFTWlJNnlsTndveTV4Um9zQWRN?=
 =?utf-8?B?NjZZcmE2K1lWQVpHVVJxNGFRWStHdUU2cXJVbFhBdUlxem9HK2cvTjZTVCtD?=
 =?utf-8?B?S0YrdUhyUmsyaG9KQ05BSE1VM3dpTmZmcDNWcXFPbnE4Q3R5UnpTU1grY0pX?=
 =?utf-8?B?ZnRGQ0FiRldpaEJoTXUrNE11YXFMWGZ1Q3VLN0tIMnB1UEpramwxTTZBK2sy?=
 =?utf-8?Q?vsTc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 365b516d-c897-458b-b189-08db98db4339
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB10348.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 13:19:29.7367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkYY0BYsQDOwbglbbnm6A/YklOmoEPpmnE8tmNcvq8up2JwdkOE7YB5NNZ1FWe6X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB10009
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 15.50, Krzysztof Kozlowski wrote:
> On 03/08/2023 13:26, Anton Eliasson wrote:
>> At least freeze, restore and thaw need to be set in order for the driver
>> to support system hibernation. The existing suspend/resume functions can
>> be reused since those functions don't touch the device's power state or
>> wakeup capability. Use the helper macros SET_SYSTEM_SLEEP_PM_OPS and
>> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for symmetry with similar drivers.
>>
> Looks sensible, although you should also test the other sleep methods,
> e.g. suspend to idle.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>
Yes, s2idle still works. Standby / Power-On Suspend and s2ram we don't 
have support for so I can't test it. Thanks for the review!


Anton Eliasson

