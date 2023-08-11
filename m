Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43613779713
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbjHKSZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjHKSZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:25:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A679F30DC;
        Fri, 11 Aug 2023 11:25:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA7AD660ED;
        Fri, 11 Aug 2023 18:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BC4C433C8;
        Fri, 11 Aug 2023 18:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691778341;
        bh=J5jMJWNe5mxefsfwYpjk94ucCqvKpHDhJ2RLFLWPzvE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gz052yUM1XxLU/RgjOg34wukKcdr6mu92lg4kRvftL4t+JLmQb8r1u1actRxxcApf
         PjHlYbsUsWZ+bKIaVoc7rK52krQ4OWPLnEH93QFvpXRAbigb2wSUKLi45TU/nHEb+C
         Jwl9WfjJwBcQjOTRkBTLUH9d7syGI0QxxJS6cM+B4sNpqdMSIJVnJTbcdGoGTSTSlZ
         PeS+VwcMkTke4e6X7PE/F46DP+6t406NKl/ODdSSnHdrM9/eHvIbao7c9+sM5I0D9t
         oKICESQTk0FrGQu3zXtHyOu/DayhYLn0OVumhMRyOLFfjSFrRZmIStkSQKluPFVJ8K
         zZHStULYsZlMQ==
Message-ID: <2cb4c584-fb4a-5781-f74d-902416749ed4@kernel.org>
Date:   Fri, 11 Aug 2023 11:25:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 16/17] [RFC] arch: turn -Wmissing-prototypes off
 conditionally
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@quicinc.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Youling Tang <tangyouling@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Xin Li <xin3.li@intel.com>, Nhat Pham <nphamcs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Marc_Aur=c3=a8le_La_France?= <tsi@tuyoix.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-17-arnd@kernel.org>
 <CAJF2gTRdbXOEBNPN14y_ZUwBJ15qBG929BDspk0sqPo2sn=L-Q@mail.gmail.com>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <CAJF2gTRdbXOEBNPN14y_ZUwBJ15qBG929BDspk0sqPo2sn=L-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/23 19:33, Guo Ren wrote:
> Thx, Arnd, I will clean them up for the csky part.

Likewise, I'll clean up ARC errors this weekend !
It seems most of therm are in the category you mentioned. Non static but 
only used by asm code.

Thx,
-Vineet
