Return-Path: <linux-kernel+bounces-21773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA1A829416
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DE81C2575F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C38338FA6;
	Wed, 10 Jan 2024 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJ3GTyz8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB23716F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704870928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kTt5OI9QpO/BOpHgZl5opubNaUnNqKIIbtwHk4ms4Vs=;
	b=eJ3GTyz8HSTnpkiVGYemN8/M4qRvmi8M7p0N+x9itJDQKnuRYdKTK4OGspj0It1cG/bapG
	4pVzSd+YfktGDe8j0OJ2dzN0tsB1ScQgPW4wJTN+/N/vg8ASzg5EkQq79mGjkARZf4MHlb
	J8EawdBh1xbG0rD990ppVuLrAst8kKM=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Fcrh3iRLOW24DM2s5w75Sg-1; Wed, 10 Jan 2024 02:15:26 -0500
X-MC-Unique: Fcrh3iRLOW24DM2s5w75Sg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bd3eb9643dso1977047b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704870926; x=1705475726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTt5OI9QpO/BOpHgZl5opubNaUnNqKIIbtwHk4ms4Vs=;
        b=O5+BGnRGvSqepv0H/fwL3NBHm3IKEqxUjpOcCdlAmpsvBRA8NRdwZtScqG1ejBO4Mn
         GgdHoF+7/xGYd5bauftvvJZqcLsUZnQ4GYufDwT0ymW2VX+MdsPJBBQS8WKFqKa7Mlua
         BSdRNIogG4cFyAbjaCx7b2ypQTMJ/lu1J1ZWe/OlW62zU7z2JdJNHGiTE2dXLLWN4p8Q
         PvdOuDfikwZ0G66fD6m6/Japnr9INN4urZU58Y7EIPC4Pbw0tSaSecgDFuSHxyUlGHqM
         NsM/2WWMdRsx0EKRu9SgbLBV6R7n21+9XQUOW9DRUtk5OWqvYwTGgkZQLtu9ZzuBFp1f
         uLLA==
X-Gm-Message-State: AOJu0YyFXIVF5lVkPO+b3uu+S+xGRx7n2zJKp0e6AGEMUXryaKINrYoG
	+sQSDAG7Im2UcMZRtt+vf4Pybs+CrgdCNsPFkzVxEsBLre/I7R5+KffaPkSTEJSJHKA9/hu0jwz
	hWzPC0vbTdKQBlK0ZO7w+JrU0Y5SPRCVa
X-Received: by 2002:a05:6808:171c:b0:3bb:bd15:828f with SMTP id bc28-20020a056808171c00b003bbbd15828fmr708214oib.104.1704870925907;
        Tue, 09 Jan 2024 23:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcnf4K76GZhVdOd3OzWp6ce6KrNoWyMXwOawD6ZNkjJ1VBAeSHwpohfDcE3bBbnY3sxQM9PA==
X-Received: by 2002:a05:6808:171c:b0:3bb:bd15:828f with SMTP id bc28-20020a056808171c00b003bbbd15828fmr708190oib.104.1704870925574;
        Tue, 09 Jan 2024 23:15:25 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a24-20020a62d418000000b006d70b0d4639sm2897467pfh.107.2024.01.09.23.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:15:25 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v2 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
Date: Wed, 10 Jan 2024 15:15:15 +0800
Message-ID: <20240110071522.1308935-1-coxu@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LUKS is the standard for Linux disk encryption. Many users choose LUKS
and in some use cases like Confidential VM it's mandated. With kdump
enabled, when the 1st kernel crashes, the system could boot into the
kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
specified target. Currently, when dumping vmcore to a LUKS
encrypted device, there are two problems,

 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes; For cloud confidential VMs, depending on the policy the
   kdump kernel may not be able to unseal the key with TPM and the
   console virtual keyboard is untrusted

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump. Take Fedora example, by default, only 256M is reserved for
   systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
   to be reserved for kdump. Note if the memory reserved for kdump can't
   be used by 1st kernel i.e. an user sees ~1300M memory missing in the
   1st kernel. 
 
Besides users (at least for Fedora) usually expect kdump to work out of
the box i.e. no manual password input is needed. And it doesn't make
sense to derivate the key again in kdump kernel which seems to be
redundant work.

This patch set addresses the above issues by reusing the LUKS volume key
in kdump kernel with the help of cryptsetup's new APIs
(--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
this kdump copy of LUKS volume key,

 1. After the 1st kernel loads the initramfs during boot, systemd
    use an user-input passphrase or TPM-sealed key to de-crypt the LUKS
    volume key and then save the volume key to specified keyring 
    (using the --link-vk-to-keyring API) and the key will expire within
    specified time.

 2.  A user space tool (kdump initramfs builder) writes the key description to
    /sys/kernel/crash_dm_crypt_key to inform the 1st kernel to save a
    temporary copy of the volume key while building the kdump initramfs

 3. The kexec_file_load syscall saves the temporary copy of the volume
    key to kdump reserved memory and wipe the copy.

 4. When the 1st kernel crashes and the kdump initramfs is booted, the kdump
    initramfs asks the kdump kernel to create a user key using the
    key stored in kdump reserved memory by writing the key
    description to /sys/kernel/crash_dm_crypt_key. Then the LUKS
    encrypted devide is unlocked with libcryptsetup's
    --volume-key-keyring API.

 5. The system gets rebooted to the 1st kernel after dumping vmcore to
    the LUKS encrypted device is finished

After libcryptsetup saving the LUKS volume key to specified keyring,
whoever takes this should be responsible for the safety of this copy
of key. This key will be saved in the memory area exclusively reserved
for kdump where even the 1st kernel has no direct access. And further
more, two additional protections are added,
 - save the copy randomly in kdump reserved memory as suggested by Jan
 - clear the _PAGE_PRESENT flag of the page that stores the copy as
   suggested by Pingfan

This patch set only supports x86. There will be patches to support other
architectures once this patch set gets merged.

v2
 - work together with libscryptsetup's --link-vk-to-keyring/--volume-key-keyring APIs [Milan and Ondrej]
 - add the case where console virtual keyboard is untrusted for confidential VM
 - use dm_crypt_key instead of LUKS volume key [Milan and Eric]
 - fix some code format issues
 - don't move "struct kexec_segment" declaration
 - Rebase the code onto latest Linus tree (6.7.0)

v1
 - "Put the luks key handling related to crash_dump out into a separate
   file kernel/crash_dump_luks.c" [Baoquan]
 - Put the generic luks handling code before the x86 specific code to
   make it easier for other arches to follow suit [Baoquan]
 - Use phys_to_virt instead of "pfn -> page -> vaddr" [Dave Hansen]
 - Drop the RFC prefix [Dave Young]
 - Rebase the code onto latest Linus tree (6.4.0-rc4)

RFC v2
 - libcryptsetup interacts with the kernel via sysfs instead of "hacking"
   dm-crypt 
   - to save a kdump copy of the LUKS volume key in 1st kernel
   - to add a logon key using the copy for libcryptsetup in kdump kernel [Milan]
   - to avoid the incorrect usage of LUKS master key in dm-crypt [Milan]
 - save the kdump copy of LUKS volume key randomly [Jan]
 - mark the kdump copy inaccessible [Pingfan]
 - Miscellaneous
   - explain when operations related to the LUKS volume key happen [Jan]
   - s/master key/volume key/g
   - use crash_ instead of kexec_ as function prefix
   - fix commit subject prefixes e.g. "x86, kdump" to x86/crash


Coiby Xu (5):
  kexec_file: allow to place kexec_buf randomly
  crash_dump: save the dm crypt key temporarily
  crash_dump: retrieve dm crypt key in kdump kernel
  x86/crash: pass the dm crypt key to kdump kernel
  x86/crash: make the page that stores the dm crypt key inaccessible

 arch/x86/kernel/crash.c            |  15 +-
 arch/x86/kernel/kexec-bzimage64.c  |   7 +
 arch/x86/kernel/machine_kexec_64.c |  18 +++
 include/linux/crash_core.h         |   7 +-
 include/linux/crash_dump.h         |   2 +
 include/linux/kexec.h              |   6 +
 kernel/Makefile                    |   2 +-
 kernel/crash_dump_dm_crypt.c       | 234 +++++++++++++++++++++++++++++
 kernel/kexec_file.c                |  15 ++
 kernel/ksysfs.c                    |  23 ++-
 10 files changed, 324 insertions(+), 5 deletions(-)
 create mode 100644 kernel/crash_dump_dm_crypt.c

-- 
2.43.0


