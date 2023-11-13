Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DE57EA12D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjKMQVU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Nov 2023 11:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjKMQVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:21:18 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778581715;
        Mon, 13 Nov 2023 08:21:11 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id CECE624DFC2;
        Tue, 14 Nov 2023 00:21:08 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Nov
 2023 00:21:08 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Nov
 2023 00:21:01 +0800
From:   Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To:     <conor@kernel.org>
CC:     <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <jisheng.teoh@starfivetech.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <leyfoon.tan@starfivetech.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <peterz@infradead.org>, <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <will@kernel.org>
Subject: Re: [PATCH 1/2] perf: starfive: Add StarLink PMU support
Date:   Tue, 14 Nov 2023 00:20:47 +0800
Message-ID: <20231113162047.2213725-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113-grip-unstamped-7d5cb2e39d3e@squawk>
References: <20231113-grip-unstamped-7d5cb2e39d3e@squawk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023 13:45:00 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Nov 13, 2023 at 12:22:30PM +0800, Ji Sheng Teoh wrote:
> 
> > +config STARFIVE_STARLINK_PMU
> > +	depends on SOC_STARFIVE  
> 
> Please s/SOC/ARCH/ so I have one fewer instance to delete.

Thanks Conor, will change to ARCH_STARFIVE in v2.

> 
> > +	bool "StarFive StarLink PMU"
> > +	help
> > +	   Provide support for StarLink Performance Monitor Unit.
> > +	   StarLink Performance Monitor Unit integrates one or
> > more cores with
> > +	   an L3 memory system. The L3 cache events are added into
> > perf event
> > +	   subsystem, allowing monitoring of various L3 cache perf
> > events.  
> 

