Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA987E087C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344366AbjKCSvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKCSvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:51:20 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896DE134
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 11:51:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 20399FF806;
        Fri,  3 Nov 2023 18:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699037471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IDuaV2o26ipn18Dth3c/+CRuMDxlnBDkzFnwfW4wPK4=;
        b=AotkSUlt+cvUxCNRruWpyimBanIZ5u43UQp2V7aTrUb+lRvE7OzcN4hwD6DJlN0IpcEUxw
        lRAJcrQ3KG/Pdv8dcm8HSy86f8M738+nM+QkKxa9O764AwIVkhCsTntKlbh+956zAx7zVB
        lAYygv8WB/IeKYLmeQJ80anvxqdZatFulL7bytfQcSYN2bkvCVZMJ26M9+ClT6idI9gNxr
        B1KCHcpIC+IasoPIJOPVtR7uTcHv4XneDpT++dRKFniF0h+v8usuhVK6JS/qDBlKpxuyaS
        SC1Fh5rtgXRgZ/5xJQ0dX9qW4CFf5vCaTf/oBz9hL3rorHIgtC4xmNMR7yNn+A==
Date:   Fri, 3 Nov 2023 19:51:10 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     miquel.raynal@bootlin.com, Frank Li <Frank.Li@nxp.com>
Cc:     Frank.li@nxp.com, conor.culhane@silvaco.com, imx@lists.linux.dev,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] i3c: master: svc: collection of bugs fixes
Message-ID: <169903733135.383554.5820823171048383962.b4-ty@bootlin.com>
References: <20231023161658.3890811-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023161658.3890811-1-Frank.Li@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Oct 2023 12:16:52 -0400, Frank Li wrote:
> Each patch is indepedents. See commit message for detail.
> 
> Change from v1 to v4.
> See each patch notes
> 
> If there are not notes between v2 to v4, that's means not change.
> 
> [...]

Applied, thanks!

[1/6] i3c: master: svc: fix race condition in ibi work thread
      commit: 6bf3fc268183816856c96b8794cd66146bc27b35
[2/6] i3c: master: svc: fix wrong data return when IBI happen during start frame
      commit: 5e5e3c92e748a6d859190e123b9193cf4911fcca
[3/6] i3c: master: svc: fix ibi may not return mandatory data byte
      commit: c85e209b799f12d18a90ae6353b997b1bb1274a5
[4/6] i3c: master: svc: fix check wrong status register in irq handler
      commit: 225d5ef048c4ed01a475c95d94833bd7dd61072d
[5/6] i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen
      commit: dfd7cd6aafdb1f5ba93828e97e56b38304b23a05
[6/6] i3c: master: svc: fix random hot join failure since timeout error
      commit: 9aaeef113c55248ecf3ab941c2e4460aaa8b8b9a


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
