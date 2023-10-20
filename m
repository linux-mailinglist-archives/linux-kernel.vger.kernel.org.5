Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B37D0941
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376396AbjJTHMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376359AbjJTHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:12:06 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2096.outbound.protection.outlook.com [40.107.117.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB2B1A3;
        Fri, 20 Oct 2023 00:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxZiR5AqXjKR2aVBJTC05fSoybFCwAxhA/7N/W1Xg/Au1n9fkAvuNLd04rhMsbvknOqbFtnW6ZSvF69fSLj+/P6KI5YU95IEwbf9ydWy9onCMPs6aEC61RwvBytUKrLBI68B/3Vt6rQ1v3CpftesFdXn138r5yX1qF5RgnpJcwcmEMzWuYI5WKiRwICbWTBos48afM2hm4Mk38NDu1TLNlXT+kZKFgoPJ42wD5xur7Dg821MxjW3rnjm1KtJgCQteafefJl0CEwi/eru4kstjgZhZHoc3fjqYN9Ymivv0T0d/+eydiMyQxR3tgleiaPHt5vvb8n39MeAv5NPAF70wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvgQwFm5GiWirv447OEDUfOziIDYOOio/u2ZAOCGDfE=;
 b=fuDke50T9Ey+Qu0wiVO9nN9fmlsNYe2/Ox5M4GpDoLvLjWQmn3pcQj1lrqkk7xgyY2THC5eTHd/OGUogBW8cpCZmw622d1zBlpWQ9g1xVoavvIw4wtDSpIOxI7UQ9T5oIQzCND2jfHPagcCWEAglGcQT38jl5CBePjA82JacNPij7HB+aBj43F+y1jwkM3oVniQ7tcldkE3HUmEvacVpr+lURWJ+NHC2M5wPp1GIpEs9HD9pRhrKG8l8vHIZ1YUm7q4IXN9weE0KtljgfHNtkndNzg6seTTyWe64n0awI4onP4tKv/+Q/wldKslABolFgwmWoODG1AvSIaZ9FvFKhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvgQwFm5GiWirv447OEDUfOziIDYOOio/u2ZAOCGDfE=;
 b=JHf+tc57b+n1gqF0Qh1r1i2A4NTjmNdJyh505/FquUFmgnl0tNOuT0+C9eSYeMy2I7lfEjJPj7q2BjuL3Q51vWf8zLoS94LaD4Q/iriXkv4JeAXSgF5w5wBUCRKN0Q2pcvuJlacSWQs9mv6iLnZYh4VRnmjUUWPYetjOQqFqQf447zzHghQHAQ+hkjl/C2c6MrnooYgb6pkMuS9dvAI/gMvTpq5m6tyGzEVRqmmyQAil2J29l9Ij85ww3L1rfeNDaaKkw8bneNAzm15/5aQlpmY6WhsYUMpQDOkYXdxa7ITw9b5GFOJS4gFnEJxCzSha/vSG/hpYb3Zu06VK6xE3VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SI2PR06MB3961.apcprd06.prod.outlook.com (2603:1096:4:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Fri, 20 Oct
 2023 07:11:58 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::e9c4:dade:c65f:a63c]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::e9c4:dade:c65f:a63c%7]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 07:11:58 +0000
Message-ID: <257172c3-2d74-4cf9-a0f0-fa26431cf926@vivo.com>
Date:   Fri, 20 Oct 2023 15:11:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] scsi: ufs: core: support WB buffer resize function
To:     Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <quic_cang@quicinc.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20230911055810.879-1-luhongfei@vivo.com>
 <86e5cc25-80f7-451b-9067-a220c7a2c39e@vivo.com>
 <ec1a2b51-6b46-441d-99e2-8e5bc48ba2d2@acm.org>
From:   Lu Hongfei <luhongfei@vivo.com>
In-Reply-To: <ec1a2b51-6b46-441d-99e2-8e5bc48ba2d2@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0339.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::14) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB3961:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e4c4a9-9de7-4f52-3b64-08dbd13bd8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rD5z2/4HXfulDM6fcnV786Ir6NJsMHcAQVTG2CFU/RqUWTlRM8jq/QVp3Qqanj7OfzFowu8CKHQSfFIaLNZJt1YkxWifSKXUvWRTajkUIhLk5qvs9gNQh0vuuAZ3smmOG2eZnA/eS5AhArnxE7iUN3j+P1EOiMYwIfc/CXV75RamtngFJg2URsF6I4bSQWyGMVqwk4eTsNZ0aefMDWmVlf8/6s+Hs8F2EoGVhrtadX+WdI82PI6VR6jZYPopEZjMred/KYHzsT8JmkIb8A8DdFT5nbjRyafpxpMfrZKvz7fNFnhFPbzD6XeHpWQ5aOZwd24UnOj1K4HL03Uqa1xBXqKy37/vth3EQsvHx8V1oxngFyUOGgRvkw7D6uF8AVKYLTZc8X/Z0B9xr4KdkG6Q92phMv2FbkMF9ipXJmdBRzt6zegwNOSYZmWHszUSNSNVqSoK4mcJQ+DrONwTFdNKn3J5TbpK/y1S2IsmkDttEE3o1XmM/FNa08s2j6VyscugS061nw1z9sxOLfjDiCgptxA3Re9Lgc5W4SMyC++B1cWBnCZBiGfYAVzmfEkv2q3InB7x0VF+QMr7y8wvGMu2MWtWgVTv7HYhkmWKEdr3+odfwZcwClr6Cr6BUuKUjXKXqLQtognhpC91zQ0nxWuBru5JjgTRuHHCE+h4iqX25dPosqvSDhupX/JA6F5wwhTh3S2CqqmpWB96DgeYLdssw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2906002)(4744005)(7416002)(86362001)(31696002)(4326008)(8936002)(8676002)(41300700001)(5660300002)(36756003)(66556008)(110136005)(38350700005)(316002)(52116002)(2616005)(107886003)(26005)(66476007)(53546011)(6666004)(6506007)(6512007)(38100700002)(66946007)(31686004)(6486002)(478600001)(921008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2ZWZDBHcTNkZnVKeUJTaWpsK1pGYWhmcmhYSzRtY09URDM2bHcvUFZSdmhG?=
 =?utf-8?B?UFNuMGVGU2FVbTJKdlpUTHArUG5xak12KzZsZHJmSThaK0tCTEVvT0JFZGhz?=
 =?utf-8?B?SmpYREUySnVIT1NQRkVpczFsV1c0T3lkcFJRUzVlWTY1eTNFREZod3NXU1Qz?=
 =?utf-8?B?a2hhYzgveEFBUGRBY2xFcXZuRmVMSDVjSXJRUjVoODBQei9LZy9uK1NwL0t0?=
 =?utf-8?B?dWhZMkdWRGQxRndZYnl0NlVrSkNLYVBYbDVkTmNUZ2tyMFFrUjRndjZ2dUNO?=
 =?utf-8?B?U2FFUlJ3SjFmYUdRYm1wNHU2d3RaL2hRTkNtTXoreTlWTFB6TnRyVUNqNEZt?=
 =?utf-8?B?cU5oVytnYWZRZ0MvdUFmbEpYcXhFN09IbVQ3WmhFL1NsUnVmeFFxK3ZMcUVw?=
 =?utf-8?B?c1NIdDFISmMyS1FJeUx1ZThpTGkrakM0QUJSMWxRWC9WdWRMMkxzT3UzMTBR?=
 =?utf-8?B?WGsxRGZZUUVhTGkrV2Z4bzQ2YTFnRHp4VGNwVVA1WEEyL3Q2bmRoWldiM0Vr?=
 =?utf-8?B?Qy8wek9LRjFyNmxhRGh2MXBGWkdISGpOalh5ZGRQbG9DcjFadVI5cndEMEE5?=
 =?utf-8?B?Y3JqbnM3SFdTNzRSRW00amNRUmNsNUFzNFptVlFXOUFrcm1GRElucjV4Rlcy?=
 =?utf-8?B?Q3FQT1BBZnVGR3R3WHR2SmY5Wjh4Z2JucXpUN3JHNFEwQ1lUUEZZdGxGR3hu?=
 =?utf-8?B?QkRMTUpRcmpmSUZKWFVMcEVrZytLNXkvdGZnS3hReThFa1RFcng0RDJaRTc1?=
 =?utf-8?B?SDRUMG5xckVEekMvQnNRUDlTb2x2ZldCcVlydnJFQUhOU1ZIYzJBYTRLc1Jp?=
 =?utf-8?B?eEdUTzlydzY2WWo3MnBBdnlhY1Vpa3E1cG9ZNDRWaDdXZXM0L014ZzU0STZx?=
 =?utf-8?B?cW5FaDZBYnVkODZ5VThrZGplaUN1SytZVW9zQnhvcUhuQm8zREVjK3FiYUM2?=
 =?utf-8?B?NzhGd2crMmhibUhEMXZzNGR1Nm5IMThSRGlTdTVTVmRvMk05N1JyL05SNTEr?=
 =?utf-8?B?SlZ6cHNKMHNEOXlKODgwSU5TU3ZXQWZ2NmVoQVhVQnpTNHZnZlNhOG9kMmhu?=
 =?utf-8?B?b0Z0R1luOUpxcENVT2VWRlUxRXhmb0swWkVHR2VFOTI3dnJRNXZaSHRORWFy?=
 =?utf-8?B?S1oyM1UrVDQ4YUFzRlRlVmJnUXIxanJKMkJTb0lyRkUvVUlQdXRwWUxEaHht?=
 =?utf-8?B?bk5JZFhQbjdoeS9TZldzSUE3WW5OOFg2R0pITGZrYko4MU11SlBUK09DRG5p?=
 =?utf-8?B?V3F0ckM0Zm1lemhzc3lpand6Q21kNmVSdEsydmtRZ1llbGRoKzE4dlVuV3o4?=
 =?utf-8?B?cmVwNUg4aWp2bCs4Tk0zZW1YLzVxL0lKbkMvUVBNZTJnd0RTK3poL2xKd2Vr?=
 =?utf-8?B?VW03TXFJR1ZMLzdpMlg5YXhSZklOVGhyQXVaellNN2VRVzNXMFRCY2xMYU5Z?=
 =?utf-8?B?WmQvNnd2SlBEVnJRelhkWlhkSWNsK1ZWSGw5WTdPaCtaNWxUclZmZmdOWHdm?=
 =?utf-8?B?SjkxME5BSzdka3JlMmUrTFU3T0N0aURsZkJhNEJLVFRFYzZJcS92akRPbmFP?=
 =?utf-8?B?MksxWVBTczdvSjZzNzkreU10eUpWNFViZFhXQW96RFBlYmRsRFZRaXZmeHk2?=
 =?utf-8?B?by9hZjFienVJNzNWWWNrOThXZUJ0TmRTaW5NUVNtZnBkNTlrR2VQMnJKd0cr?=
 =?utf-8?B?TGdpZHhFOWpoeklXZUs3b2Uvbng4K3RDU2JQYVhCSFBOa0YvK1dKdWxZRjVE?=
 =?utf-8?B?eFJIQTBWcFdJR3Rxa2RsblZzWVgrUjRFWGZMcHhwYXliVXVLQWhKblRhRjRW?=
 =?utf-8?B?T2h5aEk4Yms5MUxUNUJGVGhtNEt5OW5JbjI2aDRYUDU1dEZUYVRpZlRCbXY1?=
 =?utf-8?B?ZGRYVk9INmF1YWVOdEhSMFEraElZUGxMNVVidWwxWUp2ZWJkVUhueXhtZFNo?=
 =?utf-8?B?VjhpcFl0ZjZuRXB5T1p0eWRuMUcvQW1scVpBTjY2Z2JBdDQ1aFcwL0h3dDdL?=
 =?utf-8?B?QmlXd3MydHFPNFJqM2p3b2tFTnZKbGlteERMVk9vS3JWUEFoTWpweEZVUmJ5?=
 =?utf-8?B?NjltOEZGNlhjZFNzOUladUZjdVgwdzJSU1lZdGVUSVpLcFFyTHhRcGV0MHNw?=
 =?utf-8?Q?qZnIc2tQRPJkHhwT3YFBM6y1F?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e4c4a9-9de7-4f52-3b64-08dbd13bd8fc
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 07:11:57.8993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKIkEbx5ZZAJxU2KFaXV7iikxxALGQX1jQytLK0uu+3fQESEtEW/HIlf8Y3BKAGjAQjOqKFr2QzWsM0/3zMzWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3961
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/20 2:20, Bart Van Assche wrote:
> On 10/18/23 21:50, Lu Hongfei wrote:
>> Are there any new developments in this group of patches?
>
> The JEDEC ballot about resizing the WriteBooster buffer has not yet been
> approved. Please wait with posting patches that implement support for a
> JEDEC feature until agreement has been reached in JEDEC.
>
> Thanks,
>
> Bart.
>
I got it.

Thanks,

Hongfei.

