Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A1B808A91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443269AbjLGO3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjLGO3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:29:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8830E10F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:29:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06ACEC433A9;
        Thu,  7 Dec 2023 14:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701959348;
        bh=TqlKfFKOLLV8/pff7AZHnAMNzvKwpCh5nT2X8mByeJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXBkyx03W4Uuv9404zBCC/K1KLScFaO4qf3eWS4PQNfQfe4mrafoBjEt1pGH74/+G
         2pOWvzS/4lCCj46zVXsrM78Emf3o+4xWuGYZEwfiYJ1Co1ptYNOaQ1FWMSVD32tdXr
         sdhS9gXAEZMhYQn93jmEDMaZw90Az24dFJsV9asJmmVR/Ka1pIGXWrRVGVqDCcxUyx
         fkKS7HJ304ESaPXUtKPJ19zblqOneEbehpEx0gfxHqHuobLIZFIAXMrl5RNcIsrhDi
         7pX48TbcOJZY0aP4ZJppFrF8uIh23mculrE5n48KJdyfc/7DkDRuYTZNl5hwbVsMwj
         v1X91WTWd4oUQ==
Date:   Thu, 7 Dec 2023 14:29:04 +0000
From:   Lee Jones <lee@kernel.org>
To:     Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v2 2/2] ptp: add FemtoClock3 Wireless as ptp
 hardware clock
Message-ID: <20231207142904.GE8867@google.com>
References: <20231129204806.14539-1-lnimi@hotmail.com>
 <PH7PR03MB7064FC8C284D83E9C34B8C08A083A@PH7PR03MB7064.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR03MB7064FC8C284D83E9C34B8C08A083A@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> The RENESAS FemtoClock3 Wireless is a high-performance jitter attenuator,
> frequency translator, and clock synthesizer. The device is comprised of 3
> digital PLLs (DPLL) to track CLKIN inputs and three independent low phase
> noise fractional output dividers (FOD) that output low phase noise clocks.
> 
> FemtoClock3 supports one Time Synchronization (Time Sync) channel to enable
> an external processor to control the phase and frequency of the Time Sync
> channel and to take phase measurements using the TDC. Intended applications
> are synchronization using the precision time protocol (PTP) and
> synchronization with 0.5 Hz and 1 Hz signals from GNSS.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/ptp/Kconfig                |   12 +
>  drivers/ptp/Makefile               |    1 +
>  drivers/ptp/ptp_fc3.c              | 1036 ++++++++++++++++++++++++++++
>  drivers/ptp/ptp_fc3.h              |   45 ++

>  include/linux/mfd/idtRC38xxx_reg.h |  273 ++++++++

Acked-by: Lee Jones <lee@kernel.org>

>  5 files changed, 1367 insertions(+)
>  create mode 100644 drivers/ptp/ptp_fc3.c
>  create mode 100644 drivers/ptp/ptp_fc3.h
>  create mode 100644 include/linux/mfd/idtRC38xxx_reg.h

-- 
Lee Jones [李琼斯]
