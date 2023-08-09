Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC07775402
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjHIHXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjHIHXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:23:32 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6630D172A;
        Wed,  9 Aug 2023 00:23:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D3A978105;
        Wed,  9 Aug 2023 07:23:31 +0000 (UTC)
Date:   Wed, 9 Aug 2023 10:23:30 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Kevin Hilman <khilman@kernel.org>
Cc:     Dhruva Gole <d-gole@ti.com>, Andrew Davis <afd@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>, Georgi Vlaev <g-vlaev@ti.com>
Subject: Re: [PATCH V6 4/4] firmware: ti_sci: Introduce system suspend resume
 support
Message-ID: <20230809072330.GB11676@atomide.com>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-5-d-gole@ti.com>
 <3882f0ac-b74c-6eb2-197c-34ca233cd7a3@ti.com>
 <20230803155541.nwsfwobfkbpefoyw@dhruva>
 <8c330bd9-5f4e-8cd0-ed02-c3a696d7473a@ti.com>
 <20230803160815.yfpkdfssv75d4inf@dhruva>
 <7ho7jifrda.fsf@baylibre.com>
 <20230808115403.dkz6ev5vc6bhcmzh@dhruva>
 <7httt9dq2x.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7httt9dq2x.fsf@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kevin Hilman <khilman@kernel.org> [230809 00:20]:
> To me, it sounds like you might want to use ->resume_early() or maybe
> ->resume_noirq() in the pinctrl driver for this so that IO isolation can
> be disabled sooner?

For calls that need to happen just before the SoC is disabled or first
thing on resume path, cpu_cluster_pm_enter() and cpu_cluster_pm_exit()
notifiers work nice and allow distributing the code across the related
SoC specific code and device drivers. See for example the usage in
drivers/irqchip/irq-gic.c for CPU_CLUSTER_PM_ENTER.

Regards,

Tony
