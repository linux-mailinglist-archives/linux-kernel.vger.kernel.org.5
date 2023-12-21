Return-Path: <linux-kernel+bounces-8019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A7E81B0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D60285B29
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08200208B6;
	Thu, 21 Dec 2023 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IyftV+pU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A898208AE;
	Thu, 21 Dec 2023 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL62uwa011922;
	Thu, 21 Dec 2023 08:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yp7sGp1Z1FvijkqqpugtNxfoXwe8++jKqVOfNhM7Kfc=; b=Iy
	ftV+pUI48Zp7pMSZtYo803vfgIXbSTVWPz4U6x4On/vQ4QPTNBh0aGTwfb8G090c
	Mb81u7cfCWCbk82PuQzQ2wNbuqtyE2nRfoIPEkWK0kPwHE/z3aZIWevG5uW7PfO8
	v2lMe0O46t/SAINW7IofNPyJ2q8s0WGvMotEep7fI2dpH849duRobjf9uI7R2QfO
	eWirLresYADkzNXd1CPwsPYLNjilQMuQcPNIHvS8zp/eZUhrJoRxon2yvTOF5jI7
	YCupDiGBurUZ3UuT8MqFCvsCJpHoVgWtY3WheacxEdBwOWIermJ+E9MsHXbmn9Ab
	TneIj0acx+q413TFLI4w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4auf1nuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:49:55 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BL8ntoa010558
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:49:55 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 00:49:46 -0800
Message-ID: <e88787dc-ed03-42d2-a6e7-fb88bbc89357@quicinc.com>
Date: Thu, 21 Dec 2023 16:49:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: sm8550: remove
 address/size-cells from mdss_dsi1
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
 <20231219003106.8663-2-quic_tengfan@quicinc.com>
 <457e336e-004c-4721-b58d-e9ada16dc04b@linaro.org>
 <a8f168da-14f7-4377-8dea-f282a3eac0a4@quicinc.com>
 <13b61d41-6045-499e-864b-51c6cb6eacf9@linaro.org>
 <38604415-b410-4995-9c4f-525536435699@quicinc.com>
 <CAA8EJpo07gE7ZeNP6wSGTLtmF_3PKQAKFyMRZ8dk1K+f7PAxrg@mail.gmail.com>
 <ad1547cf-0520-422d-a105-ec426f526d71@quicinc.com>
 <CAA8EJppwsezPV21Uw8xTn=ra8L2jfnkHoRghDPN96O5tJsOD7A@mail.gmail.com>
 <72305a35-02e6-4ff6-8251-01f986530c5d@quicinc.com>
 <A45746C4-54C9-48D2-9DB7-52B4B56854E6@linaro.org>
 <4e328cd8-9ef7-42ce-b592-7f2216c00c0b@quicinc.com>
 <CAA8EJprE8v3bhHfyZJM9SJT=ShJ-LQvk5mR=gpdAWXF2yANWbQ@mail.gmail.com>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <CAA8EJprE8v3bhHfyZJM9SJT=ShJ-LQvk5mR=gpdAWXF2yANWbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5m9OAMTbTzRYu9okrVvT5pLybJjPTHUX
X-Proofpoint-GUID: 5m9OAMTbTzRYu9okrVvT5pLybJjPTHUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312210064



On 12/21/2023 2:59 PM, Dmitry Baryshkov wrote:
> On Thu, 21 Dec 2023 at 03:57, Aiqun Yu (Maria) <quic_aiquny@quicinc.com> wrote:
>>
>>
>>
>> On 12/20/2023 7:10 PM, Dmitry Baryshkov wrote:
>>> On 20 December 2023 12:33:07 EET, "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com> wrote:
>>>>
>>>>
>>>> On 12/20/2023 3:06 PM, Dmitry Baryshkov wrote:
>>>>> On Wed, 20 Dec 2023 at 02:54, Aiqun Yu (Maria) <quic_aiquny@quicinc.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 12/19/2023 6:21 PM, Dmitry Baryshkov wrote:
>>>>>>> On Tue, 19 Dec 2023 at 12:09, Aiqun Yu (Maria) <quic_aiquny@quicinc.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12/19/2023 5:41 PM, Krzysztof Kozlowski wrote:
>>>>>>>>> On 19/12/2023 10:36, Aiqun Yu (Maria) wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 12/19/2023 3:17 PM, Krzysztof Kozlowski wrote:
>>>>>>>>>>> On 19/12/2023 01:31, Tengfei Fan wrote:
>>>>>>>>>>>> The address/size-cells in mdss_dsi1 node have not ranges and child also
>>>>>>>>>>>> have not reg, then this leads to dtc W=1 warnings:
>>>>>>>>>>>
>>>>>>>>>> Comments can be more readable:
>>>>>>>>>> "mdss_dsi1" node don't have "ranges" or child "reg" property, while it
>>>>>>>>>> have address/size-cells properties. This caused
>>>>>>>>>> "avoid_unnecessary_addr_size" warning from dtb check.
>>>>>>>>>> Remove address/size-cells properties for "mdss_dsi1" node.
>>>>>>>>>>
>>>>>>>>>>> I cannot parse it. Address/size cells never have ranges or children.
>>>>>>>>>>> They cannot have. These are uint32 properties.
>>>>>>>>>> Pls help to comment on the revised commit message. Every time I write a
>>>>>>>>>> commit message, also takes a while for me to double confirm whether
>>>>>>>>>> others can understand me correctly as well. Feel free to let us know if
>>>>>>>>>> it is not readable to you. It will help us as non-English native developers.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>         sm8550.dtsi:2937.27-2992.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
>>>>>>>>>>>>           unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>>>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>
>>>>>>>>>>> I disagreed with the patch before. You resubmit it without really
>>>>>>>>>>> addressing my concerns.
>>>>>>>>>>>
>>>>>>>>>>> I am not sure if this is correct fix and I want to fix all of such
>>>>>>>>>>> errors (there are multiple of them) in the same way. Feel free to
>>>>>>>>>>> propose common solution based on arguments.
>>>>>>>>>> Per my understanding, "qcom,mdss-dsi-ctrl" driver node like "mdss_dsi1"
>>>>>>>>>> don't need to have address/size-cells properties.
>>>>>>>>>
>>>>>>>>> Just because dtc says so? And what about bindings?
>>>>>>>> I don't find any reason why "qcom,mdss-dsi-ctrl" driver node need to
>>>>>>>> have address/size-cells properties. Document Bindings should also be fixed.
>>>>>>>>>
>>>>>>>>>> Feel free to let us know whether there is different idea of
>>>>>>>>>> "address/size-cells" needed for the "qcom,mdss-dsi-ctrl" driver node.
>>>>>>>>>
>>>>>>>>> The bindings expressed that idea. If the binding is incorrect, fix the
>>>>>>>>> binding and the DTS. If the binding is correct, provide rationale why it
>>>>>>>>> somehow does not apply here etc.
>>>>>>>> Our plan is to fix the bindings as well.
>>>>>>>>
>>>>>>>> In case you have missed the question, I just re-place it here:
>>>>>>>> While there are about 22 different soc dtsi and it's document binding
>>>>>>>> files needed to be fixed. Shall we fix it for all qcom related soc usage
>>>>>>>> in one patch, or we'd better to split into different patches according
>>>>>>>> to soc specifically?
>>>>>>>
>>>>>>> Don't touch the bindings unless you understand what you are doing.
>>>>>>> Your patch will be NAKed. There can be a DSI panel attached to the DSI
>>>>>>> host, which means there is a need for #address-cells / #size-cells.
>>>>>>>
>>>>>> Could you please help to elaborate more on details? Like what's the
>>>>>> right example here for the "qcom,mdss-dsi-ctrl" driver node needed to
>>>>>> have "#address-cells"/"#size-cells".
>>>>>
>>>>> As I wrote, the attached DSI panels make use of #address-cells / #size-cells.
>>>>>
>>>>> Please take a look at the sdm845-mtp.dts, which provides a complex
>>>>> enough example (a panel which is attached to both DSI0 and DSI1
>>>>> hosts).
>>>> I can see the panel example now.
>>>> While panel@0 likely node is not at in the binding that I've checked. There are quite a few of binding document about the same driver. I checked 5 of the bindings document and moste of them are alike, and don't have the panel example.:(
>>>
>>> There is a single bindings documents describing MSM DSI controller, display/MSM/dsi-controller-main.yaml . It explicitly includes ../dsi-controller.yaml, which describes generic DSI host controller. The latter one includes an example of the DSI panel. MSM DSI bindings do not have to include one, there is nothing platform specific there.
>>>
>>>
>>>>>
>>>>>> Thx to chime in that we have put a good amount of time here.
>>>>>
>>>>> Can't quite catch you here.
>>>>>
>>>>>>> Please stop wasting the time on dtc warning. The bindings (and the
>>>>>>> file) are correct.
>>>>>> I don't agree here.
>>>>>> Either it is a wrong usage of "#address-cells"/"#size-cells", or dtc
>>>>>> warning should be fixed with this usage take into account.
>>>>>> "dtb check" will be a good guideline for developers to follow, I don't
>>>>>> think it is wasting time here.
>>>>>
>>>>> It is a guideline, but not a rule. No warnings by default is more of
>>>>> the rule. W=1 enables warnings that developers have to classify and
>>>>> cope with.
>>>>>
>>>>> E.g. I don't think dtc correctly handles the case when there are both
>>>>> with-address and no-address nodes (e.g. 'panel@0' and 'ports'). Note,
>>>>> I might be mistaken there.
>>>> Now I understand the issue, here is some thinking from my end, and welcome others to chime in with more ideas:
>>>> 1. Only put "#address-cells" "#size-cells" right before node of panel@0
>>>
>>> No. Cells specification is a property of the host/bus. As such they do not belong to the board DT file.
>> As "#address-cells" "#size-cells" is not marked as required properties
>> in the Document dsi-controller.yaml. Did it really needed even
>> "panel@[0-3]" is not present at current dsi node?
>> That's good that comes to the initial discussion of current patch here. :)
> 
> The #address-cells / #size-cells describe the addressing of the bus.
> The bus still continues to exist even with no panel being attached.
While even empty "panel@[0-3]" is not required to be written as long as 
there is no panel being attached. Although the bus do have such kind of 
2 bits allocation.
> 
>>
>> I can understand that "#address-cells" "#size-cells" cannot be device
>> tree overlayed by dtbo. While when there is no "panel@[0-3]" nodes shall
>> we also remove "#address-cells" "#size-cells" properties for dsi node?
> 
> But why?
The reason is that "#address-cells" "#size-cells" are not marked as 
"required" properties in dsi-controller.yaml.
Also referenced the other bindings which "$ref:dsi-controller.yaml", 
some of them also not have those 2 properties in dsi node.

Take below 2 examples(there are more of cause):
[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/display/amlogic,meson-g12a-dw-mipi-dsi.yaml
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml

> 
>>>
>>>> 2. Align current binding document with "panel@0" examples.
>>>
>>> There is already a panel in dsi-controller.yaml. Adding another example is optional. Do you also need an example with the external DSI bridge?
>> Current binding I am talking about is current patch binding file:
>> qcom,sm8550-mdss.yaml
> 
> Why do you call it a patch? Also if you have read the description, you
> would have known that the bindings describe the Mobile Display
> Subsystem (MDSS) itself. And then it explicitly tells that the MDSS on
> that platform has (among others) DSI blocks with proper compatibles.
> 
>> It have a ref to mdss-common.yaml,  but I cannot find the ref direct me
>> to dsi-controller.yaml.
> 
> Because qcom,sm8550-mdss.yaml doesn't describe the DSI controller. I
> think I have already mentioned a file that describes the DSI
> controller, it is called display/msm/dsi-controller-main.yaml. Not the
> best name, but it is quickly revealed by grepping for either of the
> DSI compatible strings. And the dsi-controller-main.yaml has `  -
> $ref: ../dsi-controller.yaml#` string inside.
Let me try to describe this in a code way.
"qcom,sm8550-mdss.yaml" binding document is confusing me when it also 
have same compatible string support in the binding. So I will suggest to 
directly reference the "dsi-controller-main.yaml" in file 
"qcom,sm8550-mdss.yaml" instead.

For example:

--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml

@@ -55,14 +50,7 @@ patternProperties:
            - const: qcom,sm8350-dp

    "^dsi@[0-9a-f]+$":
-    type: object
-    additionalProperties: true
-
-    properties:
-      compatible:
-        items:
-          - const: qcom,sm8550-dsi-ctrl
-          - const: qcom,mdss-dsi-ctrl
+    $ref: ../dsi-controller-main.yaml#

With above unified reference change, it will be easier for other 
developers to reference bindings files next time.
Also dsi@[0-9a-f] node in mdss node will be correctly fully described.
> 
>> In my opinion if the example have "#address-cells" "#size-cells", then
>> it's better to also include "panel@0" with "reg = <0>" to not confuse.
> 
> It is already there, see dsi-controller.yaml.
> 
>>>> 3. Too many bindings files for driver "qcom,mdss-dsi-ctrl", shall we align them into 1 binding files.
>>>
>>> There is just one.
>> Currently I mentioned bindings files was searched the compatible
>> "qcom,mdss-dsi-ctrl", and find binding docs like "qcom,sm8550-mdss.yaml"
>> "qcom,sm8450-mdss.yaml" etc.
>> There is duplicate information on "qcom,sm8550-mdss.yaml" etc, while
>> "qcom,mdss-common.yaml" is not common enough for my understanding.
> 
> If you had compared the qcom,SOC-mdss.yaml, you would have seen that
> they provide tight binding between compatible strings used for all the
> subblocks. The `mdss-common.yaml` describes MDSS common properties. It
> describes everything except the platform specifics. It can not be made
> more common. And there is no duplication.
> 
> If you think you can improve the bindings, please send the patches.
I am thinking of a unified qcom,mdss.yaml instead of "qcom,*each 
SOC*-mdss.yaml". I will try to have a patch.
> They must pass the `make dt_binding_check` check.
Thx for the remind.
> 
>>>> 4. enhance the dtc warning check if we still want to have "#address-cells" "#size-cells" even if there is no "panel@0" attached.
>>>
>>> In my opinion this is a way to go, if any. Did you include devicetree@ ML and the corresponding maintainers into the discussion?
>> Already included devicetree@ ML at the very beginning.
> 
> Good, thanks for the confirmation.
> 
>> If the required properties part in each yaml is marked good enough, I
>> think it can be an input for avoid unnecessary dtc warnings.
> 
> Patches are welcome.
Improving developer efficiency with unnecessary warnings is one of my 
interest as well.
First of all, I'd better to make sure "Required properties" attribute in 
current bindings are good enough. Let me try to get back on this in a 
separate discuss session.
> 
>>>
>>>>
>>>> @krzy here I try to answer your comments here as well.
>>>> I am disagree on leave the warning as it is. And want to do something to improve this. Ideas above.
>>>> Let me know if any comments is not right addressed from your comments.
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

