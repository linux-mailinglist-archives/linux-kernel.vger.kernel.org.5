Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D731C7AA7D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjIVEdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIVEdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:33:01 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A0122;
        Thu, 21 Sep 2023 21:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1695357173; x=1695616373;
        bh=ky/I5+eIsKo29UW7LB/TUWn+eMis8pbYkCdUWOTJTCU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=lebD5170GbFvzAq/iof9+JOGY3rOV27SIS+0NKBm9tuYXpVXB+1J1GKAddb0ibn0P
         guS+eAyJGJooecutx8cudw6Z22TrBDrRawLwi7Oah6H4acHuTghd68pgMpgJzWuZxM
         cagXhLrN2nO8YPHKVUFBfHsjkTf1Xyof+NXAsb8Y13FK0SKyx+xDLi4pw6u2UHeq6R
         vpKccgp2XCREA6CUm9o1Ka1sPXN8kI2wccFRzzm1uBudC//ch29WdlGBnBtPmYg75/
         E4I7PGTxdUMveQglqThgqSH/q/FTLIASrHHvwOtq0/l7id1ifzeZSb5WFrPE2B+uid
         Sjt2qutVJIcOg==
Date:   Fri, 22 Sep 2023 04:32:41 +0000
To:     Johannes Roith <johannes@gnu-linux.rocks>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     jikos@kernel.org, andi.shyti@kernel.org,
        benjamin.tissoires@redhat.com, christophe.jaillet@wanadoo.fr,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v7] HID: mcp2200: added driver for GPIOs of MCP2200
Message-ID: <87r0mqhlp6.fsf@protonmail.com>
In-Reply-To: <20230921164928.170383-1-johannes@gnu-linux.rocks>
References: <20230921164928.170383-1-johannes@gnu-linux.rocks>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep, 2023 18:49:28 +0200 "Johannes Roith" <johannes@gnu-linux.ro=
cks> wrote:
> Added a gpiochip compatible driver to control the 8 GPIOs of
> the MCP2200 by using the HID interface.
>
> Using GPIOs with alternative functions (GP0<->SSPND, GP1<->USBCFG,
> GP6<->RXLED, GP7<->TXLED) will reset the functions, if set (unset by
> default).
>
> The driver was tested while also using the UART of the chip. Setting
> and reading the GPIOs has no effect on the UART communication. However,
> a reset is triggered after the CONFIGURE command. If the GPIO Direction
> is constantly changed, this will affect the communication at low baud
> rates. This is a hardware problem of the MCP2200 and is not caused by
> the driver.
>
> Signed-off-by: Johannes Roith <johannes@gnu-linux.rocks>
> ---

Reviewed-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

