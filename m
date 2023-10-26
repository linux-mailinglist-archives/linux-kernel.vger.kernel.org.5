Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51F77D8450
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbjJZOOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjJZOOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:14:48 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99A41AA;
        Thu, 26 Oct 2023 07:14:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7841224000C;
        Thu, 26 Oct 2023 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698329683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W5fFxhCOIYscZBRprzniuQ2/sqUzxXjEob/R9onjmmU=;
        b=S5gKKvTTOlDQVxRGeXo1NbJLAwFsIjZLgIXFKbYYtNjfPXI9t1bfYGE+2URKYJsdCEp2TQ
        BPHrYl3vzD0847Q4bCsHsU2F5DunNwS10rA81t1uWjWOqZgkazNyjeLV/68HL8q4KWX48d
        TZ3WjFPpHeiKeFejZ65gzM83H6eQo+Zvp6aexWa18Qxlr+sj8pC9jo4HvCpAdHnTIhKBVm
        a/B1eZ3io7FGIJsAlH6ImJmNyhcXsm1SdpcCeEzFst7KH72+iK5NOKtAn28Z8s7jGYYbeA
        P/9VTaloQXo5k9Z04EDdnf0Pc8gP9iJAuv41BMuEXeqS3UsuJN5nzu8vjzy/8A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 26 Oct 2023 16:14:42 +0200
Cc:     "Russell King" <linux@armlinux.org.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>
To:     "Linus Walleij" <linus.walleij@linaro.org>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 2/6] tty: serial: amba: Use BIT() macro for constant
 declarations
Message-Id: <CWIFML5MV4EL.2YHI3RC2NQ0BI@tleb-bootlin-xps13-01>
X-Mailer: aerc 0.15.2
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
 <20231026-mbly-uart-v1-2-9258eea297d3@bootlin.com>
 <CACRpkdaBGRsH3q9xY5-YuvgO4jXSr9x-+wZZ4bPXByZbrHt4Qg@mail.gmail.com>
In-Reply-To: <CACRpkdaBGRsH3q9xY5-YuvgO4jXSr9x-+wZZ4bPXByZbrHt4Qg@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu Oct 26, 2023 at 3:37 PM CEST, Linus Walleij wrote:
> Since you don't know where this header may be included, you should
> add #include <linux/bits.h> at the top of linux/amba/serial.h
>
> With that fixed:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Clearly, thanks for that.

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
