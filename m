Return-Path: <linux-kernel+bounces-98618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED7C877CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DBC1C20F76
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC19317999;
	Mon, 11 Mar 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oB6GY36o"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D086617BDA;
	Mon, 11 Mar 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149337; cv=none; b=q2S/c8xKG2L1TIxNjDIuOzoOh1fSLiYPrUIc8/ewgW1cbDg3rWwnNUWeXriyOzIgICRPTw4pyqRoHnOnvZtCjVbhk9MMddaeKYBvdny0LfQTMX4WxkCHdhULaSKWOFmisI0YrjUToYLae/KkQr1bB0C3KGHBFAGm7raBwP2LTZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149337; c=relaxed/simple;
	bh=s9+n0n7sZOfB1coRQQJRtJE7lMhJbLn/fMxC+MMgpjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u2jDGvqoTKkRvm3+BXmqnOXaCNWYWLk2LrFgjT1Lf656rZLnzGvM/fMqugfRyW7KFOuNnfxuPZXde2Immv6tLmwt6WFxTcq+Q8/J/LbxJyd3ZQ8XXXccYioyYOw/SZF10MwUf+ZpQWTb5i2Z9etCvZTnS/VcJo98dPAzWp5pTlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oB6GY36o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B8KMJp016399;
	Mon, 11 Mar 2024 09:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rLR1WV7vYJoOLZKe7kI/qPMd4Q0DBwXKwVuIQva33aE=; b=oB
	6GY36oiPUwRxONtuf1ywHCD3yIOrbGjVXz7nfMg1nrLmK+HT0dUdbBSSFfnIUNTm
	jFZwBjMcMB7Dbef+52RlGFZv8Tlgs1ZWqOTdvSFMWd9JL9zbzwTVf1ZQLNlF3eSm
	s5yMrwdfUCt1yLeXqYAacCTC6YUOnGrpm9T8U9ckT9JZSgfhIJE8JNjWB9cnJ/HF
	UHOkTMOwFBnDW1JVN7uq7+ZmoWS2ok+8hQ8Kw6nQFptzwbOUUNVnS7fxJy8pH5rU
	JKUsMq0c2hstcNeEPuaznytGGrbtM6SJYdMhwOFMCAGPwdr1ddc2PKSJN7OBSWW0
	rr6874IfA+aYeb4DWnDw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wsxbvg3x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 09:28:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42B9SlVt030358
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 09:28:47 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Mar
 2024 02:28:45 -0700
Message-ID: <919477ee-929e-45d3-85fc-82cac071a0ec@quicinc.com>
Date: Mon, 11 Mar 2024 17:28:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [virtio-dev] Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver. -
 Correction
To: Harald Mommer <harald.mommer@opensynergy.com>
CC: <quic_ztu@quicinc.com>, Matti Moell <Matti.Moell@opensynergy.com>,
        "Mikhail Golubev" <Mikhail.Golubev@opensynergy.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        "Mark Brown" <broonie@kernel.org>
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
 <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
 <e2e5a7a0-7a2b-40d3-acf7-6f0b91bd5d40@quicinc.com>
 <2a911f96-eed9-4adc-9043-27fd1d3a7ca2@opensynergy.com>
 <c7c939c9-50e0-4d86-bd44-d8b4b90ca14d@quicinc.com>
 <7bfbf09f-67d1-43d0-8ecd-aedf3b9e2287@opensynergy.com>
 <58d1487a-fd3b-4b31-a133-3181359e0c61@opensynergy.com>
 <a8e5463f-787b-44c3-842f-c2d7f703d26e@quicinc.com>
 <b5e3ed19-15a2-4dfd-a1af-28d11ebefbcc@opensynergy.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <b5e3ed19-15a2-4dfd-a1af-28d11ebefbcc@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -cvifhR0tRouVFQLhnJsep64Ssk8c4qM
X-Proofpoint-GUID: -cvifhR0tRouVFQLhnJsep64Ssk8c4qM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110070

Hello Harald,
     My concern is if possible to create the udev(spidev) by adding the 
device-tree node. Although the way of using the udev rule is fine, I 
think the way of adding device-tree node also suitable for some scenarios.

     Referring to Kumar's examples, I guess the virtio spi device-tree 
should be like:

     virtio-spi@4b013000 {
         compatible = "virtio,mmio";
         reg = <0x4b013000 0x1000>;
         interrupts = <0 497 4>;

         spi {
             compatible = "virtio,device45";
             #address-cells = <1>;
             #size-cells = <0>;

             spidev@0 {
                 compatible = "xxx";
                 reg = <0>;
                 spi-max-frequency = <100000>;
             };
         };
     };

     Just like virtio-i2c node, virtio-spi@4b013000 has three levels. 
And the innermost, spidev node is to match spidev driver, to create 
spidev(udev) device. I am working on this recently, but got some 
stranger cases. Need more effort and time.

     Harald, do you have any idea about this way? I'm looking forward to 
it. Thanks a lot.

Haixu Cui




On 3/7/2024 12:18 AM, Harald Mommer wrote:
> Hello Haixu,
> 
> not really sure what you mean and where the problem are. But we will 
> find out.
> 
> What I did in the device tree of some hardware board was
> 
> virtio_mmio@4b013000 {
>          compatible = "virtio,mmio";
>          reg = <0x0 0x4b013000 0x0 0x1000>;
>          /* GIC_SPI = 0, IRQ_TYPE_LEVEL_HIGH = 4 */
>          interrupts = <0 497 4>;
>          spi,bus-num = <1234>;
>      };
> 
> Simply added a line "spi,bus-num = <1234>;" in the device tree to 
> configure the bus number.
> 
> (There is no device tree for my very small qemu setup to check 
> next/latest, also no full udev, therefore I've to live there with the 
> default bus-num which is 0.)
> 
> What I guess you mean is that the syntax of the device tree node should 
> be changed having GPIO and I2C as template.
> 
> And as you need more parameters for the board info, not only this single 
> line for the bus number. May this be somewhat for an enhancement in a 
> subsequent version?
> 
> Why it's not easy to create the device node using the udev rule below in 
> a full system with udev (vs. some minimal RAMDISK system) I don't 
> understand. It's a single line, rest are comments.
> 
> # Bind spi-virtio device spiB.C to user mode SPI device /dev/spidevB.C
> # Requires spi driver_override sysfs entry (Linux version 4.20+ and later)
> #
> # See also 
> https://www.mail-archive.com/debian-arm@lists.debian.org/msg22090.html
> # and Documentation/spi/spidev.rst
> #
> #ACTION=="add", SUBSYSTEM=="spi", ENV{MODALIAS}=="spi:spi-virtio", 
> PROGRAM+="/bin/sh -c 'echo spidev > %S%p/driver_override && echo %k > 
> %S%p/subsystem/drivers/spidev/bind"
> ACTION=="add", SUBSYSTEM=="spi", ENV{MODALIAS}=="spi:spi-virtio", 
> PROGRAM+="/bin/sh -c 'echo spidev > %S%p/driver_override && echo %k > 
> %S/bus/spi/drivers/spidev/bind"
> 
> It may be helpful if you could provide a proposal how exactly the device 
> tree entry should look. This would also show which information is needed 
> in addition to the bus number.
> 
> What I guess is that you in the end it may look like this:
> 
> virtio_mmio@4b013000 {
>          compatible = "virtio,mmio";
>          reg = <0x0 0x4b013000 0x0 0x1000>;
>          /* GIC_SPI = 0, IRQ_TYPE_LEVEL_HIGH = 4 */
>          interrupts = <0 497 4>;
> 
>          spi {
>              bus-num = <1234>; /* Is it like this? */
>              /* More stuff here especially for the board_info I've 
> currently no need for and no idea about that it may be needed by others 
> */ /* ??? More info needed */
>          }
>      };
> 
> Regards
> Harald Mommer
> 
> On 06.03.24 08:48, Haixu Cui wrote:
>> Hello Harald,
>>
>>     In current driver, spi_new_device is used to instantiate the 
>> virtio SPI device, spidevX.Y is created manually, this way seems not 
>> flexible enough. Besides it's not easy to set the spi_board_info 
>> properly.
>>
>>     Viresh Kumar has standardized the device tree node format for 
>> virtio-i2c and virtio-gpio:
>>
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
>>
>>     In this way, the driver is unified, board customization only 
>> depends on the device-tree node. It's easy to bring up spidev 
>> automatically.
>>
>>     Look forward to your opinions. Thanks a lot.
>>
>> Haixu Cui
>>
>>
>> On 3/6/2024 1:54 AM, Harald Mommer wrote:
>>> Hello,
>>>
>>> looked again at my tinny setup and I've to add a small correction.
>>>
>>> It's not the way that I've no udev at all there. What is in place 
>>> there is busybox mdev.
>>>
>>> Relevant part of /etc/init.d/rcS:
>>>
>>> #!/bin/sh
>>> mount -t proc none /proc
>>> mount -t sysfs none /sys
>>> depmod
>>> modprobe spi-virtio
>>> mdev -s
>>> mdev -d
>>>
>>> If I kill the "mdev -d" process my small script below does not make 
>>> the /dev/spidev0.0 device node appear any more. Of course not, there 
>>> must be some user mode process which does the job in the device 
>>> directory.
>>>
>>> Regards
>>> Harald Mommer
>>>
>>> On 05.03.24 11:57, Harald Mommer wrote:
>>>> Hello,
>>>>
>>>> I took next/stable as base giving the exact tag/sha of the current 
>>>> next/stable so that it's known what was used as base version even 
>>>> when next/stable moves. The ordinary next tags are currently not of 
>>>> best quality, gets better, therefore next/stable now. We were on 
>>>> v6.8-rc7 yesterday with next/stable.
>>>>
>>>> VMM is qemu for the driver you have. But it's a specially modified 
>>>> qemu which allows that we use our proprietary virtio SPI device as 
>>>> backend.
>>>>
>>>> Proprietary virtio SPI device is started first, this is an own user 
>>>> process in our architecture. Subsequently the special internal qemu 
>>>> version is started. The virtio SPI driver is compiled as a module 
>>>> and inserted manually by a startup script by "modprobe spi-virtio". 
>>>> The driver goes live immediately.
>>>>
>>>> In this simple setup I do not have udev rules (no service supporting 
>>>> udev => no rules) so no /dev/spidevX.Y automatically after the 
>>>> driver went live. What I'm using to test the latest driver before 
>>>> sending it to the mailing lists is really a naked kernel + a busybox 
>>>> running in a ramdisk. The udev rule I've sent are used on some more 
>>>> complete setup on real hardware.
>>>>
>>>> So without udev I have to bring this device up manually:
>>>>
>>>> In /etc/spidev-up.sh there is a script tp bring up /dev/spidev0.0 
>>>> manually:
>>>>
>>>> #!/bin/sh
>>>> SPIDEV=spi0.0
>>>> echo spidev > /sys/bus/spi/devices/$SPIDEV/driver_override
>>>> echo $SPIDEV > /sys/bus/spi/drivers/spidev/bind
>>>>
>>>> Afterwards there is /dev/spidev0.0.
>>>>
>>>> In linux/tools/spi there are spidev_test.c and spidev_fdx.c. Those 
>>>> (somewhat hacked locally, and I mean "hacked" to be able to test 
>>>> somewhat more) are used to play around with /dev/spidev0.0.
>>>>
>>>> I can do this on my Laptop which has no underlying SPI hardware 
>>>> which could be used as a backend for the virtio SPI device. The 
>>>> proprietary virtio SPI device has a test mode to support this. Using 
>>>> this test mode the driver does not communicate with a real backend 
>>>> SPI device but does an internal simulation. For example, if I do a 
>>>> half duplex read it always gives back the sequence 01 02 03 ...
>>>>
>>>> For full duplex it gives back what has been read but with letter 
>>>> case changed, in loopback mode it gives back exactly what was sent. 
>>>> With this test mode I could develop a driver and parts of the device 
>>>> (device - real backend communication to an actual SPI device) on a 
>>>> board which had no user space /dev/spiX.Y available which could have 
>>>> served as backend for the virtio SPI device on the host.
>>>>
>>>> Slightly different module version is tested on real hardware with 
>>>> the virtio SPI device not in test mode. "Tested on hardware" means 
>>>> that device + module work for our special use case (some hardware 
>>>> device using 8 bit word size) and the project team for which device 
>>>> and driver have been made did until now not complain.
>>>>
>>>> Regards
>>>> Harald Mommer
>>>>
>>>> On 05.03.24 08:46, Haixu Cui wrote:
>>>>> Hello Harald,
>>>>>
>>>>> Thank you for your detailed expatiation. To my knowledge, you took 
>>>>> Vanilla as the front-end, and VMM is QEMU. Can you please explain 
>>>>> further how do you test the SPI transfer without the Vanilla 
>>>>> userspace interface? Thanks again.
>>>>>
>>>>> Haixu Cui
>>>>
>>>>
>>

