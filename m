Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6917A98A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjIURun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjIURuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:50:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC275365E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:26:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c09673b006so9940605ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695317178; x=1695921978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vkClKg2P+YbVqtVVJwErqWoyeSx3DV41h1M/hrNk7lM=;
        b=BL1DELJz3W4yofgFT7Av3nGR7XGdpbTonfe2q9B6YXS1RXiUveLjtKpWIGyoTHfjyR
         6foetOFRCNNHwh2NCpc8ivLTy4aLH30UrgFhI4BLDrvrpdqCrEdLRk7Uvlpxd+9QLSd2
         bZ5rucGGDP2TivzoGnuJpcy41xI2ZA5KAzsnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317178; x=1695921978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkClKg2P+YbVqtVVJwErqWoyeSx3DV41h1M/hrNk7lM=;
        b=jO1odsw0N1tUeF8zYSHkIBDOe0tmXvnk5UmmMcYzX/lgHs9HyYuuuXldkNvaDOAG5O
         rFiUxItf/OULG0PVhtIKCJnh/MLZuiAzPZqUJmI2oCq24VWv1H+gu+Qz5Lwt9S2jaIov
         /BSYSd3dgkx0ZOBxUsnJzz3n8gJ9bQH3Uik1HG1x4wtT7wSxI4t1pqlKGdqA5CSnMUca
         Pwpn8uLhVz43ZLUAyXVgcXtZcR4bms7/UvqZbY3/6zSFHiG3/5JQ0lom6VRYN2SEaydO
         zUQnm0wDDQwebaLYNBh8H2w+kzb256BsDeOxAnQxxVK6K3eSlNg8sjykqnrBxQuGMESP
         pJ8w==
X-Gm-Message-State: AOJu0Yxiq4DFCYu2Xpq3KpVimlyPF1sMabzItOr3O1Cs04FQGJQQaqYp
        hwSedM0u1m6svYcDiZEJJmUVcA==
X-Google-Smtp-Source: AGHT+IET8FhUW1xGxis+lHyY2KB5DpSDSmh01LjhlSUnAt5uW0TG0y+WtjaM/bkvpU6hrd+tJXuY6g==
X-Received: by 2002:a17:902:9f8e:b0:1c5:b1a6:8111 with SMTP id g14-20020a1709029f8e00b001c5b1a68111mr5025803plq.31.1695317178310;
        Thu, 21 Sep 2023 10:26:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e6ed:6d49:f262:8041])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902eb0a00b001bbb25dd3a7sm1771889plb.187.2023.09.21.10.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 10:26:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        andriy.shevchenko@linux.intel.com, broonie@kernel.org,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, james.clark@arm.com, james@equiv.tech,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de
Subject: [RFC PATCH] of: device: Support 2nd sources of probeable but undiscoverable devices
Date:   Thu, 21 Sep 2023 10:24:27 -0700
Message-ID: <20230921102420.RFC.1.I9dddd99ccdca175e3ceb1b9fa1827df0928c5101@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for multiple "equivalent" sources for components (also known
as second sourcing components) is a standard practice that helps keep
cost down and also makes sure that if one component is unavailable due
to a shortage that we don't need to stop production for the whole
product.

Some components are very easy to second source. eMMC, for instance, is
fully discoverable and probable so you can stuff a wide variety of
similar eMMC chips on your board and things will work without a hitch.

Some components are more difficult to second source, specifically
because it's difficult for software to probe what component is present
on any given board. In cases like this software is provided
supplementary information to help it, like a GPIO strap or a SKU ID
programmed into an EEPROM. This helpful information can allow the
bootloader to select a different device tree. The various different
"SKUs" of different Chromebooks are examples of this.

Some components are somewhere in between. These in-between components
are the subject of this patch. Specifically, these components are
easily "probeable" but not easily "discoverable".

A good example of a probeable but undiscoverable device is an
i2c-connected touchscreen or trackpad. Two separate components may be
electrically compatible with each other and may have compatible power
sequencing requirements but may require different software. If
software is told about the different possible components (because it
can't discover them), it can safely probe them to figure out which
ones are present.

On systems using device tree, if we want to tell the OS about all of
the different components we need to list them all in the device
tree. This leads to a problem. The multiple sources for components
likely use the same resources (GPIOs, interrupts, regulators). If the
OS tries to probe all of these components at the same time then it
will detect a resource conflict and that's a fatal error.

The fact that Linux can't handle these probeable but undiscoverable
devices well has had a few consequences:
1. In some cases, we've abandoned the idea of second sourcing
   components for a given board, which increases cost / generates
   manufacturing headaches.
2. In some cases, we've been forced to add some sort of strapping /
   EEPROM to indicate which component is present. This adds difficulty
   to manufacturing / refurb processes.
3. In some cases, we've managed to make things work by the skin of our
   teeth through slightly hacky solutions. Specifically, if we remove
   the "pinctrl" entry from the various options then it won't
   conflict. Regulators inherently can have more than one consumer, so
   as long as there are no GPIOs involved in power sequencing and
   probing devices then things can work. This is how
   "sc8280xp-lenovo-thinkpad-x13s" works and also how
   "mt8173-elm-hana" works.

Let's attempt to do something better. Specifically, we'll allow
tagging nodes in the device tree as mutually exclusive from one
another. This says that only one of the components in this group is
present on any given board. To make it concrete, in my proposal this
looks like:

  / {
    tp_ex_group: trackpad-exclusion-group {
    };
  };

  &i2c_bus {
    tp1: trackpad@10 {
      ...
      mutual-exclusion-group = <&tp_ex_group>;
    };
    tp2: trackpad@20 {
      ...
      mutual-exclusion-group = <&tp_ex_group>;
    };
    tp3: trackpad@30 {
      ...
      mutual-exclusion-group = <&tp_ex_group>;
    };
  };

In Linux, we can make things work by simply only probing one of the
devices in the group at a time. We can make a mutex per group and
enforce locking that mutex around probe. If the first device that gets
the mutex fails to probe then it won't try again. If it succeeds then
it will acquire the shared resources and future devices (which we know
can't be present) will fail to get the shared resources. Future
patches could quiet down errors about failing to acquire shared
resources or failing to probe if a device is in a
mutual-exclusion-group.

A traditional response to a proposal to express this type of
information in the device tree is that it's a "hack" to work around
Linux's quirks and is not a proper hardware description.

One often proposed solution instead of this "hack" is that firmware
should be probing the hardware and it should ensure that the device
tree only expresses the hardware that's present. This has a few
serious downsides:
1. It slows down boot. Powering up a component to probe it could take
   hundreds of milliseconds and, in the bootloader, it can't be
   parallelized with anything else.
2. It adds complexity to firmware. By its nature, firmware is harder
   to update regularly and impossible to keep "lockstep" with the
   kernel. This leads to the general principle that if we can keep
   code out of firmware then we should.
3. Not all firmware can be updated. If a device originally shipped as
   a Windows laptop or an Android phone, the bootloader might not be
   open source and easy to update.

Another proposed solution instead of this "hack" is that Linux should
automagically handle this. The idea here is that during probe a device
should get its resources provisionally and not commit to them until
the probe is a success. While possible, this is difficult to implement
in a generic way across all possible resources.

Instead of thinking of this as a "hack", it doesn't seem too
unreasonable to think of this as a hardware description even if it's
an inexact one. We are describing that the hardware has one of N
different variants and we describe the non-discoverable properties of
those components.

For some prior discussions:
- We discussed a bit of this recently in a patch that Johan posted to
  make simple i2c-hid devices (those that don't need reset GPIOs) work
  again [1].
- Johan pointed to a previous discussion with Rob [2].
- Dmitry did some previous prototyping of trying to handle this
  automagically for GPIOs [3].

[1] https://lore.kernel.org/r/20230918125851.310-1-johan+linaro@kernel.org
[2] https://lore.kernel.org/r/Y3teH14YduOQQkNn@hovoldconsulting.com/
[3] https://crrev.com/c/461349

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I definitely understand that, if we decide to go this way, somewhere
in DT documentation we need to document it. However, I wasn't sure
where that should happen. I'd love advice!

 drivers/base/core.c       |  1 +
 drivers/base/dd.c         |  7 +++++
 drivers/of/device.c       | 54 +++++++++++++++++++++++++++++++++++++++
 include/linux/device.h    |  5 ++++
 include/linux/of_device.h |  6 +++++
 5 files changed, 73 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4d8b315c48a1..adeceea331df 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3109,6 +3109,7 @@ void device_initialize(struct device *dev)
 	dev->dma_coherent = dma_default_coherent;
 #endif
 	swiotlb_dev_init(dev);
+	of_device_init(dev);
 }
 EXPORT_SYMBOL_GPL(device_initialize);
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a528cec24264..476d411b5443 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -789,6 +789,9 @@ static int __driver_probe_device(struct device_driver *drv, struct device *dev)
 	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 
+	if (dev->probe_mutex)
+		mutex_lock(dev->probe_mutex);
+
 	pm_runtime_get_suppliers(dev);
 	if (dev->parent)
 		pm_runtime_get_sync(dev->parent);
@@ -804,6 +807,10 @@ static int __driver_probe_device(struct device_driver *drv, struct device *dev)
 		pm_runtime_put(dev->parent);
 
 	pm_runtime_put_suppliers(dev);
+
+	if (dev->probe_mutex)
+		mutex_unlock(dev->probe_mutex);
+
 	return ret;
 }
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 1ca42ad9dd15..c58c716507e8 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -304,3 +304,57 @@ int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
+
+struct of_mutex_list_node {
+	struct list_head list;
+	struct device_node *np;
+	struct mutex mutex;
+};
+
+static DEFINE_MUTEX(of_mutex_list_lock);
+static LIST_HEAD(of_mutex_list);
+
+/**
+ * of_device_init() - Init a OF-related elements in a new struct device
+ * @dev: the new struct device
+ *
+ * The only initialization we need done at the moment is to init the
+ * "probe_mutex" if this device is part of a mutual-exclusion-group.
+ */
+void of_device_init(struct device *dev)
+{
+	struct of_mutex_list_node *node;
+	struct device_node *mutex_np;
+
+	mutex_np = of_parse_phandle(dev->of_node, "mutual-exclusion-group", 0);
+	if (!mutex_np)
+		return;
+
+	mutex_lock(&of_mutex_list_lock);
+
+	/*
+	 * Check to see if we've already created a mutex for this group. If
+	 * so then we're done.
+	 */
+	list_for_each_entry(node, &of_mutex_list, list) {
+		if (node->np == mutex_np) {
+			of_node_put(mutex_np);
+			dev->probe_mutex = &node->mutex;
+			goto exit;
+		}
+	}
+
+	/*
+	 * We need to create a new mutex. We'll never free the memory for this
+	 * (nor release the referenced to the mutual-exclusion-group node) but
+	 * there is only one object per group.
+	 */
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	mutex_init(&node->mutex);
+	node->np = mutex_np;
+	list_add_tail(&node->list, &of_mutex_list);
+	dev->probe_mutex = &node->mutex;
+
+exit:
+	mutex_unlock(&of_mutex_list_lock);
+}
diff --git a/include/linux/device.h b/include/linux/device.h
index 56d93a1ffb7b..f3cecf535bca 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -672,6 +672,9 @@ struct device_physical_location {
  * @iommu:	Per device generic IOMMU runtime data
  * @physical_location: Describes physical location of the device connection
  *		point in the system housing.
+ * @probe_mutex: If non-NULL, this mutex will be held during device probe
+ *		to allow mutual exclusion between multiple sources of probable
+ *		but non-discoverable devices with conflicting resources.
  * @removable:  Whether the device can be removed from the system. This
  *              should be set by the subsystem / bus driver that discovered
  *              the device.
@@ -790,6 +793,8 @@ struct device {
 
 	struct device_physical_location *physical_location;
 
+	struct mutex		*probe_mutex;
+
 	enum device_removable	removable;
 
 	bool			offline_disabled:1;
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 2c7a3d4bc775..8ebaf4d58ecd 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -30,6 +30,7 @@ extern ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len);
 
 extern void of_device_uevent(const struct device *dev, struct kobj_uevent_env *env);
 extern int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *env);
+extern void of_device_init(struct device *dev);
 
 int of_dma_configure_id(struct device *dev,
 		     struct device_node *np,
@@ -82,6 +83,11 @@ static inline int of_dma_configure(struct device *dev,
 {
 	return 0;
 }
+
+static inline void of_device_init(struct device *dev)
+{
+}
+
 #endif /* CONFIG_OF */
 
 #endif /* _LINUX_OF_DEVICE_H */
-- 
2.42.0.515.g380fc7ccd1-goog

