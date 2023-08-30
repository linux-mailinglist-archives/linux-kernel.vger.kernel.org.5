Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C7178DF23
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242534AbjH3Tb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244784AbjH3OAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F599F4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24EFE620B6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD75C433C7;
        Wed, 30 Aug 2023 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693404010;
        bh=DS85y2RVrAUar/apW58Yhf2H+FoUBE6hZnLGNHu9Imc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TCB6v29UaaAg466TjHBg5pWy04rI8WPRW5szGxlenQZuP6QQGw1Zyw08oMUG9eCeB
         rdv60TTQVwQ6fRzvP0L1hESSYx4eAgFhjV5aBYyEeGjfMdcKjYwFSEJDH2Tkv35jzL
         LANlGCWv9f+f3P6cYtSKn3zzcP+bU7pBYIJjY9216DMkdgPf1arako1VxwE3BUtVld
         oG32HF4+DyFyh5VXLGBy5100f4IhaaQWboH78haYhMYz+xyBLk7y+xBOpMIKA0O6zw
         6tNVJxUL2OTuH2oTUlVYEvpSQQ/ln8jel6+pDO+pKjX1OSwJspDJlzutkcRXP++bNd
         8+2sZnYT6YPMw==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qbLjs-009KXO-4t;
        Wed, 30 Aug 2023 15:00:08 +0100
MIME-Version: 1.0
Date:   Wed, 30 Aug 2023 15:00:07 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin@biqu3d.com>
Subject: Re: [PATCH] firmware: smccc: Export both soc_id functions
In-Reply-To: <20230830-smccc_export-v1-1-6ecc7661bc94@somainline.org>
References: <20230830-smccc_export-v1-1-6ecc7661bc94@somainline.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8587262deb02cf46a922ec2ec3e647d5@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: martin.botka@somainline.org, mark.rutland@arm.com, lpieralisi@kernel.org, sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, andre.przywara@arm.com, tech@biqu3d.com, bttuniversity@biqu3d.com, marijn.suijten@somainline.org, angelogioacchino.delregno@somainline.org, konrad.dybcio@somainline.org, martin@biqu3d.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-30 14:23, Martin Botka wrote:
> arm_smccc_get_soc_id_version and arm_smccc_get_soc_id_revision
> need to be exported so they can be used by modules.
> Currently sun50i cpu freq driver is planning to use these functions.
> 

What for? I'm absolutely not keen on randomly exporting synbols
until we see what this is for.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
