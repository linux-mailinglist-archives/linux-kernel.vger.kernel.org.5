Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBC177CEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbjHOPNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbjHOPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:13:13 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DDC1BC1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:13:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D81A20004;
        Tue, 15 Aug 2023 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692112383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eHudGMEyhYeKG88YzAkDWG9Nax8kvFylfT1Z2ot33EM=;
        b=ZyDYyxi88xv2zoXsgP4HpMgAdt28vf7rZTYrbUkxG2X3HNczJfbbGwrQ3jLQ3hbMO9Dced
        x/zG0jG5awb3gxWYLEpHnjq9nwGeW1zGWg5nAnOKDBguzLuWhPERyaNDBDXZvy2P6HKjM7
        6cAxo9gYo+qG0l8zAQfh3DsnoGKPEC0Wq3G6mR8h8qR1fNWYFRVeLKNlc2mFDC8GoJKgNJ
        McuHfcJ/OxjP+whZaHdVa8nAmehlQC9bwF3jCuYPVB4yKQTaYXgiiSlQyGd7FTOJ2eF5eY
        5scrL/n9rql6maJBYnwBLOGWh50eNDKCaPegocmGTzBSGtGD66v49tn253VzrA==
Date:   Tue, 15 Aug 2023 17:13:01 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v1 1/1] minmax: Deduplicate __unconst_integer_typeof()
Message-ID: <20230815171301.6076cbc0@bootlin.com>
In-Reply-To: <20230815113534.10592-1-andriy.shevchenko@linux.intel.com>
References: <20230815113534.10592-1-andriy.shevchenko@linux.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, 15 Aug 2023 14:35:34 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> It appears that compiler_types.h already have an implementation
> of the __unconst_integer_typeof() called __unqual_scalar_typeof().
> Use it instead of the copy.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> As the initial code is in Linux Next via ASoC tree, it's assumed
> to go via that tree as well.
> 
>  include/linux/minmax.h | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
> 

Sure. I missed the __unqual_scalar_typeof(). Sorry.

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
