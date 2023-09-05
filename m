Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222B97925B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbjIEQD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353539AbjIEGgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 02:36:01 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9E4ECC7;
        Mon,  4 Sep 2023 23:35:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3E087809E;
        Tue,  5 Sep 2023 06:35:57 +0000 (UTC)
Date:   Tue, 5 Sep 2023 09:35:55 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Grant B Adams <nemith592@gmail.com>
Cc:     linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix tps65217-charger vs vbus irq conflict
Message-ID: <20230905063555.GZ11676@atomide.com>
References: <20230823085430.6610-1-nemith592@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823085430.6610-1-nemith592@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Grant B Adams <nemith592@gmail.com> [230823 08:54]:
> Both the tps65217-charger and vbus drivers are trying to allocate the same
> TPS65217 device interrupt line (TPS65217 is a TI power management IC) 
> which results in the following error and a probe failure:
> 
> genirq: Flags mismatch irq 148. 00002000 (vbus) vs. 00000000 
> (tps65217-charger)
> 
> For the Beaglebone Black's config the tps65217-charger driver is currently
> disabled and therefore no conflict. Based on comments from Robert C Nelson
> this driver has been disabled for a long time and he is uncertain on the
> reasons why it was disabled. With a battery connected to the BBB, I 
> re-enabled the tps65217-charger driver which resulted in the 
> abovementioned.
> 
> The conflict is resolved by changing both driver's threaded interrupt
> request function from IRQF_ONESHOT to IRQF_SHARED.

Looks good to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>
