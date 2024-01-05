Return-Path: <linux-kernel+bounces-18361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 113F1825C0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949B71F24377
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F18364A8;
	Fri,  5 Jan 2024 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smXtvof4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392FB360B0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed430ef5eso152386276.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 13:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704489228; x=1705094028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGCSFlWKydblwWMOFacS3ACee5xNkQaM8WYvo0xjaiE=;
        b=smXtvof4D5e/8albIlytcM7vCmEUtV8RQrH3tsjdNESjlJaAvHGtlT18Vbs0cu0qGH
         fQIZrdcTfWDLG+gKRUaDchwnIhIfrQCenuW77Ya+uNFQIykpAWISziUmuye7Yk0mhiaX
         Xi2OqUSv3GE93t8p1RQg8lzOWXg7pRiObcGDp6wFgVkM6VKK5929APpQ8wgfi8FLRPji
         qDQ7Abfpu3WS9xNt4t+VHYRt07cdMSoWIYesadCkc5w8zjpEWoEA8Kumf5aDA7f8749x
         kKPWBxf/ugsRNeASyq1FHclOrSeS+tK/Wt+p+RgBU+T0rKFrEwJnaJVJ+SkgGah65XFs
         5o3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704489228; x=1705094028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGCSFlWKydblwWMOFacS3ACee5xNkQaM8WYvo0xjaiE=;
        b=wQyjyLg78d1EBGFsfkyM+EX1GpQYbZmzu9V0yXpjhfZJR9kjgNm+ROo+aE06QQlycz
         9xPDWr/cfRTUcH3fmOmTA1+YCPWh4S2rscydiAaBY7Y8CYFhsPS5wYwjcIc5mq26Rr24
         Gl7FDucWvNjHS4LvUG0hbNQlPfxQKu9Ed/ATVn1ygHa0bQdAT41UMhINZa6EMTOlm+Sd
         XzthLnlWKMY1mzaVQmzzT6YuR67QtcY1R2EN0ivNU8JI8K1Whn9qeGdz1T4leOHPmUI1
         8Quf5Q8DPPBbA4NyHoCMful35FakQqoCSngC7QERXAQzi4DzKCqIGvyvztvBCP3VFFcI
         +Asg==
X-Gm-Message-State: AOJu0YwFAgG89bVUfMaHjxQjppOGlsfKxcXefAKXSkpw6mH+xgaDOvGu
	n9eZ95ZNQVm39flwwcTOXIz12p9FRU97kwJe2fkXTvolSG0BfZQLsfNSQLxazXsO
X-Google-Smtp-Source: AGHT+IEqps6rRJqqnGzpToplu959Ly9xVwkRQ2+JhIIRSapp4Irsg5E6CKfWOeHY+eq9eK1vb2nCB9Fpg5D2bMM1uyc=
X-Received: by 2002:a25:9c46:0:b0:db7:dad0:76db with SMTP id
 x6-20020a259c46000000b00db7dad076dbmr2491348ybo.119.1704489227807; Fri, 05
 Jan 2024 13:13:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713001833.3778937-1-jiaqiyan@google.com> <20230713001833.3778937-5-jiaqiyan@google.com>
 <be3976b5-0a9c-41c6-8160-88e6c1e5d63e@collabora.com>
In-Reply-To: <be3976b5-0a9c-41c6-8160-88e6c1e5d63e@collabora.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 5 Jan 2024 13:13:35 -0800
Message-ID: <CACw3F51WvZDVCpVg9j4j8WmnmAFOsnK+FZDDoVqhgLqVwhPTCA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs read
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linmiaohe@huawei.com, mike.kravetz@oracle.com, naoya.horiguchi@nec.com, 
	akpm@linux-foundation.org, songmuchun@bytedance.com, shy828301@gmail.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, jthoughton@google.com, 
	"kernel@collabora.com" <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 10:27=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi,
>
> I'm trying to convert this test to TAP as I think the failures sometimes =
go
> unnoticed on CI systems if we only depend on the return value of the
> application. I've enabled the following configurations which aren't alrea=
dy
> present in tools/testing/selftests/mm/config:
> CONFIG_MEMORY_FAILURE=3Dy
> CONFIG_HWPOISON_INJECT=3Dm
>
> I'll send a patch to add these configs later. Right now I'm trying to
> investigate the failure when we are trying to inject the poison page by
> madvise(MADV_HWPOISON). I'm getting device busy every single time. The te=
st
> fails as it doesn't expect any business for the hugetlb memory. I'm not
> sure if the poison handling code has issues or test isn't robust enough.
>
> ./hugetlb-read-hwpoison
> Write/read chunk size=3D0x800
>  ... HugeTLB read regression test...
>  ...  ... expect to read 0x200000 bytes of data in total
>  ...  ... actually read 0x200000 bytes of data in total
>  ... HugeTLB read regression test...TEST_PASSED
>  ... HugeTLB read HWPOISON test...
> [    9.280854] Injecting memory failure for pfn 0x102f01 at process virtu=
al
> address 0x7f28ec101000
> [    9.282029] Memory failure: 0x102f01: huge page still referenced by 51=
1
> users
> [    9.282987] Memory failure: 0x102f01: recovery action for huge page: F=
ailed
>  ...  !!! MADV_HWPOISON failed: Device or resource busy
>  ... HugeTLB read HWPOISON test...TEST_FAILED
>
> I'm testing on v6.7-rc8. Not sure if this was working previously or not.

Thanks for reporting this, Usama!

I am also able to repro MADV_HWPOISON failure at "501a06fe8e4c
(akpm/mm-stable, mm-stable) zswap: memcontrol: implement zswap
writeback disabling."

Then I checked out the earliest commit "ba91e7e5d15a (HEAD -> Base)
selftests/mm: add tests for HWPOISON hugetlbfs read". The
MADV_HWPOISON injection works and and the test passes:

 ... HugeTLB read HWPOISON test...
 ...  ... expect to read 0x101000 bytes of data in total
 ...  !!! read failed: Input/output error
 ...  ... actually read 0x101000 bytes of data in total
 ... HugeTLB read HWPOISON test...TEST_PASSED
 ... HugeTLB seek then read HWPOISON test...
 ...  ... init val=3D4 with offset=3D0x102000
 ...  ... expect to read 0xfe000 bytes of data in total
 ...  ... actually read 0xfe000 bytes of data in total
 ... HugeTLB seek then read HWPOISON test...TEST_PASSED
 ...

[ 2109.209225] Injecting memory failure for pfn 0x3190d01 at process
virtual address 0x7f75e3101000
[ 2109.209438] Memory failure: 0x3190d01: recovery action for huge
page: Recovered
...

I think something in between broken MADV_HWPOISON on hugetlbfs, and we
should be able to figure it out via bisection (and of course by
reading delta commits between them, probably related to page
refcount).

That being said, I will be on vacation from tomorrow until the end of
next week. So I will get back to this after next weekend. Meanwhile if
you want to go ahead and bisect the problematic commit, that will be
very much appreciated.

Thanks,
Jiaqi


>
> Regards,
> Usama
>
> On 7/13/23 5:18 AM, Jiaqi Yan wrote:
> > Add tests for the improvement made to read operation on HWPOISON
> > hugetlb page with different read granularities. For each chunk size,
> > three read scenarios are tested:
> > 1. Simple regression test on read without HWPOISON.
> > 2. Sequential read page by page should succeed until encounters the 1st
> >    raw HWPOISON subpage.
> > 3. After skip a raw HWPOISON subpage by lseek, read()s always succeed.
> >
> > Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  tools/testing/selftests/mm/.gitignore         |   1 +
> >  tools/testing/selftests/mm/Makefile           |   1 +
> >  .../selftests/mm/hugetlb-read-hwpoison.c      | 322 ++++++++++++++++++
> >  3 files changed, 324 insertions(+)
> >  create mode 100644 tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> >
> > diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/self=
tests/mm/.gitignore
> > index 7e2a982383c0..cdc9ce4426b9 100644
> > --- a/tools/testing/selftests/mm/.gitignore
> > +++ b/tools/testing/selftests/mm/.gitignore
> > @@ -5,6 +5,7 @@ hugepage-mremap
> >  hugepage-shm
> >  hugepage-vmemmap
> >  hugetlb-madvise
> > +hugetlb-read-hwpoison
> >  khugepaged
> >  map_hugetlb
> >  map_populate
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selfte=
sts/mm/Makefile
> > index 66d7c07dc177..b7fce9073279 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -41,6 +41,7 @@ TEST_GEN_PROGS +=3D gup_longterm
> >  TEST_GEN_PROGS +=3D gup_test
> >  TEST_GEN_PROGS +=3D hmm-tests
> >  TEST_GEN_PROGS +=3D hugetlb-madvise
> > +TEST_GEN_PROGS +=3D hugetlb-read-hwpoison
> >  TEST_GEN_PROGS +=3D hugepage-mmap
> >  TEST_GEN_PROGS +=3D hugepage-mremap
> >  TEST_GEN_PROGS +=3D hugepage-shm
> > diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools=
/testing/selftests/mm/hugetlb-read-hwpoison.c
> > new file mode 100644
> > index 000000000000..ba6cc6f9cabc
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
> > @@ -0,0 +1,322 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#define _GNU_SOURCE
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +
> > +#include <linux/magic.h>
> > +#include <sys/mman.h>
> > +#include <sys/statfs.h>
> > +#include <errno.h>
> > +#include <stdbool.h>
> > +
> > +#include "../kselftest.h"
> > +
> > +#define PREFIX " ... "
> > +#define ERROR_PREFIX " !!! "
> > +
> > +#define MAX_WRITE_READ_CHUNK_SIZE (getpagesize() * 16)
> > +#define MAX(a, b) (((a) > (b)) ? (a) : (b))
> > +
> > +enum test_status {
> > +     TEST_PASSED =3D 0,
> > +     TEST_FAILED =3D 1,
> > +     TEST_SKIPPED =3D 2,
> > +};
> > +
> > +static char *status_to_str(enum test_status status)
> > +{
> > +     switch (status) {
> > +     case TEST_PASSED:
> > +             return "TEST_PASSED";
> > +     case TEST_FAILED:
> > +             return "TEST_FAILED";
> > +     case TEST_SKIPPED:
> > +             return "TEST_SKIPPED";
> > +     default:
> > +             return "TEST_???";
> > +     }
> > +}
> > +
> > +static int setup_filemap(char *filemap, size_t len, size_t wr_chunk_si=
ze)
> > +{
> > +     char iter =3D 0;
> > +
> > +     for (size_t offset =3D 0; offset < len;
> > +          offset +=3D wr_chunk_size) {
> > +             iter++;
> > +             memset(filemap + offset, iter, wr_chunk_size);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static bool verify_chunk(char *buf, size_t len, char val)
> > +{
> > +     size_t i;
> > +
> > +     for (i =3D 0; i < len; ++i) {
> > +             if (buf[i] !=3D val) {
> > +                     printf(PREFIX ERROR_PREFIX "check fail: buf[%lu] =
=3D %u !=3D %u\n",
> > +                             i, buf[i], val);
> > +                     return false;
> > +             }
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_c=
hunk_size,
> > +                                    off_t offset, size_t expected)
> > +{
> > +     char buf[MAX_WRITE_READ_CHUNK_SIZE];
> > +     ssize_t ret_count =3D 0;
> > +     ssize_t total_ret_count =3D 0;
> > +     char val =3D offset / wr_chunk_size + offset % wr_chunk_size;
> > +
> > +     printf(PREFIX PREFIX "init val=3D%u with offset=3D0x%lx\n", val, =
offset);
> > +     printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total=
\n",
> > +            expected);
> > +     if (lseek(fd, offset, SEEK_SET) < 0) {
> > +             perror(PREFIX ERROR_PREFIX "seek failed");
> > +             return false;
> > +     }
> > +
> > +     while (offset + total_ret_count < len) {
> > +             ret_count =3D read(fd, buf, wr_chunk_size);
> > +             if (ret_count =3D=3D 0) {
> > +                     printf(PREFIX PREFIX "read reach end of the file\=
n");
> > +                     break;
> > +             } else if (ret_count < 0) {
> > +                     perror(PREFIX ERROR_PREFIX "read failed");
> > +                     break;
> > +             }
> > +             ++val;
> > +             if (!verify_chunk(buf, ret_count, val))
> > +                     return false;
> > +
> > +             total_ret_count +=3D ret_count;
> > +     }
> > +     printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\=
n",
> > +            total_ret_count);
> > +
> > +     return total_ret_count =3D=3D expected;
> > +}
> > +
> > +static bool read_hugepage_filemap(int fd, size_t len,
> > +                               size_t wr_chunk_size, size_t expected)
> > +{
> > +     char buf[MAX_WRITE_READ_CHUNK_SIZE];
> > +     ssize_t ret_count =3D 0;
> > +     ssize_t total_ret_count =3D 0;
> > +     char val =3D 0;
> > +
> > +     printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total=
\n",
> > +            expected);
> > +     while (total_ret_count < len) {
> > +             ret_count =3D read(fd, buf, wr_chunk_size);
> > +             if (ret_count =3D=3D 0) {
> > +                     printf(PREFIX PREFIX "read reach end of the file\=
n");
> > +                     break;
> > +             } else if (ret_count < 0) {
> > +                     perror(PREFIX ERROR_PREFIX "read failed");
> > +                     break;
> > +             }
> > +             ++val;
> > +             if (!verify_chunk(buf, ret_count, val))
> > +                     return false;
> > +
> > +             total_ret_count +=3D ret_count;
> > +     }
> > +     printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\=
n",
> > +            total_ret_count);
> > +
> > +     return total_ret_count =3D=3D expected;
> > +}
> > +
> > +static enum test_status
> > +test_hugetlb_read(int fd, size_t len, size_t wr_chunk_size)
> > +{
> > +     enum test_status status =3D TEST_SKIPPED;
> > +     char *filemap =3D NULL;
> > +
> > +     if (ftruncate(fd, len) < 0) {
> > +             perror(PREFIX ERROR_PREFIX "ftruncate failed");
> > +             return status;
> > +     }
> > +
> > +     filemap =3D mmap(NULL, len, PROT_READ | PROT_WRITE,
> > +                    MAP_SHARED | MAP_POPULATE, fd, 0);
> > +     if (filemap =3D=3D MAP_FAILED) {
> > +             perror(PREFIX ERROR_PREFIX "mmap for primary mapping fail=
ed");
> > +             goto done;
> > +     }
> > +
> > +     setup_filemap(filemap, len, wr_chunk_size);
> > +     status =3D TEST_FAILED;
> > +
> > +     if (read_hugepage_filemap(fd, len, wr_chunk_size, len))
> > +             status =3D TEST_PASSED;
> > +
> > +     munmap(filemap, len);
> > +done:
> > +     if (ftruncate(fd, 0) < 0) {
> > +             perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
> > +             status =3D TEST_FAILED;
> > +     }
> > +
> > +     return status;
> > +}
> > +
> > +static enum test_status
> > +test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
> > +                        bool skip_hwpoison_page)
> > +{
> > +     enum test_status status =3D TEST_SKIPPED;
> > +     char *filemap =3D NULL;
> > +     char *hwp_addr =3D NULL;
> > +     const unsigned long pagesize =3D getpagesize();
> > +
> > +     if (ftruncate(fd, len) < 0) {
> > +             perror(PREFIX ERROR_PREFIX "ftruncate failed");
> > +             return status;
> > +     }
> > +
> > +     filemap =3D mmap(NULL, len, PROT_READ | PROT_WRITE,
> > +                    MAP_SHARED | MAP_POPULATE, fd, 0);
> > +     if (filemap =3D=3D MAP_FAILED) {
> > +             perror(PREFIX ERROR_PREFIX "mmap for primary mapping fail=
ed");
> > +             goto done;
> > +     }
> > +
> > +     setup_filemap(filemap, len, wr_chunk_size);
> > +     status =3D TEST_FAILED;
> > +
> > +     /*
> > +      * Poisoned hugetlb page layout (assume hugepagesize=3D2MB):
> > +      * |<---------------------- 1MB ---------------------->|
> > +      * |<---- healthy page ---->|<---- HWPOISON page ----->|
> > +      * |<------------------- (1MB - 8KB) ----------------->|
> > +      */
> > +     hwp_addr =3D filemap + len / 2 + pagesize;
> > +     if (madvise(hwp_addr, pagesize, MADV_HWPOISON) < 0) {
> > +             perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
> > +             goto unmap;
> > +     }
> > +
> > +     if (!skip_hwpoison_page) {
> > +             /*
> > +              * Userspace should be able to read (1MB + 1 page) from
> > +              * the beginning of the HWPOISONed hugepage.
> > +              */
> > +             if (read_hugepage_filemap(fd, len, wr_chunk_size,
> > +                                       len / 2 + pagesize))
> > +                     status =3D TEST_PASSED;
> > +     } else {
> > +             /*
> > +              * Userspace should be able to read (1MB - 2 pages) from
> > +              * HWPOISONed hugepage.
> > +              */
> > +             if (seek_read_hugepage_filemap(fd, len, wr_chunk_size,
> > +                                            len / 2 + MAX(2 * pagesize=
, wr_chunk_size),
> > +                                            len / 2 - MAX(2 * pagesize=
, wr_chunk_size)))
> > +                     status =3D TEST_PASSED;
> > +     }
> > +
> > +unmap:
> > +     munmap(filemap, len);
> > +done:
> > +     if (ftruncate(fd, 0) < 0) {
> > +             perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
> > +             status =3D TEST_FAILED;
> > +     }
> > +
> > +     return status;
> > +}
> > +
> > +static int create_hugetlbfs_file(struct statfs *file_stat)
> > +{
> > +     int fd;
> > +
> > +     fd =3D memfd_create("hugetlb_tmp", MFD_HUGETLB);
> > +     if (fd < 0) {
> > +             perror(PREFIX ERROR_PREFIX "could not open hugetlbfs file=
");
> > +             return -1;
> > +     }
> > +
> > +     memset(file_stat, 0, sizeof(*file_stat));
> > +     if (fstatfs(fd, file_stat)) {
> > +             perror(PREFIX ERROR_PREFIX "fstatfs failed");
> > +             goto close;
> > +     }
> > +     if (file_stat->f_type !=3D HUGETLBFS_MAGIC) {
> > +             printf(PREFIX ERROR_PREFIX "not hugetlbfs file\n");
> > +             goto close;
> > +     }
> > +
> > +     return fd;
> > +close:
> > +     close(fd);
> > +     return -1;
> > +}
> > +
> > +int main(void)
> > +{
> > +     int fd;
> > +     struct statfs file_stat;
> > +     enum test_status status;
> > +     /* Test read() in different granularity. */
> > +     size_t wr_chunk_sizes[] =3D {
> > +             getpagesize() / 2, getpagesize(),
> > +             getpagesize() * 2, getpagesize() * 4
> > +     };
> > +     size_t i;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(wr_chunk_sizes); ++i) {
> > +             printf("Write/read chunk size=3D0x%lx\n",
> > +                    wr_chunk_sizes[i]);
> > +
> > +             fd =3D create_hugetlbfs_file(&file_stat);
> > +             if (fd < 0)
> > +                     goto create_failure;
> > +             printf(PREFIX "HugeTLB read regression test...\n");
> > +             status =3D test_hugetlb_read(fd, file_stat.f_bsize,
> > +                                        wr_chunk_sizes[i]);
> > +             printf(PREFIX "HugeTLB read regression test...%s\n",
> > +                    status_to_str(status));
> > +             close(fd);
> > +             if (status =3D=3D TEST_FAILED)
> > +                     return -1;
> > +
> > +             fd =3D create_hugetlbfs_file(&file_stat);
> > +             if (fd < 0)
> > +                     goto create_failure;
> > +             printf(PREFIX "HugeTLB read HWPOISON test...\n");
> > +             status =3D test_hugetlb_read_hwpoison(fd, file_stat.f_bsi=
ze,
> > +                                                 wr_chunk_sizes[i], fa=
lse);
> > +             printf(PREFIX "HugeTLB read HWPOISON test...%s\n",
> > +                    status_to_str(status));
> > +             close(fd);
> > +             if (status =3D=3D TEST_FAILED)
> > +                     return -1;
> > +
> > +             fd =3D create_hugetlbfs_file(&file_stat);
> > +             if (fd < 0)
> > +                     goto create_failure;
> > +             printf(PREFIX "HugeTLB seek then read HWPOISON test...\n"=
);
> > +             status =3D test_hugetlb_read_hwpoison(fd, file_stat.f_bsi=
ze,
> > +                                                 wr_chunk_sizes[i], tr=
ue);
> > +             printf(PREFIX "HugeTLB seek then read HWPOISON test...%s\=
n",
> > +                    status_to_str(status));
> > +             close(fd);
> > +             if (status =3D=3D TEST_FAILED)
> > +                     return -1;
> > +     }
> > +
> > +     return 0;
> > +
> > +create_failure:
> > +     printf(ERROR_PREFIX "Abort test: failed to create hugetlbfs file\=
n");
> > +     return -1;
> > +}
>
> --
> BR,
> Muhammad Usama Anjum

