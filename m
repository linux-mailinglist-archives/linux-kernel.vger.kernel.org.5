Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA97BC521
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbjJGGoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343586AbjJGGom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:44:42 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42903D6;
        Fri,  6 Oct 2023 23:44:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AD8CC80E0;
        Sat,  7 Oct 2023 06:44:40 +0000 (UTC)
Date:   Sat, 7 Oct 2023 09:44:39 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap3-gta04: Drop superfluous omap36xx
 compatible
Message-ID: <20231007064439.GN34982@atomide.com>
References: <20231004065323.2408615-1-andreas@kemnade.info>
 <12323F42-3611-4685-8981-F6A18C4A5862@goldelico.com>
 <20231004130353.01228376@aktux>
 <FF3A3F35-E264-4D28-AFAC-EFA2ADB69F40@goldelico.com>
 <20231004135449.591b3f6c@aktux>
 <42806B60-E48B-4AA9-B375-E9F65F59AB87@goldelico.com>
 <6B245439-F9FE-4931-A0DE-81F825BB5FE5@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B245439-F9FE-4931-A0DE-81F825BB5FE5@goldelico.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [231004 12:50]:
> What about the PVR/SGX driver. This needs a compatible that can distinguish
> between the DM3725 and DM3730. The first is w/o SGX and the second one
> with. Having all summarized as omap3630 does not allow to load the
> PVR/SGX driver based on the board specific compatible entry.
> 
> AFAIR this was the original idea behind 
> 
> 	compatible = "goldelico,gta04", "ti,omap3630", "ti,omap36xx", "ti,omap3"; 

I think we already handle this, see drivers/bus/ti-sysc.c and search for
DIS_SGX and similar flags for other accelerators. So I think this patch is
safe to apply?

Regards,

Tony
