Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DCA774FCE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjHIA3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHIA3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:29:01 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC701995;
        Tue,  8 Aug 2023 17:28:59 -0700 (PDT)
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A4E9D20172;
        Wed,  9 Aug 2023 08:28:57 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1691540937;
        bh=KZQz3C4EK4svAfJjrGrSxyQuWjZmE8LD+H2VcJuXgmw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Mysbv6IrcmrKmUowjZT/O2GUGqDVxT2o6q6SlMAcaEHU1AO3oOjGvWPAghvq46qaV
         th8Crr7ZRgElbViQb5onYGUT4EF6Yqf2K+I53cUZm5hsl57VLJts7j31c8z/v06dJ+
         iCwzbAPABRShFTXcl9mcvn9C7/XmP2JFtP42tDO5vshiFl+IH3qoU30wjWudyhohH7
         9T/WnvEyKDUx0byTCfVtXeYi9YNzhvhBQp7pjOUKX2xLKZAa5IhXlGxUIuqz72MzIk
         zvkcNAQe/fhEgB8Bf0jyot7zH7yOd4IEA8O0B9C7+OrWXKAGbWuLrXXQKwR2MVWJRC
         7IeEXWzNBMdyA==
Message-ID: <a670192024911f7f2d676e245f5f240e9ed5126b.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/3] Add Aspeed AST2600 I3C support
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Dylan Hung <dylan_hung@aspeedtech.com>,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@aj.id.au, p.zabel@pengutronix.de,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     BMC-SW@aspeedtech.com, kobedylan@gmail.com
Date:   Wed, 09 Aug 2023 08:28:57 +0800
In-Reply-To: <d8d577e91779e045d5a2c7d701f65133a15b5d64.camel@codeconstruct.com.au>
References: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
         <d8d577e91779e045d5a2c7d701f65133a15b5d64.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dylan,

> - with no changes needed to any bindings. I haven't needed any other
> resets; are there per-controller resets specified in the HW docs you
> have?

... keeping in mind the reset control that the aspeed SCU driver
already provides for you, when you enable the appropriate clock gate:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/clk/clk-aspeed.c#n224

Cheers,


Jeremy
