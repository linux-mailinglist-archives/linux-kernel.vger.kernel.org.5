Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252EF7846AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbjHVQOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjHVQOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:14:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2849CE4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:14:36 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MG1L2k008589;
        Tue, 22 Aug 2023 16:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yC5f33Ob4/TsP6gqRM1f9CgoFNkgmI1O4+HZP8dDm/8=;
 b=i9ojrL97z3xPv1C6+EZFLQkmfuM4z/fFYT43DodIto7CpxBiUsFq2dtTqOsdHv7TjXfG
 9c8TYNWQpnKaXhee1o/3tBwTFUQ80qn9KeLtd4L+W9AePVUy9FEdtAl5gmrbJROzuYgJ
 mnEw4hkQoE0yZOa4kG8VuWZgN3cHGaUuggOS+b4Y45EmX0u47cvibQyuFx88WIQrjmrZ
 LIodQsjTZ1TlOK2O/ZemrGM46mgHcZb5YQ9QjvSN3t9dtngQ00206qn01T0Vb6oMQiur
 04LUPnfN6dZXDHILiFlSlraVqZPQFRHi5VCeEBqa5gBGTBPFLWb0vcu0d0QwNJj1a7ZF 7A== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sn05w91fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 16:14:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37MEpej0020687;
        Tue, 22 Aug 2023 16:14:18 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sk9jkmrrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 16:14:18 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37MGEHXk65995120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 16:14:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D50258062;
        Tue, 22 Aug 2023 16:14:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17BB558059;
        Tue, 22 Aug 2023 16:14:16 +0000 (GMT)
Received: from [9.67.101.231] (unknown [9.67.101.231])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 22 Aug 2023 16:14:15 +0000 (GMT)
Message-ID: <6cea8ee7-f845-6ef3-631f-3f252ff5e949@linux.vnet.ibm.com>
Date:   Tue, 22 Aug 2023 11:14:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] soc/aspeed: Add host side BMC device driver
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>, Ninad Palsule <ninad@linux.ibm.com>
Cc:     joel@jms.id.au, andrew@aj.id.au, eajames@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
References: <20230821183525.3427144-1-ninad@linux.ibm.com>
 <20230821183525.3427144-2-ninad@linux.ibm.com>
 <5159abb8-1b4c-4576-b370-4dd9db142beb@lunn.ch>
From:   Ninad Palsule <ninad@linux.vnet.ibm.com>
In-Reply-To: <5159abb8-1b4c-4576-b370-4dd9db142beb@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jw-rUKEt0Unr8q74GG93j6Xch7D8yZe1
X-Proofpoint-ORIG-GUID: Jw-rUKEt0Unr8q74GG93j6Xch7D8yZe1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 clxscore=1011 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220124
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

Thanks for the review.

On 8/21/23 2:29 PM, Andrew Lunn wrote:
>> Testing:
>>    - This is tested on IBM rainier system with BMC. It requires BMC side
>>      BMC device driver which is available in the ASPEED's 5.15 SDK
>>      kernel.
> How relevant is that? To the host side, it just appears to be an
> 16550A. Is the SDK emulating an 16550A? If you where to use a
> different kernel, is it still guaranteed to be an 16550A? I also
> notice there is a mainline
> drivers/tty/serial/8250/8250_aspeed_vuart.c. Could that be used on the
> BMC? That would be a better testing target than the vendor kernel.

This is just to indicate how I tested my code.

Yes, aspeed chip (in this case ast2600) is compatible with 16550 UART.

I am guessing it should work with different kernel too as 16550 standard 
is used.

The 8250_aspeed_vuart.c is a BMC side driver for accessing VUART over 
LPC bus and

this is a host side driver to access VUART over PCIe bus.

>> +config ASPEED_HOST_BMC_DEV
>> +	bool "ASPEED SoC Host BMC device driver"
>> +	default ARCH_ASPEED
>> +	select SOC_BUS
>> +	default ARCH_ASPEED
> same default twice?
Removed.
>
>> +static int __init aspeed_host_bmc_device_init(void)
>> +{
>> +	int ret;
>> +
>> +	/* register pci driver */
>> +	ret = pci_register_driver(&aspeed_host_bmc_dev_driver);
>> +	if (ret < 0) {
>> +		pr_err("pci-driver: can't register pci driver\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +
>> +}
>> +
>> +static void aspeed_host_bmc_device_exit(void)
>> +{
>> +	/* unregister pci driver */
>> +	pci_unregister_driver(&aspeed_host_bmc_dev_driver);
>> +}
>> +
>> +late_initcall(aspeed_host_bmc_device_init);
>> +module_exit(aspeed_host_bmc_device_exit);
> It looks like you can use module_pci_driver() ?
yes, It should work unless the late initcall is important. I will test 
it and see.

Thanks & Regards,

Ninad Palsule

