Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E2A76CC75
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjHBMSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjHBMST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:18:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BFC269D;
        Wed,  2 Aug 2023 05:18:14 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690978692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bMAneZp3OckYjyE32V73PiGzEMsgoPXCBUkh4CsnmoU=;
        b=w3ThA7Z06zmpY68gr+ESi4ZA/mC3537QiRzz6v6ozvn3HuQiIJ2ksA3J++l+F9MwQKyBdy
        cHA126rZVZnUofpwO4HJyjfE4zvv6wGjuYqKqpVjSkfehc8+ZmcPtPyFyKHiQ7DKeDoaBH
        myzoKh8CUDjSJmhz9UWlpc5v8yEvS/dTrBu1rErjIxqzd1XuYYxe7FK3PmV9Xgk7iikpnv
        nxyPMnGyyZ6Mf38kzIS6lcYClILMH+kczPtJ9JinQRVtKpkuCPI/dQGhUiCy4I9V2N6cBV
        91P0WnRwJ8zl4Z6hh7O3qJ7dAi9JcFp8NejJP7CM2h9rk276exwwPJa21TP1kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690978692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bMAneZp3OckYjyE32V73PiGzEMsgoPXCBUkh4CsnmoU=;
        b=wNFbAxGuBxg98WB6+t3Oe71370gKrw7ZsemKYB400LiMLrfeCeygtP6DuZP4VJM9k7Ym9V
        JNUVjJaVCTGH1wDw==
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: Re: [PATCH v3 net-next 06/10] net: ptp: create a mock-up PTP
 Hardware Clock driver
In-Reply-To: <20230801182421.1997560-7-vladimir.oltean@nxp.com>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
 <20230801182421.1997560-7-vladimir.oltean@nxp.com>
Date:   Wed, 02 Aug 2023 14:18:10 +0200
Message-ID: <87cz05k58d.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

this looks good. One question below.

On Tue Aug 01 2023, Vladimir Oltean wrote:
> There are several cases where virtual net devices may benefit from
> having a PTP clock, and these have to do with testing. I can see at
> least netdevsim and veth as potential users of a common mock-up PTP
> hardware clock driver.
>
> The proposed idea is to create an object which emulates PTP clock
> operations on top of the unadjustable CLOCK_MONOTONIC_RAW plus a
> software-controlled time domain via a timecounter/cyclecounter and then
> link that PHC to the netdevsim device.
>
> The driver is fully functional for its intended purpose, and it
> successfully passes the PTP selftests.
>
> $ cd tools/testing/selftests/ptp/
> $ ./phc.sh /dev/ptp2
> TEST: settime                          [ OK ]
> TEST: adjtime                          [ OK ]
> TEST: adjfreq                          [ OK ]
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v2->v3:
> - split off ptp_mock into separate patch
> - fix ptp_mock compilation as a module
> - turn phc->lock into a global spinlock
> - drop bogus support for ptp_clock_register() ever returning NULL
> - add MAINTAINERS entry
> v1->v2: patch is new
>
>  MAINTAINERS              |   7 ++
>  drivers/ptp/Kconfig      |  11 +++
>  drivers/ptp/Makefile     |   1 +
>  drivers/ptp/ptp_mock.c   | 175 +++++++++++++++++++++++++++++++++++++++
>  include/linux/ptp_mock.h |  38 +++++++++
>  5 files changed, 232 insertions(+)
>  create mode 100644 drivers/ptp/ptp_mock.c
>  create mode 100644 include/linux/ptp_mock.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c4f95a9d03b9..164b7930f5d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17175,6 +17175,13 @@ F:	drivers/ptp/*
>  F:	include/linux/ptp_cl*
>  K:	(?:\b|_)ptp(?:\b|_)
>=20=20
> +PTP MOCKUP CLOCK SUPPORT
> +M:	Vladimir Oltean <vladimir.oltean@nxp.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/ptp/ptp_mock.c
> +F:	include/linux/ptp_mock.h
> +
>  PTP VIRTUAL CLOCK SUPPORT
>  M:	Yangbo Lu <yangbo.lu@nxp.com>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index 32dff1b4f891..ed9d97a032f1 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -155,6 +155,17 @@ config PTP_1588_CLOCK_IDTCM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called ptp_clockmatrix.
>=20=20
> +config PTP_1588_CLOCK_MOCK
> +	tristate "Mock-up PTP clock"
> +	depends on PTP_1588_CLOCK
> +	help
> +	  This driver offers a set of PTP clock manipulation operations over
> +	  the system monotonic time. It can be used by virtual network device
> +	  drivers to emulate PTP capabilities.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ptp_mock.
> +
>  config PTP_1588_CLOCK_VMW
>  	tristate "VMware virtual PTP clock"
>  	depends on ACPI && HYPERVISOR_GUEST && X86
> diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
> index 553f18bf3c83..dea0cebd2303 100644
> --- a/drivers/ptp/Makefile
> +++ b/drivers/ptp/Makefile
> @@ -16,6 +16,7 @@ ptp-qoriq-y				+=3D ptp_qoriq.o
>  ptp-qoriq-$(CONFIG_DEBUG_FS)		+=3D ptp_qoriq_debugfs.o
>  obj-$(CONFIG_PTP_1588_CLOCK_IDTCM)	+=3D ptp_clockmatrix.o
>  obj-$(CONFIG_PTP_1588_CLOCK_IDT82P33)	+=3D ptp_idt82p33.o
> +obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+=3D ptp_mock.o
>  obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+=3D ptp_vmw.o
>  obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+=3D ptp_ocp.o
>  obj-$(CONFIG_PTP_DFL_TOD)		+=3D ptp_dfl_tod.o
> diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ptp_mock.c
> new file mode 100644
> index 000000000000..1525aafca752
> --- /dev/null
> +++ b/drivers/ptp/ptp_mock.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2023 NXP
> + *
> + * Mock-up PTP Hardware Clock driver for virtual network devices
> + *
> + * Create a PTP clock which offers PTP time manipulation operations
> + * using a timecounter/cyclecounter on top of CLOCK_MONOTONIC_RAW.
> + */
> +
> +#include <linux/ptp_clock_kernel.h>
> +#include <linux/ptp_mock.h>
> +#include <linux/timecounter.h>
> +
> +/* Clamp scaled_ppm between -2,097,152,000 and 2,097,152,000,
> + * and thus "adj" between -68,719,476 and 68,719,476
> + */
> +#define MOCK_PHC_MAX_ADJ_PPB		32000000
> +/* Timestamps from ktime_get_raw() have 1 ns resolution, so the scale fa=
ctor
> + * (MULT >> SHIFT) needs to be 1. Pick SHIFT as 31 bits, which translates
> + * MULT(freq 0) into 0x80000000.
> + */
> +#define MOCK_PHC_CC_SHIFT		31
> +#define MOCK_PHC_CC_MULT		(1 << MOCK_PHC_CC_SHIFT)
> +#define MOCK_PHC_FADJ_SHIFT		9
> +#define MOCK_PHC_FADJ_DENOMINATOR	15625ULL
> +
> +/* The largest cycle_delta that timecounter_read_delta() can handle with=
out a
> + * 64-bit overflow during the multiplication with cc->mult, given the ma=
x "adj"
> + * we permit, is ~8.3 seconds. Make sure readouts are more frequent than=
 that.
> + */
> +#define MOCK_PHC_REFRESH_INTERVAL	(HZ * 5)
> +
> +#define info_to_phc(d) container_of((d), struct mock_phc, info)
> +
> +static DEFINE_SPINLOCK(mock_phc_lock);
> +
> +struct mock_phc {
> +	struct ptp_clock_info info;
> +	struct ptp_clock *clock;
> +	struct timecounter tc;
> +	struct cyclecounter cc;
> +};
> +
> +static u64 mock_phc_cc_read(const struct cyclecounter *cc)
> +{
> +	return ktime_to_ns(ktime_get_raw());

Maybe return ktime_get_raw_ns()?

> +}
> +
> +static int mock_phc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
> +{
> +	struct mock_phc *phc =3D info_to_phc(info);
> +	s64 adj;
> +
> +	adj =3D (s64)scaled_ppm << MOCK_PHC_FADJ_SHIFT;
> +	adj =3D div_s64(adj, MOCK_PHC_FADJ_DENOMINATOR);
> +
> +	spin_lock_bh(&mock_phc_lock);

Why spin_lock_bh()? What's executed in bh context here? The PTP aux
worker runs in thread context.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmTKSYITHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgmalD/0T4fNzGBAhSXGDvnb/llJaos7360ga
pc+sYaEa9wRcbZf+Q8fwg/cUsNd73a6weLS7SPlNzq3BOpzmL+nKC/fFj5DwSWB+
D8TJdIeugioy0OJQ/nhovu+32o4BDaRaP3sd4z2XyyvU4kuLBdRvRopX6sXc4lyf
Z+6GlOX0n96XSHqix4nv0HHj6iHRXWzbFvcXQBinJTJMY1WNzrdX+jpZ75X90J3a
BWPjiJ2v+N0KAzGA1eLf71lKhUnugIZjX85nbDqP/ZsOuSKTwk3+0+mtwchDHiL+
VWrtNTNseprLbBrgPD1Vm6o1KuxksEAvDEm/VQdkPI6s7/+trw4wJMP4+ASY36cj
J2H+Y4H1uIsOtjOCoFKghJMVRS8Vij4/YgbJVsExd+h4mQndiWmyOZTVcP+EwfOV
infkBmIPeXcjDsHd0Xw5d8GUYbcZeFSs8V90D9qeX2S773OZrpaKIWaU1BffGhZo
gCXzE5zNAPqJPcrQGrbnwk69IJ5Bhso19eU77xrNsbR3cBB3a3mASG0VqorfDmrk
mHq136FJ3U+W1bL+gNORu5I377DvDrbIoMYeywK9C+NF8X2jR9kYYoWnzVgQONEb
YOJwP9osD/3nKJVKjXwu+oJrY3bv4GWutDMFRMu3MfpTMopR36POg4nNSn+B6A/A
INKSRgt2BvMLAA==
=p7Jf
-----END PGP SIGNATURE-----
--=-=-=--
