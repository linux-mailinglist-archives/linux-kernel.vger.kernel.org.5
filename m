Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A6880F5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376753AbjLLS6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376678AbjLLS6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:58:12 -0500
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFDE98
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:58:14 -0800 (PST)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.171.117])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 47FED100004D2;
        Tue, 12 Dec 2023 18:58:12 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1702407491.890000
X-TM-MAIL-UUID: 4b7a9443-1858-47f2-9840-e3409d238c97
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id D985110000314;
        Tue, 12 Dec 2023 18:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsZiN6elbn85gEi6NwJdzUudSbyv+7EYhUT0zQud6HOwxiveArqpyyu72ZBbhui+kyBOmBOXyjKTl21t79jgfzztypiBB6xfWPC1vyuUMF3ynaCb1z5oFA2IdkL0LHVTDqGEMAkpmu0kRrSntPGVUASn68rS91OULXaYX/2Sv9ei9M04dpxkxTUnScs38VsHOE6C5QaXl7RFcvqd1xJmoa1PdQuX9dzlRD1B7Kn4TR4RGiTm1XNWAn0/YFW3pbvjs3IWSOsgrBUU90fcswz+c/2IGfatqymiqc3Z8toLMPyROen4tlIke+JujSBfXgq0cgndtLhWVY6Qs10vMI0trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg/Q152vbJRrrKEgaHzvif1OtY+/jTBza3InwFChevg=;
 b=eph7T+3HeISajDFKWEadYLfYr8qawV04JsgKdDjABCYeJBXzQKI81JgW2H1G0KIXJhfrr9e0yhkW6YhlMhGim3j7mR1vPRcmqlcHJ802ApN/FPJndc6Mwj+P9uQLs6wqSLmAfaCxLRmhgvI6mGo4JqU1RRU/wlqu1Z88PMjRSPf+vjy68KCJqTLh57oH1RUhjxh+x5+ZOJ6CgKKI5gIbe230pERtm6HJ1LsDjeWtCw7xLBmLXLUgBQVwptWa42OpTN39JdsKev/Mqyz9xzM3jmQfQsvoOZTwwHsZEJ1XL0Iofo0bfFZgSrSQhM1k75uh7abecZhuqBtWhrjaEcJIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <87f06ede-ac54-48cd-8135-ea2c8f5548f3@opensynergy.com>
Date:   Tue, 12 Dec 2023 19:58:08 +0100
Subject: Re: [virtio-dev] [RFC PATCH v1 2/3] virtio-spi: Add virtio-spi.h (V4
 draft specification).
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     virtio-dev@lists.oasis-open.org,
        Haixu Cui <quic_haixcui@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harald.Mommer@gmail.com,
        quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
 <20231027161016.26625-3-Harald.Mommer@opensynergy.com>
 <20231212103411.wbjmr5mefmxfnsib@vireshk-i7>
Content-Language: en-US
From:   Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <20231212103411.wbjmr5mefmxfnsib@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::16) To BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:9e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEUP281MB3414:EE_|FRYP281MB2537:EE_
X-MS-Office365-Filtering-Correlation-Id: 46fcbff8-41dc-4ff0-ad0f-08dbfb4448db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MziDqtEOqn0oMjfGexPaNegLwFQFk9G6ebBDykrZQHyTdMjQmc7vsPCL0gy0ieel5zdhRO6bzfdBALQUp86N88dqXvnfzKJqPueD2IzFSLlHAqbLOFFwMdCG7TikXdE9hIT7q+sYIdxSXbyEBwnUTAGOLMxoIMEs+R+faYKyo1l3KoH5bTfHqq5ob8+dHl/Zfi3dTUAE4nUXRE9z9ZK/GGjaAdcJL2tlcMSSJN4qaK5r7xmWF+4fPAWQO64RdAmZUbeg1L3kzUuBRzR3Kz59QId7J4I8+Vog8dFZZiZhJyD+GqWYO8MhX2dwJNSIEl8wBKz5niuz3akPnPtciCFNnTG00csndRV2JHz48VI1dsd+KpIj8QsLGicXo9I+iUguPiZJB9kyHZCoPrmdORka3meTS1GRG549mhGSwANWsaL0031HDd8WgmaDPkQ/i3nCMR0swEs1KnEU5ucYyTpvDfq5kYba5sRtOgLrdtHo0j2N9JEob6yAEEmGhKPE0ruSR6Kk3RcNMjZgxg8Jn1yJhHgyW/aDQ0l7Q/h8YILLphQoa19BJvXwBLYskVpjGGGiQqMj7lzCyPw6ZmuovWhvBUWrbAtBQubZbkLZG3Qd8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39840400004)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(41300700001)(2906002)(7416002)(5660300002)(44832011)(4326008)(8676002)(8936002)(66556008)(66476007)(66946007)(83380400001)(6916009)(42186006)(54906003)(316002)(86362001)(31696002)(38100700002)(2616005)(53546011)(478600001)(36756003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlkyTFVPY2h4NktxWSt1N2JaK2xsQXNDTGhUaGluZytDc3hrYVMxNDUvRlc5?=
 =?utf-8?B?c2dXcXZIdVZMVTNoTDJ4Ui9GOS92Q1pSNHdwNkRDSm9RVWNWRFJ4MkpQemN0?=
 =?utf-8?B?R29SaUNQWVYrTUxxMm9aaVBZTTgvbGxpcFdjMWoxVmtjZlpGeWlENFBsSk1C?=
 =?utf-8?B?UEdma0ZqOFpmS3RMNlNxamlvTnRJZ3IxMmpRdDN0OXFtM1VPOEg3Q0ZkczVJ?=
 =?utf-8?B?UVBONzhIKzBnUWpjU2FiWGo4c3daWnEzSDFIV2dNeHA2cVQ3OFFkVjUwd3pv?=
 =?utf-8?B?NEF3YzNXTDhCdkFJVVkzOEhwc2REeWxrMnBCczZOSkRMc0FhdVRKSE5hNGxt?=
 =?utf-8?B?T3A3eWpYeCtzQkE0K1FleE5GcXdMWmJwYmxpMlJ6ZGhNUzB6ZG84WnlOR2t1?=
 =?utf-8?B?TEpLdkoxQ21CREp5T0tLdS9sKyt5Q29xSUdVbXlndGZWVGFDOGxiQVZ4UkN0?=
 =?utf-8?B?YndremNPOTdZVXRDbFB1SkRIM0I4ZGxhdUx2OGd1SE9BOWVNK1lqVXN3RXdR?=
 =?utf-8?B?RDd3VmJEU0ZtMkdUTERXMFlSdGkxVnJteVJhdzRabm1OTEFVcDV5ZUxFVm1Q?=
 =?utf-8?B?aUhNMXY0MnllWHhscTJjbWRnMFQ4ejdRVHJVZU1EUFdIR0pGeFhIS3NkSWN5?=
 =?utf-8?B?Z1NLWS9iY2QrYVBreTB0WVJOZ0RNTFd1UnZDUTJPMnJwaTJQd2Y1SURXMVVr?=
 =?utf-8?B?aURYVTdTVllJS25CeVFoYmZJdFVVYkxvVXVlUVg1VXNPSnNEZ2RWYmxJNWNk?=
 =?utf-8?B?akRiKzBwR0lybmpiQlB2aUZVOWM3VS9DQXhKaDlwU3JOckxleVUxVDNOLzRz?=
 =?utf-8?B?aVpkSVhtYzQ2Wk1EZENNRjRHRDg0bjdybHVmL0srRHllM1FEMERNeUNVWk8r?=
 =?utf-8?B?cDM0VEZyWkI2WHRVdzhqekZCdmcvOXJLbFRUUnRab2lZeDZCem5jNlhLUDQ2?=
 =?utf-8?B?MlhRcDRtZkxYNXdGMmEvMWlIOEtJa1RGNlJ0T0VsRFQzMFN3VldTVExTc3hw?=
 =?utf-8?B?d1pUVkxJUTN5Mm00ZFRyc2dHZVArYzdkelZ2S21xVWRocEhBNjFzZitoNzhT?=
 =?utf-8?B?THBqSW9JVHo1RjRySmpZb2hxUllOZUoyUHhpSVdleVlQTUFmOEZCMlJTNCtm?=
 =?utf-8?B?VlQ4YkQvSS80SWpFeWZrVmVEbTNEak9oZ3B1d1Z4dGhLQlUra0hoc1NiU3E1?=
 =?utf-8?B?dlNUNmF2dXJydUZJQVhGSkNlejZReEhXcGtvZmF3RXhsOXRXVStpT0R3RHds?=
 =?utf-8?B?aDhqV3JrYWhDNHlyWVA0cHRaODJWY2Ixa2ZzTlB4Ym1RQ0V0Z2RwNHYzWWVn?=
 =?utf-8?B?ejU2bDhOUkl5RFJIZGRqOFRuaTkwZTQrOFhpa3MxRU9LWlp2MU9DeEtJUklF?=
 =?utf-8?B?cVV0VzZGK25DS25kYkRidTFZOGo5ZEswNkprRndNUzBMRFd2dHh1aGp3YWFB?=
 =?utf-8?B?WE93bHZxeHV5Y3BHMUVqWGovWjlVbmE5S1g1dU9pU0VCYVZBTUFwYk9lUmxH?=
 =?utf-8?B?K3l4RFFjVG95elptY1ArNEpTM2dQY01ha1loMEVKRHZMSW4zV1EzdDNtWFMz?=
 =?utf-8?B?QzZDa1djeEMrMko0c1lXajMrekUrbk1ReXV6ZzcyYWNGZmdhUGphVHNyOHNu?=
 =?utf-8?B?ekdQSHF2VXA4K3VpSFRWZlAyVk5CMCtlMVFrUUlCcVBldWkwMTY3eHJGR2w1?=
 =?utf-8?B?RzFDdEtreUhYUVVFbldSdkVJMGhMcnNITWNxZzBpRXhQMXh3cnRwdkl0TERU?=
 =?utf-8?B?MnhNRHZ6RUN3b2dGTm5xSFNBdml4QWhTbTVBT0pwUGw4a2dkZUExcENVRzgx?=
 =?utf-8?B?TmtBeUFGWjk4b2Q3QXRJRXFKS0hxdEpndmEwaGYyT1NZL0ZIWUxoNWpza2xl?=
 =?utf-8?B?d0VXR2RUUGNlemZZR0E3WWNVVGFsbjFoSGJGRHZVaDhTVzVVTGxScCtTYU5N?=
 =?utf-8?B?bW5OQ0N0WktlaWM2d2E4Mm1DNTVTeWNEOG9RNllwTlFqNm45Z3NrbUZkcDky?=
 =?utf-8?B?YTRkOUtzeVVmc1BTWVd4UVRML2JYM2dzQlBidnE0ZnUyMnNjR0Z2R2Q2Mm53?=
 =?utf-8?B?cmVhU0oweHp0dnRqbHlVTnVGd1VEbGpmRFQ1VkxabHNnNE1tS1Z3NGlpUXZE?=
 =?utf-8?Q?azBblAJddbL/gthGSHCyh2d3q?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fcbff8-41dc-4ff0-ad0f-08dbfb4448db
X-MS-Exchange-CrossTenant-AuthSource: BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 18:58:10.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WgOh+6/T3vYpbSapm9d7rfbXtq3uU+BMLa2G0dElPSGtEKrHFX9G+ndozdBN3NnU76r9Ps6wU9WfZCRNwxT37A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2537
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28054.001
X-TMASE-Result: 10--29.107000-4.000000
X-TMASE-MatchedRID: oll/cJ/dUC75ETspAEX/ngw4DIWv1jSVpolXqDXvwwr6ZqDtcfRPaZ0Q
        FAkvwQa18P2WikvSM6PxjbRd+0PYZvtoM7gJNNcB0RneM2u5ms8vnJK5AAeZkG8+ap1bd9X3mk5
        bHLUSS5Yo8MUoOsp8k9pxddmA5icRB3IvJI6WGyoZD7bjq+6lMGzY00haS8Qo2ubnxCjreJ/nq/
        Q0Vm6yzRHANFoXrZpZNGeRmiR9N6ORCAvd7LgmuQlnZD3sv7ndnVW5D6U48fdNxwE8nXnrj+WHg
        sveKOjcLf5MGGJoSOZOGMHZ/S9RXtWj8AOJGZwlC+mr+2Lx3HzG3G6LZ224QpVWWV8EQExBpBu7
        zSJhKcyQu5n44sF57/KVnX2qkQfVYqM4fMxms9UMfiba6PAK28KMLGyUZCs5qWgfIMWloSzhI6E
        iM5MgH78LjLfFjbHuQSj8JfMvdReFxY+3yd3F2iJPlyIC6RpANIT72OEr+MhSb0H/ldHBOsnuq2
        BSLvwEL1fM/YsPjGqOb+axUc71zL3Nevci1C/eeJchdZcr1K0/pTtjH60tlq6kz9EduW8cyPolN
        lf3VVR8F50he0LXP7RlIGrjfx+OKMb4+/ZxcNFY2dZJE6ken6cy8JAFrh85ujBC2MOFc29myY2r
        AmnM4uSyDmhxkj24rq+0RE91lFLRueOV2LpTkl7l57ki0S38vUwFctMuPBsweIyZbRlQ2yzecBj
        190z12HlzhM3zNtnRKDuafjrn+ZrjKaOVysNvOfEmq6feyfMlCGssfkpInQ==
X-TMASE-XGENCLOUD: 2ce0aa78-d15b-4d95-a7f2-68bd74eae77a-0-0-200-0
X-TM-Deliver-Signature: 135E19FCD3ABA8EBFA9F7AE213436E0A
X-TM-Addin-Auth: mix9aBHa42/G1GWRiG4nt0QaHn+rgbl74OT1ndGBmMlKRZjoKbzL/P3zFvS
        JTHEXhbNyRrDtONSfZabZmeb0BMq4J2YW0zeAvw6aH8x2jy5FirLf6eS9n1UhDAvoIQvF+ie5k6
        QuFTZ0j9QNpiI/4l5Yr+3YKVJo4n7K9HJbkhYIcYUE2KdxQx4H0gmF/iTHYs88roISzrbUWdHzI
        bh07mj9N4/TH7fYy2A3ZouN+4RfUriLwuMBWm/xmTRBBH0GwxdjLheoKJnyZAfHPq+qnX0aCNhy
        okjCkj1cXpcJfsg=.yKg3RHWMvI/wmf8ABOxFlK7TYVa1pn2JuW832WkTfdY9mihOgzl8QOE1Va
        mXrnaJjiWdjJqGlCkBTu+LXe/0uhEn1iYdqEbPSLs5SbGZrS2UK32rqDFGSGR6GC1LenjowVDLy
        ugbRWwvoZtcIQiBv0OyE2oYahad8zBvTiEcbhrk2OAcGJQ6MVXRJ5H//LIaBYWxgK/ONZx+H1mm
        DIIo5NWIMzJ/1eUhadLYSNvk0KOAVoHxZQ7z+1UhgEuaimTPU85WxdlHw+/pt/3wkepno10e7u3
        4BE8gRImAhX5O1CnQcYh92zXPudCri459nPpC0xgXJDw8mb9aMFvRLZQd0A==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1702407492;
        bh=hM78NYRybnuJ72itlCUnnUj4UhhbyPalWPdMEWmGGeg=; l=8225;
        h=Date:To:From;
        b=tAntlTNnDdh1aK4LBRmibu1HfhYvM13LucsLKjrGT03ukkhOR5KRCpXSEaj60MWod
         dlCxJajIqSjFnla+77IK96VuJuf3uDEUsNEFTwUBoPcX56hUhEtsJ6ZivW5lgm6++4
         h4FpmBQmd25Uq0X/RaX0kAUNdazV/GxEYHNFxY0o0Osy1Zi5FoxEdK9yGldev5j1DK
         UbMdPH15L+SwoaztIT1DG3Le/rVEBKlne9Fy0clntXvnNPOnL+O27bPxbQ6IF+9Yki
         Je5lVwEd2Y6wT6Q8oA5fabbw8CZElCKFpfFBy5EDjLAQTYo01tnN0H8jJkRTQ7dqtY
         M9WQpgrsLGoJw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viresh,

On 12.12.23 11:34, Viresh Kumar wrote:
> Hi Harald,
>
> I have reviewed the specifications changes recently and here is an
> attempt to go through the kernel code too.
>
> I hope you would be sending a new version soon as there are few
> changes in the spec already.

I'm working on V8. It's coming to an end, will still have to check some 
details but it's close. Internal review pending. Now there is a V9 and I 
will also have to look at this. Maybe I will send V8 and subsequently 
update to V9,

> On 27-10-23, 18:10, Harald Mommer wrote:
>> From: Harald Mommer <harald.mommer@opensynergy.com>
>>
>> Add initial virtio-spi.h header for virtio SPI. The header file is
>> compliant to the virtio SPI draft specification V4.
>>
>> Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
>> ---
>>   include/uapi/linux/virtio_spi.h | 130 ++++++++++++++++++++++++++++++++
>>   1 file changed, 130 insertions(+)
>>   create mode 100644 include/uapi/linux/virtio_spi.h
>>
>> diff --git a/include/uapi/linux/virtio_spi.h b/include/uapi/linux/virtio_spi.h
>> new file mode 100644
>> index 000000000000..9cf4335784ef
>> --- /dev/null
>> +++ b/include/uapi/linux/virtio_spi.h
>> @@ -0,0 +1,130 @@
>> +/* SPDX-License-Identifier: BSD-3-Clause */
> Maybe this should be:
>
> SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>
> ?
Looking into what others do here. virtio_blk.h, virtio_input.h and 
virtio_iommu.h for example: None is using GPL-2.0 here. virtio_iommu.h 
is using exactly the same header as we do.
>> +/*
>> + * Copyright (C) 2023 OpenSynergy GmbH
>> + */
>> +#ifndef _LINUX_VIRTIO_VIRTIO_SPI_H
>> +#define _LINUX_VIRTIO_VIRTIO_SPI_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/virtio_types.h>
>> +#include <linux/virtio_ids.h>
>> +#include <linux/virtio_config.h>
>> +
>> +// clang-format off
> Why do we want to avoid clang-format here ?
Will be removed in the V8+ version.
>> +/* Sample data on trailing clock edge */
>> +#define VIRTIO_SPI_CPHA (1u << 0)
>> +/* Clock is high when IDLE */
>> +#define VIRTIO_SPI_CPOL (1u << 1)
>> +/* Chip Select is active high */
>> +#define VIRTIO_SPI_CS_HIGH (1u << 2)
>> +/* Transmit LSB first */
>> +#define VIRTIO_SPI_MODE_LSB_FIRST (1u << 3)
>> +
>> +/*
>> + * Beware: From here on the bits do not match any more the Linux definitions!
>> + */
> Not sure if this is really required here. We are talking about the
> interface defined by the Virtio protocol here and there can be
> mismatch with Linux definitions.

This is a friendliness for implementers so that they get awake here and 
don't walk into a trap just because the first 4 definitions were 
identical by coincidence.No, it's not required, I can also let people 
let go into the trap. Including myself. But you have a point here as the 
header is not really Linux specific but Virtio specific. And I have 4 
BUILD_BUG_ON in the C source code.

=> Out with this here.

>> +/* Loopback mode */
>> +#define VIRTIO_SPI_MODE_LOOP (1u << 4)
>> +
>> +/* All config fields are read-only for the Virtio SPI driver */
>> +struct virtio_spi_config {
> Can you please add proper doc style comments for the structures ?
Checking my current code. This is updated in the V8 version.
>> +	/* /dev/spidev<bus_num>.CS. For Linux must be >= 0 and <= S16_MAX */
>> +	__le16 bus_num;
>> +	/* # of /dev/spidev<bus_num>.CS with CS=0..chip_select_max_number -1 */
>> +	__le16 chip_select_max_number;
>> +	/*
>> +	 * 0: physical SPI master doesn't support cs timing setting"
>> +	 * 1:_physical SPI master supports cs timing setting
>> +	 * TODO: Comment on this, unclear and naming not good!
>> +	 * Meant is probably word_delay_ns, cs_setup_ns and cs_delay_hold_ns
>> +	 * while cs_change_delay_inactive_ns may be supportable everywhere
>> +	 * Or all are meant. And the naming mismatch is the cs_ when the most
>> +	 * critical word_delay_ns which cannot be supported everywhere is also
>> +	 * affected.
>> +	 */
>> +	u8 cs_timing_setting_enable;
>> +	/* Alignment and future extension */
>> +	u8 reserved[3];
>> +};
>> +
>> +/*
>> + * @slave_id: chipselect index the SPI transfer used.
>> + *
>> + * @bits_per_word: the number of bits in each SPI transfer word.
>> + *
>> + * @cs_change: whether to deselect device after finishing this transfer
>> + *     before starting the next transfer, 0 means cs keep asserted and
>> + *     1 means cs deasserted then asserted again.
>> + *
>> + * @tx_nbits: bus width for write transfer.
>> + *     0,1: bus width is 1, also known as SINGLE
>> + *     2  : bus width is 2, also known as DUAL
>> + *     4  : bus width is 4, also known as QUAD
>> + *     8  : bus width is 8, also known as OCTAL
>> + *     other values are invalid.
>> + *
>> + * @rx_nbits: bus width for read transfer.
>> + *     0,1: bus width is 1, also known as SINGLE
>> + *     2  : bus width is 2, also known as DUAL
>> + *     4  : bus width is 4, also known as QUAD
>> + *     8  : bus width is 8, also known as OCTAL
>> + *     other values are invalid.
>> + *
>> + * @reserved: for future use.
>> + *
>> + * @mode: SPI transfer mode.
>> + *     bit 0: CPHA, determines the timing (i.e. phase) of the data
>> + *         bits relative to the clock pulses.For CPHA=0, the
>> + *         "out" side changes the data on the trailing edge of the
>> + *         preceding clock cycle, while the "in" side captures the data
>> + *         on (or shortly after) the leading edge of the clock cycle.
>> + *         For CPHA=1, the "out" side changes the data on the leading
>> + *         edge of the current clock cycle, while the "in" side
>> + *         captures the data on (or shortly after) the trailing edge of
>> + *         the clock cycle.
>> + *     bit 1: CPOL, determines the polarity of the clock. CPOL=0 is a
>> + *         clock which idles at 0, and each cycle consists of a pulse
>> + *         of 1. CPOL=1 is a clock which idles at 1, and each cycle
>> + *         consists of a pulse of 0.
>> + *     bit 2: CS_HIGH, if 1, chip select active high, else active low.
>> + *     bit 3: LSB_FIRST, determines per-word bits-on-wire, if 0, MSB
>> + *         first, else LSB first.
>> + *     bit 4: LOOP, loopback mode.
>> + *
>> + * @freq: the transfer speed in Hz.
>> + *
>> + * @word_delay_ns: delay to be inserted between consecutive words of a
>> + *     transfer, in ns unit.
>> + *
>> + * @cs_setup_ns: delay to be introduced after CS is asserted, in ns
>> + *     unit.
>> + *
>> + * @cs_delay_hold_ns: delay to be introduced before CS is deasserted
>> + *     for each transfer, in ns unit.
>> + *
>> + * @cs_change_delay_inactive_ns: delay to be introduced after CS is
>> + *     deasserted and before next asserted, in ns unit.
>> + */
>> +struct spi_transfer_head {
>> +	__u8 slave_id;
>> +	__u8 bits_per_word;
>> +	__u8 cs_change;
>> +	__u8 tx_nbits;
>> +	__u8 rx_nbits;
>> +	__u8 reserved[3];
>> +	__le32 mode;
>> +	__le32 freq;
>> +	__le32 word_delay_ns;
>> +	__le32 cs_setup_ns;
>> +	__le32 cs_delay_hold_ns;
>> +	__le32 cs_change_delay_inactive_ns;
>> +};
>> +
>> +struct spi_transfer_result {
>> +#define VIRTIO_SPI_TRANS_OK 0
>> +#define VIRTIO_SPI_TRANS_ERR 1
> Maybe just define them above the struct.

People do here things differently in the virtio headers. Regardless what 
I do I would get comments.

In most virtio headers the constants are defined above the struct. Which 
makes it more difficult to see which definition is meant for which 
member and leads to comments. virtio_net.h does it frequently in the way 
it's done here. In the V8 version there will be much more definitions in 
the middle of the structures for constants which are needed but only 
textually defined in the specification. For those constants it's 
desirable to have them close to the structure members for which they are 
meant. I think I should stick to the way virtio_net.h does it.

>> +	__u8 result;
>> +};
>> +// clang-format on
>> +
>> +#endif /* #ifndef _COQOS_VIRTIO_VIRTIO_SPI_H */
> s/_COQOS_VIRTIO_VIRTIO_SPI_H/_LINUX_VIRTIO_VIRTIO_SPI_H/
Needs to be fixed.

