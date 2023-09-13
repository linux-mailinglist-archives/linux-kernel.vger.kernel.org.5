Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC079ECB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241658AbjIMPXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbjIMPXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ECF31BCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694618566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fibNFcMGfhpyzyB1Dlmhk6FIYISVfSif6JjtonTL8MA=;
        b=Fl8uSjqZ2eZ9Z1vkMxMKugIqegWS1YlvdUEB+t6gUDor8ZUiR8IWFcnGYq2ye5tOlXga2O
        Pv6DadvdN9tcuMysLNRdFL1monWLcL0QA/H3mbOZ/ogEgrtbDqKv7NRJxtV8hy8DCuLszM
        9H+8B9nYoEPAy6G79LEsfqpJyrIBBDo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-4S76KYwBMxSgRnPp4wPg9A-1; Wed, 13 Sep 2023 11:22:44 -0400
X-MC-Unique: 4S76KYwBMxSgRnPp4wPg9A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a9d7a801a3so458690166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618561; x=1695223361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fibNFcMGfhpyzyB1Dlmhk6FIYISVfSif6JjtonTL8MA=;
        b=Re1YFoZT3rZU54Uot+mFpudoMSG8OScdnxOYuewezoPYFShqxTaJnM4v0+arHTxVa/
         y0EM9D/H/wDR0mBt2UJEZ6DT9MOXtNJkWqXmBJGIpyfCFVPDz+Y2E+RUrkR3rDwyoXTZ
         FUFjP9B2FPUWPdx/u4xZcrDGzj3JIJu4fvhiorIDJbRVoBTIiVyRM2qtcoOPnLFXmEuZ
         eq0HhZM3pi+aNeHGaIWtPQHV5b4AD92Las0Utw1IeJdCSPFfThGZzCyzQv8V4vJlFhXX
         xD81N0CADIcobiE4LkgxYIia+VkgWcvQncvxir8aDh+ZEFP+p7OTsu+t8ZeV8IbycUCz
         FM3w==
X-Gm-Message-State: AOJu0YxRWF3lVmpqlJJaDznoCw8UpZtv528X+lJKaFG/ENtgM3m81Pwf
        hBKxBlg1G84bG+sIhSzYGXJMWGE0zr1XzHU3HYgHGMPC2cMpAfytfrSpxl451yL0LIwuzMKSymS
        nRU4fbQWR3+N9lShIoKa3F3uJ
X-Received: by 2002:a17:907:7742:b0:9a5:d657:47ee with SMTP id kx2-20020a170907774200b009a5d65747eemr2413310ejc.58.1694618561498;
        Wed, 13 Sep 2023 08:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCeVwF2+JcYHZGB2lIjCz1DTX4prKbW5ev4Hq7EfxD4YhEjBelhKvfKIbxLCPEf3bhJHP1ig==
X-Received: by 2002:a17:907:7742:b0:9a5:d657:47ee with SMTP id kx2-20020a170907774200b009a5d65747eemr2413286ejc.58.1694618561127;
        Wed, 13 Sep 2023 08:22:41 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (79-120-253-96.pool.digikabel.hu. [79.120.253.96])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906a09200b0099b8234a9fesm8640663ejy.1.2023.09.13.08.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:22:40 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [RFC PATCH 0/3] quering mount attributes
Date:   Wed, 13 Sep 2023 17:22:33 +0200
Message-ID: <20230913152238.905247-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the mount querying syscalls agreed on at LSF/MM 2023.  This is an
RFC with just x86_64 syscalls.

Excepting notification this should allow full replacement for
parsing /proc/self/mountinfo.

It is not a replacement for /proc/$OTHER_PID/mountinfo, since mount
namespace and root are taken from the current task.  I guess namespace and
root could be switched before invoking these syscalls but that sounds a bit
complicated.  Not sure if this is a problem.

Test utility attached at the end.
---

Miklos Szeredi (3):
  add unique mount ID
  add statmnt(2) syscall
  add listmnt(2) syscall

 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 fs/internal.h                          |   5 +
 fs/mount.h                             |   3 +-
 fs/namespace.c                         | 365 +++++++++++++++++++++++++
 fs/proc_namespace.c                    |  19 +-
 fs/stat.c                              |   9 +-
 fs/statfs.c                            |   1 +
 include/linux/syscalls.h               |   5 +
 include/uapi/asm-generic/unistd.h      |   8 +-
 include/uapi/linux/mount.h             |  36 +++
 include/uapi/linux/stat.h              |   1 +
 11 files changed, 443 insertions(+), 11 deletions(-)

-- 
2.41.0

=== statmnt.c ===
#define _GNU_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <err.h>

struct stmt_str {
	__u32 off;
	__u32 len;
};

struct statmnt {
	__u64 mask;		/* What results were written [uncond] */
	__u32 sb_dev_major;	/* Device ID */
	__u32 sb_dev_minor;
	__u64 sb_magic;		/* ..._SUPER_MAGIC */
	__u32 sb_flags;		/* MS_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
	__u32 __spare1;
	__u64 mnt_id;		/* Unique ID of mount */
	__u64 mnt_parent_id;	/* Unique ID of parent (for root == mnt_id) */
	__u32 mnt_id_old;	/* Reused IDs used in proc/.../mountinfo */
	__u32 mnt_parent_id_old;
	__u64 mnt_attr;		/* MOUNT_ATTR_... */
	__u64 mnt_propagation;	/* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
	__u64 mnt_peer_group;	/* ID of shared peer group */
	__u64 mnt_master;	/* Mount receives propagation from this ID */
	__u64 propagate_from;	/* Propagation from in current namespace */
	__u64 __spare[20];
	struct stmt_str mnt_root;	/* Root of mount relative to root of fs */
	struct stmt_str mountpoint;	/* Mountpoint relative to root of process */
	struct stmt_str fs_type;	/* Filesystem type[.subtype] */
	struct stmt_str sb_opts;	/* Super block string options (nul delimted) */
};

#define STMT_SB_BASIC		0x00000001U     /* Want/got sb_... */
#define STMT_MNT_BASIC		0x00000002U	/* Want/got mnt_... */
#define STMT_PROPAGATE_FROM	0x00000004U	/* Want/got propagate_from */
#define STMT_MNT_ROOT		0x00000008U	/* Want/got mnt_root  */
#define STMT_MOUNTPOINT		0x00000010U	/* Want/got mountpoint */
#define STMT_FS_TYPE		0x00000020U	/* Want/got fs_type */
#define STMT_SB_OPTS		0x00000040U	/* Want/got sb_opts */

#define __NR_statmnt   454
#define __NR_listmnt   455

#define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */

int main(int argc, char *argv[])
{
	char buf[65536];
	struct statmnt *st = (void *) buf;
	char *end;
	const char *arg = argv[1];
	long res;
	int list = 0;
	unsigned long mnt_id;
	unsigned int mask = STMT_SB_BASIC | STMT_MNT_BASIC | STMT_PROPAGATE_FROM | STMT_MNT_ROOT | STMT_MOUNTPOINT | STMT_FS_TYPE | STMT_SB_OPTS;

	if (arg && strcmp(arg, "-l") == 0) {
		list = 1;
		arg = argv[2];
	}
	if (argc != list + 2)
		errx(1, "usage: %s [-l] (mnt_id|path)", argv[0]);

	mnt_id = strtol(arg, &end, 0);
	if (!mnt_id || *end != '\0') {
		struct statx sx;

		res = statx(AT_FDCWD, arg, 0, STATX_MNT_ID_UNIQUE, &sx);
		if (res == -1)
			err(1, "%s", arg);

		if (!(sx.stx_mask & (STATX_MNT_ID | STATX_MNT_ID_UNIQUE)))
			errx(1, "Sorry, no mount ID");

		mnt_id = sx.stx_mnt_id;
	}


	if (list) {
		size_t size = 8192;
		uint64_t list[size];
		long i, num;

		res = syscall(__NR_listmnt, mnt_id, list, size, 0);
		if (res == -1)
			err(1, "listmnt(%lu)", mnt_id);

		num = res;
		for (i = 0; i < num; i++) {
			printf("0x%lx / ", list[i]);

			res = syscall(__NR_statmnt, list[i], STMT_MNT_BASIC | STMT_MOUNTPOINT, &buf, sizeof(buf), 0);
			if (res == -1) {
				printf("???\t[%s]\n", strerror(errno));
			} else {
				printf("%u\t%s\n", st->mnt_id_old,
				       (st->mask & STMT_MOUNTPOINT) ? buf + st->mountpoint.off : "???");
			}
		}

		return 0;
	}

	res = syscall(__NR_statmnt, mnt_id, mask, &buf, sizeof(buf), 0);
	if (res == -1)
		err(1, "statmnt(%lu)", mnt_id);

	printf("mask: 0x%llx\n", st->mask);
	if (st->mask & STMT_SB_BASIC) {
		printf("sb_dev_major: %u\n", st->sb_dev_major);
		printf("sb_dev_minor: %u\n", st->sb_dev_minor);
		printf("sb_magic: 0x%llx\n", st->sb_magic);
		printf("sb_flags: 0x%08x\n", st->sb_flags);
	}
	if (st->mask & STMT_MNT_BASIC) {
		printf("mnt_id: 0x%llx\n", st->mnt_id);
		printf("mnt_parent_id: 0x%llx\n", st->mnt_parent_id);
		printf("mnt_id_old: %u\n", st->mnt_id_old);
		printf("mnt_parent_id_old: %u\n", st->mnt_parent_id_old);
		printf("mnt_attr: 0x%08llx\n", st->mnt_attr);
		printf("mnt_propagation: %s%s%s%s\n",
		       st->mnt_propagation & MS_SHARED ? "shared," : "",
		       st->mnt_propagation & MS_SLAVE ? "slave," : "",
		       st->mnt_propagation & MS_UNBINDABLE ? "unbindable," : "",
		       st->mnt_propagation & MS_PRIVATE ? "private" : "");
		printf("mnt_peer_group: %llu\n", st->mnt_peer_group);
		printf("mnt_master: %llu\n", st->mnt_master);
	}
	if (st->mask & STMT_PROPAGATE_FROM) {
		printf("propagate_from: %llu\n", st->propagate_from);
	}
	if (st->mask & STMT_MNT_ROOT) {
		printf("mnt_root: %i/%u <%s>\n", st->mnt_root.off,
		       st->mnt_root.len, buf + st->mnt_root.off);
	}
	if (st->mask & STMT_MOUNTPOINT) {
		printf("mountpoint: %i/%u <%s>\n", st->mountpoint.off,
		       st->mountpoint.len, buf + st->mountpoint.off);
	}
	if (st->mask & STMT_FS_TYPE) {
		printf("fs_type: %i/%u <%s>\n", st->fs_type.off,
		       st->fs_type.len, buf + st->fs_type.off);
	}

	if (st->mask & STMT_SB_OPTS) {
		char *p = buf + st->sb_opts.off;
		char *end = p + st->sb_opts.len;

		printf("sb_opts: %i/%u ", st->sb_opts.off, st->sb_opts.len);
		for (; p < end; p += strlen(p) + 1)
			printf("<%s>, ", p);
		printf("\n");
	}

	return 0;
}

