Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87495785342
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjHWI4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjHWIwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:52:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E46B1705;
        Wed, 23 Aug 2023 01:49:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3162865579;
        Wed, 23 Aug 2023 08:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D592AC433C8;
        Wed, 23 Aug 2023 08:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692780589;
        bh=+eMghjkLxbUewcYWSKbRAkX0vlBIDr6r3dCdT6cTBSQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DAEAmEH2fxHFQIX6DdyiHMxRmy501avm1T7yaZzviZvOgJJyVWEEY882POObrHCDT
         kcPoaXPXqsK/zdyuWvrI6EgdOOZt8pUYHXNESvonsZzC+gThRPXhpnN5u8EBxZ8eOa
         +j4Xl0j3G3swRWx8uZrVPyH+CEckjQ8K9zSOHwOHrfgnioRlLSSzikt9tABxRDYnsr
         7XUVsje1RzwV/O49IYm4I2CVp07iAbiZaRS5246+I88qrXzSbYyHlHGZ6pdJDtm0Lh
         yzPwmv6VQkB1bbV9LtkkwRpg279wrSDzxBTG+W/hRfW4rMiYXI7WsG9s+HRzrH0Q1E
         5q1A7K37vjG9Q==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] riscv: Require FRAME_POINTER for some configurations
In-Reply-To: <20230823082845.354839-1-bjorn@kernel.org>
References: <20230823082845.354839-1-bjorn@kernel.org>
Date:   Wed, 23 Aug 2023 10:49:46 +0200
Message-ID: <87cyzep2hh.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Some V configurations implicitly turn on '-fno-omit-frame-pointer',

s/V/RISC-V/
