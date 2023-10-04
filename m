Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1AE7B862F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbjJDROX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243632AbjJDROW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:14:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2FA9E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:14:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC2DC433C9;
        Wed,  4 Oct 2023 17:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696439659;
        bh=sOAP03+W9UkNwBC7b0j1L28Qg4M4aoxG9yOktt/PwQY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ccINkiZMcqiWavgi4MniY2e+pEf54wywxE/s4NCG1h8rQ9Sh769kzWyTytmAk4o+9
         kpE0Gff2UAZ1NWYswQK9MOic4u1WHjafJeRpG4EmUpNwqNytD8Am7x/AUel9Vobie9
         b6IcQ2tIJdwItLmnc7iy28Z2jN+WBAD+VPCVFwCLdnScHaOefcbEyUg44AGxcKHcIc
         wjVAHKXx+kBksaQfTCZ8CvYFEai7rLdJKlG85TsN1HiV+Pve4C6u0RGsCDiEM/KhaT
         XfZrYv6mySQ8cwhNGmezvvuWTEGwcm2tn6yLUlhS+IKjuXNqJOOKsehQE+TbjYWf8S
         3Zu2rX6xAm8vg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?utf-8?Q?Bj=C3=B6rn?= Topel <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v2 5/8] riscv: add support for sysctl unaligned_enabled
 control
In-Reply-To: <20231004151405.521596-6-cleger@rivosinc.com>
References: <20231004151405.521596-1-cleger@rivosinc.com>
 <20231004151405.521596-6-cleger@rivosinc.com>
Date:   Wed, 04 Oct 2023 19:14:16 +0200
Message-ID: <877co2ux7b.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com> writes:

> This sysctl tuning option allows the user to disable misaligned access
> handling globally on the system. This will also be used by misaligned
> detection code to temporarily disable misaligned access handling.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
