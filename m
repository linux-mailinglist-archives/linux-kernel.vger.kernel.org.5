Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FADA803311
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjLDMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjLDMi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:38:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEB0138
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701693542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UcMY0nO5dqmWwUW8huSAOrcglj827NnzxtT47SpXgsE=;
        b=dm5FcEviLMNMbftrXgJsz2Ct/YjrvMyNLV6XOy6MPVqNCNFspE6JwrQzRfSfmhIDGBqHtt
        RrIRA12dts3xKqspGX3jmrRQj5xuQO/4+lMiLou72N4CfPKZhiKnKl2LV3VymrxrWcxSyB
        vL+l/7ynz6Gt5+LggAyBA81uwptBW0g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-otEc4RVRM-68zj8fVGphuQ-1; Mon, 04 Dec 2023 07:39:01 -0500
X-MC-Unique: otEc4RVRM-68zj8fVGphuQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b53d6a000so7718725e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:39:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693540; x=1702298340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcMY0nO5dqmWwUW8huSAOrcglj827NnzxtT47SpXgsE=;
        b=sVAVhfzkbYhdF3q02OikP/sUWieyqCCbM4RlOR8IV3dfQhC7Hxb/HaO6EM4CgzovWK
         YEjBFOOIvUCxl7kzjGbd8yX4bVIdv63gxrC8AZsg+Bs+DD+vicoKAw4rhjcKF7nCgdKm
         uzUu5t2dMFvdkLZQcHH78MvpXeVgAFP1wIqmm4nj1vWbzNBql9nRoN6nZg5obmfmEkYM
         hlsHMbfxYmqYEG0hP06vNTf5XktbPPI2qkvPYDLH1rIhgMyoVer9KpPUgTFuusNlP8NY
         uBS4xUw7h6yDPKkzmOj8KkmW4W6HvBwsUd3rm+99+97uRzdYCCOAqqyKoJUPbyROjEpT
         4wAw==
X-Gm-Message-State: AOJu0YzOqW6qYl7AExi95/xUD40D8RlRKybKyo7ikoXJlKQH0141QmUC
        7w1jyg06ixdi0+qLHSlooMhbZpjzUqCFBYDPWNENlKqdfb8i1DmgXWLeW8UJFoAlvWhC1FBhtZn
        6s6+TcQvJXF/ELt8A98HAIv2R
X-Received: by 2002:a05:600c:5107:b0:40c:b81:c640 with SMTP id o7-20020a05600c510700b0040c0b81c640mr1623746wms.0.1701693540528;
        Mon, 04 Dec 2023 04:39:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQsV4RBp/fnNOsRStFq9HDTbccY1Zuz+Z7n3e9KaqVNhPsdooOIQ+iBn81u+1GTibRMX8jdw==
X-Received: by 2002:a05:600c:5107:b0:40c:b81:c640 with SMTP id o7-20020a05600c510700b0040c0b81c640mr1623707wms.0.1701693540051;
        Mon, 04 Dec 2023 04:39:00 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c8:b00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b0040b538047b4sm18355935wms.3.2023.12.04.04.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:38:59 -0800 (PST)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Hanjun Guo <guohanjun@huawei.com>, NeilBrown <neilb@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Uladzislau Koshchanka <koshchanka@gmail.com>,
        John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Philipp Stanner <pstanner@redhat.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Yury Norov <yury.norov@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>, dakr@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 0/5] Regather scattered PCI-Code
Date:   Mon,  4 Dec 2023 13:38:27 +0100
Message-ID: <20231204123834.29247-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Stable-Kernel:
You receive this patch series because its first patch fixes leaks in
PCI.


Changes in v3:
- Create a separate patch for the leaks in lib/iomap.c. Make it the
  series' first patch. (Arnd)
- Turns out the aforementioned bug wasn't just accidentally removing
  iounmap() with the ifdef, it was also missing ioport_unmap() to begin
  with. Add it.
- Move the ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT-mechanism from
  asm-generic/io.h to asm-generic/ioport.h. (Arnd)
- Adjust the implementation of iomem_is_ioport() in asm-generic/io.h so
  that it matches exactly what pci_iounmap() previously did in
  lib/pci_iomap.c. (Arnd)
- Move the CONFIG_HAS_IOPORT guard in asm-generic/io.h so that
  iomem_is_ioport() will always be compiled and just returns false if
  there are no ports.
- Add TODOs to several places informing about the generic
  iomem_is_ioport() in lib/iomap.c not being generic.
- Add TODO about the followup work to make drivers/pci/iomap.c's
  pci_iounmap() actually generic.

Changes in v2:
- Replace patch 4, previously extending the comment about pci_iounmap()
  in lib/iomap.c, with a patch that moves pci_iounmap() from that file
  to drivers/pci/iomap.c, creating a unified version there. (Arnd)
- Implement iomem_is_ioport() as a new helper in asm-generic/io.h and
  lib/iomap.c. (Arnd)
- Move the build rule in drivers/pci/Makefile for iomap.o under the
  guard of #if PCI. This had to be done because when just checking for
  GENERIC_PCI_IOMAP being defined, the functions don't disappear, which
  was the case previously in lib/pci_iomap.c, where the entire file was
  made empty if PCI was not set by the guard #ifdef PCI. (Intel's Bots)
- Rephares all patches' commit messages a little bit.


Sooooooooo. I reworked v1.

Please review this carefully, the IO-Ranges are obviously a bit tricky,
as is the build-system / ifdef-ery.

Arnd has suggested that architectures defining a custom inb() need their
own iomem_is_ioport(), as well. I've grepped for inb() and found the
following list of archs that define their own:
  - alpha
  - arm
  - m68k <--
  - parisc
  - powerpc
  - sh
  - sparc
  - x86 <--

All of those have their own definitons of pci_iounmap(). Therefore, they
don't need our generic version in the first place and, thus, also need
no iomem_is_ioport().
The two exceptions are x86 and m68k. The former uses lib/iomap.c through
CONFIG_GENERIC_IOMAP, as Arnd pointed out in the previous discussion
(thus, CONFIG_GENERIC_IOMAP is not really generic in this regard).

So as I see it, only m68k WOULD need its own custom definition of
iomem_is_ioport(). But as I understand it it doesn't because it uses the
one from asm-generic/pci_iomap.h ??

I wasn't entirely sure how to deal with the address ranges for the
generic implementation in asm-generic/io.h. It's marked with a TODO.
Input appreciated.

I removed the guard around define pci_iounmap in asm-generic/io.h. An
alternative would be to have it be guarded by CONFIG_GENERIC_IOMAP and
CONFIG_GENERIC_PCI_IOMAP, both. Without such a guard, there is no
collision however, because generic pci_iounmap() from
drivers/pci/iomap.c will only get pulled in when
CONFIG_GENERIC_PCI_IOMAP is actually set.

I cross-built this for a variety of architectures, including the usual
suspects (s390, m68k). So far successfully. But let's see what Intel's
robots say :O

P.


Original cover letter:

Hi!

So it seems that since ca. 2007 the PCI code has been scattered a bit.
PCI's devres code, which is only ever used by users of the entire
PCI-subsystem anyways, resides in lib/devres.c and is guarded by an
ifdef PCI, just as the content of lib/pci_iomap.c is.

It, thus, seems reasonable to move all of that.

As I were at it, I moved as much of the devres-specific code from pci.c
to devres.c, too. The only exceptions are four functions that are
currently difficult to move. More information about that can be read
here [1].

I noticed these scattered files while working on (new) PCI-specific
devres functions. If we can get this here merged, I'll soon send another
patch series that addresses some API-inconsistencies and could move the
devres-part of the four remaining functions.

I don't want to do that in this series as this here is only about moving
code, whereas the next series would have to actually change API
behavior.

I successfully (cross-)built this for x86, x86_64, AARCH64 and ARM
(allyesconfig). I booted a kernel with it on x86_64, with a Fedora
desktop environment as payload. The OS came up fine

I hope this is OK. If we can get it in, we'd soon have a very
consistent PCI API again.

Regards,
P.


Philipp Stanner (5):
  lib/pci_iomap.c: fix cleanup bugs in pci_iounmap()
  lib: move pci_iomap.c to drivers/pci/
  lib: move pci-specific devres code to drivers/pci/
  pci: move devres code from pci.c to devres.c
  lib, pci: unify generic pci_iounmap()

 drivers/pci/Kconfig                    |   5 +
 drivers/pci/Makefile                   |   3 +-
 drivers/pci/devres.c                   | 450 +++++++++++++++++++++++++
 lib/pci_iomap.c => drivers/pci/iomap.c |  49 +--
 drivers/pci/pci.c                      | 249 --------------
 drivers/pci/pci.h                      |  24 ++
 include/asm-generic/io.h               |  27 +-
 include/asm-generic/iomap.h            |  21 ++
 lib/Kconfig                            |   3 -
 lib/Makefile                           |   1 -
 lib/devres.c                           | 208 +-----------
 lib/iomap.c                            |  28 +-
 12 files changed, 565 insertions(+), 503 deletions(-)
 create mode 100644 drivers/pci/devres.c
 rename lib/pci_iomap.c => drivers/pci/iomap.c (75%)

-- 
2.43.0

