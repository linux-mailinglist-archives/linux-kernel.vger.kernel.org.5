Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073A77D24D7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjJVRSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVRSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:18:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450EDEE;
        Sun, 22 Oct 2023 10:18:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nspV7ImP9gxi2GAS0YJU1I/u7jXzr7nr/WYIGWGjkE0tZgKAQx/AM7Kow7wzV71p+9yLlurjdYCVZd206QILRz6/ViFQkYyGBxNSQoMpn2wgfLUBHO9oDFw8XYRaaQBuiycTqsoGDc43jzGrfVfzrfWw2mKeNN22x5TTMtxh7H8QWRJrKT6WZfaNfdjE0Gjpz0BCFol3khqKzYnNWL7xRu3B5nQSY786ETRvqJ4zCeTlhYlNzBjToNh9RGr+zn22QKxAwuT5gKKCf+OB7EUzQT6ipCdvU/qlU+tIW6JpFcwcmH40OnOpRWANMFHFX0n8tfovZIzUDy9V8u3Sn4Cu2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJOVljrfkuwt3CKHX8N4ijktw0Lng9++tU8/xRh/EE4=;
 b=hIZR+d9XLe2GcuGyzakBNGIe1SgqHXAcobe/+hQL8FkI6nwt1AJGGjKstdLOULrGMumCe+0Rp8K/WcW4fMyRdovrGhvBizT7umjh0o+twcvRSmKh/wInC9iUHLsB8UMn4wpwoxthZrzGb/dFsgF6ikWZ3Zi//1v9iXflErKsKwvrbDJuLPOyw4OXm3v6Bgft183LRWvXTRlEOUbFwQW8d2GI5K30i/cWVw9P4Uk2xgdz9U++CYHfKfi6jLuobSbyw0Ru7yixq7h3bn9L073R87Y10UzltoiJBUTy/txga3fMAByrMUKnEe0OFB1EqP0gttOS1r48vZkb+m76Q7525A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJOVljrfkuwt3CKHX8N4ijktw0Lng9++tU8/xRh/EE4=;
 b=h2CNDSPpfPbbwIPlD9jiR2L9eWbOBAq3OL5evzehaTq7xax1RAgP9ztSKiS/YkU0N851632WhU30a8ikZHPzcgQVP+lk1U5at34pi/aTjklf8CER9Zd+IV08+W4XCyITnEL/rpmHNHlnLbp/D4I7Yx11gHEqw8q+tx/o1Y/0zIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by DS0PR08MB8980.namprd08.prod.outlook.com
 (2603:10b6:8:1a0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sun, 22 Oct
 2023 17:18:03 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4528:c7c7:de7:aec2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::4528:c7c7:de7:aec2%7]) with mapi id 15.20.6907.025; Sun, 22 Oct 2023
 17:18:02 +0000
Date:   Sun, 22 Oct 2023 12:17:55 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc:     Karel Balej <balejk@matfyz.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] input: Imagis: add support for the IST3032C
 touchscreen
Message-ID: <ZTVZQ+Po20pcDWm8@nixie71>
References: <20230926173531.18715-1-balejk@matfyz.cz>
 <20230926173531.18715-3-balejk@matfyz.cz>
 <ZROIKSVCiTI3VB2B@nixie71>
 <CVUQTCJBG265.1MTSYOLY0FR7Q@gimli.ms.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CVUQTCJBG265.1MTSYOLY0FR7Q@gimli.ms.mff.cuni.cz>
X-ClientProxiedBy: DS7PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::35) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|DS0PR08MB8980:EE_
X-MS-Office365-Filtering-Correlation-Id: 50706b65-4e7d-42e9-431b-08dbd322d8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mBbCsl2t5kfWIhtqVAozYDJ9rjLQBxseJRPL7vErUHyHSeoiXpn1dFUEW2zXW1DtA97K9jGeADXVNuFMon0putlIlOQ9IG94rvwIAKPmGibhOwv6DDF+4av8jbh6PDZjOKLRRvnGsJt7M3J2J3IsFH+5JZ+H3mocv9naKlvkIRfiocdBO2ty0Ggg8Yw4Ps4n+H1MrvvKGUM5Upw9bmfLIm/WpgdHZxIA15ttF1VsfbUBNABNvBUlxIFKJHmKQe01QK0/ofmrqv9iVr9nmZ/9lPbistot8EoID8SLUSSt7PhCgV9N5KZyqfp83uV82QWb4RB/86gPdN+LBjo2YP/07Ku3TNzGsVWSFZOwIghyz1qjaS1sTvD2SLWlF6kDcuml3aQcshTvNfwhrXqwW6SOkIelCIWUYHQzC1JfKFRrn/H4gwgDrS1UI7x0re8pTmE0b5WDeqjccvvnItSFYhO0PDomIpsWWLipDywHPCD9t8q02k/s6gPyioSbKRcZgLhsIZW/MOejhqIU3eviSo1Pj6fVBNHM0aDy77CM2F9PmOPLv5DXQwqoQT6/x6NZRQL03lop3I9GzMg7U0+v32l8exLNi94/h5teew+rWsIJRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39830400003)(366004)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(83380400001)(6486002)(7416002)(8676002)(316002)(54906003)(66946007)(4326008)(66476007)(6916009)(66556008)(8936002)(5660300002)(6506007)(86362001)(33716001)(38100700002)(6512007)(9686003)(26005)(41300700001)(6666004)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hlgoddN5n1XTjkRtkJLQEXiO45JzeToXt168/lujY0r5Mk4sLLVBCiz447Ar?=
 =?us-ascii?Q?nWyyCUnbKRSqkjFGDZMlvWkzi3nBbh5uPrIGKo8/RCpL9PZDaTwsFN2lE6wh?=
 =?us-ascii?Q?rqHEZ54n5mnygDVVQ4j9gG7Frfdvdx+pYErZNYZPAQ9Sc0lrTAGqh6WN+mpd?=
 =?us-ascii?Q?ngzP21MwJK7Opm6KtP35ApDNnRnz6EPZESmD9QTJBS6ZzWKN9OUhYP6vQZiO?=
 =?us-ascii?Q?qqBchlK3JxhT2Y3/qBtFo1ENA3mlHNDvPfueZI5yeu+csFvZRkvRNe9+uH4Y?=
 =?us-ascii?Q?SRfCo8V2px1iy70GyvWcfcGEg13vFS5Bhw59qhc+6vIDqLm5CRb7qAn0JdGK?=
 =?us-ascii?Q?gaBf/nvhJMx7Nhari6wXNE3UwL4GTDj0e8RzWskOzPRIMcY+xD/jXVbwKJRl?=
 =?us-ascii?Q?2g7FDBFp+WPih01ENVcYN/BZHq3GrZBqOc7XiH3KeGgWf+ziu6Wug8cg+Xfd?=
 =?us-ascii?Q?JKCggVTftCgCak0WnnQkvAAMztOtHQH1zm7WckEPW2qrOEbREQG+xQFdlFaQ?=
 =?us-ascii?Q?hC/rfqqzKk6/uM1rqFZgO7cl57T1d0NDjUbi8aFJf7UlIBIga/jCQSjHpHIX?=
 =?us-ascii?Q?s5QvoIAoAuKNtJaeybGh4p3ojzEX3kCHZpFkEdHr0hNto9U5nFc9z8j743X6?=
 =?us-ascii?Q?Dg9JpWWsa9Y7djEbFgszFwOXcGSMN4rL0yzuanWMiLrRNfI6t1HPDQxJT9hc?=
 =?us-ascii?Q?T58SYBZBSwKOWya3lwTpz0r6EKgWmFd47Ik6Jfbv5DzUblla0gxnIPlE0o+a?=
 =?us-ascii?Q?u7RXe+z93WfzOpAUsV0UEpvuGkyOV45djmZL4fnKu5PDtqamOxV8V4xCh4R1?=
 =?us-ascii?Q?EhnkFmimcDc7OGz9D+zr6Ag+w+AwBtyZIYg8FY1gU5qFsdRdljjftuM8rUIg?=
 =?us-ascii?Q?7GQl4KCpZ0Y5JSyd6U3e1kx82VLebBHcvImP9wAz5hD4qao4hh+QXkRtpoH/?=
 =?us-ascii?Q?QW8KLuFfhFLkpGEbS0xkVdJ73R4sl2NtDqIMfNLj6oNCrApn68/kwDP+dRNH?=
 =?us-ascii?Q?wvNDQn171Djg2jh2A/SADzHocIYs3nXKaM71ILLzFp4AxHGP7lCa7cSLBc1E?=
 =?us-ascii?Q?JudpzQcoC/YHDP0kzrL6sct7AdNqpdDulwECiYsOczxaSUmpOhdvs6Tde2Yb?=
 =?us-ascii?Q?wp8HwDKv1g0GGLNWt+6qAXvXVvFhuI7dUGuEbx7e36KLI0As5PMV2vZMdkcM?=
 =?us-ascii?Q?8nY/hTMV2MX6tH9RAK97uRsKOAB3FZwZqql2Jv910/8qYKXPYFBe2lI8QZPC?=
 =?us-ascii?Q?phPEodda46y2BL0e9HJenxuvO8+QNhoHCQz4TrbWcVyYJMApqyKOqBddTzIp?=
 =?us-ascii?Q?pj5IF6nM3MQ4GMRNqTmWLA/MHLvrt3ZtaUPsL28LCZLNzsHWuXD+XvZ7xT8p?=
 =?us-ascii?Q?w9CkUNNN6TRtz/Qx1TYcg/cXhQzXv3iF+35YQY3uDlEab9IEv5EGLHwL0nVi?=
 =?us-ascii?Q?ZiRZ18P66fwBHWlBZnM3bB5f/ENU3znvn0WdSg+xjKjO/ZdqzW5jT6D1Sy4e?=
 =?us-ascii?Q?yebV+wLkgg5VATujBk3XDYV8lWdwJ202tcLiBnW7gU/vLvYFb55MXYY5OCYp?=
 =?us-ascii?Q?QHRG5tLwL6Bu0lW/ClkpS9d4dsvJ1V4RDqfAaKh+?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50706b65-4e7d-42e9-431b-08dbd322d8ba
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2023 17:18:02.5373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1LCs8vIHwYmHe4lZx8vPC4vOWbdM/LTCLv0N43eo0j9bq46UygtwYfA3w01tzNq0YkvD1I/SH5rVk94Neulgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR08MB8980
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karel,

On Thu, Sep 28, 2023 at 07:56:45PM +0200, Karel Balej wrote:
> Hello, Jeff,
> 
> thank you very much for your feedback.
> 
> > > +	if (chip_id == IST3032C_WHOAMI) {
> > > +		/*
> > > +		 * if the regulator voltage is not set like this, the touchscreen
> > > +		 * generates random touches without user interaction
> > > +		 */
> > > +		error = regulator_set_voltage(ts->supplies[0].consumer, 3100000, 3100000);
> > > +		if (error)
> > > +			dev_warn(dev, "failed to set regulator voltage\n");
> > > +	}
> > > +
> >
> > Opinions may vary, but mine is that this kind of hard-coded board-level policy
> > does not belong in the driver. Surely the supply need not be equal to exactly
> > 3.1 V and this is merely an upper or lower limit? Assuming so, what if the board
> > designer opts to share this supply with another consumer that requires a specific
> > voltage not equal to 3.1 V, but still within the safe range of IST3032C?
> >
> > To me, this restriction belongs in dts, specifically within the regulator child
> > node referenced by the client which bears the new 'ist3032c' compatible string.
> > Maybe a better solution is to simply note this presumed silicon erratum in the
> > description of the vdd supply in the binding which, as Conor states, must not be
> > clubbed with driver patches.
> 
> I agree that the voltage should not be hardcoded. I do not know what the
> safe range for the touchscreen is though, because the downstream driver
> does exactly this. I will try to test it with several values within the
> range allowed by the regulator and see if I can determine some limits on
> when the "ghost" touches do not appear.
> 
> However I am not sure whether this setting should be moved to the
> regulator DT - it is my understanding that the DT for the regulator
> should list the min/max range *supported* by the regulator, not conform
> to requirements of its consumers, which should instead ask for the
> regulator to be set to a range they require themselves, via their driver
> - is it not so?
> 
> The regulator driver is not mainlined yet (although I managed to get the
> downstream code working with mainline), however the downstream DT
> contains much wider range of supported voltage (compared to those 3.1 V
> used by the touchscreen) - an information which would get lost if I set
> the DT for the regulator by the requirements of the touchscreen, which I
> believe would have similiar implications as what you said regarding
> using this regulator with other consumers.
> 
> What would seem a reasonable solution to me would be to move the voltage
> range values to the touchscreen DT (which incidentally is what the
> downstream driver does also, except it uses one value for both min and
> max), so that they would be set by the driver but not hardcoded in the
> code - what do you think about this?

I believe this has been clarified in the other thread with Markuss, but
just to close this out: in general, individual drivers should not be
setting the output value of a regulator. Instead, they should merely mark
themselves as a consumer of a regulator, and increment or decrement its
usage counter by enabling and disabling the regulator, respectively.

You are correct that the regulator node typically specifies the minimum
and maximum voltages supported by the regulator, but if your board has
a stricter range because said regulator is tied to something such as this
touchscreen controller, then you can override the maximum voltage with
something smaller (e.g. 3.1 V). The regulator framework will then set the
output voltage according to the ultimate range defined in the device tree.

Often times the baseline regulator nodes are defined in a PMIC-specific
.dtsi file, or part of a more generic board definition. Then, some nodes
are overridden at a higher level in the heirarchy tailored to the board,
or an overlay applied by the bootloader.

> 
> Best regards,
> K. B.

Kind regards,
Jeff LaBundy
