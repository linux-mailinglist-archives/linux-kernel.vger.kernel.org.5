Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5CE769BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGaQMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjGaQMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:12:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B1E1BE;
        Mon, 31 Jul 2023 09:12:43 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1B18E5C018D;
        Mon, 31 Jul 2023 12:12:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 31 Jul 2023 12:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690819963; x=1690906363; bh=Nd
        NmSxtlFsEMzoXcqa9Y1UrUq7PfRm3QMd0u0om9fwo=; b=ii9PkP06rCG12PbQ2X
        Yjg/A+IYqX36u8EBJpq/Ing971sRR6zrDbZ6cT1ddBVFDrkrHDi+wWFkxCJBwktB
        aSzd4r8TcIHtXtga+FV1aQa923Yn18Uh0LDtKfNgLUtk2u0B3h/WFyo+9i+0+hOF
        mP3vh2bF3KWScKLCs6F96G76psUFmE+qwVnic/I/8ghy8LNna0JWBQpr4xf/nQOt
        UVC3ikGyElg7ltzFCMaM1hjI3Mkgc5dE3SFjrgFggPX0pWhLFq7p60IxzR+tfqc4
        XkA64vCjTOuRswlr65nxf84YUbI22Rq40WGYCOJEnqo2cDt9mrADY87s8i98Si97
        2S7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690819963; x=1690906363; bh=NdNmSxtlFsEMz
        oXcqa9Y1UrUq7PfRm3QMd0u0om9fwo=; b=Hxxvyo0t9jvGwDZlFnhWVPwW+PdpP
        Ff63Sv8xYnqbbghP5b3W7QMVJxmlmdJxb1b0geAXuBJwlVStdSmPJkrxe8rgLy/x
        olGLR3r06sole5M96I9tdJjblMcQh17TJW982jatrpc7UeMaop3oMN/X+GehqdUL
        h6bVwKxf+KM6nMsI/pzGTIH0CsdqDS08HoVm2cUf2OsrTlN0AYyG2NJ9i2u8Y0T3
        PkDlc0mK+wGm+PEAepV/g2+0gPzQQWTGct/5cMgqPVPIZ3b6qGHOeY1RtBRh9Wz8
        89a50cKliSeZ/9kyzpm3xQRfrhN1SeIxFL4WSHyfOi0KQaKiWE2hrGjfg==
X-ME-Sender: <xms:et3HZCa6FHXngCxgyIwTfWWjMqnIcmZNjLijdTOE5tS2ADDbgj7DTw>
    <xme:et3HZFaCD1A3x6nJ_uo6himS446LXjaG7FabdbWupvIp8rXFW7yEiKQnzxtCSKLUP
    VqNotbj-bmFKLiZ5EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeggdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:et3HZM8aXLj441YrdJfaYQmHnkuA_cWHQxPX7Id1BFE3L-kBb9gxhw>
    <xmx:et3HZErQBL2LeDKbJZnxbw9YF4pd62Z-vqBTkHFtWh-3DjE-nV62qQ>
    <xmx:et3HZNrvqjrgswqcQjqUbwIxHN-CzeSm_lQzki3y49oDpbWUY_A5-w>
    <xmx:e93HZO4YLyawrhuukjcb3GSGHVJABSzKKVTY7yR_1CX0n1U6qc7e2A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A74B6B60089; Mon, 31 Jul 2023 12:12:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <86b73242-94bb-4537-92ec-51da02127848@app.fastmail.com>
In-Reply-To: <20230731083806.453036-2-hch@lst.de>
References: <20230731083806.453036-1-hch@lst.de>
 <20230731083806.453036-2-hch@lst.de>
Date:   Mon, 31 Jul 2023 18:12:22 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christoph Hellwig" <hch@lst.de>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Yangbo Lu" <yangbo.lu@nxp.com>, "Joshua Kinard" <kumba@gentoo.org>
Cc:     "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        "open list" <linux-kernel@vger.kernel.org>,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-rtc@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/5] ARM/pxa: use EXPORT_SYMBOL_GPL for sharpsl_battery_kick
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023, at 10:38, Christoph Hellwig wrote:
> sharpsl_battery_kick is only used via symbol_get, which was only ever
> intended for very internal symbols like this one.  Use EXPORT_SYMBOL_GPL
> for it so that symbol_get can enforce only being used on
> EXPORT_SYMBOL_GPL symbols.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The reasoning makes sense, and the patch looks good, so feel
free to take this through your tree.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Or let me know if you want a better fix. Since sharpsl_pm.c and
spitz.c are no longer loadable modules and just get linked together
these days, I think the variant below would be simpler (this could
be cleanup up further, endlessly, of course):

--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -518,17 +518,6 @@ static struct gpiod_lookup_table spitz_ads7846_gpio_table = {
        },
 };
 
-static void spitz_bl_kick_battery(void)
-{
-       void (*kick_batt)(void);
-
-       kick_batt = symbol_get(sharpsl_battery_kick);
-       if (kick_batt) {
-               kick_batt();
-               symbol_put(sharpsl_battery_kick);
-       }
-}
-
 static struct gpiod_lookup_table spitz_lcdcon_gpio_table = {
        .dev_id = "spi2.1",
        .table = {
@@ -556,7 +545,7 @@ static struct corgi_lcd_platform_data spitz_lcdcon_info = {
        .max_intensity          = 0x2f,
        .default_intensity      = 0x1f,
        .limit_mask             = 0x0b,
-       .kick_battery           = spitz_bl_kick_battery,
+       .kick_battery           = sharpsl_battery_kick,
 };
 
 static struct spi_board_info spitz_spi_devices[] = {
