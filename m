Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A78A7F6891
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 21:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjKWU5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 15:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKWU5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 15:57:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68117D59
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 12:57:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82159C433C7;
        Thu, 23 Nov 2023 20:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700773074;
        bh=+3F4s+IAUYLwhXgtInkbimzrIFWoEU7zQccek18Zy3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7fCdQUNE6iXFi5rUMFGIONqSAXdmjBYMvTV4OTq4dVLVJB605IC0r5WVjKJ8SMND
         xQXcgfjxhcKBovUi7STS+qs4JxkEhG26uj86hlczVAJUEwwUtYDdHnkgzkZSg80mQM
         Sc6y2/elaZmvXejymAT+e99PTijCgKJJouBhtMliWTdPZcmQpXiBiHXnrdV0064mxG
         V/ctFTUd1MP/4Xd4waS030cZlqDC2yNeTvk3jraFI6frvMIoIbLSeSSOUQTOC6Wxjw
         7XYCXdBAmDdSt4W8Hwu5g1eTUgfg1tpntsZIs+3oEEO6ENlu27Y/uGw3OQjHyw/BvQ
         604hvtq88RDtQ==
Date:   Thu, 23 Nov 2023 21:57:51 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] drivers/i2c/busses: Don't let i2c adapters declare
 I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Message-ID: <ZV+8z7zloE/gn/4p@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org
References: <20231118180504.1785-1-hkallweit1@gmail.com>
 <20231118180504.1785-2-hkallweit1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PwSR3A6iQFvsAk3P"
Content-Disposition: inline
In-Reply-To: <20231118180504.1785-2-hkallweit1@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PwSR3A6iQFvsAk3P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Series was created supported by Coccinelle and its splitpatch.

I don't know splitpatch. However, I don't understand its result. Why
isn't there one patch for all in drivers/i2c/busses? Also, the subject
prefix should be plain "i2c: <do x for all drivers>" or something.


--PwSR3A6iQFvsAk3P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmVfvM4ACgkQFA3kzBSg
Kba1zQ//Z444dzSXhxkRbiruyduTqb0PHEYHZPC3jFzSinHhmDiiaFjCkPnpDOdD
d926o1TOTxX8YxpGPWy7xeBDmSsuPWbQnHY04rMu9hNmVjp0ozL8DWvcy8IUoMbf
DaFZ0oXwYpwisa9b0ve8T61sZIrIoPdkXuOQcUlGYo/wG3qCWgtEoHn+GF2va0B3
Daw193ttJqHnhQYoBankeFbd3ncb8EUpQieLDmR/yEnAEAsucBlpG2Qkvv66gDXt
ZWK35R8PV+M0hwbOyYoH6EK3Jo5LTk05++rUbHNVrhrrfvlnjPeiiEplRxTgk7wa
tX0uzRVJVBqEw7BKtFZ/3uuPWpqzd3axiXZwEz9LTbfreyJ5tvVP32X0XnMujVbk
ID6uHWkXtsSIYs2eYRl9fcAcbrENY6BXi7QzMjGtZ+xRGClZtIaldges3LWRklQB
+g7u4e4kgXb8DGK4hKDp7NYyQyIvsq18xTu9nDiP92VYrsAe0d6qNqqYvL2CLzob
hilEtRoWHeMF7a9UKUYqqEXb84rhpXRtF70UXY6eSxfz6bYPsgklv3hq31OrPja7
GKQER/ism0ML7SrovX3dXqLMQJSFTbXmrQuvmr5Myix3O/0xp7sPuxKOv1B0ayU2
LeALdfCRXLGkAeIgpZvGWNupLtORRYYR8zTd9FcPGWWdHUPVkFw=
=SUMv
-----END PGP SIGNATURE-----

--PwSR3A6iQFvsAk3P--
