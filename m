Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440F87E365A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjKGIH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKGIHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:07:54 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F461114;
        Tue,  7 Nov 2023 00:07:51 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A785Jln014630;
        Tue, 7 Nov 2023 08:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : reply-to : in-reply-to : references :
 message-id : content-type : content-transfer-encoding; s=pp1;
 bh=7gzP5LHnhJ3AXPiMA6NlNzNXHze64ekcT/WiS/MQFXE=;
 b=hUd2Q7HEY75KAFAuyrPOyr6BifhKE73ofZ9lCeqvdmgPXZZ+48bXprEeCWSS9ZwjPmZE
 m28x4tCDW6IpUXvKRqPU3YZ23rv3567eQ1lYCFc4WitUwRibLNnhBtfSL8agxQZ8KNwx
 m9QZ+4mhbrmw6TR7m5/PA2zLZCrHm5X2FxNtwPNXjQTqUDaXF7jlmBlW3Sw4yMOTvRxM
 X/+bI++Z3xZbNabMN6mepJ9Fk69FUcC1w4gvst8CxOf3vzj8I+h9+FrgvTbikUlZOJDk
 iR/P3f0eZU5oPj89xx+MkoUwfiLdk1lhryzxI2cmWgSfEQgRsrkAxZvbkRwfZLU2syTl oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7hds02dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 08:07:49 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A785bmB015479;
        Tue, 7 Nov 2023 08:07:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7hds02db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 08:07:49 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A77o4XI007930;
        Tue, 7 Nov 2023 08:07:48 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u61skf2y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 08:07:48 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A787laY19071708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Nov 2023 08:07:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3206A58056;
        Tue,  7 Nov 2023 08:07:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2C0258052;
        Tue,  7 Nov 2023 08:07:45 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Nov 2023 08:07:45 +0000 (GMT)
MIME-Version: 1.0
Date:   Tue, 07 Nov 2023 09:07:45 +0100
From:   Harald Freudenberger <freude@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH] s390/vfio-ap: fix sysfs status attribute for AP queue
 devices
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <cff6c61d-71a9-4dcc-a12a-5160b67d9ae4@linux.ibm.com>
References: <20231020204838.409521-1-akrowiak@linux.ibm.com>
 <cff6c61d-71a9-4dcc-a12a-5160b67d9ae4@linux.ibm.com>
Message-ID: <12aef605a2add44afca75cc647674cdb@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tmWVeew_3h_S2pzJnbsGxvmefs5_KwGX
X-Proofpoint-ORIG-GUID: BagmgpN2EuyEMsUB9Md3k2Uukfq4HaPt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-06 17:03, Tony Krowiak wrote:
> PING
> This patch is pretty straight forward, does anyone see a reason why
> this shouldn't be integrated?
> 
> On 10/20/23 16:48, Tony Krowiak wrote:
>> The 'status' attribute for AP queue devices bound to the vfio_ap 
>> device
>> driver displays incorrect status when the mediated device is attached 
>> to a
>> guest, but the queue device is not passed through. In the current
>> implementation, the status displayed is 'in_use' which is not correct; 
>> it
>> should be 'assigned'. This can happen if one of the queue devices
>> associated with a given adapter is not bound to the vfio_ap device 
>> driver.
>> For example:
>> 
>> Queues listed in /sys/bus/ap/drivers/vfio_ap:
>> 14.0005
>> 14.0006
>> 14.000d
>> 16.0006
>> 16.000d
>> 
>> Queues listed in /sys/devices/vfio_ap/matrix/$UUID/matrix
>> 14.0005
>> 14.0006
>> 14.000d
>> 16.0005
>> 16.0006
>> 16.000d
>> 
>> Queues listed in /sys/devices/vfio_ap/matrix/$UUID/guest_matrix
>> 14.0005
>> 14.0006
>> 14.000d
>> 
>> The reason no queues for adapter 0x16 are listed in the guest_matrix 
>> is
>> because queue 16.0005 is not bound to the vfio_ap device driver, so no
>> queue associated with the adapter is passed through to the guest;
>> therefore, each queue device for adapter 0x16 should display 
>> 'assigned'
>> instead of 'in_use', because those queues are not in use by a guest, 
>> but
>> only assigned to the mediated device.
>> 
>> Let's check the AP configuration for the guest to determine whether a
>> queue device is passed through before displaying a status of 'in_use'.
>> 
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Fixes: f139862b92cf ("s390/vfio-ap: add status attribute to AP queue 
>> device's sysfs dir")
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 4db538a55192..871c14a6921f 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -1976,6 +1976,7 @@ static ssize_t status_show(struct device *dev,
>>   {
>>   	ssize_t nchars = 0;
>>   	struct vfio_ap_queue *q;
>> +	unsigned long apid, apqi;
>>   	struct ap_matrix_mdev *matrix_mdev;
>>   	struct ap_device *apdev = to_ap_dev(dev);
>>   @@ -1984,7 +1985,11 @@ static ssize_t status_show(struct device 
>> *dev,
>>   	matrix_mdev = vfio_ap_mdev_for_queue(q);
>>     	if (matrix_mdev) {
>> -		if (matrix_mdev->kvm)
>> +		apid = AP_QID_CARD(q->apqn);
>> +		apqi = AP_QID_QUEUE(q->apqn);
>> +		if (matrix_mdev->kvm &&
>> +		    test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
>> +		    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
>>   			nchars = scnprintf(buf, PAGE_SIZE, "%s\n",
>>   					   AP_QUEUE_IN_USE);
>>   		else

I can give you an
Acked-by: Harald Freudenberger <freude@linux.ibm.com>
for this. Your explanation sounds sane to me and fixes a wrong
display. However, I am not familiar with the code so, I can't tell
if that's correct.
Just a remark: How can it happen that one queue is not bound to the vfio 
dd?
Didn't we actively remove the unbind possibility from the sysfs for 
devices
assigned to the vfio dd?
