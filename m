Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7307E792F5F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242186AbjIET4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjIET4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:56:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E191AB;
        Tue,  5 Sep 2023 12:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1693943801; x=1694548601; i=fan.ni@gmx.us;
 bh=fH5fl2iT7bJK58HYQS61E8lV0EElinXPEGRDeSG774o=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=sIbOg/13QgrWZTAnXi+N/5zBxKEmvxiMSSTzrJ2p5jw97RUc1M4V2EMk0RckDttucTbxDXD
 UWuCQ8bpb1ObvHtk+yePEB6ZdoQ130dOCURiqYOe1Rp0UvcPSKKW05buNFPfWrkNcNd2q+sxD
 n8scVq4ytZPy3PVqVRj5fxERVYUbLC/XxAMjyCDsUyw1pMiybRo5//NwHo5s/sil7ybkQV0iL
 NArbTJ02b1kFnD7ODROBMFZc9z2wDt7+Mm0rEtu2JI0rj9zywibRPoKvGFV9Wj+V33CnrxOt9
 AKDxG6op/sYvr2XZRfsG53lXQN/EiyU7bXl3pYxvouLuN8bpy8NA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([50.205.20.42]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MORAU-1qI4sX1A10-00Pxua; Tue, 05
 Sep 2023 19:55:23 +0200
Date:   Tue, 5 Sep 2023 10:55:12 -0700
From:   Fan Ni <fan.ni@gmx.us>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 07/18] cxl/mem: Expose device dynamic capacity
 configuration
Message-ID: <ZPdrgN9mt8oIxil0@debian>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-7-f740c47e7916@intel.com>
 <20230829161449.00000c7a@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829161449.00000c7a@Huawei.com>
X-Provags-ID: V03:K1:7FPfXhisLSI5kaGGZv7QSee2tVduCM+GGxg07v26LnQxmJb/e2Y
 FbZ8OozFEEM/40NKV6fLI4a0kSuNBMG2KRFpV0QCAvoUha4X23E0SGNyxQIp1nHuLTTRsGN
 Xbselzcygt4H8Lt0lP94xfuCecNICDqX8Ozo9sB2RSPL1ORa/wVptzyNvMAyJqFpqQ2kfg+
 /DGjsm5aILKhJGgxS1baw==
UI-OutboundReport: notjunk:1;M01:P0:0w8GjRTky48=;3F3nJFdQAnPV2FCoraDBQRYPbdV
 7rV9e5EKoIgOHv+HKfvO8zPNGqFgSK6wAoVAlT8O3UrrhwUysgQzKDGXerQVMSk4gxI86inKa
 Zi3sDFMwevK0FN3dcwdkKu6zEBcrQoS/NIMyPqSnvf66cgEW8RNzPWpkRMalwr79pSTnWrB2C
 jfPbGofYzTHinYisduwUoyZUE5pgJc01E5unlidWOwdXWGRzkDhVxGl5nZfYLPofculBCYcRy
 Ji/siB7unuefEdiyg3D/aeQRPjc1AU3z4csPDubGBjIGU+MrQydr+QOKYgxx5vYgkbeLXV64o
 hnHjuRno0daFZvEmP1b2pIlcFZRMBpELtbBxs4k1itSCovvewhiORZrF9DsJsa7L4s+fYCAAN
 YfMmc5QY4MdGZXjidFf4ldGH9gWc0CxBs8kyeS06NPR4n7sMD+s0oNs0pgvyFKjZ+3gYyC3lb
 fmqNWD01kwgeiLmiYTzN/QhdFczpwmpmuhdh7RXV18GGqssTE+G6BMrlC+JizwST3ZgkQpbep
 fJA2SO91FLS8uOqTC79UrsgFXhUbodgOHriWMrkWSwY09uBEZtIUAUkjQ3XDAGP/84ihE7SHK
 les8bAY8b4WAHzCG8fadBSsC+VVhebpstN2H+CcjzfD2Ww5j7ZcyKS0h+XF85a/FjgHcrBkNy
 UTBGCKwx+qMX6cCwaXvIcqowSSxSdg327GivaLDAFoc0496s5IH+s63pZ6jd6cG+JoIl3uTA/
 2z2CUEs87uflfU7SfsxoVhMNGFQ3AdAQXNsIYwmGreojaOnZWxesBEdXGc5ym+pfX3clQusbx
 4WO9basreyl/vRFLxxBRy+J7EJrPQvqNnfm0YIOt0zI6qZUfPo8186i2L7PI3KO3/UeY1Y7KO
 YFDjvWl8dh7FDh5LHqi9QltjmQVgUI6Pfv1/fa4RrTe/MZUbTJAq95k9kP4pd32k5Ijm1oOFG
 jz64tAXnRH2bGBItDH2SbY7knQ8=
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

On Tue, Aug 29, 2023 at 04:14:49PM +0100, Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:20:58 -0700
> ira.weiny@intel.com wrote:
>
> > From: Navneet Singh <navneet.singh@intel.com>
> >
> > To properly configure CXL regions on Dynamic Capacity Devices (DCD),
> > user space will need to know the details of the DC Regions available o=
n
> > a device.
> >
> > Expose driver dynamic capacity configuration through sysfs
> > attributes.
> >
> > Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> One trivial comment inline.  I wondered a bit if it would
> be better to not present dc at all on devices that don't support
> dynamic capacity, but for now there isn't an elegant way to do that
> (some discussions and patches are flying around however so maybe this
>  will be resolved before this series merges giving us that elegant
>  option).
>
> With commented code tidied up
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>

Agreed. It makes more sense to not show dc at all.
Other than that, looks good to me.

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>
> > ---
> > Changes for v2:
> > [iweiny: Rebased on latest master/type2 work]
> > [iweiny: add documentation for sysfs entries]
> > [iweiny: s/dc_regions_count/region_count/]
> > [iweiny: s/dcY_size/regionY_size/]
> > [alison: change size format to %#llx]
> > [iweiny: change count format to %d]
> > [iweiny: Formatting updates]
> > [iweiny: Fix crash when device is not a mem device: found with cxl-tes=
t]
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 17 ++++++++
> >  drivers/cxl/core/memdev.c               | 77 ++++++++++++++++++++++++=
+++++++++
> >  2 files changed, 94 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/A=
BI/testing/sysfs-bus-cxl
> > index 2268ffcdb604..aa65dc5b4e13 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -37,6 +37,23 @@ Description:
> >  		identically named field in the Identify Memory Device Output
> >  		Payload in the CXL-2.0 specification.
> >
> > +What:		/sys/bus/cxl/devices/memX/dc/region_count
> > +Date:		July, 2023
> > +KernelVersion:	v6.6
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) Number of Dynamic Capacity (DC) regions supported on the
> > +		device.  May be 0 if the device does not support Dynamic
> > +		Capacity.
> > +
> > +What:		/sys/bus/cxl/devices/memX/dc/regionY_size
> > +Date:		July, 2023
> > +KernelVersion:	v6.6
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) Size of the Dynamic Capacity (DC) region Y.  Only
> > +		available on devices which support DC and only for those
> > +		region indexes supported by the device.
> >
> >  What:		/sys/bus/cxl/devices/memX/serial
> >  Date:		January, 2022
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 492486707fd0..397262e0ebd2 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -101,6 +101,20 @@ static ssize_t pmem_size_show(struct device *dev,=
 struct device_attribute *attr,
> >  static struct device_attribute dev_attr_pmem_size =3D
> >  	__ATTR(size, 0444, pmem_size_show, NULL);
> >
> > +static ssize_t region_count_show(struct device *dev, struct device_at=
tribute *attr,
> > +				 char *buf)
> > +{
> > +	struct cxl_memdev *cxlmd =3D to_cxl_memdev(dev);
> > +	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlmd->cxlds);
> > +	int len =3D 0;
> > +
> > +	len =3D sysfs_emit(buf, "%d\n", mds->nr_dc_region);
> > +	return len;
>
> return sysfs_emit(buf, "...);
>
> > +}
> > +
> > +struct device_attribute dev_attr_region_count =3D
> > +	__ATTR(region_count, 0444, region_count_show, NULL);
> > +
> >  static ssize_t serial_show(struct device *dev, struct device_attribut=
e *attr,
> >  			   char *buf)
> >  {
> > @@ -454,6 +468,62 @@ static struct attribute *cxl_memdev_security_attr=
ibutes[] =3D {
> >  	NULL,
> >  };
> >
> > +static ssize_t show_size_regionN(struct cxl_memdev *cxlmd, char *buf,=
 int pos)
> > +{
> > +	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlmd->cxlds);
> > +
> > +	return sysfs_emit(buf, "%#llx\n", mds->dc_region[pos].decode_len);
> > +}
> > +
> > +#define REGION_SIZE_ATTR_RO(n)						\
> > +static ssize_t region##n##_size_show(struct device *dev,		\
> > +				     struct device_attribute *attr,	\
> > +				     char *buf)				\
> > +{									\
> > +	return show_size_regionN(to_cxl_memdev(dev), buf, (n));		\
> > +}									\
> > +static DEVICE_ATTR_RO(region##n##_size)
> > +REGION_SIZE_ATTR_RO(0);
> > +REGION_SIZE_ATTR_RO(1);
> > +REGION_SIZE_ATTR_RO(2);
> > +REGION_SIZE_ATTR_RO(3);
> > +REGION_SIZE_ATTR_RO(4);
> > +REGION_SIZE_ATTR_RO(5);
> > +REGION_SIZE_ATTR_RO(6);
> > +REGION_SIZE_ATTR_RO(7);
> > +
> > +static struct attribute *cxl_memdev_dc_attributes[] =3D {
> > +	&dev_attr_region0_size.attr,
> > +	&dev_attr_region1_size.attr,
> > +	&dev_attr_region2_size.attr,
> > +	&dev_attr_region3_size.attr,
> > +	&dev_attr_region4_size.attr,
> > +	&dev_attr_region5_size.attr,
> > +	&dev_attr_region6_size.attr,
> > +	&dev_attr_region7_size.attr,
> > +	&dev_attr_region_count.attr,
> > +	NULL,
> > +};
> > +
> > +static umode_t cxl_dc_visible(struct kobject *kobj, struct attribute =
*a, int n)
> > +{
> > +	struct device *dev =3D kobj_to_dev(kobj);
> > +	struct cxl_memdev *cxlmd =3D to_cxl_memdev(dev);
> > +	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlmd->cxlds);
> > +
> > +	/* Not a memory device */
> > +	if (!mds)
> > +		return 0;
> > +
> > +	if (a =3D=3D &dev_attr_region_count.attr)
> > +		return a->mode;
> > +
> > +	if (n < mds->nr_dc_region)
> > +		return a->mode;
> > +
> > +	return 0;
> > +}
> > +
> >  static umode_t cxl_memdev_visible(struct kobject *kobj, struct attrib=
ute *a,
> >  				  int n)
> >  {
> > @@ -482,11 +552,18 @@ static struct attribute_group cxl_memdev_securit=
y_attribute_group =3D {
> >  	.attrs =3D cxl_memdev_security_attributes,
> >  };
> >
> > +static struct attribute_group cxl_memdev_dc_attribute_group =3D {
> > +	.name =3D "dc",
> > +	.attrs =3D cxl_memdev_dc_attributes,
> > +	.is_visible =3D cxl_dc_visible,
> > +};
> > +
> >  static const struct attribute_group *cxl_memdev_attribute_groups[] =
=3D {
> >  	&cxl_memdev_attribute_group,
> >  	&cxl_memdev_ram_attribute_group,
> >  	&cxl_memdev_pmem_attribute_group,
> >  	&cxl_memdev_security_attribute_group,
> > +	&cxl_memdev_dc_attribute_group,
> >  	NULL,
> >  };
> >
> >
>
