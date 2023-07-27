Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A602676489E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjG0Haw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjG0Ha0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:30:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A6E271C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:19:01 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qOvGy-0008Dp-0g; Thu, 27 Jul 2023 09:18:56 +0200
Message-ID: <65810968-d34f-8a89-f235-95391a959c2b@pengutronix.de>
Date:   Thu, 27 Jul 2023 09:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Content-Language: en-US, de-DE
To:     Kurt Kanzenbach <kurt@linutronix.de>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        kernel test robot <lkp@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, patchwork-jzi@pengutronix.de
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <20230725200606.5264b59c@kernel.org> <ZMCRjcRF9XqEPg/Z@hoboy.vegasvil.org>
 <09a2d767-d781-eba2-028f-a949f1128fbd@pengutronix.de>
 <ZME/GjBWdodiUO+8@hoboy.vegasvil.org>
 <8742d597-e8b1-705f-6616-dca4ead529f4@pengutronix.de> <873519u8o3.fsf@kurt>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <873519u8o3.fsf@kurt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kurt,

On 7/27/23 09:15, Kurt Kanzenbach wrote:
> Hi Johannes, Richard,
> 
> On Thu Jul 27 2023, Johannes Zink wrote:
>>> BTW this driver is actually for an IP core used in many, many SoCs.
>>>
>>> How many _other_ SoCs did you test your patch on?
>>>
>> I don't have many available, thus as stated in the description: on the i.MX8MP
>> only. That's why I am implementing my stuff in the imx glue code, you're
>> welcome to help testing on other hardware if you have any at hand.
> 
> I can assist with testing on Intel real time platforms, stm32mp1 and
> Cyclone V (and imx8mp). Just Cc me on the next the version of this
> patch.

Thanks for your kind offer, I am going to CC you when I send my v3.

Best regards
Johannes

> 
> Thanks,
> Kurt

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

