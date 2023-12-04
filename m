Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14C80315B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjLDLR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLDLRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:17:54 -0500
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970F3D5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:17:59 -0800 (PST)
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
        by mail.avm.de (Postfix) with ESMTPS;
        Mon,  4 Dec 2023 12:17:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1701688675; bh=aGkUrjrf2Bd0jPpMXffD2gS7xY90WZq7FUKU/C/NXpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vj+KIEB0nTU/Zn6kBIstfu/O0Q8tMYJ4j9WsQYTgrBufJBQQkRi4//zDpYJbO4zzR
         eDkBUi5NzD7JJZJVl+d07/sqdsfALb8YNeZQfow6kyPsnJQ03w+9FCdp6vYFg/dbLM
         EsRfxMvzqGWNzSu46q7JaybZMYMcOBXB3BlF8RM0=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 01DB3806BD;
        Mon,  4 Dec 2023 12:17:55 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id E74951812D3; Mon,  4 Dec 2023 12:17:54 +0100 (CET)
Date:   Mon, 4 Dec 2023 12:17:54 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: determine base DTB by suffix
Message-ID: <ZW21Yu73Uan+HcbL@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
References: <20231203080548.1869540-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231203080548.1869540-1-masahiroy@kernel.org>
X-purgate-ID: 149429::1701688675-BDEE2A59-FAB33F4C/0/0
X-purgate-type: clean
X-purgate-size: 762
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 05:05:48PM +0900, Masahiro Yamada wrote:
> When using the -dtbs syntax, you need to ensure to list the base first,
> as follows:
> 
>     foo-dtbs := foo_base.dtb foo_overlay1.dtbo foo_overlay2.dtbo
>     dtb-y := foo.dtb
> 
> You cannot do this arrangement:
> 
>     foo-dtbs := foo_overlay1.dtbo foo_overlay2.dtbo foo_base.dtb
> 
> This restriction comes from $(firstword ...), but it is unneeded to
> rely on the order in the -dtbs syntax.
> 
> Instead, you can simply determine the base by suffix because the
> base (*.dtb) and overlays (*.dtbo) use different suffixes.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Thanks, looks good to me.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
