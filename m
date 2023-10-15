Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F867C9BB2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 23:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjJOVC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 17:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOVC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 17:02:56 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFD9B7;
        Sun, 15 Oct 2023 14:02:54 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03FF51BF203;
        Sun, 15 Oct 2023 21:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697403773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Y+OVMmYlFPzuUi7xiFYuWXvjmH0z07SQ3F3rVS2El4=;
        b=djihpRT8NL5vB9Qo5i4K6Qfw0aYNGcyymKRwfQUDJ+etW7Kir+tKiAuBkTf1wLJDl4DUR9
        pxNnYYWyuRAykXtTij0V6dXYXswSIRfOsJ0XJFr+I1ac86ekKZa3RDPK6F2z4aGZwvtkm9
        xDl2+t5950mZD276g1LcGR+s2CaoHNZUJxyaFmL0o/O/PAGNh4T21dwPB9EGtOuL9cHwKq
        1nT+XzMufPn+v4hTQov7ekPH4kbRsclyfG5ogDBhKMGpNQuSckz5n+z+O01zESn0YvmZEG
        KAS596+Iqr4k3KCOMgAOnwpI0joV3WEDJgQO04YlPC4NnzoLEr4IOmtll89+dg==
Date:   Sun, 15 Oct 2023 23:02:52 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf85363: fix wrong mask/val parameters in
 regmap_update_bits call
Message-ID: <169740375017.169509.12472808728728079735.b4-ty@bootlin.com>
References: <20231013-topic-pcf85363_regmap_update_bits-v1-1-c454f016f71f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013-topic-pcf85363_regmap_update_bits-v1-1-c454f016f71f@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Oct 2023 16:34:21 +0200, Javier Carrasco wrote:
> The current implementation passes PIN_IO_INTA_OUT (2) as a mask and
> PIN_IO_INTAPM (GENMASK(1, 0)) as a value.
> Swap the variables to assign mask and value the right way.
> 
> This error was first introduced with the alarm support. For better or
> worse it worked as expected because 0x02 was applied as a mask to 0x03,
> resulting 0x02 anyway. This will of course not work for any other value.
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf85363: fix wrong mask/val parameters in regmap_update_bits call
      commit: 2be36c09b6b07306be33519e1aa70d2e2a2161bb

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
