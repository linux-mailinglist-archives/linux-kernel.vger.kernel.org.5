Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9438E78A0D5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 19:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjH0R6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjH0R5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 13:57:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC87210B;
        Sun, 27 Aug 2023 10:57:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0C53628FF;
        Sun, 27 Aug 2023 17:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C87C433C9;
        Sun, 27 Aug 2023 17:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693159044;
        bh=wl7Yq0FEVBAEExjCSxE+Z63ubf+IPyvbnadjuAvJcTc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NQ8buwX5r3+RdNTEorJymSVYXssFZVVzUgi4fzXp3wPwVjDAp7koBhrOdnS4/Myij
         9qJEG/puGQST52WzdLSRL9shFTPGczdH5PQSM/Dwfk8EwPQZcA/uO72eAkrqVTcBZf
         VTh3vl9CsQWAMeO4tRP/ig/xZEyZbItNoFbL/NCLG+Bjm2lJEJDTZg9un8VivHGcjI
         06peGjfg9O/TgKvYtQHHAsDXKYskGc1+xCSfCjE1zjcFR789RJLsFUbVuo+sGAi4K0
         HijaUWuSeKm+Zokf/jXgiTmIzSALenlYBEnzveh6J6trGbI0LwvbE0/OQ0/n/3mTB+
         zv3e2aEFSUglw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Nam Cao <namcaov@gmail.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] riscv: Only consider swbp/ss handlers for correct
 privileged mode
In-Reply-To: <20230827-dispute-platform-83b494acf090@spud>
References: <20230827114003.224958-1-bjorn@kernel.org>
 <20230827-dispute-platform-83b494acf090@spud>
Date:   Sun, 27 Aug 2023 19:57:21 +0200
Message-ID: <87zg2cwepq.fsf@all.your.base.are.belong.to.us>
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

Conor Dooley <conor@kernel.org> writes:

>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202308271841.HlnnHFL7-lkp@=
intel.com/
>
> Delete these, LKP did not report the probes issue. The LKP bot says:
>> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
>> the same patch/commit), kindly add following tags

Ugh, sloppy. Thanks for clearing that up.

I'll wait and see if there's more comments. If not, Palmer, can you
remove these two tags?

Bj=C3=B6rn
