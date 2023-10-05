Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08F37BA3F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjJEQCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbjJEQA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:00:58 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17982469E;
        Thu,  5 Oct 2023 06:52:04 -0700 (PDT)
Received: from [192.168.68.112] (ppp118-210-84-62.adl-adc-lon-bras32.tpg.internode.on.net [118.210.84.62])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5D962200DB;
        Thu,  5 Oct 2023 11:14:56 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1696475698;
        bh=R7cbZEGmJy2Gw2vxwUa3TW2M1e1bape91R+3bvKvVu0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=O34P3A/oGQNwIozMFMzAjDAioU17wp3c9h1nOMZ7RV8TgQXElvFBqhe4Bsbl8fE3x
         gQJHr4JcMw0cY+ZWvzT4kdJUNrBlJY268m03OdYVbLkUGQxAsG2UsnZSHZkVBfy/ud
         Ijx6ZjbiaRGBK5PJQOHlqpK/zAbkif3zrnpSQ4DHsBw/vEdgEDH2Dkffu3UU5j4eKu
         MRDmWH4T+LbN/9/q9UkU98aF7+68IUsY6WlrKbKEy7JE2euX6wE7QhXOhK9C7SBe/D
         dFxN+kL91aUD6hgp+qRN2ZtZi7wnw91jBnLcYB5RQCJFiBsHw/M9m/+6dufL4msv8U
         Iljyq3ilKd4/g==
Message-ID: <3bf55144b8169a8f44c67e9a6b63cc67a2edfa50.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] pinctrl: aspeed: Allow changing SPI mode from
 hardware strap defaults
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Zev Weiss <zev@bewilderbeest.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org
Cc:     openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Oct 2023 13:44:54 +1030
In-Reply-To: <20231005030849.11352-2-zev@bewilderbeest.net>
References: <20231005030849.11352-2-zev@bewilderbeest.net>
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

On Wed, 2023-10-04 at 20:08 -0700, Zev Weiss wrote:
> Some platforms unfortunately have their SPI mode selection bits
> strapped incorrectly (such as being configured for passthrough mode
> when master mode is in fact the only useful configuration for it) and
> thus require correction in software.  Add the SPI mode bits to the
> GPIO passthrough bits as the exceptions to the read-only rule for the
> hardware strap register so that the pinctrl subsystem can be used for
> such corrections.
>=20
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks!
