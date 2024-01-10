Return-Path: <linux-kernel+bounces-22105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1980A829946
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DFA1F22B96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B0A47F47;
	Wed, 10 Jan 2024 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gadgetoid.com header.i=@gadgetoid.com header.b="OyB0qRfE"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB447A6B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gadgetoid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gadgetoid.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-204df0830ccso3394675fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gadgetoid.com; s=google; t=1704886848; x=1705491648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pIldsqrJky1RwWSYzG/96yLVnfZJAovLeq8al9NrcFM=;
        b=OyB0qRfEU3DMspft8L9xfYX3mv1yBcX2mnAcli59cZj4yZCdeTN8hmqwCl+eyBBp7M
         K7Cesj3QQ04IGbNZFKyWmOyr7FMD6pokUGvbDSUZE582/qqwDMsYFl3myBffh+Dd0yJc
         j4+/PeoC2S2kpRKfjsiNbUvqOobUUszxMZep+XZiCGmMHC8QI+Bl3FiapXNoE/sW7nQB
         RMBtb+Z2cyVC0m+tUB8pOAOVBikKq6m8CW9/h6mv+WzdDHgj+j3MZ7FvlG1ZiGyiN4Cj
         DVZJF6MdDlCAOwCfmTYVF+HmxZMlYlofQejU2/0rUqW88T4hv32f5/E0UvydfiKIMPx/
         Jtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704886848; x=1705491648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIldsqrJky1RwWSYzG/96yLVnfZJAovLeq8al9NrcFM=;
        b=VGPL+ryqWth+KYkhM4XlnY1d8lNwY1GXcBczbnhGQfH0JSvge8Qgal8Pksq87cQXDz
         1YftsOuZePtRNKst1Hml0S+1V0wvZsVc4yYcUL5WD3wfCPdetyySkLIuPaVGViOSQbRn
         OmAG5SyHbxRZQjyGcMPjFjXjzB/ysPbLX5WausZObywtt1yGahkmLoCHqPXK/Z2pTaT/
         A/Crg97Nj9XqCHphN0PSm/2qNY1RZMGy0+3h14x/mJWZEjXBFZSyJfwSo1G1Acig/e8m
         p2TVBz6vEpDU/2loHM6HeaVOrW4d8N4NrfqpBcrnUWIdgGLdOqxl9ysEFE/enZ6XrTAU
         SM6Q==
X-Gm-Message-State: AOJu0YwjUPcp3RFVk0dkCfGZAQR0jGh8S08WXUYsY3lUBcxWhYP1SdLE
	JZI2Seu608mfYcbuyMa/Wx2nPoIDRyRpmP/qQ9cDJkwcZW0Bs1+wtufbyb/vWzk5Gw==
X-Google-Smtp-Source: AGHT+IGYY0PhKDGjytNviE/yI9LVvWxnEszERpug3Bjd47AtCfrxtjYX2QYmrZOPvZlZz3E42FvNMwB9sYC5BbQ3s/w=
X-Received: by 2002:a05:6870:9728:b0:1fb:75c:3fe4 with SMTP id
 n40-20020a056870972800b001fb075c3fe4mr576005oaq.68.1704886847624; Wed, 10 Jan
 2024 03:40:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109135952.77458-1-warthog618@gmail.com> <20240109135952.77458-2-warthog618@gmail.com>
In-Reply-To: <20240109135952.77458-2-warthog618@gmail.com>
From: Phil Howard <phil@gadgetoid.com>
Date: Wed, 10 Jan 2024 11:40:34 +0000
Message-ID: <CA+kSVo_347gS+w_7ZXFDi9qDtT1aw15qoWRJZAVSkfbHShz7kQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] Documentation: gpio: add chardev userspace API documentation
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org, 
	andy@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"

First up, thank you for this. I'm busy getting up to speed with libgpiod
having been spoiled by bit-bashing memory mapped GPIO and there
are many gotchas that the below helps clarify.

FWIW I've added a few "from the perspective of an advanced noob"
comments.

On Tue, 9 Jan 2024 at 14:00, Kent Gibson <warthog618@gmail.com> wrote:
>
> Add documentation for the GPIO character device userspace API.
>
> Added to the userspace-api book, but also provide a link from the
> admin-guide book, as historically the GPIO documentation has been
> there.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  Documentation/admin-guide/gpio/index.rst      |   1 +
>  Documentation/userspace-api/gpio/chardev.rst  | 114 ++++++++++++++++++
>  .../userspace-api/gpio/error-codes.rst        |  78 ++++++++++++
>  .../gpio/gpio-get-chipinfo-ioctl.rst          |  41 +++++++
>  .../gpio/gpio-get-lineinfo-unwatch-ioctl.rst  |  47 ++++++++
>  .../gpio/gpio-v2-get-line-ioctl.rst           |  99 +++++++++++++++
>  .../gpio/gpio-v2-get-lineinfo-ioctl.rst       |  50 ++++++++
>  .../gpio/gpio-v2-get-lineinfo-watch-ioctl.rst |  67 ++++++++++
>  .../gpio/gpio-v2-line-event-read.rst          |  83 +++++++++++++
>  .../gpio/gpio-v2-line-get-values-ioctl.rst    |  51 ++++++++
>  .../gpio/gpio-v2-line-set-config-ioctl.rst    |  57 +++++++++
>  .../gpio/gpio-v2-line-set-values-ioctl.rst    |  47 ++++++++
>  .../gpio/gpio-v2-lineinfo-changed-read.rst    |  81 +++++++++++++
>  Documentation/userspace-api/gpio/index.rst    |  17 +++
>  Documentation/userspace-api/index.rst         |   1 +
>  15 files changed, 834 insertions(+)
>  create mode 100644 Documentation/userspace-api/gpio/chardev.rst
>  create mode 100644 Documentation/userspace-api/gpio/error-codes.rst
>  create mode 100644 Documentation/userspace-api/gpio/gpio-get-chipinfo-ioctl.rst
>  create mode 100644 Documentation/userspace-api/gpio/gpio-get-lineinfo-unwatch-ioctl.rst
>  create mode 100644 Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
>  create mode 100644 Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-ioctl.rst
>  create mode 100644 Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-watch-ioctl.rst
>  create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-event-read.rst
>  create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-get-values-ioctl.rst
>  create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-set-config-ioctl.rst
>  create mode 100644 Documentation/userspace-api/gpio/gpio-v2-line-set-values-ioctl.rst
>  create mode 100644 Documentation/userspace-api/gpio/gpio-v2-lineinfo-changed-read.rst
>  create mode 100644 Documentation/userspace-api/gpio/index.rst
>
> diff --git a/Documentation/admin-guide/gpio/index.rst b/Documentation/admin-guide/gpio/index.rst
> index f6861ca16ffe..b40f0a2a6822 100644
> --- a/Documentation/admin-guide/gpio/index.rst
> +++ b/Documentation/admin-guide/gpio/index.rst
> @@ -7,6 +7,7 @@ gpio
>  .. toctree::
>      :maxdepth: 1
>
> +    Character Device Userspace API <../../userspace-api/gpio/chardev>
>      gpio-aggregator
>      sysfs
>      gpio-mockup
> diff --git a/Documentation/userspace-api/gpio/chardev.rst b/Documentation/userspace-api/gpio/chardev.rst
> new file mode 100644
> index 000000000000..af5f1753e565
> --- /dev/null
> +++ b/Documentation/userspace-api/gpio/chardev.rst
> @@ -0,0 +1,114 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================================
> +GPIO Character Device Userspace API
> +===================================
> +
> +This is latest version (v2) of the character device API, as defined in
> +``include/uapi/linux/gpio.h.``
> +
> +.. note::
> +   Do NOT abuse userspace APIs to control hardware that has proper kernel
> +   drivers. There may already be a driver for your use case, and an existing
> +   kernel driver is sure to provide a superior solution to bitbashing
> +   from userspace.
> +
> +   Read Documentation/driver-api/gpio/drivers-on-gpio.rst to avoid reinventing
> +   kernel wheels in userspace.

I realise this is in part an emotional response, but very much
"citation needed" on
this one. While I believe Kernel drivers for things are a good idea, I
don't believe
userspace libraries are necessarily bad or wrong. They might be the first
experience a future kernel dev has with hardware. Either way there are multiple
ecosystems of userspace drivers both existing and thriving right now, and there
are good reasons to reinvent kernel wheels in userspace.

At least some of these reasons relate to the (incorrectly assumed)
insurmountable
nature of kernel development vs just throwing together some Python. Including
this loaded language just serves to reinforce that.

You catch more flies with honey than with vinegar, so I'd probably soften to:

Before abusing userspace APIs to bitbash drivers for your hardware you should
read Documentation/driver-api/gpio/drivers-on-gpio.rst to see if your device has
an existing kernel driver. If not, please consider contributing one.

> +
> +   Similarly, for multi-function lines there may be other subsystems, such as
> +   Documentation/spi/index.rst, Documentation/i2c/index.rst,
> +   Documentation/driver-api/pwm.rst, Documentation/w1/index.rst etc, that
> +   provide suitable drivers and APIs for your hardware.

This is good, people trying to do PWM via userspace bitbashing on arbitrary pins
(sometimes we really do just want to dim a bunch of LEDs without the cost of an
extra driver IC) is kind of silly in hindsight. If we steer people
toward the right
subsystems, perhaps those can be improved for the benefit of all.

> +
> +Basic examples using the character device API can be found in ``tools/gpio/*``.
> +
> +The API is based around two major objects, the :ref:`gpio-v2-chip` and the
> +:ref:`gpio-v2-line-request`.
> +
> +.. _gpio-v2-chip:
> +
> +Chip
> +====
> +
> +The Chip represents a single GPIO chip and is exposed to userspace using device
> +files of the form ``/dev/gpiochipX``.

Is it worth clarifying that - afaik - the numbering of these device
files is or can
be arbitrary? Or, in the opposite case, that the order is guaranteed
by the vendor's
device tree configuration?

> +
> +Each chip supports a number of GPIO lines,
> +:c:type:`chip.lines<gpiochip_info>`. Lines on the chip are identified by an
> +``offset`` in the range from 0 to ``chip.lines - 1``, i.e. `[0,chip.lines)`.

I don't recognise this syntax "`[0,chip.lines)`", typo, or me being clueless?

> +
> +Lines are requested from the chip using gpio-v2-get-line-ioctl.rst
> +and the resulting line request is used to access the GPIO chip's lines or
> +monitor the lines for edge events.
> +
> +Within this documentation, the file descriptor returned by calling `open()`
> +on the GPIO device file is referred to as ``chip_fd``.
> +
> +Operations
> +----------
> +
> +The following operations may be performed on the chip:
> +
> +.. toctree::
> +   :titlesonly:
> +
> +   Get Line <gpio-v2-get-line-ioctl>
> +   Get Chip Info <gpio-get-chipinfo-ioctl>
> +   Get Line Info <gpio-v2-get-lineinfo-ioctl>
> +   Watch Line Info <gpio-v2-get-lineinfo-watch-ioctl>
> +   Unwatch Line Info <gpio-get-lineinfo-unwatch-ioctl>
> +   Read Line Info Changed Events <gpio-v2-lineinfo-changed-read>
> +
> +.. _gpio-v2-line-request:
> +
> +Line Request
> +============
> +
> +Line requests are created by gpio-v2-get-line-ioctl.rst and provide
> +access to a set of requested lines.  The line request is exposed to userspace
> +via the anonymous file descriptor returned in
> +:c:type:`request.fd<gpio_v2_line_request>` by gpio-v2-get-line-ioctl.rst.
> +
> +Within this documentation, the line request file descriptor is referred to
> +as ``req_fd``.
> +
> +Operations
> +----------
> +
> +The following operations may be performed on the line request:
> +
> +.. toctree::
> +   :titlesonly:
> +
> +   Get Line Values <gpio-v2-line-get-values-ioctl>
> +   Set Line Values <gpio-v2-line-set-values-ioctl>
> +   Read Line Edge Events <gpio-v2-line-event-read>
> +   Reconfigure Lines <gpio-v2-line-set-config-ioctl>
> +
> +Types
> +=====
> +
> +This section contains the structs and enums that are referenced by the API v2,
> +as defined in ``include/uapi/linux/gpio.h``.
> +
> +.. kernel-doc:: include/uapi/linux/gpio.h
> +   :identifiers:
> +    gpio_v2_line_attr_id
> +    gpio_v2_line_attribute
> +    gpio_v2_line_changed_type
> +    gpio_v2_line_config
> +    gpio_v2_line_config_attribute
> +    gpio_v2_line_event
> +    gpio_v2_line_event_id
> +    gpio_v2_line_flag
> +    gpio_v2_line_info
> +    gpio_v2_line_info_changed
> +    gpio_v2_line_request
> +    gpio_v2_line_values
> +    gpiochip_info
> +
> +.. toctree::
> +   :hidden:
> +
> +   error-codes
> diff --git a/Documentation/userspace-api/gpio/error-codes.rst b/Documentation/userspace-api/gpio/error-codes.rst
> new file mode 100644
> index 000000000000..edf01f2cf9d2
> --- /dev/null
> +++ b/Documentation/userspace-api/gpio/error-codes.rst
> @@ -0,0 +1,78 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _gpio_errors:
> +
> +*******************
> +GPIO Error Codes
> +*******************
> +
> +.. _gpio-errors:
> +
> +.. tabularcolumns:: |p{2.5cm}|p{15.0cm}|
> +
> +.. flat-table:: Common GPIO error codes
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths: 1 16
> +
> +    -  -  ``EAGAIN`` (aka ``EWOULDBLOCK``)
> +
> +       -  The device was opened in non-blocking mode and a read can't
> +          be performed as there is no data available.
> +
> +    -  -  ``EBADF``
> +
> +       -  The file descriptor is not valid.
> +
> +    -  -  ``EBUSY``
> +
> +       -  The ioctl can't be handled because the device is busy. Typically
> +          returned when an ioctl attempts something that would require the
> +          usage of a resource that was already allocated. The ioctl must not
> +          be retried without performing another action to fix the problem
> +          first.

eg: When a line is already claimed by another process?

> +
> +    -  -  ``EFAULT``
> +
> +       -  There was a failure while copying data from/to userspace, probably
> +         caused by an invalid pointer reference.
> +
> +    -  -  ``EINVAL``
> +
> +       -  One or more of the ioctl parameters are invalid or out of the
> +          allowed range. This is a widely used error code.
> +
> +    -  -  ``ENODEV``
> +
> +       -  Device not found or was removed.
> +
> +    -  -  ``ENOMEM``
> +
> +       -  There's not enough memory to handle the desired operation.
> +
> +    -  -  ``EPERM``
> +
> +       -  Permission denied. Typically returned in response to an attempt
> +          to perform an action incompatible with the current line
> +          configuration.
> +
> +    -  -  ``EIO``
> +
> +       -  I/O error. Typically returned when there are problems communicating
> +          with a hardware device or requesting features that hardware does not
> +          support. This could indicate broken or flaky hardware.
> +          It's a 'Something is wrong, I give up!' type of error.
> +
> +    -  - ``ENXIO``
> +
> +       -  No device corresponding to this device special file exists.
> +
> +.. note::
> +
> +  #. This list is not exhaustive; ioctls may return other error codes.
> +     Since errors may have side effects such as a driver reset,
> +     applications should abort on unexpected errors, or otherwise
> +     assume that the device is in a bad state.
> +
> +  #. Request-specific error codes are listed in the individual
> +     requests descriptions.
> diff --git a/Documentation/userspace-api/gpio/gpio-get-chipinfo-ioctl.rst b/Documentation/userspace-api/gpio/gpio-get-chipinfo-ioctl.rst
> new file mode 100644
> index 000000000000..05f07fdefe2f
> --- /dev/null
> +++ b/Documentation/userspace-api/gpio/gpio-get-chipinfo-ioctl.rst
> @@ -0,0 +1,41 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _GPIO_GET_CHIPINFO_IOCTL:
> +
> +***********************
> +GPIO_GET_CHIPINFO_IOCTL
> +***********************
> +
> +Name
> +====
> +
> +GPIO_GET_CHIPINFO_IOCTL - Get the publicly available information for a chip.
> +
> +Synopsis
> +========
> +
> +.. c:macro:: GPIO_GET_CHIPINFO_IOCTL
> +
> +``int ioctl(int chip_fd, GPIO_GET_CHIPINFO_IOCTL, struct gpiochip_info *info)``
> +
> +Arguments
> +=========
> +
> +``chip_fd``
> +    The file descriptor of the GPIO character device returned by `open()`.
> +
> +``info``
> +    The :c:type:`chip_info<gpiochip_info>` to be populated.
> +
> +Description
> +===========
> +
> +Gets the publicly available information for a particular GPIO chip.
> +
> +Return Value
> +============
> +
> +On success 0 and ``info`` is populated with the chip info.
> +
> +On error -1 and the ``errno`` variable is set appropriately.
> +Common error codes are described in error-codes.rst.
> diff --git a/Documentation/userspace-api/gpio/gpio-get-lineinfo-unwatch-ioctl.rst b/Documentation/userspace-api/gpio/gpio-get-lineinfo-unwatch-ioctl.rst
> new file mode 100644
> index 000000000000..ba6f9d00a40b
> --- /dev/null
> +++ b/Documentation/userspace-api/gpio/gpio-get-lineinfo-unwatch-ioctl.rst
> @@ -0,0 +1,47 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _GPIO_GET_LINEINFO_UNWATCH_IOCTL:
> +
> +*******************************
> +GPIO_GET_LINEINFO_UNWATCH_IOCTL
> +*******************************
> +
> +Name
> +====
> +
> +GPIO_GET_LINEINFO_UNWATCH_IOCTL - Disable watching a line for changes to its
> +requested state and configuration information.
> +
> +Synopsis
> +========
> +
> +.. c:macro:: GPIO_GET_LINEINFO_UNWATCH_IOCTL
> +
> +``int ioctl(int chip_fd, GPIO_GET_LINEINFO_UNWATCH_IOCTL, u32 *offset)``
> +
> +Arguments
> +=========
> +
> +``chip_fd``
> +    The file descriptor of the GPIO character device returned by `open()`.
> +
> +``offset``
> +    The offset of the line to no longer watch.
> +
> +Description
> +===========
> +
> +Remove the line from the list of lines being watched on this ``chip_fd``.
> +
> +This is the opposite of gpio-v2-get-lineinfo-watch-ioctl.rst (v2) and
> +gpio-get-lineinfo-watch-ioctl.rst (v1).
> +
> +Unwatching a line that is not watched is an error (**EBUSY**).
> +
> +Return Value
> +============
> +
> +On success 0.
> +
> +On error -1 and the ``errno`` variable is set appropriately.
> +Common error codes are described in error-codes.rst.
> diff --git a/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst b/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
> new file mode 100644
> index 000000000000..4259c08779c1
> --- /dev/null
> +++ b/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
> @@ -0,0 +1,99 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _GPIO_V2_GET_LINE_IOCTL:
> +
> +**********************
> +GPIO_V2_GET_LINE_IOCTL
> +**********************
> +
> +Name
> +====
> +
> +GPIO_V2_GET_LINE_IOCTL - Request a line or lines from the kernel.
> +
> +Synopsis
> +========
> +
> +.. c:macro:: GPIO_V2_GET_LINE_IOCTL
> +
> +``int ioctl(int chip_fd, GPIO_V2_GET_LINE_IOCTL, struct gpio_v2_line_request *request)``
> +
> +Arguments
> +=========
> +
> +``chip_fd``
> +    The file descriptor of the GPIO character device returned by `open()`.
> +
> +``request``
> +    The :c:type:`line_request<gpio_v2_line_request>` specifying the lines
> +    to request and their configuration.
> +
> +Description
> +===========
> +
> +On success, the requesting process is granted exclusive access to the line
> +value, write access to the line configuration, and may receive events when
> +edges are detected on the line, all of which are described in more detail in
> +:ref:`gpio-v2-line-request`.
> +
> +A number of lines may be requested in the one line request, and request
> +operations are performed on the requested lines by the kernel as atomically
> +as possible. e.g. gpio-v2-line-get-values-ioctl.rst will read all the
> +requested lines at once.
> +
> +The state of a line, including the value of output lines, is guaranteed to
> +remain as requested until the returned file descriptor is closed. Once the
> +file descriptor is closed, the state of the line becomes uncontrolled from
> +the userspace perspective, and may revert to its default state.

At the behest of the line driver? (an example of a line driver that
has good reason
for reverting might be useful here, to indicate that in the general
case the user
cannot assume the state of unclaimed lines)

> +
> +Closing the ``chip_fd`` has no effect on existing line requests.
> +
> +.. _gpio-v2-get-line-config-rules:
> +
> +Configuration Rules
> +-------------------
> +
> +For any given requested line, the following configuration rules apply:
> +
> +The direction flags, ``GPIO_V2_LINE_FLAG_INPUT`` and
> +``GPIO_V2_LINE_FLAG_OUTPUT``, cannot be combined. If neither are set then
> +the only other flag that may be set is ``GPIO_V2_LINE_FLAG_ACTIVE_LOW``
> +and the line is requested "as-is" to allow reading of the line value
> +without altering the electrical configuration.
> +
> +The drive flags, ``GPIO_V2_LINE_FLAG_OPEN_xxx``, require the
> +``GPIO_V2_LINE_FLAG_OUTPUT`` to be set.
> +Only one drive flag may be set.
> +If none are set then the line is assumed push-pull.
> +
> +Only one bias flag, ``GPIO_V2_LINE_FLAG_BIAS_xxx``, may be set, and it
> +requires a direction flag to also be set.
> +If no bias flags are set then the bias configuration is not changed.
> +
> +The edge flags, ``GPIO_V2_LINE_FLAG_EDGE_xxx``, require
> +``GPIO_V2_LINE_FLAG_INPUT`` to be set and may be combined to detect both rising
> +and falling edges.
> +
> +Only one event clock flag, ``GPIO_V2_LINE_FLAG_EVENT_CLOCK_xxx``, may be set.
> +If none are set then the event clock defaults to ``CLOCK_MONOTONIC``.
> +The ``GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE`` flag requires supporting hardware
> +and a kernel with ``CONFIG_HTE`` set.  Requesting HTE from a device that
> +doesn't support it is an error (**EOPNOTSUP**).
> +
> +The :c:type:`debounce_period_us<gpio_v2_line_attribute>` attribute may only
> +be applied to lines with ``GPIO_V2_LINE_FLAG_INPUT`` set. When set, debounce
> +applies to both the values returned by gpio-v2-line-get-values-ioctl.rst and
> +the edges returned by gpio-v2-line-event-read.rst.  If not
> +supported directly by hardware, the debouncing is performed in software by the
> +kernel.
> +
> +Requesting an invalid configuration is an error (**EINVAL**).
> +
> +Return Value
> +============
> +
> +On success 0 and the :c:type:`request.fd<gpio_v2_line_request>` contains the
> +file descriptor for the request.
> +
> +On error -1 and the ``errno`` variable is set appropriately.
> +Common error codes are described in error-codes.rst.
> diff --git a/Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-ioctl.rst b/Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-ioctl.rst
> new file mode 100644
> index 000000000000..bc4d8df887d4
> --- /dev/null
> +++ b/Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-ioctl.rst
> @@ -0,0 +1,50 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _GPIO_V2_GET_LINEINFO_IOCTL:
> +
> +**************************
> +GPIO_V2_GET_LINEINFO_IOCTL
> +**************************
> +
> +Name
> +====
> +
> +GPIO_V2_GET_LINEINFO_IOCTL - Get the publicly available information for a line.
> +
> +Synopsis
> +========
> +
> +.. c:macro:: GPIO_V2_GET_LINEINFO_IOCTL
> +
> +``int ioctl(int chip_fd, GPIO_V2_GET_LINEINFO_IOCTL, struct gpio_v2_line_info *info)``
> +
> +Arguments
> +=========
> +
> +``chip_fd``
> +    The file descriptor of the GPIO character device returned by `open()`.
> +
> +``info``
> +    The :c:type:`line_info<gpio_v2_line_info>` to be populated, with the
> +    ``offset`` field set to indicate the line to be collected.
> +
> +Description
> +===========
> +
> +Get the publicly available information for a line.
> +
> +This information is available independent of whether the line is in use.
> +
> +.. note::
> +    The line info does not include the line value.
> +
> +    The line must be requested using gpio-v2-get-line-ioctl.rst to access its
> +    value.
> +
> +Return Value
> +============
> +
> +On success 0 and ``info`` is populated with the chip info.
> +
> +On error -1 and the ``errno`` variable is set appropriately.
> +Common error codes are described in error-codes.rst.
> diff --git a/Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-watch-ioctl.rst b/Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-watch-ioctl.rst
> new file mode 100644
> index 000000000000..938ff85a9322
> --- /dev/null
> +++ b/Documentation/userspace-api/gpio/gpio-v2-get-lineinfo-watch-ioctl.rst
> @@ -0,0 +1,67 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _GPIO_V2_GET_LINEINFO_WATCH_IOCTL:
> +
> +********************************
> +GPIO_V2_GET_LINEINFO_WATCH_IOCTL
> +********************************
> +
> +Name
> +====
> +
> +GPIO_V2_GET_LINEINFO_WATCH_IOCTL - Enable watching a line for changes to its
> +request state and configuration information.
> +
> +Synopsis
> +========
> +
> +.. c:macro:: GPIO_V2_GET_LINEINFO_WATCH_IOCTL
> +
> +``int ioctl(int chip_fd, GPIO_V2_GET_LINEINFO_WATCH_IOCTL, struct gpio_v2_line_info *info)``
> +
> +Arguments
> +=========
> +
> +``chip_fd``
> +    The file descriptor of the GPIO character device returned by `open()`.
> +
> +``info``
> +    The :c:type:`line_info<gpio_v2_line_info>` struct to be populated, with
> +    the ``offset`` set to indicate the line to watch
> +
> +Description
> +===========
> +
> +Enable watching a line for changes to its request state and configuration
> +information. Changes to line info include a line being requested, released
> +or reconfigured.
> +
> +.. note::
> +    Watching line info is not generally required, and would typically only be
> +    used by a system monitoring component.
> +
> +    The line info does NOT include the line value.
> +    The line must be requested using gpio-v2-get-line-ioctl.rst to access
> +    its value, and the line request can monitor a line for events using
> +    gpio-v2-line-event-read.rst.
> +
> +By default all lines are unwatched when the GPIO chip is opened.
> +
> +Multiple lines may be watched simultaneously by adding a watch for each.
> +
> +Once a watch is set, any changes to line info will generate events which can be
> +read from the ``chip_fd`` as described in
> +gpio-v2-lineinfo-changed-read.rst.
> +
> +Adding a watch to a line that is already watched is an error (**EBUSY**).
> +
> +Watches are specific to the ``chip_fd`` and are independent of watches
> +on the same GPIO chip opened with a separate call to `open()`.
> +
> +Return Value
> +============
> +
> +On success 0 and ``info`` is populated with the current line info.
> +
> +On error -1 and the ``errno`` variable is set appropriately.
> +Common error codes are described in error-codes.rst.
> diff --git a/Documentation/userspace-api/gpio/gpio-v2-line-event-read.rst b/Documentation/userspace-api/gpio/gpio-v2-line-event-read.rst
> new file mode 100644
> index 000000000000..6513c23fb7ca
> --- /dev/null
> +++ b/Documentation/userspace-api/gpio/gpio-v2-line-event-read.rst
> @@ -0,0 +1,83 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _GPIO_V2_LINE_EVENT_READ:
> +
> +***********************
> +GPIO_V2_LINE_EVENT_READ
> +***********************
> +
> +Name
> +====
> +
> +GPIO_V2_LINE_EVENT_READ - Read edge detection events for lines from a request.
> +
> +Synopsis
> +========
> +
> +``int read(int req_fd, void *buf, size_t count)``
> +
> +Arguments
> +=========
> +
> +``req_fd``
> +    The file descriptor of the GPIO character device, as returned in the
> +    :c:type:`request.fd<gpio_v2_line_request>` by gpio-v2-get-line-ioctl.rst.
> +
> +``buf``
> +    The buffer to contain the :c:type:`events<gpio_v2_line_event>`.
> +
> +``count``
> +    The number of bytes available in ``buf``, which must be at
> +    least the size of a :c:type:`gpio_v2_line_event`.
> +
> +Description
> +===========
> +
> +Read edge detection events for lines from a request.
> +
> +Edge detection must be enabled for the input line using either
> +``GPIO_V2_LINE_FLAG_EDGE_RISING`` or ``GPIO_V2_LINE_FLAG_EDGE_FALLING``, or
> +both. Edge events are then generated whenever edge interrupts are detected on
> +the input line.
> +
> +The kernel captures and timestamps edge events as close as possible to their
> +occurrence and stores them in a buffer from where they can be read by
> +userspace at its convenience using `read()`.
> +
> +Events read from the buffer are always in the same order that they were
> +detected by the kernel, including when multiple lines are being monitored by
> +the one request.
> +
> +The size of the kernel event buffer is fixed at the time of line request
> +creation, and can be influenced by the
> +:c:type:`request.event_buffer_size<gpio_v2_line_request>`.
> +The default size is 16 times the number of lines requested.

This might explain why I could never quite get high-speed pulse counting to feel
right. Thank you!

> +
> +The buffer may overflow if bursts of events occur quicker than they are read
> +by userspace. If an overflow occurs then the oldest buffered event is
> +discarded. Overflow can be detected from userspace by monitoring the event
> +sequence numbers.
> +
> +To minimize the number of calls required to copy events from the kernel to
> +userspace, `read()` supports copying multiple events. The number of events
> +copied is the lower of the number available in the kernel buffer and the
> +number that will fit in the userspace buffer (``buf``).
> +
> +Changing the edge detection flags using gpio-v2-line-set-config-ioctl.rst
> +does not remove or modify the events already contained in the kernel event
> +buffer.
> +
> +The `read()` will block if no event is available and the ``req_fd`` has not
> +been set **O_NONBLOCK**.
> +
> +The presence of an event can be tested for by checking that the ``req_fd`` is
> +readable using `poll()` or an equivalent.
> +
> +Return Value
> +============
> +
> +On success the number of bytes read, which will be a multiple of the size of a
> +:c:type:`gpio_v2_line_event` event.
> +
> +On error -1 and the ``errno`` variable is set appropriately.
> +Common error codes are described in error-codes.rst.
> diff --git a/Documentation/userspace-api/gpio/gpio-v2-line-get-values-ioctl.rst b/Documentation/userspace-api/gpio/gpio-v2-line-get-values-ioctl.rst
> new file mode 100644
> index 000000000000..e4e74a1926d8
> --- /dev/null
> +++ b/Documentation/userspace-api/gpio/gpio-v2-line-get-values-ioctl.rst
> @@ -0,0 +1,51 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _GPIO_V2_LINE_GET_VALUES_IOCTL:
> +
> +*****************************
> +GPIO_V2_LINE_GET_VALUES_IOCTL
> +*****************************
> +
> +Name
> +====
> +
> +GPIO_V2_LINE_GET_VALUES_IOCTL - Get the values of requested lines.
> +
> +Synopsis
> +========
> +
> +.. c:macro:: GPIO_V2_LINE_GET_VALUES_IOCTL
> +
> +``int ioctl(int req_fd, GPIO_V2_LINE_GET_VALUES_IOCTL, struct gpio_v2_line_values *values)``
> +
> +Arguments
> +=========
> +
> +``req_fd``
> +    The file descriptor of the GPIO character device, as returned in the
> +    :c:type:`request.fd<gpio_v2_line_request>` by gpio-v2-get-line-ioctl.rst.
> +
> +``values``
> +    The :c:type:`line_values<gpio_v2_line_values>` to get with the ``mask`` set
> +    to indicate the subset of requested lines to get.
> +
> +Description
> +===========
> +
> +Get the values of requested lines.
> +
> +The values of both input and output lines may be read.
> +
> +For output lines, the value returned is driver and configuration dependent and
> +may be either the output buffer (the last requested value set) or the input
> +buffer (the actual level of the line), and depending on the hardware and
> +configuration these may differ.
> +
> +Return Value
> +============
> +
> +On success 0 and the corresponding :c:type:`values.bits<gpio_v2_line_values>`
> +contain the value read.
> +
> +On error -1 and the ``errno`` variable is set appropriately.
> +Common error codes are described in error-codes.rst.
> diff --git a/Documentation/userspace-api/gpio/gpio-v2-line-set-config-ioctl.rst b/Documentation/userspace-api/gpio/gpio-v2-line-set-config-ioctl.rst
> new file mode 100644
> index 000000000000..126c2626ba6b
> --- /dev/null
> +++ b/Documentation/userspace-api/gpio/gpio-v2-line-set-config-ioctl.rst
> @@ -0,0 +1,57 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _GPIO_V2_LINE_SET_CONFIG_IOCTL:
> +
> +*****************************
> +GPIO_V2_LINE_SET_CONFIG_IOCTL
> +*****************************
> +
> +Name
> +====
> +
> +GPIO_V2_LINE_SET_CONFIG_IOCTL - Update the configuration of previously requested lines.
> +
> +Synopsis
> +========
> +
> +.. c:macro:: GPIO_V2_LINE_SET_CONFIG_IOCTL
> +
> +``int ioctl(int req_fd, GPIO_V2_LINE_SET_CONFIG_IOCTL, struct gpio_v2_line_config *config)``
> +
> +Arguments
> +=========
> +
> +``req_fd``
> +    The file descriptor of the GPIO character device, as returned in the
> +    :c:type:`request.fd<gpio_v2_line_request>` by gpio-v2-get-line-ioctl.rst.
> +
> +``config``
> +    The new :c:type:`configuration<gpio_v2_line_config>` to apply to the
> +    requested lines.
> +
> +Description
> +===========
> +
> +Update the configuration of previously requested lines, without releasing the
> +line or introducing potential glitches.

Is this guaranteed by all line drivers?

> +
> +The new configuration must specify the configuration of all requested lines.
> +
> +The same :ref:`gpio-v2-get-line-config-rules` that apply when requesting the lines
> +also apply when updating the line configuration.
> +
> +The motivating use case for this command is changing direction of
> +bi-directional lines between input and output, but it may also be used to
> +dynamically control edge detection, or more generally move lines seamlessly
> +from one configuration state to another.
> +
> +To only change the value of output lines, use
> +gpio-v2-line-set-values-ioctl.rst.
> +
> +Return Value
> +============
> +
> +On success 0.
> +
> +On error -1 and the ``errno`` variable is set appropriately.
> +Common error codes are described in error-codes.rst.
> diff --git a/Documentation/userspace-api/gpio/gpio-v2-line-set-values-ioctl.rst b/Documentation/userspace-api/gpio/gpio-v2-line-set-values-ioctl.rst
> new file mode 100644
> index 000000000000..6d2d1886950b
> --- /dev/null
> +++ b/Documentation/userspace-api/gpio/gpio-v2-line-set-values-ioctl.rst
> @@ -0,0 +1,47 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _GPIO_V2_LINE_SET_VALUES_IOCTL:
> +
> +*****************************
> +GPIO_V2_LINE_SET_VALUES_IOCTL
> +*****************************
> +
> +Name
> +====
> +
> +GPIO_V2_LINE_SET_VALUES_IOCTL - Set the values of requested output lines.
> +
> +Synopsis
> +========
> +
> +.. c:macro:: GPIO_V2_LINE_SET_VALUES_IOCTL
> +
> +``int ioctl(int req_fd, GPIO_V2_LINE_SET_VALUES_IOCTL, struct gpio_v2_line_values *values)``
> +
> +Arguments
> +=========
> +
> +``req_fd``
> +    The file descriptor of the GPIO character device, as returned in the
> +    :c:type:`request.fd<gpio_v2_line_request>` by gpio-v2-get-line-ioctl.rst.
> +
> +``values``
> +    The :c:type:`line_values<gpio_v2_line_values>` to set with the ``mask`` set
> +    to indicate the subset of requested lines to set and ``bits`` set to
> +    indicate the new value.
> +
> +Description
> +===========
> +
> +Set the values of requested output lines.
> +
> +Only the values of output lines may be set.
> +Attempting to set the value of an input line is an error (**EPERM**).

User beware if they come from some cursed ecosystem where writing a value
to an input line sets or enables/disables the bias,

eg: https://www.arduino.cc/reference/en/language/functions/digital-io/digitalwrite/

> +
> +Return Value
> +============
> +
> +On success 0.
> +
> +On error -1 and the ``errno`` variable is set appropriately.
> +Common error codes are described in error-codes.rst.
> diff --git a/Documentation/userspace-api/gpio/gpio-v2-lineinfo-changed-read.rst b/Documentation/userspace-api/gpio/gpio-v2-lineinfo-changed-read.rst
> new file mode 100644
> index 000000000000..24ad325e7253
> --- /dev/null
> +++ b/Documentation/userspace-api/gpio/gpio-v2-lineinfo-changed-read.rst
> @@ -0,0 +1,81 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _GPIO_V2_LINEINFO_CHANGED_READ:
> +
> +*****************************
> +GPIO_V2_LINEINFO_CHANGED_READ
> +*****************************
> +
> +Name
> +====
> +
> +GPIO_V2_LINEINFO_CHANGED_READ - Read line info changed events for watched
> +lines from the chip.
> +
> +Synopsis
> +========
> +
> +``int read(int chip_fd, void *buf, size_t count)``
> +
> +Arguments
> +=========
> +
> +``chip_fd``
> +    The file descriptor of the GPIO character device returned by `open()`.
> +
> +``buf``
> +    The buffer to contain the :c:type:`events<gpio_v2_line_info_changed>`.
> +
> +``count``
> +    The number of bytes available in ``buf``, which must be at least the size
> +    of a :c:type:`gpio_v2_line_info_changed` event.
> +
> +Description
> +===========
> +
> +Read line info changed events for watched lines from the chip.
> +
> +.. note::
> +    Monitoring line info changes is not generally required, and would typically
> +    only be performed by a system monitoring component.
> +
> +    These events relate to changes in a line's request state or configuration,
> +    not its value. Use gpio-v2-line-event-read.rst to receive events when a
> +    line changes value.
> +
> +A line must be watched using gpio-v2-get-lineinfo-watch-ioctl.rst to generate
> +info changed events.  Subsequently, a request, release, or reconfiguration
> +of the line will generate an info changed event.
> +
> +The kernel timestamps events when they occur and stores them in a buffer
> +from where they can be read by userspace at its convenience using `read()`.
> +
> +The size of the kernel event buffer is fixed at 32 events per ``chip_fd``.
> +
> +The buffer may overflow if bursts of events occur quicker than they are read
> +by userspace. If an overflow occurs then the most recent event is discarded.
> +Overflow cannot be detected from userspace.
> +
> +Events read from the buffer are always in the same order that they were
> +detected by the kernel, including when multiple lines are being monitored by
> +the one ``chip_fd``.
> +
> +To minimize the number of calls required to copy events from the kernel to
> +userspace, `read()` supports copying multiple events. The number of events
> +copied is the lower of the number available in the kernel buffer and the
> +number that will fit in the userspace buffer (``buf``).
> +
> +A `read()` will block if no event is available and the ``chip_fd`` has not
> +been set **O_NONBLOCK**.
> +
> +The presence of an event can be tested for by checking that the ``chip_fd`` is
> +readable using `poll()` or an equivalent.
> +
> +Return Value
> +============
> +
> +On success the number of bytes read, which will be a multiple of the size
> +of a :c:type:`gpio_v2_line_info_changed` event.
> +
> +On error -1 and the ``errno`` variable is set appropriately.
> +Common error codes are described in error-codes.rst.
> diff --git a/Documentation/userspace-api/gpio/index.rst b/Documentation/userspace-api/gpio/index.rst
> new file mode 100644
> index 000000000000..072b9fa18aea
> --- /dev/null
> +++ b/Documentation/userspace-api/gpio/index.rst
> @@ -0,0 +1,17 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====
> +GPIO
> +====
> +
> +.. toctree::
> +    :maxdepth: 1
> +
> +    Character Device Userspace API <chardev>
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   =======
> +
> +   * :ref:`genindex`
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index 031df47a7c19..8e174a605f69 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -25,6 +25,7 @@ place where this information is gathered.
>     dma-buf-alloc-exchange
>     ebpf/index
>     ELF
> +   gpio/index
>     ioctl/index
>     iommu
>     iommufd
> --
> 2.39.2
>
>


-- 
Philip Howard

