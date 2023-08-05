Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87692771134
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjHESAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHESAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:00:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E439183;
        Sat,  5 Aug 2023 11:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B9EF60B99;
        Sat,  5 Aug 2023 18:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80C0C433C8;
        Sat,  5 Aug 2023 18:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691258436;
        bh=4OB0LIsIuMwZCxSV0QuHTkdvl8z1YvtMFoPcoJgVuiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZxNoetshNaW9M7ViwOc/cCpVU9y5ak8RsVNGta57besr7s4NoxxH/dndsemD5RjLe
         o/k0TYBfQ6fnyzMM5RDhVIv7MV98iPK+MdcfHYjh/OdBi1cEi5oCDG/fA1vOh4t6Cd
         n0Y6Fz6cF3apXUP9pcTeLc78XlWP1cO9kkH+pJo62dX1PDvzlngzJ2OPaN5840g2f4
         V4gSJY0qz4oo+/eMKmrm0e79OAj5W4MR/YHRinV/8a3OOCBQqOz4mfjKGn+xQ0Zzm2
         ItJQnGtDCkCK3EoMD/CfB8y8iAibHjZ1jsNhxxVVLYZNZq7kcTKQaQHGHYlkC6SeXM
         S+4WvKmyvN3yA==
Date:   Sat, 5 Aug 2023 11:03:33 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 13/25] samples: Add sample userspace Gunyah VM Manager
Message-ID: <3krirzh2fojye44a7trzit54opfssnzzsujbo4kzv2mqzhpsmo@qrm53c5naaqw>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-14-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-14-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:41AM -0700, Elliot Berman wrote:
> diff --git a/samples/gunyah/gunyah_vmm.c b/samples/gunyah/gunyah_vmm.c
> new file mode 100644
> index 0000000000000..6f636ac227c69
> --- /dev/null
> +++ b/samples/gunyah/gunyah_vmm.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <sys/ioctl.h>
> +#include <getopt.h>
> +#include <limits.h>
> +#include <stdint.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <sys/sysmacros.h>
> +#define __USE_GNU
> +#include <sys/mman.h>
> +
> +#include <linux/gunyah.h>
> +
> +#define DEFAULT_GUEST_BASE	0x80000000
> +#define DEFAULT_GUEST_SIZE	0x6400000 /* 100 MiB */
> +#define DEFAULT_DTB_OFFSET	0x45f0000 /* 70MiB - 64 KiB */
> +#define DEFAULT_RAMDISK_OFFSET	0x4600000 /* 70MiB */

Would be nice if the default ramdisk offset was close to accounting for
the kernel modules produced in an upstream defconfig build... Perhaps
just bumping the default guest size to facilitate this?

[..]
> diff --git a/samples/gunyah/sample_vm.dts b/samples/gunyah/sample_vm.dts
> new file mode 100644
> index 0000000000000..293bbc0469c8f
> --- /dev/null
> +++ b/samples/gunyah/sample_vm.dts
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	interrupt-parent = <&intc>;
> +
> +	chosen {
> +		bootargs = "nokaslr";

Is this required?

> +	};
> +
> +	cpus {
> +		#address-cells = <0x2>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,armv8";
> +			reg = <0 0>;
> +		};
> +	};
> +
> +	intc: interrupt-controller@3FFF0000 {
> +		compatible = "arm,gic-v3";
> +		#interrupt-cells = <3>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		interrupt-controller;
> +		reg = <0 0x3FFF0000 0 0x10000>,
> +		      <0 0x3FFD0000 0 0x20000>;

Lowercase hex digits please.

> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		always-on;
> +		interrupts = <1 13 0x108>,
> +			     <1 14 0x108>,
> +			     <1 11 0x108>,
> +			     <1 10 0x108>;
> +		clock-frequency = <19200000>;
> +	};
> +
> +	gunyah-vm-config {

Is this node documented somewhere?

Regards,
Bjorn

> +		image-name = "linux_vm_0";
> +
> +		memory {
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +
> +			base-address = <0 0x80000000>;
> +		};
> +
> +		interrupts {
> +			config = <&intc>;
> +		};
> +
> +		vcpus {
> +			affinity-map = < 0 >;
> +			sched-priority = < (-1) >;
> +			sched-timeslice = < 2000 >;
> +		};
> +	};
> +};
> -- 
> 2.40.0
> 
