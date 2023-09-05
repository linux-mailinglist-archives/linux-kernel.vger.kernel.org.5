Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042CF7930C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbjIEVKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbjIEVKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:10:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F21C1A2;
        Tue,  5 Sep 2023 14:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1693948196; x=1694552996; i=fan.ni@gmx.us;
 bh=Rxg1bMuDR/Fqk/qNCZkvHDUMlglXCGuhkqfIPFzT4UU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=rkSa+R0+G5Ruybj8uxHKGwOFjJdivgZUKLemobTU+Wjd8HUJrR9LNWAGQkflcyju3FPLace
 cXENxHDrr08sx5WJiTGfh31EiyswMaX+Mr9x6kIxwJZ8IdWziumZSZdpaSX9G8NxGv5S/S3d2
 Q/qHvZ7gjk43imUahsCLby/ZbgieRJbkX7qJCQGvJ39AzlSbzFoo4yzVc+lnoPf3acGYYV5yY
 ePtZWC40kKufci+8iTCIMT8F0Z7VVWews6nDtKMVFm2Z5F9qyEPTsifePHu1dwY4iuLV+mHfz
 zKJ4WuEod7o07KNHgmA93SEo0/xgaP7Hv4sjEvTM4RhNlMNfnJ7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([50.205.20.42]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4hzj-1pc5Fj0KAh-011kXc; Tue, 05
 Sep 2023 23:09:56 +0200
Date:   Tue, 5 Sep 2023 14:09:48 -0700
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
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 08/18] cxl/region: Add Dynamic Capacity CXL region
 support
Message-ID: <ZPeZHIPef2otzVNU@debian>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-8-f740c47e7916@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v2-8-f740c47e7916@intel.com>
X-Provags-ID: V03:K1:m40EFgx6zakYxZbW6pPX5UgDd/jX5DbaJjPsQBz10t2JUmWMbXB
 LNMiig8gFdHOws43UgFdNvY85cSuoowl+iAIP9OL75y0KzWyIxxY8U6OOeiQLRIiq7QhhYO
 JPLMOkbJYC54EqHcR9weR4o7ad+FVWknJTzUpItIfqMOwP3QoJLtlKzRwKzrurEbywt1p/V
 D6AxOq5PTGXOvQv1LvWYg==
UI-OutboundReport: notjunk:1;M01:P0:duuZmDkwjYY=;xA048yNUMBdNNtcPuW7tqu0mGSx
 337C0p56b1P5SROw8HqhP+5ZDHlRRs15gaEWNfcAmtOhcab27y44bBdu1lZu+o0Kp2ggeohtD
 XjcUymaNl01y5wTasnqAYuWx/4qWQtNZPrkK4zAB5DF2iu7wkV9Pi/Y72i22mi5vII50a+1DW
 qJa9ZaCWtW5R8WdNbry2KLF6cMc3Q//AXsn63DLfZZyCJdh4bgL4kGx/KJiHu46cnrECuqjGb
 3EFoom1crTDw4ZNGVwGl9XXfkfE7UFreCcVW8bmiCgvbd1H03rCk+RgMBywIiEQYuangX6LiR
 SNKDGjN6V8/mfgR4iL50PP1YgEFlRIfGRTugJ/x+UxideGJjQhSa1IPxmxtzH2afNToaA4BKD
 AopMFXudXb+b05OCvFv1N5NtKWdw8JiFTUnWfTEHsDohaMd7Mn6hfMeWh+hDKCq4zqGXmqykN
 Of+vM+EPvwyCffA2cgz0aV4WUKYiajCXBxucenPEZyuGUSX8KV/JWGg9zqn4ihMim5j2eqBu3
 3nyUXVjEQuUjMaUkrCrDG23NblJp1hkhxD14cXzsu5eB9LuUaPG2KkAxJHRu2BpxSYQgh62wZ
 GLbT+ozzpSCxK4JAF46b0KeQe+/W6jPgStZ0DxBYenfviJtyJY6mMmn0eLluDVD+gjx8gowOd
 GCSK5tfVaNJr/wXL2Hx1MPkYtYiDWmXZyN6gWAjxtW2ZiM7zHdLpnA9lAM3PrYGXfp7c6gyi+
 zPI0aLVth40WDHvVM8W9eTHp+xOd9dQr39w9UlcZVW2BThGmmfzbfeL8vcPx9BP28rVIQymcC
 pUmbsvCmSiMhjvo2FxPCMm5t2ww5lr4XIp4z0tJgQqjiFmKLHNsBUMcHhLcIJrPNS4q5jDFyz
 +gSP+QecwVO3YpmfkY8TD/5llMqBMT9qygbCjwDOigm+vqM9RgQeY2Fplu0LmNXj3owpqokc8
 9l6iSvmVHApdBqg0G30cVpW4ixo=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:20:59PM -0700, Ira Weiny wrote:
> CXL devices optionally support dynamic capacity.  CXL Regions must be
> configured correctly to access this capacity.  Similar to ram and pmem
> partitions, DC Regions represent different partitions of the DPA space.
>
> Interleaving is deferred due to the complexity of managing extents on
> multiple devices at the same time.  However, there is nothing which
> directly prevents interleave support at this time.  The check allows
> for early rejection.
>
> To maintain backwards compatibility with older software, CXL regions
> need a default DAX device to hold the reference for the region until it
> is deleted.
>
> Add create_dc_region sysfs entry to create DC regions.  Share the logic
> of devm_cxl_add_dax_region() and region_is_system_ram().  Special case
> DC capable CXL regions to create a 0 sized seed DAX device until others
> can be created on dynamic space later.
>
> Flag dax_regions to indicate 0 capacity available until dax_region
> extents are supported by the region.
>
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> changes for v2:
> [iweiny: flag empty dax regions]
> [iweiny: Split out anything not directly related to creating a DC CXL
> 	 region]
> [iweiny: Separate out dev dax stuff]
> [iweiny/navneet: create 0 sized DAX device by default]
> [iweiny: use new DC region mode]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 20 +++++-----
>  drivers/cxl/core/core.h                 |  1 +
>  drivers/cxl/core/port.c                 |  1 +
>  drivers/cxl/core/region.c               | 71 ++++++++++++++++++++++++++=
++-----
>  drivers/dax/bus.c                       |  8 ++++
>  drivers/dax/bus.h                       |  1 +
>  drivers/dax/cxl.c                       | 15 ++++++-
>  7 files changed, 96 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI=
/testing/sysfs-bus-cxl
> index aa65dc5b4e13..a0562938ecac 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -351,20 +351,20 @@ Description:
>  		interleave_granularity).
>
>
> -What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
> +What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram,dc}_region
>  Date:		May, 2022, January, 2023
> -KernelVersion:	v6.0 (pmem), v6.3 (ram)
> +KernelVersion:	v6.0 (pmem), v6.3 (ram), v6.6 (dc)
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write a string in the form 'regionZ' to start the process
> -		of defining a new persistent, or volatile memory region
> -		(interleave-set) within the decode range bounded by root decoder
> -		'decoderX.Y'. The value written must match the current value
> -		returned from reading this attribute. An atomic compare exchange
> -		operation is done on write to assign the requested id to a
> -		region and allocate the region-id for the next creation attempt.
> -		EBUSY is returned if the region name written does not match the
> -		current cached value.
> +		of defining a new persistent, volatile, or Dynamic Capacity
> +		(DC) memory region (interleave-set) within the decode range
> +		bounded by root decoder 'decoderX.Y'. The value written must
> +		match the current value returned from reading this attribute.
> +		An atomic compare exchange operation is done on write to assign
> +		the requested id to a region and allocate the region-id for the
> +		next creation attempt.  EBUSY is returned if the region name
> +		written does not match the current cached value.
>
>
>  What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 45e7e044cf4a..cf3cf01cb95d 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -13,6 +13,7 @@ extern struct attribute_group cxl_base_attribute_group=
;
>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
> +extern struct device_attribute dev_attr_create_dc_region;
>  extern struct device_attribute dev_attr_delete_region;
>  extern struct device_attribute dev_attr_region;
>  extern const struct device_type cxl_pmem_region_type;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index a5db710a63bc..608901bb7d91 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -314,6 +314,7 @@ static struct attribute *cxl_decoder_root_attrs[] =
=3D {
>  	&dev_attr_target_list.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
>  	SET_CXL_REGION_ATTR(create_ram_region)
> +	SET_CXL_REGION_ATTR(create_dc_region)
>  	SET_CXL_REGION_ATTR(delete_region)
>  	NULL,
>  };
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 69af1354bc5b..fc8dee469244 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2271,6 +2271,7 @@ static struct cxl_region *devm_cxl_add_region(stru=
ct cxl_root_decoder *cxlrd,
>  	switch (mode) {
>  	case CXL_REGION_RAM:
>  	case CXL_REGION_PMEM:
> +	case CXL_REGION_DC:
>  		break;
>  	default:
>  		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %s\n",
> @@ -2383,6 +2384,33 @@ static ssize_t create_ram_region_store(struct dev=
ice *dev,
>  }
>  DEVICE_ATTR_RW(create_ram_region);
>
> +static ssize_t create_dc_region_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	return __create_region_show(to_cxl_root_decoder(dev), buf);
> +}
> +
> +static ssize_t create_dc_region_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct cxl_root_decoder *cxlrd =3D to_cxl_root_decoder(dev);
> +	struct cxl_region *cxlr;
> +	int rc, id;
> +
> +	rc =3D sscanf(buf, "region%d\n", &id);
> +	if (rc !=3D 1)
> +		return -EINVAL;
> +
> +	cxlr =3D __create_region(cxlrd, id, CXL_REGION_DC,
> +			       CXL_DECODER_HOSTONLYMEM);
> +	if (IS_ERR(cxlr))
> +		return PTR_ERR(cxlr);
> +
> +	return len;
> +}
> +DEVICE_ATTR_RW(create_dc_region);
> +
>  static ssize_t region_show(struct device *dev, struct device_attribute =
*attr,
>  			   char *buf)
>  {
> @@ -2834,7 +2862,7 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
>  	device_unregister(&cxlr_dax->dev);
>  }
>
> -static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> +static int __devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  {
>  	struct cxl_dax_region *cxlr_dax;
>  	struct device *dev;
> @@ -2863,6 +2891,21 @@ static int devm_cxl_add_dax_region(struct cxl_reg=
ion *cxlr)
>  	return rc;
>  }
>
> +static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> +{
> +	return __devm_cxl_add_dax_region(cxlr);
> +}
> +
> +static int devm_cxl_add_dc_dax_region(struct cxl_region *cxlr)
> +{
> +	if (cxlr->params.interleave_ways !=3D 1) {
> +		dev_err(&cxlr->dev, "Interleaving DC not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	return __devm_cxl_add_dax_region(cxlr);
> +}
> +
>  static int match_decoder_by_range(struct device *dev, void *data)
>  {
>  	struct range *r1, *r2 =3D data;
> @@ -3203,6 +3246,19 @@ static int is_system_ram(struct resource *res, vo=
id *arg)
>  	return 1;
>  }
>
> +/*
> + * The region can not be manged by CXL if any portion of
> + * it is already online as 'System RAM'
> + */
> +static bool region_is_system_ram(struct cxl_region *cxlr,
> +				 struct cxl_region_params *p)
> +{
> +	return (walk_iomem_res_desc(IORES_DESC_NONE,
> +				    IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				    p->res->start, p->res->end, cxlr,
> +				    is_system_ram) > 0);
> +}
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr =3D to_cxl_region(dev);
> @@ -3242,14 +3298,7 @@ static int cxl_region_probe(struct device *dev)
>  	case CXL_REGION_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
>  	case CXL_REGION_RAM:
> -		/*
> -		 * The region can not be manged by CXL if any portion of
> -		 * it is already online as 'System RAM'
> -		 */
> -		if (walk_iomem_res_desc(IORES_DESC_NONE,
> -					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> -					p->res->start, p->res->end, cxlr,
> -					is_system_ram) > 0)
> +		if (region_is_system_ram(cxlr, p))
>  			return 0;
>
>  		/*
> @@ -3261,6 +3310,10 @@ static int cxl_region_probe(struct device *dev)
>
>  		/* HDM-H routes to device-dax */
>  		return devm_cxl_add_dax_region(cxlr);
> +	case CXL_REGION_DC:
> +		if (region_is_system_ram(cxlr, p))
> +			return 0;
> +		return devm_cxl_add_dc_dax_region(cxlr);
>  	default:
>  		dev_dbg(&cxlr->dev, "unsupported region mode: %s\n",
>  			cxl_region_mode_name(cxlr->mode));
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 0ee96e6fc426..b76e49813a39 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -169,6 +169,11 @@ static bool is_static(struct dax_region *dax_region=
)
>  	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) !=3D 0;
>  }
>
> +static bool is_dynamic(struct dax_region *dax_region)
> +{
> +	return (dax_region->res.flags & IORESOURCE_DAX_DYNAMIC_CAP) !=3D 0;
> +}
> +
>  bool static_dev_dax(struct dev_dax *dev_dax)
>  {
>  	return is_static(dev_dax->region);
> @@ -285,6 +290,9 @@ static unsigned long long dax_region_avail_size(stru=
ct dax_region *dax_region)
>
>  	device_lock_assert(dax_region->dev);
>
> +	if (is_dynamic(dax_region))
> +		return 0;
> +
>  	for_each_dax_region_resource(dax_region, res)
>  		size -=3D resource_size(res);
>  	return size;
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index 1ccd23360124..74d8fe4a5532 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -13,6 +13,7 @@ struct dax_region;
>  /* dax bus specific ioresource flags */
>  #define IORESOURCE_DAX_STATIC BIT(0)
>  #define IORESOURCE_DAX_KMEM BIT(1)
> +#define IORESOURCE_DAX_DYNAMIC_CAP BIT(2)
>
>  struct dax_region *alloc_dax_region(struct device *parent, int region_i=
d,
>  		struct range *range, int target_node, unsigned int align,
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 8bc9d04034d6..147c8c69782b 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -13,19 +13,30 @@ static int cxl_dax_region_probe(struct device *dev)
>  	struct cxl_region *cxlr =3D cxlr_dax->cxlr;
>  	struct dax_region *dax_region;
>  	struct dev_dax_data data;
> +	resource_size_t dev_size;
> +	unsigned long flags;
>
>  	if (nid =3D=3D NUMA_NO_NODE)
>  		nid =3D memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>
> +	dev_size =3D range_len(&cxlr_dax->hpa_range);
> +
> +	flags =3D IORESOURCE_DAX_KMEM;
> +	if (cxlr->mode =3D=3D CXL_REGION_DC) {
> +		/* Add empty seed dax device */
> +		dev_size =3D 0;
> +		flags |=3D IORESOURCE_DAX_DYNAMIC_CAP;
> +	}
> +
>  	dax_region =3D alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, n=
id,
> -				      PMD_SIZE, IORESOURCE_DAX_KMEM);
> +				      PMD_SIZE, flags);
>  	if (!dax_region)
>  		return -ENOMEM;
>
>  	data =3D (struct dev_dax_data) {
>  		.dax_region =3D dax_region,
>  		.id =3D -1,
> -		.size =3D range_len(&cxlr_dax->hpa_range),
> +		.size =3D dev_size,
>  	};
>
>  	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
>
> --
> 2.41.0
>
