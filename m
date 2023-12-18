Return-Path: <linux-kernel+bounces-3006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11285816603
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDF31C220B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A723463CE;
	Mon, 18 Dec 2023 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CDsTWPxM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE46FA2;
	Mon, 18 Dec 2023 05:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI3q33d030701;
	Mon, 18 Dec 2023 05:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9ORMgxcyoO2xSio7DnrTJI4X6geYouHjOrWCRCI3+F4=; b=CD
	sTWPxMLV1E7D26QRzWncK/2d4JxUlq3syftMw/zFiaWkI+NfI0X6EDb6OafuWwBS
	ewDk44UFvQ9JTFXGgrdq5zAYtQl4k0Atyo9Wg/A6TOTmc4BUSYN26o4MAeK+iJy+
	ZiFJjEETxnzvHFroRrGV4oV+21DE9vig/SUkJwVOtIDyvh0aRuTg1AoQUzPeZFL6
	2yoq0NDnUtfvcTlx6MhRI9qGme2u1zE2OUWGMiC04/CHb/4ybKPshnKjwO8TS3MG
	bX/yt8R5McGWQuZDh9bGwd4YAtZyWuIZ2nl8udgGSxXbz0ZVsOpdLmPCbEpuybFh
	vOYygfiy/A6dflFRJevA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v152w3cqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 05:22:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI5MDRe020609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 05:22:13 GMT
Received: from [10.253.9.247] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Dec
 2023 21:22:08 -0800
Message-ID: <8ffe4a2c-af59-4b18-a614-9be6e41cac85@quicinc.com>
Date: Mon, 18 Dec 2023 13:22:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn
	<andrew@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <hkallweit1@gmail.com>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch>
 <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>
 <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
 <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
 <7c05b08a-bb6d-4fa1-8cee-c1051badc9d9@lunn.ch>
 <ZX2rU5OFcZFyBmGl@shell.armlinux.org.uk>
 <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>
 <657dc9d4.050a0220.e1913.c983@mx.google.com>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <657dc9d4.050a0220.e1913.c983@mx.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wNBLp9fPJugBP2qeH22LJhCu3JJYdZKH
X-Proofpoint-GUID: wNBLp9fPJugBP2qeH22LJhCu3JJYdZKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180034



On 12/17/2023 12:01 AM, Christian Marangi wrote:
> On Sat, Dec 16, 2023 at 10:41:28PM +0800, Jie Luo wrote:
>>
>>
>> On 12/16/2023 9:51 PM, Russell King (Oracle) wrote:
>>> On Sat, Dec 16, 2023 at 11:21:53AM +0100, Andrew Lunn wrote:
>>>>> The following is the chip package, the chip can work on the switch mode
>>>>> like the existed upstream code qca8k, where PHY1-PHY4 is connected with
>>>>> MAC1-MAC4 directly;
>>>>
>>>> Ah, that is new information, and has a big effect on the design.
>>>
>>> This QCA8084 that's being proposed in these patches is not a PHY in
>>> itself, but is a SoC. I came across this:
>>>
>>>    https://www.rt-rk.com/android-tv-solution-tv-in-smartphone-pantsstb-based-on-qualcomm-soc-design/
>>
>> The chip mentioned in the link you mentioned is SoC, which is not the
>> chip that the qca8084 driver work for.
>>
>> qca8084/qca8386 is just the Ethernet CHIP, not SoC, for the switch mode
>> qca8386, which is most like qca8337 the dsa drive qca8k.c is already in
>> upstream.
> 
> Hi,
> sorry for stepping in. I guess here there is a massive confusion with
> naming and using qca8k.
> 
> Since it seems the same name is used for PHY and for Switch stuff, I
> would add PHY and MAC prefix when referring to qca8064.

Hi Christian,
Welcome to join the discussion.

Sorry for the confusion, since the switch and PHY are the different
chips, the switch chip is named as qca8386, the pure PHY chip is named
as qca8084, the pure PHY chip qca8084 is connected with the SoC by PCS
working on 10g-qxgmii, the switch chip qca8386 is connected with SoC by
PCS working on sgmii.

> 
> With the previous message I was a bit confused by the use of qca8k and
> didn't know you were actually referring to the DSA driver.
> Interesting... this is for the upcoming WiFi 7 platoform right? (ipq9574)

For qca8386, it is the switch chip and leverages the qca8k DSA driver,
it is connected on the ipq5332 platform currently.

But for qca8084, it is the pure PHY chip, which works on 10g-qxgmii for
quad-phy, which is connected on the ipq9574.

> 
> All these discussion comes for the problem of using this PHY as an
> integrated PHY in the qca8386 switch and trying to select the mode in
> the PHY driver.

Yes, for qca8386, the PHY is integrated to switch, since same PHY needs
to work with qca8386 and qca8084, so the work mode needs to be
configured to distinguish the different work mode as the patch
<[PATCH v8 13/14] net: phy: at803x: configure qca8084 work mode>.

> 
> Considering you would use the same logic of the current DSA qca8k driver
> with the integrated PHY, the problem doesn't apply or a different
> implementation should be used (and actually handled later when the
> actual DSA code will come)

qca8386 has some differences from qca8337(qca8k dsa driver), qca8337
integrated PHY can work by the general PHY, but the PHY in qca8386 needs
the extra PHY driver, and the GCC clocks introduced.

> 
> I would expect in the integrated mode, the switch to handle the PHY (as
> it's done by qca8337) with the PHY defined in the switch node and qca8k
> handling the PHY registration. With the following implementation flags
> can be passed and PHY can be configured to integrated mode. (or virtual
> PHY ID can be used for such scope with dedicated functions in the PHY
> driver)
> 
Since there is the pure PHY chip qca8084 using the same PHY, which does
not enable the DSA driver.

So the PHY driver should be standalone, and the common clocks and resets
is better to put in the PHY driver, since these are the common configs
for the qca8386 and qca8084.

> With this in mind the entire integrated problem can put on hold and
> dropped to be later reimplemented when it's time. (assuming that all the
> prereq are already here and the very same implementation of qca8k will
> be used)

For the qca8386, it is true very same implementation of qca8k, besides
the 2.5G capability and GCC clock involved.

> 
> Anyway, I'm more or less the maintainer of the qca8k.c DSA driver and I
> would be more than happy to help you guys internally or externally on
> pushing and make this proceed further. (again assuming this is ipq9574
> stuff, it would be good to finally have proper DSA driver instead of
> leaving the thing unusable as it's the current situation with ipq8074)

Yes, the pure PHY chip qca8084 is connected on ipq9574 platform,
and the switch chip qca8386 is connected on ipq5332 platform.

Many thanks Christian again, will add you when pushing the qca8386 DSA
patches for upstream review.

> 
>>
>> i qca8084 chip package includes 4 PHYs, 2 PCSs and the common chip level
>> modules such as GCC and security control modules, all these modules are
>> located in the qca8084 chip package, since qca8084 works on PHY mode, so
>> the MACs are not used.
>>
>> qca8084 is connected with the SoC CHIP such as IPQ platform by PCS1
>> working on 10g-qxgmii mode and the fourth PHY can also optionally
>> be connected with the IPQ SoC PCS by sgmii mode, there is no more
>> interface on qca8084 to connect the external chips.
>>
>>> It's sounding like what we have here is some PHY IP that is integrated
>>> into a larger SoC, and the larger SoC needs to be configured so the
>>> PHY IP can work correctly.
>>
>> qca8084 is not a SoC, it is the Ethernet chip, in this qca8084 package,
>> there are GCC that is driving the PHY working on the various link speed.
>> that is the reason we need to do these package level common clocks and
>> resets initialization before probing PHY correctly.
>>
>>>
>>> Given that this package of four PHYs seems to be rather unique, I think
>>> we need Jie Luo to provide sufficient information so we can understand:
>>>
>>> 1) this package of four PHYs itself
>>
>> Yes, this chip package for all 4 PHYs itself, also including the PCSes
>> and common package level modules such as GCC.
>>
>>> 2) how this package is integrated into the SoC
>>
>> the qca8084 is connected with SoC by PCSes.
>>
>>>
>>> Specifically, what resets and clocks are controlled from within the
>>> package's register space, which are external to the package
>>> register space (and thus are provided by other IPs in the SoC).
>>
>> All clocks and resets mentioned for qca8084 drive including package
>> level and PCS & PHY clocks and resets from the qca8084 internal GCC
>> modules register space,
>>
>>>
>>> As I've said previously, the lack of DT example doesn't help to further
>>> our understanding. The lack of details of what the package encompases
>>> also doesn't help us understand the hardware.
>>
>> Indeed, i will add the qca8084 DT example in the next patch set.
>> BTW, i also replied your earlier comments by providing the DTS defined
>> for the current qca8084 drive code.
>>
>> hope you can have a better understanding with the provided DTS code in
>> earlier reply of this email thread.
>>>
>>> Unless we can gain that understanding, I feel that Jie Luo's patches
>>> are effectively unreviewable and can't be accepted into mainline.
>>>
> 

