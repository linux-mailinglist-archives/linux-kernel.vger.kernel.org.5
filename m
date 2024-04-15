Return-Path: <linux-kernel+bounces-144944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C298A4CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8A1281E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591755D726;
	Mon, 15 Apr 2024 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B4faCUjX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96933C062;
	Mon, 15 Apr 2024 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178401; cv=none; b=Xk892QwMWnUYjZd3TU0KVK0d9OaYG4AmgYgaoPxUHEEJYXfD24k8eevTOPLi2n0lZlvr1Ipi39qvfQRbpEWMhY7Qxo0G95ZMcoQXph3XCG6Bso00fTMXK7NvOUrbAhu1PwAEWYDRGrlHLbf2sYy9tu6z4LT9Cj1v6OAimPs3EYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178401; c=relaxed/simple;
	bh=V1BGjb8HNq5D0Fh/oi6hs0eA4zpI5ma4eOXVd4utS/0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=fOab8k50ZripcoE7lcaxLbKNsAXU3pa29rZRZRuww0ZIbk/Fm/vJmPMZLKhkF67SLMq/Aab2Ut0N8T0zrrMOBBXVeE8ykHilIwwos9VEIrd7fxDXjF82s+VvFIlfzUto+YEM57wGJpP2ERsoFPaHBm8dsyYCXjRoGXnFiURCs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B4faCUjX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43F7GxAH032342;
	Mon, 15 Apr 2024 10:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fUh8aczGJXmKWquDnETV7CYiUkU0VYPdnsfrIcnMzMc=; b=B4
	faCUjXXP28O7QszLlFE7/qB6vFZgRWlZsLl/v3DcCyOEEZPJcZ//jRNHUH2pQwO6
	bZrSn1Rc3kR2Odgz0lihftZeDwTPBOh2PwlQmjLxX7QnnNIP6zgPwF8Z6RXVWM+A
	8vnnMRzu2QP4kB8Ev123A2brJcrYzowSy+bMrHViJRQS91KZbjEbjOKJQl9sSc5V
	4rpq3XNDuvcv7fKeJ50MZBZokHraBXmrCMNF4m6g6imid+/V6vzH/7VKwbP9OeFn
	7332nn9A8pqsdIfIq9RU/pApDdYWsEc/gtLN7PMoKBgdmOJQjxdC/jc+pCaGz+wp
	55G3osGg+tUAIGGInZcw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xgyq7rf6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 10:53:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43FAqx8F019341
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 10:52:59 GMT
Received: from [10.218.29.219] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 03:52:56 -0700
Message-ID: <f72d83fd-9576-4017-bcf9-c50ce94d85ec@quicinc.com>
Date: Mon, 15 Apr 2024 16:22:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
To: Johan Hovold <johan@kernel.org>
CC: Johan Hovold <johan+linaro@kernel.org>, <luiz.dentz@gmail.com>,
        <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <171146704035.9961.13096206001570615153.git-patchwork-notify@kernel.org>
 <124a7d54-5a18-4be7-9a76-a12017f6cce5@quicinc.com>
 <ZgWLeo5KSLurLDhK@hovoldconsulting.com>
 <c03abbbd-faa5-4fdc-b7c3-5554a90c3419@quicinc.com>
 <Zg1KmcFQ3bAJa8qJ@hovoldconsulting.com>
 <b7d5c2ac-2278-4ccc-be2a-7c7d9936581a@quicinc.com>
In-Reply-To: <b7d5c2ac-2278-4ccc-be2a-7c7d9936581a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3N7v25ujwldprVXf3XOs24gFnLmeFYCL
X-Proofpoint-ORIG-GUID: 3N7v25ujwldprVXf3XOs24gFnLmeFYCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_08,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 clxscore=1011 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404150071

Hi Johan,
Are you planing to merge your below patch ?

On 4/5/2024 6:29 PM, Janaki Ramaiah Thota wrote:
> 
> 
> On 4/3/2024 5:54 PM, Johan Hovold wrote:
>> On Fri, Mar 29, 2024 at 12:55:40PM +0530, Janaki Ramaiah Thota wrote:
>>> On 3/28/2024 8:53 PM, Johan Hovold wrote:
>>>> On Thu, Mar 28, 2024 at 08:25:16PM +0530, Janaki Ramaiah Thota wrote:
>>
>>>>> We made this change to configure the device which supports persistent
>>>>> memory for the BD-Address
>>>>
>>>> Can you say something more about which devices support persistent
>>>> storage for the address? Is that all or just some of the chip variants?
>>
>>> Most of the devices support persistent storage, and bd-address storage
>>> is chosen based on the OEM and Target.
>>
>> Can you be more specific about which devices support it (or say which do
>> not)?
>>
> 
> We know below BT chipsets supports persistent storage(OTP) for BDA
> WCN7850, WCN6855, WCN6750
> 
>> Is the address stored in some external eeprom or similar which the OEM
>> can choose to populate?
>>
> 
> This persistent storage is One Time Programmable (OTP) reserved memory
> which resides in the BT chip.
> 
>>>>> So to make device functional in both scenarios we are adding a new
>>>>> property in dts file to distinguish persistent and non-persistent
>>>>> support of BD Address and set HCI_QUIRK_USE_BDADDR_PROPERTY bit
>>>>> accordingly
>>>>
>>>> Depending on the answer to my questions above, you may be able to infer
>>>> this from the compatible string and/or you can read out the address from
>>>> the device and only set the quirk if it's set to the default address.
>>>>
>>>> You should not need to add a new property for this.
>>
>>> As per my understanding, altering the compatible string may cause duplicate
>>> configuration, right ?
>>
> 
> Yes, we are correct.
> 
>> If it's the same device and just a different configuration then we can't
>> use the compatible string for this.
>>
>> It seems we need a patch like the below to address this. But please
>> provide some more details (e.g. answers to the questions above) so I can
>> determine what the end result should look like.
>>
>> Johan
>>
>>
>>  From 9719effe80fcc17518131816fdfeb1824cfa08b6 Mon Sep 17 00:00:00 2001
>> From: Johan Hovold <johan+linaro@kernel.org>
>> Date: Thu, 20 Apr 2023 14:10:55 +0200
>> Subject: [PATCH] Bluetooth: btqca: add invalid device address check
>>
>> Some Qualcomm Bluetooth controllers lack persistent storage for the
>> device address and therefore end up using the default address
>> 00:00:00:00:5a:ad.
>>
>> Apparently this depends on how the controller has been integrated so we
>> can not use the device type alone to determine when the address is
>> valid.
>>
>> Instead read back the address during setup() and only set the
>> HCI_QUIRK_USE_BDADDR_PROPERTY flag when needed.
>>
>> Fixes: de79a9df1692 ("Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY")
>> Fixes: e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD address missing in dts")
>> Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
>> Cc: stable@vger.kernel.org    # 6.5
>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>> ---
>>   drivers/bluetooth/btqca.c   | 33 +++++++++++++++++++++++++++++++++
>>   drivers/bluetooth/hci_qca.c |  2 --
>>   2 files changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 19cfc342fc7b..15124157372c 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -15,6 +15,8 @@
>>   #define VERSION "0.1"
>> +#define QCA_BDADDR_DEFAULT (&(bdaddr_t) {{ 0xad, 0x5a, 0x00, 0x00, 0x00, 0x00 }})
>> +
>>   int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
>>                enum qca_btsoc_type soc_type)
>>   {
>> @@ -612,6 +614,35 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>>   }
>>   EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
>> +static void qca_check_bdaddr(struct hci_dev *hdev)
>> +{
>> +    struct hci_rp_read_bd_addr *bda;
>> +    struct sk_buff *skb;
>> +    int err;
>> +
>> +    if (bacmp(&hdev->public_addr, BDADDR_ANY))
>> +        return;
>> +
>> +    skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
>> +                 HCI_INIT_TIMEOUT);
>> +    if (IS_ERR(skb)) {
>> +        err = PTR_ERR(skb);
>> +        bt_dev_err(hdev, "Failed to read device address (%d)", err);
>> +        return;
>> +    }
>> +
>> +    if (skb->len != sizeof(*bda)) {
>> +        bt_dev_err(hdev, "Device address length mismatch");
>> +        goto free_skb;
>> +    }
>> +
>> +    bda = (struct hci_rp_read_bd_addr *)skb->data;
>> +    if (!bacmp(&bda->bdaddr, QCA_BDADDR_DEFAULT))
>> +        set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>> +free_skb:
>> +    kfree_skb(skb);
>> +}
>> +
>>   static void qca_generate_hsp_nvm_name(char *fwname, size_t max_size,
>>           struct qca_btsoc_version ver, u8 rom_ver, u16 bid)
>>   {
>> @@ -818,6 +849,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>>           break;
>>       }
>> +    qca_check_bdaddr(hdev);
>> +
>>       bt_dev_info(hdev, "QCA setup on UART is completed");
>>       return 0;
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index b266db18c8cc..b621a0a40ea4 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1908,8 +1908,6 @@ static int qca_setup(struct hci_uart *hu)
>>       case QCA_WCN6750:
>>       case QCA_WCN6855:
>>       case QCA_WCN7850:
>> -        set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>> -
>>           qcadev = serdev_device_get_drvdata(hu->serdev);
>>           if (qcadev->bdaddr_property_broken)
>>               set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
> 
> Thanks for the patch. This change looks fine and it will resolve the current OTP issue.
> 
> -- 
> Thanks,
> JanakiRam

Regards,
Janaki Ram

