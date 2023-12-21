Return-Path: <linux-kernel+bounces-8166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A190781B2FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C577C1C239E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6A4F884;
	Thu, 21 Dec 2023 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kMss3NnO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5604F203
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e7415df4d6so13975487b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 01:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703152599; x=1703757399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i86WWCv3hv5GoQdCMK76RM5UpOhcDn7MONJ3V9hm4PU=;
        b=kMss3NnOQ+VptQMOM48DRdQWBAyLaMUCLWoDFCvidspWFZOKaljCpdZW3IcwATtp5Z
         QmWluZpxhavMsd4lfPckURY6ZPE315p6BKf1RinHg2AvKzOpVh6pze02PVy9fsJVwFw5
         qd622YiCwILWQhsPOREEd2afzN9PAszl6YOz1uJ4vlGzpl5JI12AcGGD3oMP5mIFLA5m
         /sHUBz1XPM8g5iZkjGRUcgiFGyw9uG0UxHg8VjY3xWYJxXeO2XNVBiRpyMoi6mSlJQGT
         u9XTRnRY9HCIzJtQwGDNY8ETX8ZiVRdxt5Cb5+4jqe/8sJTnVRq7xHwuTFyS6pBCDRrw
         B9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703152599; x=1703757399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i86WWCv3hv5GoQdCMK76RM5UpOhcDn7MONJ3V9hm4PU=;
        b=I3t8lnmHS9pkmvqj5NjEIo1EAvpaEdCOyGP8ubhQBYTt06rTe5fmgI06inRhMcibZr
         abHfCyMQkbQp7e/XoHKmRBxVtsVZHMVN3MRLRFxPdqWwrtS7tAIDO1TIS1vtP2DjJrQT
         1RaT1xtMdoKZPXqc6Qo336X9AT8TEpk3seuB9TlBrGLSO8x2Io16fciKn8sHmMNcf52h
         jNH6lHzaSAewX6S1qyXakE/mDJ64zleZejXSTUG9A8D6kwml2/4X9TyEvRV4H1nqErY1
         cYBWa3Z1xD24Zq0FoL6G54SgpmnFBS/vjiyb7GjUc5pYYSbYXJz8CJId0hv6ZW665ro+
         3PSQ==
X-Gm-Message-State: AOJu0YwWVDdN5PD+oChbw/WcrbWAFZND8nawhlchPNgUilSfvgfiFDrG
	iAk2sUVGAcXXtg583oRLC61SbdTImVmEPAkL5+by6Es/eLabaA==
X-Google-Smtp-Source: AGHT+IFN3y6D22umgZiLv0ZEDtNyEDOes2MUdUQ4twffcZrDsvHNDjoTKJ9AWpHqiB3O04OhM9lPKv+yCf4rXN3qdWI=
X-Received: by 2002:a81:498c:0:b0:5e0:8545:cc82 with SMTP id
 w134-20020a81498c000000b005e08545cc82mr186918ywa.39.1703152598723; Thu, 21
 Dec 2023 01:56:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
 <20231219003106.8663-2-quic_tengfan@quicinc.com> <457e336e-004c-4721-b58d-e9ada16dc04b@linaro.org>
 <a8f168da-14f7-4377-8dea-f282a3eac0a4@quicinc.com> <13b61d41-6045-499e-864b-51c6cb6eacf9@linaro.org>
 <38604415-b410-4995-9c4f-525536435699@quicinc.com> <CAA8EJpo07gE7ZeNP6wSGTLtmF_3PKQAKFyMRZ8dk1K+f7PAxrg@mail.gmail.com>
 <ad1547cf-0520-422d-a105-ec426f526d71@quicinc.com> <CAA8EJppwsezPV21Uw8xTn=ra8L2jfnkHoRghDPN96O5tJsOD7A@mail.gmail.com>
 <72305a35-02e6-4ff6-8251-01f986530c5d@quicinc.com> <A45746C4-54C9-48D2-9DB7-52B4B56854E6@linaro.org>
 <4e328cd8-9ef7-42ce-b592-7f2216c00c0b@quicinc.com> <CAA8EJprE8v3bhHfyZJM9SJT=ShJ-LQvk5mR=gpdAWXF2yANWbQ@mail.gmail.com>
 <e88787dc-ed03-42d2-a6e7-fb88bbc89357@quicinc.com>
In-Reply-To: <e88787dc-ed03-42d2-a6e7-fb88bbc89357@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Dec 2023 11:56:27 +0200
Message-ID: <CAA8EJpreeQDmSm_nGwnBXgMGNfS83jjYGTgLZ0tvft=xyBEZvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: sm8550: remove
 address/size-cells from mdss_dsi1
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tengfei Fan <quic_tengfan@quicinc.com>, 
	andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Dec 2023 at 10:49, Aiqun Yu (Maria) <quic_aiquny@quicinc.com> wr=
ote:
>
>
>
> On 12/21/2023 2:59 PM, Dmitry Baryshkov wrote:
> > On Thu, 21 Dec 2023 at 03:57, Aiqun Yu (Maria) <quic_aiquny@quicinc.com=
> wrote:
> >>
> >>
> >>
> >> On 12/20/2023 7:10 PM, Dmitry Baryshkov wrote:
> >>> On 20 December 2023 12:33:07 EET, "Aiqun Yu (Maria)" <quic_aiquny@qui=
cinc.com> wrote:
> >>>>
> >>>>
> >>>> On 12/20/2023 3:06 PM, Dmitry Baryshkov wrote:
> >>>>> On Wed, 20 Dec 2023 at 02:54, Aiqun Yu (Maria) <quic_aiquny@quicinc=
.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 12/19/2023 6:21 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Tue, 19 Dec 2023 at 12:09, Aiqun Yu (Maria) <quic_aiquny@quici=
nc.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 12/19/2023 5:41 PM, Krzysztof Kozlowski wrote:
> >>>>>>>>> On 19/12/2023 10:36, Aiqun Yu (Maria) wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 12/19/2023 3:17 PM, Krzysztof Kozlowski wrote:
> >>>>>>>>>>> On 19/12/2023 01:31, Tengfei Fan wrote:
> >>>>>>>>>>>> The address/size-cells in mdss_dsi1 node have not ranges and=
 child also
> >>>>>>>>>>>> have not reg, then this leads to dtc W=3D1 warnings:
> >>>>>>>>>>>
> >>>>>>>>>> Comments can be more readable:
> >>>>>>>>>> "mdss_dsi1" node don't have "ranges" or child "reg" property, =
while it
> >>>>>>>>>> have address/size-cells properties. This caused
> >>>>>>>>>> "avoid_unnecessary_addr_size" warning from dtb check.
> >>>>>>>>>> Remove address/size-cells properties for "mdss_dsi1" node.
> >>>>>>>>>>
> >>>>>>>>>>> I cannot parse it. Address/size cells never have ranges or ch=
ildren.
> >>>>>>>>>>> They cannot have. These are uint32 properties.
> >>>>>>>>>> Pls help to comment on the revised commit message. Every time =
I write a
> >>>>>>>>>> commit message, also takes a while for me to double confirm wh=
ether
> >>>>>>>>>> others can understand me correctly as well. Feel free to let u=
s know if
> >>>>>>>>>> it is not readable to you. It will help us as non-English nati=
ve developers.
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>         sm8550.dtsi:2937.27-2992.6: Warning (avoid_unnecessa=
ry_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
> >>>>>>>>>>>>           unnecessary #address-cells/#size-cells without "ra=
nges" or child "reg" property
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>>>>>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>
> >>>>>>>>>>> I disagreed with the patch before. You resubmit it without re=
ally
> >>>>>>>>>>> addressing my concerns.
> >>>>>>>>>>>
> >>>>>>>>>>> I am not sure if this is correct fix and I want to fix all of=
 such
> >>>>>>>>>>> errors (there are multiple of them) in the same way. Feel fre=
e to
> >>>>>>>>>>> propose common solution based on arguments.
> >>>>>>>>>> Per my understanding, "qcom,mdss-dsi-ctrl" driver node like "m=
dss_dsi1"
> >>>>>>>>>> don't need to have address/size-cells properties.
> >>>>>>>>>
> >>>>>>>>> Just because dtc says so? And what about bindings?
> >>>>>>>> I don't find any reason why "qcom,mdss-dsi-ctrl" driver node nee=
d to
> >>>>>>>> have address/size-cells properties. Document Bindings should als=
o be fixed.
> >>>>>>>>>
> >>>>>>>>>> Feel free to let us know whether there is different idea of
> >>>>>>>>>> "address/size-cells" needed for the "qcom,mdss-dsi-ctrl" drive=
r node.
> >>>>>>>>>
> >>>>>>>>> The bindings expressed that idea. If the binding is incorrect, =
fix the
> >>>>>>>>> binding and the DTS. If the binding is correct, provide rationa=
le why it
> >>>>>>>>> somehow does not apply here etc.
> >>>>>>>> Our plan is to fix the bindings as well.
> >>>>>>>>
> >>>>>>>> In case you have missed the question, I just re-place it here:
> >>>>>>>> While there are about 22 different soc dtsi and it's document bi=
nding
> >>>>>>>> files needed to be fixed. Shall we fix it for all qcom related s=
oc usage
> >>>>>>>> in one patch, or we'd better to split into different patches acc=
ording
> >>>>>>>> to soc specifically?
> >>>>>>>
> >>>>>>> Don't touch the bindings unless you understand what you are doing=
.
> >>>>>>> Your patch will be NAKed. There can be a DSI panel attached to th=
e DSI
> >>>>>>> host, which means there is a need for #address-cells / #size-cell=
s.
> >>>>>>>
> >>>>>> Could you please help to elaborate more on details? Like what's th=
e
> >>>>>> right example here for the "qcom,mdss-dsi-ctrl" driver node needed=
 to
> >>>>>> have "#address-cells"/"#size-cells".
> >>>>>
> >>>>> As I wrote, the attached DSI panels make use of #address-cells / #s=
ize-cells.
> >>>>>
> >>>>> Please take a look at the sdm845-mtp.dts, which provides a complex
> >>>>> enough example (a panel which is attached to both DSI0 and DSI1
> >>>>> hosts).
> >>>> I can see the panel example now.
> >>>> While panel@0 likely node is not at in the binding that I've checked=
. There are quite a few of binding document about the same driver. I checke=
d 5 of the bindings document and moste of them are alike, and don't have th=
e panel example.:(
> >>>
> >>> There is a single bindings documents describing MSM DSI controller, d=
isplay/MSM/dsi-controller-main.yaml . It explicitly includes ../dsi-control=
ler.yaml, which describes generic DSI host controller. The latter one inclu=
des an example of the DSI panel. MSM DSI bindings do not have to include on=
e, there is nothing platform specific there.
> >>>
> >>>
> >>>>>
> >>>>>> Thx to chime in that we have put a good amount of time here.
> >>>>>
> >>>>> Can't quite catch you here.
> >>>>>
> >>>>>>> Please stop wasting the time on dtc warning. The bindings (and th=
e
> >>>>>>> file) are correct.
> >>>>>> I don't agree here.
> >>>>>> Either it is a wrong usage of "#address-cells"/"#size-cells", or d=
tc
> >>>>>> warning should be fixed with this usage take into account.
> >>>>>> "dtb check" will be a good guideline for developers to follow, I d=
on't
> >>>>>> think it is wasting time here.
> >>>>>
> >>>>> It is a guideline, but not a rule. No warnings by default is more o=
f
> >>>>> the rule. W=3D1 enables warnings that developers have to classify a=
nd
> >>>>> cope with.
> >>>>>
> >>>>> E.g. I don't think dtc correctly handles the case when there are bo=
th
> >>>>> with-address and no-address nodes (e.g. 'panel@0' and 'ports'). Not=
e,
> >>>>> I might be mistaken there.
> >>>> Now I understand the issue, here is some thinking from my end, and w=
elcome others to chime in with more ideas:
> >>>> 1. Only put "#address-cells" "#size-cells" right before node of pane=
l@0
> >>>
> >>> No. Cells specification is a property of the host/bus. As such they d=
o not belong to the board DT file.
> >> As "#address-cells" "#size-cells" is not marked as required properties
> >> in the Document dsi-controller.yaml. Did it really needed even
> >> "panel@[0-3]" is not present at current dsi node?
> >> That's good that comes to the initial discussion of current patch here=
. :)
> >
> > The #address-cells / #size-cells describe the addressing of the bus.
> > The bus still continues to exist even with no panel being attached.
> While even empty "panel@[0-3]" is not required to be written as long as
> there is no panel being attached. Although the bus do have such kind of
> 2 bits allocation.
> >
> >>
> >> I can understand that "#address-cells" "#size-cells" cannot be device
> >> tree overlayed by dtbo. While when there is no "panel@[0-3]" nodes sha=
ll
> >> we also remove "#address-cells" "#size-cells" properties for dsi node?
> >
> > But why?
> The reason is that "#address-cells" "#size-cells" are not marked as
> "required" properties in dsi-controller.yaml.
> Also referenced the other bindings which "$ref:dsi-controller.yaml",
> some of them also not have those 2 properties in dsi node.

And others (like ste,mcde.yaml or brcm,bcm2835-dsi0.yaml) explicitly
have #cells in the example.

>
> Take below 2 examples(there are more of cause):
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
Documentation/devicetree/bindings/display/amlogic,meson-g12a-dw-mipi-dsi.ya=
ml
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>
> >
> >>>
> >>>> 2. Align current binding document with "panel@0" examples.
> >>>
> >>> There is already a panel in dsi-controller.yaml. Adding another examp=
le is optional. Do you also need an example with the external DSI bridge?
> >> Current binding I am talking about is current patch binding file:
> >> qcom,sm8550-mdss.yaml
> >
> > Why do you call it a patch? Also if you have read the description, you
> > would have known that the bindings describe the Mobile Display
> > Subsystem (MDSS) itself. And then it explicitly tells that the MDSS on
> > that platform has (among others) DSI blocks with proper compatibles.
> >
> >> It have a ref to mdss-common.yaml,  but I cannot find the ref direct m=
e
> >> to dsi-controller.yaml.
> >
> > Because qcom,sm8550-mdss.yaml doesn't describe the DSI controller. I
> > think I have already mentioned a file that describes the DSI
> > controller, it is called display/msm/dsi-controller-main.yaml. Not the
> > best name, but it is quickly revealed by grepping for either of the
> > DSI compatible strings. And the dsi-controller-main.yaml has `  -
> > $ref: ../dsi-controller.yaml#` string inside.
> Let me try to describe this in a code way.
> "qcom,sm8550-mdss.yaml" binding document is confusing me when it also
> have same compatible string support in the binding.

Yes, it has. But there is a huge difference. The bindings file
describes and qcom,sm8550-mdss device and then enforces that DSI
controllers should be compatible with "qcom,sm8550-dsi-ctrl",
"qcom,mdss-dsi-ctrl". In the same way it also binds SoC-specific
compatible strings to all other subnodes.

> So I will suggest to
> directly reference the "dsi-controller-main.yaml" in file
> "qcom,sm8550-mdss.yaml" instead.
>
> For example:
>
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
>
> @@ -55,14 +50,7 @@ patternProperties:
>             - const: qcom,sm8350-dp
>
>     "^dsi@[0-9a-f]+$":
> -    type: object
> -    additionalProperties: true
> -
> -    properties:
> -      compatible:
> -        items:
> -          - const: qcom,sm8550-dsi-ctrl
> -          - const: qcom,mdss-dsi-ctrl
> +    $ref: ../dsi-controller-main.yaml#

Note, there is no ../dsi-controller-main.yaml, so you didn't check
your patch (despite my request to do so).
I can only hope that you meant `$ref: dsi-controller-main.yaml`
instead of `$ref: ../dsi-controller.yaml`.

>
> With above unified reference change, it will be easier for other
> developers to reference bindings files next time.
> Also dsi@[0-9a-f] node in mdss node will be correctly fully described.

If you cared to read mailing list discussions related to the
corresponding patches, you would have noticed that this approach was
considered and then abandoned.
Two main reasons:
- This causes dsi-controller-main.yaml schema to be evaluated twice
for each of the DSI controller nodes.
- This doesn't have the SoC binding. Thus with such schema it is
possible to have top-level qcom,sm8550-mdss and then
qcom,sdm845-dsi-ctrl beneath.

> >
> >> In my opinion if the example have "#address-cells" "#size-cells", then
> >> it's better to also include "panel@0" with "reg =3D <0>" to not confus=
e.
> >
> > It is already there, see dsi-controller.yaml.
> >
> >>>> 3. Too many bindings files for driver "qcom,mdss-dsi-ctrl", shall we=
 align them into 1 binding files.
> >>>
> >>> There is just one.
> >> Currently I mentioned bindings files was searched the compatible
> >> "qcom,mdss-dsi-ctrl", and find binding docs like "qcom,sm8550-mdss.yam=
l"
> >> "qcom,sm8450-mdss.yaml" etc.
> >> There is duplicate information on "qcom,sm8550-mdss.yaml" etc, while
> >> "qcom,mdss-common.yaml" is not common enough for my understanding.
> >
> > If you had compared the qcom,SOC-mdss.yaml, you would have seen that
> > they provide tight binding between compatible strings used for all the
> > subblocks. The `mdss-common.yaml` describes MDSS common properties. It
> > describes everything except the platform specifics. It can not be made
> > more common. And there is no duplication.
> >
> > If you think you can improve the bindings, please send the patches.
> I am thinking of a unified qcom,mdss.yaml instead of "qcom,*each
> SOC*-mdss.yaml". I will try to have a patch.

Please. Read the mailing list archives first.

> > They must pass the `make dt_binding_check` check.
> Thx for the remind.
> >
> >>>> 4. enhance the dtc warning check if we still want to have "#address-=
cells" "#size-cells" even if there is no "panel@0" attached.
> >>>
> >>> In my opinion this is a way to go, if any. Did you include devicetree=
@ ML and the corresponding maintainers into the discussion?
> >> Already included devicetree@ ML at the very beginning.
> >
> > Good, thanks for the confirmation.
> >
> >> If the required properties part in each yaml is marked good enough, I
> >> think it can be an input for avoid unnecessary dtc warnings.
> >
> > Patches are welcome.
> Improving developer efficiency with unnecessary warnings is one of my
> interest as well.
> First of all, I'd better to make sure "Required properties" attribute in
> current bindings are good enough. Let me try to get back on this in a
> separate discuss session.

Let me put some kind of a point here. Show us your code. Otherwise
it's just an endless discussion.

--=20
With best wishes
Dmitry

