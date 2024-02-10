Return-Path: <linux-kernel+bounces-60365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CE5850403
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5971C21448
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 10:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15149364DB;
	Sat, 10 Feb 2024 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T/vpNaM/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D082030B;
	Sat, 10 Feb 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707561857; cv=none; b=BxLJKaB8cnWV/bCKngkYO0P1EQBqI6VgO7/nQbmAsG2J16ip31x6/bbN6X/qwaUvKFuwPtorxngYzhvh9ZRE6a0hBZHKmYYTushYomtmQJz1gItG53C9kGfpQHJQcQTPJljrFysLjE0oRZUdiZWur1m1WzamPXVFo39fljv/3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707561857; c=relaxed/simple;
	bh=HdoGJKfM4IdFF97CvlZ7u9IYY/5htVYwh9r2vlaTMWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KWtqj7CdNLoOAae/pHJpnvK2nMejkDj9ZJz8UIyeH/tJAZJjyjXiCB3eMqPvwn67zMhe00l62OM5jLSluTYgLBIdASwHvUHoxIz/LzZy+HbpfQ4cd9u6gA7wTP6DR0NLMiZ3Oup8nEwdxfdVtcxHASY+yg0U6Uqk4jT4yCczZ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T/vpNaM/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41AAfFDC018067;
	Sat, 10 Feb 2024 10:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UYh6Vys92a+IOZW81ElMcn3EE5XcVQKjyrgj0qy6/9k=; b=T/
	vpNaM/eYQRs8mfiz9h7/9Rj+FTnCmM6hL3aBTTzasvbA1kcJrV5ih27OO0Pbn5p6
	PVxQlsi3EEIOZNJ5qFAPt8bIM8fhonTh5mZyw+7cz72PhoKMxvPAyC+i/Pf6PwZ9
	0F9Y2YI22hbUqfgOJrO68JFpa91SC9rElaLbstUrAVWZ4AZ4a1yQds53YhRMTuzJ
	cVPTBbtOV9NoFTDBXlPSruWn6hGz1XjlHJE5LaxHMqVcpK490U7m6wUGoERB1r6d
	4sibxEI8jt5N3QsffRKLnv0V2BLhQW6UlMJpFCyCFnVb0ddwyJr6zG9yjli9aiBS
	rH/7Me8mxh1mrar+ZN0w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62pv8bwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 10:44:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41AAi2lK029254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 10:44:02 GMT
Received: from [10.216.17.117] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 10 Feb
 2024 02:43:56 -0800
Message-ID: <b5c25274-9af0-4b3e-ade7-9a55d3cecd29@quicinc.com>
Date: Sat, 10 Feb 2024 16:13:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8540-ride: Enable first port of
 tertiary usb controller
To: Andrew Halaney <ahalaney@redhat.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
 <20240206114745.1388491-4-quic_kriskura@quicinc.com>
 <23824242-1b37-4544-ae9a-0a5a0582580e@linaro.org>
 <CAA8EJpqbXvKMQktGsxMFJnR+fXoOz8hFmm+E3ROPTjjiD0QLvg@mail.gmail.com>
 <6q2ocvrujbli42rjddflyol74xianr7j47jwcgdnnmwjanv25d@uw2da7zulqqd>
 <CAA8EJpr6k8c5C54S9xxQgZvd9NYFoxi5qQrOTz2AMrp0xeZZpw@mail.gmail.com>
 <baw3wxbdvzpkqqb6a7iut2wpt6jgzyqii5uyfkzptzt4ryjvao@4tpee6nqup5w>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <baw3wxbdvzpkqqb6a7iut2wpt6jgzyqii5uyfkzptzt4ryjvao@4tpee6nqup5w>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gLWvh4piTatOfY9fqLXs4PyYmy-tI6LZ
X-Proofpoint-ORIG-GUID: gLWvh4piTatOfY9fqLXs4PyYmy-tI6LZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-10_10,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999 adultscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402100090

> Krishna, when you make v2 can you update the wording about the USB 2.0
> mux? Maybe something like "which by default on boot is selected to mux
> to the external port on the board (with the other option being a test
> point)." instead of the wording I originally had? That way the
> information Dmitry requested here is easily accessible in the future.
> 
>>
>>>

[...]

>>>>>>    };
>>>>>
>>>>> Isn't gpio-hog the preferred way to describe that ?
>>>>
>>>> That depends. As this pinctrl describes board configuration, I'd agree
>>>> with Neil.
>>>
>>> I unfortunately don't have the experience with gpio-hog to weigh in
>>> here, but wouldn't be opposed to Krishna switching it if that's what's
>>> recommended for this type of thing.
>>
>> Quoting gpio.txt:
>>
>> The GPIO chip may contain GPIO hog definitions. GPIO hogging is a mechanism
>> providing automatic GPIO request and configuration as part of the
>> gpio-controller's driver probe function.
>>
>> See sdm845-pinctrl.yaml for an example of the gpio-hog node.
> 
> Thanks, that seems like the way to go. Krishna please take note of this
> for v2!
> 

Hi Andrew,

  Can you help test the following patch. It is just an add-on to your 
original one. I don't have a SA8540P Ride at the moment and getting one 
might take time. Incase you can confirm this patch is working. I can 
push v2 of this series.


diff --git 
a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml 
b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
index ed344deaf8b9..aa42ac5a3197 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
@@ -36,6 +36,10 @@ patternProperties:
              $ref: "#/$defs/qcom-sc8280xp-tlmm-state"
          additionalProperties: false

+  "-hog(-[0-9]+)?$":
+    required:
+      - gpio-hog
+
  $defs:
    qcom-sc8280xp-tlmm-state:
      type: object
diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts 
b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index b04f72ec097c..aa0cec0b4cc2 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -503,6 +503,18 @@ &usb_2_qmpphy0 {
         status = "okay";
  };

+&usb_2 {
+       pinctrl-0 = <&usb2_en_state>;
+       pinctrl-names = "default";
+
+       status = "okay";
+};
+
+&usb_2_dwc3 {
+       phy-names = "usb2-port0", "usb3-port0";
+       phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>;
+};
+
  &xo_board_clk {
         clock-frequency = <38400000>;
  };
@@ -655,4 +667,19 @@ wake-pins {
                         bias-pull-up;
                 };
         };
+
+       usb2-en-hog {
+               gpio-hog;
+               gpios = <24 GPIO_ACTIVE_LOW>;
+               output-low;
+       };
+
+       usb2_en_state: usb2-en-state {
+               /* TS3USB221A USB2.0 mux select */
+               pins = "gpio24";
+               function = "gpio";
+               drive-strength = <2>;
+               bias-disable;
+               output-low;
+       };


Regards,
Krishna,

