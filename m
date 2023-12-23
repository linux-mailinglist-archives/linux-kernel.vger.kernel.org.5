Return-Path: <linux-kernel+bounces-10255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B5A81D1CE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BF91F215AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1035664;
	Sat, 23 Dec 2023 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y5rQmPA/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0974A3C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 03:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67f848f38c4so13316136d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 19:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703301083; x=1703905883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdB95tcPTNTK+3756tuniTgYUz4rjOim6SidLwlZH4M=;
        b=Y5rQmPA/yke5O8eu2GCJhQb+SXpxNN2RM+rDaW1VPEvb8W+z2u/Lfd1W3hx9ZIbfJh
         /NDxMjwWxz92leORnW7EKRrP7QZ+446Yx1v6Ao7p1W4+UUZkGJa80yRKfu1cNVF3IXeB
         ECQUXncg1XJC0cQzjvySQ3IoxoTupHdt7MZac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703301083; x=1703905883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdB95tcPTNTK+3756tuniTgYUz4rjOim6SidLwlZH4M=;
        b=Z8B79UsCgKDuq5o5YJpxnQL08/pdpmN2/qvzEUUL8miVcweW3FCb9b0HQw3P/7068x
         dvUJ65FdmEjiB6Mvx25AkvC4oDPjbkbFd6xTlj7CUTMvEOxlWQCEnnf/rq9ybE69rWPy
         iHiGTUM4sGkJCb+S0w8MI7TSbbxs//MkQzvCAMNeSPo6zAX7YxTjgs7CBh+0KXrZfuXq
         2D6oiDCqFwx+uN9lOUZTp1xLTEtiond7QNYBmrKrLc58I4szTMRJnZ6+8fTyME80kvET
         HNe9kUrWTHePol2Vm+1arWBTGwuJVyoARamdqgGNx7sN/2+mcGlqgo+s+IJVUc4pvTz2
         inZg==
X-Gm-Message-State: AOJu0YwEUVbp+GqQ5wt8F/fOMtNpuBjOhpygtgApy5Zt5qPnFYMacHJL
	R4DEoe57qj/hj16xwgpjmU4D5JuQwKq4douLN4mnKA2GOuDx
X-Google-Smtp-Source: AGHT+IEFXIQyeySBlTmbcC7JEzlV/6XXt89+GaVfOEdtXDERfikf8LLPBcse2GmVVO3swktMcuaw1HSP6jN5pWYvF74=
X-Received: by 2002:a05:6214:e63:b0:67f:27a3:4d0e with SMTP id
 jz3-20020a0562140e6300b0067f27a34d0emr3733532qvb.54.1703301082855; Fri, 22
 Dec 2023 19:11:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220165423.v2.22.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
 <202312230846.9DkpFRNv-lkp@intel.com>
In-Reply-To: <202312230846.9DkpFRNv-lkp@intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Fri, 22 Dec 2023 20:11:12 -0700
Message-ID: <CANg-bXCsB1cfRqsY4yx9X9_5GG1O+9jT0uDX6hJfj7fCRiVg+Q@mail.gmail.com>
Subject: Re: [PATCH v2 22/22] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
To: kernel test robot <lkp@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, oe-kbuild-all@lists.linux.dev, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>, Raul Rangel <rrangel@chromium.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Benson Leung <bleung@chromium.org>, Bhanu Prakash Maiya <bhanumaiya@chromium.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Guenter Roeck <groeck@chromium.org>, Lee Jones <lee@kernel.org>, 
	Prashant Malani <pmalani@chromium.org>, Rob Barnes <robbarnes@google.com>, 
	Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 5:37=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Mark,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on chrome-platform/for-next chrome-platform/for-fi=
rmware-next wsa/i2c/for-next driver-core/driver-core-testing driver-core/dr=
iver-core-next driver-core/driver-core-linus linus/master v6.7-rc6 next-202=
31222]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Hasemeyer/gpi=
olib-acpi-Modify-acpi_dev_irq_wake_get_by-to-use-resource/20231222-172104
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git fo=
r-next
> patch link:    https://lore.kernel.org/r/20231220165423.v2.22.Ieee574a0e9=
4fbaae01fd6883ffe2ceeb98d7df28%40changeid
> patch subject: [PATCH v2 22/22] platform/chrome: cros_ec: Use PM subsyste=
m to manage wakeirq
> config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20231=
223/202312230846.9DkpFRNv-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231223/202312230846.9DkpFRNv-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312230846.9DkpFRNv-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/device/driver.h:21,
>                     from include/linux/device.h:32,
>                     from include/linux/acpi.h:14,
>                     from drivers/platform/chrome/cros_ec_lpc.c:14:
> >> include/linux/module.h:244:1: error: expected ',' or ';' before 'exter=
n'
>      244 | extern typeof(name) __mod_##type##__##name##_device_table     =
          \
>          | ^~~~~~
>    drivers/platform/chrome/cros_ec_lpc.c:67:1: note: in expansion of macr=
o 'MODULE_DEVICE_TABLE'
>       67 | MODULE_DEVICE_TABLE(dmi, untrusted_fw_irq_wake_capable);
>          | ^~~~~~~~~~~~~~~~~~~
>
>
> vim +244 include/linux/module.h
>
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  240
> cff26a51da5d20 Rusty Russell     2014-02-03  241  #ifdef MODULE
> cff26a51da5d20 Rusty Russell     2014-02-03  242  /* Creates an alias so =
file2alias.c can find device table. */
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  243  #define MODULE_DEVICE_T=
ABLE(type, name)                                       \
> 0bf8bf50eddc75 Matthias Kaehlcke 2017-07-24 @244  extern typeof(name) __m=
od_##type##__##name##_device_table             \
> cff26a51da5d20 Rusty Russell     2014-02-03  245    __attribute__ ((unuse=
d, alias(__stringify(name))))
> cff26a51da5d20 Rusty Russell     2014-02-03  246  #else  /* !MODULE */
> cff26a51da5d20 Rusty Russell     2014-02-03  247  #define MODULE_DEVICE_T=
ABLE(type, name)
> cff26a51da5d20 Rusty Russell     2014-02-03  248  #endif
> ^1da177e4c3f41 Linus Torvalds    2005-04-16  249
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Failed for riscv arch. Regardless, MODULE_DEVICE_TABLE macro call is
being removed in the next version.

