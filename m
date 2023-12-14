Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B599812DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443805AbjLNK4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444030AbjLNKzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:55:51 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C06135;
        Thu, 14 Dec 2023 02:55:07 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35f761ef078so5506535ab.2;
        Thu, 14 Dec 2023 02:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702551306; x=1703156106; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3ZNilpy3qZ2+L977W0bZZ4Uoj1rm+EIz9k16UCS2kM=;
        b=VJEZ2/vxP6eTwrmPdDOaDT993XsaKUXugJUQMdidERwz5jps/qljtb6wbz8QyKFGDo
         /y6ShOxUyw1slzVsBSFq8OCQOaMBTSNTPCS662WyHw5jSfJ9lyzU0ne1cQPTScxfedDn
         8QpdAtvV8JgsT1NA516aUUzBKlJnuBGoSo4hPrT4HAQzf10rUsQ0ZBW1Z+qFtItkdh/r
         j9XO94PT9sTVJFg5iOt98eOZbcxSZ71nYYp6yiodlWrRE8EtI49gpNWeZi4u4ZHkPaJo
         cysn+7BwAOq7C+jbpZ1/PJxgzcnLpV0+iaLQYQdqOvg02a/D5wWMDT4DfZDwYkaUwdD6
         fX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551306; x=1703156106;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3ZNilpy3qZ2+L977W0bZZ4Uoj1rm+EIz9k16UCS2kM=;
        b=ISakdzfBCTWVT1Adj9O6Zku5J3CCHnPUaZ/1/Kx9o9/serUGNy9wYZUYCtezixFRU4
         /dC2RJKO0e65DLKV8qGtI+xphGx4UqUJ+d8s49PNZZG6NeTb4je0GDjIuOli/Kqcs5it
         oBjjfHwE5zIZuDEp7FzdU0hlpcv9oj6cXHX3VgTf9v9UItcKXcy6T8mgeg4nGth0Qsct
         WE0gejuu8/9R0nl/iaNJQNrZLbdrtd3tBD4J1P6ufsjRALEXvdykETGLoAzwFQ0ONAkx
         AZqemz8dLKfloWgoCeauLnB2GDi61OUUMfz96lCI4O7BYBTjDTfte50wZQpeA6u8oVpa
         26Xw==
X-Gm-Message-State: AOJu0Yyt5K4/NlcNqKtFniu9K6abSJLFm1oTY7KqgzsFcfLs7+T93xKq
        o3icaIB/prxuf3J5I3voe3o=
X-Google-Smtp-Source: AGHT+IH0L83LZBzlc1m00CwO9ZKzNgGcCdFcIb+HE2lidtSB3uGhCCP4kPqcsEZlAZ1OA+4Hd/ht4A==
X-Received: by 2002:a05:6e02:164a:b0:35f:77a9:9cd4 with SMTP id v10-20020a056e02164a00b0035f77a99cd4mr2796467ilu.41.1702551306403;
        Thu, 14 Dec 2023 02:55:06 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b001cfcd4eca11sm12100650plg.114.2023.12.14.02.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:55:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 9BB5C102057E2; Thu, 14 Dec 2023 17:55:01 +0700 (WIB)
Date:   Thu, 14 Dec 2023 17:55:01 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     SELinux Mailing List <selinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ilija Tovilo <ilija.tovilo@me.com>
Subject: Fwd: SELinux mprotect EACCES/execheap for memory segment directly
 adjacent to heap
Message-ID: <ZXrfBYLGiNXDKkJa@archie.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wAU0P7pifLBq4JoJ"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wAU0P7pifLBq4JoJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I forward a Bugzilla report [1]. As you may know, many developers don't
take a look on Bugzilla (especially linux-kernel@kernel-bugs.kernel.org
as no one subscribes to the generic component).

The original reporter (Ilija Tovilo) writes:

> Hi! We're running into an issue with SELinux where mprotect will result i=
n a EACCES due to the execheap policy since Kernel 6.6. This happens when t=
he mmap-ed segment lies directly adjacent to the heap. I think this is caus=
ed by the following patch:
>=20
> https://github.com/torvalds/linux/commit/68df1baf158fddc07b6f0333e4c81fe1=
ccecd6ff
>=20
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee5f..ee8575540a8efc 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3762,13 +3762,10 @@ static int selinux_file_mprotect(struct vm_area_s=
truct *vma,
>  	if (default_noexec &&
>  	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
>  		int rc =3D 0;
> -		if (vma->vm_start >=3D vma->vm_mm->start_brk &&
> -		    vma->vm_end <=3D vma->vm_mm->brk) {
> +		if (vma_is_initial_heap(vma)) {
>  			rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>  					  PROCESS__EXECHEAP, NULL);
> -		} else if (!vma->vm_file &&
> -			   ((vma->vm_start <=3D vma->vm_mm->start_stack &&
> -			     vma->vm_end >=3D vma->vm_mm->start_stack) ||
> +		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
>  			    vma_is_stack_for_current(vma))) {
>  			rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
>  					  PROCESS__EXECSTACK, NULL);
>=20
> Before this patch, selinux_file_mprotect would check whether the original=
 start_brk and brk values lied within the vma segment. However, this does n=
ot match the vma_is_initial_heap implementation.
>=20
> static inline bool vma_is_initial_heap(const struct vm_area_struct *vma)
> {
>        return vma->vm_start <=3D vma->vm_mm->brk &&
> 		vma->vm_end >=3D vma->vm_mm->start_brk;
> }
>=20
> This function checks whether vma overlaps with start_brk/brk. However, si=
nce the comparison includes equality this will also yield true if the segme=
nt lies directly before or after the heap. It's possible that equality is h=
andling cases where start_brk =3D=3D brk and start_brk =3D=3D vm_start, but=
 I'm not sure. In that case, the following patch might work.
>=20
> static inline bool vma_is_initial_heap(const struct vm_area_struct *vma)
> {
>        return (vma->vm_start < vma->vm_mm->brk && vma->vm_end > vma->vm_m=
m->start_brk)
> 		|| vma->vm_start =3D=3D vma->vm_mm->start_brk;
> }

Then he gives bug reproducers:

> Here's a small reproducer, which may be of help:
>=20
> int main(void)
> {
> 	const size_t size =3D 2 * 1024 * 1024;
> 	void *brk =3D sbrk(0);
> 	void *mem =3D mmap(brk, size, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONY=
MOUS|MAP_FIXED, -1, 0);
> 	if (mem =3D=3D MAP_FAILED) {
> 		fprintf(stderr, "Address %p wasn't free, try again.\n", brk);
> 		exit(1);
> 	}
> 	if (mprotect(mem, size, PROT_READ|PROT_EXEC) =3D=3D -1) {
> 		fprintf(stderr, "mprotect() failed [%d] %s\n", errno, strerror(errno));
> 		exit(1);
> 	}
> 	munmap(mem, size);
> }
>=20
> Results in:
>=20
> mprotect() failed [13] Permission denied
>=20
> Adding some padding between the heap using `void *brk =3D sbrk(0) + size;=
` solves the problem.
>
=20
> For completion, the inverse also fails, as expected.
>=20
> #include <stdint.h>
> #include <sys/mman.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <errno.h>
> #include <string.h>
>=20
> static void *find_start_brk(void)
> {
> 	uintptr_t start, end;
> 	FILE *f;
> 	char buffer[4096];
> 	f =3D fopen("/proc/self/maps", "r");
> 	while (fgets(buffer, 4096, f) && sscanf(buffer, "%lx-%lx", &start, &end)=
 =3D=3D 2) {
> 		if (strstr(buffer, "[heap]") !=3D NULL) {
> 			return (void *)start;
> 		}
> 	}
> 	fclose(f);
>=20
> 	return 0;
> }
>=20
> int main(void)
> {
> 	const size_t size =3D 2 * 1024 * 1024;
> 	void *start_brk =3D find_start_brk();
> 	void *mem =3D mmap(start_brk - size, size, PROT_READ|PROT_WRITE, MAP_SHA=
RED|MAP_ANONYMOUS|MAP_FIXED, -1, 0);
> 	if (mem =3D=3D MAP_FAILED) {
> 		fprintf(stderr, "Address %p wasn't free, try again.\n", brk);
> 		exit(1);
> 	}
> 	if (mprotect(mem, size, PROT_READ|PROT_EXEC) =3D=3D -1) {
> 		fprintf(stderr, "mprotect() failed [%d] %s\n", errno, strerror(errno));
> 		exit(1);
> 	}
> 	munmap(mem, size);
> }

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218258

--=20
An old man doll... just what I always wanted! - Clara

--wAU0P7pifLBq4JoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZXre/gAKCRD2uYlJVVFO
oxEhAP9Kr/Z7UmqksA5rmebMV7HJVztmqoOBwzpBm2TSypAbrgEAnTJ1pJ3h/Psa
AWTqOiH62l81q3kdX3sKmEH8qsopZAg=
=iO6X
-----END PGP SIGNATURE-----

--wAU0P7pifLBq4JoJ--
