Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36CE800381
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377505AbjLAGEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLAGEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:04:01 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6EA193
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:04:07 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 0B2706051E;
        Fri,  1 Dec 2023 06:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701410646;
        bh=D3R8pMk7bcyOGztgEA/pmCCQH/Yh4ZGSBEhS10gOJeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l1nLbtEWCwh14njae91OgM+A4h6K6GXiNxlvllnLxIx0+t+yZF7czaqX53YkVjVXs
         2PSeZMeKpHnwLqw1/HgW9TsKuHjFpIgyhgZqzyFm/5HqjIMKe9CPYuU7JB4EHl+R8X
         qQ0tyMwkFZhMm2wBW2kaNARiU+TT3jLPgT24JayTNHLHCxdP+00QCPheln7mQxoQSD
         zeqQIELkRsp+4TyvL183szCRMEBl59r640094kNg6Y8YqoOdIR75HGWitCe9DJoWS1
         Dkn6A+O66IaaNdPqUV4fHCsfpLU1mJsywUvCUPi2Ia2zJKXpYaGRkGbgJeO8hue3Tt
         WKkf5p489Bg2A==
Date:   Fri, 1 Dec 2023 08:03:46 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Message-ID: <20231201060346.GE5169@atomide.com>
References: <20231130231657.12715-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130231657.12715-1-francesco@dolcini.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Francesco Dolcini <francesco@dolcini.it> [231130 23:17]:
> Increase CONFIG_SERIAL_8250_NR_UARTS from 4 to 8, the current legacy value
> is not adequate for embedded systems that use SoCs where it's common to
> have a large number of serial ports.
> 
> No need to change CONFIG_SERIAL_8250_RUNTIME_UARTS, see commit 9d86719f8769
> ("serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS").
> 
> This enables using the UART connected Bluetooth device on Verdin AM62
> board.

OK makes sense for distro use.

Disabling unused ports leads into port names shifting, which we still can't
easily tolerate until we have the DEVNAME:0.0 style addressing available for
ports. So for now we still depend CONFIG_SERIAL_8250_NR_UARTS, eventually
that too should become just a legacy ISA port array.. Meanwhile:

Reviewed-by: Tony Lindgren <tony@atomide.com>
