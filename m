Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB887C94E6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 16:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjJNOog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 10:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJNOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 10:44:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC2CA
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 07:44:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638DCC433C7;
        Sat, 14 Oct 2023 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697294673;
        bh=11scpju71D+KerC5FhLxK9Ma2HRBqYwq2VHa/P5HXo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tb40Oyx8m0AwzPXsLNlWOiSigEbsAvCNBdUpb2hrFWsFqQCrASeDhLRd7HQzzg0ev
         LySdTO04dtwnNoNrNM0z2C02dwhFNeXDWP0Npm+pw3FKK07TdejIZJQOnPeqelqVsR
         8b05MV4RpV1yiNOw6N2VlGGRzEzJfC+imxNtvnA4AYo8xPvQvvsybNz5CqurNrjd96
         xD4vdsOEmP25fCCGy8pMoFd8k7Nj1ebREcJgHyXIR7Y1W6HHW1bW+Oa/Fs3n8FUNky
         neYAProozhcaz3AqZxalAfVITm/Y/AZKf2cRlXMPUNYjoapEk+JnLjKWEGhnbVS6TG
         791CflIJO8iTw==
Date:   Sat, 14 Oct 2023 16:44:28 +0200
From:   Simon Horman <horms@kernel.org>
To:     Johannes Zink <j.zink@pengutronix.de>
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
Subject: Re: [PATCH net-next 2/5] net: stmmac: fix PPS capture input index
Message-ID: <20231014144428.GA1386676@kernel.org>
References: <20231010-stmmac_fix_auxiliary_event_capture-v1-0-3eeca9e844fa@pengutronix.de>
 <20231010-stmmac_fix_auxiliary_event_capture-v1-2-3eeca9e844fa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-stmmac_fix_auxiliary_event_capture-v1-2-3eeca9e844fa@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 11:02:13AM +0200, Johannes Zink wrote:
> The stmmac supports up to 4 auxiliary snapshots that can be enabled by
> setting the appropriate bits in the PTP_ACR bitfield.
> 
> Previously instead of setting the bits, a fixed value was written to
> this bitfield instead of passing the appropriate bitmask.
> 
> Now the correct bit is set according to the ptp_clock_request.extts_index
> passed as a parameter to stmmac_enable().
> 
> Fixes: f4da56529da6 ("net: stmmac: Add support for external trigger timestamping")
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>

Hi Johannes,

The fix language of the subject and presence of a fixes tag implies that
this is a bug fix. But it's not clear to me that this is resolving
bug that manifests as a problem.

If it is a bug fix then it should probably be targeted at 'net',
creating a dependency for the remainder of this series.

On the other hand, if it is not a bug fix then perhaps it is best to
update the subject and drop the Fixes tag.

I'm no expert on stmmac, but the rest of the series looks good to me.

...
