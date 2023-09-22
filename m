Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF2F7AB8BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjIVR6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjIVR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:58:06 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB7F46A5;
        Fri, 22 Sep 2023 10:55:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76D0820008;
        Fri, 22 Sep 2023 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695405341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCGVOgvY4s16fxeT66XA9Eh5rDl/9HDtlmqeH6RjkoU=;
        b=Y0LRVQDLcKtDrLDqeMHV0I1ZNxm+9zhyWjyvX375eWeEiVtm0HXDIM8ut4QJLyJLBpXfka
        32b9my3qGADpbERF9o+hkOvhW/E3A/Yi3TseGMlOMBBa7EFGBJhpBlEiG1Bdy1YSLIuckJ
        Tr5vva1tYdbcVQcTL/oGESCbOrKuY9wMptDbuKQh8MFB7L6XYYIhv5UlcuWabGjqMC2iEj
        /33Oo/gA6G2cEFLDvrPofAfgT0hE04e4+2DnHjUAKhgQufQE7CklUQLaOzAgAlu+UnA23i
        o1ONnbR2G4Be7ak2dHtQtHG/w37nsEQ2kb9f8KzL+shsZI515TDZvrp6gGljmA==
Date:   Fri, 22 Sep 2023 19:55:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Conor Culhane <conor.culhane@silvaco.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i3c: svc: Annotate struct svc_i3c_xfer with
 __counted_by
Message-ID: <20230922195537.2ed8c479@xps-13>
In-Reply-To: <20230922175023.work.239-kees@kernel.org>
References: <20230922175023.work.239-kees@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

keescook@chromium.org wrote on Fri, 22 Sep 2023 10:50:23 -0700:

> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>=20
> As found with Coccinelle[1], add __counted_by for struct svc_i3c_xfer.
>=20
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>=20
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Conor Culhane <conor.culhane@silvaco.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-i3c@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
