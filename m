Return-Path: <linux-kernel+bounces-104533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D8E87CF5C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A111C1F219FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618963D55E;
	Fri, 15 Mar 2024 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MbAp5L/a"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8153C6AB;
	Fri, 15 Mar 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513930; cv=none; b=aopXjtPVieSMcQo7TtkY7yH+l1V6V/06L+DqF/Sps8zTf+hRjeG/On1EdqVCSFTFfanItjUgiwPR+Kcg0w8Zf5+CB5yg1Y6gl8THh6WhWJbFPOIgrk/klV1O172Xw/mdjychiTvTht0oEqjy8snxEKhVQPYj7B1TtMV7z51SxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513930; c=relaxed/simple;
	bh=/70g8O5gw0PQoUWLqnQRI0w9/5scIr2m3YRz6EGZkxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqOqcArjKYrpQ5P+XJfTeyuEnS4vJoQITVv3xYJIt6vcQ7Kebj8WDfj9/zk8615Y8Gm/042uT15y/gYIzzrTcgEC0kdbtEvYy/EJqGw7j01jijd/uOiTV4z1+O3Qko6UjBCykCVeTMwoV7qSZ14gEWvSoCjAXJFklEwUOWFNZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MbAp5L/a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FE4qNM032733;
	Fri, 15 Mar 2024 14:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HQFYfcIi6jLa+6rS+/rzWRp4aewzRJPTGTAxgFi5hgo=;
 b=MbAp5L/aP5GRkOR3R/isf0Ql1dSCKRxPL1uWvSQ+k0xiYhVeMAy7TzwNUNIhehR9wuJH
 4UToWg9RyotsZXjm+bb3jReVLJnzs5vO15JDqgd+Nz1qzf2SCpqVCBeXzEzMY2DPMPkG
 i2hXIEBvVUIui9EE3ypEK0dD2KuGjR9Ml7q8a0pvPVu9rl3mrjNUw2IoOvi54QWPBL82
 thSX6F+9MyiC2Rqv9BLmG8rLoGl/wrc+SiZeCs/Cd69rHPVioXQ+TTKJOsje6rqrDp3c
 HeR0kMUt5G5t6aq9PHnxCpP6IKFo5n8vLFPPGzcfFK8mARBMtwpKRjCL1YK4eNuK62bI PA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvnfb2jv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 14:45:26 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42FD7vmV015089;
	Fri, 15 Mar 2024 14:45:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33pcdmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 14:45:25 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42FEjMlS23200490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 14:45:24 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6249658074;
	Fri, 15 Mar 2024 14:45:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C32EF58069;
	Fri, 15 Mar 2024 14:45:21 +0000 (GMT)
Received: from [9.61.180.144] (unknown [9.61.180.144])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Mar 2024 14:45:21 +0000 (GMT)
Message-ID: <23106dfe-6e7f-41b9-9ee5-53f449fc28da@linux.ibm.com>
Date: Fri, 15 Mar 2024 10:45:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] s390/vfio-ap: Add write support to sysfs attr
 ap_config
Content-Language: en-US
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240313205807.30554-1-jjherne@linux.ibm.com>
 <20240313205807.30554-5-jjherne@linux.ibm.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20240313205807.30554-5-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: veqgjUCwgdhqyl-Oc1CTt_0XK4tjH3Ox
X-Proofpoint-GUID: veqgjUCwgdhqyl-Oc1CTt_0XK4tjH3Ox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_02,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403150119

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

On 3/13/24 4:58 PM, Jason J. Herne wrote:
> Allow writing a complete set of masks to ap_config. Doing so will
> cause the vfio-ap driver to replace the vfio-ap mediated device's
> matrix masks with the given set of masks. If the given state cannot
> be set, then no changes are made to the vfio-ap mediated device.
>
> The format of the data written to ap_config is as follows:
> {amask},{dmask},{cmask}\n
>
> \n is a newline character.
>
> amask, dmask, and cmask are masks identifying which adapters, domains,
> and control domains should be assigned to the mediated device.
>
> The format of a mask is as follows:
> 0xNN..NN
>
> Where NN..NN is 64 hexadecimal characters representing a 256-bit value.
> The leftmost (highest order) bit represents adapter/domain 0.
>
> For an example set of masks that represent your mdev's current
> configuration, simply cat ap_config.
>
> This attribute is intended to be used by an mdevctl callout script
> supporting the mdev type vfio_ap-passthrough to atomically update a
> vfio-ap mediated device's state.
>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     | 186 ++++++++++++++++++++++++--
>   drivers/s390/crypto/vfio_ap_private.h |   6 +-
>   2 files changed, 176 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 1499c2181122..05b1d311b31f 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1119,20 +1119,29 @@ static void vfio_ap_mdev_unlink_adapter(struct ap_matrix_mdev *matrix_mdev,
>   	}
>   }
>   
> -static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
> -					    unsigned long apid)
> +static void vfio_ap_mdev_hot_unplug_adapters(struct ap_matrix_mdev *matrix_mdev,
> +					    unsigned long *apids)
>   {
>   	struct vfio_ap_queue *q, *tmpq;
>   	struct list_head qlist;
> +	unsigned long apid;
> +	bool apcb_update = false;
>   
>   	INIT_LIST_HEAD(&qlist);
> -	vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, &qlist);
>   
> -	if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm)) {
> -		clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
> -		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> +	for_each_set_bit_inv(apid, apids, AP_DEVICES) {
> +		vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, &qlist);
> +
> +		if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm)) {
> +			clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
> +			apcb_update = true;
> +		}
>   	}
>   
> +	/* Only update apcb if needed to avoid impacting guest */
> +	if (apcb_update)
> +		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> +
>   	vfio_ap_mdev_reset_qlist(&qlist);
>   
>   	list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode) {
> @@ -1141,6 +1150,16 @@ static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
>   	}
>   }
>   
> +static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
> +					    unsigned long apid)
> +{
> +	DECLARE_BITMAP(apids, AP_DEVICES);
> +
> +	bitmap_zero(apids, AP_DEVICES);
> +	set_bit_inv(apid, apids);
> +	vfio_ap_mdev_hot_unplug_adapters(matrix_mdev, apids);
> +}
> +
>   /**
>    * unassign_adapter_store - parses the APID from @buf and clears the
>    * corresponding bit in the mediated matrix device's APM
> @@ -1301,20 +1320,29 @@ static void vfio_ap_mdev_unlink_domain(struct ap_matrix_mdev *matrix_mdev,
>   	}
>   }
>   
> -static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
> -					   unsigned long apqi)
> +static void vfio_ap_mdev_hot_unplug_domains(struct ap_matrix_mdev *matrix_mdev,
> +					   unsigned long *apqis)
>   {
>   	struct vfio_ap_queue *q, *tmpq;
>   	struct list_head qlist;
> +	unsigned long apqi;
> +	bool apcb_update = false;
>   
>   	INIT_LIST_HEAD(&qlist);
> -	vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, &qlist);
>   
> -	if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
> -		clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
> -		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> +	for_each_set_bit_inv(apqi, apqis, AP_DOMAINS) {
> +		vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, &qlist);
> +
> +		if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
> +			clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
> +			apcb_update = true;
> +		}
>   	}
>   
> +	/* Only update apcb if needed to avoid impacting guest */
> +	if (apcb_update)
> +		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> +
>   	vfio_ap_mdev_reset_qlist(&qlist);
>   
>   	list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode) {
> @@ -1323,6 +1351,16 @@ static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
>   	}
>   }
>   
> +static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
> +					   unsigned long apqi)
> +{
> +	DECLARE_BITMAP(apqis, AP_DOMAINS);
> +
> +	bitmap_zero(apqis, AP_DEVICES);
> +	set_bit_inv(apqi, apqis);
> +	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, apqis);
> +}
> +
>   /**
>    * unassign_domain_store - parses the APQI from @buf and clears the
>    * corresponding bit in the mediated matrix device's AQM
> @@ -1590,10 +1628,132 @@ static ssize_t ap_config_show(struct device *dev, struct device_attribute *attr,
>   	return idx;
>   }
>   
> +/* Number of characters needed for a complete hex mask representing the bits in ..  */
> +#define AP_DEVICES_STRLEN	(AP_DEVICES/4 + 3)
> +#define AP_DOMAINS_STRLEN	(AP_DOMAINS/4 + 3)
> +#define AP_CONFIG_STRLEN	(AP_DEVICES_STRLEN + 2 * AP_DOMAINS_STRLEN)
> +
> +static int parse_bitmap(char **strbufptr, unsigned long *bitmap, int nbits)
> +{
> +	char *curmask;
> +
> +	curmask = strsep(strbufptr, ",\n");
> +	if (!curmask)
> +		return -EINVAL;
> +
> +	bitmap_clear(bitmap, 0, nbits);
> +	return ap_hex2bitmap(curmask, bitmap, nbits);
> +}
> +
> +static int ap_matrix_overflow_check(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	unsigned long bit;
> +
> +	for_each_set_bit_inv(bit, matrix_mdev->matrix.apm, AP_DEVICES) {
> +		if (bit > matrix_mdev->matrix.apm_max)
> +			return -ENODEV;
> +	}
> +
> +	for_each_set_bit_inv(bit, matrix_mdev->matrix.aqm, AP_DOMAINS) {
> +		if (bit > matrix_mdev->matrix.aqm_max)
> +			return -ENODEV;
> +	}
> +
> +	for_each_set_bit_inv(bit, matrix_mdev->matrix.adm, AP_DOMAINS) {
> +		if (bit > matrix_mdev->matrix.adm_max)
> +			return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ap_matrix_copy(struct ap_matrix *dst, struct ap_matrix *src)
> +{
> +	bitmap_copy(dst->apm, src->apm, AP_DEVICES);
> +	bitmap_copy(dst->aqm, src->aqm, AP_DOMAINS);
> +	bitmap_copy(dst->adm, src->adm, AP_DOMAINS);
> +}
> +
>   static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr,
>   			       const char *buf, size_t count)
>   {
> -	return count;
> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
> +	struct ap_matrix m_new, m_old, m_added, m_removed;
> +	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
> +	unsigned long newbit;
> +	char *newbuf, *rest;
> +	int rc = count;
> +	bool do_update;
> +
> +	newbuf = rest = kstrndup(buf, AP_CONFIG_STRLEN, GFP_KERNEL);
> +	if (!newbuf)
> +		return -ENOMEM;
> +
> +	mutex_lock(&ap_perms_mutex);
> +	get_update_locks_for_mdev(matrix_mdev);
> +
> +	/* Save old state */
> +	ap_matrix_copy(&m_old, &matrix_mdev->matrix);
> +
> +	if (parse_bitmap(&rest, m_new.apm, AP_DEVICES) ||
> +	    parse_bitmap(&rest, m_new.aqm, AP_DOMAINS) ||
> +	    parse_bitmap(&rest, m_new.adm, AP_DOMAINS)) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	bitmap_andnot(m_removed.apm, m_old.apm, m_new.apm, AP_DEVICES);
> +	bitmap_andnot(m_removed.aqm, m_old.aqm, m_new.aqm, AP_DOMAINS);
> +	bitmap_andnot(m_added.apm, m_new.apm, m_old.apm, AP_DEVICES);
> +	bitmap_andnot(m_added.aqm, m_new.aqm, m_old.aqm, AP_DOMAINS);
> +
> +	/* Need new bitmaps in matrix_mdev for validation */
> +	ap_matrix_copy(&matrix_mdev->matrix, &m_new);
> +
> +	/* Ensure new state is valid, else undo new state */
> +	rc = vfio_ap_mdev_validate_masks(matrix_mdev);
> +	if (rc) {
> +		ap_matrix_copy(&matrix_mdev->matrix, &m_old);
> +		goto out;
> +	}
> +	rc = ap_matrix_overflow_check(matrix_mdev);
> +	if (rc) {
> +		ap_matrix_copy(&matrix_mdev->matrix, &m_old);
> +		goto out;
> +	}
> +	rc = count;
> +
> +	/* Need old bitmaps in matrix_mdev for unplug/unlink */
> +	ap_matrix_copy(&matrix_mdev->matrix, &m_old);
> +
> +	/* Unlink removed adapters/domains */
> +	vfio_ap_mdev_hot_unplug_adapters(matrix_mdev, m_removed.apm);
> +	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, m_removed.aqm);
> +
> +	/* Need new bitmaps in matrix_mdev for linking new adapters/domains */
> +	ap_matrix_copy(&matrix_mdev->matrix, &m_new);
> +
> +	/* Link newly added adapters */
> +	for_each_set_bit_inv(newbit, m_added.apm, AP_DEVICES)
> +		vfio_ap_mdev_link_adapter(matrix_mdev, newbit);
> +
> +	for_each_set_bit_inv(newbit, m_added.aqm, AP_DOMAINS)
> +		vfio_ap_mdev_link_domain(matrix_mdev, newbit);
> +
> +	/* filter resources not bound to vfio-ap */
> +	do_update = vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered);
> +	do_update |= vfio_ap_mdev_filter_cdoms(matrix_mdev);
> +
> +	/* Apply changes to shadow apbc if things changed */
> +	if (do_update) {
> +		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> +		reset_queues_for_apids(matrix_mdev, apm_filtered);
> +	}
> +out:
> +	release_update_locks_for_mdev(matrix_mdev);
> +	mutex_unlock(&ap_perms_mutex);
> +	kfree(newbuf);
> +	return rc;
>   }
>   static DEVICE_ATTR_RW(ap_config);
>   
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 98d37aa27044..437a161c8659 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -75,11 +75,11 @@ extern struct ap_matrix_dev *matrix_dev;
>    */
>   struct ap_matrix {
>   	unsigned long apm_max;
> -	DECLARE_BITMAP(apm, 256);
> +	DECLARE_BITMAP(apm, AP_DEVICES);
>   	unsigned long aqm_max;
> -	DECLARE_BITMAP(aqm, 256);
> +	DECLARE_BITMAP(aqm, AP_DOMAINS);
>   	unsigned long adm_max;
> -	DECLARE_BITMAP(adm, 256);
> +	DECLARE_BITMAP(adm, AP_DOMAINS);
>   };
>   
>   /**

