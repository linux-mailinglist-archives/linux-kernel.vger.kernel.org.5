Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A67785EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbjHWRdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjHWRdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:33:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F4E7E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:32:58 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NHTvAf004129;
        Wed, 23 Aug 2023 17:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yhPUGJp1hbDPP2WngAKxhzRDOvm7F81esNVKWbVBMZ0=;
 b=LG5mt7XXMhUYxOWuM3nqqQKBdPHjzrvvwnOelv7rG3aNeQWA2mWllEHDd1WC7de/9+WC
 965NuWGtJN0EBYRD10q8QXk4JDLYGCxvMSJTFN++ykRXaZiFK+wGy42DkGZURKfjYtlb
 ZMjsEnIU/IRz1cX/+5TYJsqeX+Jc/fSa2Cbqs7M7pLrWshS09QNfu4Cn8+G4iQ4AoVDi
 SOEpd18TbYRKm5vd6FDn0/CJdmZHpsN/CiYjcOO+8Xz1SD4YQP1XmT6wiTNPPm+dgtPd
 FxXqtMgCsBUUHCo2jCROYGhSXtLm2X94DNNhaQtcZ1qCqdbqouI0aNcfpj5y8QCnUWhY rg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snpjmg26n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 17:32:40 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37NGnPb4004055;
        Wed, 23 Aug 2023 17:32:39 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn21rg5rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 17:32:38 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37NHWbNm21168584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 17:32:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5CA558050;
        Wed, 23 Aug 2023 17:32:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4736B58056;
        Wed, 23 Aug 2023 17:32:36 +0000 (GMT)
Received: from [9.67.101.231] (unknown [9.67.101.231])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 23 Aug 2023 17:32:36 +0000 (GMT)
Message-ID: <5c918888-6933-7661-45f0-32ae4521aa2c@linux.vnet.ibm.com>
Date:   Wed, 23 Aug 2023 12:32:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] soc/aspeed: Add host side BMC device driver
Content-Language: en-US
From:   Ninad Palsule <ninad@linux.vnet.ibm.com>
To:     Andrew Lunn <andrew@lunn.ch>, Ninad Palsule <ninad@linux.ibm.com>
Cc:     joel@jms.id.au, andrew@aj.id.au, eajames@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
References: <20230821183525.3427144-1-ninad@linux.ibm.com>
 <20230821183525.3427144-2-ninad@linux.ibm.com>
 <5159abb8-1b4c-4576-b370-4dd9db142beb@lunn.ch>
 <6cea8ee7-f845-6ef3-631f-3f252ff5e949@linux.vnet.ibm.com>
In-Reply-To: <6cea8ee7-f845-6ef3-631f-3f252ff5e949@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1mv__vacMC-yZ399KpgyNPqZKlLTnK9L
X-Proofpoint-ORIG-GUID: 1mv__vacMC-yZ399KpgyNPqZKlLTnK9L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_12,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230159
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On 8/22/23 11:14 AM, Ninad Palsule wrote:
> Hello Andrew,
>
> Thanks for the review.
>
> On 8/21/23 2:29 PM, Andrew Lunn wrote:
>>> Testing:
>>>    - This is tested on IBM rainier system with BMC. It requires BMC 
>>> side
>>>      BMC device driver which is available in the ASPEED's 5.15 SDK
>>>      kernel.
>> How relevant is that? To the host side, it just appears to be an
>> 16550A. Is the SDK emulating an 16550A? If you where to use a
>> different kernel, is it still guaranteed to be an 16550A? I also
>> notice there is a mainline
>> drivers/tty/serial/8250/8250_aspeed_vuart.c. Could that be used on the
>> BMC? That would be a better testing target than the vendor kernel.
>
> This is just to indicate how I tested my code.
>
> Yes, aspeed chip (in this case ast2600) is compatible with 16550 UART.
>
> I am guessing it should work with different kernel too as 16550 
> standard is used.
>
> The 8250_aspeed_vuart.c is a BMC side driver for accessing VUART over 
> LPC bus and
>
> this is a host side driver to access VUART over PCIe bus.
>
>>> +config ASPEED_HOST_BMC_DEV
>>> +    bool "ASPEED SoC Host BMC device driver"
>>> +    default ARCH_ASPEED
>>> +    select SOC_BUS
>>> +    default ARCH_ASPEED
>> same default twice?
> Removed.
>>
>>> +static int __init aspeed_host_bmc_device_init(void)
>>> +{
>>> +    int ret;
>>> +
>>> +    /* register pci driver */
>>> +    ret = pci_register_driver(&aspeed_host_bmc_dev_driver);
>>> +    if (ret < 0) {
>>> +        pr_err("pci-driver: can't register pci driver\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +
>>> +}
>>> +
>>> +static void aspeed_host_bmc_device_exit(void)
>>> +{
>>> +    /* unregister pci driver */
>>> +    pci_unregister_driver(&aspeed_host_bmc_dev_driver);
>>> +}
>>> +
>>> +late_initcall(aspeed_host_bmc_device_init);
>>> +module_exit(aspeed_host_bmc_device_exit);
>> It looks like you can use module_pci_driver() ?
> yes, It should work unless the late initcall is important. I will test 
> it and see.

I will not be able to use module_pci_driver() as it doesn't support late 
initcall which is required otherwise

8250 registration fails. So I am not making this change.

>
> Thanks & Regards,
>
> Ninad Palsule
>
