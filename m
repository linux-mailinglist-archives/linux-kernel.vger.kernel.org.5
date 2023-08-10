Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E492777D27
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbjHJQC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbjHJQCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:02:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E27270F;
        Thu, 10 Aug 2023 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691683191; x=1692287991; i=deller@gmx.de;
 bh=LQ4BoluAVRb0GVjdydcgr6ii6FNpLvdjAbxqzo3k3IM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fVyd7cVX1xb7CULER8aXpZvUDMw34y68dpKhVUs8ZfR2S7048G7MucmX1i5TtqM6R82OMyR
 niOqfo7h9BzQcPM3ryfm4NQYVXaNPXZHHZkiz7VG1FgbUmccZMoRt7G6UJwhoSGn9oi7Ymmkv
 mbj2WMqZTUX9rlYnlvHU6nNlZgb9Rb3yDmafWzLCiiIfUD6X0LAiHIhVG31IXm6sBgI1OqjmK
 ggOkUGW0Ahf2P2Vq0c7++Ovnd8I4T4yVWat9f6Ob6QU9EnQto3j4L2pbtZS4yO+l3QwzXikWF
 s+FIdJZUUAJ1K0MR63xP+VnjXnNb/hlVTtQXE1xcoRa9FftNvh3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.133]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0G1d-1pYKx73M6Z-00xKyR; Thu, 10
 Aug 2023 17:59:51 +0200
Message-ID: <5bc9d25c-d546-fe94-05cc-41bd5bbbaf67@gmx.de>
Date:   Thu, 10 Aug 2023 17:59:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 16/17] [RFC] arch: turn -Wmissing-prototypes off
 conditionally
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stafford Horne <shorne@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next <linux-next@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Youling Tang <tangyouling@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Xin Li <xin3.li@intel.com>, Nhat Pham <nphamcs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Marc_Aur=c3=a8le_La_France?= <tsi@tuyoix.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-17-arnd@kernel.org>
 <e0c2f7b1-b137-fbd3-aa28-808498eb8e3f@csgroup.eu>
 <a6222c7f-f903-4de5-821a-f90da8ad1dc9@app.fastmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <a6222c7f-f903-4de5-821a-f90da8ad1dc9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7HICyZOHq9VZP2o9P4LYzDAEWALrWz4P+1I0orqIFFR4BJcuaIu
 Q9221KyRKsTxR9to62XBnXDSgCoxyl6ySZtyR6gJf0IRGNrYlEdlqawThuBvMmTa5OSZ9Wv
 Rh/jmDhXDhUPMZDeYgjoQxOJ9Pw3WKaPEG2OnD/UEDnyf+1A7038CdiHZdVsuvxWMe88oPX
 y9efA24egD5Bij0A0F5LQ==
UI-OutboundReport: notjunk:1;M01:P0:eTaYGH3ty9Q=;NJpZWDM1a6CIkGPR1WvHAlD80vR
 5vHeHYDZ4lcEJAN5tJc40ufY8F04Tox86qmnBiLu7NyOKWI9pEfJwc3zTOVyDI3m6coThGgDH
 5XgPXrhPWlhYlgKmhmMxJbomiJdr+fnochKzMwKSQC0RXV4bCsFVds5PekEWxiGIBWm5WYODS
 Yhz7ke5z5y7SGALHeuwBfCwRaYxu3EFT6v6C732qPG3t86/AtfuutwpSHExh6Mg1ziOWe0a4w
 Ry70jCe2TxeyhAIFoMwePvviXFv1h2UQ4nEvquIUEIPDMZJlRJTVAiO6w3dMEZ05EQmqhkvt1
 Cc2JcxcVR0y6v9zqx8MDRFic69ax8/apf/3WN5OB67zQGZSkXKvZF5aiJb1kWNtPeJ/+aP1fQ
 iYFe+uYvO9D91lTjb3i2pw4qi8D2k6EkNCVZH3SA1J2Hmc7Rsp5lbEYKTaslfp7+t9YEGZgwv
 YiVdd2e5N1bjBXPYAstCGy8Wx5T8V+EJyw/n2kN6uwmpqp1I5a3Co4iOTBxGmU2HxLeIhtTef
 TbQtC2xJp7M0n1KF/Y+IExPOfO29DmaPeZW0SUkvxYSjwdtJP3AB/2FdxP3TZcXVh9cIR8GXb
 6dU95L0uwddFDOeELmZR/3QU9B9klo8LR4CswW0tgFsGiwyKkdIt5zJHA3eAmcmR0hL5V36KT
 OwH28+t1FDtXL9GqJEDsyVb+1/29SJQBWKoxvs1iDOgz9LUEIa9oPaCgAStAOz4PYsv9AN/zE
 4nMJh/omWirBC7u9FzrLzPDAx+xdBDlPXa4+u3CNUfOyUAga8UkDROEHAVcxw0qxaMBSr+q38
 de3c7RYRK5BkKQOpSkY4kqm6eTu4J5qEUUna0vNhhbhonbvpnaFKKCpZ14hbAkMElxWUqTarO
 pspFwS9Qqepmle7qAbIpI35z8dyc9/0egJiK3eaMrUQxOBm8zx1UCjQo5A1m+A8XtHLzb568w
 JWFh3yEJ7/U3t85+niZsy+VmQpo=
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 17:21, Arnd Bergmann wrote:
> On Thu, Aug 10, 2023, at 16:59, Christophe Leroy wrote:
>> Le 10/08/2023 =C3=A0 16:19, Arnd Bergmann a =C3=A9crit=C2=A0:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> I have cleaned up the -Wmissing-prototypes warnings for most of the ma=
jor architectures
>>> as well as all drivers that get enabled for CONFIG_COMPILE_TEST, so no=
w these should be
>>> close to fixed on x86, arm, arm64, powerpc, s390, and riscv.
>>>
>>> The other architectures tend to have a lot of these warning in archite=
cture specific
>>> code, primarily from functions that are only called from assembler cod=
e and do
>>> not otherwise need a declaration but still cause a warning without one=
. Other cases
>>> are simply functions that should just be static or are missing an #inc=
lude statement.
>>>
>>> In order to be able to turn the warning on globally by default without=
 breaking all
>>> these architectures, add a list of exceptions for architecture directo=
ries that
>>> can revert back to the old behavior of not warning based on a new
>>> CONFIG_WNO_MISSING_PROTOTYPES option.
>>
>> Some architectures only have a few of those errors/warnings.
>>
>> For instance microblaze and parisc only have one each. Isn't it better
>> to fix them rather then turn the errors off ?
>
> The list was only the 'defconfig' warnings, there are a couple more
> that I saw with 'allmodconfig', and I'm sure there are even more
> when dealing with other random configurations.
>
> I did send other fixes for microblaze and parisc specific drivers,
> and I could also send patches for the two defconfig warnings if
> the maintainers are happy with fixing those but leaving allmodconfig
> to still warn, but I feel that it's easier for them to just
> do the last fixes themselves and then remove my hack again.
>
> I'll wait for Michal and Helge on these.

Arnd, I like your patch!
For parisc I've done quite some work during the last few weeks to
get such warnings sqeezed out, so please drop the hunk for parisc from
your patch. My plan is to become warning-free before 6.5-final.

This last one:
     arch/parisc/lib/ucmpdi2.c:12:5: error: no previous prototype for '__u=
cmpdi2' [-Werror=3Dmissing-prototypes]
I'll take care in the parisc for-next tree.

Thanks!
Helge

>> Others like loongarch which is a recent actively maintained
>> architecture, I'd expect the 30 errors to be easy to fix.
>
> Agreed, they probably are.
>
>> Many of the alpha ones seems to be brought by your commit e19d4ebc536d
>> ("alpha: add full ioread64/iowrite64 implementation")
>
> As far as I can see, those already existing before that patch, though
> I did touch the same lines there.
>
> In the end it's a matter of where to stop, as there are endless
> configurations to test if I want to do a complete job. I drew the
> line between powerpc (which I tried to fix) and mips (which I left
> alone), mainly because the powerpc side was already exhausting
> and mips has even more obscure configurations. The other ones on
> the list are all less actively maintained than these two.
>
>       Arnd

