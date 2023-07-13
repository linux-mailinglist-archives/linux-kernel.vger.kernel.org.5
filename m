Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F5B75235A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjGMNUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjGMNU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1EC2D51;
        Thu, 13 Jul 2023 06:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83CDA60C1F;
        Thu, 13 Jul 2023 13:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EC4C433CC;
        Thu, 13 Jul 2023 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689254415;
        bh=9LFKynASNpCdoV6akHpFvIz2tKVfjO0tuLEckI5k/xA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jjSRaWgPAdmx7R7Yk7cSErdoKEPD+nthBpuyQlbsJc0tk/Mqx6PGgFp/4j3PH8ZSJ
         jNXJoJ0AsSlTsP5YXS+Wege1huJowL9ihdk91jLWHg6/wqtiNWobJWba0C/ixJDWLP
         oT3EGt90GjWdcw65t9bRDEhITaGR1FaTlK1q4XWl8NMsLEQRxJxj1Y9cMd1beNUoCP
         ZSMN6PiANdq7xuZVN+mQZgkty0RrV7tC2YpuUiRLLSJt7cz0n9oC4Rwlq3WzQCePLu
         UKGpLldoTOpC2NeYqEOqPeidDFIhZbhr6cpbL9EaPNldYFdZwHDwnPFgML5TJnoo0j
         sC7zVc7SaHyCw==
Date:   Thu, 13 Jul 2023 14:20:10 +0100
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/1] leds: simatic-ipc-leds-gpio: add new model BX-21A
Message-ID: <20230713132010.GP10768@google.com>
References: <20230531155457.31632-1-henning.schild@siemens.com>
 <20230531155457.31632-2-henning.schild@siemens.com>
 <5109f2da-3b7f-421f-555c-810484d92b4c@redhat.com>
 <20230705124838.0e05177d@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230705124838.0e05177d@md1za8fc.ad001.siemens.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jul 2023, Henning Schild wrote:

> Am Thu, 1 Jun 2023 10:53:48 +0200
> schrieb Hans de Goede <hdegoede@redhat.com>:
> 
> > Hi,
> > 
> > On 5/31/23 17:54, Henning Schild wrote:
> > > This adds support for the Siemens Simatic IPC BX-21A. Its LEDs are
> > > connected to GPIO pins provided by the Intel Elkhart Lake pinctrl
> > > driver.
> > > 
> > > Signed-off-by: Henning Schild <henning.schild@siemens.com>  
> > 
> > Thank you for the patch.
> > 
> > Since this mostly touches files under drivers/leds I believe it would
> > be best for this to be merged through Lee's LEDs tree.
> 
> Lee i saw that your tree got merged recently. This one was not yet part
> of it.

That's correct.  Did I say that it would be?

-- 
Lee Jones [李琼斯]
