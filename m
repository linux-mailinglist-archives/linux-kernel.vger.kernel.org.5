Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB1F807045
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378205AbjLFMyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378143AbjLFMyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:54:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33249FA;
        Wed,  6 Dec 2023 04:54:37 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9AF461FD0C;
        Wed,  6 Dec 2023 12:54:35 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 13BCD13403;
        Wed,  6 Dec 2023 12:54:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id 9HGHAwtvcGV6dAAAn2gu4w
        (envelope-from <tzimmermann@suse.de>); Wed, 06 Dec 2023 12:54:35 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, bhelgaas@google.com, arnd@arndb.de,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        javierm@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/3] arch/x86: Remove unnecessary dependencies on bootparam.h
Date:   Wed,  6 Dec 2023 13:38:36 +0100
Message-ID: <20231206125433.18420-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9AF461FD0C
X-Spam-Score: 6.49
X-Spamd-Result: default: False [6.49 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         R_MISSING_CHARSET(2.50)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_TWELVE(0.00)[22];
         MID_CONTAINS_FROM(1.00)[];
         FREEMAIL_TO(0.00)[kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of tzimmermann@suse.de) smtp.mailfrom=tzimmermann@suse.de
X-Rspamd-Server: rspamd1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce built time in some cases by removing unnecessary include statements
for <asm/bootparam.h>. Reorganize some header files accordingly.

While working on the kernel's boot-up graphics, I noticed that touching
include/linux/screen_info.h triggers a complete rebuilt of the kernel
on x86. It turns out that the architecture's PCI and EFI headers include
<asm/bootparam.h>, which depends on <linux/screen_info.h>. But none of
the drivers have any business with boot parameters or the screen_info
state.

The patchset moves a few limes from pci.h and efi.h into separate header
files and then removes the obsolete include statements on x86. I did

  make allmodconfig
  make -j28
  touch include/linus/screen_info.h
  time -j28 make

to measure the time it takes to rebuild. Results without the patchset
are around 20 minutes.

  real    20m46,705s
  user    354m29,166s
  sys     28m27,359s

And with the patchset applied it goes down to about a minute.

  real    0m58,232s
  user    4m37,617s
  sys     0m34,993s

The test system was an Intel i5-13500.

Thomas Zimmermann (3):
  arch/x86: Move struct pci_setup_rom into pci_setup.h
  arch/x86: Add <asm/ima-efi.h> for arch_ima_efi_boot_mode
  arch/x86: Do not include <asm/bootparam.h> in several header files

 arch/x86/include/asm/efi.h              |  3 ---
 arch/x86/include/asm/ima-efi.h          | 12 ++++++++++++
 arch/x86/include/asm/kexec.h            |  1 -
 arch/x86/include/asm/mem_encrypt.h      |  2 +-
 arch/x86/include/asm/pci.h              | 13 -------------
 arch/x86/include/asm/pci_setup.h        | 19 +++++++++++++++++++
 arch/x86/include/asm/sev.h              |  3 ++-
 arch/x86/include/asm/x86_init.h         |  2 --
 arch/x86/pci/common.c                   |  1 +
 drivers/firmware/efi/libstub/x86-stub.c |  1 +
 include/asm-generic/Kbuild              |  1 +
 include/asm-generic/ima-efi.h           | 16 ++++++++++++++++
 security/integrity/ima/ima_efi.c        |  5 +----
 13 files changed, 54 insertions(+), 25 deletions(-)
 create mode 100644 arch/x86/include/asm/ima-efi.h
 create mode 100644 arch/x86/include/asm/pci_setup.h
 create mode 100644 include/asm-generic/ima-efi.h


base-commit: a9d99261a978835b02e248fe18af3026416af3e8
-- 
2.43.0

