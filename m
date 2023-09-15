Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0167A23B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjIOQiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjIOQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:38:20 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2059.outbound.protection.outlook.com [40.107.6.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086AC199;
        Fri, 15 Sep 2023 09:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEMcdWgWf2vkLpJ0AKSg2I8vAcZhjB68lYo3ENT4PEco3XdzNGufWMLrkhHLkx98rWYQnmPf/Gb25eD80jvnEzNyZZDqqx3UZiCKfrWXOv/1ekR9wJxy/zj1CAskitwuM94IxbTrX7R7uMdo8J1vj+BCwd1VLVLv/Sl3bE633RLidT7k4qbnprz7p8boqw64LtaN+bMuKVPH9pmlqu8aDwfAzdzZHKjf1rKI+nICtLcm3zvHWE8c88F78pipoaqhzgCnblAUnFNH4s3hQOThTEnnfckayEiC+MIVzpOg+g1LQNzs1yocUrXl4/8WviVUxXyCWU8FSvpH76SyjXqutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGXEFl36pVCPtL+4WGAMOEHdf8Gp4zXPlM8uFbR2br8=;
 b=YufWEOgskY5ziMIk+oMN2FDOqxxhBTy9+AD++A8CzG3yeScQ+FL4AG0AmHIpr2RH0kmEvVxILW0d5LORMTrWWsoddn24YKj426E94GZhmgj/aU5pMoxGk9l2lSe54B9kSZxMKiMFDWHGTht6EvlTSOeddAk8UpTXsMLVscCd40jIBXZ4Co1Dl398FZpUp4PotLAMcH6/OYAomPd8Qd854Z4tjj0BKIqN5OqbqCTWgzYYQ2O2M5mNhxfAtpK1nJFRr9987rs3UIjP0hXU4MxC0OdU59Qjm+Cai+atyGpoXr3lkHKM9AonBNvhkuVWMQPzRLpQgHu7K5iaTpPHeG+mhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGXEFl36pVCPtL+4WGAMOEHdf8Gp4zXPlM8uFbR2br8=;
 b=Zew3hWiDQsLaeCJWrYuHC+lia7115ScqSWifSf9j8Z9YTNPAg5xKZFAvCEw573NqtwDJYNkBfsLDTgnpz6bmFRS/wGEw2q2oaVclaxVMkWgmS50qEW4AuWPMI55kvk1M3BmR0HzE/B4DDYrl2yMpa1sLGqu7uTIwDVdnDxfv9Ul5LvTz9bQ7HN6giTPZZf+Cy6po2mH8VJGWH4AzaVfSmRJ6t/zJVO7WhWbkrF4MDKG5sd8Iw+EIdhlm4Me/TwtRCHA+m+JcLSGlCOpvfLXk/wk4O8rJkCebml2p9wql/lkVR2ieMxFOA94kxBuUG770o0foF/QOanplgN3blwj+RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB8923.eurprd04.prod.outlook.com (2603:10a6:20b:40a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 16:38:08 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5c00:6152:6ce:72b6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5c00:6152:6ce:72b6%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 16:38:08 +0000
Message-ID: <61e20eec-6d54-160e-abba-d668b1d19047@theobroma-systems.com>
Date:   Fri, 15 Sep 2023 18:38:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] pinctrl: rockchip: add support for io-domain
 dependency
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Saravana Kannan <saravanak@google.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-2-s.hauer@pengutronix.de>
 <CACRpkdYxRdToUM3JcEeNK_K87D5WDzzSLvVEbtqqdQEhz3k_Ow@mail.gmail.com>
 <CAGb2v65G-8EECNjqnpKCxqAD5nATAb0S7AA_WMiGXYOR1avrvg@mail.gmail.com>
 <20230913065843.GF637806@pengutronix.de>
 <CAGETcx8rO=aykjb6=5k0wpOyscqokNwSL6w-AHnodY7pNXyzGQ@mail.gmail.com>
 <20230915065120.GQ637806@pengutronix.de>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20230915065120.GQ637806@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 00492bc2-34ae-47f6-2666-08dbb60a24b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7B8rqpbq8s0+cXxXNfXfpKgPK3rIhSuhOCt7mka2F/VhBCfdQLu7jw25j8TVhnn+JVHigvh3yHydcVreLcH4zely7TtRRA0E8xggfeGQ8Bem408IAQDt+oKfEqYTdfda02cFQRVW5YqRs5+ip8p4lKCfLsJ8M4zXDzXiv0o7CJhKhssXd4ZaRsvQxlnF8AxHblw3pkSyt49j92YVm5uiF0JgCO5AE5le7wdGsZ7DDXGlQ0x4jH0ZivOXg351e4E+dBXizzM8tLeWZ5zWxPwoDLEc6HttL2mRqb20HoAPmvdbMfStnze2RU19N9l2fzeUC5xiUEMj8KKOlqrKdc1sDu4HaLoOmx2VL5xa1JONDr/glGbOjLlUFvu98QBJrQoPZ5q6CcLeMG+B3+xkb+g06S9BkkZ7jz+iMNCNjzutlRWxVYvXnIgZt/WO+YEjtXfNXX1l1v7XSglylHqaLftb/FdjNf981kY/TcGGSgHq6K0/Ym4mofLBmL+Jc+z7r5iPg7eKN1CbNw19PS7AhPzvzbVF4Om4br5BH2EeuZ+vZbTIFly5fvxBTJTmbjRi7cK8u7rVsKSLri/3zm89PGY6sQZkqnN+ZIjN6sFGQsw+rZ/vIctyA5sV3Jp3iD4E3QhXYs1m/Hs3jqhYSLAaLVCiWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(346002)(396003)(366004)(451199024)(1800799009)(186009)(31686004)(5660300002)(41300700001)(316002)(54906003)(110136005)(44832011)(478600001)(86362001)(31696002)(66556008)(66946007)(66476007)(36756003)(38100700002)(8936002)(8676002)(4326008)(6486002)(6506007)(53546011)(2906002)(7416002)(6512007)(6666004)(83380400001)(30864003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUJWWjRqWWhZMm9ZeFpaOHhzNUZ2MnpEc0NnU3o0NFI2RjVPODVWdks0Nm41?=
 =?utf-8?B?UVhwMFd2ZDVVU0NHTXVzditNTGRaUitjamFTUkorSEZIVXJrQVB6UGh6bmxn?=
 =?utf-8?B?MVdPNmpaZjlXRUxnbHA3a2FPSEI0NVN0TjU5OUlMdDg2VGxReDVJeE4rZk5s?=
 =?utf-8?B?d1dUWVBMT0tJUlNDdmJxSmhYMnRENjY2OVo1NjFMc2J5N2VEUGplOW4yRTdt?=
 =?utf-8?B?MnBiLzA2VkNuUzF2V1NpREpyYkgrQUwvN3ppWlFpT3QrZlF1ZHNvR256Q3Y3?=
 =?utf-8?B?UXJyMUNzN2hNRUdDMEZ5dERrWTQ5UnNwcTl6d1NiRFRRL1pVeEF2c2xLVWp6?=
 =?utf-8?B?em10M1hFNEVSVW8rd3l2enIxSk0yenA5T2poS0kvN1ovS2VDQ1RHdjBuem9m?=
 =?utf-8?B?M3NmMGVSKzFJUFVqc1pEYkxVV3J6NTVVRmdqY25ZRGp0cVMzNW5iOFg2aGx2?=
 =?utf-8?B?NDZYbW9ZU21VWTJwRDRIWi9mcS9XRXI0V1U1UjNFZVIwRUkvRGlDSUdCcTRr?=
 =?utf-8?B?cHhlUGViZ1RLb0xpSXY0cU5nR015Nko2aUNwVnlibk1PMU1kVU9kQ1BscFRU?=
 =?utf-8?B?QzZVWDJrUUJuUHBPYzVtbk9PZll1cEswMXRFV2dOSzU3V2R1MnZlUngyWXVM?=
 =?utf-8?B?Z3dlUEt5S3preG9pTzhpd3RZSWRiNys4SUNRM2FCbDFDeUdmUmtJd0Fpb1p5?=
 =?utf-8?B?Z2ZSWHdzZ2pFdXUzbEZHdjQwaGtsYWF0Tk9wRGJ0TmJCNzRoT0RIQW1wVmxB?=
 =?utf-8?B?bm96SXBzYzQ2dWFKaXRVZkt0c1dtc0NJZnR0Ymw3a25VVjdMbGJBazBFQ1Zz?=
 =?utf-8?B?dVRQbnhkVHU5ckl3cTB0VGxrV2d2TTZYU1JEUnNuMy9qakl3amJvL29BTHJv?=
 =?utf-8?B?b3FjRS9mZlNTWHNNSDlkZ2tmTzBCeDA3ekh3OXd3V2tkWVJwQ0w5eXh2YXdt?=
 =?utf-8?B?MHFCS0NYd0o5YzE5YVM3WmR6amczZFYwNGlGSnZFZFhJbGd5UFhycjcxNmVL?=
 =?utf-8?B?Y28yVzR4SUFIeVAvNldVWXFXL2k5SGs3QUNPcSs5T1VPTGcrSTVnWW5jZ1Fy?=
 =?utf-8?B?YlBzSmFielhzekFaTEw1R2NQMHh0YjBEalZxN2NuNkhNNXJ1NHl0cDd2bFN5?=
 =?utf-8?B?b1NaZnEwcW9qaXZQcHJzYjArV3ZYcDlsaUQrU25wUXo5SFA4b0EwMk5EMkk4?=
 =?utf-8?B?bVBSNDVKamdIQ00vRTdYc2ZGWnQ4OWlvWDJyaUJMa053WlVwT3dWeCtWWGRK?=
 =?utf-8?B?dUJEZnBpVzNadWREVTB2OHlrdHZiTzN2VTZqdHVhbEEvVDZMYzdaUC9RUEZy?=
 =?utf-8?B?Y1IvMjgwUDROTkNSUklFK3FIOUFXcGxveTlkUlBua3FiUVdoR0RmS0FXQzYz?=
 =?utf-8?B?QkZKd3FMY3NYdFNKUS8yYktMT2krbzVWUVB1NHVZUWhGdnVGd0p6QVVhckNI?=
 =?utf-8?B?akloY2hsMkVGSExFUTdzWFNEZnlsOGZuYXB3OUpiUG4vcndEMGxWa2FDRTF3?=
 =?utf-8?B?aTFwRmhrM3pwZWR1Z25kcWhzTFJQeE9PbDBzQzFSMm5EWldsTGRpZ25UWnVL?=
 =?utf-8?B?VHoxMks3cm9paEQyOWQwTERWbWowTU9OUHRSbnJid2o5ekVXYVBVNk5jTmcr?=
 =?utf-8?B?MWtkbnU2d2RKUmR6UStGMHphWXlPUHdBSmFxTjZYSEFDQ0NHNDBkdHU1ZFpO?=
 =?utf-8?B?MG5IaTR3cmRCcVFRSm1FVlVOYVFFWi92d3g2dkVsWlFTR2ZPekNzQ0habHF1?=
 =?utf-8?B?Y250TytXUE9aa1VCclhISHpZM2FzN1UwZE9IUnNaMExSTERTR2FsNHNQMnYv?=
 =?utf-8?B?cys2emZLNzl1cXhTUEx0dS9mT3ZkeldwL3F3Q0lhMHBncWJ1VUFMb2ZIOUhK?=
 =?utf-8?B?dEl1Rlg5ODREb0N3ZldOZU9Ic3Z6VTVBcUp2dUo2eExSVVBGQVM1WldMREZF?=
 =?utf-8?B?OHFRNXIwMS9XQXRmWXNjQThOemRPMEdWVURqUUZ4NW10UEgrK042cVVUMXRZ?=
 =?utf-8?B?dHRrRzN0SjBxWFU1dnF0bjhrV2J1U3pURkJPQXB1cXBKb0N5dlRmYy9sLzVP?=
 =?utf-8?B?R2hObm5lMElua1RadTJVa2lMT0V5L0JxR2d2UHdDbWgzb3BYcWFWR3VDbzVS?=
 =?utf-8?B?eGV3UElvaVd5enYrdVlOeWg0cS9ZYWlIQUJXVzVtU3VoR2NhMG1MZ2prTkZh?=
 =?utf-8?B?VlN6QkJta2NxZlZPTTFtSWU0UjV6YUdmN2tVaVVjdUJBcW5iUGtIVy9SM3gy?=
 =?utf-8?B?SmlGYnhVMk9XWDZpYUlVRFM5OWFnPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00492bc2-34ae-47f6-2666-08dbb60a24b5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 16:38:08.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vFeZdhMKNTTMmFW0nFER4KaUcyl+c+9tv+Sd8kbVE2iL4iS6gjruHnxRSbeVKm6W+E0h52oWG+DtZCInm+mwOrcwt+KHmorde5qSV1mPTb9ZsZbdkPJX12sBtd7cqlj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8923
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 9/15/23 08:51, Sascha Hauer wrote:
> On Wed, Sep 13, 2023 at 01:48:12PM -0700, Saravana Kannan wrote:
>> On Tue, Sep 12, 2023 at 11:58 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>>>
>>> On Wed, Sep 13, 2023 at 12:37:54PM +0800, Chen-Yu Tsai wrote:
>>>> On Tue, Sep 12, 2023 at 4:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>>>>
>>>>> Top posting to bring Saravana Kannan into this discussion.
>>>>>
>>>>> This looks like a big hack to me, Saravana has been working
>>>>> tirelessly to make the device tree probe order "sort itself out"
>>>>> and I am pretty sure this issue needs to be fixed at the DT
>>>>> core level and not in a driver.
>>>>
>>>> We could merge all the IO domain stuff into the pinctrl node/driver,
>>>> like is done for Allwinner? Maybe that would simplify things a bit?
>>>
>>> I thought about this as well. On Rockchip the pinctrl driver and the IO
>>> domain driver even work on the same register space, so putting these
>>> into a single node/driver would even feel more natural than what we have
>>> now.
>>

While technically not really wrong, I wouldn't say this is true either.

There's no real pinctrl IP address space on Rockchip SoCs (at least the 
ones I worked on, so RK3399 and PX30), at least nothing delimited 
properly. The typical pinctrl duties are scattered all over two (more 
depending on the SoC maybe?) register address spaces, for PX30 and 
RK3399 they are called GRF and PMUGRF. Many, MANY, IPs actually have 
some registers to modify in those two register address spaces as well, 
c.f. all the rockchip,grf and rockchip,pmu properties all over the place.

The pinctrl driver does refer those two register address spaces via the 
aforementioned DT properties. Those two register address spaces are 
represented as syscon... because if I remember correctly that's how you 
are supposed to handle multiple devices on the same register address 
space where registers or even register bitfields are mixed for different 
IPs?

At the same time, IO domains also aren't in their own "real" address 
space, similar as to how pinctrl is handled in HW.

>> Then we should try to do this and fix any issues blocking us.
>>
>>> However, with that the pinctrl node would get the supplies that the IO
>>> domain node now has and we would never get into the probe of the pinctrl
>>> driver due to the circular dependencies.
>>
>>  From a fw_devlink perspective, the circular dependency shouldn't be a
>> problem. It's smart enough to recognize all cycle possibilities (since
>> 6.3) and not enforce ordering between nodes in a cycle.
>>
>> So, this is really only a matter of pinctrl not trying to do
>> regulator_get() in its probe function. You need to do the
>> regulator_get() when the pins that depend on the io-domain are
>> requested. And if the regulator isn't ready yet, return -EPROBE_DEFER?
> 
> That's basically what my series does already, I return -EPROBE_DEFER
> from the pinctrl driver when a pin is requested and the IO domain is not
> yet ready.
> 
>>
>> Is there something that prevents us from doing that?
> 
> No. We could do that, but it wouldn't buy us anthing. I am glad to hear
> that fw_devlink can break the circular dependencies. With this we could
> add the supplies to the pinctrl node and the pinctrl driver would still
> be probed.
> 
> With the IO domain supplies added to the pinctrl node our binding would
> be cleaner, but still we would have to defer probe of many requested
> pins until finally the I2C driver providing access to the PMIC comes

I don't think there's any way around the deferral "of many requested 
pins until finally the I2C driver providing access to the PMIC comes 
along", this is actually necessary.

> along. We also still need a "Do not defer probe for these pins" property
> in the pingrp needed for the I2C driver.
 >

Yes, this is the difficult part right now. In the RFC, I suggested to 
have an io-domains property per pinmux DT node:

"""
&pinctrl {
     group {
         pinmux {
              io-domains = <&io_domains>;
              rockchip,pins = <0 RK_PA0 0 &pcfg_pull_none>,
                          <3 RK_PB5 0 &pcfg_pull_none>;
         };
     };
};
"""

But this is very tedious for both SoC maintainers (though they would 
probably have to do it "only" once) AND for board maintainers, for each 
new pinmux they require. Since the SoC maintainer cannot know on which 
i2c (or spi?) bus the PMIC will be, they have two choices: either let 
board maintainers not forget to add the io-domains property to the 
i2c/spi pinmux nodes of all but the one to whcih the PMIC is attached, 
or have the board maintainers add a /delete-property/ io-domains to the 
proper i2c/spi pinmux node to which the PMIC is attached.

The first one is very error-prone, the second is not very liked by DT 
people I think (and also... well is a hack on DT level to manage a 
driver/subsystem issue).

Also on a side note, the current binding for the io-domains is a bit not 
granular enough as it represents the collection of IO domains on the 
same register address space, and you can have multiple ones. e.g. for 
RK3399 you have four in "grf"/"normal" IO domain, which makes the 
inter-dependencies unnecessarily complex (but that's probably tangent to 
the current problem in discussion).

> I would consider this being a way to cleanup the bindings, but not a
> solution at DT core level that Linus was aiming at.
> 
>>
>>>>
>>>> IIRC on Allwinner SoCs the PMIC pins don't have a separate power rail,
>>>> or if they do they almost certainly use the default I/O rail that is
>>>> always on, and so we omit it to work around the dependency cycle.
>>>
>>> I looked into sun50i as an example. This one has two pinctrl nodes, pio
>>> and r_pio. Only the former has supplies whereas the latter, where the
>>> PMIC is connected to, has (found in sun50i-a64-pinephone.dtsi):
>>>
>>> &r_pio {
>>>          /*
>>>           * FIXME: We can't add that supply for now since it would
>>>           * create a circular dependency between pinctrl, the regulator
>>>           * and the RSB Bus.
>>>           *
>>>           * vcc-pl-supply = <&reg_aldo2>;
>>>           */
>>> };
>>>
>>> At least it show me that I am not the first one who has this problem ;)
>>>
>>> We could add the supplies to the pingroup subnodes of the pinctrl driver
>>> to avoid that, but as Saravana already menioned, that would feel like
>>> overkill.
>>

I think this is actually a somewhat bad idea. Let me explain.

Nothing prevents the user to create a new DT node with two pins from 
different IO domains. e.g. I could very well have the following:

"""
&pinctrl {
     group {
         two_iodomain_mux {
              rockchip,pins = <0 RK_PA0 0 &pcfg_pull_none>,
                          <3 RK_PB5 0 &pcfg_pull_none>;
         };
     };
};
"""

for example if I have a device that uses GPIO0_A0 and GPIO3_B5 as gpios 
and I need to configure their pinconf appropriately.

So from this, I guess we'd need to support multiple io-domains per node 
(don't know the proper pinctrl subsystem name for that one sorry, the 
two_iodomain_mux one in the above example).

We could also now group pinmux nodes by their io-domain, e.g.:

"""
&pinctrl {
     bt656-io-domain {
         power-supply = <&whatever>;

         only_pinmuxes_from_bt656 {
         };

         only_pinmuxes_from_bt656_2 {
         };
     };
     pmu1830-io-domain {
         power-supply = <&something>;

         only_pinmuxes_from_pmu1830 {
         };

         only_pinmuxes_from_pmu1830_2 {
         };
     };
     [...]
};
"""

This means we would need to go through all existing pinmux definition on 
rockchip devices and check if they belong to the same io domain and if 
they don't, split them in one or more pinmuxes for example.

Also, I think it'd be easier to ask board maintainers to only add a 
power-supply property to all io-domains rather than to each and every 
pinmux.

We could probably enforce that no subgroup other than the one named 
after the ones named after the io-domain can be created on the driver 
level as well. Not sure if it's wise but we could probably also check 
that within a pingroup only pinmuxes belonging to the io-domain are listed.

>> So my comment yesterday was that it'd be an overkill to make every
>> struct pin_desc into a device. But if you can split that rockchip
>> pinctrl into two devices, that should be okay and definitely not an
>> overkill.
>>
>> Maybe something like:
>>
>> pinctrl {
>>      compatible = "rockchip,rk3568-pinctrl";
>>      i2c0 {
>>                  /omit-if-no-ref/
>>                  i2c0_xfer: i2c0-xfer {
>>                          rockchip,pins =
>>                                  /* i2c0_scl */
>>                                  <0 RK_PB1 1 &pcfg_pull_none_smt>,
>>                                  /* i2c0_sda */
>>                                  <0 RK_PB2 1 &pcfg_pull_none_smt>;
>>                  };
>>      }
>>      ...
>>      ...
>>      pinctrl-io {
>>          compatible = "rockchip,rk3568-pinctrl-io";
>>          pmuio1-supply = <&vcc3v3_pmu>;
>>          cam {
>>              ....
>>          }
>>          ....
>>          ....
>> }
>>
>> So pinctrl will probe successfully and add it's child device
>> pinctrl-io. i2c0 will probe once pinctrl is available. Then eventually
>> the regulator will probe. And after all that, pinctrl-io would probe.
>>
>> This has no cycles and IMHO represents the hardware accurately. You
>> have a pinctrl block and there's a sub component of it (pinctrl-io)
>> that works differently and has additional dependencies.
>>
>> Any thoughts on this?
> 

Just to be clear that whether i2c0 is where the PMIC is is HW dependent, 
so we cannot have that in the main SoC dtsi (on Rockchip we typically 
have a bunch of those in the main SoC dtsi to avoid common nodes to be 
copy-pasted all over the place).

> By making the IO domain device a child node of the pinctrl node we
> wouldn't need a phandle from the pinctrl node to the IO domain node
> anymore, but apart from that the approach is equivalent to what we have
> already.
> 

Indeed, just one less item in the cyclic dependency but it's still there.

> Given that fw_devlink allows us to add the supplies directly to the
> pinctrl node, I would prefer doing that. But as said, it doesn't solve
> the problem.
> 

Absolutely.

The issue is that we have pinctrl that needs to probe for anything to 
work really.

Considering that pinctrl pingroups requires (on the HW level) to be 
linked to an IO domain to be working properly, the IO domain depending 
on a regulator (which can have different voltages at runtime, hence why 
this link is absolutely critical to not damage the SoC by having the IO 
domain configured for a different voltage than provided by its 
regulator), which is on a bus (i2c/spi) that needs a specific pinmux in 
order to work.

Saravana gave one example of the cyclic dependency on the DT level 
earlier. The issue isn't the DT-part of the cyclic dependency, it's that 
the drivers actually also have this cyclic dependency, the i2c/spi 
controller via its pinctrl default state and the pinctrl driver with a 
dependency on a PMIC driver that could'nt have been probed yet because 
its on the i2c bus. I don't see how we can not have a special property 
in the DT binding for ignoring this cyclic dependency for one specific 
loop. We cannot hardcode the driver to look for a specific compatible or 
something like that because this is HW dependent, there's no rule on 
which i2c/spi bus one needs to put their PMIC on. Maybe we could try to 
look for the PMIC on child nodes of consumers of pinctrl (if possible 
only when a cyclic dependency is detected) and bypass this dependency on 
the regulator? Or maybe check if the parent of the PMIC of the IO domain 
of the currently requested pingroup is the same as the consumer of the 
currently requested pinmux within this pingroup?

I'm also wondering how this would play out if the PMIC isn't supplying 
power to the IO domain the bus controller to which it's connected... but 
I guess that's a HW design issue :)

It's Friday evening here so hopefully my brain wasn't already on weekend 
mode and I could convey properly everything I had in mind.

Cheers,
Quentin
