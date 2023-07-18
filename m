Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ADA7588A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjGRWnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjGRWnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15FA198E;
        Tue, 18 Jul 2023 15:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 705C1612CE;
        Tue, 18 Jul 2023 22:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AC6C433C7;
        Tue, 18 Jul 2023 22:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689720179;
        bh=KRMygVN5jZYm75AeHEbT7m8aCXoMDnLH4Nzw6q1KO5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFXw8MwIG0ykGM5KJHXJgBUllUkcD41aJyN3dELWmyFoYDw6tL1MYPE+n+0mKG+ny
         RyDhw1jH9AM0iHvkKl/gDYNEnOEBvcMS+KAqgflt8lHOOShm9FoW+gfh2UdP9AS1Xe
         X41a6AD0IzY3cdfe67vvuWIprBu9EnWvG/WSXQW90ezfu7Qbyr0l/warnnmfYLc1z8
         aVWpwofaN5QHO60JX0l10KBKIDg2JwjAGcAyiOLV/rWuLMThSd2td+2L+I8bRTasB+
         txYEX7uUdlwCoL4U5mRL0v95rxNfaZoeiamPHgsGCcY5JeWJ7TcXGj7BI3LjmPFmZY
         7yW4U6atL1fLw==
Received: (nullmailer pid 2145837 invoked by uid 1000);
        Tue, 18 Jul 2023 22:42:57 -0000
Date:   Tue, 18 Jul 2023 16:42:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] of/irq: Export of_irq_count()
Message-ID: <20230718224257.GA2144433-robh@kernel.org>
References: <20230717205357.2779473-1-samuel.holland@sifive.com>
 <20230717205357.2779473-2-samuel.holland@sifive.com>
 <CAHp75VeD=R2kp4wbCkJUEzi3TP4GXAhciAdWkQm247tgwR7-Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeD=R2kp4wbCkJUEzi3TP4GXAhciAdWkQm247tgwR7-Ww@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 12:40:53AM +0300, Andy Shevchenko wrote:
> On Mon, Jul 17, 2023 at 11:54 PM Samuel Holland
> <samuel.holland@sifive.com> wrote:
> >
> > This function is used by the SiFive GPIO driver. Export it so that
> > driver can be built as a module.
> 
> Can we rather reduce use of of_*() APIs?
> For example, why not use platform_irq_count()?

+1
