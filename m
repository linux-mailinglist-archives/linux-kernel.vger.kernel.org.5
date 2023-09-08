Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE94798EE0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbjIHTM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbjIHTMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:12:40 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5565AE4B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 12:12:27 -0700 (PDT)
Received: (qmail 792929 invoked by uid 1000); 8 Sep 2023 15:12:26 -0400
Date:   Fri, 8 Sep 2023 15:12:26 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@kernel.org>, quic_jjohnson@quicinc.com,
        nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
        matthias.bgg@gmail.com, kuba@kernel.org, srini.raju@purelifi.com,
        stf_xl@wp.pl, helmut.schaa@googlemail.com, pkshih@realtek.com,
        corentin.chary@gmail.com, hdegoede@redhat.com,
        markgross@kernel.org, johannes.berg@intel.com,
        alexander@wetzel-home.de, error27@gmail.com,
        szymon.heidrich@gmail.com, gustavoars@kernel.org, lynxis@fe80.eu,
        daniel@makrotopia.org, arnd@arndb.de, shayne.chen@mediatek.com,
        keescook@chromium.org, tglx@linutronix.de, pabeni@redhat.com,
        rostedt@goodmis.org, jacob.e.keller@intel.com,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.5 43/45] Fix nomenclature for USB and PCI
 wireless devices
Message-ID: <0d2ddf90-2334-4d0c-9f63-018c150e06a9@rowland.harvard.edu>
References: <20230908181327.3459042-1-sashal@kernel.org>
 <20230908181327.3459042-43-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908181327.3459042-43-sashal@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 02:13:24PM -0400, Sasha Levin wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> [ Upstream commit 5d7cf67f72ae34d38e090bdfa673da4aefe4048e ]
> 
> A mouse that uses a USB connection is called a "USB mouse" device (or
> "USB mouse" for short), not a "mouse USB" device.  By analogy, a WiFi
> adapter that connects to the host computer via USB is a "USB wireless"
> device, not a "wireless USB" device.  (The latter term more properly
> refers to a defunct Wireless USB specification, which described a
> technology for sending USB protocol messages over an ultra wideband
> radio link.)
> 
> Similarly for a WiFi adapter card that plugs into a PCIe slot: It is a
> "PCIe wireless" device, not a "wireless PCIe" device.
> 
> Rephrase the text in the kernel source where the word ordering is
> wrong.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Link: https://lore.kernel.org/r/57da7c80-0e48-41b5-8427-884a02648f55@rowland.harvard.edu
> Signed-off-by: Sasha Levin <sashal@kernel.org>


Is there any real reason to apply this commit to the -stable kernels?
I did not mark it that way when it was submitted, and it doesn't fix
any bugs.  In fact, aside from updating some module and device
description strings, all it does is change a bunch of comments.

Does that really fall under the -stable rules for acceptance?

Alan Stern
