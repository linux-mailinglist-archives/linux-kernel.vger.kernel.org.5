Return-Path: <linux-kernel+bounces-8861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA3081BD5C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63EA1F26B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE86634E1;
	Thu, 21 Dec 2023 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkFDqyLJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C366280D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdb759e73bso899012276.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703180127; x=1703784927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4pitSoqAdLpsUVi8gXLLq+kTpdjoSUIMJK45w/cUjS8=;
        b=FkFDqyLJSxWg+8Xq69s+SiuLWlViC5JSNWbUxH2Bp7jGq++ZHG8W97a9GXZAIqAKpC
         IrTBMuqtqOo+i16ACUGi6VRA5g8ib8jzMpW0H0Ou1hZkJ8jbWaMz2lYoxRhCFIfIIUoE
         oL0GhvsHCNAGtM+cR3CgdEgAKJlZWpZgG3MVFmpAzYcVpFGMKfI+ySWT25VFCQi2uVGL
         nL5rbnX42LIHQ2WUtoCaCLONRrOBJaUCA4U3/LjTs0QgK2G9878c6HGXGXyY7W7nweSy
         WQaD0pO8H3pLFHENlWz3HUTAyLQQkFlWDSa3453h49ToTPbXTI6Nh+yUZ+zp9n9ObQF3
         kJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703180127; x=1703784927;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pitSoqAdLpsUVi8gXLLq+kTpdjoSUIMJK45w/cUjS8=;
        b=h+x9/qPQ+yfLieWZ3vZ4ZVtvhJsahBL68CC50WllGsZxXYhhzamxwadmuzmaWcbdZ9
         M1lmu1MZ7vAfVb9jmJMKseyd0mUrOlsO8WNTEM8awxKIzSsdYiwdoxI2QqgPoOVuFNkT
         Eo7J9BlMsCHTv0YtdvoXY57rteyW31S5kfAcKg2DD4ZLBAjNMc94nBvNISElCcGpo1uD
         UGE4/5uYhG7nN1rP05I27qKd1m78z4DJ6VebsZyYgpEWwTzPsxuAvZIpJkOynZcoWBw1
         Wpewkdu10B/9c9zpOnIxCbow6tUKkTKNJzSs18WZJ77gWT0PdqBq1DDWdgZx/8ybhDHl
         exHQ==
X-Gm-Message-State: AOJu0Yzy7TNWXAVwkI5bdHhYi35EWW3w2YM0svtCGuPMDAGZoeXZZ1zH
	kg7XCmWglPdC8bhpQZE9DTK/e4jzkMFdRwgBtgzvEko=
X-Google-Smtp-Source: AGHT+IGt4NLc/Ra0z5JpYCdEb5MX/rJ0Dx84iNch20I6bxyTP/buen2K0/KgHre4FFAA2Fp3nmgtZxN+UZaMBWc5
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a25:bcca:0:b0:dbd:aa53:6850 with SMTP
 id l10-20020a25bcca000000b00dbdaa536850mr470ybm.9.1703180127623; Thu, 21 Dec
 2023 09:35:27 -0800 (PST)
Date: Thu, 21 Dec 2023 17:35:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231221173523.3015715-1-vdonnefort@google.com>
Subject: [PATCH v9 0/2] Introducing trace buffer mapping by user-space
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

v8 -> v9:
  * Fix the unlock path in ring_buffer_map()
  * Fix cpu_buffer cast with rb_work_rq->is_cpu_buffer
  * Rebase on linux-trace/for-next (3cb3091138ca0921c4569bcf7ffa062519639b6a)

v7 -> v8:
  * Drop the subbufs renaming into bpages
  * Use subbuf as a name when relevant

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

	unsigned long	subbufs_touched;
	unsigned long	subbufs_lost;
	unsigned long	subbufs_read;

	struct {
		unsigned long	lost_events;	/* Events lost at the time of the reader swap */
		__u32		id;		/* Reader subbuf ID from 0 to nr_subbufs - 1 */
		__u32		read;		/* Number of bytes read on the reader subbuf */
	} reader;

	__u32		subbuf_size;
	__u32		nr_subbufs;		/* Number of subbufs in the ring-buffer */

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

static void read_subbuf(struct tep_handle *tep, struct kbuffer *kbuf)
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
				"%s-%d %9d\t%s: %s\n", TEP_PRINT_COMM,
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

	if (prev_reader != new_reader)
		*read = 0;
	else
		*read = prev_read;

	return new_reader;
}

static void signal_handler(int unused)
{
	printf("Exit!\n");
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
	printf("subbufs_touched:%lu\n", map->subbufs_touched);
	printf("subbufs_lost:	%lu\n", map->subbufs_lost);
	printf("subbufs_read:	%lu\n", map->subbufs_read);
	printf("nr_subbufs:	%u\n", map->nr_subbufs);

	data_len = map->subbuf_size * map->nr_subbufs;
	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED, fd, meta_len);
	if (data == MAP_FAILED)
		pdie("mmap data");

	signal(SIGINT, signal_handler);

	while (!exit_requested) {
		subbuf = next_reader_subbuf(fd, map, &read);
		kbuffer_load_subbuffer(kbuf, data + map->subbuf_size * subbuf);
		while (kbuf->curr < read)
			kbuffer_next_event(kbuf, NULL);

		read_subbuf(tep, kbuf);
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
 kernel/trace/ring_buffer.c      | 382 +++++++++++++++++++++++++++++++-
 kernel/trace/trace.c            |  79 ++++++-
 4 files changed, 495 insertions(+), 4 deletions(-)
 create mode 100644 include/uapi/linux/trace_mmap.h


base-commit: 3cb3091138ca0921c4569bcf7ffa062519639b6a
-- 
2.43.0.472.g3155946c3a-goog


