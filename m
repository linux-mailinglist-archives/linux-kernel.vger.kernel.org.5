Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62987EE60D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbjKPRjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjKPRjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:39:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9A6D5E;
        Thu, 16 Nov 2023 09:39:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A37C433C7;
        Thu, 16 Nov 2023 17:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700156380;
        bh=Zgd5QCuzvKEJFDLFEKjM60EEmgTalFX8rouizgN0mfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YT2DIpaTL/Eiy2JY8VlYnI5iD/v6L2uFCfNsxeK3EPGEhUcUYlDWkQZ1dtcIOeCOL
         wJe4OcPAfJkKyddrzmWmYkai++zzS8XhZeVQcev1JzQ0Zq+ymqDD49St0VsLwsmarT
         pILUUFml2MuTk9CI1F2aN4k9MvP2fq8L8VFmEBYPTMxfDxEZcyrEcHEviXKT2bO6fQ
         4O5MFVu1jtKZW7j8m8k4TXIc2QW9dzbdCy59Un6imvMj8ar1XxZXRtjnBlan7gXsi/
         kpMFSd5lUJIiiPDk7hvPk3WM78Hf7aG4Ckk+hgVOnX3X0mT3hx7ae1B3t5ca16vMMs
         7IBlvTg4FO1Qg==
Date:   Thu, 16 Nov 2023 12:39:39 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>, maobibo@loongson.cn,
        palmer@rivosinc.com, yangtiezhu@loongson.cn, wangliupu@loongson.cn,
        jpoimboe@kernel.org, zhoubinbin@loongson.cn,
        loongarch@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.6 4/6] LoongArch/smp: Call
 rcutree_report_cpu_starting() earlier
Message-ID: <ZVZT27pS16Y7S9wQ@sashalap>
References: <20231115033350.1228588-1-sashal@kernel.org>
 <20231115033350.1228588-4-sashal@kernel.org>
 <CAAhV-H61R006eHGN+ujvDqrT_6AYV0XBcSaT2zyVLJi1rR=kMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAAhV-H61R006eHGN+ujvDqrT_6AYV0XBcSaT2zyVLJi1rR=kMA@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:55:24AM +0800, Huacai Chen wrote:
>Hi, Sasha,
>
>In 6.6 and earlier versions, rcutree_report_cpu_starting() should be
>rcu_cpu_starting().

I'll drop this one. Happy to apply a backport...

-- 
Thanks,
Sasha
