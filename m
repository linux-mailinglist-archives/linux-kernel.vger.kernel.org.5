Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C600D8012E9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379333AbjLASif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLASie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:38:34 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5C0EE;
        Fri,  1 Dec 2023 10:38:40 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1B4E0660739A;
        Fri,  1 Dec 2023 18:38:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701455918;
        bh=nshdBGarWc9GZ7/hAoBX4o9Dx3BkRnL4SICEx41+/Ys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KnJJWZpmHLwkB+keOQZvI7md6rHIRpT6G5/imUC16l0vH+mS6lXkgAM9TdbmMiXw8
         YsCvTpgsZnoWe53/HWWYUZcQBRJKopfp5lsvPV9pjqdSmkisasku0LQCeRj0XBEACA
         kR3KXuoTTxDNyoqwqYBplTPnxT54+D697KNDLiFt7qq2SsXjzxFGuh75ct0C4qQ4Ub
         YdttgPdNA90ZTkM83B8v6WT+4MbLoEV/5Z+qUL+9WP5AsvRyQftY/WGPTaWPwZbIVz
         cjslp+LDvct0vf5ilw5LA6luiAoP1DCtYhF+MMNueZ3GPd8/wtyAVKy6hqkgbOfwrH
         Tje10/yajjCIQ==
Date:   Fri, 1 Dec 2023 19:38:34 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     dregan <dregan@broadcom.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH 1/1] mtd: rawnand: Add deassert_wp comment
Message-ID: <20231201193834.5da80273@collabora.com>
In-Reply-To: <20231201181542.421077-1-dregan@broadcom.com>
References: <20231201181542.421077-1-dregan@broadcom.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Dec 2023 10:15:42 -0800
dregan <dregan@broadcom.com> wrote:

> From: Boris Brezillon <bbrezillon@kernel.org>

I'm pretty sure I shouldn't be the author. The original patch might
have been partly written by me, but this is a fixup on top of it.

> 
> Add deassert_wp description comment
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>

and you should drop my SoB too.

> Signed-off-by: David Regan <dregan@broadcom.com>
> ---
>  include/linux/mtd/rawnand.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index fcad94aa0515..3049b05d8a20 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1001,6 +1001,8 @@ struct nand_op_parser {
>  /**
>   * struct nand_operation - NAND operation descriptor
>   * @cs: the CS line to select for this NAND operation
> + * @deassert_wp: set to true when the operation requires the WP pin to be
> + *		 de-asserted (ERASE, PROG, ...)
>   * @instrs: array of instructions to execute
>   * @ninstrs: length of the @instrs array
>   *

