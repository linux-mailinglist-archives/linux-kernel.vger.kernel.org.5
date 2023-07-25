Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A387621C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjGYStc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGYStb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:49:31 -0400
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FFE1BC2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=s1; bh=slvye5wtN2LtYZ0xLS1A+7DvQJ4v5mIZFeSvFvmOaQM=;
        b=M63E3U9ADds9ZQIDFmYyogYxQVR8reCaFsFRNX5EMSPduM3QH7Z+bn4ZLzCV8aTzaIY8
        q75HevhruLSdG77YeO7l9PcfYvZP0RAFq868NCiESDB06mbM6XRrko0vg1ur7iYVdsGEXZ
        jraVRo8DVCjoqDjlQzyiPsN/xnaUFymcBw6CIFk6EVayn62eZ1lc6Xu5RxLkSUitu5t64L
        jP0H23nXPGgJIOcfOUOtZj2Fu6zaPupp3//erDVP8gSnu4rANPEAe9i+4aASVmwQPpJik+
        9dMdx8rr2F9MCQ+XgjJ8rotGhY4uya2I32EMLUlZFqwdtLOrEpLAqwlhcBHwTugA==
Received: by filterdrecv-66949dbc98-2h875 with SMTP id filterdrecv-66949dbc98-2h875-1-64C01936-5A
        2023-07-25 18:49:26.85580565 +0000 UTC m=+6548987.779244678
Received: from [192.168.1.50] (unknown)
        by geopod-ismtpd-3 (SG) with ESMTP
        id CzoI7C93Q8C6ozvHpFDwpw
        Tue, 25 Jul 2023 18:49:26.565 +0000 (UTC)
Message-ID: <294d2905-79b5-3a49-88e5-47df9a2447ec@kwiboo.se>
Date:   Tue, 25 Jul 2023 18:49:27 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: rockchip: Fix regulators and enable SATA on
 Radxa E25
Content-Language: en-US
References: <20230724145213.3833099-1-jonas@kwiboo.se>
 <169030979754.2939984.9282914456412331786.b4-ty@sntech.de>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <169030979754.2939984.9282914456412331786.b4-ty@sntech.de>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hzhHxSPpdSFr4pHYV?=
 =?us-ascii?Q?0qIOofIH=2FsXgZ+Dsy7M6zY8SPImb9EjGkNHQzKu?=
 =?us-ascii?Q?75EkYebQpT1O=2FE6195t1I78Rk8V34asePV+50Ii?=
 =?us-ascii?Q?+br5O20o4XaI20AHgCqhwWTUTi=2Fib1r9GdwXTmJ?=
 =?us-ascii?Q?vvyW=2FpWoa1D7yezQnKITr9EPeDeSmHR=2FxlIqzC?=
To:     Heiko Stuebner <heiko@sntech.de>, Chukun Pan <amadeus@jmu.edu.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-25 20:32, Heiko Stuebner wrote:
> On Mon, 24 Jul 2023 14:52:16 +0000 (UTC), Jonas Karlman wrote:
>> Despite its name, the regulator vcc3v3_pcie30x1 has nothing to do with
>> pcie30x1. Instead, it supply power to VBAT1-5 on the M.2 KEY B port as
>> seen on page 8 of the schematic [1].
>>
>> pcie30x1 is used for the mini PCIe slot, and as seen on page 9 the
>> vcc3v3_minipcie regulator is instead related to pcie30x1.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/2] arm64: dts: rockchip: Fix PCIe regulators on Radxa E25
> commit: a87852e37f782257ebc57cc44a0d3fbf806471f6
> 
> [2/2] arm64: dts: rockchip: Enable SATA on Radxa E25
> commit: 2bdfe84fbd57a4ed9fd65a67210442559ce078f0
> 
> As you can see, I've split them in two. Please check that I didn't
> mess anything up. Having an "and" in the commit subject is always a
> very strong indicator that a split is probably a good thing ;-)

Thanks, and they look fine. Should probably have split it in two from
the beginning, I will try to do better next time :-)

Regards,
Jonas

> 
> 
> Best regards,

