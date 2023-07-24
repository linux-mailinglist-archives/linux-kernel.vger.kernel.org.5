Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B70875F699
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGXMnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjGXMnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:43:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE79D8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:43:03 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qNutq-00028q-R2; Mon, 24 Jul 2023 14:42:54 +0200
Message-ID: <8a5686f8-8c86-8242-b1b0-881b55a35489@pengutronix.de>
Date:   Mon, 24 Jul 2023 14:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] arm64: dts: imx8mp: use correct clock for eqos
 timestamping counter
Content-Language: en-US, de-DE
To:     Fabio Estevam <festevam@gmail.com>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, patchwork-jzi@pengutronix.de
References: <20230719-imx8mp_enet_qos_use_125mhz_clock-v2-1-eed15d74bfd1@pengutronix.de>
 <CAOMZO5AxuMOmy_RwQ-HpTMJn7Lg9j6ytb6t0pMerQd+t0AG12Q@mail.gmail.com>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <CAOMZO5AxuMOmy_RwQ-HpTMJn7Lg9j6ytb6t0pMerQd+t0AG12Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

On 7/22/23 03:49, Fabio Estevam wrote:
> On Fri, Jul 21, 2023 at 12:51 AM Johannes Zink <j.zink@pengutronix.de> wrote:
>>
>> The i.MX8MP Reference Manual rev 1 06/2021, section 11.7.2.5 "Timestamp
>> Support" indicates the PTP timestamp clock expects a typical frequency
>> of 125MHz.
>>
>> As this also improves the precision of the measured timestamps: assign
>> appropriate 125MHz Clock parent. As no one except the timestamping
>> counter uses this clock, there are no side-effects of this change in
>> other peripherals.
>>
>> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 
> 

please scratch this patch, the PTP Timestamping clock cannot be supplied with a 
125MHz clock, there is no 125MHz source in the MUX input and I misinterpreted 
the clocksummary when testing this patch.

Sorry for the noise,
Johannes


-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

