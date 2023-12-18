Return-Path: <linux-kernel+bounces-3906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEB08174FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27092B22838
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73549498AB;
	Mon, 18 Dec 2023 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYBKkM7V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1949887
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e5bf8a6f06so17199207b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702912497; x=1703517297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sqMBRGVB7ITZ5QpcdhANLQ3bhO+vF23Jtr346AzQjvo=;
        b=fYBKkM7V7RQhiQshbXF6g3zwzEmhTtANmpu5U1GPJybVW6zxEG2ywVj/FiPE8lXwAx
         rk3/HlJMFgSCTGovC1oyDh7ZAQ1vDpSAWMHbMW0SxJ7YGHyTYwP0Utliw76+29tx2uxr
         NVmakJUF3FpYbHon5oAn/W6gItc5SNl4ZqpQd3SzdWSObexuSVUcK3DXGb09eY5A16He
         1SzbR2ZF2MinCarZUv1Nrw7kAgAjgaTE8uftfGs3I/XcaxbwhhTzwspLOLSeFHJHb4uq
         7s3u+k3KUxwVPyztYOc0vFASpPruWc6ijhUVN/60sqSGfifWgFjfacnSimXIhICMiXEq
         mrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702912497; x=1703517297;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqMBRGVB7ITZ5QpcdhANLQ3bhO+vF23Jtr346AzQjvo=;
        b=BEIGarCN5tgySCNBte03M9m0MLI6YEvAgI/A5Eh/mOmT8+zOJ3hHmxlZx0Gnpi0Z/4
         Kbj6RFnhKAGk4F5MeroDdVRwN3zHkxYurK96dKL9AtwS/j5EOmgcd0wGLU50QEb5tHB6
         6xYpYr/C5j2WKZeeunC34DUS5E9EWmRIzbz4sv9saMPtSn6qPxVIjJrAQl0rrdb+52CB
         NV63IrpwJqrg5P1mlEbrjtaQziajyXwKPNTnz7pL5cQzCdKU1hXYTWR4Eu/fD3E2M0ZM
         mUA1W37yxk47CRxI4IW7xN8IahxYT8YEjzJlPVQYmBwY76rf2ieDKIwLsKwqzJOmLKGF
         HSjg==
X-Gm-Message-State: AOJu0YxcWI+4ba8lLLzuPWA+d22wu1L+xdcOMLQvAmXU+P6bwerEhouY
	IkLajZzwOkT06/ETvQy7GnAAodMfGyVOcnKa
X-Google-Smtp-Source: AGHT+IHMDPC+ur4lPgfi/ul4VK8uC8FL7NJL+5I/1zorPu8Jk+YjF+9GfybbnvECQeRd6pz9rsU+++AVQi0EhjlE
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a0d:cb0b:0:b0:5e7:6547:863a with SMTP
 id n11-20020a0dcb0b000000b005e76547863amr37874ywd.2.1702912497742; Mon, 18
 Dec 2023 07:14:57 -0800 (PST)
Date: Mon, 18 Dec 2023 15:14:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231218151451.944907-1-vdonnefort@google.com>
Subject: [PATCH v7 0/2] Introducing trace buffer mapping by user-space
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The tracing ring-buffers can be stored on disk or sent to network
without any copy via splice. However the later doesn't allow real time
processing of the traces. A solution is to give userspace direct access
to the ring-buffer pages via a mapping. An application can now become a
consumer of the ring-buffer, in a similar fashion to what trace_pipe
offers.

Attached to this cover letter an example of consuming read for a
ring-buffer, using libtracefs.

Vincent

v6 -> v7:
  * Rebase onto lore.kernel.org/lkml/20231215175502.106587604@goodmis.org/
  * Support for subbufs
  * Rename subbufs into bpages

v5 -> v6:
  * Rebase on next-20230802.
  * (unsigned long) -> (void *) cast for virt_to_page().
  * Add a wait for the GET_READER_PAGE ioctl.
  * Move writer fields update (overrun/pages_lost/entries/pages_touched)
    in the irq_work.
  * Rearrange id in struct buffer_page.
  * Rearrange the meta-page.
  * ring_buffer_meta_page -> trace_buffer_meta_page.
  * Add meta_struct_len into the meta-page.

v4 -> v5:
  * Trivial rebase onto 6.5-rc3 (previously 6.4-rc3)

v3 -> v4:
  * Add to the meta-page:
       - pages_lost / pages_read (allow to compute how full is the
	 ring-buffer)
       - read (allow to compute how many entries can be read)
       - A reader_page struct.
  * Rename ring_buffer_meta_header -> ring_buffer_meta
  * Rename ring_buffer_get_reader_page -> ring_buffer_map_get_reader_page
  * Properly consume events on ring_buffer_map_get_reader_page() with
    rb_advance_reader().

v2 -> v3:
  * Remove data page list (for non-consuming read)
    ** Implies removing order > 0 meta-page
  * Add a new meta page field ->read
  * Rename ring_buffer_meta_page_header into ring_buffer_meta_header

v1 -> v2:
  * Hide data_pages from the userspace struct
  * Fix META_PAGE_MAX_PAGES
  * Support for order > 0 meta-page
  * Add missing page->mapping.

---

/* Need to access private struct to save counters */
struct kbuffer {
	unsigned long long      timestamp;
	long long               lost_events;
	unsigned long           flags;
	void                    *subbuffer;
	void                    *data;
	unsigned int            index;
	unsigned int            curr;
	unsigned int            next;
	unsigned int            size;
	unsigned int            start;
	unsigned int            first;

	unsigned int (*read_4)(void *ptr);
	unsigned long long (*read_8)(void *ptr);
	unsigned long long (*read_long)(struct kbuffer *kbuf, void *ptr);
	int (*next_event)(struct kbuffer *kbuf);
};

struct trace_buffer_meta {
	unsigned long	entries;
	unsigned long	overrun;
	unsigned long	read;

	unsigned long	bpages_touched;
	unsigned long	bpages_lost;
	unsigned long	bpages_read;

	struct {
		unsigned long	lost_events;	/* Events lost at the time of the reader swap */
		__u32		id;		/* Reader bpage ID from 0 to nr_bpages - 1 */
		__u32		read;		/* Number of bytes read on the reader bpage */
	} reader;

	__u32		bpage_size;		/* Size of each buffer page including the header */
	__u32		nr_bpages;		/* Number of buffer pages in the ring-buffer */

	__u32		meta_page_size;		/* Size of the meta-page */
	__u32		meta_struct_len;	/* Len of this struct */
};

static char *argv0;
static bool exit_requested;

static char *get_this_name(void)
{
	static char *this_name;
	char *arg;
	char *p;

	if (this_name)
		return this_name;

	arg = argv0;
	p = arg+strlen(arg);

	while (p >= arg && *p != '/')
		p--;
	p++;

	this_name = p;
	return p;
}

static void __vdie(const char *fmt, va_list ap, int err)
{
	int ret = errno;
	char *p = get_this_name();

	if (err && errno)
		perror(p);
	else
		ret = -1;

	fprintf(stderr, "  ");
	vfprintf(stderr, fmt, ap);

	fprintf(stderr, "\n");
	exit(ret);
}

void pdie(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	__vdie(fmt, ap, 1);
	va_end(ap);
}

static void read_page(struct tep_handle *tep, struct kbuffer *kbuf)
{
	static struct trace_seq seq;
	struct tep_record record;

	if (seq.buffer)
		trace_seq_reset(&seq);
	else
		trace_seq_init(&seq);

	while ((record.data = kbuffer_read_event(kbuf, &record.ts))) {
		record.size = kbuffer_event_size(kbuf);
		kbuffer_next_event(kbuf, NULL);
		tep_print_event(tep, &seq, &record,
				"%s-%d %9d\t%s: %s", TEP_PRINT_COMM,
				TEP_PRINT_PID, TEP_PRINT_TIME, TEP_PRINT_NAME,
				TEP_PRINT_INFO);
		trace_seq_do_printf(&seq);
		trace_seq_reset(&seq);
	}
}

static int next_reader_subbuf(int fd, struct trace_buffer_meta *meta, unsigned long *read)
{
	__u32 prev_read, prev_reader, new_reader;

	prev_read = READ_ONCE(meta->reader.read);
	prev_reader = READ_ONCE(meta->reader.id);
	if (ioctl(fd, TRACE_MMAP_IOCTL_GET_READER) < 0)
		pdie("ioctl");
	new_reader = READ_ONCE(meta->reader.id);

	if (prev_reader != new_reader) {
		*read = 0;
		printf("NEW READER PAGE: %d\n", new_reader);
	} else
		*read = prev_read;

	return new_reader;
}

static void signal_handler(int unused)
{
	exit_requested = true;
}

int main(int argc, char **argv)
{
	int page_size, meta_len, data_len, subbuf, fd;
	struct trace_buffer_meta *map;
	struct tep_handle *tep;
	struct kbuffer *kbuf;
	unsigned long read;
	void *meta, *data;
	char path[32];
	int cpu;

	if (argc != 2)
		return -EINVAL;

	argv0 = argv[0];
	cpu = atoi(argv[1]);
	snprintf(path, 32, "per_cpu/cpu%d/trace_pipe_raw", cpu);

	tep = tracefs_local_events(NULL);
	kbuf = tep_kbuffer(tep);
	page_size = getpagesize();

	fd = tracefs_instance_file_open(NULL, path, O_RDONLY);
	if (fd < 0)
		pdie("raw");

	meta = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
	if (meta == MAP_FAILED)
		pdie("mmap");
	map = (struct trace_buffer_meta *)meta;
	meta_len = map->meta_page_size;

	printf("entries:	%lu\n", map->entries);
	printf("overrun:	%lu\n", map->overrun);
	printf("read:		%lu\n", map->read);
	printf("bpages_touched: %lu\n", map->bpages_touched);
	printf("bpages_lost:	%lu\n", map->bpages_lost);
	printf("bpages_read:	%lu\n", map->bpages_read);
	printf("bpage_size:	%u\n", map->bpage_size);
	printf("nr_bpages:	%u\n", map->nr_bpages);

	data_len = map->bpage_size * map->nr_bpages;
	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, meta_len);
	if (data == MAP_FAILED)
		pdie("mmap data");

	signal(SIGINT, signal_handler);

	while (!exit_requested) {
		subbuf = next_reader_subbuf(fd, map, &read);
		kbuffer_load_subbuffer(kbuf, data + map->bpage_size * subbuf);
		while (kbuf->curr < read)
			kbuffer_next_event(kbuf, NULL);

		read_page(tep, kbuf);
	}

	munmap(data, data_len);
	munmap(meta, page_size);
	close(fd);

	return 0;
}

Vincent Donnefort (2):
  ring-buffer: Introducing ring-buffer mapping functions
  tracing: Allow user-space mapping of the ring-buffer

 include/linux/ring_buffer.h     |   7 +
 include/uapi/linux/trace_mmap.h |  31 +++
 kernel/trace/ring_buffer.c      | 373 +++++++++++++++++++++++++++++++-
 kernel/trace/trace.c            |  79 ++++++-
 4 files changed, 486 insertions(+), 4 deletions(-)
 create mode 100644 include/uapi/linux/trace_mmap.h

-- 
2.43.0.472.g3155946c3a-goog


