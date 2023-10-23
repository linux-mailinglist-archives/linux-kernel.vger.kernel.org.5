Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7DF7D384A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjJWNmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJWNmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:42:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC1CC5;
        Mon, 23 Oct 2023 06:42:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D738DC433C7;
        Mon, 23 Oct 2023 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698068551;
        bh=+XfmN/5V+VDFpJHX76E2hB16obBnUtdt74xxNZXrtfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQgUfxoGjcrA1HNrLCd5iALn4iRujJJUD4+APU5lLsVTO2G7k+vzs8FhVARvUTqlk
         GGglEj1HHuDM8kaU+fXdn2s9eqnHQaKXCwH4zcpO9ZZwAa9i6NMtHn3iBHN5wmiSBE
         I8xpoXb3Fj3HOLhOQHxWbQwjY7Mc7olO4UIXhLTY1SGEtgIE7L74N0jT3aQLxuKYGx
         BOKV4sIDX5jv+9mfmH0tBX4yfjLXO/J0T2y4qHtnfAnI7VIgWFddHLycCfUpXwj0vI
         1wk0QI9ISNHUD0UeDM3TaCtFsPsm5yW0L8i0YhVlzqivoQEqacKCCz7WqPU8lXNCMF
         T6QekTgTOPrQg==
Date:   Mon, 23 Oct 2023 14:42:26 +0100
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Cc:     kernel-team@android.com, Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v5 0/3]  Fix 'faddr2line' for LLVM arm64 builds
Message-ID: <20231023134225.GA3746@willie-the-truck>
References: <20231002165750.1661-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002165750.1661-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh,

On Mon, Oct 02, 2023 at 05:57:46PM +0100, Will Deacon wrote:
> Hello again.
> 
> This is version five of the fadd2line fixes that I previously posted at:
> 
> v1: https://lore.kernel.org/r/20230724174517.15736-1-will@kernel.org
> v2: https://lore.kernel.org/r/20230725211157.17031-1-will@kernel.org
> v3: https://lore.kernel.org/r/20230728113415.21067-1-will@kernel.org
> v4: https://lore.kernel.org/r/20230914131225.13415-1-will@kernel.org
> 
> Changes since v4 include:
>   * Simplify the is_mapping_symbol() regex to reflect the latest version
>     of the C code.
>   * Add Suggested-by and Reviewed-by tags to patch 1.

Please can you pick this up for 6.7?

Will
