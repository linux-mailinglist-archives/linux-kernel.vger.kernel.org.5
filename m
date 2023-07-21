Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC5775C14E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjGUIUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGUIUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:20:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFC7ED;
        Fri, 21 Jul 2023 01:20:14 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L5fl23028457;
        Fri, 21 Jul 2023 08:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=content-type :
 message-id : date : mime-version : subject : to : cc : references : from :
 in-reply-to; s=qcppdkim1; bh=ReKOwlEt6iFcVUJoSxzed4B8DXu7DxTCpNxa4yi5KMY=;
 b=kklklOUrovmbiYW3i8U/VyU6rZVpdlwX0jjoctH2l0H+eblLnO98MuyNNbRQMzYshw+F
 kMUxJ4AjWVnUczQL53wjYC/ivkPt3+MBWgjsX5CnO8M2B0hsyI3UliYcR5vUWkfzqn5z
 5nKslUbhAg1tzhGG3StctBkbiLOuClNDJDNsEwgKxI1+FOzxnyNqbtXDmJzjdWmfGKJF
 qU4nK0+ehOHNtdphPeRsvv8f0FRE8BWJTz21LhHIkSsoXaTa9ghwakk1waBfgQ6dNyAn
 nngpdP0FXLAqT7oOqy15aLDpOfSeL/M8qz/dxwvzwHfPq3tFXUwVjV0ujSQi8VmStnDB qQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rykser9t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 08:19:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L8JmDW005620
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 08:19:48 GMT
Received: from [10.216.63.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 01:19:42 -0700
Content-Type: multipart/mixed;
        boundary="------------C6jFaf6FSFplgvJE98moETnG"
Message-ID: <f6f2456d-0067-6cd6-3282-8cae7c47a2d3@quicinc.com>
Date:   Fri, 21 Jul 2023 13:49:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 06/10] usb: dwc3: qcom: Add support to read IRQ's
 related to multiport
To:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-7-quic_kriskura@quicinc.com>
 <ZJryrhuUrL5APh4o@hovoldconsulting.com>
 <7e32cf95-1565-5736-cc3e-c70e8d8f3ca7@quicinc.com>
 <ZLo-feuIr2FzCoxa@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZLo-feuIr2FzCoxa@hovoldconsulting.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mWDnjFLV3kgEnmijxyMSGiAQpi78eBmI
X-Proofpoint-ORIG-GUID: mWDnjFLV3kgEnmijxyMSGiAQpi78eBmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210074
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------C6jFaf6FSFplgvJE98moETnG
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 7/21/2023 1:44 PM, Johan Hovold wrote:
> On Mon, Jul 03, 2023 at 12:29:41AM +0530, Krishna Kurapati PSSNV wrote:
>> On 6/27/2023 8:01 PM, Johan Hovold wrote:
>>> On Wed, Jun 21, 2023 at 10:06:24AM +0530, Krishna Kurapati wrote:
>    
>>>> +static int dwc3_qcom_setup_mp_irq(struct platform_device *pdev)
>>>> +{
>>>> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
>>>> +	char irq_name[15];
>>>> +	int irq;
>>>> +	int ret;
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < 4; i++) {
>>>
>>> DWC3_MAX_PORTS here too and similar below.
>>>
>>>> +		if (qcom->dp_hs_phy_irq[i])
>>>> +			continue;
>>>
>>> This is not very nice. You should try to integrate the current lookup
>>> code as I told you to do with the PHY lookups. That is, use a single
>>> loop for all HS/SS IRQs, and pick the legacy name if the number of ports
>>> is 1.
>>>
>>> Of course, you added the xhci capability parsing to the core driver so
>>> that information is not yet available, but you need it in the glue
>>> driver also...
>>>
>>> As I mentioned earlier, you can infer the number of ports from the
>>> interrupt names. Alternatively, you can infer it from the compatible
>>> string. In any case, you should not need to ways to determine the same
>>> information in the glue driver, then in the core part, and then yet
>>> again in the xhci driver...
> 
>>    The reason why I didn't integrate this with the original function was
>> the ACPI stuff. The MP devices have no ACPI variant. And I think for
>> clarity sake its best to keep these two functions separated.
> 
> No. The ACPI stuff may make this a little harder to implement, but
> that's not a sufficient reason to not try to refactor things properly.
> 
>>>> +
>>>> +		sprintf(irq_name, "dp%d_hs_phy_irq", i+1);
>>>
>>> Spaces around binary operators. Does not checkpatch warn about that?
>>>
>>>> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
>>>> +		if (irq > 0) {
>>>> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
>>>> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>>>> +					qcom_dwc3_resume_irq,
>>>> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>>>> +					irq_name, qcom);
>>>> +			if (ret) {
>>>> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
>>>> +				return ret;
>>>> +			}
>>>> +		}
>>>> +
>>>> +		qcom->dp_hs_phy_irq[i] = irq;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < 4; i++) {
>>>> +		if (qcom->dm_hs_phy_irq[i])
>>>> +			continue;
>>>> +
>>>> +		sprintf(irq_name, "dm%d_hs_phy_irq", i+1);
>>>> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
>>>> +		if (irq > 0) {
>>>> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
>>>> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>>>> +					qcom_dwc3_resume_irq,
>>>> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>>>> +					irq_name, qcom);
>>>> +			if (ret) {
>>>> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
>>>> +				return ret;
>>>> +			}
>>>> +		}
>>>> +
>>>> +		qcom->dm_hs_phy_irq[i] = irq;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < 2; i++) {
>>>> +		if (qcom->ss_phy_irq[i])
>>>> +			continue;
>>>> +
>>>> +		sprintf(irq_name, "ss%d_phy_irq", i+1);
>>>> +		irq = dwc3_qcom_get_irq(pdev, irq_name, -1);
>>>> +		if (irq > 0) {
>>>> +			irq_set_status_flags(irq, IRQ_NOAUTOEN);
>>>> +			ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
>>>> +					qcom_dwc3_resume_irq,
>>>> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>>>> +					irq_name, qcom);
>>>> +			if (ret) {
>>>> +				dev_err(qcom->dev, "%s failed: %d\n", irq_name, ret);
>>>> +				return ret;
>>>> +			}
>>>> +		}
>>>> +
>>>> +		qcom->ss_phy_irq[i] = irq;
>>>> +	}
>>>
>>> So the above should all be merged in either a single helper looking up
>>> all the interrupts for a port and resused for the non-MP case.
>>>
>> I agree, Will merge all under some common helper function.
> 
> Good.
> 
> Johan

Hi Johan,

  How about the implementation in the attached patches. This way we 
don't need to know if we are multiport capable or not.

Regards,
Krishna,

--------------C6jFaf6FSFplgvJE98moETnG
Content-Type: text/plain; charset="UTF-8";
	name="0006-usb-dwc3-qcom-Refactor-IRQ-handling-in-QCOM-Glue-dri.patch"
Content-Disposition: attachment;
	filename*0="0006-usb-dwc3-qcom-Refactor-IRQ-handling-in-QCOM-Glue-dri.pa";
	filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjNWJmMTIzNWQ3ZDFjMWI2MjlmZGE3ZjMyMWIzMzY3MWQ5NzA1YjFmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJh
QHF1aWNpbmMuY29tPgpEYXRlOiBXZWQsIDE5IEp1bCAyMDIzIDE5OjI5OjEwICswNTMwClN1
YmplY3Q6IFtQQVRDSCAwNi8xMV0gdXNiOiBkd2MzOiBxY29tOiBSZWZhY3RvciBJUlEgaGFu
ZGxpbmcgaW4gUUNPTSBHbHVlCiBkcml2ZXIKClJlZmFjdG9yIHNldHVwX2lycSBjYWxsIHRv
IGZhY2lsaXRhdGUgcmVhZGluZyBtdWx0aXBvcnQgSVJRJ3MKYWxvbmcgd2l0aCBub24gbXVs
aXRwb3J0IG9uZXMuCgpTaWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2ty
aXNrdXJhQHF1aWNpbmMuY29tPgotLS0KIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMg
fCAxOTYgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCAxMzcgaW5zZXJ0aW9ucygrKSwgNTkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1x
Y29tLmMKaW5kZXggM2RlNDNkZjZiYmU4Li5hYjg2NjRjZWQyNTUgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMKKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LXFjb20uYwpAQCAtNzQsOSArNzQsOSBAQCBzdHJ1Y3QgZHdjM19xY29tIHsKIAlzdHJ1Y3Qg
cmVzZXRfY29udHJvbAkqcmVzZXRzOwogCiAJaW50CQkJaHNfcGh5X2lycTsKLQlpbnQJCQlk
cF9oc19waHlfaXJxOwotCWludAkJCWRtX2hzX3BoeV9pcnE7Ci0JaW50CQkJc3NfcGh5X2ly
cTsKKwlpbnQJCQlkcF9oc19waHlfaXJxW0RXQzNfTUFYX1BPUlRTXTsKKwlpbnQJCQlkbV9o
c19waHlfaXJxW0RXQzNfTUFYX1BPUlRTXTsKKwlpbnQJCQlzc19waHlfaXJxW0RXQzNfTUFY
X1BPUlRTXTsKIAllbnVtIHVzYl9kZXZpY2Vfc3BlZWQJdXNiMl9zcGVlZDsKIAogCXN0cnVj
dCBleHRjb25fZGV2CSplZGV2OwpAQCAtOTMsNiArOTMsNDIgQEAgc3RydWN0IGR3YzNfcWNv
bSB7CiAJc3RydWN0IGljY19wYXRoCQkqaWNjX3BhdGhfYXBwczsKIH07CiAKK3N0cnVjdCBk
d2MzX3Fjb21faXJxX2luZm8geworCWNoYXIJKmR0X25hbWU7CisJY2hhcgkqZGlzcF9uYW1l
OworCWJvb2wJYWNwaV92YXJpYW50X3ByZXNlbnQ7Cit9OworCitjb25zdCBzdHJ1Y3QgZHdj
M19xY29tX2lycV9pbmZvIG5vbl9tcF9pcnFfaW5mb1s0XSA9IHsKKwl7ICJoc19waHlfaXJx
IiwgInFjb21fZHdjMyBIUyIsIHRydWUsIH0sCisJeyAiZHBfaHNfcGh5X2lycSIsICJxY29t
X2R3YzMgRFBfSFMiLCB0cnVlLCB9LAorCXsgImRtX2hzX3BoeV9pcnEiLCAicWNvbV9kd2Mz
IERNX0hTIiwgdHJ1ZSwgfSwKKwl7ICJzc19waHlfaXJxIiwgInFjb21fZHdjMyBTUyIsIHRy
dWUsIH0sCit9OworCitjb25zdCBzdHJ1Y3QgZHdjM19xY29tX2lycV9pbmZvIG1wX2lycV9p
bmZvWzNdW0RXQzNfTUFYX1BPUlRTXSA9IHsKKwl7CisJCXsgImRwX2hzX3BoeV8xIiwgInFj
b21fZHdjMyBEUF9IUzEiLCBmYWxzZSB9LAorCQl7ICJkcF9oc19waHlfMiIsICJxY29tX2R3
YzMgRFBfSFMyIiwgZmFsc2UgfSwKKwkJeyAiZHBfaHNfcGh5XzMiLCAicWNvbV9kd2MzIERQ
X0hTMyIsIGZhbHNlIH0sCisJCXsgImRwX2hzX3BoeV80IiwgInFjb21fZHdjMyBEUF9IUzQi
LCBmYWxzZSB9LAorCX0sCisKKwl7CisJCXsgImRtX2hzX3BoeV8xIiwgInFjb21fZHdjMyBE
TV9IUzEiLCBmYWxzZSB9LAorCQl7ICJkbV9oc19waHlfMiIsICJxY29tX2R3YzMgRE1fSFMy
IiwgZmFsc2UgfSwKKwkJeyAiZG1faHNfcGh5XzMiLCAicWNvbV9kd2MzIERNX0hTMyIsIGZh
bHNlIH0sCisJCXsgImRtX2hzX3BoeV80IiwgInFjb21fZHdjMyBETV9IUzQiLCBmYWxzZSB9
LAorCX0sCisKKwl7CisJCXsgInNzX3BoeV8xIiwgInFjb21fZHdjMyBTUzEiLCBmYWxzZSB9
LAorCQl7ICJzc19waHlfMiIsICJxY29tX2R3YzMgU1MyIiwgZmFsc2UgfSwKKwkJeyAic3Nf
cGh5XzMiLCAicWNvbV9kd2MzIFNTMyIsIGZhbHNlIH0sCisJCXsgInNzX3BoeV80IiwgInFj
b21fZHdjMyBTUzQiLCBmYWxzZSB9LAorCX0sCit9OworCiBzdGF0aWMgaW5saW5lIHZvaWQg
ZHdjM19xY29tX3NldGJpdHModm9pZCBfX2lvbWVtICpiYXNlLCB1MzIgb2Zmc2V0LCB1MzIg
dmFsKQogewogCXUzMiByZWc7CkBAIC0zNzUsMTYgKzQxMSwxNiBAQCBzdGF0aWMgdm9pZCBk
d2MzX3Fjb21fZGlzYWJsZV9pbnRlcnJ1cHRzKHN0cnVjdCBkd2MzX3Fjb20gKnFjb20pCiAJ
ZHdjM19xY29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29tLT5oc19waHlfaXJxKTsKIAogCWlm
IChxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9MT1cpIHsKLQkJZHdjM19xY29tX2Rp
c2FibGVfd2FrZXVwX2lycShxY29tLT5kbV9oc19waHlfaXJxKTsKKwkJZHdjM19xY29tX2Rp
c2FibGVfd2FrZXVwX2lycShxY29tLT5kbV9oc19waHlfaXJxWzBdKTsKIAl9IGVsc2UgaWYg
KChxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9ISUdIKSB8fAogCQkJKHFjb20tPnVz
YjJfc3BlZWQgPT0gVVNCX1NQRUVEX0ZVTEwpKSB7Ci0JCWR3YzNfcWNvbV9kaXNhYmxlX3dh
a2V1cF9pcnEocWNvbS0+ZHBfaHNfcGh5X2lycSk7CisJCWR3YzNfcWNvbV9kaXNhYmxlX3dh
a2V1cF9pcnEocWNvbS0+ZHBfaHNfcGh5X2lycVswXSk7CiAJfSBlbHNlIHsKLQkJZHdjM19x
Y29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29tLT5kcF9oc19waHlfaXJxKTsKLQkJZHdjM19x
Y29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29tLT5kbV9oc19waHlfaXJxKTsKKwkJZHdjM19x
Y29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29tLT5kcF9oc19waHlfaXJxWzBdKTsKKwkJZHdj
M19xY29tX2Rpc2FibGVfd2FrZXVwX2lycShxY29tLT5kbV9oc19waHlfaXJxWzBdKTsKIAl9
CiAKLQlkd2MzX3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPnNzX3BoeV9pcnEpOwor
CWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+c3NfcGh5X2lycVswXSk7CiB9
CiAKIHN0YXRpYyB2b2lkIGR3YzNfcWNvbV9lbmFibGVfaW50ZXJydXB0cyhzdHJ1Y3QgZHdj
M19xY29tICpxY29tKQpAQCAtNDAxLDIwICs0MzcsMjAgQEAgc3RhdGljIHZvaWQgZHdjM19x
Y29tX2VuYWJsZV9pbnRlcnJ1cHRzKHN0cnVjdCBkd2MzX3Fjb20gKnFjb20pCiAJICovCiAK
IAlpZiAocWNvbS0+dXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfTE9XKSB7Ci0JCWR3YzNfcWNv
bV9lbmFibGVfd2FrZXVwX2lycShxY29tLT5kbV9oc19waHlfaXJxLAorCQlkd2MzX3Fjb21f
ZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+ZG1faHNfcGh5X2lycVswXSwKIAkJCQkJCUlSUV9U
WVBFX0VER0VfRkFMTElORyk7CiAJfSBlbHNlIGlmICgocWNvbS0+dXNiMl9zcGVlZCA9PSBV
U0JfU1BFRURfSElHSCkgfHwKIAkJCShxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9G
VUxMKSkgewotCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+ZHBfaHNfcGh5
X2lycSwKKwkJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPmRwX2hzX3BoeV9p
cnFbMF0sCiAJCQkJCQlJUlFfVFlQRV9FREdFX0ZBTExJTkcpOwogCX0gZWxzZSB7Ci0JCWR3
YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShxY29tLT5kcF9oc19waHlfaXJxLAorCQlkd2Mz
X3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+ZHBfaHNfcGh5X2lycVswXSwKIAkJCQkJ
CUlSUV9UWVBFX0VER0VfUklTSU5HKTsKLQkJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJx
KHFjb20tPmRtX2hzX3BoeV9pcnEsCisJCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShx
Y29tLT5kbV9oc19waHlfaXJxWzBdLAogCQkJCQkJSVJRX1RZUEVfRURHRV9SSVNJTkcpOwog
CX0KIAotCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShxY29tLT5zc19waHlfaXJxLCAw
KTsKKwlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+c3NfcGh5X2lycVswXSwg
MCk7CiB9CiAKIHN0YXRpYyBpbnQgZHdjM19xY29tX3N1c3BlbmQoc3RydWN0IGR3YzNfcWNv
bSAqcWNvbSwgYm9vbCB3YWtldXApCkBAIC01MzUsNzIgKzU3MSwxMTQgQEAgc3RhdGljIGlu
dCBkd2MzX3Fjb21fZ2V0X2lycShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LAogCXJl
dHVybiByZXQ7CiB9CiAKK3N0YXRpYyBpbnQgZHdjM19xY29tX3ByZXBfaXJxKHN0cnVjdCBk
d2MzX3Fjb20gKnFjb20sIGNoYXIgKmlycV9uYW1lLAorCQkJCWNoYXIgKmRpc3BfbmFtZSwg
aW50IGlycSkKK3sKKwlpbnQgcmV0OworCisJLyogS2VlcCB3YWtldXAgaW50ZXJydXB0cyBk
aXNhYmxlZCB1bnRpbCBzdXNwZW5kICovCisJaXJxX3NldF9zdGF0dXNfZmxhZ3MoaXJxLCBJ
UlFfTk9BVVRPRU4pOworCXJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEocWNvbS0+
ZGV2LCBpcnEsIE5VTEwsCisJCQkJCXFjb21fZHdjM19yZXN1bWVfaXJxLAorCQkJCQlJUlFG
X1RSSUdHRVJfSElHSCB8IElSUUZfT05FU0hPVCwKKwkJCQkJZGlzcF9uYW1lLCBxY29tKTsK
KwlpZiAocmV0KQorCQlkZXZfZXJyKHFjb20tPmRldiwgIiVzIGZhaWxlZDogJWRcbiIsIGly
cV9uYW1lLCByZXQpOworCisJcmV0dXJuIHJldDsKK30KKwogc3RhdGljIGludCBkd2MzX3Fj
b21fc2V0dXBfaXJxKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7CiAJc3RydWN0
IGR3YzNfcWNvbSAqcWNvbSA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOwogCWNvbnN0
IHN0cnVjdCBkd2MzX2FjcGlfcGRhdGEgKnBkYXRhID0gcWNvbS0+YWNwaV9wZGF0YTsKKwlj
aGFyICpkaXNwX25hbWU7CisJY2hhciAqZHRfbmFtZTsKKwlpbnQgaW5kZXg7CiAJaW50IGly
cTsKIAlpbnQgcmV0OworCWludCBpOwogCi0JaXJxID0gZHdjM19xY29tX2dldF9pcnEocGRl
diwgImhzX3BoeV9pcnEiLAorCWlycSA9IGR3YzNfcWNvbV9nZXRfaXJxKHBkZXYsIG5vbl9t
cF9pcnFfaW5mb1swXS5kdF9uYW1lLAogCQkJCXBkYXRhID8gcGRhdGEtPmhzX3BoeV9pcnFf
aW5kZXggOiAtMSk7CiAJaWYgKGlycSA+IDApIHsKLQkJLyogS2VlcCB3YWtldXAgaW50ZXJy
dXB0cyBkaXNhYmxlZCB1bnRpbCBzdXNwZW5kICovCi0JCWlycV9zZXRfc3RhdHVzX2ZsYWdz
KGlycSwgSVJRX05PQVVUT0VOKTsKLQkJcmV0ID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2ly
cShxY29tLT5kZXYsIGlycSwgTlVMTCwKLQkJCQkJcWNvbV9kd2MzX3Jlc3VtZV9pcnEsCi0J
CQkJCUlSUUZfVFJJR0dFUl9ISUdIIHwgSVJRRl9PTkVTSE9ULAotCQkJCQkicWNvbV9kd2Mz
IEhTIiwgcWNvbSk7Ci0JCWlmIChyZXQpIHsKLQkJCWRldl9lcnIocWNvbS0+ZGV2LCAiaHNf
cGh5X2lycSBmYWlsZWQ6ICVkXG4iLCByZXQpOworCQlyZXQgPSBkd2MzX3Fjb21fcHJlcF9p
cnEocWNvbSwgbm9uX21wX2lycV9pbmZvWzBdLmR0X25hbWUsCisJCQkJbm9uX21wX2lycV9p
bmZvWzBdLmRpc3BfbmFtZSwgaXJxKTsKKwkJaWYgKHJldCkKIAkJCXJldHVybiByZXQ7Ci0J
CX0KIAkJcWNvbS0+aHNfcGh5X2lycSA9IGlycTsKIAl9CiAKLQlpcnEgPSBkd2MzX3Fjb21f
Z2V0X2lycShwZGV2LCAiZHBfaHNfcGh5X2lycSIsCi0JCQkJcGRhdGEgPyBwZGF0YS0+ZHBf
aHNfcGh5X2lycV9pbmRleCA6IC0xKTsKLQlpZiAoaXJxID4gMCkgewotCQlpcnFfc2V0X3N0
YXR1c19mbGFncyhpcnEsIElSUV9OT0FVVE9FTik7Ci0JCXJldCA9IGRldm1fcmVxdWVzdF90
aHJlYWRlZF9pcnEocWNvbS0+ZGV2LCBpcnEsIE5VTEwsCi0JCQkJCXFjb21fZHdjM19yZXN1
bWVfaXJxLAotCQkJCQlJUlFGX1RSSUdHRVJfSElHSCB8IElSUUZfT05FU0hPVCwKLQkJCQkJ
InFjb21fZHdjMyBEUF9IUyIsIHFjb20pOwotCQlpZiAocmV0KSB7Ci0JCQlkZXZfZXJyKHFj
b20tPmRldiwgImRwX2hzX3BoeV9pcnEgZmFpbGVkOiAlZFxuIiwgcmV0KTsKLQkJCXJldHVy
biByZXQ7CisJZm9yIChpID0gMDsgaSA8IERXQzNfTUFYX1BPUlRTOyBpKyspIHsKKwkJZHRf
bmFtZSA9IG1wX2lycV9pbmZvWzBdW2ldLmR0X25hbWU7CisJCWRpc3BfbmFtZSA9IG1wX2ly
cV9pbmZvWzBdW2ldLmRpc3BfbmFtZTsKKwkJaW5kZXggPSAobXBfaXJxX2luZm9bMF1baV0u
YWNwaV92YXJpYW50X3ByZXNlbnQgJiYgcGRhdGEpID8KKwkJCQlwZGF0YS0+ZHBfaHNfcGh5
X2lycV9pbmRleCA6IC0xOworCisJCWlycSA9IGR3YzNfcWNvbV9nZXRfaXJxKHBkZXYsIGR0
X25hbWUsIGluZGV4KTsKKwkJaWYgKChpcnEgPCAwKSAmJiAoaSA9PSAwKSkgeworCQkJZHRf
bmFtZSA9IG5vbl9tcF9pcnFfaW5mb1sxXS5kdF9uYW1lOworCQkJZGlzcF9uYW1lID0gbm9u
X21wX2lycV9pbmZvWzFdLmRpc3BfbmFtZTsKKwkJCWluZGV4ID0gKG5vbl9tcF9pcnFfaW5m
b1sxXS5hY3BpX3ZhcmlhbnRfcHJlc2VudCAmJiBwZGF0YSkgPworCQkJCQlwZGF0YS0+ZHBf
aHNfcGh5X2lycV9pbmRleCA6IC0xOworCisJCQlpcnEgPSBkd2MzX3Fjb21fZ2V0X2lycShw
ZGV2LCBkdF9uYW1lLCBpbmRleCk7CisJCX0KKworCQlpZiAoaXJxID4gMCkgeworCQkJcmV0
ID0gZHdjM19xY29tX3ByZXBfaXJxKHFjb20sIGR0X25hbWUsIGRpc3BfbmFtZSwgaXJxKTsK
KwkJCWlmIChyZXQpCisJCQkJcmV0dXJuIHJldDsKKwkJCXFjb20tPmRwX2hzX3BoeV9pcnFb
aV0gPSBpcnE7CiAJCX0KLQkJcWNvbS0+ZHBfaHNfcGh5X2lycSA9IGlycTsKIAl9CiAKLQlp
cnEgPSBkd2MzX3Fjb21fZ2V0X2lycShwZGV2LCAiZG1faHNfcGh5X2lycSIsCi0JCQkJcGRh
dGEgPyBwZGF0YS0+ZG1faHNfcGh5X2lycV9pbmRleCA6IC0xKTsKLQlpZiAoaXJxID4gMCkg
ewotCQlpcnFfc2V0X3N0YXR1c19mbGFncyhpcnEsIElSUV9OT0FVVE9FTik7Ci0JCXJldCA9
IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEocWNvbS0+ZGV2LCBpcnEsIE5VTEwsCi0JCQkJ
CXFjb21fZHdjM19yZXN1bWVfaXJxLAotCQkJCQlJUlFGX1RSSUdHRVJfSElHSCB8IElSUUZf
T05FU0hPVCwKLQkJCQkJInFjb21fZHdjMyBETV9IUyIsIHFjb20pOwotCQlpZiAocmV0KSB7
Ci0JCQlkZXZfZXJyKHFjb20tPmRldiwgImRtX2hzX3BoeV9pcnEgZmFpbGVkOiAlZFxuIiwg
cmV0KTsKLQkJCXJldHVybiByZXQ7CisJZm9yIChpID0gMDsgaSA8IERXQzNfTUFYX1BPUlRT
OyBpKyspIHsKKwkJZHRfbmFtZSA9IG1wX2lycV9pbmZvWzFdW2ldLmR0X25hbWU7CisJCWRp
c3BfbmFtZSA9IG1wX2lycV9pbmZvWzFdW2ldLmRpc3BfbmFtZTsKKwkJaW5kZXggPSAobXBf
aXJxX2luZm9bMV1baV0uYWNwaV92YXJpYW50X3ByZXNlbnQgJiYgcGRhdGEpID8KKwkJCQlw
ZGF0YS0+ZG1faHNfcGh5X2lycV9pbmRleCA6IC0xOworCisJCWlycSA9IGR3YzNfcWNvbV9n
ZXRfaXJxKHBkZXYsIGR0X25hbWUsIGluZGV4KTsKKwkJaWYgKChpcnEgPCAwKSAmJiAoaSA9
PSAwKSkgeworCQkJZHRfbmFtZSA9IG5vbl9tcF9pcnFfaW5mb1syXS5kdF9uYW1lOworCQkJ
ZGlzcF9uYW1lID0gbm9uX21wX2lycV9pbmZvWzJdLmRpc3BfbmFtZTsKKwkJCWluZGV4ID0g
KG5vbl9tcF9pcnFfaW5mb1syXS5hY3BpX3ZhcmlhbnRfcHJlc2VudCAmJiBwZGF0YSkgPwor
CQkJCQlwZGF0YS0+ZHBfaHNfcGh5X2lycV9pbmRleCA6IC0xOworCisJCQlpcnEgPSBkd2Mz
X3Fjb21fZ2V0X2lycShwZGV2LCBkdF9uYW1lLCBpbmRleCk7CisJCX0KKworCQlpZiAoaXJx
ID4gMCkgeworCQkJcmV0ID0gZHdjM19xY29tX3ByZXBfaXJxKHFjb20sIGR0X25hbWUsIGRp
c3BfbmFtZSwgaXJxKTsKKwkJCWlmIChyZXQpCisJCQkJcmV0dXJuIHJldDsKKwkJCXFjb20t
PmRtX2hzX3BoeV9pcnFbaV0gPSBpcnE7CiAJCX0KLQkJcWNvbS0+ZG1faHNfcGh5X2lycSA9
IGlycTsKIAl9CiAKLQlpcnEgPSBkd2MzX3Fjb21fZ2V0X2lycShwZGV2LCAic3NfcGh5X2ly
cSIsCi0JCQkJcGRhdGEgPyBwZGF0YS0+c3NfcGh5X2lycV9pbmRleCA6IC0xKTsKLQlpZiAo
aXJxID4gMCkgewotCQlpcnFfc2V0X3N0YXR1c19mbGFncyhpcnEsIElSUV9OT0FVVE9FTik7
Ci0JCXJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEocWNvbS0+ZGV2LCBpcnEsIE5V
TEwsCi0JCQkJCXFjb21fZHdjM19yZXN1bWVfaXJxLAotCQkJCQlJUlFGX1RSSUdHRVJfSElH
SCB8IElSUUZfT05FU0hPVCwKLQkJCQkJInFjb21fZHdjMyBTUyIsIHFjb20pOwotCQlpZiAo
cmV0KSB7Ci0JCQlkZXZfZXJyKHFjb20tPmRldiwgInNzX3BoeV9pcnEgZmFpbGVkOiAlZFxu
IiwgcmV0KTsKLQkJCXJldHVybiByZXQ7CisJZm9yIChpID0gMDsgaSA8IERXQzNfTUFYX1BP
UlRTOyBpKyspIHsKKwkJZHRfbmFtZSA9IG1wX2lycV9pbmZvWzJdW2ldLmR0X25hbWU7CisJ
CWRpc3BfbmFtZSA9IG1wX2lycV9pbmZvWzJdW2ldLmRpc3BfbmFtZTsKKwkJaW5kZXggPSAo
bXBfaXJxX2luZm9bMl1baV0uYWNwaV92YXJpYW50X3ByZXNlbnQgJiYgcGRhdGEpID8KKwkJ
CQlwZGF0YS0+c3NfcGh5X2lycV9pbmRleCA6IC0xOworCisJCWlycSA9IGR3YzNfcWNvbV9n
ZXRfaXJxKHBkZXYsIGR0X25hbWUsIGluZGV4KTsKKwkJaWYgKChpcnEgPCAwKSAmJiAoaSA9
PSAwKSkgeworCQkJZHRfbmFtZSA9IG5vbl9tcF9pcnFfaW5mb1szXS5kdF9uYW1lOworCQkJ
ZGlzcF9uYW1lID0gbm9uX21wX2lycV9pbmZvWzNdLmRpc3BfbmFtZTsKKwkJCWluZGV4ID0g
KG5vbl9tcF9pcnFfaW5mb1szXS5hY3BpX3ZhcmlhbnRfcHJlc2VudCAmJiBwZGF0YSkgPwor
CQkJCQlwZGF0YS0+ZHBfaHNfcGh5X2lycV9pbmRleCA6IC0xOworCisJCQlpcnEgPSBkd2Mz
X3Fjb21fZ2V0X2lycShwZGV2LCBkdF9uYW1lLCBpbmRleCk7CisJCX0KKworCQlpZiAoaXJx
ID4gMCkgeworCQkJcmV0ID0gZHdjM19xY29tX3ByZXBfaXJxKHFjb20sIGR0X25hbWUsIGRp
c3BfbmFtZSwgaXJxKTsKKwkJCWlmIChyZXQpCisJCQkJcmV0dXJuIHJldDsKKwkJCXFjb20t
PnNzX3BoeV9pcnFbaV0gPSBpcnE7CiAJCX0KLQkJcWNvbS0+c3NfcGh5X2lycSA9IGlycTsK
IAl9CiAKIAlyZXR1cm4gMDsKLS0gCjIuNDAuMAoK
--------------C6jFaf6FSFplgvJE98moETnG
Content-Type: text/plain; charset="UTF-8";
	name="0007-usb-dwc3-qcom-Enable-wakeup-for-mulitport-IRQ-s.patch"
Content-Disposition: attachment;
	filename="0007-usb-dwc3-qcom-Enable-wakeup-for-mulitport-IRQ-s.patch"
Content-Transfer-Encoding: base64

RnJvbSBmYTdlZTI0ZjNlYjEwOWUxNWIyMDdkOGE5ZjI5ZDRkYjRkOTVmYjA1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJh
QHF1aWNpbmMuY29tPgpEYXRlOiBGcmksIDIxIEp1bCAyMDIzIDA5OjU4OjQ5ICswNTMwClN1
YmplY3Q6IFtQQVRDSCAwNy8xMV0gdXNiOiBkd2MzOiBxY29tOyBFbmFibGUgd2FrZXVwIGZv
ciBtdWxpdHBvcnQgSVJRJ3MKCkVuYWJsZSB3YWtldXAgZm9yIG11bHRpcG9ydCBJUlEncyB0
byBiZSBhYmxlIHRvIHdha2V1cCB0aGUgRFVUCmZyb20gc3lzdGVtIHN1c3BlbmQgd2hlbiBp
biBob3N0IG1vZGUuCgpTaWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2ty
aXNrdXJhQHF1aWNpbmMuY29tPgotLS0KIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMg
fCAzNCArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMjQgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9kd2MzLXFjb20uYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29t
LmMKaW5kZXggYWI4NjY0Y2VkMjU1Li4zMTk2ODYyMGU2ZmYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvdXNiL2R3YzMvZHdjMy1xY29tLmMKKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFj
b20uYwpAQCAtNDA4LDIzICs0MDgsMzIgQEAgc3RhdGljIHZvaWQgZHdjM19xY29tX2Rpc2Fi
bGVfd2FrZXVwX2lycShpbnQgaXJxKQogCiBzdGF0aWMgdm9pZCBkd2MzX3Fjb21fZGlzYWJs
ZV9pbnRlcnJ1cHRzKHN0cnVjdCBkd2MzX3Fjb20gKnFjb20pCiB7CisJaW50IGk7CisKIAlk
d2MzX3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPmhzX3BoeV9pcnEpOwogCiAJaWYg
KHFjb20tPnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0xPVykgewotCQlkd2MzX3Fjb21fZGlz
YWJsZV93YWtldXBfaXJxKHFjb20tPmRtX2hzX3BoeV9pcnFbMF0pOworCQlmb3IgKGkgPSAw
OyBpIDwgRFdDM19NQVhfUE9SVFM7IGkrKykKKwkJCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1
cF9pcnEocWNvbS0+ZG1faHNfcGh5X2lycVtpXSk7CiAJfSBlbHNlIGlmICgocWNvbS0+dXNi
Ml9zcGVlZCA9PSBVU0JfU1BFRURfSElHSCkgfHwKIAkJCShxY29tLT51c2IyX3NwZWVkID09
IFVTQl9TUEVFRF9GVUxMKSkgewotCQlkd2MzX3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFj
b20tPmRwX2hzX3BoeV9pcnFbMF0pOworCQlmb3IgKGkgPSAwOyBpIDwgRFdDM19NQVhfUE9S
VFM7IGkrKykKKwkJCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+ZHBfaHNf
cGh5X2lycVtpXSk7CiAJfSBlbHNlIHsKLQkJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVwX2ly
cShxY29tLT5kcF9oc19waHlfaXJxWzBdKTsKLQkJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVw
X2lycShxY29tLT5kbV9oc19waHlfaXJxWzBdKTsKKwkJZm9yIChpID0gMDsgaSA8IERXQzNf
TUFYX1BPUlRTOyBpKyspIHsKKwkJCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNv
bS0+ZHBfaHNfcGh5X2lycVtpXSk7CisJCQlkd2MzX3Fjb21fZGlzYWJsZV93YWtldXBfaXJx
KHFjb20tPmRtX2hzX3BoeV9pcnFbaV0pOworCQl9CiAJfQogCi0JZHdjM19xY29tX2Rpc2Fi
bGVfd2FrZXVwX2lycShxY29tLT5zc19waHlfaXJxWzBdKTsKKwlmb3IgKGkgPSAwOyBpIDwg
RFdDM19NQVhfUE9SVFM7IGkrKykKKwkJZHdjM19xY29tX2Rpc2FibGVfd2FrZXVwX2lycShx
Y29tLT5zc19waHlfaXJxW2ldKTsKIH0KIAogc3RhdGljIHZvaWQgZHdjM19xY29tX2VuYWJs
ZV9pbnRlcnJ1cHRzKHN0cnVjdCBkd2MzX3Fjb20gKnFjb20pCiB7CisJaW50IGk7CisKIAlk
d2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+aHNfcGh5X2lycSwgMCk7CiAKIAkv
KgpAQCAtNDM3LDIwICs0NDYsMjUgQEAgc3RhdGljIHZvaWQgZHdjM19xY29tX2VuYWJsZV9p
bnRlcnJ1cHRzKHN0cnVjdCBkd2MzX3Fjb20gKnFjb20pCiAJICovCiAKIAlpZiAocWNvbS0+
dXNiMl9zcGVlZCA9PSBVU0JfU1BFRURfTE9XKSB7Ci0JCWR3YzNfcWNvbV9lbmFibGVfd2Fr
ZXVwX2lycShxY29tLT5kbV9oc19waHlfaXJxWzBdLAorCQlmb3IgKGkgPSAwOyBpIDwgRFdD
M19NQVhfUE9SVFM7IGkrKykKKwkJCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShxY29t
LT5kbV9oc19waHlfaXJxW2ldLAogCQkJCQkJSVJRX1RZUEVfRURHRV9GQUxMSU5HKTsKIAl9
IGVsc2UgaWYgKChxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9ISUdIKSB8fAogCQkJ
KHFjb20tPnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0ZVTEwpKSB7Ci0JCWR3YzNfcWNvbV9l
bmFibGVfd2FrZXVwX2lycShxY29tLT5kcF9oc19waHlfaXJxWzBdLAorCQlmb3IgKGkgPSAw
OyBpIDwgRFdDM19NQVhfUE9SVFM7IGkrKykKKwkJCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVw
X2lycShxY29tLT5kcF9oc19waHlfaXJxW2ldLAogCQkJCQkJSVJRX1RZUEVfRURHRV9GQUxM
SU5HKTsKIAl9IGVsc2UgewotCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+
ZHBfaHNfcGh5X2lycVswXSwKKwkJZm9yIChpID0gMDsgaSA8IERXQzNfTUFYX1BPUlRTOyBp
KyspCisJCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+ZHBfaHNfcGh5X2ly
cVtpXSwKIAkJCQkJCUlSUV9UWVBFX0VER0VfUklTSU5HKTsKLQkJZHdjM19xY29tX2VuYWJs
ZV93YWtldXBfaXJxKHFjb20tPmRtX2hzX3BoeV9pcnFbMF0sCisJCQlkd2MzX3Fjb21fZW5h
YmxlX3dha2V1cF9pcnEocWNvbS0+ZG1faHNfcGh5X2lycVtpXSwKIAkJCQkJCUlSUV9UWVBF
X0VER0VfUklTSU5HKTsKKwkJfQogCX0KIAotCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2ly
cShxY29tLT5zc19waHlfaXJxWzBdLCAwKTsKKwlmb3IgKGkgPSAwOyBpIDwgRFdDM19NQVhf
UE9SVFM7IGkrKykKKwkJZHdjM19xY29tX2VuYWJsZV93YWtldXBfaXJxKHFjb20tPnNzX3Bo
eV9pcnFbaV0sIDApOwogfQogCiBzdGF0aWMgaW50IGR3YzNfcWNvbV9zdXNwZW5kKHN0cnVj
dCBkd2MzX3Fjb20gKnFjb20sIGJvb2wgd2FrZXVwKQotLSAKMi40MC4wCgo=

--------------C6jFaf6FSFplgvJE98moETnG--
