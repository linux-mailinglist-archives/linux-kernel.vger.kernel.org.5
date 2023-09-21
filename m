Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C07A9124
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 05:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjIUDCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 23:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIUDCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 23:02:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AFAF4;
        Wed, 20 Sep 2023 20:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=v/hQ3g0fh6F+RhhYiYOgFWnIHZ1EnH3LC+69vNAwmOs=; b=Gas4ZYf9++QHsissyewrNWJ2Or
        CwBarsa0Sl4pVZh92Ac59VHi0qbr+XyuiHccZZxlMiVxf46jSvNDOr0xTcsXPqhOlRIfrlO/yD/AF
        Bl53pnvcBNKgrVmcIsqIaNVJcfi5FUE4PYFh2GrxLa5VtMpiY8gfJqyJ1lgHI3g7QkljR7YDlJ8W6
        hDXhx3rj7uWI5p5gMCcNVstq6XpObu2kPD8+tdNioT+kEM97VAPfRCavR/h2zAjw7WB6FrsRhJlQT
        KIa9tYzpwcUvPVV2Chh8Cba9tvpQ42Rndae5uYTj6PbTP7w72123CuH46E4esE9+PgzoaEDq3vtam
        LTHnsmCw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qj9xP-004r2B-0K;
        Thu, 21 Sep 2023 03:02:23 +0000
Date:   Wed, 20 Sep 2023 20:02:23 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Joel Granados <j.granados@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the sysctl tree with the asm-generic
 tree
Message-ID: <ZQuyP8GsIP+gSB4U@bombadil.infradead.org>
References: <20230921115034.5461f62f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230921115034.5461f62f@canb.auug.org.au>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:50:34AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the sysctl tree got a conflict in:
>=20
>   arch/ia64/kernel/crash.c
>=20
> between commit:
>=20
>   cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
>=20
> from the asm-generic tree and commit:
>=20
>   d2f2ef357794 ("ia64: Remove now superfluous sentinel element from ctl_t=
able array")
>=20
> from the sysctl tree.
>=20
> I fixed it up (I removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Lol, good bye IA64! Glad I got merge conflict to say goodbye.

  Luis
