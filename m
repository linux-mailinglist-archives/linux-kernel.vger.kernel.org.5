Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DAE7BDD54
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376326AbjJINJ2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 09:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376649AbjJINJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:09:26 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1096394;
        Mon,  9 Oct 2023 06:09:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id ACBC36340DFB;
        Mon,  9 Oct 2023 15:09:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fAqWxJUbVZPL; Mon,  9 Oct 2023 15:09:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 86D316234897;
        Mon,  9 Oct 2023 15:09:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qGg_8h5ogqvU; Mon,  9 Oct 2023 15:09:19 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2312E6340DFB;
        Mon,  9 Oct 2023 15:09:19 +0200 (CEST)
Date:   Mon, 9 Oct 2023 15:09:18 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     masahiroy <masahiroy@kernel.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        loongarch <loongarch@lists.linux.dev>,
        sparclinux <sparclinux@vger.kernel.org>, x86 <x86@kernel.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        bp <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>,
        hpa <hpa@zytor.com>, mingo <mingo@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        tglx <tglx@linutronix.de>
Message-ID: <687416388.7594.1696856958852.JavaMail.zimbra@nod.at>
In-Reply-To: <20231009124210.1064021-2-masahiroy@kernel.org>
References: <20231009124210.1064021-1-masahiroy@kernel.org> <20231009124210.1064021-2-masahiroy@kernel.org>
Subject: Re: [PATCH 2/5] UML: remove unused cmd_vdso_install
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove unused cmd_vdso_install
Thread-Index: 3hBejy77kYh6pqow8LgNKN8Tb77OsQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "masahiroy" <masahiroy@kernel.org>
> An: "linux-kbuild" <linux-kbuild@vger.kernel.org>
> CC: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
> linux-csky@vger.kernel.org, "linux-parisc" <linux-parisc@vger.kernel.org>, linux-riscv@lists.infradead.org,
> linux-s390@vger.kernel.org, "linux-um" <linux-um@lists.infradead.org>, "loongarch" <loongarch@lists.linux.dev>,
> "sparclinux" <sparclinux@vger.kernel.org>, "x86" <x86@kernel.org>, "masahiroy" <masahiroy@kernel.org>, "anton ivanov"
> <anton.ivanov@cambridgegreys.com>, "bp" <bp@alien8.de>, "dave hansen" <dave.hansen@linux.intel.com>, "hpa"
> <hpa@zytor.com>, "mingo" <mingo@redhat.com>, "Johannes Berg" <johannes@sipsolutions.net>, "richard" <richard@nod.at>,
> "tglx" <tglx@linutronix.de>
> Gesendet: Montag, 9. Oktober 2023 14:42:07
> Betreff: [PATCH 2/5] UML: remove unused cmd_vdso_install

> You cannot run this code because arch/um/Makefile does not define the
> vdso_install target.
> 
> It appears that this code was blindly copied from another architecture.
> 
> Remove the dead code.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
