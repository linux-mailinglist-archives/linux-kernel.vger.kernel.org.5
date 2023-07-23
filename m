Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D421175E579
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGWWKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWWKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 18:10:41 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F120AD;
        Sun, 23 Jul 2023 15:10:39 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1690150234; bh=RBLYzId7q5rLyrmeOfA7KtxUDvqgZPZcTGOEpMnxbOo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OeuGmuPhicNWMwN1ajbzHHH55e0IEwqhIz8RNBgekmQ7zXWc1pTXxsxPnCUP4HWku
         KbA+Yv6U0F+Mi6sZnUcn51yJsYhlVBSCRoGAXsludTAXnpgymgqRThS2Xd8GKf6E8O
         CV+9BfuguTz7W1dN79bD7cteUdfwMdQ7Uf+v/eYeHAc//ScT06KkS482CNBA9DKOrU
         g1f8MOv4pG5B3arjzVVG6ScuVQDFu7fRZmbSSZgmnxwc7GbZj/LdVNv0u3tpIlslHs
         XtHGpoKzEoWVwnVMnF+tWbx4HpII/LZ92zMMdPLy3vW10kIXDiIOsfARcNQyiMZWJv
         /W/Fo7qpD/9Ag==
To:     Dongliang Mu <dzm91@hust.edu.cn>, Kalle Valo <kvalo@kernel.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] wifi: ath9k: fix printk specifier
In-Reply-To: <20230723040403.296723-1-dzm91@hust.edu.cn>
References: <20230723040403.296723-1-dzm91@hust.edu.cn>
Date:   Mon, 24 Jul 2023 00:10:33 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87mszms2hy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Smatch reports:
>
> ath_pci_probe() warn: argument 4 to %lx specifier is cast from pointer
> ath_ahb_probe() warn: argument 4 to %lx specifier is cast from pointer
>
> Fix it by modifying %lx to %p in the printk format string.
>
> Note that with this change, the pointer address will be printed as a
> hashed value by default. This is appropriate because the kernel
> should not leak kernel pointers to user space in an informational
> message. If someone wants to see the real address for debugging
> purposes, this can be achieved with the no_hash_pointers kernel option.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
