Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815A876A87C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjHAFsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjHAFst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:48:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095AB1FCA;
        Mon, 31 Jul 2023 22:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A1661473;
        Tue,  1 Aug 2023 05:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A2FC433C7;
        Tue,  1 Aug 2023 05:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690868923;
        bh=CSYR83m0hWJjYjIRujwvyFiMN2MH6lGieHS+KpcH5TI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+v+oBPjg7WgK2jhl4qBub9O18tXXnx6yR9HpjbyTlMTq9j8VrdTh2kEtcaJVlg7o
         sy4fvYWyyOeeGWhGez0j+4ln+DJHQxEQOJQALxK2wxNEOlvwQiTgJN1yCJJoVGWFqD
         ypC6WdR6ijmYOJLItZ5htFUzFNLsgyH0cDPpWG4w=
Date:   Tue, 1 Aug 2023 07:48:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/3] PM / wakeirq: fix wake irq arming
Message-ID: <2023080129-district-punk-3da3@gregkh>
References: <20230713145741.30390-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713145741.30390-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:57:38PM +0200, Johan Hovold wrote:
> When reviewing the Qualcomm serial-driver suspend implementation I
> noticed the odd runtime PM state update which had snuck in. Turns out it
> was added to work around a bug in PM core which prevented drivers not
> implementing runtime PM from using dedicated wake irqs.
> 
> This series fixes the wake irq arming and drops the unused wake irq
> enable helpers before dropping the bogus runtime PM state update in the
> Qualcomm driver.
> 
> I suggest that Rafael takes all of these through his tree.

I agree:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
