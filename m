Return-Path: <linux-kernel+bounces-6795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98654819DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1C61C22648
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3935210F6;
	Wed, 20 Dec 2023 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmK47ozb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B7210E5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso6990719e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703070653; x=1703675453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P00l5/G39/CnZAwz3Y6Rt1CsAq7TTvtXn370Rl4vz8I=;
        b=PmK47ozbdOl2/UOohZyIthofqUyJzMI1ved/rfnSmj/jZX/u6HkKnluwlIQSV5ox4V
         kBoo8b2UT+VS1e3Hdrjd9ad2Py6gogRhuT5ml/C6klvUlbM8OFbn/jgMguxmsdGNbwFo
         tecmgb94aU6agrgMlhI1rJYbq/nkrrtBX9/BaCTyCVQAPuaJ42UMGfD0E2RgVAIAHKl8
         VE5Fa29qJT0/5RrFxMSEy4Bf9abrFBLY22WXSnI30LguBG8QW/TVA65K94m7tm2z/CPc
         aDBVb8x5JTZYDHQFV7u5XOyCtbecwnwvZ0A+Qb+YYTwW0K0h8pi0RyMuZV6YDuRFbdS8
         veaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703070653; x=1703675453;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P00l5/G39/CnZAwz3Y6Rt1CsAq7TTvtXn370Rl4vz8I=;
        b=lchjpyqdVUyGZ81B91xBCtNF8HjIG82Ig0KlhdGefL9j4mxzP4GqROHTIwThAflh0O
         hYw3//J/f8PYCCX8hEDLTOufg4pPZKnFvbJ7taBBg9UHVjN5ZhIxK4szBuzB7CrgyM1D
         dxaOznmhpzgfq6XZ7eXBqQwrdW0zLWAuiBZVh2KCTDN6ZZ3T5ybMY8Zcoxr8vhqF3QGu
         HTk8I3XSxdnm9w/BA94oHH22uzfoOA9aSa3KaepCkrowkKEdrgURxdnuOtOi+j8Ve8aI
         /58cJ4w86+GQ0g0LrGOFOPZxUteJiX0AWM22WFv4+jETfEhe8P8m9IGPATcXZCNjiUJN
         Rjyw==
X-Gm-Message-State: AOJu0YxlctjO1h307M29I1bELllOJTy4jh+W/LsljYcqa+XPpIWcsPmC
	75atGfIy2jL+L9YHu6dD4zuDjw==
X-Google-Smtp-Source: AGHT+IG/rJCmGU7XChgEkU22t7hSpwmgWoOlR6cnr9LRJVLEw5Z+uocoAZtyLq0Iv0se76UtYjMM1w==
X-Received: by 2002:a05:6512:752:b0:50e:2f29:4794 with SMTP id c18-20020a056512075200b0050e2f294794mr3025837lfs.86.1703070653108;
        Wed, 20 Dec 2023 03:10:53 -0800 (PST)
Received: from [127.0.0.1] (85-76-103-161-nat.elisa-mobile.fi. [85.76.103.161])
        by smtp.gmail.com with ESMTPSA id dw11-20020a0565122c8b00b0050d12f2a97asm3450874lfb.177.2023.12.20.03.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 03:10:52 -0800 (PST)
Date: Wed, 20 Dec 2023 13:10:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/1=5D_arm64=3A_dts=3A_qcom=3A_sm855?= =?US-ASCII?Q?0=3A_remove_address/size-cells_from_mdss=5Fdsi1?=
User-Agent: K-9 Mail for Android
In-Reply-To: <72305a35-02e6-4ff6-8251-01f986530c5d@quicinc.com>
References: <20231219003106.8663-1-quic_tengfan@quicinc.com> <20231219003106.8663-2-quic_tengfan@quicinc.com> <457e336e-004c-4721-b58d-e9ada16dc04b@linaro.org> <a8f168da-14f7-4377-8dea-f282a3eac0a4@quicinc.com> <13b61d41-6045-499e-864b-51c6cb6eacf9@linaro.org> <38604415-b410-4995-9c4f-525536435699@quicinc.com> <CAA8EJpo07gE7ZeNP6wSGTLtmF_3PKQAKFyMRZ8dk1K+f7PAxrg@mail.gmail.com> <ad1547cf-0520-422d-a105-ec426f526d71@quicinc.com> <CAA8EJppwsezPV21Uw8xTn=ra8L2jfnkHoRghDPN96O5tJsOD7A@mail.gmail.com> <72305a35-02e6-4ff6-8251-01f986530c5d@quicinc.com>
Message-ID: <A45746C4-54C9-48D2-9DB7-52B4B56854E6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20 December 2023 12:33:07 EET, "Aiqun Yu (Maria)" <quic_aiquny@quicinc=
=2Ecom> wrote:
>
>
>On 12/20/2023 3:06 PM, Dmitry Baryshkov wrote:
>> On Wed, 20 Dec 2023 at 02:54, Aiqun Yu (Maria) <quic_aiquny@quicinc=2Ec=
om> wrote:
>>>=20
>>>=20
>>>=20
>>> On 12/19/2023 6:21 PM, Dmitry Baryshkov wrote:
>>>> On Tue, 19 Dec 2023 at 12:09, Aiqun Yu (Maria) <quic_aiquny@quicinc=
=2Ecom> wrote:
>>>>>=20
>>>>>=20
>>>>>=20
>>>>> On 12/19/2023 5:41 PM, Krzysztof Kozlowski wrote:
>>>>>> On 19/12/2023 10:36, Aiqun Yu (Maria) wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>> On 12/19/2023 3:17 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On 19/12/2023 01:31, Tengfei Fan wrote:
>>>>>>>>> The address/size-cells in mdss_dsi1 node have not ranges and chi=
ld also
>>>>>>>>> have not reg, then this leads to dtc W=3D1 warnings:
>>>>>>>>=20
>>>>>>> Comments can be more readable:
>>>>>>> "mdss_dsi1" node don't have "ranges" or child "reg" property, whil=
e it
>>>>>>> have address/size-cells properties=2E This caused
>>>>>>> "avoid_unnecessary_addr_size" warning from dtb check=2E
>>>>>>> Remove address/size-cells properties for "mdss_dsi1" node=2E
>>>>>>>=20
>>>>>>>> I cannot parse it=2E Address/size cells never have ranges or chil=
dren=2E
>>>>>>>> They cannot have=2E These are uint32 properties=2E
>>>>>>> Pls help to comment on the revised commit message=2E Every time I =
write a
>>>>>>> commit message, also takes a while for me to double confirm whethe=
r
>>>>>>> others can understand me correctly as well=2E Feel free to let us =
know if
>>>>>>> it is not readable to you=2E It will help us as non-English native=
 developers=2E
>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>>       sm8550=2Edtsi:2937=2E27-2992=2E6: Warning (avoid_unnecessa=
ry_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
>>>>>>>>>         unnecessary #address-cells/#size-cells without "ranges" =
or child "reg" property
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry=2Ebaryshkov@linaro=2Eorg>
>>>>>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc=2Ecom>
>>>>>>>>> ---
>>>>>>>>=20
>>>>>>>> I disagreed with the patch before=2E You resubmit it without real=
ly
>>>>>>>> addressing my concerns=2E
>>>>>>>>=20
>>>>>>>> I am not sure if this is correct fix and I want to fix all of suc=
h
>>>>>>>> errors (there are multiple of them) in the same way=2E Feel free =
to
>>>>>>>> propose common solution based on arguments=2E
>>>>>>> Per my understanding, "qcom,mdss-dsi-ctrl" driver node like "mdss_=
dsi1"
>>>>>>> don't need to have address/size-cells properties=2E
>>>>>>=20
>>>>>> Just because dtc says so? And what about bindings?
>>>>> I don't find any reason why "qcom,mdss-dsi-ctrl" driver node need to
>>>>> have address/size-cells properties=2E Document Bindings should also =
be fixed=2E
>>>>>>=20
>>>>>>> Feel free to let us know whether there is different idea of
>>>>>>> "address/size-cells" needed for the "qcom,mdss-dsi-ctrl" driver no=
de=2E
>>>>>>=20
>>>>>> The bindings expressed that idea=2E If the binding is incorrect, fi=
x the
>>>>>> binding and the DTS=2E If the binding is correct, provide rationale=
 why it
>>>>>> somehow does not apply here etc=2E
>>>>> Our plan is to fix the bindings as well=2E
>>>>>=20
>>>>> In case you have missed the question, I just re-place it here:
>>>>> While there are about 22 different soc dtsi and it's document bindin=
g
>>>>> files needed to be fixed=2E Shall we fix it for all qcom related soc=
 usage
>>>>> in one patch, or we'd better to split into different patches accordi=
ng
>>>>> to soc specifically?
>>>>=20
>>>> Don't touch the bindings unless you understand what you are doing=2E
>>>> Your patch will be NAKed=2E There can be a DSI panel attached to the =
DSI
>>>> host, which means there is a need for #address-cells / #size-cells=2E
>>>>=20
>>> Could you please help to elaborate more on details? Like what's the
>>> right example here for the "qcom,mdss-dsi-ctrl" driver node needed to
>>> have "#address-cells"/"#size-cells"=2E
>>=20
>> As I wrote, the attached DSI panels make use of #address-cells / #size-=
cells=2E
>>=20
>> Please take a look at the sdm845-mtp=2Edts, which provides a complex
>> enough example (a panel which is attached to both DSI0 and DSI1
>> hosts)=2E
>I can see the panel example now=2E
>While panel@0 likely node is not at in the binding that I've checked=2E T=
here are quite a few of binding document about the same driver=2E I checked=
 5 of the bindings document and moste of them are alike, and don't have the=
 panel example=2E:(

There is a single bindings documents describing MSM DSI controller, displa=
y/MSM/dsi-controller-main=2Eyaml =2E It explicitly includes =2E=2E/dsi-cont=
roller=2Eyaml, which describes generic DSI host controller=2E The latter on=
e includes an example of the DSI panel=2E MSM DSI bindings do not have to i=
nclude one, there is nothing platform specific there=2E


>>=20
>>> Thx to chime in that we have put a good amount of time here=2E
>>=20
>> Can't quite catch you here=2E
>>=20
>>>> Please stop wasting the time on dtc warning=2E The bindings (and the
>>>> file) are correct=2E
>>> I don't agree here=2E
>>> Either it is a wrong usage of "#address-cells"/"#size-cells", or dtc
>>> warning should be fixed with this usage take into account=2E
>>> "dtb check" will be a good guideline for developers to follow, I don't
>>> think it is wasting time here=2E
>>=20
>> It is a guideline, but not a rule=2E No warnings by default is more of
>> the rule=2E W=3D1 enables warnings that developers have to classify and
>> cope with=2E
>>=20
>> E=2Eg=2E I don't think dtc correctly handles the case when there are bo=
th
>> with-address and no-address nodes (e=2Eg=2E 'panel@0' and 'ports')=2E N=
ote,
>> I might be mistaken there=2E
>Now I understand the issue, here is some thinking from my end, and welcom=
e others to chime in with more ideas:
>1=2E Only put "#address-cells" "#size-cells" right before node of panel@0

No=2E Cells specification is a property of the host/bus=2E As such they do=
 not belong to the board DT file=2E

>2=2E Align current binding document with "panel@0" examples=2E

There is already a panel in dsi-controller=2Eyaml=2E Adding another exampl=
e is optional=2E Do you also need an example with the external DSI bridge?=
=20


>3=2E Too many bindings files for driver "qcom,mdss-dsi-ctrl", shall we al=
ign them into 1 binding files=2E

There is just one=2E


>4=2E enhance the dtc warning check if we still want to have "#address-cel=
ls" "#size-cells" even if there is no "panel@0" attached=2E

In my opinion this is a way to go, if any=2E Did you include devicetree@ M=
L and the corresponding maintainers into the discussion?

>
>@krzy here I try to answer your comments here as well=2E
>I am disagree on leave the warning as it is=2E And want to do something t=
o improve this=2E Ideas above=2E
>Let me know if any comments is not right addressed from your comments=2E
>>=20
>>>>=20
>>>=20
>>> --
>>> Thx and BRs,
>>> Aiqun(Maria) Yu
>>=20
>>=20
>>=20
>


