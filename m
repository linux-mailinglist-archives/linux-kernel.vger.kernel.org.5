Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74E75ACDD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjGTLUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGTLUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:20:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CF9123;
        Thu, 20 Jul 2023 04:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E3161A35;
        Thu, 20 Jul 2023 11:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258A6C433C9;
        Thu, 20 Jul 2023 11:19:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="j33a19lI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1689851996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bcIYInu7A8RRI76RRA4HzZStywPsn3yPNSRuU259k1s=;
        b=j33a19lIW8dmudB8/yos7Awz0mDxKB/9/C74EhjaZg4guqXJeAdPlJQrlOXTHEiokrP3xx
        kOYD3+p4wZqiGfiuQc1+CYrElTfAPH0ATehT+s6FGRFbHSkitcmszlvciEUItAlOJ3V1Py
        SIT4sInhksw57Ozx4OUlp9dBq55IZ74=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 03c522f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 20 Jul 2023 11:19:54 +0000 (UTC)
Date:   Thu, 20 Jul 2023 13:19:52 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: convert syna,rmi4 to DT schema
Message-ID: <ZLkYWL4wMhYLRTuL@zx2c4.com>
References: <20230720110008.133359-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720110008.133359-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 01:00:08PM +0200, Krzysztof Kozlowski wrote:
> Convert the bindings for Synaptics RMI4 bus and devices to DT schema.
> Changes during conversion:
> 1. Add reset-gpios already used in DTS and mentioned by RMI4
>    specification.
> 2. Do not require address/size cells, because without functions
>    (children) they aren't really needed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Jason, Matthias, Vincent,
> I put your names as maintainers, because moderately recently you were
> changing the driver. Let me know if this is okay or you prefer not to
> maintain the hardware.
 
I'm more of the occasional "why doesn't my new Thinkpad work?" sort of
drive-by RMI4-er, rather than an actual maintainer. I don't know a lot
about the protocol beyond what it takes to drag a laptop into behaving
right. So maybe best to leave me off the list.

Jason
