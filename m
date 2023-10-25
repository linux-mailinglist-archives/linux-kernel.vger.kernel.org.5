Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F547D64BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjJYIRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjJYIRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:17:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66EB0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:17:14 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39P89Wq1018370;
        Wed, 25 Oct 2023 08:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=A2uw3UuwQ8KCnit9kWh7BpC0c08GN8NdE77ZiNSkcaw=;
 b=YzkJeEBvUYMiE+OsFXUPniookCZGQVfluunI0YKTwQMn826NWAHKAjhwO3xNyWYskxg7
 2hjjn2LpnSh3R55dDLNj93miD50dLS9UyBdQuEuItZGT5wpfQ7RI1q6rOYQu826m8J2M
 Ze8vrUfbvN55zbPwlpIlyBx0knv4bnh/g4aMyePwi2lYk0K10EF1JtFBFR6DsmujJjra
 gNZQCdoNU4/bfDS94W2Ygw4eczLtp1E7m3vPlPrVz0w54MVCzXI5Em9TJvbKSPvxF+BZ
 B1grGPhqX5WOe2y0H3h2sMfs2NAIxyDcWGEb574ezscIO1uhIrNygiD+QLatvavCGzQr YA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3txy8u0fur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 08:17:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39P73fTs010290;
        Wed, 25 Oct 2023 08:16:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbynepy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 08:16:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39P8Gubb18940600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 08:16:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 184EF20043;
        Wed, 25 Oct 2023 08:16:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B330B20040;
        Wed, 25 Oct 2023 08:16:55 +0000 (GMT)
Received: from [9.171.32.46] (unknown [9.171.32.46])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Oct 2023 08:16:55 +0000 (GMT)
Message-ID: <9573ec63-a8d6-4c69-a70b-9095838d521d@linux.ibm.com>
Date:   Wed, 25 Oct 2023 10:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: make cxl_class constant
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <2023102434-haiku-uphill-0c11@gregkh>
Content-Language: en-US
From:   Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <2023102434-haiku-uphill-0c11@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DNlKNOt5L6DbWH-N_5lNSx63TUppcBK4
X-Proofpoint-GUID: DNlKNOt5L6DbWH-N_5lNSx63TUppcBK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=963 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/2023 13:48, Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, we should make all 'class' structures declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at runtime.
> 
> Cc: Frederic Barrat <fbarrat@linux.ibm.com>
> Cc: Andrew Donnellan <ajd@linux.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Thanks!
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>

   Fred


>   drivers/misc/cxl/file.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index 144d1f2d78ce..012e11b959bc 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -38,8 +38,6 @@
>   
>   static dev_t cxl_dev;
>   
> -static struct class *cxl_class;
> -
>   static int __afu_open(struct inode *inode, struct file *file, bool master)
>   {
>   	struct cxl *adapter;
> @@ -559,7 +557,10 @@ static char *cxl_devnode(const struct device *dev, umode_t *mode)
>   	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
>   }
>   
> -extern struct class *cxl_class;
> +static const struct class cxl_class = {
> +	.name =		"cxl",
> +	.devnode =	cxl_devnode,
> +};
>   
>   static int cxl_add_chardev(struct cxl_afu *afu, dev_t devt, struct cdev *cdev,
>   			   struct device **chardev, char *postfix, char *desc,
> @@ -575,7 +576,7 @@ static int cxl_add_chardev(struct cxl_afu *afu, dev_t devt, struct cdev *cdev,
>   		return rc;
>   	}
>   
> -	dev = device_create(cxl_class, &afu->dev, devt, afu,
> +	dev = device_create(&cxl_class, &afu->dev, devt, afu,
>   			"afu%i.%i%s", afu->adapter->adapter_num, afu->slice, postfix);
>   	if (IS_ERR(dev)) {
>   		rc = PTR_ERR(dev);
> @@ -633,14 +634,14 @@ void cxl_chardev_afu_remove(struct cxl_afu *afu)
>   
>   int cxl_register_afu(struct cxl_afu *afu)
>   {
> -	afu->dev.class = cxl_class;
> +	afu->dev.class = &cxl_class;
>   
>   	return device_register(&afu->dev);
>   }
>   
>   int cxl_register_adapter(struct cxl *adapter)
>   {
> -	adapter->dev.class = cxl_class;
> +	adapter->dev.class = &cxl_class;
>   
>   	/*
>   	 * Future: When we support dynamically reprogramming the PSL & AFU we
> @@ -678,13 +679,11 @@ int __init cxl_file_init(void)
>   
>   	pr_devel("CXL device allocated, MAJOR %i\n", MAJOR(cxl_dev));
>   
> -	cxl_class = class_create("cxl");
> -	if (IS_ERR(cxl_class)) {
> +	rc = class_register(&cxl_class);
> +	if (rc) {
>   		pr_err("Unable to create CXL class\n");
> -		rc = PTR_ERR(cxl_class);
>   		goto err;
>   	}
> -	cxl_class->devnode = cxl_devnode;
>   
>   	return 0;
>   
> @@ -696,5 +695,5 @@ int __init cxl_file_init(void)
>   void cxl_file_exit(void)
>   {
>   	unregister_chrdev_region(cxl_dev, CXL_NUM_MINORS);
> -	class_destroy(cxl_class);
> +	class_unregister(&cxl_class);
>   }
