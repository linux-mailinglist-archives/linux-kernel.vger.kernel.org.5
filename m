Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB9E76D77E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjHBTMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHBTMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:12:15 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A1826B0;
        Wed,  2 Aug 2023 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=8WLpw6r5gAvcjcRiv8zlx0QGc4QyV5Z8Lyq6blhWPEk=; b=T
        I4T/GT2WUPvcY20vXyfr8xfGUq8ezI58z2FD6FQIvlo9xkcpuwneALGou7HZMTtbBQLXH2me8X51G
        p+gJTh1+n947WJJqiPOVsMhw4+m0Ncu5e4pYfG/AOb0FFU9+k3kC9bvWKW2cYaxJypnxxCCJkA8G3
        KG1QnpWSV2EVSD+Q=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:50458 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qRHGK-0003z2-IX; Wed, 02 Aug 2023 15:12:01 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        bruno.thomsen@gmail.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Wed,  2 Aug 2023 15:11:51 -0400
Message-Id: <20230802191153.952667-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 0/2] rtc: pcf2127: add default battery-related power-on values
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series adds support for setting default battery-related
functions for RTC devices.

This evolved from previous discussions about PCF2127 and also when reviewing
PCF2131 driver:

Link: https://lore.kernel.org/linux-rtc/20190910143945.9364-1-bruno.thomsen@gmail.com/
Link: https://lore.kernel.org/linux-rtc/20191211163354.GC1463890@piout.net/
Link: https://lore.kernel.org/linux-rtc/20230123170731.6064430c50f5fb7b484d8734@hugovil.com/

I decided to add these two new DT properties as generic RTC properties, in the
hope that they can be reused by other RTC drivers if needed.

Patch 1 adds two new DT properties to set battery-related functions. These
properties are generic for all RTC devices.

Patch 2 adds support for these two new DT properties to the PCF2127 driver.
This is especially important for PCF2131 devices which have default PWRMNG
values which disable battery-related functions.

Thank you.

Hugo Villeneuve (2):
  dt-bindings: rtc: add properties to set battery-related functions
  rtc: pcf2127: add support for battery-related DT properties

 .../devicetree/bindings/rtc/rtc.yaml          | 19 ++++++
 drivers/rtc/rtc-pcf2127.c                     | 59 +++++++++++++++++++
 2 files changed, 78 insertions(+)


base-commit: 3c87b351809f220294aec3c0df7b078ff5c5b15b
-- 
2.30.2

