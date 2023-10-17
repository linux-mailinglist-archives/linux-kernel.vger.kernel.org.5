Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F287CBEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjJQJNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjJQJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:13:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFC393
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:13:19 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qsg8J-0003xl-I0; Tue, 17 Oct 2023 11:12:59 +0200
Message-ID: <004d6ce9-7d15-4944-b31c-c9e628e7483a@pengutronix.de>
Date:   Tue, 17 Oct 2023 11:12:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: stmmac: fix PPS capture input index
Content-Language: en-US, de-DE
To:     Simon Horman <horms@kernel.org>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20231010-stmmac_fix_auxiliary_event_capture-v1-0-3eeca9e844fa@pengutronix.de>
 <20231010-stmmac_fix_auxiliary_event_capture-v1-2-3eeca9e844fa@pengutronix.de>
 <20231014144428.GA1386676@kernel.org>
From:   Johannes Zink <j.zink@pengutronix.de>
In-Reply-To: <20231014144428.GA1386676@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 10/14/23 16:44, Simon Horman wrote:
> On Thu, Oct 12, 2023 at 11:02:13AM +0200, Johannes Zink wrote:
>> The stmmac supports up to 4 auxiliary snapshots that can be enabled by
>> setting the appropriate bits in the PTP_ACR bitfield.
>>
>> Previously instead of setting the bits, a fixed value was written to
>> this bitfield instead of passing the appropriate bitmask.
>>
>> Now the correct bit is set according to the ptp_clock_request.extts_index
>> passed as a parameter to stmmac_enable().
>>
>> Fixes: f4da56529da6 ("net: stmmac: Add support for external trigger timestamping")
>> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> 
> Hi Johannes,
> 
> The fix language of the subject and presence of a fixes tag implies that
> this is a bug fix. But it's not clear to me that this is resolving
> bug that manifests as a problem.

Thank you for taking your time to read through the series. This series is 
somewhere in the realm between "fixing some stuff added previously (and never 
worked)" and "filling the gaps/adding a new feature in some template code that 
never worked as intended". However, I do not have strong opinions about this.

If you prefer to have the commits reworded, I will just wait a bit more for any 
additional feedback and resend the series with the commit messages reworded+ 
fixes, should any be required.

> 
> If it is a bug fix then it should probably be targeted at 'net',
> creating a dependency for the remainder of this series.
> 
> On the other hand, if it is not a bug fix then perhaps it is best to
> update the subject and drop the Fixes tag.

I added the fixes-Tag in order to make code archeology easier, but as it may 
trigger picks to stable branches (which is not required imho), I have no 
objections to dropping it for a v2.

> 
> I'm no expert on stmmac, but the rest of the series looks good to me.
> 
> ...
> 

that's good news. thx for looking through the series.

Best regards
Johannes


-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

