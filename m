Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A3E8064BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376386AbjLFB5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjLFB5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:57:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997869A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:57:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB1AC433C8;
        Wed,  6 Dec 2023 01:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701827863;
        bh=S6FcSqXiPkB7bwWbEbflS16ZC3a2KNbRC5F2L4gR/4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAn3xdl21XANaUmOmjCJr+DdXxkpTwUv26qVzaT5ZSHJpMY8b73R3wUqaEgSCUG+3
         TtExK7/OMeBj3TfRSSzJJYdQezB0cd3i9UAHoqkndX74Krj+WyUU9Sk1ra13GaLhhZ
         f05xuh3fI6CtRJjSZkS+/r17EytANbKv/fy+ZPqFwdnfk6BeTKY83xAAPuiN0nHpgh
         vOkwdTS9cQIP91Y3QIdZXJMNjY4d2HOF/GFLWw3bCpoQyNOpjhSR7UCFwFe2yrE3jr
         KNoTYudbDfwoX/KHqXikBr4fO/PDzDplOWwgtR8NH4hHuzNm2vLp8TaCZDilX3hLPz
         TbSiqpaAQawqg==
Date:   Tue, 5 Dec 2023 20:57:35 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>, deller@gmx.de,
        ndesaulniers@google.com
Subject: Re: [PATCH AUTOSEL 6.6 12/17] linux/export: clean up the IA-64
 KSYM_FUNC macro
Message-ID: <ZW_VD-H7ota8GZwE@sashalap>
References: <20231122153212.852040-1-sashal@kernel.org>
 <20231122153212.852040-12-sashal@kernel.org>
 <CAKXUXMxiRL-ay9eMz4AZNORbO-mhyZECGE2SDg0rTB7wZdHSRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXUXMxiRL-ay9eMz4AZNORbO-mhyZECGE2SDg0rTB7wZdHSRA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:06:54PM +0100, Lukas Bulwahn wrote:
>On Wed, Nov 22, 2023 at 4:32 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>>
>> [ Upstream commit 9e0be3f50c0e8517d0238b62409c20bcb8cd8785 ]
>>
>> With commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture"),
>> there is no need to keep the IA-64 definition of the KSYM_FUNC macro.
>>
>> Clean up the IA-64 definition of the KSYM_FUNC macro.
>>
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>
>I am a bit surprised that this is picked up for v6.6. This commit only
>makes sense after IA-64 architecture is removed and I do not think we
>want to backport that change to v6.6. So, this change here should not
>be backported as well.

I'll drop it, thanks!

-- 
Thanks,
Sasha
