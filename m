Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79596797DAB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbjIGVCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbjIGVCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:02:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746B11BD0;
        Thu,  7 Sep 2023 14:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1694120500; x=1694725300; i=fan.ni@gmx.us;
 bh=WrB5oiToAlymIiAhWyGaU1p6lSYTjk9xAiQGH/WXI80=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jvp7ga7QPDGkmkYBFw7d6Hsa1jN1rL21vpoyp7Nr20MfK+JJRSNqs9mdknj6rrKuylcSkX/
 ZK3soy9TmLTt0OhBryhsMplK7yHVpCDx6UwKTyxaXC1ai6rxdiQ7FlCOAzegv1YJWKOV9TAH7
 El0L0oUAqALblW94tAiVU1ySkMJcE0nHKVCVNBjlEmxsk7AWkbFgpjKvO07d+rZkpNZFwE1rr
 /WWrBhAD0yCBs3owmRAKe6ab6Cq3KRClmZsvMTuzuuuztqkLxHFGtqyg7eYrIwMDuOl1XnVsW
 eTAOE/tVrEKiNSUP8sqcsZmht0S1bIJSYDrj5kyxgxF4rW8gTbQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZktZ-1qAP4O3uRb-00WjCk; Thu, 07
 Sep 2023 23:01:40 +0200
Date:   Thu, 7 Sep 2023 14:01:27 -0700
From:   Fan Ni <fan.ni@gmx.us>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        a.manzanares@samsung.com, nmtadam.samsung@gmail.com,
        nifan@outlook.com
Subject: Re: [PATCH RFC v2 00/18] DCD: Add support for Dynamic Capacity
 Devices (DCD)
Message-ID: <ZPo6J3OsmD7YbYJs@debian>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
X-Provags-ID: V03:K1:pBQrDzrNcJp9ogGI8qSgQL9I//m97oj7R39Hy/5zl3Obfl5LGUb
 F2H2uNo4zPPYQ/J6AvQ27YDbHw9hgwjVxulNYfzlz4JBVxMarj1Zca4cIlRQIhGx5cJcXPO
 mYzdVxKnBWgpdoxL8qdpmXpitgD0BxhSFKG6y/pI36YRcf+HRskEWmPgsfsy9YwcwnMYEQU
 ssTbmD9vK7VIXHojLplDQ==
UI-OutboundReport: notjunk:1;M01:P0:AH+613zBNz4=;duW8UqZtLXKLDJyR3JAhwGVZNfi
 Z0ozNGXIRRxlt4fnA8M5nz1Mw8I/RRX/NfQHeFM6aYpuz6vztIzIhGa3tpAU/rI6Rz8EE/JZ9
 bYx/7+kqaRNhBKSXz4tNGRxKsgsIJYj0E4uBo6rhNNQ3vpxyJxJHR3zM/vh+/jQe+d+DM3uar
 hRJV3AtWDnxtsIdT1HA8QkN3haNdLELRCeO3LJdn8fReBIYuJcMc4nxmL7RUlBMdMHjqoPvbo
 /tglRR2kAChNx2K0on2FUgJEUPmtR6tlQgOpb79Om1Ovu0ntXmt3SViUSQyDfZzYGXgOOUVYi
 hR24ZZd9nTelak61aXJUWEJG3gAh5XJy1l4KXJ1NX2tSKdyY7bxKzB42U+A9Oyrip+CWl3YD1
 /82GCSoR5Gtf24Pt2af2ADREG1uROKH6qpmaDyTHv6X3jF7XkUNPlY+QAVZDE3lEtKMpZFTyt
 5k6kdV9R1WT575Nm0opV3OdSSg0QQXiJbzUDzcPIbXCVDZhGy0syLuy3LggOGx8Z0h4wJWXzc
 XtZ+5Mfkwvk2hqqjGuwKPe3k4Y6K9Xmv9L4MRx9bip9Oj8qrZ+sd2au8ttlYYa+B2AZxf32oU
 hg+v5Iafda16F/dCVLcSaHgP7CXanDFG5ytJy0hgDQcddkcagfVcEPCk78STUGEI2VbJMDWOx
 JOJJHx8w/J/+L3thuydmsdjkfyejJH8K2+yDQZ1/PLOFAwzn34FkXaDUa3hiXaBgYojobuoGq
 +Jg2hheC6RMrFcLTjMq0QDgd+ASi8mxYxE6m2j8KjrrFQyFSFdvP8ywDEZ0V4bSSZadUqSryy
 7iEThug/NWaA2YwNE6lOtk57eDFNTRdC5KeLvD/acwOgiEUSZCe2BWHiT+sgvyIjqtGFkAqZi
 kaUuQPyInEYUP4yztLOyxOaAjpz9Kq+1Mg3qV1/eenYLceZVcm1DB3EjT2zEDV3DK/nK4MyVf
 a1XjGHZ3R+vRgdAIyNf5pRJal6E=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:20:51PM -0700, Ira Weiny wrote:
> A Dynamic Capacity Device (DCD) (CXL 3.0 spec 9.13.3) is a CXL memory
> device that implements dynamic capacity.  Dynamic capacity feature
> allows memory capacity to change dynamically, without the need for
> resetting the device.
>
> Even though this is marked v2 by b4, this is effectively a whole new
> series for DCD support.  Quite a bit of the core support was completed
> by Navneet in [4].  However, the architecture through the CXL region,
> DAX region, and DAX Device layers is completely different.  Particular
> attention was paid to:
>
> 	1) managing skip resources in the hardware device
> 	2) ensuring the host OS only sent a release memory mailbox
> 	   response when all DAX devices are done using an extent
> 	3) allowing dax devices to span extents
> 	4) allowing dax devices to use parts of extents
>
> I could say all of the review comments from v1 are addressed but frankly
> the series has changed so much that I can't guarantee anything.
>
> The series continues to be based on the type-2 work posted from Dan.[2]
> However, my branch with that work is a bit dated.  Therefore I have
> posted this series on github here.[5]
>
> Testing was sped up with cxl-test and ndctl dcd support.  A preview of
> that work is on github.[6]  In addition Fan Ni's Qemu DCD series was
> used part of the time.[3]
>
> The major parts of this series are:
>
> - Get the dynamic capacity (DC) region information from cxl device
> - Configure device DC regions reported by hardware
> - Enhance CXL and DAX regions for DC
> 	a. maintain separation between the hardware extents and the CXL
> 	   region extents to provide for the addition of interleaving in
> 	   the future.
> - Get and maintain the hardware extent lists for each device via an
>   initial extent list and DC event records
>         a. Add capacity Events
> 	b. Add capacity response
> 	b. Release capacity events
> 	d. Release capacity response
> - Notify region layers of extent changes
> - Allow for DAX devices to be created on extents which are surfaced
> - Maintain references on extents which are in use
> 	a. Send Release capacity Response only when DAX devices are not
> 	   using memory
> - Allow DAX region extent labels to change to allow for flexibility in
>   DAX device creation in the future (further enhancements are required
>   to ndctl for this)
> - Trace Dynamic Capacity events
> - Add cxl-test infrastructure to allow for faster unit testing
>
> To: Dan Williams <dan.j.williams@intel.com>
> Cc: Navneet Singh <navneet.singh@intel.com>
> Cc: Fan Ni <fan.ni@samsung.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> [1] https://lore.kernel.org/all/64326437c1496_934b2949f@dwillia2-mobl3.a=
mr.corp.intel.com.notmuch/
> [2] https://lore.kernel.org/all/168592149709.1948938.8663425987110396027=
.stgit@dwillia2-xfh.jf.intel.com/
> [3] https://lore.kernel.org/all/6483946e8152f_f1132294a2@iweiny-mobl.not=
much/
> [4] https://lore.kernel.org/r/20230604-dcd-type2-upstream-v1-0-71b6341ba=
e54@intel.com
> [5] https://github.com/weiny2/linux-kernel/commits/dcd-v2-2023-08-28
> [6] https://github.com/weiny2/ndctl/tree/dcd-region2
>

Hi Ira,

I tried to test the patch series with the qemu dcd patches, however, I
hit some issues, and would like to check the following with you.

1. After we create a region for DC before any extents are added, a dax
device will show under /dev. Is that what we want? If I remember it
correctly, the dax device used to show up after a dc extent is added.


2. add/release extent does not work correctly for me. The code path is
not called, and I made the following changes to make it pass.
=2D--
 drivers/cxl/cxl.h    | 3 ++-
 drivers/cxl/cxlmem.h | 1 +
 drivers/cxl/pci.c    | 7 +++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 2c73a30980b6..0d132c1739ce 100644
=2D-- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -168,7 +168,8 @@ static inline int ways_to_eiw(unsigned int ways, u8 *e=
iw)
 #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
 				 CXLDEV_EVENT_STATUS_WARN |	\
 				 CXLDEV_EVENT_STATUS_FAIL |	\
-				 CXLDEV_EVENT_STATUS_FATAL)
+				 CXLDEV_EVENT_STATUS_FATAL| \
+				 CXLDEV_EVENT_STATUS_DCD)

 /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
 #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8ca81fd067c2..ae9dcb291c75 100644
=2D-- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -235,6 +235,7 @@ struct cxl_event_interrupt_policy {
 	u8 warn_settings;
 	u8 failure_settings;
 	u8 fatal_settings;
+	u8 dyncap_settings;
 } __packed;

 /**
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 10c1a583113c..e30fe0304514 100644
=2D-- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -686,6 +686,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_=
state *mds,
 		.warn_settings =3D CXL_INT_MSI_MSIX,
 		.failure_settings =3D CXL_INT_MSI_MSIX,
 		.fatal_settings =3D CXL_INT_MSI_MSIX,
+		.dyncap_settings =3D CXL_INT_MSI_MSIX,
 	};

 	mbox_cmd =3D (struct cxl_mbox_cmd) {
@@ -739,6 +740,12 @@ static int cxl_event_irqsetup(struct cxl_memdev_state=
 *mds)
 		return rc;
 	}

+	rc =3D cxl_event_req_irq(cxlds, policy.dyncap_settings);
+	if (rc) {
+		dev_err(cxlds->dev, "Failed to get interrupt for event dyncap log\n");
+		return rc;
+	}
+
 	return 0;
 }

=2D-

3. With changes made in 2, the code for add/release dc extent can be calle=
d,
however, the system behaviour seems different from before. Previously, aft=
er a
dc extent is added, it will show up with lsmem command and listed as offli=
ne.
Now, nothing is showing. Is it expected? What should we do to make it usab=
le
as system ram?

Please let me know if I miss something or did something wrong. Thanks.

Fan



> ---
> Changes in v2:
> - iweiny: Complete rework of the entire series
> - Link to v1: https://lore.kernel.org/r/20230604-dcd-type2-upstream-v1-0=
-71b6341bae54@intel.com
>
> ---
> Ira Weiny (15):
>       cxl/hdm: Debug, use decoder name function
>       cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
>       cxl/region: Add Dynamic Capacity decoder and region modes
>       cxl/port: Add Dynamic Capacity mode support to endpoint decoders
>       cxl/port: Add Dynamic Capacity size support to endpoint decoders
>       cxl/region: Add Dynamic Capacity CXL region support
>       cxl/mem: Read extents on memory device discovery
>       cxl/mem: Handle DCD add and release capacity events.
>       cxl/region: Expose DC extents on region driver load
>       cxl/region: Notify regions of DC changes
>       dax/bus: Factor out dev dax resize logic
>       dax/region: Support DAX device creation on dynamic DAX regions
>       tools/testing/cxl: Make event logs dynamic
>       tools/testing/cxl: Add DC Regions to mock mem data
>       tools/testing/cxl: Add Dynamic Capacity events
>
> Navneet Singh (3):
>       cxl/mem: Read Dynamic capacity configuration from the device
>       cxl/mem: Expose device dynamic capacity configuration
>       cxl/mem: Trace Dynamic capacity Event Record
>
>  Documentation/ABI/testing/sysfs-bus-cxl |  56 ++-
>  drivers/cxl/core/core.h                 |   1 +
>  drivers/cxl/core/hdm.c                  | 215 ++++++++-
>  drivers/cxl/core/mbox.c                 | 646 +++++++++++++++++++++++++=
-
>  drivers/cxl/core/memdev.c               |  77 ++++
>  drivers/cxl/core/port.c                 |  19 +
>  drivers/cxl/core/region.c               | 418 +++++++++++++++--
>  drivers/cxl/core/trace.h                |  65 +++
>  drivers/cxl/cxl.h                       |  99 +++-
>  drivers/cxl/cxlmem.h                    | 138 +++++-
>  drivers/cxl/mem.c                       |  50 ++
>  drivers/cxl/pci.c                       |   8 +
>  drivers/dax/Makefile                    |   1 +
>  drivers/dax/bus.c                       | 263 ++++++++---
>  drivers/dax/bus.h                       |   1 +
>  drivers/dax/cxl.c                       | 213 ++++++++-
>  drivers/dax/dax-private.h               |  61 +++
>  drivers/dax/extent.c                    | 133 ++++++
>  tools/testing/cxl/test/mem.c            | 782 +++++++++++++++++++++++++=
++-----
>  19 files changed, 3005 insertions(+), 241 deletions(-)
> ---
> base-commit: c76cce37fb6f3796e8e146677ba98d3cca30a488
> change-id: 20230604-dcd-type2-upstream-0cd15f6216fd
>
> Best regards,
> --
> Ira Weiny <ira.weiny@intel.com>
>
