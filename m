Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3117D9EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjJ0RPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbjJ0RPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:15:24 -0400
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5920A5FC9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 10:06:16 -0700 (PDT)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.19.202])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id D380A105C805A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 17:05:22 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.187.19])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 8C877100004D3;
        Fri, 27 Oct 2023 17:04:52 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1698426211.052000
X-TM-MAIL-UUID: 369fa8bd-b53d-4b97-87a6-4cace715956d
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 0CE1C100010CF;
        Fri, 27 Oct 2023 17:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3Z7OuGjQKRhh9RrySOUrzuwzaR+1pxl25ogfBvTDHZ2MgyDHfit7ybqiylqNcSjlVsPASUEzGaDMOmKQ4s64vYP7dRBH7/Pmdh7hcXUolUVxd0E9cy8ozxZnAjo9urQM5SKR25Mh7/y2UpnyPp5HpR1LkGThbmEOcRZmqewupPpJr0t0dTbfMk8O7gZNvHxb8rEhZm+OpE6wDlBmHYhXXMY3qcSElet8wWbqXjIZJf8K/6mHb8dhLVz5li93cfYwpuxM91VRswm3NXVl+c/tNScFepqGEW+V8ek6hlHkjAc0By5jl/lTPenFj7XMF5x5u11tF5oK7V/sWue0ysEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rONsK28WO5/B7W/NuICUQ3zbZa7Ma5HPEmqakPa9dmY=;
 b=DGavP2znNSGXzyBG1nSsr4L6J3KK9dpsHZ3GL+utnMpI9gGa28sRIiQYqxHf4N9CYqDhI/qPoLU95SDtZ5FM5WGQ1mF2PLuhnGagAUtyv/3xV/A2ELr1NWkcAPmcw2Pr5QgsOlwiPJOjEUk5gUO/7PRD3Qex1oCuL4Sow3H5seMNQtMiySUIx1Y++AMHVmHptWFuIbPmyeEaLtBPUaJzsrsrv/XGnavE/yjo3/Dr9hVNGqxT6VNeusUBhroZxfMpSnKc/qG7OjbJEaTOMZDO2EAO9w6phg+ulgkX8Potbq20W/4RY0zJR3Yn4ux9YZvkmd7as9nGYnwPMmBqnHhUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <48327bf4-d656-7b1e-7112-bad29d934eb1@opensynergy.com>
Date:   Fri, 27 Oct 2023 19:03:28 +0200
Subject: Re: [RFC PATCH] Virtio SPI Linux driver.
To:     Mark Brown <broonie@kernel.org>
Cc:     virtio-dev@lists.oasis-open.org,
        Haixu Cui <quic_haixcui@quicinc.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
 <ZTvrEFjL3nCRRQnY@finisterre.sirena.org.uk>
Content-Language: en-US
From:   Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <ZTvrEFjL3nCRRQnY@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB3400:EE_|FR0P281MB1611:EE_
X-MS-Office365-Filtering-Correlation-Id: bfcfab22-a723-4dca-67f1-08dbd70ea4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2KRBxQ2bI33EVCBAzeJKe25onUKsz87oOLJ3W/5uc297FDmWTWsJ2GMaVwS/1FvrnNaTqF7lJCFIWhBPlBAwrbQ9LkMB9SEahWEvcl8qd44isNBjPsrd2ByemWsB7PoD8eOnBt7vCNA9wvjxwuIJq7SVHfznLjsphLu8KWUR0u+5tz41hzoJvuG00i1R6Tnj4XGEQ1mkyWkmLjEH/0fgm5u9epkQGPH/na0Awu5EP7J2lTyNqd8xjEKRFpLW65W0nDPephsdEisZ/EIxkCmGKfj4StjZ2AtgUQgeY1hYfOHblnuZ24DZS/Q9XoeJpwQN27w6LBy8L9ikNvc65eP/JE7O/n4cRYFfxdAhkq5vGpG+vu/yLYIbeZOrU4CEbHfmt8xNi/meSIFEr9TIhyI+S2Nlpsl7ClRgUOoOnIaAZcUcHIyYm0SgrDKvJS/K6GDa+4AZg3QveHcUWt68ym2m3T10xYkceD4rjMI0mww23yZVRP6LfMFu2fUHeIp4jFws+csHsi2TMtI0CjNm5DEOS2SHD+3ZHIbIZLRZRONDaRp+/ac9fnKJHyPPVdLOFvvPxXPKnsmJ7QCl1bIpRan5a9yLORCjsZjsYXa60sLN3ZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39840400004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(53546011)(966005)(83380400001)(478600001)(26005)(107886003)(2616005)(2906002)(4744005)(5660300002)(66476007)(54906003)(6916009)(42186006)(44832011)(66946007)(41300700001)(8676002)(4326008)(8936002)(316002)(86362001)(31696002)(36756003)(38100700002)(66556008)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?empBUkQ1TU8vanVCUVFTZDhXUEUwWGFLQmtaUjR0Q3kwa3ZFTmJUWjJsTzF1?=
 =?utf-8?B?R3NGZE9ZdXZRZFRwaVlkSDVqNFk4akFiMVdtNjZkME9jQ0hSQURQNXQzZHk2?=
 =?utf-8?B?QW5tSGNHekJsdlpYN29lOUNTVk1Ec0JraDRncjRUTms0ZXVxbnoydDBJUHJj?=
 =?utf-8?B?YUpBUXJ0Tm1hR0VGVzM5ZEt2N01hMXhlTE1zVkR2WUVvZGExclNmVnNyNUt2?=
 =?utf-8?B?YlU3OWhBYUVyUGozMm5NbGF4SllmZ1diNHdjR2M4VmlYc0cvRFQ4Wk5NMjZw?=
 =?utf-8?B?UVZsWTNJZEpVV1dyc28zQWR1a0ROWGNlR3NPN3N5eWtIb2kxV3M1N29aMm1E?=
 =?utf-8?B?MVNVZFgyS29tbmk3VnRsZ2JGUy9ra2dYbzA5TG1sclk0SkVYQllPdy93eWw3?=
 =?utf-8?B?YUYvZFAyS0ZBY1hMck13ZTVkRzQzWFNPRVMyRGVxOVJDVEMwK2o0TmdiS0tn?=
 =?utf-8?B?LytuTVplSUg2UGVvSjZUUnZDNVJiSDBaczJ5ODV0UWRrM3hOZmNQbHFYd2Vm?=
 =?utf-8?B?b2xMRkZ6SjhCNHZ0c1lRK3NWZGsxTXdWM1g5aVdXRUMydjlUN2VFTnd4OFNE?=
 =?utf-8?B?OEMvQUYrM3NmNGQzN0dFWHRVVE91cVlKeFJnSEhqTklmS0NuTzhaam1Lb1BM?=
 =?utf-8?B?NlNKeEJXbHhqWUREcTk5ZjdOaFlCNS9pSHhuOHR6ZFlSVTNwQzNjMG56czJ2?=
 =?utf-8?B?OXVaamFia3FzQjJHU2ExTzdOdVk2WWdvN1dMeWYrenZMQk5FUkNvTzk1Y1Y0?=
 =?utf-8?B?a2szUWVtVzRqTFcrUnRMSTZtWU44MGlMNEtQQThFOXQ3Vk9xZitaSDNGelNn?=
 =?utf-8?B?T29SblYySkJ3OWZsUm95RWZ3S25MeGY1a3QwUnNUdnI2VCtMK1Jud1ZaZDJz?=
 =?utf-8?B?WVdDY1Y1QVoxcHVhbExkNmFnZkdwV3M4UE45TDVrT2lXVjFrbE9leDBPclAr?=
 =?utf-8?B?RlZtN3E4ZDBPL282UURCMTRQSVRFa1E4L2loTWxCOThoWS93NUFzMU5GUlZn?=
 =?utf-8?B?aGU3YzR3cTBDQlVVeWNRQ3E0dXZ1SFNvYUM3bGhWaUFKSnR2WVRaNFo0Nzhn?=
 =?utf-8?B?YTA1YzlIbEoybXQ4SVZPVExFck1sMGhVTFlQVmhQb2hCZHBxMXJCaEFPVHgr?=
 =?utf-8?B?TGRUK05LcFNuNHlPYUUxNHRzOEMvNDU0VmxaWmhhQkFOZUJPSXdFS21jZmJt?=
 =?utf-8?B?T295dlI3UnhmTElkRzMrdkZhaDVNUnY3aHJzTGtLaEdnOUM4R0JXbVJxM0xz?=
 =?utf-8?B?bXdqbXhyUFBqMjg5UllwTDhuZ3RWQ2w1ajlwNVBLM2FGY2xDS1VxRElMK2VJ?=
 =?utf-8?B?cFF5WkNGMWFYYWF3a1dIcEZFcTI1aTZvVTd1QktVTGFncnZLZjFpNDl6MVFL?=
 =?utf-8?B?cXN0MDZTdk14ZWt1UXhiSE9QdjQ5U3VGeXVrL2IxNW9CZTRBRXgrdUFmYzFs?=
 =?utf-8?B?YkxQVW9MZUJKR0hBMzFDdWsvc0xBaVNaMjU0eDE5NWpkZ0NtbEUzN0lWWmRa?=
 =?utf-8?B?R1BEZUtWRjBPU3RyUFVUUHltOHNreCtQZnRENEtYanRXYmxIanFjU2VtRUQz?=
 =?utf-8?B?SW9qdFRrTzZYVkttc0xscVZqQlB2Y3BtWXZOMmtsSlVtWWNOTWN0bjRieDZ5?=
 =?utf-8?B?ZHYwbXR5bjIybGloQW12cm5oTm1hRGdaaE93MFE3c1M1bXV0aTl4cWJKeDND?=
 =?utf-8?B?OHY1SWZDWUZaQlh1cS8xTm9QblRDWHc1bFMwMGZjNkRTSkhLMUNHS3hPZEFz?=
 =?utf-8?B?cjBIeGRMbFhtejd1K2FMRDc3K205RlNaMTZOZUhBUHVOaC9BSU1iSnNLMk9Z?=
 =?utf-8?B?aVBidjFIQTRMa2hibGxtSjFtSFNtdTNJUDNLSXdDVS9BRFZWdmdTWDEwdGJL?=
 =?utf-8?B?M1NoUjNHQkJOL0gzMVpTY0dveGpOS2x2RW9RZ2xMQTNyY3cxL0J3d25YOVBN?=
 =?utf-8?B?SHJicEVaVXRZL09xaDd1Q2dVRWh5NmlOeTFzQzM0QzZpTEZQelJqNVVETzg5?=
 =?utf-8?B?MStqZWR6RDQ5b3NGNDNkZEtxWUdCRjZzVzVsckgwUk43UCtQOGJJeHZJR0lX?=
 =?utf-8?B?amtBaS81MWUxczlYRllpcWdSYVN1bnpXTkJkSDBwVG5GL01HR0NoRkJrK3Bv?=
 =?utf-8?Q?t00CPS7VqFKs5e5VOS6cHg3Da?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcfab22-a723-4dca-67f1-08dbd70ea4cb
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB3400.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 17:03:29.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzD5Ez+0lDgxOeenW7cOzTxzoEMR3g8qE42rDif7n+LrrLe9FpZeolUaGYA7mCPBnznMW4vpr9tWzdV5Wt1Pag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1611
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27962.001
X-TMASE-Result: 10--2.480600-4.000000
X-TMASE-MatchedRID: 5+1rHnqhWURTzAVQ78TKJRhvdi92BBAu5f2pKgY/c031Rudqy9AHLUdl
        IucSc2Ae38ep2/it9UoaqShqHxesm4n8kUCxEWNKQj0AQ98QP92jg0lrtKMWyg2h/xVLZG6H5aA
        6lI7RRJoT5wrvg3IkAy0bcDo8j/RXoli4ZoiOHT9+ICquNi0WJMAKpuoiA4Jv3dYYRFg/ctQFEO
        TGeBft3ivOFLOWE2sfftwZ3X11IV0=
X-TMASE-XGENCLOUD: 0cf53c47-ef32-437d-a918-9346dfd84667-0-0-200-0
X-TM-Deliver-Signature: DA9EAA4F2A1B91B3D366247FDE897E1A
X-TM-Addin-Auth: GevSYh7gp5WMRRzM6m+qTMG8NUwG46DaCwKbmqCILUnZ9yv+2kB9Ned0u6/
        v/nfw1Yq0wAZaifucnmx23LQmtIaTYQAaGqSOMUpUisNXQD3VnwEFwjPmxyxcegogcX+SOZRfC6
        umgiD0ELgsX2b8TmrukhDzY16/Rk2AN4tNiYwwKRrH1AspG+qaB88dIJZ96PsdptfFYtgX94Yz5
        tQHyTSHcDg5ers1BZNINhgP0MEyoRAJdByoJhNQk7pv+prp8WzjINsm5G4JptekgWNvRIUhxUQx
        oE1fTIZS5G6DuTM=.FUKLn4IGauTKMpcF71hH+9I9lQ1X/dGlGZ0yqlnzmhDEX9AKOeXO+x5SWW
        c+J1qgmaa21OTUoGVinVuqb4ZMRnVh2Eqmx1+KYzWCA7p0xcWlyLaH6bZhsd1YiAZNh5tCRC9kx
        G2b+lZYkEsjxQSjwt+fKbeXToECVFrp2N0vJYq+MSzoHMTt/hSD+g9L5vTzlXaztKfHnYYYOJRf
        F56ab6atCTNBBH57BSA/P4SgzbmkxRI7uvz6/ebntItsvjQUxTHcDSVVNjzMB593xct1fpGky9y
        6MOPRH7yQwKNasFTtg19cc2vloMoHY+bZZbS2evrblmr/XmHD3OY41K7QMQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1698426292;
        bh=rONsK28WO5/B7W/NuICUQ3zbZa7Ma5HPEmqakPa9dmY=; l=404;
        h=Date:To:From;
        b=PLBNVHs9gg0/eWswle1/pZWwrXjjkSROB8k+B8LDe+NnU2TmvaOlo/YzUayNkysiO
         uc0/iENdyuRT/hNG0ug/Ixdrv7k/Oc1WeajjPbo6oQQ6qAt8XsfH+dXULyFcLiwylB
         kWFwTpM+/qeSZfQh2Rp1DYMYkHD3mxYdKpuJh5XwiLOa49jw3eqID1v/ukcPPxQcx5
         CT6ALFiFTDf/O+ltgaUVovOr4HlbEWa2Akh0Jrw9NLpkWN6bgsl1rPsKznzpvC4+ce
         l8OXLI12ZU0S8FWjIQvTa4uq/sNKtdU26sHRF6qQd2cx9qIhEHBzGoIX9DMo5avhOO
         5v7wo0a7CLnvQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.23 18:53, Mark Brown wrote:
> On Fri, Oct 27, 2023 at 06:10:13PM +0200, Harald Mommer wrote:
>
>> This is a virtio SPI Linux driver which is intended to be compliant with
>> the proposed virtio SPI draft specification V4.
> Do you have any pointers to the drafts?

There is a copy to the latest V4 draft at

https://lore.kernel.org/all/20231024125346.23546-1-quic_haixcui@quicinc.com/


