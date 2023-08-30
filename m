Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1508B78E193
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242435AbjH3Vqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242425AbjH3Vqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:46:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3050C1A1;
        Wed, 30 Aug 2023 14:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1693431887; x=1694036687; i=fan.ni@gmx.us;
 bh=a96elxncsmZYJ1v5mtoSAnJRURD4jXVFOWj3F+hokfk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dd0QKc4GnfuU/uWr9DFWLVdBH7DBdwbwmc4LyLco3Glc1XSwiFZLpzqkdw7EoaWG/V+At2S
 BABQvqoMqTJpxt2N+ah6esiyAiC7yVvrjLEWOdYd4CO6+k4ZgZ+Qnx2kg4K0IDIXlysWyRENm
 121iSu/BgHeiLZ2hNPad+AdLyYMMT8Ltzo5AGR3MnJo0+bMBu0/CEY5adVrUYlsfEZqYbTxmH
 2fbDw0sezIjUTHw0951c25r4mpJh6eigYCvC7VFBgEu+l4nU4nc4y18ZvQ6SYf9LMUiZBNtv0
 SOyeIyOkhjzGN6BUoSkTtpAwzXTIYgnjSitn8Ex2PfxrES+pQJvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([50.205.20.42]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mz9Yv-1poA8649ml-00wC6M; Wed, 30
 Aug 2023 23:44:46 +0200
Date:   Wed, 30 Aug 2023 14:44:34 -0700
From:   Fan Ni <fan.ni@gmx.us>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 03/18] cxl/mem: Read Dynamic capacity
 configuration from the device
Message-ID: <ZO+4Qql0rOslp0bl@debian>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-3-f740c47e7916@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v2-3-f740c47e7916@intel.com>
X-Provags-ID: V03:K1:CMg7y4LAwRJLCKwlyh6aU43mmFT8F1YCGIRST3rTQRGgLU0oCzm
 7Ca4vm0PSeUP8I/F0cMiRmPEG00aKzLuoL5HUHzzUrza6KPLSe4hqRuVbOoieLE7O+U47E1
 cM+SEUTAdnvRYUJxryiKVjX3HmZV9sNI9jPO4hry09emIW+N/LhqkuTK/Nao0Ubod3vGgKv
 XTvZOG4fHKtZYX1QybXSg==
UI-OutboundReport: notjunk:1;M01:P0:cgCUXOUDkng=;tQM2O6XFljOCywWQVvq5jXIeU/t
 ZdELCzHLPPZtfc77emVb33NdKzbWtc5Okx/4DLsh0UEWcKnptX/Nc3d5YeONmr1FL0ksXr6El
 J5WgG89I1+lkkO6mUTKMcXz7zh46p3TiEH5pJmjE9Mi/8gDL2ik7bkWsfn7Q7pMW3EPxfuZN0
 qJky3q7icNybREFItOX+agrk2bi4GDNXc293rzfYB6Tur03AGYx3kr442rYdB4UQbSYASS6Zd
 O+Xb5IBa/4v8SYuj4TNNyo7yA8+I8t0wjYmblF4KgFvKQh75b/0xVfEpXZga/wZK0tWldZfvs
 1eVhIjGFmAM77V9FV1wxyRUOOyOK+ml7Ehj1Rm6L1LYx3ZFqxqxxFnw1huoNbrWNalEQulX8T
 PGn32eEOmS+WV84S8C0i4q2CR2hxrWPb3Zr2K0pZfc6klAP6exaoqyjFmtG9uCQMoitzRkGYR
 O9nIOhinG7auI1VcQhp/4ncKovFpe4QwEzJx9rRlf0SFbLDUbvMZ3bAJizC3qRD9uSmJwUQxh
 AGzsa7V8lnpw1TyHHtHPl9DwgZ8hH3V8RQOTCqRY3aewZghSNpOYgbQMjXI+If+sndstCuDQU
 O/c2LqmI+Q2sdtv5YRk3RuZhvz8JccJbrfe2X+DmM9Qvqar/ju6Nxkz40kgkIy5LtS0434XWj
 yRIYhKklCdII3nOEaX+hNXXJ6aOZ51t8Hp5Pq5BJ2aHtG/KJYbKEs+v6C5oSGaTSqKzz1v7cq
 5IiMrGIrIHLLziC9ZxtI5/5enJgAE4kseLqXwwbcUh5st52GeIGpu9iE/S11OFtJ2azEJFPaT
 dFHfaLUKAQfNH3Tsk/LxJ1XrIENZ39O8zYAVLkDPa4RwKrjpAKEqL2COgtP6ysGawej62PIJQ
 9nTF34gfZF7yk8vMXrbrBg1WhADXpCd7iYFSph4Xb7t26m6u8yMGSck1wztF9VuoS4laVRP/A
 P4p4lEcaTjOyu2G3ohZ14ps69Lg=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:20:54PM -0700, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
>
> Devices can optionally support Dynamic Capacity (DC).  These devices are
> known as Dynamic Capacity Devices (DCD).
>
> Implement the DC (opcode 48XXh) mailbox commands as specified in CXL 3.0
> section 8.2.9.8.9.  Read the DC configuration and store the DC region
> information in the device state.
>
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes for v2
> [iweiny: Rebased to latest master type2 work]
> [jonathan: s/dc/dc_resp/]
> [iweiny: Clean up commit message]
> [iweiny: Clean kernel docs]
> [djiang: Fix up cxl_is_dcd_command]
> [djiang: extra blank line]
> [alison: s/total_capacity/cap/ etc...]
> [alison: keep partition flag with partition structures]
> [alison: reformat untenanted_mem declaration]
> [alison: move 'cmd' definition back]
> [alison: fix comment line length]
> [alison: reverse x-tree]
> [jonathan: fix and adjust CXL_DC_REGION_STRLEN]
> [Jonathan/iweiny: Factor out storing each DC region read from the device=
]
> [Jonathan: place all dcr initializers together]
> [Jonathan/iweiny: flip around the region DPA order check]
> [jonathan: Account for short read of mailbox command]
> [iweiny: use snprintf for region name]
> [iweiny: use '<nil>' for missing region names]
> [iweiny: factor out struct cxl_dc_region_info]
> [iweiny: Split out reading CEL]
> ---
>  drivers/cxl/core/mbox.c   | 179 +++++++++++++++++++++++++++++++++++++++=
++++++-
>  drivers/cxl/core/region.c |  75 +++++++++++++------
>  drivers/cxl/cxl.h         |  27 ++++++-
>  drivers/cxl/cxlmem.h      |  55 +++++++++++++-
>  drivers/cxl/pci.c         |   4 ++
>  5 files changed, 314 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 554ec97a7c39..d769814f80e2 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1096,7 +1096,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state=
 *mds)
>  	if (rc < 0)
>  		return rc;
>
> -	mds->total_bytes =3D
> +	mds->static_cap =3D
>  		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
>  	mds->volatile_only_bytes =3D
>  		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
> @@ -1114,6 +1114,8 @@ int cxl_dev_state_identify(struct cxl_memdev_state=
 *mds)
>  		mds->poison.max_errors =3D min_t(u32, val, CXL_POISON_LIST_MAX);
>  	}
>
> +	mds->dc_event_log_size =3D le16_to_cpu(id.dc_event_log_size);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
> @@ -1178,6 +1180,165 @@ int cxl_mem_sanitize(struct cxl_memdev_state *md=
s, u16 cmd)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
>
> +static int cxl_dc_save_region_info(struct cxl_memdev_state *mds, int in=
dex,
> +				   struct cxl_dc_region_config *region_config)
> +{
> +	struct cxl_dc_region_info *dcr =3D &mds->dc_region[index];
> +	struct device *dev =3D mds->cxlds.dev;
> +
> +	dcr->base =3D le64_to_cpu(region_config->region_base);
> +	dcr->decode_len =3D le64_to_cpu(region_config->region_decode_length);
> +	dcr->decode_len *=3D CXL_CAPACITY_MULTIPLIER;
> +	dcr->len =3D le64_to_cpu(region_config->region_length);
> +	dcr->blk_size =3D le64_to_cpu(region_config->region_block_size);
> +	dcr->dsmad_handle =3D le32_to_cpu(region_config->region_dsmad_handle);
> +	dcr->flags =3D region_config->flags;
> +	snprintf(dcr->name, CXL_DC_REGION_STRLEN, "dc%d", index);
> +
> +	/* Check regions are in increasing DPA order */
> +	if (index > 0) {
> +		struct cxl_dc_region_info *prev_dcr =3D &mds->dc_region[index - 1];
> +
> +		if ((prev_dcr->base + prev_dcr->decode_len) > dcr->base) {
> +			dev_err(dev,
> +				"DPA ordering violation for DC region %d and %d\n",
> +				index - 1, index);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* Check the region is 256 MB aligned */
> +	if (!IS_ALIGNED(dcr->base, SZ_256M)) {
> +		dev_err(dev, "DC region %d not aligned to 256MB: %#llx\n",
> +			index, dcr->base);
> +		return -EINVAL;
> +	}
> +
> +	/* Check Region base and length are aligned to block size */
> +	if (!IS_ALIGNED(dcr->base, dcr->blk_size) ||
> +	    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
> +		dev_err(dev, "DC region %d not aligned to %#llx\n", index,
> +			dcr->blk_size);
> +		return -EINVAL;
> +	}

Based on on cxl 3.0 spec: Table 8-126, we may need some extra checks
here:
1. region len <=3D decode_len
2. region block size should be power of 2 and a multiple of 40H.

Also, if region len or block size is 0, it mentions that DC will not be
available, we may also need to handle that.

Fan

> +
> +	dev_dbg(dev,
> +		"DC region %s DPA: %#llx LEN: %#llx BLKSZ: %#llx\n",
> +		dcr->name, dcr->base, dcr->decode_len, dcr->blk_size);
> +
> +	return 0;
> +}
> +
> +/* Returns the number of regions in dc_resp or -ERRNO */
> +static int cxl_get_dc_id(struct cxl_memdev_state *mds, u8 start_region,
> +			 struct cxl_mbox_dynamic_capacity *dc_resp,
> +			 size_t dc_resp_size)
> +{
> +	struct cxl_mbox_get_dc_config get_dc =3D (struct cxl_mbox_get_dc_confi=
g) {
> +		.region_count =3D CXL_MAX_DC_REGION,
> +		.start_region_index =3D start_region,
> +	};
> +	struct cxl_mbox_cmd mbox_cmd =3D (struct cxl_mbox_cmd) {
> +		.opcode =3D CXL_MBOX_OP_GET_DC_CONFIG,
> +		.payload_in =3D &get_dc,
> +		.size_in =3D sizeof(get_dc),
> +		.size_out =3D dc_resp_size,
> +		.payload_out =3D dc_resp,
> +		.min_out =3D 1,
> +	};
> +	struct device *dev =3D mds->cxlds.dev;
> +	int rc;
> +
> +	rc =3D cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc =3D dc_resp->avail_region_count - start_region;
> +
> +	/*
> +	 * The number of regions in the payload may have been truncated due to
> +	 * payload_size limits; if so adjust the count in this query.
> +	 */
> +	if (mbox_cmd.size_out < sizeof(*dc_resp))
> +		rc =3D CXL_REGIONS_RETURNED(mbox_cmd.size_out);
> +
> +	dev_dbg(dev, "Read %d/%d DC regions\n", rc, dc_resp->avail_region_coun=
t);
> +
> +	return rc;
> +}
> +
> +/**
> + * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> + *					 information from the device.
> + * @mds: The memory device state
> + *
> + * This will dispatch the get_dynamic_capacity command to the device
> + * and on success populate structures to be exported to sysfs.
> + *
> + * Return: 0 if identify was executed successfully, -ERRNO on error.
> + */
> +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> +{
> +	struct cxl_mbox_dynamic_capacity *dc_resp;
> +	struct device *dev =3D mds->cxlds.dev;
> +	size_t dc_resp_size =3D mds->payload_size;
> +	u8 start_region;
> +	int i, rc =3D 0;
> +
> +	for (i =3D 0; i < CXL_MAX_DC_REGION; i++)
> +		snprintf(mds->dc_region[i].name, CXL_DC_REGION_STRLEN, "<nil>");
> +
> +	/* Check GET_DC_CONFIG is supported by device */
> +	if (!test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds)) {
> +		dev_dbg(dev, "unsupported cmd: get_dynamic_capacity_config\n");
> +		return 0;
> +	}
> +
> +	dc_resp =3D kvmalloc(dc_resp_size, GFP_KERNEL);
> +	if (!dc_resp)
> +		return -ENOMEM;
> +
> +	start_region =3D 0;
> +	do {
> +		int j;
> +
> +		rc =3D cxl_get_dc_id(mds, start_region, dc_resp, dc_resp_size);
> +		if (rc < 0)
> +			goto free_resp;
> +
> +		mds->nr_dc_region +=3D rc;
> +
> +		if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
> +			dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
> +				mds->nr_dc_region);
> +			rc =3D -EINVAL;
> +			goto free_resp;
> +		}
> +
> +		for (i =3D start_region, j =3D 0; i < mds->nr_dc_region; i++, j++) {
> +			rc =3D cxl_dc_save_region_info(mds, i, &dc_resp->region[j]);
> +			if (rc)
> +				goto free_resp;
> +		}
> +
> +		start_region =3D mds->nr_dc_region;
> +
> +	} while (mds->nr_dc_region < dc_resp->avail_region_count);
> +
> +	mds->dynamic_cap =3D
> +		mds->dc_region[mds->nr_dc_region - 1].base +
> +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> +		mds->dc_region[0].base;
> +	dev_dbg(dev, "Total dynamic capacity: %#llx\n", mds->dynamic_cap);
> +
> +free_resp:
> +	kfree(dc_resp);
> +	if (rc)
> +		dev_err(dev, "Failed to get DC info: %d\n", rc);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> +
>  static int add_dpa_res(struct device *dev, struct resource *parent,
>  		       struct resource *res, resource_size_t start,
>  		       resource_size_t size, const char *type)
> @@ -1208,8 +1369,12 @@ int cxl_mem_create_range_info(struct cxl_memdev_s=
tate *mds)
>  {
>  	struct cxl_dev_state *cxlds =3D &mds->cxlds;
>  	struct device *dev =3D cxlds->dev;
> +	size_t untenanted_mem;
>  	int rc;
>
> +	untenanted_mem =3D mds->dc_region[0].base - mds->static_cap;
> +	mds->total_bytes =3D mds->static_cap + untenanted_mem + mds->dynamic_c=
ap;
> +
>  	if (!cxlds->media_ready) {
>  		cxlds->dpa_res =3D DEFINE_RES_MEM(0, 0);
>  		cxlds->ram_res =3D DEFINE_RES_MEM(0, 0);
> @@ -1217,8 +1382,16 @@ int cxl_mem_create_range_info(struct cxl_memdev_s=
tate *mds)
>  		return 0;
>  	}
>
> -	cxlds->dpa_res =3D
> -		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
> +	cxlds->dpa_res =3D (struct resource)DEFINE_RES_MEM(0, mds->total_bytes=
);
> +
> +	for (int i =3D 0; i < mds->nr_dc_region; i++) {
> +		struct cxl_dc_region_info *dcr =3D &mds->dc_region[i];
> +
> +		rc =3D add_dpa_res(dev, &cxlds->dpa_res, &cxlds->dc_res[i],
> +				 dcr->base, dcr->decode_len, dcr->name);
> +		if (rc)
> +			return rc;
> +	}
>
>  	if (mds->partition_align_bytes =3D=3D 0) {
>  		rc =3D add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 252bc8e1f103..75041903b72c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -46,7 +46,7 @@ static ssize_t uuid_show(struct device *dev, struct de=
vice_attribute *attr,
>  	rc =3D down_read_interruptible(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> -	if (cxlr->mode !=3D CXL_DECODER_PMEM)
> +	if (cxlr->mode !=3D CXL_REGION_PMEM)
>  		rc =3D sysfs_emit(buf, "\n");
>  	else
>  		rc =3D sysfs_emit(buf, "%pUb\n", &p->uuid);
> @@ -359,7 +359,7 @@ static umode_t cxl_region_visible(struct kobject *ko=
bj, struct attribute *a,
>  	 * Support tooling that expects to find a 'uuid' attribute for all
>  	 * regions regardless of mode.
>  	 */
> -	if (a =3D=3D &dev_attr_uuid.attr && cxlr->mode !=3D CXL_DECODER_PMEM)
> +	if (a =3D=3D &dev_attr_uuid.attr && cxlr->mode !=3D CXL_REGION_PMEM)
>  		return 0444;
>  	return a->mode;
>  }
> @@ -537,7 +537,7 @@ static ssize_t mode_show(struct device *dev, struct =
device_attribute *attr,
>  {
>  	struct cxl_region *cxlr =3D to_cxl_region(dev);
>
> -	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxlr->mode));
> +	return sysfs_emit(buf, "%s\n", cxl_region_mode_name(cxlr->mode));
>  }
>  static DEVICE_ATTR_RO(mode);
>
> @@ -563,7 +563,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resour=
ce_size_t size)
>
>  	/* ways, granularity and uuid (if PMEM) need to be set before HPA */
>  	if (!p->interleave_ways || !p->interleave_granularity ||
> -	    (cxlr->mode =3D=3D CXL_DECODER_PMEM && uuid_is_null(&p->uuid)))
> +	    (cxlr->mode =3D=3D CXL_REGION_PMEM && uuid_is_null(&p->uuid)))
>  		return -ENXIO;
>
>  	div_u64_rem(size, SZ_256M * p->interleave_ways, &remainder);
> @@ -1765,6 +1765,17 @@ static int cxl_region_sort_targets(struct cxl_reg=
ion *cxlr)
>  	return rc;
>  }
>
> +static bool cxl_modes_compatible(enum cxl_region_mode rmode,
> +				 enum cxl_decoder_mode dmode)
> +{
> +	if (rmode =3D=3D CXL_REGION_RAM && dmode =3D=3D CXL_DECODER_RAM)
> +		return true;
> +	if (rmode =3D=3D CXL_REGION_PMEM && dmode =3D=3D CXL_DECODER_PMEM)
> +		return true;
> +
> +	return false;
> +}
> +
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -1778,9 +1789,11 @@ static int cxl_region_attach(struct cxl_region *c=
xlr,
>  	lockdep_assert_held_write(&cxl_region_rwsem);
>  	lockdep_assert_held_read(&cxl_dpa_rwsem);
>
> -	if (cxled->mode !=3D cxlr->mode) {
> -		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> -			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> +	if (!cxl_modes_compatible(cxlr->mode, cxled->mode)) {
> +		dev_dbg(&cxlr->dev, "%s region mode: %s mismatch decoder: %s\n",
> +			dev_name(&cxled->cxld.dev),
> +			cxl_region_mode_name(cxlr->mode),
> +			cxl_decoder_mode_name(cxled->mode));
>  		return -EINVAL;
>  	}
>
> @@ -2234,7 +2247,7 @@ static struct cxl_region *cxl_region_alloc(struct =
cxl_root_decoder *cxlrd, int i
>   * devm_cxl_add_region - Adds a region to a decoder
>   * @cxlrd: root decoder
>   * @id: memregion id to create, or memregion_free() on failure
> - * @mode: mode for the endpoint decoders of this region
> + * @mode: mode of this region
>   * @type: select whether this is an expander or accelerator (type-2 or =
type-3)
>   *
>   * This is the second step of region initialization. Regions exist with=
in an
> @@ -2245,7 +2258,7 @@ static struct cxl_region *cxl_region_alloc(struct =
cxl_root_decoder *cxlrd, int i
>   */
>  static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *=
cxlrd,
>  					      int id,
> -					      enum cxl_decoder_mode mode,
> +					      enum cxl_region_mode mode,
>  					      enum cxl_decoder_type type)
>  {
>  	struct cxl_port *port =3D to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
> @@ -2254,11 +2267,12 @@ static struct cxl_region *devm_cxl_add_region(st=
ruct cxl_root_decoder *cxlrd,
>  	int rc;
>
>  	switch (mode) {
> -	case CXL_DECODER_RAM:
> -	case CXL_DECODER_PMEM:
> +	case CXL_REGION_RAM:
> +	case CXL_REGION_PMEM:
>  		break;
>  	default:
> -		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
> +		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %s\n",
> +			cxl_region_mode_name(mode));
>  		return ERR_PTR(-EINVAL);
>  	}
>
> @@ -2308,7 +2322,7 @@ static ssize_t create_ram_region_show(struct devic=
e *dev,
>  }
>
>  static struct cxl_region *__create_region(struct cxl_root_decoder *cxlr=
d,
> -					  int id, enum cxl_decoder_mode mode,
> +					  int id, enum cxl_region_mode mode,
>  					  enum cxl_decoder_type type)
>  {
>  	int rc;
> @@ -2337,7 +2351,7 @@ static ssize_t create_pmem_region_store(struct dev=
ice *dev,
>  	if (rc !=3D 1)
>  		return -EINVAL;
>
> -	cxlr =3D __create_region(cxlrd, id, CXL_DECODER_PMEM,
> +	cxlr =3D __create_region(cxlrd, id, CXL_REGION_PMEM,
>  			       CXL_DECODER_HOSTONLYMEM);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
> @@ -2358,7 +2372,7 @@ static ssize_t create_ram_region_store(struct devi=
ce *dev,
>  	if (rc !=3D 1)
>  		return -EINVAL;
>
> -	cxlr =3D __create_region(cxlrd, id, CXL_DECODER_RAM,
> +	cxlr =3D __create_region(cxlrd, id, CXL_REGION_RAM,
>  			       CXL_DECODER_HOSTONLYMEM);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
> @@ -2886,10 +2900,31 @@ static void construct_region_end(void)
>  	up_write(&cxl_region_rwsem);
>  }
>
> +static enum cxl_region_mode
> +cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
> +{
> +	switch (mode) {
> +	case CXL_DECODER_NONE:
> +		return CXL_REGION_NONE;
> +	case CXL_DECODER_RAM:
> +		return CXL_REGION_RAM;
> +	case CXL_DECODER_PMEM:
> +		return CXL_REGION_PMEM;
> +	case CXL_DECODER_DEAD:
> +		return CXL_REGION_DEAD;
> +	case CXL_DECODER_MIXED:
> +	default:
> +		return CXL_REGION_MIXED;
> +	}
> +
> +	return CXL_REGION_MIXED;
> +}
> +
>  static struct cxl_region *
>  construct_region_begin(struct cxl_root_decoder *cxlrd,
>  		       struct cxl_endpoint_decoder *cxled)
>  {
> +	enum cxl_region_mode mode =3D cxl_decoder_to_region_mode(cxled->mode);
>  	struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> @@ -2897,7 +2932,7 @@ construct_region_begin(struct cxl_root_decoder *cx=
lrd,
>
>  	do {
>  		cxlr =3D __create_region(cxlrd, atomic_read(&cxlrd->region_id),
> -				       cxled->mode, cxled->cxld.target_type);
> +				       mode, cxled->cxld.target_type);
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) =3D=3D -EBUSY);
>
>  	if (IS_ERR(cxlr)) {
> @@ -3200,9 +3235,9 @@ static int cxl_region_probe(struct device *dev)
>  		return rc;
>
>  	switch (cxlr->mode) {
> -	case CXL_DECODER_PMEM:
> +	case CXL_REGION_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
> -	case CXL_DECODER_RAM:
> +	case CXL_REGION_RAM:
>  		/*
>  		 * The region can not be manged by CXL if any portion of
>  		 * it is already online as 'System RAM'
> @@ -3223,8 +3258,8 @@ static int cxl_region_probe(struct device *dev)
>  		/* HDM-H routes to device-dax */
>  		return devm_cxl_add_dax_region(cxlr);
>  	default:
> -		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> -			cxlr->mode);
> +		dev_dbg(&cxlr->dev, "unsupported region mode: %s\n",
> +			cxl_region_mode_name(cxlr->mode));
>  		return -ENXIO;
>  	}
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cd4a9ffdacc7..ed282dcd5cf5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -374,6 +374,28 @@ static inline const char *cxl_decoder_mode_name(enu=
m cxl_decoder_mode mode)
>  	return "mixed";
>  }
>
> +enum cxl_region_mode {
> +	CXL_REGION_NONE,
> +	CXL_REGION_RAM,
> +	CXL_REGION_PMEM,
> +	CXL_REGION_MIXED,
> +	CXL_REGION_DEAD,
> +};
> +
> +static inline const char *cxl_region_mode_name(enum cxl_region_mode mod=
e)
> +{
> +	static const char * const names[] =3D {
> +		[CXL_REGION_NONE] =3D "none",
> +		[CXL_REGION_RAM] =3D "ram",
> +		[CXL_REGION_PMEM] =3D "pmem",
> +		[CXL_REGION_MIXED] =3D "mixed",
> +	};
> +
> +	if (mode >=3D CXL_REGION_NONE && mode <=3D CXL_REGION_MIXED)
> +		return names[mode];
> +	return "mixed";
> +}
> +
>  /*
>   * Track whether this decoder is reserved for region autodiscovery, or
>   * free for userspace provisioning.
> @@ -502,7 +524,8 @@ struct cxl_region_params {
>   * struct cxl_region - CXL region
>   * @dev: This region's device
>   * @id: This region's id. Id is globally unique across all regions
> - * @mode: Endpoint decoder allocation / access mode
> + * @mode: Region mode which defines which endpoint decoder mode the reg=
ion is
> + *        compatible with
>   * @type: Endpoint decoder target type
>   * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
>   * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
> @@ -512,7 +535,7 @@ struct cxl_region_params {
>  struct cxl_region {
>  	struct device dev;
>  	int id;
> -	enum cxl_decoder_mode mode;
> +	enum cxl_region_mode mode;
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_pmem_region *cxlr_pmem;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5f2e65204bf9..8c8f47b397ab 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -396,6 +396,7 @@ enum cxl_devtype {
>  	CXL_DEVTYPE_CLASSMEM,
>  };
>
> +#define CXL_MAX_DC_REGION 8
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -412,6 +413,8 @@ enum cxl_devtype {
>   * @dpa_res: Overall DPA resource tree for the device
>   * @pmem_res: Active Persistent memory capacity configuration
>   * @ram_res: Active Volatile memory capacity configuration
> + * @dc_res: Active Dynamic Capacity memory configuration for each possi=
ble
> + *          region
>   * @component_reg_phys: register base of component registers
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
> @@ -426,11 +429,23 @@ struct cxl_dev_state {
>  	struct resource dpa_res;
>  	struct resource pmem_res;
>  	struct resource ram_res;
> +	struct resource dc_res[CXL_MAX_DC_REGION];
>  	resource_size_t component_reg_phys;
>  	u64 serial;
>  	enum cxl_devtype type;
>  };
>
> +#define CXL_DC_REGION_STRLEN 7
> +struct cxl_dc_region_info {
> +	u64 base;
> +	u64 decode_len;
> +	u64 len;
> +	u64 blk_size;
> +	u32 dsmad_handle;
> +	u8 flags;
> +	u8 name[CXL_DC_REGION_STRLEN];
> +};
> +
>  /**
>   * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver =
data
>   *
> @@ -449,6 +464,8 @@ struct cxl_dev_state {
>   * @enabled_cmds: Hardware commands found enabled in CEL.
>   * @exclusive_cmds: Commands that are kernel-internal only
>   * @total_bytes: sum of all possible capacities
> + * @static_cap: Sum of RAM and PMEM capacities
> + * @dynamic_cap: Complete DPA range occupied by DC regions
>   * @volatile_only_bytes: hard volatile capacity
>   * @persistent_only_bytes: hard persistent capacity
>   * @partition_align_bytes: alignment size for partition-able capacity
> @@ -456,6 +473,10 @@ struct cxl_dev_state {
>   * @active_persistent_bytes: sum of hard + soft persistent
>   * @next_volatile_bytes: volatile capacity change pending device reset
>   * @next_persistent_bytes: persistent capacity change pending device re=
set
> + * @nr_dc_region: number of DC regions implemented in the memory device
> + * @dc_region: array containing info about the DC regions
> + * @dc_event_log_size: The number of events the device can store in the
> + * Dynamic Capacity Event Log before it overflows
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @fw: firmware upload / activation state
> @@ -473,7 +494,10 @@ struct cxl_memdev_state {
>  	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> +
>  	u64 total_bytes;
> +	u64 static_cap;
> +	u64 dynamic_cap;
>  	u64 volatile_only_bytes;
>  	u64 persistent_only_bytes;
>  	u64 partition_align_bytes;
> @@ -481,6 +505,11 @@ struct cxl_memdev_state {
>  	u64 active_persistent_bytes;
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
> +
> +	u8 nr_dc_region;
> +	struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
> +	size_t dc_event_log_size;
> +
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
>  	struct cxl_security_state security;
> @@ -587,6 +616,7 @@ struct cxl_mbox_identify {
>  	__le16 inject_poison_limit;
>  	u8 poison_caps;
>  	u8 qos_telemetry_caps;
> +	__le16 dc_event_log_size;
>  } __packed;
>
>  /*
> @@ -741,9 +771,31 @@ struct cxl_mbox_set_partition_info {
>  	__le64 volatile_capacity;
>  	u8 flags;
>  } __packed;
> -
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>
> +struct cxl_mbox_get_dc_config {
> +	u8 region_count;
> +	u8 start_region_index;
> +} __packed;
> +
> +/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
> +struct cxl_mbox_dynamic_capacity {
> +	u8 avail_region_count;
> +	u8 rsvd[7];
> +	struct cxl_dc_region_config {
> +		__le64 region_base;
> +		__le64 region_decode_length;
> +		__le64 region_length;
> +		__le64 region_block_size;
> +		__le32 region_dsmad_handle;
> +		u8 flags;
> +		u8 rsvd[3];
> +	} __packed region[];
> +} __packed;
> +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
> +#define CXL_REGIONS_RETURNED(size_out) \
> +	((size_out - 8) / sizeof(struct cxl_dc_region_config))
> +
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
>  	__le64 timestamp;
> @@ -867,6 +919,7 @@ enum {
>  int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5242dbf0044d..a9b110ff1176 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -879,6 +879,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>
> +	rc =3D cxl_dev_dynamic_capacity_identify(mds);
> +	if (rc)
> +		return rc;
> +
>  	rc =3D cxl_mem_create_range_info(mds);
>  	if (rc)
>  		return rc;
>
> --
> 2.41.0
>
