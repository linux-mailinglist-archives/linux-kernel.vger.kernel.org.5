Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C057D4483
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjJXBJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJXBJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:09:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D6BDE;
        Mon, 23 Oct 2023 18:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0Vhw28NLaCgHA8ebsV5CFrc2MSDPeP7SJgVCz/4Fu8xOTaZxkYvR1UplkdKtsw8+FjeqisSOQETHzekQyshqq3SqhEwI4e3bEQys2RsW1e3pc7WSiQyzor6xWqUQGUZuwTyEc3IW2KPRfSFU8fp4qQxaonvb8uAxjr8WDcNW0+cw2i7Dpgg2PJEowZWFQsaU+as7bBO4+EdFMjdrY297YYixtMvafr5z6wIAx99O9ji3LwbGlVpnitg89q9mqxE+p4PYfmCHWiTlrgLafMpLiXnYWfpyg3816diBaNF7jBQ3otr0KTFw6RkU+9vxf0+gCNj3ZifMHvWFLe9Eynj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKbXxSgHRTAU6W0ruuwY/9/TrwxzZJ+8GrnUPdnY8FY=;
 b=ava4pPRPK1L68adVAYM6sLH84vlEpPov+djuPzDlCIQw9ED3stkI0e8KfE+9JMubyDtpfr4twzmBJExRY4p7L3gwaeoB/LpilwYv1UeVXbCwiMy4TT96rvtKlczb6dfrzLD5iuMtMbRgJfTSzVb/VVS7JVDg0Yw6DL6QlfreiTmk8Ov92HhFUtSjjLd2nqbzjskj2RbdrvQ6lRIV9qKdK8rUjdtKC1w6ySngO7kLC8AuG3HoIdJG2cfHBaqMO7ksIZTYza4X8gIxLmI+HsU2QmCn10hHu/xCgl8bH6VheLj3CxOGgoq2BtlR4YPVCvX9rLwKkZvotvG4BhjfgKs20A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKbXxSgHRTAU6W0ruuwY/9/TrwxzZJ+8GrnUPdnY8FY=;
 b=CDL41CFHu+SIIA2vF/8PT2WrqWlveJzIDFcTtvk5Y7/FfE/fDQYC0QnlRBqUd3HWBfv2raG0Va/7FUiAd7XXcZ99Ue49TtbQFyfVeCPPEU/hJLE/pCkglYMHc6V4hqcBCHqYnA8A3AtN/1Gzmwdcp/a3ssRiZ9cben2nYS3ecaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DS0PR08MB8656.namprd08.prod.outlook.com
 (2603:10b6:8:15d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 01:08:55 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::e73c:270b:75f7:5302%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 01:08:54 +0000
Date:   Mon, 23 Oct 2023 20:08:48 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Lee Jones <lee@kernel.org>
Cc:     James Ogletree <James.Ogletree@cirrus.com>,
        James Ogletree <james.ogletree@opensource.cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Message-ID: <ZTcZIMbrFEhz+rm4@nixie71>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-4-james.ogletree@opensource.cirrus.com>
 <20231019162359.GF2424087@google.com>
 <E3224624-7FF4-48F6-BA53-08312B69EF9F@cirrus.com>
 <20231023092046.GA8909@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023092046.GA8909@google.com>
X-ClientProxiedBy: DM6PR14CA0065.namprd14.prod.outlook.com
 (2603:10b6:5:18f::42) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DS0PR08MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ced57ab-bbe2-4a9e-bf77-08dbd42dcade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJcH1F67iX0qLoyNHQ5q8LHWkT+5BlZX6KWjw4w+6peIpqjEfwxkO+x4eF6xCwl7EzXV8BvWZAbq9GjKea+9tTPb8ZF8nVV07rbqLK/194eTDGLmvym6yNwoQDGVjWMnKJQCnnUTOL5c0bbeixaDkIgfmqA161AiILGhXIVYZxBWOSe6/3/+LsHKIAVhtelUisOY9XLz+h1g4OcDg/7nXp4Tvgv0WgsBwqbuJWu9EaKzvaLY2oDYuONE7JiwgPLa3gBLFAGlcmtdk3gzbTiwTurvPYdYqQQP8FWm/3337Fk1ndkBdYIHoXv6MLunK1SBAHotyWIB849tZLX+As/pYIfN5I/gdpX03sSX4mBtVXpD6OdCsJb8n9R1l8ipQkdycVHV+4Za/rtSOobuXtvGWKVEWDhMpjFyk+gy3QeCU4w1StVK8Bi9kD6RlmMr7DLYNRyELH+5zNhflBHfbXPDBGZIfmCiGnUJdq1MYi9CXpTv6CgsgH5phcQVLwuUQBC/PAkEW2uDGxv+uoZjO215UtwvUTwciEjg0yxM7/4RTyFfb2YQlUWFomqlOoJLdJBx3TaLOTbIHiDLfkZlNsuR4ZLSSwE9z5WkERB2zVEH+NY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(396003)(136003)(39830400003)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(41300700001)(2906002)(38100700002)(316002)(54906003)(66476007)(66946007)(66556008)(6916009)(6506007)(478600001)(6486002)(6666004)(6512007)(9686003)(83380400001)(5660300002)(86362001)(4326008)(8676002)(7416002)(8936002)(26005)(33716001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlA4Yng5bFdpaGFtcGd1Y1pOa3NDSllzYWJLR2pxYmhzN2tDSFgzK3kwMzhP?=
 =?utf-8?B?a1NSYWhVRkk2QzlvUS9rUlJrY25IWk9oVWhkWnVCT2J6UFJYTTZpcEtNMlU4?=
 =?utf-8?B?bERIZTVvYzExbC82Q1hjaG9oNk1HSlNpaUJPSDZWQUM2bXUvWjNzSjlZTEJZ?=
 =?utf-8?B?akRTcjIwLzl5QWR6dFZMVDJGL3ZKWnBKaHA3MUxhaHlycUVEM1pobkJKd0t4?=
 =?utf-8?B?ZGtOWUtQYTdycDhjMWFDdVJJTlZwcGdDMjNBWVRYMjJtRGhicStGYUFUSU9F?=
 =?utf-8?B?NU5VUmFrOWJwYVQwNjRYRG5hdHI3NEVzZUN5UXhrY3JMb0N6SXBsZXNIRHNk?=
 =?utf-8?B?WW9BRWIreDk1WGdnRGplaU4yNmtzUXI4TE1qOUVTZi9FQ3g3czhLUjgxTU40?=
 =?utf-8?B?SlcrdkpvYlFIb3ZGZVFDOXRzZzQxSVkvTWs0dG80RlJ1WGxGUTBleUlKa0Uv?=
 =?utf-8?B?WTdGNjNsUzdlYzRvcnFuUldUcENFWTFoKzlHWTQ0NGVOOUo0aVBqVGFZNUdC?=
 =?utf-8?B?VEROYk9PZnNBUzhDVzBxSHl4aFlOKzdCYWVxVmN6d3loWmpKN1djQzVNL2xs?=
 =?utf-8?B?VG1xYVZiZXlrdUpGTGU5MVp0WFAxRUxvakwweDZuUGl3b202TXR5cGVZa3VM?=
 =?utf-8?B?b0tkRXkxRDZZRWoxM2JaMHRwbm1FdkVoWGRtazBEVXh4aGxSQ0VWc3k1ZWNQ?=
 =?utf-8?B?Z0pEUHhWRStGTk5kaHhMdkRpUHZYZkJQRVU2NXkzamR2Nmo5YjEvaS9WOVRS?=
 =?utf-8?B?SjdnaDdWSUhpTFd3OEwzWERuTUxINEMvQkgrUTFQT2NQV00ySGdHcVdwTmZk?=
 =?utf-8?B?V2JFU2VaWWRIbm1FdDZDR1NZLzQzc3hBWkFXbU9kQXhrV2lCb0cvd3pzdzk3?=
 =?utf-8?B?WkNaQ2RqWmRpZ2xaVmtYSjRkSGxpK1BZLzV2L1F4U296RFViM3g3cXZHdm10?=
 =?utf-8?B?aUtaTTBkZlZrZ2dQc2dhdXdEQk1SOE9UbGZCOG0rVWlzNnhkSE1UalY3NzFJ?=
 =?utf-8?B?cE1SeUhoaGpuWVBzY1NUeGNrSzdyakFHSVpDbVNtdGR2SytIbXJkTitWNUhW?=
 =?utf-8?B?dDl4K0ZyVHRyWGpWUU42bXpWZllkeE9kQVBNc1Urb0lHVThTanhlYU1kQ3ZU?=
 =?utf-8?B?Z0pvQVVzQTlEYWJjWjR3NVUxR3ltbmhtSEo3U3VYbFBEaWdZR0k4b1ZWTlYr?=
 =?utf-8?B?QVNELzMwUlhMSEFkWElsZzI0L0gxbjkwRWY0NCs3TEpBK09aSUJnV3FjR0VB?=
 =?utf-8?B?eWFkTGUxbXZQL3lESk90RWpnTDAyVkZVbkpldVNudzE2aWM5d1cybHJCMHFa?=
 =?utf-8?B?cWN0aUR1Q1JTYWIrZVpOdXY2dURHcy9ONkwyUjFIa1lLWnBHVjl5ak00UEhD?=
 =?utf-8?B?TU85U0V6T056NHZXSHd4cnN5WVE0TjI4VXVLOUcwMUp4NmVwZXRVUC9JTVlS?=
 =?utf-8?B?UDg5NHdiRzl4Ry83NkVZM2EvOGkxdVFJZkZUaGtycmoyVndLeUIxZ0t0ZFlZ?=
 =?utf-8?B?VEMrR1ptTW45SmtGeWdmNGJxTXN6dTdlWWRFRitiaC9uWElPenlmTFZVWGJ4?=
 =?utf-8?B?aFJaajFkNm1NT1EzdkZuM0JjNkViY2VqRmtOMlRpVlRZOGRvMUVoQnpFTWhw?=
 =?utf-8?B?aGJJam45UXdVcUs4WTl0RTZxVHNtajgwZGJmcGlNdDBWY2k4aTN6NE9Nekth?=
 =?utf-8?B?UlkvenpBR2lYZW9FMENYajRET29maVI1RFpHRVdpbTR6WnoyRktKQ1FjS0Zx?=
 =?utf-8?B?eTFVUStZaVI4TnNkVktLSGtqbWEwQWJuekhRU0RiSGloWjlBdkVMV29JZW9X?=
 =?utf-8?B?bEVBNk02NGozTEI0a0JhUmhKeEdidTF1dlRlTHRZT25FMWsvNkd2MzVDbkFK?=
 =?utf-8?B?UzNMNlI5NVlMRkpldDErNVE1K2VvUmYwVE00OFZiWVRsRXZ6Y3VFN3dXZVZK?=
 =?utf-8?B?ZHZsWjZyWTBQV0ZEVGpkTHlCWDF2NmZpdThQNU1LSmVORCtRVGxlVlFEaDRB?=
 =?utf-8?B?NE9kQU9NNEVVSjI5aHlZTXNvRFVhUEE4Q2Q0SnRFWmE4eXdqa2IySUxUWkw4?=
 =?utf-8?B?S25hdlJjZVlRUEVnTzdoS2JMeEFYOVZBLzVmOS9HRlMwZC9qam9FTEJhRXRP?=
 =?utf-8?Q?JNuyXlseHg/gqsG7lQYC/cLdZ?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ced57ab-bbe2-4a9e-bf77-08dbd42dcade
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 01:08:54.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8cY6VvpRJF4kzXl8y6kQUfPCxI7cxA4EUXXNpCmsHo7WrJ34GKwDAYXVRmkeoQHBI4plAgyXbyLc53nJW0qHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR08MB8656
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee and James,

On Mon, Oct 23, 2023 at 10:20:46AM +0100, Lee Jones wrote:

[...]

> > >> +static int cs40l50_handle_redc_est_done(struct cs40l50_private *cs40l50)
> > >> +{
> > >> + int error, fractional, integer, stored;
> > > 
> > > err or ret is traditional.
> > 
> > We received feedback to change from “ret” to “error” in the input
> > subsystem, and now the opposite in MFD. I have no problem adopting
> > “err” here, but is it understood that styles will be mixed across
> > components?

FWIW, this is not an uncommon outcome for submissions that span multiple
subsystems.

> 
> That surprises me:
> 
> % git grep "int .*error" | wc -l
> 6152
> 
> vs
> 
> % git grep "int .*err" | grep -v error | wc -l
> 34753
> % git grep "int .*ret" | wc -l  
> 76584

Right, the history here is that this driver started its life in input,
where submitters have historically been asked to use 'error' for return
variables that return either zero or a negative error code. Since this
driver is no longer in input, this can easily be changed.

[...]

> > > Should the last two drivers live in drivers/mailbox?
> > 
> > Adopting the mailbox framework seems like an excessive amount
> > of overhead for our requirements.
> 
> MFD isn't a dumping a ground for miscellaneous functionality.
> 
> MFD requests resources and registers devices.
> 
> Mailbox functionality should live in drivers/mailbox.

I think this is just a misnomer; the code uses the terms "mailbox" and
"mbox" throughout because the relevant registers are named as such in
the datasheet.

Please correct me James, but I believe the datasheet uses this language
because both the host and the part itself have write access, meaning the
part may write a status code to the register after the host writes that
same register. There is no relation to IPC or the mbox subsystem.

That being said, some of the functions currently placed in this MFD,
namely those related to haptic motor properties (e.g. f0 and ReDC), do
seem more appropriate for the input/FF child device. My understanding
is that those functions serve only momentary haptic click effects and
not the I2S streaming case; please let me know if I have misunderstood.

I understand that no customer would ever build the to-be-added codec
driver _without_ the input driver, but the MFD must be generic enough
to support this case. Would a codec-only implementation use f0 and ReDC
estimation? If so, then these functions _do_ belong in the MFD, albeit
with some comments to explain their nature.

[...]

> > >> +{
> > >> + struct device *dev = cs40l50->dev;
> > >> + int error;
> > >> +
> > >> + mutex_init(&cs40l50->lock);
> > > 
> > > Don't you need to destroy this in the error path?
> > 
> > My understanding based on past feedback is that mutex_destroy()
> > is an empty function unless mutex debugging is enabled, and there
> > is no need cleanup the mutex explicitly. I will change this if you
> > disagree with that feedback.
> 
> It just seems odd to create something and not tear it down.

mutex_init() is not creating anything; the mutex struct is allocated as
part of the driver's private data, which is de-allocated as part of device
managed resources being freed when the module is unloaded.

mutex_destroy() is a NOP unless CONFIG_DEBUG_MUTEXES is set, and there are
roughly 4x fewer instances of it than mutex_init() in mainline. I recommend
not to add mutex_destroy() because it adds unnecessary tear-down paths and
remove() callbacks that wouldn't otherwise have to exist.

Kind regards,
Jeff LaBundy

