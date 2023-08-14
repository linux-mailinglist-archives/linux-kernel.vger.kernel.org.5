Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C177BB78
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjHNOYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjHNOYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:24:07 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4DAB2;
        Mon, 14 Aug 2023 07:24:03 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1692023040; bh=8SoUg7FO+B5ltN+g6mc/GlWomKwJReuVjx+WDxr4fG0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Q7kRvaONx8fu6n6qI38VDGpzAWdZEDVoe1g+DoBmUZtrq0Fn5eI2ui186O6rxbt/Y
         W8vwFlb2SGysuamOxs99cfHh6jlzfvdfjk3LkKtxJeqJR7T4U22IDSszXrc6tgPJy9
         FieoOMY3S4Qa1zykwR5wTnoXLmUzCQarLx3+Mq/04aTOxHA13Jkyfao9XbNFtFZ27h
         f8VptPi3zogfbPgb9CUSoyc7+njnL7+3Fq5yS2XD5eM4SgF7ziYxj3WdKlgL6lbWK2
         a5HyqElzaFH/TI1EGlpEEksDpnsQ3fnt8tT2kB12mM6LkR+LV7gfOgW2gxRxuWWaun
         WtClH1slP7r1A==
To:     Arnd Bergmann <arnd@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Aloka Dixit <quic_alokad@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Karthik M <quic_karm@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] wireless: ath: remove unused-but-set parameter
In-Reply-To: <20230814073255.1065242-1-arnd@kernel.org>
References: <20230814073255.1065242-1-arnd@kernel.org>
Date:   Mon, 14 Aug 2023 16:23:59 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87zg2tem80.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This has never been used since the driver was merged, but it now causes
> a W=3D1 warning in recent clang versions
>
> drivers/net/wireless/ath/ath9k/main.c:1566:21: error: parameter 'changed_=
flags' set but not used [-Werror,-Wunused-but-set-parameter]
> drivers/net/wireless/ath/ath9k/htc_drv_main.c:1258:25: error: parameter '=
changed_flags' set but not used [-Werror,-Wunused-but-set-parameter]
> drivers/net/wireless/ath/ath5k/mac80211-ops.c:367:62: error: parameter 'c=
hanged_flags' set but not used [-Werror,-Wunused-but-set-parameter]
>
> Remove the bit manipulation on the otherwise unused parameter.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For ath9k:
Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
