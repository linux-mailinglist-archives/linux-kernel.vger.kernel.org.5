Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C3775D51C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGUTgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjGUTg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:36:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFE71715;
        Fri, 21 Jul 2023 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=aHk9rd9AUE2gc3/xbDzbaMmyUHyYtCgU4AX8wh2Umso=; b=F+D/QjKe6pPtGBvURNrxNRYDUB
        wjOpFUEleMgjf9lgxcn46aTbZjSbgTkfFBU2i3ve1wv+MHjXM25GNt9rhqcugEpLcNm27NBuKQEdO
        QG1mWP+Wxi1N9+HgYsPy+k+jv/DsZ+F5jsYo9ooq7CDNS62LcaNmu2uMRHyp5uyR0nlV/fyvFXb0s
        iq84uJdVW+fkQgIyQD5GF+YPLNPwIuVB53f/UcHthholS+lz0aDC0MUGUKwZ1tLlWpxTVGGXF+B2x
        ilHxWHrQBn5ZV4HdxaR42aZI4mPRe151Mc0ehfxwo6qObQ9d+pZx4fXN5GsUnlYcPqrAjED1UfCgk
        MKXJi2bg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMvvD-00EyBM-2T;
        Fri, 21 Jul 2023 19:36:15 +0000
Date:   Fri, 21 Jul 2023 12:36:15 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, wangkefeng.wang@huawei.com,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] modpost, kallsyms: Treat add '$'-prefixed symbols as
 mapping symbols
Message-ID: <ZLreL/9W28qSbhB3@bombadil.infradead.org>
References: <20230721150147.11720-2-palmer@rivosinc.com>
 <CAK7LNATF9pxJc0nU3NPnX_PFJr7gF6Baras548ULkO8XE98_VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATF9pxJc0nU3NPnX_PFJr7gF6Baras548ULkO8XE98_VQ@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 02:02:56AM +0900, Masahiro Yamada wrote:
> On Sat, Jul 22, 2023 at 12:20 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> >
> > Trying to restrict the '$'-prefix change to RISC-V caused some fallout,
> > so let's just treat all those symbols as special.
> >
> > Fixes: c05780ef3c1 ("module: Ignore RISC-V mapping symbols too")
> > Link: https://lore.kernel.org/all/20230712015747.77263-1-wangkefeng.wang@huawei.com/
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> 
> Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

Patch applied and pushed, thanks!

  Luis
