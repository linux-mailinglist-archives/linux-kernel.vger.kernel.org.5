Return-Path: <linux-kernel+bounces-25571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1228A82D2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0B61C2074A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF4C256A;
	Mon, 15 Jan 2024 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b21qzixP"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485DD63C5;
	Mon, 15 Jan 2024 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9344f30caso5456384b3a.1;
        Sun, 14 Jan 2024 16:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705279813; x=1705884613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MK7KhU/c/OCKeFhc+Alpj9+x/wfFEroXy7/XTlKq6R4=;
        b=b21qzixPnEPxuTgGlHOk/M7UikDc/qk0LdFosakmyXwWA5jNHnsNz51O2y2J/1aZ+x
         T39P2zG06RYFHZQFrF7EVPclcRKB5Ik4xrgqT5lNIQ7LuWHU6FCd2hXMgG+YQfTO8wIt
         CM/QZlptZpMIakZxRMD/lkhZiMXCiHEZyx3me6yfpcszdX3AY5dT3QPnHrShYfzqgMSO
         faKKX6vCQVOr59aLW/HFwjVyyGqPT+2YiTeIdk8Cdf+8dV80zdxn8xontWdfXisIwkWb
         Bdd7fGZReOKZLvQ4sjk/5OZ4rl8nyp+Wt7K1qaxo4zSPy/P8Prtfhh0hQqXvZ/6p4hCG
         oV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705279813; x=1705884613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MK7KhU/c/OCKeFhc+Alpj9+x/wfFEroXy7/XTlKq6R4=;
        b=wkMTuabH1weBj5bk27EfTMR+usI53GyFrkky30kmp0UDhH2xqmJDSjHyhKw/xdbUkX
         FiexFnMxa3WmECM4VkVSCs99flcbiV0s5P3pr26DEmbRQazTdn76w9aU1OqPXR7FXsaA
         VZk+JD8wKJlpIi7kVFJXiSIJqUcvlSGgXB6gYp0oLKTV4ug/Uwrn26hQVykKZ23aZX2R
         sOiBJsJrNQooEST/GgMSf7mFDgz6T9K7aRAS7pVnWB7zQR2Bd4vPN5h0cr/cmCiBaQ6d
         DBhGSvEHSFr9C7ynOXEtgIdQgHt8dx8+UUtxqteVMH2zy1EJIsKcyObNXDc28Tuo/sKc
         cmCQ==
X-Gm-Message-State: AOJu0YwpMEchxsraXfyQ85uQCsXJGjOH+Co4aze65KVDLWuHtL1pysNP
	QjiDGtKDTYtktxPKOVEiXpxC/wQGLosoRg==
X-Google-Smtp-Source: AGHT+IF1252Hb1TRGhUTV/ms0tdoru/Fxg9mZnjWddthfavflk45lZaqONNEJ1BNDyLNcrh3lAamQQ==
X-Received: by 2002:a05:6a00:2282:b0:6d2:74fc:1f1e with SMTP id f2-20020a056a00228200b006d274fc1f1emr5760378pfe.14.1705279812958;
        Sun, 14 Jan 2024 16:50:12 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b006d999f4a3c0sm6538365pfo.152.2024.01.14.16.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 16:50:12 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 6/9] Documentation: gpio: add chardev v1 userspace API documentation
Date: Mon, 15 Jan 2024 08:48:44 +0800
Message-Id: <20240115004847.22369-7-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115004847.22369-1-warthog618@gmail.com>
References: <20240115004847.22369-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for v1 of the GPIO character device userspace API
to the obsolete section of both the admin-guide and userspace-api
books.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/admin-guide/gpio/obsolete.rst   |   1 +
 .../userspace-api/gpio/chardev_v1.rst         | 131 ++++++++++++++++++
 .../gpio/gpio-get-lineevent-ioctl.rst         |  78 +++++++++++
 .../gpio/gpio-get-linehandle-ioctl.rst        |  86 ++++++++++++
 .../gpio/gpio-get-lineinfo-ioctl.rst          |  54 ++++++++
 .../gpio/gpio-get-lineinfo-unwatch-ioctl.rst  |   2 +-
 .../gpio/gpio-get-lineinfo-watch-ioctl.rst    |  74 ++++++++++
 .../gpio-handle-get-line-values-ioctl.rst     |  56 ++++++++
 .../gpio/gpio-handle-set-config-ioctl.rst     |  62 +++++++++
 .../gpio-handle-set-line-values-ioctl.rst     |  48 +++++++
 .../gpio/gpio-lineevent-data-read.rst         |  84 +++++++++++
 .../gpio/gpio-lineinfo-changed-read.rst       |  87 ++++++++++++
 Documentation/userspace-api/gpio/obsolete.rst |   1 +
 13 files changed, 763 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/gpio/chardev_v1.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineevent-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-linehandle-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineinfo-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineinfo-watch-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-handle-get-line-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-handle-set-config-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-handle-set-line-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-lineevent-data-read.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-lineinfo-changed-read.rst

diff --git a/Documentation/admin-guide/gpio/obsolete.rst b/Documentation/admin-guide/gpio/obsolete.rst
index dbf88f13c680..5926e5440207 100644
--- a/Documentation/admin-guide/gpio/obsolete.rst
+++ b/Documentation/admin-guide/gpio/obsolete.rst
@@ -7,5 +7,6 @@ Obsolete GPIO APIs
 .. toctree::
     :maxdepth: 1
 
+    Character Device Userspace API (v1) <../../userspace-api/gpio/chardev_v1>
     Sysfs Interface <../../userspace-api/gpio/sysfs>
 
diff --git a/Documentation/userspace-api/gpio/chardev_v1.rst b/Documentation/userspace-api/gpio/chardev_v1.rst
new file mode 100644
index 000000000000..67124b1d0487
--- /dev/null
+++ b/Documentation/userspace-api/gpio/chardev_v1.rst
@@ -0,0 +1,131 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+GPIO Character Device Userspace API (v1)
+========================================
+
+.. warning::
+   This API is obsoleted by chardev.rst (v2).
+
+   New developments should use the v2 API, and existing developments are
+   encouraged to migrate as soon as possible, as this API will be removed
+   in the future. The v2 API is a functional superset of the v1 API so any
+   v1 call can be directly translated to a v2 equivalent.
+
+   This interface will continue to be maintained for the migration period,
+   but new features will only be added to the new API.
+
+First added in 4.8.
+
+The API is based around three major objects, the :ref:`gpio-v1-chip`, the
+:ref:`gpio-v1-line-handle`, and the :ref:`gpio-v1-line-event`.
+
+Where "line event" is used in this document it refers to the request that can
+monitor a line for edge events, not the edge events themselves.
+
+.. _gpio-v1-chip:
+
+Chip
+====
+
+The Chip represents a single GPIO chip and is exposed to userspace using device
+files of the form ``/dev/gpiochipX``.
+
+Each chip supports a number of GPIO lines,
+:c:type:`chip.lines<gpiochip_info>`. Lines on the chip are identified by an
+``offset`` in the range from 0 to ``chip.lines - 1``, i.e. `[0,chip.lines)`.
+
+Lines are requested from the chip using either gpio-get-linehandle-ioctl.rst
+and the resulting line handle is used to access the GPIO chip's lines, or
+gpio-get-lineevent-ioctl.rst and the resulting line event is used to monitor
+a GPIO line for edge events.
+
+Within this documentation, the file descriptor returned by calling `open()`
+on the GPIO device file is referred to as ``chip_fd``.
+
+Operations
+----------
+
+The following operations may be performed on the chip:
+
+.. toctree::
+   :titlesonly:
+
+   Get Line Handle <gpio-get-linehandle-ioctl>
+   Get Line Event <gpio-get-lineevent-ioctl>
+   Get Chip Info <gpio-get-chipinfo-ioctl>
+   Get Line Info <gpio-get-lineinfo-ioctl>
+   Watch Line Info <gpio-get-lineinfo-watch-ioctl>
+   Unwatch Line Info <gpio-get-lineinfo-unwatch-ioctl>
+   Read Line Info Changed Events <gpio-lineinfo-changed-read>
+
+.. _gpio-v1-line-handle:
+
+Line Handle
+===========
+
+Line handles are created by gpio-get-linehandle-ioctl.rst and provide
+access to a set of requested lines.  The line handle is exposed to userspace
+via the anonymous file descriptor returned  in
+:c:type:`request.fd<gpiohandle_request>` by gpio-get-linehandle-ioctl.rst.
+
+Within this documentation, the line handle file descriptor is referred to
+as ``handle_fd``.
+
+Operations
+----------
+
+The following operations may be performed on the line handle:
+
+.. toctree::
+   :titlesonly:
+
+   Get Line Values <gpio-handle-get-line-values-ioctl>
+   Set Line Values <gpio-handle-set-line-values-ioctl>
+   Reconfigure Lines <gpio-handle-set-config-ioctl>
+
+.. _gpio-v1-line-event:
+
+Line Event
+==========
+
+Line events are created by gpio-get-lineevent-ioctl.rst and provide
+access to a requested line.  The line event is exposed to userspace
+via the anonymous file descriptor returned  in
+:c:type:`request.fd<gpioevent_request>` by gpio-get-lineevent-ioctl.rst.
+
+Within this documentation, the line event file descriptor is referred to
+as ``event_fd``.
+
+Operations
+----------
+
+The following operations may be performed on the line event:
+
+.. toctree::
+   :titlesonly:
+
+   Get Line Value <gpio-handle-get-line-values-ioctl>
+   Read Line Edge Events <gpio-lineevent-data-read>
+
+Types
+=====
+
+This section contains the structs that are referenced by the ABI v1.
+
+The :c:type:`struct gpiochip_info<gpiochip_info>` is common to ABI v1 and v2.
+
+.. kernel-doc:: include/uapi/linux/gpio.h
+   :identifiers:
+    gpioevent_data
+    gpioevent_request
+    gpiohandle_config
+    gpiohandle_data
+    gpiohandle_request
+    gpioline_info
+    gpioline_info_changed
+
+.. toctree::
+   :hidden:
+
+   error-codes
diff --git a/Documentation/userspace-api/gpio/gpio-get-lineevent-ioctl.rst b/Documentation/userspace-api/gpio/gpio-get-lineevent-ioctl.rst
new file mode 100644
index 000000000000..7d0b932925c6
--- /dev/null
+++ b/Documentation/userspace-api/gpio/gpio-get-lineevent-ioctl.rst
@@ -0,0 +1,78 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _GPIO_GET_LINEEVENT_IOCTL:
+
+************************
+GPIO_GET_LINEEVENT_IOCTL
+************************
+
+.. warning::
+    This ioctl is part of chardev_v1.rst and is obsoleted by
+    gpio-v2-get-line-ioctl.rst.
+
+Name
+====
+
+GPIO_GET_LINEEVENT_IOCTL - Request a line with edge detection from the kernel.
+
+Synopsis
+========
+
+.. c:macro:: GPIO_GET_LINEEVENT_IOCTL
+
+``int ioctl(int chip_fd, GPIO_GET_LINEEVENT_IOCTL, struct gpioevent_request *request)``
+
+Arguments
+=========
+
+``chip_fd``
+    The file descriptor of the GPIO character device returned by `open()`.
+
+``request``
+    The :c:type:`event_request<gpioevent_request>` specifying the line
+    to request and its configuration.
+
+Description
+===========
+
+Request a line with edge detection from the kernel.
+
+On success, the requesting process is granted exclusive access to the line
+value and may receive events when edges are detected on the line, as
+described in gpio-lineevent-data-read.rst.
+
+The state of a line is guaranteed to remain as requested until the returned
+file descriptor is closed. Once the file descriptor is closed, the state of
+the line becomes uncontrolled from the userspace perspective, and may revert
+to its default state.
+
+Requesting a line already in use is an error (**EBUSY**).
+
+Closing the ``chip_fd`` has no effect on existing line events.
+
+Configuration Rules
+-------------------
+
+The following configuration rules apply:
+
+The line event is requested as an input, so no flags specific to output lines,
+``GPIOHANDLE_REQUEST_OUTPUT``, ``GPIOHANDLE_REQUEST_OPEN_DRAIN``, or
+``GPIOHANDLE_REQUEST_OPEN_SOURCE``, may be set.
+
+Only one bias flag, ``GPIOHANDLE_REQUEST_BIAS_xxx``, may be set.
+If no bias flags are set then the bias configuration is not changed.
+
+The edge flags, ``GPIOEVENT_REQUEST_RISING_EDGE`` and
+``GPIOEVENT_REQUEST_FALLING_EDGE``, may be combined to detect both rising
+and falling edges.
+
+Requesting an invalid configuration is an error (**EINVAL**).
+
+Return Value
+============
+
+On success 0 and the :c:type:`request.fd<gpioevent_request>` contains the file
+descriptor for the request.
+
+On error -1 and the ``errno`` variable is set appropriately.
+Common error codes are described in error-codes.rst.
diff --git a/Documentation/userspace-api/gpio/gpio-get-linehandle-ioctl.rst b/Documentation/userspace-api/gpio/gpio-get-linehandle-ioctl.rst
new file mode 100644
index 000000000000..c8256afe306e
--- /dev/null
+++ b/Documentation/userspace-api/gpio/gpio-get-linehandle-ioctl.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _GPIO_GET_LINEHANDLE_IOCTL:
+
+*************************
+GPIO_GET_LINEHANDLE_IOCTL
+*************************
+
+.. warning::
+    This ioctl is part of chardev_v1.rst and is obsoleted by
+    gpio-v2-get-line-ioctl.rst.
+
+Name
+====
+
+GPIO_GET_LINEHANDLE_IOCTL - Request a line or lines from the kernel.
+
+Synopsis
+========
+
+.. c:macro:: GPIO_GET_LINEHANDLE_IOCTL
+
+``int ioctl(int chip_fd, GPIO_GET_LINEHANDLE_IOCTL, struct gpiohandle_request *request)``
+
+Arguments
+=========
+
+``chip_fd``
+    The file descriptor of the GPIO character device returned by `open()`.
+
+``request``
+    The :c:type:`handle_request<gpiohandle_request>` specifying the lines to
+    request and their configuration.
+
+Description
+===========
+
+Request a line or lines from the kernel.
+
+While multiple lines may be requested, the same configuration applies to all
+lines in the request.
+
+On success, the requesting process is granted exclusive access to the line
+value and write access to the line configuration.
+
+The state of a line, including the value of output lines, is guaranteed to
+remain as requested until the returned file descriptor is closed. Once the
+file descriptor is closed, the state of the line becomes uncontrolled from
+the userspace perspective, and may revert to its default state.
+
+Requesting a line already in use is an error (**EBUSY**).
+
+Closing the ``chip_fd`` has no effect on existing line handles.
+
+.. _gpio-get-linehandle-config-rules:
+
+Configuration Rules
+-------------------
+
+The following configuration rules apply:
+
+The direction flags, ``GPIOHANDLE_REQUEST_INPUT`` and
+``GPIOHANDLE_REQUEST_OUTPUT``, cannot be combined. If neither are set then the
+only other flag that may be set is ``GPIOHANDLE_REQUEST_ACTIVE_LOW`` and the
+line is requested "as-is" to allow reading of the line value without altering
+the electrical configuration.
+
+The drive flags, ``GPIOHANDLE_REQUEST_OPEN_xxx``, require the
+``GPIOHANDLE_REQUEST_OUTPUT`` to be set.
+Only one drive flag may be set.
+If none are set then the line is assumed push-pull.
+
+Only one bias flag, ``GPIOHANDLE_REQUEST_BIAS_xxx``, may be set, and
+it requires a direction flag to also be set.
+If no bias flags are set then the bias configuration is not changed.
+
+Requesting an invalid configuration is an error (**EINVAL**).
+
+Return Value
+============
+
+On success 0 and the :c:type:`request.fd<gpiohandle_request>` contains the
+file descriptor for the request.
+
+On error -1 and the ``errno`` variable is set appropriately.
+Common error codes are described in error-codes.rst.
diff --git a/Documentation/userspace-api/gpio/gpio-get-lineinfo-ioctl.rst b/Documentation/userspace-api/gpio/gpio-get-lineinfo-ioctl.rst
new file mode 100644
index 000000000000..c895b8910b25
--- /dev/null
+++ b/Documentation/userspace-api/gpio/gpio-get-lineinfo-ioctl.rst
@@ -0,0 +1,54 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _GPIO_GET_LINEINFO_IOCTL:
+
+***********************
+GPIO_GET_LINEINFO_IOCTL
+***********************
+
+.. warning::
+    This ioctl is part of chardev_v1.rst and is obsoleted by
+    gpio-v2-get-lineinfo-ioctl.rst.
+
+Name
+====
+
+GPIO_GET_LINEINFO_IOCTL - Get the publicly available information for a line.
+
+Synopsis
+========
+
+.. c:macro:: GPIO_GET_LINEINFO_IOCTL
+
+``int ioctl(int chip_fd, GPIO_GET_LINEINFO_IOCTL, struct gpioline_info *info)``
+
+Arguments
+=========
+
+``chip_fd``
+    The file descriptor of the GPIO character device returned by `open()`.
+
+``info``
+    The :c:type:`line_info<gpioline_info>` to be populated, with the
+    ``offset`` field set to indicate the line to be collected.
+
+Description
+===========
+
+Get the publicly available information for a line.
+
+This information is available independent of whether the line is in use.
+
+.. note::
+    The line info does not include the line value.
+
+    The line must be requested using gpio-get-linehandle-ioctl.rst or
+    gpio-get-lineevent-ioctl.rst to access its value.
+
+Return Value
+============
+
+On success 0 and ``info`` is populated with the chip info.
+
+On error -1 and the ``errno`` variable is set appropriately.
+Common error codes are described in error-codes.rst.
diff --git a/Documentation/userspace-api/gpio/gpio-get-lineinfo-unwatch-ioctl.rst b/Documentation/userspace-api/gpio/gpio-get-lineinfo-unwatch-ioctl.rst
index 2fec6f12e3bf..a82d0161daf8 100644
--- a/Documentation/userspace-api/gpio/gpio-get-lineinfo-unwatch-ioctl.rst
+++ b/Documentation/userspace-api/gpio/gpio-get-lineinfo-unwatch-ioctl.rst
@@ -33,7 +33,7 @@ Description
 
 Remove the line from the list of lines being watched on this ``chip_fd``.
 
-This is the opposite of gpio-v2-get-lineinfo-watch-ioctl.rst (v2) and
+This is the reverse of gpio-v2-get-lineinfo-watch-ioctl.rst (v2) and
 gpio-get-lineinfo-watch-ioctl.rst (v1).
 
 Unwatching a line that is not watched is an error (**EBUSY**).
diff --git a/Documentation/userspace-api/gpio/gpio-get-lineinfo-watch-ioctl.rst b/Documentation/userspace-api/gpio/gpio-get-lineinfo-watch-ioctl.rst
new file mode 100644
index 000000000000..f5c92b69a496
--- /dev/null
+++ b/Documentation/userspace-api/gpio/gpio-get-lineinfo-watch-ioctl.rst
@@ -0,0 +1,74 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _GPIO_GET_LINEINFO_WATCH_IOCTL:
+
+*****************************
+GPIO_GET_LINEINFO_WATCH_IOCTL
+*****************************
+
+.. warning::
+    This ioctl is part of chardev_v1.rst and is obsoleted by
+    gpio-v2-get-lineinfo-watch-ioctl.rst.
+
+Name
+====
+
+GPIO_GET_LINEINFO_WATCH_IOCTL - Enable watching a line for changes to its
+request state and configuration information.
+
+Synopsis
+========
+
+.. c:macro:: GPIO_GET_LINEINFO_WATCH_IOCTL
+
+``int ioctl(int chip_fd, GPIO_GET_LINEINFO_WATCH_IOCTL, struct gpioline_info *info)``
+
+Arguments
+=========
+
+``chip_fd``
+    The file descriptor of the GPIO character device returned by `open()`.
+
+``info``
+    The :c:type:`line_info<gpioline_info>` struct to be populated, with
+    the ``offset`` set to indicate the line to watch
+
+Description
+===========
+
+Enable watching a line for changes to its request state and configuration
+information. Changes to line info include a line being requested, released
+or reconfigured.
+
+.. note::
+    Watching line info is not generally required, and would typically only be
+    used by a system monitoring component.
+
+    The line info does NOT include the line value.
+
+    The line must be requested using gpio-get-linehandle-ioctl.rst or
+    gpio-get-lineevent-ioctl.rst to access its value, and the line event can
+    monitor a line for events using gpio-lineevent-data-read.rst.
+
+By default all lines are unwatched when the GPIO chip is opened.
+
+Multiple lines may be watched simultaneously by adding a watch for each.
+
+Once a watch is set, any changes to line info will generate events which can be
+read from the ``chip_fd`` as described in
+gpio-lineinfo-changed-read.rst.
+
+Adding a watch to a line that is already watched is an error (**EBUSY**).
+
+Watches are specific to the ``chip_fd`` and are independent of watches
+on the same GPIO chip opened with a separate call to `open()`.
+
+First added in 5.7.
+
+Return Value
+============
+
+On success 0 and ``info`` is populated with the current line info.
+
+On error -1 and the ``errno`` variable is set appropriately.
+Common error codes are described in error-codes.rst.
diff --git a/Documentation/userspace-api/gpio/gpio-handle-get-line-values-ioctl.rst b/Documentation/userspace-api/gpio/gpio-handle-get-line-values-ioctl.rst
new file mode 100644
index 000000000000..25263b8f0588
--- /dev/null
+++ b/Documentation/userspace-api/gpio/gpio-handle-get-line-values-ioctl.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _GPIOHANDLE_GET_LINE_VALUES_IOCTL:
+
+********************************
+GPIOHANDLE_GET_LINE_VALUES_IOCTL
+********************************
+.. warning::
+    This ioctl is part of chardev_v1.rst and is obsoleted by
+    gpio-v2-line-get-values-ioctl.rst.
+
+Name
+====
+
+GPIOHANDLE_GET_LINE_VALUES_IOCTL - Get the values of all requested lines.
+
+Synopsis
+========
+
+.. c:macro:: GPIOHANDLE_GET_LINE_VALUES_IOCTL
+
+``int ioctl(int handle_fd, GPIOHANDLE_GET_LINE_VALUES_IOCTL, struct gpiohandle_data *values)``
+
+Arguments
+=========
+
+``handle_fd``
+    The file descriptor of the GPIO character device, as returned in the
+    :c:type:`request.fd<gpiohandle_request>` by gpio-get-linehandle-ioctl.rst.
+
+``values``
+    The :c:type:`line_values<gpiohandle_data>` to be populated.
+
+Description
+===========
+
+Get the values of all requested lines.
+
+The values of both input and output lines may be read.
+
+For output lines, the value returned is driver and configuration dependent and
+may be either the output buffer (the last requested value set) or the input
+buffer (the actual level of the line), and depending on the hardware and
+configuration these may differ.
+
+This ioctl can also be used to read the line value for line events,
+substituting the ``event_fd`` for the ``handle_fd``.  As there is only
+one line requested in that case, only the one value is returned in ``values``.
+
+Return Value
+============
+
+On success 0 and ``values`` populated with the values read.
+
+On error -1 and the ``errno`` variable is set appropriately.
+Common error codes are described in error-codes.rst.
diff --git a/Documentation/userspace-api/gpio/gpio-handle-set-config-ioctl.rst b/Documentation/userspace-api/gpio/gpio-handle-set-config-ioctl.rst
new file mode 100644
index 000000000000..8f1e748dccc8
--- /dev/null
+++ b/Documentation/userspace-api/gpio/gpio-handle-set-config-ioctl.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _GPIOHANDLE_SET_CONFIG_IOCTL:
+
+***************************
+GPIOHANDLE_SET_CONFIG_IOCTL
+***************************
+
+.. warning::
+    This ioctl is part of chardev_v1.rst and is obsoleted by
+    gpio-v2-line-set-config-ioctl.rst.
+
+Name
+====
+
+GPIOHANDLE_SET_CONFIG_IOCTL - Update the configuration of previously requested lines.
+
+Synopsis
+========
+
+.. c:macro:: GPIOHANDLE_SET_CONFIG_IOCTL
+
+``int ioctl(int handle_fd, GPIOHANDLE_SET_CONFIG_IOCTL, struct gpiohandle_config *config)``
+
+Arguments
+=========
+
+``handle_fd``
+    The file descriptor of the GPIO character device, as returned in the
+    :c:type:`request.fd<gpiohandle_request>` by gpio-get-linehandle-ioctl.rst.
+
+``config``
+    The new :c:type:`configuration<gpiohandle_config>` to apply to the
+    requested lines.
+
+Description
+===========
+
+Update the configuration of previously requested lines, without releasing the
+line or introducing potential glitches.
+
+The configuration applies to all requested lines.
+
+The same :ref:`gpio-get-linehandle-config-rules` that apply when requesting the
+lines also apply when updating the line configuration.
+
+The motivating use case for this command is changing direction of
+bi-directional lines between input and output, but it may be used more
+generally move lines seamlessly from one configuration state to another.
+
+To only change the value of output lines, use
+gpio-handle-set-line-values-ioctl.rst.
+
+First added in 5.5.
+
+Return Value
+============
+
+On success 0.
+
+On error -1 and the ``errno`` variable is set appropriately.
+Common error codes are described in error-codes.rst.
diff --git a/Documentation/userspace-api/gpio/gpio-handle-set-line-values-ioctl.rst b/Documentation/userspace-api/gpio/gpio-handle-set-line-values-ioctl.rst
new file mode 100644
index 000000000000..0aa05e623a6c
--- /dev/null
+++ b/Documentation/userspace-api/gpio/gpio-handle-set-line-values-ioctl.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _GPIO_HANDLE_SET_LINE_VALUES_IOCTL:
+
+*********************************
+GPIO_HANDLE_SET_LINE_VALUES_IOCTL
+*********************************
+.. warning::
+    This ioctl is part of chardev_v1.rst and is obsoleted by
+    gpio-v2-line-set-values-ioctl.rst.
+
+Name
+====
+
+GPIO_HANDLE_SET_LINE_VALUES_IOCTL - Set the values of all requested output lines.
+
+Synopsis
+========
+
+.. c:macro:: GPIO_HANDLE_SET_LINE_VALUES_IOCTL
+
+``int ioctl(int handle_fd, GPIO_HANDLE_SET_LINE_VALUES_IOCTL, struct gpiohandle_data *values)``
+
+Arguments
+=========
+
+``handle_fd``
+    The file descriptor of the GPIO character device, as returned in the
+    :c:type:`request.fd<gpiohandle_request>` by gpio-get-linehandle-ioctl.rst.
+
+``values``
+    The :c:type:`line_values<gpiohandle_data>` to set.
+
+Description
+===========
+
+Set the values of all requested output lines.
+
+Only the values of output lines may be set.
+Attempting to set the value of input lines is an error (**EPERM**).
+
+Return Value
+============
+
+On success 0.
+
+On error -1 and the ``errno`` variable is set appropriately.
+Common error codes are described in error-codes.rst.
diff --git a/Documentation/userspace-api/gpio/gpio-lineevent-data-read.rst b/Documentation/userspace-api/gpio/gpio-lineevent-data-read.rst
new file mode 100644
index 000000000000..68b8d4f9f604
--- /dev/null
+++ b/Documentation/userspace-api/gpio/gpio-lineevent-data-read.rst
@@ -0,0 +1,84 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _GPIO_LINEEVENT_DATA_READ:
+
+************************
+GPIO_LINEEVENT_DATA_READ
+************************
+
+.. warning::
+    This ioctl is part of chardev_v1.rst and is obsoleted by
+    gpio-v2-line-event-read.rst.
+
+Name
+====
+
+GPIO_LINEEVENT_DATA_READ - Read edge detection events from a line event.
+
+Synopsis
+========
+
+``int read(int event_fd, void *buf, size_t count)``
+
+Arguments
+=========
+
+``event_fd``
+    The file descriptor of the GPIO character device, as returned in the
+    :c:type:`request.fd<gpioevent_request>` by gpio-get-lineevent-ioctl.rst.
+
+``buf``
+    The buffer to contain the :c:type:`events<gpioevent_data>`.
+
+``count``
+    The number of bytes available in ``buf``, which must be at
+    least the size of a :c:type:`gpioevent_data`.
+
+Description
+===========
+
+Read edge detection events for a line from a line event.
+
+Edge detection must be enabled for the input line using either
+``GPIOEVENT_REQUEST_RISING_EDGE`` or ``GPIOEVENT_REQUEST_FALLING_EDGE``, or
+both. Edge events are then generated whenever edge interrupts are detected on
+the input line.
+
+The kernel captures and timestamps edge events as close as possible to their
+occurrence and stores them in a buffer from where they can be read by
+userspace at its convenience using `read()`.
+
+The source of the clock for :c:type:`event.timestamp<gpioevent_data>` is
+``CLOCK_MONOTONIC``, except for kernels earlier than Linux 5.7 when it was
+``CLOCK_REALTIME``.  There is no indication in the :c:type:`gpioevent_data`
+as to which clock source is used, it must be determined from either the kernel
+version or sanity checks on the timestamp itself.
+
+Events read from the buffer are always in the same order that they were
+detected by the kernel.
+
+The size of the kernel event buffer is fixed at 16 events.
+
+The buffer may overflow if bursts of events occur quicker than they are read
+by userspace. If an overflow occurs then the most recent event is discarded.
+Overflow cannot be detected from userspace.
+
+To minimize the number of calls required to copy events from the kernel to
+userspace, `read()` supports copying multiple events. The number of events
+copied is the lower of the number available in the kernel buffer and the
+number that will fit in the userspace buffer (``buf``).
+
+The `read()` will block if no event is available and the ``event_fd`` has not
+been set **O_NONBLOCK**.
+
+The presence of an event can be tested for by checking that the ``event_fd`` is
+readable using `poll()` or an equivalent.
+
+Return Value
+============
+
+On success the number of bytes read, which will be a multiple of the size of
+a :c:type:`gpio_lineevent_data` event.
+
+On error -1 and the ``errno`` variable is set appropriately.
+Common error codes are described in error-codes.rst.
diff --git a/Documentation/userspace-api/gpio/gpio-lineinfo-changed-read.rst b/Documentation/userspace-api/gpio/gpio-lineinfo-changed-read.rst
new file mode 100644
index 000000000000..c4f5e1787a9d
--- /dev/null
+++ b/Documentation/userspace-api/gpio/gpio-lineinfo-changed-read.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _GPIO_LINEINFO_CHANGED_READ:
+
+**************************
+GPIO_LINEINFO_CHANGED_READ
+**************************
+
+.. warning::
+    This ioctl is part of chardev_v1.rst and is obsoleted by
+    gpio-v2-lineinfo-changed-read.rst.
+
+Name
+====
+
+GPIO_LINEINFO_CHANGED_READ - Read line info change events for watched lines
+from the chip.
+
+Synopsis
+========
+
+``int read(int chip_fd, void *buf, size_t count)``
+
+Arguments
+=========
+
+``chip_fd``
+    The file descriptor of the GPIO character device returned by `open()`.
+
+``buf``
+    The buffer to contain the :c:type:`events<gpioline_info_changed>`.
+
+``count``
+    The number of bytes available in ``buf``, which must be at least the size
+    of a :c:type:`gpioline_info_changed` event.
+
+Description
+===========
+
+Read line info change events for watched lines from the chip.
+
+.. note::
+    Monitoring line info changes is not generally required, and would typically
+    only be performed by a system monitoring component.
+
+    These events relate to changes in a line's request state or configuration,
+    not its value. Use gpio-lineevent-data-read.rst to receive events when a
+    line changes value.
+
+A line must be watched using gpio-get-lineinfo-watch-ioctl.rst to generate
+info changed events.  Subsequently, a request, release, or reconfiguration
+of the line will generate an info changed event.
+
+The kernel timestamps events when they occur and stores them in a buffer
+from where they can be read by userspace at its convenience using `read()`.
+
+The size of the kernel event buffer is fixed at 32 events per ``chip_fd``.
+
+The buffer may overflow if bursts of events occur quicker than they are read
+by userspace. If an overflow occurs then the most recent event is discarded.
+Overflow cannot be detected from userspace.
+
+Events read from the buffer are always in the same order that they were
+detected by the kernel, including when multiple lines are being monitored by
+the one ``chip_fd``.
+
+To minimize the number of calls required to copy events from the kernel to
+userspace, `read()` supports copying multiple events. The number of events
+copied is the lower of the number available in the kernel buffer and the
+number that will fit in the userspace buffer (``buf``).
+
+A `read()` will block if no event is available and the ``chip_fd`` has not
+been set **O_NONBLOCK**.
+
+The presence of an event can be tested for by checking that the ``chip_fd`` is
+readable using `poll()` or an equivalent.
+
+First added in 5.7.
+
+Return Value
+============
+
+On success the number of bytes read, which will be a multiple of the size of
+a :c:type:`gpioline_info_changed` event.
+
+On error -1 and the ``errno`` variable is set appropriately.
+Common error codes are described in error-codes.rst.
diff --git a/Documentation/userspace-api/gpio/obsolete.rst b/Documentation/userspace-api/gpio/obsolete.rst
index c27bd6014a3d..c42538b44ec8 100644
--- a/Documentation/userspace-api/gpio/obsolete.rst
+++ b/Documentation/userspace-api/gpio/obsolete.rst
@@ -7,4 +7,5 @@ Obsolete GPIO Userspace APIs
 .. toctree::
     :maxdepth: 1
 
+    Character Device Userspace API (v1) <chardev_v1>
     Sysfs Interface <sysfs>
-- 
2.39.2


