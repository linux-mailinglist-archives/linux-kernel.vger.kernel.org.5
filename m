Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86E476C4DC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjHBF12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHBF10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:27:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4207CC6;
        Tue,  1 Aug 2023 22:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF274617C4;
        Wed,  2 Aug 2023 05:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF52C433C7;
        Wed,  2 Aug 2023 05:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690954044;
        bh=azM3bcFJeWc/QfFcM1GLP+oyJesxpNRDvkBEwKapPVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PquN6SH5qSNL/QpI9d6APdUMX7krzrOugE45kPfPFLFLu6+lFBwPTO92BsE/Ljm+l
         QLhO19ojv4MXz7cdZ0IH4TfKN6Idd8rH9CeDJs+CJiZ19ZyYGw9PeKKczDzqlMqTSC
         pHCY1+Un92ZXedh+C1EI3MKH8MzU34DtTYI1Nb0c=
Date:   Wed, 2 Aug 2023 07:27:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Stanley Chang <stanley_chang@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue
 layer driver
Message-ID: <2023080232-stowaway-resisting-fe39@gregkh>
References: <20230801092541.25261-1-stanley_chang@realtek.com>
 <20230802011400.v4jim6ajsqc3tvei@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802011400.v4jim6ajsqc3tvei@synopsys.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 01:14:09AM +0000, Thinh Nguyen wrote:
> > +MODULE_LICENSE("GPL");
> 
> I'm not familiar with licensing much, but can the SPDX header indicates
> different version than the module license?

They match, so I do not understand the issue.  Look at module.h for a
list of what the different strings of MODULE_LICENSE() mean for details.

thanks,

greg k-h
