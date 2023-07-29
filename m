Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AB3767EE4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjG2LzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG2LzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:55:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9690CE7D;
        Sat, 29 Jul 2023 04:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30CE760BAC;
        Sat, 29 Jul 2023 11:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C46EC433C8;
        Sat, 29 Jul 2023 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690631711;
        bh=9UMhb9z1YuThHkFflZyDlXDCl5omiIFhG7wms9aKdGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JzNhlLTNpAKviHX0jLeRQhg2DaKiFcgrFWNxrxMtt+QRNXsjOYEmtub1f7pNf59uB
         GXcIESzkMO9HVXcOygQ9XnaiXz4nbbf+p54aEL9nxSOOwzxYz1PcHAmc4AHuKw6nlv
         fT0IRORJgjw7UzmDwjSnV/O9ii0oXtYMIpgaHE/+rarbGXqhsU1Z9XgxVxnPKcj7Oh
         I2MrStPXRT3PaUcAomq8cYZWKczbp/pvytF3M7OYG+pWdM/kBQbOV77RZmKHbuQdcu
         JWjMK/L6/p3+LIuP+Elx6YRhGyM+D3v/2iFqdRZhwrw1etAmDh3HvOYsfgOlvH5KZ1
         AsQIG2AU/oDAg==
Date:   Sat, 29 Jul 2023 12:55:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: admv1014: make all regs required
Message-ID: <20230729125516.68a29852@jic23-huawei>
In-Reply-To: <BN6PR03MB3395F9139A225AA97A100B829B01A@BN6PR03MB3395.namprd03.prod.outlook.com>
References: <20230727113136.98037-1-antoniu.miclaus@analog.com>
        <7f7d1c90-9969-66bd-fd71-defffe0e05d6@linaro.org>
        <BN6PR03MB3395F9139A225AA97A100B829B01A@BN6PR03MB3395.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 12:02:04 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Sent: Thursday, July 27, 2023 2:47 PM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>; jic23@kernel.org;
> > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > conor+dt@kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] dt-bindings: iio: admv1014: make all regs required
> > 
> > [External]
> > 
> > On 27/07/2023 13:31, Antoniu Miclaus wrote:  
> > > Since the regulators are required in the driver implementation, make
> > > them required also in the bindings.

This bit is probably not strictly true.  Try no providing them and you will
probably find stub regulators created on assumption they are fixed regs
that we aren't interested in controlling.

> > >  
> > 
> > The true reason should be whether the hardware requires them. Because if
> > hardware does not need some, the driver should be fixed.  
> The datasheet is not very explicit on this topic, but all the specifications of the
> part are built around these pins being supplied.
> Moreover, the evaluation board or the part comes with all VCC pins connected
> to fixed supplies.

Agreed - these should be required in the binding.

There was an old disagreement on this in which it they were not marked
required in some bindings because the regulator subsystem would assume they
were fixed supplies that were just missing in the DT and so provides stub regulators.
My understanding at least has changed and now we mark the required even if
the driver works fine on some boards without them being supplied.

Note though that this means the whole of trivial-devices.yaml is garbage
as very few devices actually work without any power :)

Jonathan



> > Best regards,
> > Krzysztof  
> 

