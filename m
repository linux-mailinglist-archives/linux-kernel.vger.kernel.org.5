Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAE37F97E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjK0DXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0DXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:23:04 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8B58F;
        Sun, 26 Nov 2023 19:23:10 -0800 (PST)
Received: from [192.168.68.112] (203-57-215-234.dyn.iinet.net.au [203.57.215.234])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3F42420034;
        Mon, 27 Nov 2023 11:23:03 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1701055389;
        bh=9Y12ePRBana+i/gp2nHJOJIJGp9W0wzK4lhnfvk1osk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=QeUDGbRTji2Gnka1aFgPpDEsTHMgv+RMDklc/gnUyAB9B7iQSECEO8gXh86pHjY4J
         AfiJiL2NOQkhNadiNRGUDddM8KE4ZMHbL5T/UhCHVkvAh8+YDD2FgxqwTIQ754eC6u
         md8lNPOvD9ESdCnjghP2r1fbRSmqbVM+IiAkMIzdH1dsCXQ0mUO3orgANJn/J56mwY
         EnPI9fxcJjtdnZ9Z+PfCln+Pn1UKoliuUfc3H3rr/B+OPdbm4FWoeIAF5T+L0XkQE/
         pIuv2PdAR/RhHi2T9BwY8veXjgnk0XdCnUYT5yDw6sOztKfah6j3Epl43+XlYIuP8b
         /inBS/5tzDIcQ==
Message-ID: <fdd884426497486c6b17795b4edc66243bdc7350.camel@codeconstruct.com.au>
Subject: Re: [PATCH] i2c: aspeed: Acknowledge Tx ack late when in
 SLAVE_READ_PROCESSED
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Cosmo Chou <chou.cosmo@gmail.com>, brendan.higgins@linux.dev,
        benh@kernel.crashing.org, joel@jms.id.au, andi.shyti@kernel.org,
        linux@roeck-us.net, wsa@kernel.org, jae.hyun.yoo@linux.intel.com
Cc:     linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        cosmo.chou@quantatw.com
Date:   Mon, 27 Nov 2023 13:53:02 +1030
In-Reply-To: <20231120091746.2866232-1-chou.cosmo@gmail.com>
References: <20231120091746.2866232-1-chou.cosmo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-20 at 17:17 +0800, Cosmo Chou wrote:
> commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early
> in interrupt handler") moved most interrupt acknowledgments to the
> start of the interrupt handler to avoid race conditions. However,
> slave Tx ack status shouldn't be cleared before SLAVE_READ_PROCESSED
> is handled.
>=20
> Acknowledge Tx ack status after handling SLAVE_READ_PROCESSED to fix
> the problem that the next byte is not sent correctly.

What does this mean in practice? Can you provide more details? It
sounds like you've seen concrete problems and it would be nice to
capture what it was that occurred.

Andrew
