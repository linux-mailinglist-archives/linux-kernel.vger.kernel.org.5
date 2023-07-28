Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6756E76766E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjG1Tgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjG1Tgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:36:44 -0400
Received: from abi149hd126.arn1.oracleemaildelivery.com (abi149hd126.arn1.oracleemaildelivery.com [129.149.84.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9BA30DA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=WvVvdhVMzarAPgKSDz+57haMY2V5DGCr8AR4QPbT3O8=;
 b=rukcSh68Gpps9upIqEQ+y8jUK2Frk5bbMPYpsWWB6hVV0+QszLKHOFxoNru4LcpPgXpG6Y3XB1JM
   Ur0J7r4wi8zMZpgbtaM+7r9DFNR3hG9xwp0SikiW99DfJo+SNHyn+nWyUulY6uc4NA05ndeUYw8Q
   qGMty3/Z0GdDxhoTxBAGS4RkWY9l7PifP6iKJ/fXNryUYefS/7x9IX/l9RggUkFmjDUBiNLtdJH0
   WKib2lM0kKZiJrtrM44G92f2/wGGi4dvZCYW7xr1khj4Lb2kZfUXqfwn6wLzwPsw9A7msLuuPCwF
   5fDQcAb10oRow7xHK01yT0bDs4t0Lg13GyICCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=WvVvdhVMzarAPgKSDz+57haMY2V5DGCr8AR4QPbT3O8=;
 b=SYtVKkXGqHHS59unG/tWwhvB675j1bHk3qDavnHzZYqt7klKnHk93h6UPZWnqW/NadhHew0jsV0G
   59deC+Z7HvlIq7t7BkjTuNR773lp9wAQFR3m7E6ZGVOS33MhOwe2Syj8GrWip4omm42y69VFZy+K
   C2FRI1/zDc6vqCKS/ZE1ywI2CGjOzcRYB8NAgTBztBmAGBj99M4wCw8OBiJKADqaXm8l7ns9m+lj
   0bGexf3o/OyCVxCaJyLIu3oRxfVm5YPUh0tsLafqDFmWJcIIk3s4//B4vnw7pEdBw/4c59PYNf/f
   KDVY0xXMYfVZTiVtFrbDb0X2wix6fVn7P3BpiA==
Received: by omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RYI0063EUH39Y10@omta-ad1-fd3-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-kernel@vger.kernel.org; Fri, 28 Jul 2023 19:36:39 +0000 (GMT)
Message-id: <a1b7de54-53ec-0899-eaf6-e1c3d3d15f56@augustwikerfors.se>
Date:   Fri, 28 Jul 2023 21:36:36 +0200
MIME-version: 1.0
Subject: Re: [PATCH v2] ACPI: resource: Add a quirk for Lenovo Yoga 7 14ARB7
Content-language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, regressions@lists.linux.dev
References: <20230728191408.18141-1-mario.limonciello@amd.com>
From:   August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20230728191408.18141-1-mario.limonciello@amd.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAFMx/BI9+2fEpnCAiiG34Fma+jsCm2JEnzmZKHoPTgqTmh1iK3C2jNizYSEZhxg
 ICQN8F9QebZzzi7+Kc5bzFZlY3aynMC72svASZ/o9hBhYw+McTZ+1162lU1E88Dw
 wbzCJDmhIDs9MKVOqypVr8m8JMVsf8+Vm+aKS+Q8CUcK6Q+t4pFjCoRSG1lT9UqY
 2CnoNZIAdY2Ogo2jgjdxosOfgFPqY8LmaJmiOlSkrC/rwyfE2ZDQg/iuDrKhTUwf
 Eism/KUOaBHXiWzW8/utBFt+zT8EvUaV8eJrrenhpVIlOwB32A5oXEnesBaoSb4x
 iFsiV0Kef0dsFxFoUjSjqaH5TG7QBcQVhehHTWbWECmZN7xefnZCad/6ivFMMmV9
 YPEroZTt5WsWPhfclWjTwC1rosAcNBZ2CcaP4BSjuBzjRU5uOro4i9uB4TFKTLqk tTujkrA=
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-28 21:14, Mario Limonciello wrote:
> Lenovo Yoga 7 needs to have keyboard interrupt signaling polarity
> is incorrect in the MADT and the value from the DSDT should be used.
> 
> Reported-by: August Wikerfors <git@augustwikerfors.se>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217718
> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: August Wikerfors <git@augustwikerfors.se>

Thanks!
