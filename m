Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3627F7C66BC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377747AbjJLHZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377623AbjJLHZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:25:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C030F90;
        Thu, 12 Oct 2023 00:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697095477; x=1697700277; i=deller@gmx.de;
 bh=oXy5tX2J/Ph6eTM9bAGsgHUtEr/KjBOa9YKsIsb+zZo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RyEsuy/MOe7+0kyhqW5fyiLrNtgpGiIcosZ+Yvw2I1towJ5lpw/71QVowPMw2iGkSfYG1lCcX3c
 Je+1IHNlE7kTz4gU5bwGssFPDS0SgG2M8YS/LEgM8w0p6siZd6vFj6GFNZn2TKbKMJrNTiy//ez7J
 BWHEfo4AmOU19+TIkXKez5VI+LLLHx1vqbnfcm9Ob1rJ9TnlUN9BFrO2AFDGBA2GU3pcqDyRY6sEJ
 7xEgtkzBhhmLDMPw+aUp/0uIKiiDxgz8W4zq5e2P5ijjY6GUDiipzkw0zioaOviN7rc3mXYCksL2E
 fVd6jyqzV7Vqq9xuqFbqpqijcdmVLA5uMf1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.153.231]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0JM-1rJKFJ2X96-00kRh2; Thu, 12
 Oct 2023 09:24:37 +0200
Message-ID: <d886d83a-87b4-428d-856e-9bbaa554563a@gmx.de>
Date:   Thu, 12 Oct 2023 09:24:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] parisc: remove broken vdso_install
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, x86@kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20231009124210.1064021-1-masahiroy@kernel.org>
 <20231009124210.1064021-3-masahiroy@kernel.org>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20231009124210.1064021-3-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UuRaX4Qyf+vUPdgU+tYXxohqJX86snYyiLQ1GLwyp69h7XprT7J
 gIJCWxMLT7TqKQsMWUziQR7PpqexRnlVJX67B6UFqqJbheZPMEsh0SpQwpREUZ/Y3tt0CfN
 kjZK7PN2+my2xbvTvkBpXNP34rbV4u+xF3gnjATHAkV27ITVERd44tDpb5ZQZgxCpiM+VDN
 9bEi/P7yFjW3vQAAdC8LA==
UI-OutboundReport: notjunk:1;M01:P0:dv/izyBJz7w=;o5X8ff7JU/4ObAv70zN3D0eXcDJ
 OVfsETuHPyw3nTXayRCSQOPexM75ofy/ywHIBwCbaVz3aXtDraxdIBPjGkx0ece6TfSHpAq8N
 Xncx0BomXSTwi7heFKQy1Zo5VFQrovcVbBk6e/11NpG7PNIpZEd1ZXXPQJYLR9jnaSgzrepA6
 j+LqSzqCjNakNJOOk3WnUTAldNR9Ge6O3H0i3Bu63mzofi5You9/hmHi+yybdfBIOhDtlU4Rd
 D7M91OPVWpSgD3/+O//pmdtgBwhtCy+wMSAd0q6d+RqSjCuWULgLksUa95Ozn0ptf9ovP0U3a
 aD0TmiHaggRj9CQOGILxGjvw2/ODYbWkFzZRoeIeEb0JspbccSNMbGLgE2sMdI8fFtOmMKTkO
 efqooP33QDLhTYzLZ24pEnqej2ks6vbhnckjqk76gO9spWC0UwmU8H7siUv45VZYBIqWiIjUM
 E7Mm5JgpLt7+dLilET0lvbjpU8vGWqpsEsqhqIOcPT6MH36M7CdPM7r9EA0x9bRWuTFPop5PC
 doZt7uUewz9zq8qLH7b7piwrymrisWA3uTq9MW2USW2Jb4kd7TWQEIJvXfGUL/V61YnDHSavl
 gui+DDcLya8/0lS1PZ2z3GkpFGkkfv6A5Krtg4thvjBQ7n8jQs59N/OF+P/ZKK2ka06NbK764
 60oq7csCNkPDpJan/HY5YOVvJKGE3YOQBDCkSRX8HKsmbKSz8eVDq47/ptiqyCD8e9Blw64Gb
 qPVCYbmECBAHBUOm4cWWExMaHd9PRqzaO5jVo6CE0YtmYYW0lSkF0R37BGIRsjGJNgYTEiznA
 DV1JSqTkjL3BbQ8DfdA6eF/OBoo4H/3zrE1hbQ0i69b6WI81gdwviBLE6sH/Xv7OuTbD94tWU
 TE2nsqlAVkS7no9QaJgAgYsABy6qwO54aZEiJbVKRHf+ff/bMAxBjRPhCKIHS23TP9n8Iml2b
 GuJX9A==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On 10/9/23 14:42, Masahiro Yamada wrote:
> 'make ARCH=3Dparisc vdso_install' has never worked. It attempts to
> descend into arch/parisc/kernel/vdso/, which does not exist.
>
> The command just fails:
>
>    scripts/Makefile.build:41: arch/parisc/kernel/vdso/Makefile: No such =
file or directory
>
> The second line is also meaningless because parisc does not define
> CONFIG_COMPAT_VDSO.
>
> It appears that this code was copied from another architecture without
> proper adaptation.

Yes.

> Remove the broken code.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for cleaning this up and making it consistent across the architectu=
res.

Acked-by: Helge Deller <deller@gmx.de>  # parisc

In case you do a v2 version of the patch, would you add to arch/parisc/Mak=
efile
(otherwise I can send a follow-up patch in the parisc git tree):

vdso-install-y               +=3D arch/parisc/kernel/vdso32/vdso32.so
vdso-install-$(CONFIG_64BIT) +=3D arch/parisc/kernel/vdso64/vdso64.so

Thanks!
Helge
