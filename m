Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850DB7FB92A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjK1LOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjK1LOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:14:37 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5152A109;
        Tue, 28 Nov 2023 03:14:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E1D4DC0010;
        Tue, 28 Nov 2023 11:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701170081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNMFjNjhLifrVaW3Buhm2wwZKds2TKBlbyAc5QrDcaY=;
        b=Vml2hN5pEcw7TUf/ybH0i7LwpD1b1TL9sQUO/hvpAPaUF62CV97I1tQe6NZXWCeVMrHCtw
        COFNBb6EEo89EagWG7JPAHnlKq7COnbihZFg8afIFF6GtQsl3QzmmDXnZpWTSDCD/s77oA
        EWSa2+MYAVTCi9vfLu3DHaxTQc1D45n14VG+k/GvPVG6xyQI9oQWB8TQAmHBK85L5+aeCX
        LvvQvq+3Y8ZbsPjUW5fM3PypWPlYuEub2IP/lrzpReN0q6Sil2nizWQPYYSZ5CJpnzmrLz
        0SZxhnEkxfgXIH3ii1obKmHnzjiXTjp/9Q23WLsIngm3xYtjh98ZhUo7k+JXYA==
Date:   Tue, 28 Nov 2023 12:14:39 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jeff LaBundy <jeff@labundy.com>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: input: touchscreen: goodix: clarify
 irq-gpios misleading text
Message-ID: <20231128121439.1c4c7f8e@booty>
In-Reply-To: <729e43fb-bc01-4d68-ba1c-5874b5428b63@linaro.org>
References: <20230925032208.11698-1-luca.ceresoli@bootlin.com>
        <169565910910.1468857.379234431707593994.robh@kernel.org>
        <20231128102105.4d901b3a@booty>
        <729e43fb-bc01-4d68-ba1c-5874b5428b63@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

On Tue, 28 Nov 2023 10:22:27 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 28/11/2023 10:21, Luca Ceresoli wrote:
> > Hello Rob,
> > 
> > On Mon, 25 Sep 2023 11:25:09 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >   
> >> Acked-by: Rob Herring <robh@kernel.org>  
> > 
> > I can't find this patch in your for-next, is there any blocker I should
> > handle?  
> 
> This was an Ack, not applied from Rob. Intention is that bindings go via
> subsystem maintainer (here: Dmitry).

Thanks for the clarification!

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
