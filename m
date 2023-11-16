Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E552B7EE960
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjKPWkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjKPWkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:40:17 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB330127
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:40:11 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 010791C0003;
        Thu, 16 Nov 2023 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700174410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PcI5DmxFweLocvZiTAD/rwWYJAn3IHIgKS4/i00jgWk=;
        b=R/e1dql5Z2pyCQp7Ckpgw3HAwGAwz/ryacwE2Hhc1bDUvca0WGUkkRKF+hS1PgQp6F7B0X
        JvAC9Vs73JtodNITVFuazDzWKjDfYggHlzQZcozLIZ9G0HXxO4VIRU05qfYuIEC+ruotns
        nTLK0r3+8issf09GQrWNWyLPGCZvFKgqSg42OEL0ki7wb/CnOOga3NzwShi1w2w/OKCzaD
        cAXfeSp/ptd7s0fs9Zao78iAxmhm66RRMjJYh4VNN4A1ys3VKc3k7NLOR53laZIzpHcsHo
        JK77KHd7m7y0D3mSA/Ehz4ZXRMtf0MPtcEOp2mbBnzTyqBbhwY38xCNR6C42zw==
Date:   Thu, 16 Nov 2023 23:40:09 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     miquel.raynal@bootlin.com,
        Joshua Yeong <joshua.yeong@starfivetech.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Fallback mechanism for GETMXDS CCC
Message-ID: <170017437282.331655.12906579286877237235.b4-ty@bootlin.com>
References: <20231114085525.6271-1-joshua.yeong@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114085525.6271-1-joshua.yeong@starfivetech.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Nov 2023 16:55:24 +0800, Joshua Yeong wrote:
> Some I3C hardware does not support turnaround time in GETMXDS. Cadence IPs will
> perform validation against length of CCC returned. Similar hardware error were
> not seen in other IPs DW/SVC.
> 
> Joshua Yeong (1):
>   i3c: Add fallback method for GETMXDS CCC
> 
> [...]

Applied, thanks!

[1/1] i3c: Add fallback method for GETMXDS CCC
      commit: 2aac0bf4ebc8e09941bb2a40c0ce725437d9a82c

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
