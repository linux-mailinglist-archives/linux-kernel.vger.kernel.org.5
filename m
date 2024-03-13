Return-Path: <linux-kernel+bounces-101150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80387A325
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DC01F2190F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F00E14ABA;
	Wed, 13 Mar 2024 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k3GUqsJA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D73D6D;
	Wed, 13 Mar 2024 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313558; cv=none; b=UIeTGl4bYCmyec+VgjBDspcIja+/wUgj4ezi4mIFFGMDorqNAsvRcLbwwTBS9cZFsfsvP2l57AauZjcC/Vv2+awSa7k66oNrxjpbc8pOtPtqNiOnE0aebGYW638Ob8gc/9j5DV7LZmcQzian87M4jNffU5tXOiqqAQP9M1eNAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313558; c=relaxed/simple;
	bh=0GU+DFYxz9zYEDh2oC++emqsXagEnaIuQN5LEyLqoDg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=bgbZQPxjkHTOjSndBL7JgChSWDE67MMTmpzFVRa2+vaq2YVsH0V4SjVU+Bqpe/R0SqomLETBQYNym9r3fal1hWqt3QO8VKvuMDYyabSpukaA1CDZXAbi+KsZcMNzz0my1eM6ZQLOoKypnkHg8jTdyLE/OJsYTX9TZuevMCqsWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k3GUqsJA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D6F8lV009561;
	Wed, 13 Mar 2024 07:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gipoK2DWrZoh55nFQQgg9pTMK8wfoOiAcl8zJU7Ece4=; b=k3
	GUqsJAgg49SvThrSPDCtZbrT9dAMBUEGfIj8OtY5MNrKJy5+D6Xb0jYkNJGQb68n
	EDSQ5q8q/7LvlFYWn1Ic3pFwMikrvnzdRXx016hOY1g1SZ+DNseLOSPnFxLcagwr
	xE8njUNFQzwMd0T7seFV/uoTgh+rGXbFruTjNstjJKTRm9B5aKo/vTRQCSEu0u5u
	yAYYM+ZRrpSLpUZMphVH/+g9jWJAHieWQez9mW3WFUjEQ+OLnjzV/fe4gdnvjl2d
	0JdHO9uLkx8G/VquKedWBdYIM481LPBXeBIUPZHH/XmYVbDPpVu5AOsSqBQ5Xb3x
	7yVWWtDRlCQqhDTcnB+Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtw3h16x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 07:05:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42D75nCa005839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 07:05:49 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 00:05:47 -0700
Message-ID: <75bd5961-1fa5-4d48-b6df-ed5baa9ac5ae@quicinc.com>
Date: Wed, 13 Mar 2024 15:05:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [virtio-dev] Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver. -
 Correction
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
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
 <919477ee-929e-45d3-85fc-82cac071a0ec@quicinc.com>
In-Reply-To: <919477ee-929e-45d3-85fc-82cac071a0ec@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DSyJ-MuUAZ_QfJPmiX0PI5fwmFXA0JlS
X-Proofpoint-GUID: DSyJ-MuUAZ_QfJPmiX0PI5fwmFXA0JlS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_06,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130052

Hello Harald,

     Some updates:

         1. the virtio-spi device node intermediate layer, "spi", the
            compatible is not "virtio,device45", should be
            "virtio,device2d", shall be in lower case hexadecimal.

         2. the driver should support the way that creating the spi
            device via device-tree, but now the driver doesn't, it cannot
            parse the child node. I guess this is due to the missing of
            of_node property, please refer to the i2c virtio driver.

 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-virtio.c?h=v6.8#n216

         3. in current driver, spi_new_device to create spi devices, as

+        for (csi = 0; csi < ctrl->num_chipselect; csi++) {
+		dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
+		board_info.chip_select = csi;
+		/* TODO: Discuss setting of board_info.mode */
+		if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
+			board_info.mode = SPI_MODE_0;
+		else
+			board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;
+		if (!spi_new_device(ctrl, &board_info)) {
+			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
+			spi_unregister_controller(ctrl);
+			err = -ENODEV;
+			goto err_return;
+		}
+	}

           but when I add spi device node in device tree, there will be
           conflicts here, between the device dynamically created via
           device tree node and the device static created by calling
           spi_new_device. As far as I am concerned, it's necessary to
           support of and(or) acpi.

         Let's discuss this topic firstly. Thanks a lot.

BR
Haixu Cui





On 3/11/2024 5:28 PM, Haixu Cui wrote:
> Hello Harald,
>      My concern is if possible to create the udev(spidev) by adding the 
> device-tree node. Although the way of using the udev rule is fine, I 
> think the way of adding device-tree node also suitable for some scenarios.
> 
>      Referring to Kumar's examples, I guess the virtio spi device-tree 
> should be like:
> 
>      virtio-spi@4b013000 {
>          compatible = "virtio,mmio";
>          reg = <0x4b013000 0x1000>;
>          interrupts = <0 497 4>;
> 
>          spi {
>              compatible = "virtio,device45";
>              #address-cells = <1>;
>              #size-cells = <0>;
> 
>              spidev@0 {
>                  compatible = "xxx";
>                  reg = <0>;
>                  spi-max-frequency = <100000>;
>              };
>          };
>      };
> 
>      Just like virtio-i2c node, virtio-spi@4b013000 has three levels. 
> And the innermost, spidev node is to match spidev driver, to create 
> spidev(udev) device. I am working on this recently, but got some 
> stranger cases. Need more effort and time.
> 
>      Harald, do you have any idea about this way? I'm looking forward to 
> it. Thanks a lot.
> 
> Haixu Cui
> 
> 
> 
> 
> On 3/7/2024 12:18 AM, Harald Mommer wrote:
>> Hello Haixu,
>>
>> not really sure what you mean and where the problem are. But we will 
>> find out.
>>
>> What I did in the device tree of some hardware board was
>>
>> virtio_mmio@4b013000 {
>>          compatible = "virtio,mmio";
>>          reg = <0x0 0x4b013000 0x0 0x1000>;
>>          /* GIC_SPI = 0, IRQ_TYPE_LEVEL_HIGH = 4 */
>>          interrupts = <0 497 4>;
>>          spi,bus-num = <1234>;
>>      };
>>
>> Simply added a line "spi,bus-num = <1234>;" in the device tree to 
>> configure the bus number.
>>
>> (There is no device tree for my very small qemu setup to check 
>> next/latest, also no full udev, therefore I've to live there with the 
>> default bus-num which is 0.)
>>
>> What I guess you mean is that the syntax of the device tree node 
>> should be changed having GPIO and I2C as template.
>>
>> And as you need more parameters for the board info, not only this 
>> single line for the bus number. May this be somewhat for an 
>> enhancement in a subsequent version?
>>
>> Why it's not easy to create the device node using the udev rule below 
>> in a full system with udev (vs. some minimal RAMDISK system) I don't 
>> understand. It's a single line, rest are comments.
>>
>> # Bind spi-virtio device spiB.C to user mode SPI device /dev/spidevB.C
>> # Requires spi driver_override sysfs entry (Linux version 4.20+ and 
>> later)
>> #
>> # See also 
>> https://www.mail-archive.com/debian-arm@lists.debian.org/msg22090.html
>> # and Documentation/spi/spidev.rst
>> #
>> #ACTION=="add", SUBSYSTEM=="spi", ENV{MODALIAS}=="spi:spi-virtio", 
>> PROGRAM+="/bin/sh -c 'echo spidev > %S%p/driver_override && echo %k > 
>> %S%p/subsystem/drivers/spidev/bind"
>> ACTION=="add", SUBSYSTEM=="spi", ENV{MODALIAS}=="spi:spi-virtio", 
>> PROGRAM+="/bin/sh -c 'echo spidev > %S%p/driver_override && echo %k > 
>> %S/bus/spi/drivers/spidev/bind"
>>
>> It may be helpful if you could provide a proposal how exactly the 
>> device tree entry should look. This would also show which information 
>> is needed in addition to the bus number.
>>
>> What I guess is that you in the end it may look like this:
>>
>> virtio_mmio@4b013000 {
>>          compatible = "virtio,mmio";
>>          reg = <0x0 0x4b013000 0x0 0x1000>;
>>          /* GIC_SPI = 0, IRQ_TYPE_LEVEL_HIGH = 4 */
>>          interrupts = <0 497 4>;
>>
>>          spi {
>>              bus-num = <1234>; /* Is it like this? */
>>              /* More stuff here especially for the board_info I've 
>> currently no need for and no idea about that it may be needed by 
>> others */ /* ??? More info needed */
>>          }
>>      };
>>
>> Regards
>> Harald Mommer
>>
>> On 06.03.24 08:48, Haixu Cui wrote:
>>> Hello Harald,
>>>
>>>     In current driver, spi_new_device is used to instantiate the 
>>> virtio SPI device, spidevX.Y is created manually, this way seems not 
>>> flexible enough. Besides it's not easy to set the spi_board_info 
>>> properly.
>>>
>>>     Viresh Kumar has standardized the device tree node format for 
>>> virtio-i2c and virtio-gpio:
>>>
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
>>>
>>>     In this way, the driver is unified, board customization only 
>>> depends on the device-tree node. It's easy to bring up spidev 
>>> automatically.
>>>
>>>     Look forward to your opinions. Thanks a lot.
>>>
>>> Haixu Cui
>>>
>>>
>>> On 3/6/2024 1:54 AM, Harald Mommer wrote:
>>>> Hello,
>>>>
>>>> looked again at my tinny setup and I've to add a small correction.
>>>>
>>>> It's not the way that I've no udev at all there. What is in place 
>>>> there is busybox mdev.
>>>>
>>>> Relevant part of /etc/init.d/rcS:
>>>>
>>>> #!/bin/sh
>>>> mount -t proc none /proc
>>>> mount -t sysfs none /sys
>>>> depmod
>>>> modprobe spi-virtio
>>>> mdev -s
>>>> mdev -d
>>>>
>>>> If I kill the "mdev -d" process my small script below does not make 
>>>> the /dev/spidev0.0 device node appear any more. Of course not, there 
>>>> must be some user mode process which does the job in the device 
>>>> directory.
>>>>
>>>> Regards
>>>> Harald Mommer
>>>>
>>>> On 05.03.24 11:57, Harald Mommer wrote:
>>>>> Hello,
>>>>>
>>>>> I took next/stable as base giving the exact tag/sha of the current 
>>>>> next/stable so that it's known what was used as base version even 
>>>>> when next/stable moves. The ordinary next tags are currently not of 
>>>>> best quality, gets better, therefore next/stable now. We were on 
>>>>> v6.8-rc7 yesterday with next/stable.
>>>>>
>>>>> VMM is qemu for the driver you have. But it's a specially modified 
>>>>> qemu which allows that we use our proprietary virtio SPI device as 
>>>>> backend.
>>>>>
>>>>> Proprietary virtio SPI device is started first, this is an own user 
>>>>> process in our architecture. Subsequently the special internal qemu 
>>>>> version is started. The virtio SPI driver is compiled as a module 
>>>>> and inserted manually by a startup script by "modprobe spi-virtio". 
>>>>> The driver goes live immediately.
>>>>>
>>>>> In this simple setup I do not have udev rules (no service 
>>>>> supporting udev => no rules) so no /dev/spidevX.Y automatically 
>>>>> after the driver went live. What I'm using to test the latest 
>>>>> driver before sending it to the mailing lists is really a naked 
>>>>> kernel + a busybox running in a ramdisk. The udev rule I've sent 
>>>>> are used on some more complete setup on real hardware.
>>>>>
>>>>> So without udev I have to bring this device up manually:
>>>>>
>>>>> In /etc/spidev-up.sh there is a script tp bring up /dev/spidev0.0 
>>>>> manually:
>>>>>
>>>>> #!/bin/sh
>>>>> SPIDEV=spi0.0
>>>>> echo spidev > /sys/bus/spi/devices/$SPIDEV/driver_override
>>>>> echo $SPIDEV > /sys/bus/spi/drivers/spidev/bind
>>>>>
>>>>> Afterwards there is /dev/spidev0.0.
>>>>>
>>>>> In linux/tools/spi there are spidev_test.c and spidev_fdx.c. Those 
>>>>> (somewhat hacked locally, and I mean "hacked" to be able to test 
>>>>> somewhat more) are used to play around with /dev/spidev0.0.
>>>>>
>>>>> I can do this on my Laptop which has no underlying SPI hardware 
>>>>> which could be used as a backend for the virtio SPI device. The 
>>>>> proprietary virtio SPI device has a test mode to support this. 
>>>>> Using this test mode the driver does not communicate with a real 
>>>>> backend SPI device but does an internal simulation. For example, if 
>>>>> I do a half duplex read it always gives back the sequence 01 02 03 ...
>>>>>
>>>>> For full duplex it gives back what has been read but with letter 
>>>>> case changed, in loopback mode it gives back exactly what was sent. 
>>>>> With this test mode I could develop a driver and parts of the 
>>>>> device (device - real backend communication to an actual SPI 
>>>>> device) on a board which had no user space /dev/spiX.Y available 
>>>>> which could have served as backend for the virtio SPI device on the 
>>>>> host.
>>>>>
>>>>> Slightly different module version is tested on real hardware with 
>>>>> the virtio SPI device not in test mode. "Tested on hardware" means 
>>>>> that device + module work for our special use case (some hardware 
>>>>> device using 8 bit word size) and the project team for which device 
>>>>> and driver have been made did until now not complain.
>>>>>
>>>>> Regards
>>>>> Harald Mommer
>>>>>
>>>>> On 05.03.24 08:46, Haixu Cui wrote:
>>>>>> Hello Harald,
>>>>>>
>>>>>> Thank you for your detailed expatiation. To my knowledge, you took 
>>>>>> Vanilla as the front-end, and VMM is QEMU. Can you please explain 
>>>>>> further how do you test the SPI transfer without the Vanilla 
>>>>>> userspace interface? Thanks again.
>>>>>>
>>>>>> Haixu Cui
>>>>>
>>>>>
>>>

