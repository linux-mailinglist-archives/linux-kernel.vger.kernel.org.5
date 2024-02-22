Return-Path: <linux-kernel+bounces-75871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D28385F016
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D020B28510D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4B31BDC2;
	Thu, 22 Feb 2024 03:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eKdfwIsH"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169B1B599
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573602; cv=none; b=EQ1hMcqPnIG1b97n+WoDXpVqIvCb8/F6mlmE3oCP0SJTX1UtL2gwgUacGYWZf5jwAX4y7TzpiYHKw8frbk4q8M0goND4D8/jVnHyXgKoHtuk8S/Dvw20QZ9EVhL02Ug8CMxgge1JdK4jRTV8mwGUjDUNop4FeyG08GT+Sj9ufZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573602; c=relaxed/simple;
	bh=cp0XJ1vg7N+tq7T/hQqrmLoRlQ0Tu1sLQF3XCorNNhs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Eme08yPV1iPSrdNEbpTM0Tl0T9JMs8NuPi+gaBG4B+aXAlbTafNrmqImpfAVoclaJyXrj+8+RoltAeuHdA0wk7eFp6xwSgClhq6dWZn6GB/5pNaW7C5T8wHp49ErRwDu4vda8Ev+Pkm+JDmuh427GKu+Bm98vWlItMUG/OaBVRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eKdfwIsH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-602dae507caso122707567b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708573598; x=1709178398; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wH33w5aG2BffksVtrB54fX5fBHp+P/Q2DjXoHgc9nyE=;
        b=eKdfwIsH5w8eFcUFGOrDNG/nCGjXPZf/pnkbbo2V+M9kBdTsxftXqvex1bZH3QyPej
         vf5qtS1JqXIFAxAKDryQ3FdMVe6Mp+0bq/8FakzEjuZ6Ayub6tPlOUjT267kX4ZXMWe1
         OVgbXZVa9Koexehbjaw2ii3FHjPNqATNH3DqUJwaQ7ORk+WovRD8rb/d+jknFyyxFFwA
         nWq3UA2LLLkKlzygJIKHDrR0Vj5AdeuXqgQvGe7tJ6P0tkyO0ECvctCa/9cKqJQpvFbM
         2dAbDJMzfQWssNIDHl5xALh9sYW4wMQ0iiw5i9lvYtzMDQGjc7nG8a5ZB2zfrmHCbW4P
         mo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708573598; x=1709178398;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wH33w5aG2BffksVtrB54fX5fBHp+P/Q2DjXoHgc9nyE=;
        b=H622Cml7eW0Wl3kdOmp9FoFgqjMX6U9hjc5jR7pqPvJpGxqO/HdvboOUsKXXZoesA3
         SKu//8hfRzwGSLQYYSfFXVe4kqgAeREzbjmXXHZLtLh14y3wP4lV5jwpXZSGXH/QIslK
         4FWOpGYP68xZhFHHOQ1diqdWK0GWVD6pji2jkMLY0dgObtJ1T5rWGgw83h2sFSNAP0YD
         uSrm0jo0UmU2DTDj3ZzbxQHJdclAH9TBasUdPXxQ8fdDFKFVc5S9JCrTCKZDaRXPN2es
         Kiau4ZWMFX0TS3+T1yLiSf23i6tViyXnpni3JuGiTKa38L7EGwpJcU/Pv6WCsJd+uK/U
         l6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWnSdDqzyeenTvvc2WCwNpJmDOxuwKWRDEabsH3s15n/G/hxOH8J2IH0c8LnP1FuFiwVq6cgbz4Ag2UIvaqxKWgPbSx1guVrBLqrC0r
X-Gm-Message-State: AOJu0Yz9PQeSZ2PFiGfkWVJtEeA5ZL75Q9Ps6hSCMjqY3OalowQL9jEU
	NVG0Y8HQJxmBKBJU5UPrNKp9KzkU1uFq9mLIz/uJUXar9E5ESrTBfO80pii8p7aDrF5kCRCnNne
	dO/firH12995lqw==
X-Google-Smtp-Source: AGHT+IECAd++kNqbj7P3O+ZaufolEwh1k0tAwEFsFNnN5Q1YIPOlFxgE+MiOrvGczCSWeJaEYcSnAoQ6Lx71cos=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:451c:c6c5:1fb1:a2a1])
 (user=saravanak job=sendgmr) by 2002:a25:ef09:0:b0:dc6:53c3:bcbd with SMTP id
 g9-20020a25ef09000000b00dc653c3bcbdmr325368ybd.7.1708573598675; Wed, 21 Feb
 2024 19:46:38 -0800 (PST)
Date: Wed, 21 Feb 2024 19:46:21 -0800
In-Reply-To: <20240222034624.2970024-1-saravanak@google.com>
Message-Id: <20240222034624.2970024-4-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222034624.2970024-1-saravanak@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v4 3/4] dt-bindings: Add post-init-providers property
From: Saravana Kannan <saravanak@google.com>
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The post-init-providers property can be used to break a dependency cycle by
marking some provider(s) as a post device initialization provider(s). This
allows an OS to do a better job at ordering initialization and
suspend/resume of the devices in a dependency cycle.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../bindings/post-init-providers.yaml         | 105 ++++++++++++++++++
 MAINTAINERS                                   |  13 ++-
 2 files changed, 112 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/post-init-providers.yaml

diff --git a/Documentation/devicetree/bindings/post-init-providers.yaml b/Documentation/devicetree/bindings/post-init-providers.yaml
new file mode 100644
index 000000000000..92eb9a027443
--- /dev/null
+++ b/Documentation/devicetree/bindings/post-init-providers.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2020, Google LLC. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/post-init-providers.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Post device initialization providers
+
+maintainers:
+  - Saravana Kannan <saravanak@google.com>
+
+description: |
+  This property is used to indicate that the device(s) pointed to by the
+  property are not needed for the initialization of the device that lists this
+  property. This property does not make a device (that's previously not a
+  provider) into a provider. It simply downgrades an existing provider to a
+  post device initialization provider.
+
+  A device can list its providers in devicetree using one or more of the
+  standard devicetree bindings. By default, it is assumed that the provider
+  device can be initialized before the consumer device is initialized.
+
+  However, that assumption cannot be made when there are cyclic dependencies
+  between devices. Since each device is a provider (directly or indirectly) of
+  the others in the cycle, there is no guaranteed safe order for initializing
+  the devices in a cycle. We can try to initialize them in an arbitrary order
+  and eventually successfully initialize all of them, but that doesn't always
+  work well.
+
+  For example, say,
+  * The device tree has the following cyclic dependency X -> Y -> Z -> X (where
+    -> denotes "depends on").
+  * But X is not needed to fully initialize Z (X might be needed only when a
+    specific functionality is requested post initialization).
+
+  If all the other -> are mandatory initialization dependencies, then trying to
+  initialize the devices in a loop (or arbitrarily) will always eventually end
+  up with the devices being initialized in the order Z, Y and X.
+
+  However, if Y is an optional provider for X (where X provides limited
+  functionality when Y is not initialized and providing its services), then
+  trying to initialize the devices in a loop (or arbitrarily) could end up with
+  the devices being initialized in the following order:
+
+  * Z, Y and X - All devices provide full functionality
+  * Z, X and Y - X provides partial functionality
+  * X, Z and Y - X provides partial functionality
+
+  However, we always want to initialize the devices in the order Z, Y and X
+  since that provides the full functionality without interruptions.
+
+  One alternate option that might be suggested is to have the driver for X
+  notice that Y became available at a later point and adjust the functionality
+  it provides. However, other userspace applications could have started using X
+  with the limited functionality before Y was available and it might not be
+  possible to transparently transition X or the users of X to full
+  functionality while X is in use.
+
+  Similarly, when it comes to suspend (resume) ordering, it's unclear which
+  device in a dependency cycle needs to be suspended/resumed first and trying
+  arbitrary orders can result in system crashes or instability.
+
+  Explicitly calling out which link in a cycle needs to be broken when
+  determining the order, simplifies things a lot, improves efficiency, makes
+  the behavior more deterministic and maximizes the functionality that can be
+  provided without interruption.
+
+  This property is used to provide this additional information between devices
+  in a cycle by telling which provider(s) is not needed for initializing the
+  device that lists this property.
+
+  In the example above, Z would list X as a post-init-providers and the
+  initialization dependency would become X -> Y -> Z -/-> X. So the best order
+  to initialize them becomes clear: Z, Y and then X.
+
+select: true
+
+properties:
+  post-init-providers:
+    # One or more providers can be marked as post initialization provider
+    description:
+      List of phandles to providers that are not needed for initializing or
+      resuming this device.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      maxItems: 1
+
+additionalProperties: true
+
+examples:
+  - |
+    gcc: clock-controller@1000 {
+        compatible = "vendor,soc4-gcc", "vendor,soc1-gcc";
+        reg = <0x1000 0x80>;
+        clocks = <&dispcc 0x1>;
+        #clock-cells = <1>;
+        post-init-providers = <&dispcc>;
+    };
+    dispcc: clock-controller@2000 {
+        compatible = "vendor,soc4-dispcc", "vendor,soc1-dispcc";
+        reg = <0x2000 0x80>;
+        clocks = <&gcc 0xdd>;
+        #clock-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d3868539..feec740239c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6060,12 +6060,6 @@ S:	Maintained
 F:	drivers/base/devcoredump.c
 F:	include/linux/devcoredump.h
 
-DEVICE DEPENDENCY HELPER SCRIPT
-M:	Saravana Kannan <saravanak@google.com>
-L:	linux-kernel@vger.kernel.org
-S:	Maintained
-F:	scripts/dev-needs.sh
-
 DEVICE DIRECT ACCESS (DAX)
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
@@ -8300,6 +8294,13 @@ F:	include/linux/firewire.h
 F:	include/uapi/linux/firewire*.h
 F:	tools/firewire/
 
+FIRMWARE DEVICE LINK (fw_devlink)
+M:	Saravana Kannan <saravanak@google.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/post-init-providers.yaml
+F:	scripts/dev-needs.sh
+
 FIRMWARE FRAMEWORK FOR ARMV8-A
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.44.0.rc0.258.g7320e95886-goog


