Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BD27FF7E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjK3RPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjK3RPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:15:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E9B10D9;
        Thu, 30 Nov 2023 09:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SfxaXFs+cllY4uODLdXtYEBXO/hmVXC6iVPj35F0Y6A=; b=ORvDthmpj0fi/bP8z6Pk5T3Gx/
        ghxAZCpj3Otwhp2Y+U5MiC5K6/RazDsjHg+1b3mNiVE+91nK5LJA3unS6fFvrLT6gCpkNwxbyrf5H
        B3WAJeTXU925WWBXUfgRD3Nh0SO3Bau7kyxUITCpvEM8p/IYwFiWyqXK63rRTUN9k7uODi2tCzqXY
        7P1sZ0oo/9zmm9ydQGqzzUvZ13erL3xjb9BIpU/cLFId/RiOtIlgP4bTVeQ5zWyNBx+/KJ9tUcGUS
        UZWLiL/N9j+MZJFzAjUKsz06oVGkNWO3+T1MkoLBLJCmQ643t3pqCMLPoIOOVEjfk5gixBDjxN/Bu
        C99MYjHA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r8kdl-00BTih-1g;
        Thu, 30 Nov 2023 17:15:53 +0000
Message-ID: <6d11b95a-c5a5-47ca-b3da-d78f2ef9f5bc@infradead.org>
Date:   Thu, 30 Nov 2023 09:15:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Nov 30 (mm/zswap.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
References: <20231130140330.55de96cd@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231130140330.55de96cd@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/23 19:03, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20231129:
> 

on i386, loongarch, ppc64, riscv32:
when CONFIG_MEMCG is not set.


../mm/zswap.c: In function 'mem_cgroup_from_entry':
../mm/zswap.c:313:31: error: implicit declaration of function 'obj_cgroup_memcg'; did you mean 'obj_cgroup_put'? [-Werror=implicit-function-declaration]
  313 |         return entry->objcg ? obj_cgroup_memcg(entry->objcg) : NULL;
      |                               ^~~~~~~~~~~~~~~~
      |                               obj_cgroup_put
../mm/zswap.c:313:62: warning: pointer/integer type mismatch in conditional expression
  313 |         return entry->objcg ? obj_cgroup_memcg(entry->objcg) : NULL;
      |                                                              ^
../mm/zswap.c: In function 'shrink_worker':
../mm/zswap.c:984:31: error: invalid use of undefined type 'struct mem_cgroup'
  984 |                 css_get(&memcg->css);
      |                               ^~



-- 
~Randy
