Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AAB763072
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjGZItp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjGZItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:49:19 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7075B8C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:42:29 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 587334d6-2b90-11ee-b3cf-005056bd6ce9;
        Wed, 26 Jul 2023 11:42:25 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 26 Jul 2023 11:42:25 +0300
To:     =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9?= Javier 
        <JoseJavier.Rodriguez@duagon.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?B?U2FuanXhbiBHYXJj7WEs?= Jorge 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: Re: [PATCH 0/3] 8250_men_mcb: Make UART port autoconfigurable
Message-ID: <ZMDccXK4N4ZEwsPn@surfacebook>
References: <20230705131423.30552-1-josejavier.rodriguez@duagon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230705131423.30552-1-josejavier.rodriguez@duagon.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jul 05, 2023 at 01:14:51PM +0000, Rodríguez Barbarin, José Javier kirjoitti:
> Make configuration be handled by the 8250 UART subsystem

Actually this is not the best idea. 

> to avoid weird behaviours 

The opposite.

8250 detection is full of quirks and was developed to handle tons of different
UARTs when the driver was in a single file. Since you have a separate 8250_*.c
module for your UART and you _know_ the type beforehand, why on earth you need
to rely on the old and maybe not very suitable code? Have you thought about
corner cases with IRQ detection, for example?

> and for better maintainability.

The opposite.

I don't know if it affects your hardware to the date, but it may be different
for the future models, or models that you hadn't tested.

That said, I highly recommend to reconsider.

-- 
With Best Regards,
Andy Shevchenko


