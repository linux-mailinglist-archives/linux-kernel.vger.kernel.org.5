Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6639A7F33C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjKUQbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjKUQba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:31:30 -0500
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5070C1A2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:31:19 -0800 (PST)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
        by cmsmtp with ESMTPS
        id 5TAWrTCudjtZ35Telrch2p; Tue, 21 Nov 2023 16:31:23 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 5TefrZCSNqkaT5Tefr3SK2; Tue, 21 Nov 2023 16:31:18 +0000
X-Authority-Analysis: v=2.4 cv=bY547cDB c=1 sm=1 tr=0 ts=655cdb56
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=el_zaujX9iDH7R9aTdgA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7CrKRXxwaxc41PDQ+3XM7MTcEtfrLzQtzjAt/JtViAY=; b=FwqPqpsbVsD/zWAVItmkLhZ8H8
        WR9QrGmhfDb6RrzvWl4sZ+eW7MmBbgBY6/YK4SvgGM/IquCEnXdBv5Bf2BJ+wlUnwNEGN8d37SMx5
        Qvnke2MiE8FpG4L5COIa6J3SDs6qsZoaLp2+GgW4NTnfBl5vAMqnX3kslwOjkBzus5cCrEBStbyu5
        lUTv8/oGz7g72855qHaj9ysBbUki6vc9ENWtHbulMP8U7QZEiUKd09P2sJrZv99iEVaaM2VbHVHCY
        Bz0Jk/jEUF6ppQTb4qF42mrfkcy6Ay+JAKSiOkuKX9pacqjxOfcdN+tTkL2wBNtGGNg/0DzvPyKLA
        sX23VM8w==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:57028 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r5Tef-002iJo-0f;
        Tue, 21 Nov 2023 10:31:17 -0600
Message-ID: <26671a7a-c3ed-448e-a220-108516a50deb@embeddedor.com>
Date:   Tue, 21 Nov 2023 10:31:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the kspp-gustavo tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231121131903.68a37932@canb.auug.org.au>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231121131903.68a37932@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1r5Tef-002iJo-0f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:57028
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP2owLanUoxGhbcPyzJdn45OefiSrKzDMkCvEqbWrHbKSgJvM7UBL/MC23sGImZclOILI9Zi2qp4bxJk05zK5xp0Aav5rgrWsKiHQFg6n71YX0oQNxg+
 aR60Eg12joSsxVNMmjJBa0VEqYIrLfVO2TB1a53BcvdmNJwt+43vTeCmeVs3SFrPslVTZttpQtpzX2kgn51z72uU/lWLn4OzuJIHjfe+QlS7OgPvk54JFRF9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 11/20/23 20:19, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kspp-gustavo tree, today's linux-next build (powerpc
> pseries_le_defconfig) failed like this:
> 
> arch/powerpc/crypto/aes-gcm-p10-glue.c: In function 'gcmp10_init':
> arch/powerpc/crypto/aes-gcm-p10-glue.c:120:9: error: 'gcm_init_htable' accessing 256 bytes in a region of size 224 [-Werror=stringop-overflow=]
>    120 |         gcm_init_htable(hash->Htable+32, hash->H);
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/crypto/aes-gcm-p10-glue.c:120:9: note: referencing argument 1 of type 'unsigned char[256]'
> arch/powerpc/crypto/aes-gcm-p10-glue.c:120:9: note: referencing argument 2 of type 'unsigned char[16]'
> arch/powerpc/crypto/aes-gcm-p10-glue.c:40:17: note: in a call to function 'gcm_init_htable'
>     40 | asmlinkage void gcm_init_htable(unsigned char htable[256], unsigned char Xi[16]);
>        |                 ^~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>    167820dd258d ("Makefile: Enable -Wstringop-overflow globally")
> 
> I have used the kspp-gustavo tree from next-20231120 for today.
> 

Thanks a lot for the report, again!

We are pretty close to enabling this compiler option, and it seems you
are catching issues that neither 0-day folks nor I have caught before.

I wonder if you could help me catch the rest of these issues by disabling
WERROR (so we can get all the warnings) and letting your builds run with the
following patch on top:

diff --git a/Makefile b/Makefile
index ede0bd241056..596c33e6319b 100644
--- a/Makefile
+++ b/Makefile
@@ -982,6 +982,8 @@ NOSTDINC_FLAGS += -nostdinc
  # perform bounds checking.
  KBUILD_CFLAGS += $(call cc-option, -fstrict-flex-arrays=3)

+KBUILD_CFLAGS += $(call cc-option, -Wstringop-overflow)
+
  # disable invalid "can't wrap" optimizations for signed / pointers
  KBUILD_CFLAGS  += -fno-strict-overflow

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 2fe6f2828d37..1527199161d7 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -106,7 +106,6 @@ KBUILD_CFLAGS += $(call cc-option, -Wunused-const-variable)
  KBUILD_CFLAGS += $(call cc-option, -Wpacked-not-aligned)
  KBUILD_CFLAGS += $(call cc-option, -Wformat-overflow)
  KBUILD_CFLAGS += $(call cc-option, -Wformat-truncation)
-KBUILD_CFLAGS += $(call cc-option, -Wstringop-overflow)
  KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)

  KBUILD_CPPFLAGS += -Wundef
@@ -122,7 +121,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
  KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
  KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
  KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
-KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
  KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)

  ifdef CONFIG_CC_IS_CLANG


Thank you!
--
Gustavo

