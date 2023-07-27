Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FDF7650EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjG0KWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjG0KW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:22:26 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41A9272A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:22:15 -0700 (PDT)
Received: from 104.47.7.174_.trendmicro.com (unknown [172.21.162.221])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 3103B10000631;
        Thu, 27 Jul 2023 10:22:14 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1690453333.455000
X-TM-MAIL-UUID: 7129bc9c-a546-4fe4-bf0a-070d9ec65890
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.174])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 6F3D6100024EB;
        Thu, 27 Jul 2023 10:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OX79zNY/zBymnE0jhCeEzZzDIp+mWMmk/hwBkiJ9SLy54nTLwoQoKSjvs78t7UQnEEzksUjko+Gm0yz673Mcmk+v35EtGc9ZQQoBZTnpGeMYQznhHFBPVG1mn1/cJlWjQtqIj3glhS86ffJqRCDgT0D741j0yBUeesM4qBhF3y29NVDsX1YB/sAfRBdOwzLDfUewr3zHIXBhYtvWpNJqdvO9jiFEeNIs/eEwZf3qhEvBO0joL9oJHBc+lfHwh1DKdDcZCAiWb/Jw5ZO8G7bEs/pFD+bIj/awtdiwfZxzF9lPw/jjhCdaaNpmK6Iy/lWwBAcqG9heh3e+BlBNjs09CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXi5IeUqJO7at6JhgjWgTHJB3HvFpBeac7mxvaSkH4w=;
 b=c9aFhu/X3DROhynXNLZxVftCdOa4Z3wbHym+zjCqKiETt49Q3idqNNfvIYGymx8PVORrOJuk8s4IRpi3UxLRVJePQvdvdUnD+/dHxVe9DeaBVeNhg6H0MUMnJyYtx3JoeHqzQdPNLjwiBfVu1sneVqQMfIgQvwCeENSUpmlQqtD4GOuJ10lB6yeoiRtTvRa3uxzWG/ymoouoWqEqAbgmOI8Uo9ptW8MQyQu/i8C9s4MyW1jEOUZoH8cl9JocOgP70f+bZmZ8Bxl1je1rSDu//gWyTkdh+HDBFibKOnP3hp4sDwCh659PUdc6TTgajeNE/dXK6AGurWP9kvnsyRyLhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <0290012c-a419-40ac-ed8c-7708fc5a5dd0@opensynergy.com>
Date:   Thu, 27 Jul 2023 12:22:11 +0200
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230630171052.985577-1-peter.hilber@opensynergy.com>
 <20230630171052.985577-5-peter.hilber@opensynergy.com>
 <874jmlza3v.wl-maz@kernel.org>
Content-Language: en-US
Subject: Re: [RFC PATCH 4/7] clocksource: arm_arch_timer: Export counter type,
 clocksource
In-Reply-To: <874jmlza3v.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::7) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|FR3P281MB2800:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bed3422-e051-4b01-130e-08db8e8b57ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISRNtHDSgos3TiTMLZbUfyySiF5d7dBqt3j6jD2ofJTvRFxAM9C6UQ+1GELriXrJAh9zDnTm4t9+Hm1VBUwTGa3YEZqz609yn6+XL9tCyGMJ7xMBWVy5bQSUPfGF5T/aZL1Zh8wTKSSYLxcZ3Q4dqiWEBhZs/zEPvURy5gsN89V4LEI3hlM90KmUW8X0B8LF4rNTh8t6mQ7jxwYIEi3YD8LByIYim9i1EwuFqHfZkv+LZOsfIDUS8hkUE4Mmh2TkAcBxe/F1zIlsLaEhMio5H3XDT18LN5I6bLutxD1dlPx9MoalbbhYpzMUu3xDcPjnQJVk1QhqW3hSyqF3Wp6eOy60qS6HNn8RrBaVGG6nsU0GFstBlGlOGdUixeWXIodvq/VOR77qYovEwEV5s61x7VIWCGzV+hFMne9c+i+y/W3ruLfpyS8hyGTt0H2ZGlQyt9WE88p4N46LEgKUQCB+iB3RDa5obz0Du1LK/7EEkjinsEoFqJHihx9WNyAikFpOyQZ/KtTkzNK0IJjBFzSIjduNO/aO41b5NjHwZ6tEijILN95hS8lOe3Vn3x017iDG7Am/SOcryyxDozC7JlQBhtzsKQEcQ14LEC2lQ82sAH0ziTE64QD1vLSa8rLVY/Q9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39840400004)(376002)(136003)(346002)(366004)(451199021)(316002)(42186006)(966005)(54906003)(38100700002)(66946007)(66556008)(66476007)(4326008)(6916009)(478600001)(83380400001)(2616005)(44832011)(31696002)(36756003)(2906002)(31686004)(86362001)(41300700001)(53546011)(186003)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THg4Q1ludXQyY1NoUEE2ZzBTS2xNV3BEdVYvNDlva0U3TDVCRGdyVFE2amV4?=
 =?utf-8?B?cVc4cjJ3a0I3RGJXaUhNR21UOHJuVFp3NFVhU2xJNEpEWCtyNkFVZWhGZ0I2?=
 =?utf-8?B?aVVZbEFnczcrVW13TkdRaElmRzZqVXRmZ25LQnVicmVUTFVldlVRdmoreFhi?=
 =?utf-8?B?SU1YUHZ6SEdCWTI4YUZTdlBrbDlUUkxDQUc4cTBldTBqYXBTZnVBeFhWTmxF?=
 =?utf-8?B?ZHBwMG1zd3FIZ3B5QmZKTDN0bHFGMld2dFJzZENjMHlKYlRJMVlWTUFUbUhQ?=
 =?utf-8?B?SldLU1lndEt4VVRJV0poYzFHdXlTR0o4ekVDVG9xRXg2dXdodktIbE8yNXFW?=
 =?utf-8?B?WDJlQ1FSazIrQ1pmdllMVUtHb1d4M29BYnZ2S1M1bHlGQ1ZwYzV1VW9OZjJ4?=
 =?utf-8?B?b3Fab2xVMHJMMTgrdE00SG5UZGtoTVRmSVc4aGlJUDZZQVVuZmdGTEowUStu?=
 =?utf-8?B?R2VZcDl3eFd5bFd5V1NJSW9lN1ZiTVZBNks5eGRZb05YZ3RORzRZS045VTc3?=
 =?utf-8?B?TEd0bDhsa0lmRVdMUW11dXpndGMrakFRaTFQWnAvZXZFZVZzNkZrZ1Erd3gz?=
 =?utf-8?B?NWV0UTNRTEZVc3kyR1RxazhKcm9SdzN1UHEvNVB0RHdIaU9YdDV3R0dKMmps?=
 =?utf-8?B?ODFCdXBrMVdUaEoveWV3OTVEK0Y3RGNXOVUvLzdjV09scWN5anZacnhWZ0gr?=
 =?utf-8?B?TXFsK20vTDE1cUVWRlFLOG9FWEpwNDAzU2l3Qk5VNE5YY2R2UWJTQlJzejJx?=
 =?utf-8?B?ZWdjdmEydEZ2RlJCSk1UQ2RXbGtyTHByQkRscGtPc1pGQWU5QjE1VHpta0J1?=
 =?utf-8?B?ZE1HNUZNSFY2WGlMQzRZNEJic1VnYThFbHppdXZlOUJRNmZSVGdmREl0YXBS?=
 =?utf-8?B?ZGdHM2lkZWRydktoV3dmOXRTcHFKRExJb2xZckJVVi94UFBDZ1RYWWdIWllm?=
 =?utf-8?B?Ny83anJ1OFJGMnl4UFlQTjJZNTZ2YnBRZHNtQjJFeHhHbTR3bmt5aXhxWFdF?=
 =?utf-8?B?NmdnbVp1SmV6QnFRR3ZmaWZPVkFacFhhdDQzMjhLTEEyVHlRTnIzU1g4U1Fn?=
 =?utf-8?B?S3c5ckoyU2ppYXIzcHdXS24wNXBadng2d1ZRb0NOU1JNbk5YVVAxcXV2SkM0?=
 =?utf-8?B?ME1pdFNzU2JGZEZ6TjlFTUZIa1kyNDRRS3J3T1VvWmZJL25qMnZFOGNRd3pz?=
 =?utf-8?B?a3k1dC9Gaytrc3pPTTRPTUNYbWdsc1l4b1hzVDVCb2JVWDhybHVvZEN4UTEx?=
 =?utf-8?B?eVlkRXFqTWFBTVVrZ09Kc1NOVnU5bE1icEdTWHBYaTc1Nk1ZcCt2ZlNNdDFu?=
 =?utf-8?B?czVONFlvQmo3RXIyTDZDTDg0amxlVHNYS2luWDdKeVR3bXRHWVp3SnAvNWU5?=
 =?utf-8?B?MXNRVFNWZFZ3MHJDekJ4WGM2bEx1a0d1QjduRVhQWFJFemZoUGZKWUlyM1lL?=
 =?utf-8?B?YnBSKzFvZmg1WE9oYjhVYU44ZWtkakRERnQ0VENJRnhKeGJPaGJLcmlKc0ZE?=
 =?utf-8?B?RGg4N1l6N2trc2JPYnRqMFBOSTFsc3hLTVRVNHhWdk1lMXNZSEdnNU1xQk4r?=
 =?utf-8?B?M2E0TFRVTU1neHdCQk1ZOEw1dWpFZ1lBT0QzaEdVMkRVU1A1UHJhVElHNWJr?=
 =?utf-8?B?ZHRXQTFNYmpMaFQ4K3ZuOWpzcVBrSDlCLzJxUXRTWEQ0cDdMeVhxM0tKTDAv?=
 =?utf-8?B?VEIzWlVKaWlXVmh1TTlFcUh0YnQzRnQyVkV0Y0d3ZU1GSE9MZlZWTTlBaFZ6?=
 =?utf-8?B?Tk12ZEdlSEVUUDZOOXNwWlF4UTNBZ0hwZ1phOVhSTnhzUXVtd1B1WGJJTkdm?=
 =?utf-8?B?dm1FTTVCMUh1Zk82NUV6dlpicUh6MHZrWHZrK2ZyL3NHVVNBTGZkaWVuUk1B?=
 =?utf-8?B?VTFaSCt5bGhDc0hBeFNQbmVLdUNjNHV5U2xDek01eWNlS1RmSnJZVUd4Sk1Y?=
 =?utf-8?B?L2ZQbUR3OFJRbUdoQ0pINGZjVXlVRngxaGpkQWoxL0xPcWZJN0ZSNTd0cjhQ?=
 =?utf-8?B?bldONTBkaWYyR1MrT2tTOUN0T2YrOHJlUGdWc1NSM1laSnJyd21NNjVLNTNr?=
 =?utf-8?B?eTBLVHVaVEhmQllyQ3NwM3hXeUxqTmZEU0JTQzFLR0VOQ01IL2JGbHhZRjNu?=
 =?utf-8?B?Z2UyR2F5c05tdENMbW9OVk5vbThueElrVnhwK3I3TUllZ3lqQ1dRVFBVOU9t?=
 =?utf-8?Q?gJc+1oxiuqQ+JN5d3qklBepYkedU5Th2NzygS8z3y10Y?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bed3422-e051-4b01-130e-08db8e8b57ad
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 10:22:12.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSv4YFs9RJIqrdC1+6ll/7EW8C7FjxP151A1UR08b3FE6kfjlsKyWUkZb7MKj0d1jxNZwTfhOarfqVu4tq86AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2800
X-TM-AS-ERS: 104.47.7.174-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27776.006
X-TMASE-Result: 10--20.256700-4.000000
X-TMASE-MatchedRID: 6lay9u8oTUMqXRK86+Icjgw4DIWv1jSVpolXqDXvwwomE24Kzp/H+XYe
        CV6lBhH9ChrJ0BEo1vuIX09SCo5rQ2NwxFoIDUCJSr+cp4/vPz1raLL6Gp9UPIRNexATNUui6E0
        v+Eh37RXxSHUgp8OZQ/cEGLvWq8DLM8VWyP3FqfPgR8l2Qhmx6l6UsWSgw8xYzw0R57pZjQCuB1
        4ADbID6rflJxTe9lcw8Vsnm0kp8PDZaB7Z+HsZOddapwVvMmCvusBvtbk1teAPbkwnBlKslNL90
        xWTZFrvpIifG/3K3OqtwjU17tXdetZSVIh2F3SJCzp4ZDpFqX2OmNylh2VEByO6O6TqeaLOd1CS
        kzHFQYgez4vHJ2sOfDLKIbGf7bWqTcKcw8Fc3bZ4ws25aUc7HEXzYX/dCbSfMHiMmW0ZUNss3nA
        Y9fdM9dh5c4TN8zbZ0Sg7mn465/ma4ymjlcrDbznxJqun3snzJQhrLH5KSJ0=
X-TMASE-XGENCLOUD: 178ede2c-25f5-44c9-9621-a6b5969302a5-0-0-200-0
X-TM-Deliver-Signature: BD97FBDBDF8FB14C935CC3610FB0D2D7
X-TM-Addin-Auth: Wnqftv/omKOiruYMtXLcw0nY3ti+usuykWzHL8GKJRjGxsG8e70j+St1dNU
        xfB9FtCk4jn5rPQrGToaMJEAgmOgeH385dcwtno8MDuvDUodc2uF19hXy8/2UX++jfr+BoHCrmD
        l+iWSevh5c9rCLfbtSa9tSbCj2LmiQZDuWYyyw3Bdsx5RlV5LTyo6RV88fmGPaRTt1cmWkOb9Uv
        aR3AgItL3gfXKiAchHioT/mId0WDWXXVlDOOg5iLGMlbgqyhoETrYialfOZipG49nyLc6m3eSC0
        limatWc6aUiGYXo=.3ZtKGFLa3XdtelI5Ayh8jOXJMN4z6HX46xj10HUxCpj4V1BLO/xCVCcF4p
        GGTn/RXRSJhWMmQjmuEE1cO4bALzQJkGVWrtUiVoPvjRSe7pXUfmHRDq9Op1zpMCvKpjfR5V2gS
        2z/Eb4CykVJCzLapSN97jp1vNfX+jB5B5dZud/M0qCPJKz348DGwEqBKRJ/MtaKxdgA9GmP/aWL
        6zprNKdWcpyHaPNSDu2ZVX5bkZGPKSCxjBRjOj5ZK5Zz2c1fekrDbD6GCoLvvfq6CVxIZUr9gF4
        63epFlarkfZbmiLiYH18cMlNzP4v3S1ds2TKEFqRqKLd+IoksWpBeC3NDYg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1690453334;
        bh=zarZnzm5AzETz4o2xazcIEIDD8RnadM7++FMC4wDn6U=; l=3138;
        h=Date:From:To;
        b=F/FnN+L8nHNqkZBiifp3EUSWUbpzua94hwsDyF0/EzJxCfcf5+PsY7uWi80fWWEjg
         t4RlHt6IalDQ/xwHBD47DsO6CveHFjfYKBW4xW8ahTp7QF7hkNElF8AOL1IiRcjnFJ
         bG3VZTfp2ZyFFDuvvjYO78eNYbiBBew3+heG6Gs31xA2+UsjbUz66mx4Da4rqdhxgM
         iNPlA3yeNv8uIL2byhoVWB20MnS43qffKYYCNMIj0vUxAT8GHSBtyZlzNUdac1O3ro
         ypM+DHk7psyFRbpyTKBJo6vVw1/oh462AVP5f5c0969nLz4GpnvaE/thWBJVxZMw0o
         oYrgwUczdCb1g==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.23 10:13, Marc Zyngier wrote:
> On Fri, 30 Jun 2023 18:10:47 +0100,
> Peter Hilber <peter.hilber@opensynergy.com> wrote:
>>
>> Export helper functions to allow other code to
>>
>> - determine the counter type in use (virtual or physical, CP15 or memory),
>>
>> - get a pointer to the arm_arch_timer clocksource, which can be compared
>>   with the current clocksource.
>>
>> The virtio_rtc driver will require the clocksource pointer when using
>> get_device_system_crosststamp(), and should communicate the actual Arm
>> counter type to the Virtio RTC device (cf. spec draft [1]).
> 
> I really don't see why you should poke at the clocksource backend:
> 
> - the MMIO clocksource is only used in PM situations, which a virtio
>   driver has no business being involved with
> 
> - only the virtual counter is relevant -- it is always at a 0-offset
>   from the physical one when userspace has an opportunity to run
> 
> So it really looks that out of the four combinations, only one is
> relevant.

Thanks for the explanation. Dropping arch_timer_counter_get_type() and
assuming that the CP15 virtual counter is in use should also work for
now. With the physical/virtual counter distinction, I tried to be
future-proof, as per the following considerations:

The intended consumer of arch_timer_counter_get_type() is the Virtio RTC
device (draft spec [2], patch series [1]). If the Virtio device has
optional cross-timestamp support, it must know the current Linux kernel
view of the current clocksource counter. The Virtio driver tells the
Virtio device the current counter type (in the Arm case, CNTVCT_EL0 or
CNTPCT_EL0). It is intentionally left unspecified how the Virtio device
would know the counter value. AFAIU, if the Linux kernel were a
virtualization host itself, it would be better for the Virtio device to
look at the physical counter, since the virtual counter could be set for
a guest. And in other cases, the guest OSes use a virtual counter with
an offset.

This was the rationale to come up with the physical/virtual counter
distinction for the Virtio RTC device. Looking at extensions such as
FEAT_ECV, where the CNTPCT_EL0 value can depend on the EL, or FEAT_NV*,
it might be a bit simplistic.

Does this physical/virtual counter distinction sound like a good idea?
Otherwise I would drop the arch_timer_counter_get_type() in the next
iteration.

> 
> I'm not Cc'd on the rest of the series, so I can't even see in which
> context this is used. But as it is, the approach looks wrong.
> 

Sorry, I will Cc you on all relevant patches in the next iteration,
which I will send out soon.

The first patch series can be found at [1]. I think the second helper
function in this patch, arch_timer_get_cs(), would still be needed, in
order to supply the clocksource to get_device_system_crosststamp().

Thanks for the comments,

Peter

[1] https://lore.kernel.org/lkml/20230630171052.985577-1-peter.hilber@opensynergy.com/T/#me7df2d4db4fe1119d821dc9c4054b9404c15b02d
[2] https://lists.oasis-open.org/archives/virtio-comment/202306/msg00592.html
