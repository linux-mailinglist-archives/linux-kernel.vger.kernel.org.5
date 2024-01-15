Return-Path: <linux-kernel+bounces-25565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ED682D2C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E76281303
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D54615A5;
	Mon, 15 Jan 2024 00:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhkF9VAe"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31D6A3D;
	Mon, 15 Jan 2024 00:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bb53e20a43so5867552b6e.1;
        Sun, 14 Jan 2024 16:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705279745; x=1705884545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihEdIVcvFw3CmEFZbZuSsEOuxkPmZ6VB5P0/0vrY06E=;
        b=jhkF9VAep8pqrPBw/CVKTENlf8Y5CfC3GtTuL+HKwD7rWyhx0TwpCJqczsyi8rEx/N
         +frcN9CfviXrLFbF8jA/jUiwDRIUJ3dQytQ0ZiAPMqWGngeh4Gy7eOeai4/23W1lKamu
         g+Fm2EUz8+8oFSCK0wnucj/aqxNqAvn/Q/zi59fUMz4Ld+WitODbNNstOQS9EY7pFbGC
         CcsbFho/2sy7SSy8ZzlkqOowVvmTZ7nvcRLuOrRHArC9iuyiHUcnzN4YBouhoKl42niB
         nvLtBTfL/Yxc2imLqB8aIrHd1rTCDAbrCDsKhyK3TWv9h7o/yqDErsenw40eUh6WEpaz
         +N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705279745; x=1705884545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihEdIVcvFw3CmEFZbZuSsEOuxkPmZ6VB5P0/0vrY06E=;
        b=scvbOukW0JUp+9xxxJXOWY9zZm3gkecsgnTLC+nS9Ziyo19FqnCgPRCvj+EYVqvVeS
         MBTXN2cNgxbXey+K2aoQnUgYf6gukfS4n3sE/+7uwAHIIEWvhe/QR19q0Z0vNNXiYr2P
         8bRoLVIeAWtlLmN3RF3SNjCO5SIS2wTbN+MvUJqkepbwb8VRgOVvggwZ4sODyMJHclR8
         rGvg4wjYCRrvV2Euaz56OP1uCr3Jf2I8G4/lMKv8ol0wP8J9KuY1QphkfdB9Aavh3SFT
         IzRBZxuxaV6y2ZoT3JqU5rw/xuYBMeytF29fOlP9nlA9pvooTwnWHbnXw04v4iNrZ7IS
         oU5A==
X-Gm-Message-State: AOJu0YzFo2iMd9DZAaxQH8o0jAEA56EWg2M1c3bXiShLk0V/I1oIrcwA
	yG74teJOxIWJCdccWII6mnNHEJQeSxGbpg==
X-Google-Smtp-Source: AGHT+IHh35jDY+FMp/fNdW2QsHQVGGyVgp7SoT9bWMAv5gCdercKz+mdOZfhUxZwmnTuKIv+LZEGnQ==
X-Received: by 2002:a05:6808:485:b0:3bd:72b3:47a3 with SMTP id z5-20020a056808048500b003bd72b347a3mr2349646oid.67.1705279745262;
        Sun, 14 Jan 2024 16:49:05 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b006d999f4a3c0sm6538365pfo.152.2024.01.14.16.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 16:49:04 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 0/9] Documentation: gpio: add character device userspace API documentation
Date: Mon, 15 Jan 2024 08:48:38 +0800
Message-Id: <20240115004847.22369-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My new year's resolution was to improve the documentation of the
character device API and gpio in general, so here we are.

Wrt the formatting and file breakdown, I've taken inspiration from
the userspace-api/media documentation.

Patch 1 adds documentation for the current chardev uAPI. I've added
it to the userspace-api book, as that is the most obvious place a
reader would look for it, but have also provided links from the
admin-guide book where the gpio docs currently reside.

I realise MAINTAINERS should be updated with
Documentation/userspace-api/gpio/, but the split out of GPIO UAPI
hasn't made it into gpio/for-next yet, so I was unsure of how to
handle that.

Patch 2 updates the gpio-cdev ABI documentation to reference the
chardev documentation as well as gpio.h.

Patch 3 updates the sysfs-gpio ABI documentation to reference the
gpio-cdev ABI that obsoletes it.

Patch 4 relocates the sysfs API doc to stress its deprecation by
moving it to a new obsolete section, again in userspace-api but
with a similar section in the admin-guide. The obsolete section
also serves as a placeholder for subsequent changes.

Patch 5 updates the sysfs API doc to reference the chardev
documentation rather than gpio.h and make use of reST formatting.

Patch 6 adds documentation for the obsolete v1 version of the
chardev uAPI.  It is obsolete, but still useful to have, if
nothing else to help identify the differences between v1 and v2.

Patch 7 capitalizes the title of the admin-guide/gpio to match
the other subsystems and the userspace-api book.

Patch 8 adds an obsolescence note to the gpio-mockup, as it is
obsoleted by the gpio-sim.

Patch 9 moves the gpio-mockup doc into the obsolete section.

I've got some minor updates for the kernel doc in gpio.h as well,
but they make sense on their own so I've sent those separately
to keep the cross-posting to a minimum.

I realise the only thing less exciting than writing documentation
is reviewing it, so my apologies and thanks in advance if you
have the fortitude to attempt such a scintillating endeavour.

Cheers,
Kent.

Changes v1 -> v2:
 - add Linus' review tag (patch 1)
 - add first added kernel version for APIs, and ioctls where
   they were added separately from the API they are part of (patch 1 and 6).
 - add note that requesting a line in use is an error (EBUSY),
   GPIO_v2_GET_LINE_IOCTL (patch 1), GPIO_GET_LINEEVENT_IOCTL
   and GPIO_GET_LINEHANDLE_IOCTL (patch 6).
 - add updating gpio-cdev interface doc to reference chardev.rst (patch 2).
 - add updating sysfs-gpio interface doc to reference gpio-cdev (patch 3).
 - rename deprecated section to obsolete section (patch 4, 6 and 9).
 - rework obsolescence warning and abuse note in sysfs.rst to
   make use of reST formatting for emphasis, rather than ALL CAPS,
   and to note that the interface is to be removed in the future
   (patch 5).
 - note that the v1 API will be removed in the future (patch 6).

Kent Gibson (9):
  Documentation: gpio: add chardev userspace API documentation
  Documentation: ABI: update gpio-cdev to reference chardev.rst
  Documentation: ABI: update sysfs-gpio to reference gpio-cdev
  Documentation: gpio: move sysfs into an obsolete section
  Documentation: gpio: update sysfs documentation to reference new
    chardev doc
  Documentation: gpio: add chardev v1 userspace API documentation
  Documentation: gpio: capitalize GPIO in index title
  Documentation: gpio: document gpio-mockup as obsoleted by gpio-sim
  Documentation: gpio: move gpio-mockup into obsolete section

 Documentation/ABI/obsolete/sysfs-gpio         |   4 +-
 Documentation/ABI/testing/gpio-cdev           |   9 +-
 .../admin-guide/gpio/gpio-mockup.rst          |   8 ++
 Documentation/admin-guide/gpio/index.rst      |   6 +-
 Documentation/admin-guide/gpio/obsolete.rst   |  13 ++
 Documentation/userspace-api/gpio/chardev.rst  | 116 ++++++++++++++++
 .../userspace-api/gpio/chardev_v1.rst         | 131 ++++++++++++++++++
 .../userspace-api/gpio/error-codes.rst        |  78 +++++++++++
 .../gpio/gpio-get-chipinfo-ioctl.rst          |  41 ++++++
 .../gpio/gpio-get-lineevent-ioctl.rst         |  78 +++++++++++
 .../gpio/gpio-get-linehandle-ioctl.rst        |  86 ++++++++++++
 .../gpio/gpio-get-lineinfo-ioctl.rst          |  54 ++++++++
 .../gpio/gpio-get-lineinfo-unwatch-ioctl.rst  |  49 +++++++
 .../gpio/gpio-get-lineinfo-watch-ioctl.rst    |  74 ++++++++++
 .../gpio-handle-get-line-values-ioctl.rst     |  56 ++++++++
 .../gpio/gpio-handle-set-config-ioctl.rst     |  62 +++++++++
 .../gpio-handle-set-line-values-ioctl.rst     |  48 +++++++
 .../gpio/gpio-lineevent-data-read.rst         |  84 +++++++++++
 .../gpio/gpio-lineinfo-changed-read.rst       |  87 ++++++++++++
 .../gpio/gpio-v2-get-line-ioctl.rst           | 101 ++++++++++++++
 .../gpio/gpio-v2-get-lineinfo-ioctl.rst       |  50 +++++++
 .../gpio/gpio-v2-get-lineinfo-watch-ioctl.rst |  67 +++++++++
 .../gpio/gpio-v2-line-event-read.rst          |  83 +++++++++++
 .../gpio/gpio-v2-line-get-values-ioctl.rst    |  51 +++++++
 .../gpio/gpio-v2-line-set-config-ioctl.rst    |  57 ++++++++
 .../gpio/gpio-v2-line-set-values-ioctl.rst    |  47 +++++++
 .../gpio/gpio-v2-lineinfo-changed-read.rst    |  81 +++++++++++
 Documentation/userspace-api/gpio/index.rst    |  18 +++
 Documentation/userspace-api/gpio/obsolete.rst |  11 ++
 .../gpio/sysfs.rst                            |  27 ++--
 Documentation/userspace-api/index.rst         |   1 +
 31 files changed, 1657 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/admin-guide/gpio/obsolete.rst
 create mode 100644 Documentation/userspace-api/gpio/chardev.rst
 create mode 100644 Documentation/userspace-api/gpio/chardev_v1.rst
 create mode 100644 Documentation/userspace-api/gpio/error-codes.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-chipinfo-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineevent-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-linehandle-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineinfo-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineinfo-unwatch-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineinfo-watch-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-handle-get-line-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-handle-set-config-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-handle-set-line-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-lineevent-data-read.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-lineinfo-changed-read.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-watch-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-event-read.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-get-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-set-config-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-set-values-ioctl.rst
 create mode 100644 Documentation/userspace-api/gpio/gpio-v2-lineinfo-changed-read.rst
 create mode 100644 Documentation/userspace-api/gpio/index.rst
 create mode 100644 Documentation/userspace-api/gpio/obsolete.rst
 rename Documentation/{admin-guide => userspace-api}/gpio/sysfs.rst (89%)

-- 
2.39.2


