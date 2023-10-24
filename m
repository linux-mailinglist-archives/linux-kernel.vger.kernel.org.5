Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E197D43BC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjJXALe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjJXAL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:11:29 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767C710A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 17:11:25 -0700 (PDT)
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.184.89])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id B22F810000D16;
        Tue, 24 Oct 2023 00:11:23 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1698106283.337000
X-TM-MAIL-UUID: 77ff5ad5-b4ec-4f7b-acbc-105ddbffeb0e
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 528E01000100B;
        Tue, 24 Oct 2023 00:11:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BokVjo291kPU2VBAvLpVC6L4NCh0MGRXAFkxA6pOCYpTQdZw/5PRyx6Mb962B+GWESuQh99QQGXXTwLAyHY0c7PrRn60BTHUajl5KnblRnp4jPr159r9OosbN8HbyNpioor4m1xy4BLLdGMJLy6h2RaCL38Km8KFPeY5YRYNFaBsE/xQRWOaH5qvmkUwRpCSEaGh8638QqC04jwFG7yPgN4JlkDPFmym+6edTL/W9NjRwlFnHTAaNcg+VrQloveHmaLIpM4ZTOtXnb3tZ0c3KuSelBiBn5/VMjV9N+1vEhFmad7CN1P3iquAiruNTTLlD0s4n3FOrFyUCKaFOGAHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnkacQflEac2v1amQql1sOd4Yju9cld7TgbIvyExlOg=;
 b=MMQtBQcRAoVhAszkvyffjuHg0QWnK/koK5erJNYxV2Z7siVu/BU8CVAIuznC28dIFEAFdE2Vat249xfb+K9Po2B5g3M4qWwzfSpsy0zALwQ8pcuYnBAULfgn8QUWXOfSraiEUPWsh/6JsXbFXSIjb6UPOmHuADZ8n9EF/qrBVSda7F07QDUeL5ArXdDWlWeFIUMvf8mQ2Yi56cKBCJ5fWmUAr2cAdvLq930fDtEZMjm2uruVdKUJZ0dIaRVm7BqLK0sxHGF/meRnp36wn5+4EOq7WNy1D6cOeyjJz9QiEC5Nrfi9lowj0nPf3iyc5H1Sd93Jf6o2dvQn3Om+YJvGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <a7808ac5-3f03-4584-93bc-485d358d57c1@opensynergy.com>
Date:   Tue, 24 Oct 2023 09:11:10 +0900
Subject: Re: [PATCH v3] ALSA: virtio: use ack callback
To:     Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, mst@redhat.com
Cc:     perex@perex.cz, tiwai@suse.com,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        manos.pitsidianakis@linaro.org, mripard@redhat.com
References: <ZTaMEUZUTrRRUD6y@fedora>
Content-Language: en-US
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
In-Reply-To: <ZTaMEUZUTrRRUD6y@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::14) To BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:5c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2374:EE_|FRYP281MB2191:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8ba72b-4c86-4313-7c42-08dbd425c0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrm+c011fElGUbdxLx5hv3haF6KBBth4ycB6ia3PeDTji84w0qwrT6Kwk5suwBQadWxF8A8L3S5SywRu8B5WUXycs6qQvhkPkSBSLYTzUv3YYJAGug3m9YcAo5RpugAw8ZyOs/ZsyXnHfaRQRwQHDwcvKoR5IFjZSb0rR9EE4nEmTaNskvTNqSbpgcpykXRSXWq8qvxV88puV6YdTgU+Z0Y/Ig8WYDjdikm934uW9LryRq2AQI5SXh1/xalcfrNiMAbByJzVmiNuSVFrfx4bz73auuBykTiadxWuGQh9nxQhp6Bp9mEDOVIogqEdvYNjeZ+34CcvSZC20ukxZ5fO3YT+hukBWPtB9W7xb732wvF+OTGhpQVRzS/NT5OMTV+xnddzkwBUT/BXzM82sWX1UDcWP48BNOZEWVs/dtIKmqS+HfHt/58hSAHEOFTYUn0XM6oAwIxAFItIFZ08jyvVxqvAW08V8MSC2JLMJGRTsTlxoTZZKfmPa1xiQzN+SqQDElhviAkaZ50yvnsVxWp3d/FoTh44FpyG/A2+FmxFSyBnM+BrxUQsaI6/IyiklsPIF6lMDIqG6eSFzrmgwxtIXrmGbbUePxGYFJIXeJg+ACeLN+KPZM0rFf9yGAGQyKtYhgDn/0ScGD+6aecgJavhKyTemeW5T+cBVsMzRXxn7Mk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(31686004)(2616005)(53546011)(38100700002)(31696002)(86362001)(36756003)(41300700001)(26005)(2906002)(44832011)(7416002)(30864003)(966005)(83380400001)(478600001)(8676002)(8936002)(5660300002)(4326008)(42186006)(66556008)(316002)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU5xTFFLNmFXcjRyVWtwRndmOUtUQWlFUGs2OVI1TVlXdEVyQUNNUlpWdUtM?=
 =?utf-8?B?R2lGSTNGYmNSSXZLY3NKRTdGbVg0VkNuV1BOZTlwSTZXL0JxMUFwbWxraE9a?=
 =?utf-8?B?Rm9xb2xoZkc1ZnN1TmlVK0FYRDFjNXdMTHQwYXJqUW00ZHl6RVRWVU44cThW?=
 =?utf-8?B?enlhaEFTR2hFNnUxaGVaSWVaTTdRZGwrU2p5RmVPOXZRbVlRT3BTR25xTHZK?=
 =?utf-8?B?YXpYdHQ4cmVxZDVyZFRWV2UzZ1N6UWVIcVZncGJoYXJtZUpYRnpyangwN0FN?=
 =?utf-8?B?OTVyMW13VXhZMVlUODdWaW1JSm1RdTEyMTFjcDMvRVRuNDNRUkRMTXlJaFA0?=
 =?utf-8?B?RmRCUTVDVVhmUmNySXJUSmpxVWVXWU5LSHFPNVVKT0VhMU1jOXpOWEc0OC9v?=
 =?utf-8?B?Q1d6T0dmVGRYS1c2cjEzSFBsbWVuTFkxZXduMTdTaHlRNkI3VGRRV3M1YTBC?=
 =?utf-8?B?UmhzUTZUQTlHN2s3ZHptTjNnRTR3T1ovTHNnNGtFOVgzSVpTVFd6TmtJTkEx?=
 =?utf-8?B?MmZOWDB1ellqZDgySkN5RURwYVVrUS9XMVc5bE9ZUnhBNXhzRGk5bDAxV2dR?=
 =?utf-8?B?NWF3eXNmeXpQNEJ6cXdNWmFYOC82Z295Ym1KSEFtcWhPQ2lMc1VjYktwaGFY?=
 =?utf-8?B?Z2FUaldQOHlPVHNReXlFTFRENFQxbC91RlU0L0ZiamNSZ1h3K1JJbWFlbmE2?=
 =?utf-8?B?VU5PMnJER0phT2RCMmN0RFlJZkpZZi9FQ3RZQmxBQ3hjQjNLeWh5U3VKTXVI?=
 =?utf-8?B?WFV6cWtYdDV5a0VKZ08zTlJEemhOc3owVFFCZStBRW1rVmFrWERXYituTDBY?=
 =?utf-8?B?RXJxQTY3N25uajh3MDgvd0gxSU14dHk1djdNKy9JNzAwaHZxbWsxYUlOUDVH?=
 =?utf-8?B?S0YrSXJmaGVyWlVVeU4xbS8rV09CQzkxZVZuczF1SjlKbWJpU3V0d0FJZTJQ?=
 =?utf-8?B?eDMzbW96KzFhb2dsMWk1WjdQbGl2R0FkeU8wY0kvNHBkZG1rbWhySVBrcUFy?=
 =?utf-8?B?dXlCc1k4OTBISWFneVpuMXdyb2d4eFF3dVY3SVdwY2tqdDNsa0xzTW55YzlS?=
 =?utf-8?B?YnV0UHR0S0ZSZmtUMGlHM2ZiUlJzM0JkS2MxUGVtRFBlOWZrNTNScnBKTUhr?=
 =?utf-8?B?MDZ1THBKSXRIcHFTeUowRzl3a096NTUwSHF1RTBMVHRCRTVZY09QYU9ITGZF?=
 =?utf-8?B?ZEZwWVhCVG9SZzcvUXZHYUJvamg0Ty9laUhlRE1LNUdLQmlZMlZCS0NJcDIx?=
 =?utf-8?B?Skc0dFJjT2kvS21vcHVQR1BOUU9oeUIvQTZBaXQzRkMvOTZoZlRKempaZ2pn?=
 =?utf-8?B?Kzg5WmYrbXAyRXdVRUZNd3FuY1RIY2RqT3RHSDBDdmVGQ3JtUnIzUjg4bWk2?=
 =?utf-8?B?bVQ5ajkvWFRzSlAydU9VUnhKSHY0eGdjdk9xK0RLRWl2T3Y2Y3BWbTM0b1dY?=
 =?utf-8?B?NUpTZk4xNUREQjJ3a3gwZm5aMGtxTzhvSTNDenZjZkpKcDdmUVJxRjZYWWV1?=
 =?utf-8?B?eTFMbGhtV0Nxd3haZWRpaTZxcFVsZTJORFBZaDlGRDE4RkxvUWRzREJ4bUhm?=
 =?utf-8?B?Y2RvNU0wMXlMTHQwZlMrQTVOQ0FoMG9tR0JqNk05RVFpS0NINHFKNGxKL0x2?=
 =?utf-8?B?NHhncHo2MDdjeFQ1RUJWekdqUXJSYWk4d3dNL09YK0g2cWYwaTdYMVMrOGow?=
 =?utf-8?B?Ky9MUnh3eWRZMk4wdFJidndQbjZTWUhpaE03T2tVZ1lVblpJMW1PYVlwa0x2?=
 =?utf-8?B?Z0t6UE4ySTBQL2V4L1pGaUpJUldQNTIwaXdkODhMYmhqbDVHemZid2kxbzN6?=
 =?utf-8?B?d0VrazVzQkJYZ1NJd0R1NFB4K3ZUWkNxbzBvZ00rQnRWcVR2RnYzbmFzWkZM?=
 =?utf-8?B?R1V5QlYvWHdWL3Flc3FBWTJ2cjlsUTN2T2NacEhVbkhUaUQrOCsza04wWkFG?=
 =?utf-8?B?WTZJWlJUdFRkdmtOcEFRWFRmRjE1WFFTY2M1ZFk2N1hrWDNQZmxQMmRvNTR2?=
 =?utf-8?B?N0pwOWRMS2NvQjlvMXVaQzU0UEoyRU5FNGwvb2VaNUxFK2ZIaEoxUCtrL0sy?=
 =?utf-8?B?NVlVVy9YQitoWnBkTHVuMmxuNys3aDErQ2JHbmFjTzZDeXIrUVdWTk5kY3JJ?=
 =?utf-8?Q?/PEJm+qD6OP3B//o6Yx7IV8tI?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8ba72b-4c86-4313-7c42-08dbd425c0d6
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 00:11:21.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3q0l5LcFWa0KLadnTgM8rd0doAv4rpS3nmDLsRdnbHeXw6nygI+iJNdaSFpiPYXhWMcoxoL2sjw+mWZRdneThQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2191
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27954.003
X-TMASE-Result: 10--22.446400-4.000000
X-TMASE-MatchedRID: b/1IsOqez6dxHKHpX0oMclY9XYa1m8xAZK1SF2R3edgrwvLze83KAozv
        m4Pxxv8Pyu3z7i3vDyRixG1BKJfHB/+qpWmqEPg8ITytpp/jrEzCjCxslGQrORxnMY5CbhsDFZp
        Plpzh62WlGa+vOpRchezi1bYwxuLCe9BlXvdmdcMsJRkKgHlrKG8lDAHJQfo4uxtkhcNHU8q/VP
        rnHmBZ41Kc/rRb51rIT/4sve2RJeQkEDLQ9SF8dVZB3ebKuqDZnVW5D6U48fcLDzQJD3kt0BgvD
        LMzLQnup6zqiHj263MqSEjxwqOovEB18yGtgV5AUrLQDoO1CVcSRRLwSueD2qaikDM2s04msUhF
        qfNcgQSOWA7WYqzVHt9rEb5Bf7uJQZdS6shUybjcMvZsE7nbYgf8yw0JGfKVSEazXcGLi+pWJ/2
        jutJX2+b1Nz8aB8UnAW1a55mUwfT9ldOC+RYUwbzf3G4hAqP9lIhi5GPAGePHA9/x8bsoXbdR0S
        OxdZbbTMncP/fvV6GaTQJyFGUjR+xAkh/4iTFXhi2C7dlNKWpWEpmiB2wI2xz2sRWlXYlsqTvdM
        FzB6We3UZmshdxAcVVZaI9Xr8ZXoR0T2IxW1QMnDrpxCH9Hlxnz+kO152KHujBC2MOFc2/92Qye
        yVvg9DnSnJR7/jmXAZuNGa1Y8H+7TLcxkxrna3lrH/TkKCsRikbFJLrj8PZCD8NaLaza0SiPEA0
        m2RyOkdo2c2shEujlS3lpuOq4YlE0IR/WwiQgSfWp9DpMHJ7piEa4ycCIsDB4jJltGVDbLN5wGP
        X3TPXYeXOEzfM22dEoO5p+Ouf5muMpo5XKw2/jfCs1ZLzBSlo7GmCOJYd1AqYBE3k9Mpw=
X-TMASE-XGENCLOUD: 540b6483-7809-4f45-8bd3-53aa3a027cea-0-0-200-0
X-TM-Deliver-Signature: 1759E8D0E36F93484587016491F42D67
X-TM-Addin-Auth: G+/sdhIfcnS49yduSjScKUl0AFRc4LbuKNDDd2qb/3nIvifhv1vBLNVD7cA
        J6RMmhRmXG411RKxRjNG3hd3K7lY8juVtZRVU2cBKco2xBADkBsqOJandLJ8Hfm3a4NfSqEDIj9
        k/i7yGlHpqjiD56p+pFJORcCP4Q5bck682mKTyGDCP6XUQYsq7rbja+DMScFuACP5Uye+0u1Pwz
        qGb9zPSZkgkiacxlrzV1v+qj2c1P/YaRUxDg06sru4arqzXh49oVeZmJ0aKs9UfHd/6+EdTBn98
        jbHHK33L8LYK0Rs=.L2mzIk9MxPOGbvXlon1Vat0sxqvoCEUKn4fQUCyIAnc8mVPIoVaFC1Vuuu
        79U2BbV+fVvaRnjZ3p71UdQEbEF9yi/Fb2AXjRxpVwnJwyO3NR0CSr9G9SELz6B/KnOAQlXTIdj
        8rEpDDnRqXsCrgVXu9b4ehjUcrtF1nHNP1+9W8qqlY99hkfP6AkYrfDMYrQ+BY/ah1bK2VPwyW9
        +Ygu4D2dsTccP8/DEPepuOzM9IGhPdSw7ZcNrMgXihNROtr7SBJlZqYwu1+SZrN50BT5WVfrdGG
        V/2ht9wOta2J60uwIpvpAP8sK71jBb+s0hgdCDbDM83CkWdFju9F4im6RZw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1698106283;
        bh=nSH/xpUBfco0EKfXIzzSFkinNZ/Xvpm99ceS6fJB0GM=; l=13180;
        h=Date:To:From;
        b=u6Zs+Zrq8C2J5fuJHhSiv7OWzFjTrH9dci/xPRc9SKHFMrpwJ5MWlza7jbUiWAWHS
         2XrDkewdhXJ2auIKMCKn/7yqoBICWqZ/XYi6tVb5AjrI2y14urQganEYpgoWbl11YH
         eSW61e3q/tfK4/KWpTZPi/UDsNc/cKhNskGeLDPEr0hsGDgV2FOm85G7PKGCuZq25C
         4P6FFlFMnArXQI9v1XZUX0GeTLLdYWFI1Q/eIfD7UXFRrP/uzxQTY0auLWvcvGIRQl
         jCOVZurmX7P+M+nFyd00LbHFA6y6lMvonwJrE21htSnEme2ni1B+JlbGG9DH4jJRCg
         LVLhiwAI+W/Pw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matias,

Thanks for the new patch!



On 24.10.2023 00:06, Matias Ezequiel Vara Larsen wrote:
> This commit uses the ack() callback to determine when a buffer has been
> updated, then exposes it to guest.
> 
> The current mechanism splits a dma buffer into descriptors that are
> exposed to the device. This dma buffer is shared with the user
> application. When the device consumes a buffer, the driver moves the
> request from the used ring to available ring.
> 
> The driver exposes the buffer to the device without knowing if the
> content has been updated from the user. The section 2.8.21.1 of the
> virtio spec states that: "The device MAY access the descriptor chains
> the driver created and the memory they refer to immediately". If the
> device picks up buffers from the available ring just after it is
> notified, it happens that the content may be old.
> 
> When the ack() callback is invoked, the driver exposes only the buffers
> that have already been updated, i.e., enqueued in the available ring.
> Thus, the device always picks up a buffer that is updated.
> 
> For capturing, the driver starts by exposing all the available buffers
> to device. After device updates the content of a buffer, it enqueues it
> in the used ring. It is only after the ack() for capturing is issued
> that the driver re-enqueues the buffer in the available ring.
> 
> Co-developed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> ---
> Changelog:
> v2 -> v3:
>   * Use ack() callback instead of copy()/fill_silence()
>   * Change commit name
>   * Rewrite commit message
>   * Remove virtsnd_pcm_msg_send_locked()
>   * Use single callback for both capture and playback
>   * Fix kernel test robot warnings regarding documentation
>   * v2 patch at:
>     https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2flkml%2f87y1fzkq8c.wl%2dtiwai%40suse.de%2fT%2f&umid=6a6586e6-1bcb-48d2-8c0c-75ef6bb15df9&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-090fe82db9a03f0dc8c4f214d4d2e2bf916e7f1f
> v1 -> v2:
>   * Use snd_pcm_set_managed_buffer_all()for buffer allocation/freeing.
>   * Make virtsnd_pcm_msg_send() generic by specifying the offset and size
>     for the modified part of the buffer; this way no assumptions need to
>     be made.
>   * Disable SNDRV_PCM_INFO_NO_REWINDS since now only sequential
>     reading/writing of frames is supported.
>   * Correct comment at virtsnd_pcm_msg_send().
>   * v1 patch at:
>     https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2flore.kernel.org%2flkml%2f20231016151000.GE119987%40fedora%2ft%2f&umid=6a6586e6-1bcb-48d2-8c0c-75ef6bb15df9&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-2d4d809544c877beff1a631a29db01290c65d879
> 
>   sound/virtio/virtio_pcm.c     |  1 +
>   sound/virtio/virtio_pcm.h     |  6 ++-
>   sound/virtio/virtio_pcm_msg.c | 80 ++++++++++++++++++++---------------
>   sound/virtio/virtio_pcm_ops.c | 30 +++++++++++--
>   4 files changed, 79 insertions(+), 38 deletions(-)
> 
> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index c10d91fff2fb..9cc5a95b4913 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c
> @@ -124,6 +124,7 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
>   	values = le64_to_cpu(info->formats);
>   
>   	vss->hw.formats = 0;
> +	vss->appl_ptr = 0;
>   
>   	for (i = 0; i < ARRAY_SIZE(g_v2a_format_map); ++i)
>   		if (values & (1ULL << i)) {
> diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
> index 062eb8e8f2cf..ea3c2845ae9b 100644
> --- a/sound/virtio/virtio_pcm.h
> +++ b/sound/virtio/virtio_pcm.h
> @@ -27,6 +27,7 @@ struct virtio_pcm_msg;
>    *        substream operators.
>    * @buffer_bytes: Current buffer size in bytes.
>    * @hw_ptr: Substream hardware pointer value in bytes [0 ... buffer_bytes).
> + * @appl_ptr: Substream application pointer value in bytes [0 ... buffer_bytes).
>    * @xfer_enabled: Data transfer state (0 - off, 1 - on).
>    * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
>    * @stopped: True if the substream is stopped and must be released on the device
> @@ -51,13 +52,13 @@ struct virtio_pcm_substream {
>   	spinlock_t lock;
>   	size_t buffer_bytes;
>   	size_t hw_ptr;
> +	size_t appl_ptr;
>   	bool xfer_enabled;
>   	bool xfer_xrun;
>   	bool stopped;
>   	bool suspended;
>   	struct virtio_pcm_msg **msgs;
>   	unsigned int nmsgs;
> -	int msg_last_enqueued;
>   	unsigned int msg_count;
>   	wait_queue_head_t msg_empty;
>   };
> @@ -117,7 +118,8 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
>   
>   void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
>   
> -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss);
> +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
> +			 unsigned long bytes);
>   
>   unsigned int virtsnd_pcm_msg_pending_num(struct virtio_pcm_substream *vss);
>   
> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index aca2dc1989ba..106e8e847746 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
> @@ -155,7 +155,6 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
>   			    sizeof(msg->xfer));
>   		sg_init_one(&msg->sgs[PCM_MSG_SG_STATUS], &msg->status,
>   			    sizeof(msg->status));
> -		msg->length = period_bytes;
>   		virtsnd_pcm_sg_from(&msg->sgs[PCM_MSG_SG_DATA], sg_num, data,
>   				    period_bytes);
>   
> @@ -181,66 +180,81 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
>   
>   	vss->msgs = NULL;
>   	vss->nmsgs = 0;
> +	vss->appl_ptr = 0;
>   }
>   
>   /**
>    * virtsnd_pcm_msg_send() - Send asynchronous I/O messages.
>    * @vss: VirtIO PCM substream.
> + * @offset: starting position that has been updated
> + * @bytes: number of bytes that has been updated
>    *
>    * All messages are organized in an ordered circular list. Each time the
>    * function is called, all currently non-enqueued messages are added to the
> - * virtqueue. For this, the function keeps track of two values:
> - *
> - *   msg_last_enqueued = index of the last enqueued message,
> - *   msg_count = # of pending messages in the virtqueue.
> + * virtqueue. For this, the function uses offset and bytes to calculate the
> + * messages that need to be added.
>    *
>    * Context: Any context. Expects the tx/rx queue and the VirtIO substream
>    *          spinlocks to be held by caller.
>    * Return: 0 on success, -errno on failure.
>    */
> -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
> +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
> +			 unsigned long bytes)
>   {
> -	struct snd_pcm_runtime *runtime = vss->substream->runtime;
>   	struct virtio_snd *snd = vss->snd;
>   	struct virtio_device *vdev = snd->vdev;
>   	struct virtqueue *vqueue = virtsnd_pcm_queue(vss)->vqueue;
> -	int i;
> -	int n;
> +	unsigned long period_bytes = snd_pcm_lib_period_bytes(vss->substream);
> +	unsigned long start, end, i;
> +	unsigned int msg_count = vss->msg_count;
>   	bool notify = false;
> +	int rc;
>   
> -	i = (vss->msg_last_enqueued + 1) % runtime->periods;
> -	n = runtime->periods - vss->msg_count;
> +	start = offset / period_bytes;
> +	end = (offset + bytes - 1) / period_bytes;
>   
> -	for (; n; --n, i = (i + 1) % runtime->periods) {
> +	for (i = start; i <= end; i++) {
>   		struct virtio_pcm_msg *msg = vss->msgs[i];
>   		struct scatterlist *psgs[] = {
>   			&msg->sgs[PCM_MSG_SG_XFER],
>   			&msg->sgs[PCM_MSG_SG_DATA],
>   			&msg->sgs[PCM_MSG_SG_STATUS]
>   		};
> -		int rc;
> -
> -		msg->xfer.stream_id = cpu_to_le32(vss->sid);
> -		memset(&msg->status, 0, sizeof(msg->status));
> -
> -		if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK)
> -			rc = virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
> -					       GFP_ATOMIC);
> -		else
> -			rc = virtqueue_add_sgs(vqueue, psgs, 1, 2, msg,
> -					       GFP_ATOMIC);
> -
> -		if (rc) {
> -			dev_err(&vdev->dev,
> -				"SID %u: failed to send I/O message\n",
> -				vss->sid);
> -			return rc;
> +		unsigned long n;
> +
> +		n = period_bytes - (offset % period_bytes);
> +		if (n > bytes)
> +			n = bytes;
> +
> +		msg->length += n;
> +		if (msg->length == period_bytes) {
> +			msg->xfer.stream_id = cpu_to_le32(vss->sid);
> +			memset(&msg->status, 0, sizeof(msg->status));
> +
> +			if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK)
> +				rc = virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
> +						       GFP_ATOMIC);
> +			else
> +				rc = virtqueue_add_sgs(vqueue, psgs, 1, 2, msg,
> +						       GFP_ATOMIC);
> +
> +			if (rc) {
> +				dev_err(&vdev->dev,
> +					"SID %u: failed to send I/O message\n",
> +					vss->sid);
> +				return rc;
> +			}
> +
> +			vss->msg_count++;
>   		}
>   
> -		vss->msg_last_enqueued = i;
> -		vss->msg_count++;
> +		offset = 0;
> +		bytes -= n;
>   	}
>   
> +	if (msg_count == vss->msg_count)
> +		return 0;
> +
>   	if (!(vss->features & (1U << VIRTIO_SND_PCM_F_MSG_POLLING)))
>   		notify = virtqueue_kick_prepare(vqueue);
>   
> @@ -309,6 +323,8 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
>   	if (vss->hw_ptr >= vss->buffer_bytes)
>   		vss->hw_ptr -= vss->buffer_bytes;
>   
> +	msg->length = 0;
> +
>   	vss->xfer_xrun = false;
>   	vss->msg_count--;
>   
> @@ -320,8 +336,6 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
>   					le32_to_cpu(msg->status.latency_bytes));
>   
>   		schedule_work(&vss->elapsed_period);
> -
> -		virtsnd_pcm_msg_send(vss);
>   	} else if (!vss->msg_count) {
>   		wake_up_all(&vss->msg_empty);
>   	}
> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index f8bfb87624be..21cde37ecfa3 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -282,7 +282,6 @@ static int virtsnd_pcm_prepare(struct snd_pcm_substream *substream)
>   
>   		vss->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
>   		vss->hw_ptr = 0;
> -		vss->msg_last_enqueued = -1;
>   	} else {
>   		struct snd_pcm_runtime *runtime = substream->runtime;
>   		unsigned int buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
> @@ -324,7 +323,7 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
>   	struct virtio_snd_queue *queue;
>   	struct virtio_snd_msg *msg;
>   	unsigned long flags;
> -	int rc;
> +	int rc = 0;
>   
>   	switch (command) {
>   	case SNDRV_PCM_TRIGGER_START:
> @@ -333,7 +332,8 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
>   
>   		spin_lock_irqsave(&queue->lock, flags);
>   		spin_lock(&vss->lock);
> -		rc = virtsnd_pcm_msg_send(vss);
> +		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
> +			rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
>   		if (!rc)
>   			vss->xfer_enabled = true;
>   		spin_unlock(&vss->lock);
> @@ -450,6 +450,29 @@ virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
>   	return hw_ptr;
>   }
>   
> +static int virtsnd_pcm_ack(struct snd_pcm_substream *substream)
> +{
> +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> +	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
> +	unsigned long flags;
> +	struct snd_pcm_runtime *runtime = vss->substream->runtime;
> +	ssize_t appl_pos = frames_to_bytes(runtime, runtime->control->appl_ptr);
> +	ssize_t buf_size = frames_to_bytes(runtime, runtime->buffer_size);
> +	int rc;
> +
> +	spin_lock_irqsave(&queue->lock, flags);
> +	spin_lock(&vss->lock);
> +
> +	ssize_t bytes = (appl_pos - vss->appl_ptr) % buf_size;
> +
> +	rc = virtsnd_pcm_msg_send(vss, vss->appl_ptr % buf_size, bytes);
> +	vss->appl_ptr += bytes;

I think it makes sense to store vss->appl_ptr in frames (type
snd_pcm_uframes_t instead of size_t), and do all calculations in frames.
You could do convertion before invoking virtsnd_pcm_msg_send().

We also need to either disable rewinds (SNDRV_PCM_INFO_NO_REWINDS), or take
into account the case when the new runtime->control->appl_ptr value is less
than the old one.


Best regards,

> +
> +	spin_unlock(&vss->lock);
> +	spin_unlock_irqrestore(&queue->lock, flags);
> +	return rc;
> +}
> +
>   /* PCM substream operators map. */
>   const struct snd_pcm_ops virtsnd_pcm_ops = {
>   	.open = virtsnd_pcm_open,
> @@ -461,4 +484,5 @@ const struct snd_pcm_ops virtsnd_pcm_ops = {
>   	.trigger = virtsnd_pcm_trigger,
>   	.sync_stop = virtsnd_pcm_sync_stop,
>   	.pointer = virtsnd_pcm_pointer,
> +	.ack = virtsnd_pcm_ack,
>   };
> 
> base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin
