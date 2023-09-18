Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCB87A4FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjIRQux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjIRQuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:50:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE094;
        Mon, 18 Sep 2023 09:50:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70B6C433C7;
        Mon, 18 Sep 2023 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695055847;
        bh=8JxeeNt0YIANYdkuILxO1QdRpilUqSWyV1gcj/PegTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlpAl0p0ot/ZdMds5/dzHxWvSvCvoB6UFz2DNFt8l8uvRG06FlLRX1IMnpZk5FAWt
         xp0hbr0IHEFQ8Fc9h3/iFakdDYOh+hd7LgzCYbXYqenvfRcEONW4VaxI42nvK2WIZZ
         0Qr1iqebzd7NopusIhwRMtqzJSmzNtRUve6/yNd/Fc3zlQ1DesWAeVlu/qQ0Cf7puc
         5/ZrtsowpVcbuRfia4JAsYX+W/BVhF9UFxa9SiAAx+NIbe3W5bA5S0KuHJ9fybFKPZ
         CPO1pzBAZTZXVwmZhaqHYiWkwPs6RrmFUErlYXc8RYn6MYkOpjlgGUWaqpHI9NmPkD
         x9hzbmwpPZKJg==
Date:   Mon, 18 Sep 2023 12:50:45 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, keescook@chromium.org,
        Conor Dooley <conor.dooley@microchip.com>, nathan@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ndesaulniers@google.com,
        peterz@infradead.org, ajones@ventanamicro.com, heiko@sntech.de,
        prabhakar.mahadev-lad.rj@bp.renesas.com, liaochang1@huawei.com,
        namcaov@gmail.com, andy.chiu@sifive.com, guoren@kernel.org,
        alexghiti@rivosinc.com, Bjorn Topel <bjorn@rivosinc.com>,
        jeeheng.sia@starfivetech.com, jszhang@kernel.org,
        greentime.hu@sifive.com, masahiroy@kernel.org,
        apatel@ventanamicro.com, mnissler@rivosinc.com,
        coelacanthushex@gmail.com, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.4 25/25] riscv: Add CFI error handling
Message-ID: <ZQh/5ZnoI6dnTonS@sashalap>
References: <20230909003715.3579761-25-sashal@kernel.org>
 <mhng-e2cedb63-0933-4752-bfd8-592e4e1f6e2c@palmer-ri-x1c9>
 <CABCJKucm3KjYKgjP9OT4GLe8KZ3QxpRk9GqPD5JgwMaoZumnQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCJKucm3KjYKgjP9OT4GLe8KZ3QxpRk9GqPD5JgwMaoZumnQQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 08:03:38AM -0700, Sami Tolvanen wrote:
>On Fri, Sep 8, 2023 at 8:33 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> Sami probably understands the dependencies better than I do, but I don't
>> think this one is sane to just backport -- there's a whole series here,
>> and IIRC we had to set up some clang bits for it to work correctly.
>
>Agreed, it doesn't really make sense to backport this patch.

Ack, it's gone :)

-- 
Thanks,
Sasha
