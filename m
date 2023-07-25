Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F33761241
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjGYLAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjGYLAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:00:17 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486404223
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:57:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-668711086f4so3481735b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690282651; x=1690887451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qvjHAYgSg2MMxQBr50LK2tzwYkNIQtvGXiVi72AP3w0=;
        b=HLDMMdXIrJ1dI47+4Zg3/qapw999XXjWIEaiDM5eyJuFhFlVcMDP6wYNjtKB9oQffF
         xVKSmRYoguqb4lhJD36rbSnCUK+UMvrhd+1JSAypmNurOblFUYAd1xoEyloAIudc2XEK
         rcNctVRYkdxD3W2EsTEA3YZ+ZUd+OyvSWlH4l18M8Ff6aoqnHLi6vzUVXo/1sW6xW+Zo
         g0N2biwqq9i8eJNNeJ4jj8AwKKIpXvye+x0YJKR5WhhWYQC1cCjvvhSSm+HSZNWhBn9o
         ECFSJ83ecRzhVrw0F9lTQgLJZwINZsfIbyWNXgL6J3w1C6qHisAWVmveJLH3zaIrCMKa
         pi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690282651; x=1690887451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvjHAYgSg2MMxQBr50LK2tzwYkNIQtvGXiVi72AP3w0=;
        b=XkVH+vIeV2sRRYytexCPLwQGud42/SPz1TY2pMGS0jGmwQGoaYZRHvkorwbHtFGNeW
         /Is47GSrB1Hyg08mtKFhI4mZeF4k8JBHdDMSvGVqfEIHKOCVz2b55E43WHRvlQp6amyE
         HmLAQuvUjYlyMle5iQMQA1CoeRbA4kHAW30U2pRAPsO3Dckz0NUBzuvBlp1PNtppWcLj
         86x+LnEwRVzqVoc9wH1c9FRMNkBrcZdf4pkunebADaHb9bQk4zaSzsUeq2T2YNrG9wkx
         fykUDrdyhWcFXNyBRR2cXOHgJh009uEFTF2YdeBkY3CWfa2WCZbNlNG8MsSDAAyCSY/o
         jJeQ==
X-Gm-Message-State: ABy/qLa+oNuZCnfwgiI8LjhtddVvis9EU6u+cPKrJRZ/My/OTeKfgK9H
        2opWVbl2W61ziNdrGWzw6ttIiA==
X-Google-Smtp-Source: APBJJlEDzn3s8/mi4yBlx3QnoIGh2Rt7Yx/UiabIGORbUqro3poYcn3j9w3qyV/VT+ToMRIMuoP5SQ==
X-Received: by 2002:a05:6a00:1ca0:b0:67a:20d0:b9bb with SMTP id y32-20020a056a001ca000b0067a20d0b9bbmr2453198pfw.1.1690282651561;
        Tue, 25 Jul 2023 03:57:31 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id t10-20020a63954a000000b005634bd81331sm10135267pgn.72.2023.07.25.03.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:57:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4] xen: privcmd: Add support for irqfd
Date:   Tue, 25 Jul 2023 16:27:26 +0530
Message-Id: <d783b8689395e60d0c314f9dad476443ca7773cf.1690282439.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xen provides support for injecting interrupts to the guests via the
HYPERVISOR_dm_op() hypercall. The same is used by the Virtio based
device backend implementations, in an inefficient manner currently.

Generally, the Virtio backends are implemented to work with the Eventfd
based mechanism. In order to make such backends work with Xen, another
software layer needs to poll the Eventfds and raise an interrupt to the
guest using the Xen based mechanism. This results in an extra context
switch.

This is not a new problem in Linux though. It is present with other
hypervisors like KVM, etc. as well. The generic solution implemented in
the kernel for them is to provide an IOCTL call to pass the interrupt
details and eventfd, which lets the kernel take care of polling the
eventfd and raising of the interrupt, instead of handling this in user
space (which involves an extra context switch).

This patch adds support to inject a specific interrupt to guest using
the eventfd mechanism, by preventing the extra context switch.

Inspired by existing implementations for KVM, etc..

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3->V4
- Drop the imported definitions to hvm/dm_op.h.
- Make the caller pass a pointer to pre-filled "struct xen_dm_op" instance and
  get rid of irq and level fields.
- Enable the irqfd feature under a new Kconfig entry.

V2->V3
- Select EVENTFD from Kconfig

V1->V2:
- Improve error handling.
- Remove the unnecessary usage of list_for_each_entry_safe().
- Restrict the use of XEN_DMOP_set_irq_level to only ARM64.
- Import definitions from Xen to hvm/dm_op.h.

 drivers/xen/Kconfig        |   8 ++
 drivers/xen/privcmd.c      | 286 ++++++++++++++++++++++++++++++++++++-
 include/uapi/xen/privcmd.h |  14 ++
 3 files changed, 306 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index d5d7c402b651..c7fabfab4c20 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -269,6 +269,14 @@ config XEN_PRIVCMD
 	  disaggregated Xen setups this driver might be needed for other
 	  domains, too.
 
+config XEN_PRIVCMD_IRQFD
+	bool "Xen irqfd support"
+	depends on XEN_PRIVCMD && XEN_VIRTIO && EVENTFD
+	default m
+	help
+	  irqfd is a mechanism to inject a specific interrupt to a User VM using
+	  a decoupled eventfd mechanism.
+
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
 	depends on XEN && XEN_PV_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index e2f580e30a86..584c8de56c5e 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -9,11 +9,16 @@
 
 #define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
 
+#include <linux/eventfd.h>
+#include <linux/file.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
@@ -833,6 +838,267 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
 	return rc;
 }
 
+#ifdef CONFIG_XEN_PRIVCMD_IRQFD
+/* Irqfd support */
+static struct workqueue_struct *irqfd_cleanup_wq;
+static DEFINE_MUTEX(irqfds_lock);
+static LIST_HEAD(irqfds_list);
+
+struct privcmd_kernel_irqfd {
+	struct xen_dm_op_buf xbufs;
+	domid_t dom;
+	bool error;
+	struct eventfd_ctx *eventfd;
+	struct work_struct shutdown;
+	wait_queue_entry_t wait;
+	struct list_head list;
+	poll_table pt;
+};
+
+static void irqfd_deactivate(struct privcmd_kernel_irqfd *kirqfd)
+{
+	lockdep_assert_held(&irqfds_lock);
+
+	list_del_init(&kirqfd->list);
+	queue_work(irqfd_cleanup_wq, &kirqfd->shutdown);
+}
+
+static void irqfd_shutdown(struct work_struct *work)
+{
+	struct privcmd_kernel_irqfd *kirqfd =
+		container_of(work, struct privcmd_kernel_irqfd, shutdown);
+	u64 cnt;
+
+	eventfd_ctx_remove_wait_queue(kirqfd->eventfd, &kirqfd->wait, &cnt);
+	eventfd_ctx_put(kirqfd->eventfd);
+	kfree(kirqfd);
+}
+
+static void irqfd_inject(struct privcmd_kernel_irqfd *kirqfd)
+{
+	u64 cnt;
+	long rc;
+
+	eventfd_ctx_do_read(kirqfd->eventfd, &cnt);
+
+	xen_preemptible_hcall_begin();
+	rc = HYPERVISOR_dm_op(kirqfd->dom, 1, &kirqfd->xbufs);
+	xen_preemptible_hcall_end();
+
+	/* Don't repeat the error message for consecutive failures */
+	if (rc && !kirqfd->error) {
+		pr_err("Failed to configure irq for guest domain: %d\n",
+		       kirqfd->dom);
+	}
+
+	kirqfd->error = !!rc;
+}
+
+static int
+irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
+{
+	struct privcmd_kernel_irqfd *kirqfd =
+		container_of(wait, struct privcmd_kernel_irqfd, wait);
+	__poll_t flags = key_to_poll(key);
+
+	if (flags & EPOLLIN)
+		irqfd_inject(kirqfd);
+
+	if (flags & EPOLLHUP) {
+		mutex_lock(&irqfds_lock);
+		irqfd_deactivate(kirqfd);
+		mutex_unlock(&irqfds_lock);
+	}
+
+	return 0;
+}
+
+static void
+irqfd_poll_func(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
+{
+	struct privcmd_kernel_irqfd *kirqfd =
+		container_of(pt, struct privcmd_kernel_irqfd, pt);
+
+	add_wait_queue_priority(wqh, &kirqfd->wait);
+}
+
+static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
+{
+	struct privcmd_kernel_irqfd *kirqfd, *tmp;
+	struct eventfd_ctx *eventfd;
+	__poll_t events;
+	struct fd f;
+	void *dm_op;
+	int ret;
+
+	kirqfd = kzalloc(sizeof(*kirqfd) + irqfd->size, GFP_KERNEL);
+	if (!kirqfd)
+		return -ENOMEM;
+	dm_op = kirqfd + 1;
+
+	if (copy_from_user(dm_op, irqfd->dm_op, irqfd->size)) {
+		ret = -EFAULT;
+		goto error_kfree;
+	}
+
+	kirqfd->xbufs.size = irqfd->size;
+	set_xen_guest_handle(kirqfd->xbufs.h, dm_op);
+	kirqfd->dom = irqfd->dom;
+	INIT_LIST_HEAD(&kirqfd->list);
+	INIT_WORK(&kirqfd->shutdown, irqfd_shutdown);
+
+	f = fdget(irqfd->fd);
+	if (!f.file) {
+		ret = -EBADF;
+		goto error_kfree;
+	}
+
+	eventfd = eventfd_ctx_fileget(f.file);
+	if (IS_ERR(eventfd)) {
+		ret = PTR_ERR(eventfd);
+		goto error_fd_put;
+	}
+
+	kirqfd->eventfd = eventfd;
+
+	/*
+	 * Install our own custom wake-up handling so we are notified via a
+	 * callback whenever someone signals the underlying eventfd.
+	 */
+	init_waitqueue_func_entry(&kirqfd->wait, irqfd_wakeup);
+	init_poll_funcptr(&kirqfd->pt, irqfd_poll_func);
+
+	mutex_lock(&irqfds_lock);
+
+	list_for_each_entry(tmp, &irqfds_list, list) {
+		if (kirqfd->eventfd == tmp->eventfd) {
+			ret = -EBUSY;
+			mutex_unlock(&irqfds_lock);
+			goto error_eventfd;
+		}
+	}
+
+	list_add_tail(&kirqfd->list, &irqfds_list);
+	mutex_unlock(&irqfds_lock);
+
+	/*
+	 * Check if there was an event already pending on the eventfd before we
+	 * registered, and trigger it as if we didn't miss it.
+	 */
+	events = vfs_poll(f.file, &kirqfd->pt);
+	if (events & EPOLLIN)
+		irqfd_inject(kirqfd);
+
+	/*
+	 * Do not drop the file until the kirqfd is fully initialized, otherwise
+	 * we might race against the EPOLLHUP.
+	 */
+	fdput(f);
+	return 0;
+
+error_eventfd:
+	eventfd_ctx_put(eventfd);
+
+error_fd_put:
+	fdput(f);
+
+error_kfree:
+	kfree(kirqfd);
+	return ret;
+}
+
+static int privcmd_irqfd_deassign(struct privcmd_irqfd *irqfd)
+{
+	struct privcmd_kernel_irqfd *kirqfd;
+	struct eventfd_ctx *eventfd;
+
+	eventfd = eventfd_ctx_fdget(irqfd->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	mutex_lock(&irqfds_lock);
+
+	list_for_each_entry(kirqfd, &irqfds_list, list) {
+		if (kirqfd->eventfd == eventfd) {
+			irqfd_deactivate(kirqfd);
+			break;
+		}
+	}
+
+	mutex_unlock(&irqfds_lock);
+
+	eventfd_ctx_put(eventfd);
+
+	/*
+	 * Block until we know all outstanding shutdown jobs have completed so
+	 * that we guarantee there will not be any more interrupts once this
+	 * deassign function returns.
+	 */
+	flush_workqueue(irqfd_cleanup_wq);
+
+	return 0;
+}
+
+static long privcmd_ioctl_irqfd(struct file *file, void __user *udata)
+{
+	struct privcmd_data *data = file->private_data;
+	struct privcmd_irqfd irqfd;
+
+	if (copy_from_user(&irqfd, udata, sizeof(irqfd)))
+		return -EFAULT;
+
+	/* No other flags should be set */
+	if (irqfd.flags & ~PRIVCMD_IRQFD_FLAG_DEASSIGN)
+		return -EINVAL;
+
+	/* If restriction is in place, check the domid matches */
+	if (data->domid != DOMID_INVALID && data->domid != irqfd.dom)
+		return -EPERM;
+
+	if (irqfd.flags & PRIVCMD_IRQFD_FLAG_DEASSIGN)
+		return privcmd_irqfd_deassign(&irqfd);
+
+	return privcmd_irqfd_assign(&irqfd);
+}
+
+static int privcmd_irqfd_init(void)
+{
+	irqfd_cleanup_wq = alloc_workqueue("privcmd-irqfd-cleanup", 0, 0);
+	if (!irqfd_cleanup_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void privcmd_irqfd_exit(void)
+{
+	struct privcmd_kernel_irqfd *kirqfd, *tmp;
+
+	mutex_lock(&irqfds_lock);
+
+	list_for_each_entry_safe(kirqfd, tmp, &irqfds_list, list)
+		irqfd_deactivate(kirqfd);
+
+	mutex_unlock(&irqfds_lock);
+
+	destroy_workqueue(irqfd_cleanup_wq);
+}
+#else
+static inline long privcmd_ioctl_irqfd(struct file *file, void __user *udata)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int privcmd_irqfd_init(void)
+{
+	return 0;
+}
+
+static inline void privcmd_irqfd_exit(void)
+{
+}
+#endif /* CONFIG_XEN_PRIVCMD_IRQFD */
+
 static long privcmd_ioctl(struct file *file,
 			  unsigned int cmd, unsigned long data)
 {
@@ -868,6 +1134,10 @@ static long privcmd_ioctl(struct file *file,
 		ret = privcmd_ioctl_mmap_resource(file, udata);
 		break;
 
+	case IOCTL_PRIVCMD_IRQFD:
+		ret = privcmd_ioctl_irqfd(file, udata);
+		break;
+
 	default:
 		break;
 	}
@@ -992,15 +1262,27 @@ static int __init privcmd_init(void)
 	err = misc_register(&xen_privcmdbuf_dev);
 	if (err != 0) {
 		pr_err("Could not register Xen hypercall-buf device\n");
-		misc_deregister(&privcmd_dev);
-		return err;
+		goto err_privcmdbuf;
+	}
+
+	err = privcmd_irqfd_init();
+	if (err != 0) {
+		pr_err("irqfd init failed\n");
+		goto err_irqfd;
 	}
 
 	return 0;
+
+err_irqfd:
+	misc_deregister(&xen_privcmdbuf_dev);
+err_privcmdbuf:
+	misc_deregister(&privcmd_dev);
+	return err;
 }
 
 static void __exit privcmd_exit(void)
 {
+	privcmd_irqfd_exit();
 	misc_deregister(&privcmd_dev);
 	misc_deregister(&xen_privcmdbuf_dev);
 }
diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
index d2029556083e..375718ba4ab6 100644
--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -98,6 +98,18 @@ struct privcmd_mmap_resource {
 	__u64 addr;
 };
 
+/* For privcmd_irqfd::flags */
+#define PRIVCMD_IRQFD_FLAG_DEASSIGN (1 << 0)
+
+struct privcmd_irqfd {
+	void __user *dm_op;
+	__u32 size; /* Size of structure pointed by dm_op */
+	__u32 fd;
+	__u32 flags;
+	domid_t dom;
+	__u8 pad[2];
+};
+
 /*
  * @cmd: IOCTL_PRIVCMD_HYPERCALL
  * @arg: &privcmd_hypercall_t
@@ -125,5 +137,7 @@ struct privcmd_mmap_resource {
 	_IOC(_IOC_NONE, 'P', 6, sizeof(domid_t))
 #define IOCTL_PRIVCMD_MMAP_RESOURCE				\
 	_IOC(_IOC_NONE, 'P', 7, sizeof(struct privcmd_mmap_resource))
+#define IOCTL_PRIVCMD_IRQFD					\
+	_IOC(_IOC_NONE, 'P', 8, sizeof(struct privcmd_irqfd))
 
 #endif /* __LINUX_PUBLIC_PRIVCMD_H__ */
-- 
2.31.1.272.g89b43f80a514

