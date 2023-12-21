Return-Path: <linux-kernel+bounces-7911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F7381AF01
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8C81F24C13
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410AF13FF4;
	Thu, 21 Dec 2023 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2CGQMti"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB7C143
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e7d306ee27so4913927b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703141977; x=1703746777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5qjfhA6k6Ypy5X9ehKiyPOQQXjASHEE/ZIK1E7N2ew=;
        b=P2CGQMti4MKDnyuvyP3VOw6ryj8I+bTfyxxz8qCgu/C2aWMccGTmHsMRjcDetOUA1f
         tlo3pgqPwH4AOTDP3aW2VoZZ3gUuARh8nl1DLVIQ2rpsKU5AKfhWM5Js7SeyHIVWG6cc
         S+IRGu3HxScjkNH63IN4lG0h6A//tBBbweNNHeG8VFVtI7sEGVf3ZWpVyW/S3Rs0bTfk
         ieqwdOcs8ja4rD85Chsco2xqWvCx3nQoeU6At7+W55OZuXbMRVlk22XmJ4Wd0kR+nqfT
         +zQG1OY1QbPYIm9CgbZDOu9cHXFbukqHAjn5KtFuLW5Rtjvfis8NacxIUyhtPYRn+bWJ
         c5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703141977; x=1703746777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5qjfhA6k6Ypy5X9ehKiyPOQQXjASHEE/ZIK1E7N2ew=;
        b=Hik0EdZUxcPnmUUMyknIMBT6sv3ADTt3iCOyPWKwtsadEDY/5+XNGL/ZZqLAUl3ZVt
         but7CsihBs7hBSrLPQr0eTDLHzGTMM61BUYsUv4dI9pAFqGgDUYz65tJGYK7WdiAaWqz
         Kc3Yvpb/Zs7I9webA4QeF9BrvfDH+4cLBYeopBvnTZGEmocHxJnLfYFOX++KZeTNL610
         DY7/e+I71dUWRIdOpNOTOplpCGi4ivxdo/RPSfLDKmHY4GROhhV1LnuVXyOrCDijNGDx
         rwqE5CA9Br9nPRcM2rQUOaALWaOCVSQ8w80McDBSCmRljbNJHeZF9ih27SOZXJo0RrO2
         ZTNg==
X-Gm-Message-State: AOJu0YxFVUhrDzdtHooozLw8wYFyowKbkokva3nWgRJqH/+DM+OCgZPK
	hOSw9F98Xubx4SeHca5aVOI9ConV0djNnBXx4ABAaw==
X-Google-Smtp-Source: AGHT+IFqFiB3IB7LrK51HWjhrRIYQJgjOnrJYmn8pNi0p8qjjT6T3gvmXs3CRS7GmIAp4IPo1O/4VsuGKfWlPqXV92M=
X-Received: by 2002:a0d:ff47:0:b0:5d7:1940:7d63 with SMTP id
 p68-20020a0dff47000000b005d719407d63mr928434ywf.58.1703141976999; Wed, 20 Dec
 2023 22:59:36 -0800 (PST)
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
 <4e328cd8-9ef7-42ce-b592-7f2216c00c0b@quicinc.com>
In-Reply-To: <4e328cd8-9ef7-42ce-b592-7f2216c00c0b@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Dec 2023 08:59:25 +0200
Message-ID: <CAA8EJprE8v3bhHfyZJM9SJT=ShJ-LQvk5mR=gpdAWXF2yANWbQ@mail.gmail.com>
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

On Thu, 21 Dec 2023 at 03:57, Aiqun Yu (Maria) <quic_aiquny@quicinc.com> wr=
ote:
>
>
>
> On 12/20/2023 7:10 PM, Dmitry Baryshkov wrote:
> > On 20 December 2023 12:33:07 EET, "Aiqun Yu (Maria)" <quic_aiquny@quici=
nc.com> wrote:
> >>
> >>
> >> On 12/20/2023 3:06 PM, Dmitry Baryshkov wrote:
> >>> On Wed, 20 Dec 2023 at 02:54, Aiqun Yu (Maria) <quic_aiquny@quicinc.c=
om> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 12/19/2023 6:21 PM, Dmitry Baryshkov wrote:
> >>>>> On Tue, 19 Dec 2023 at 12:09, Aiqun Yu (Maria) <quic_aiquny@quicinc=
.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 12/19/2023 5:41 PM, Krzysztof Kozlowski wrote:
> >>>>>>> On 19/12/2023 10:36, Aiqun Yu (Maria) wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 12/19/2023 3:17 PM, Krzysztof Kozlowski wrote:
> >>>>>>>>> On 19/12/2023 01:31, Tengfei Fan wrote:
> >>>>>>>>>> The address/size-cells in mdss_dsi1 node have not ranges and c=
hild also
> >>>>>>>>>> have not reg, then this leads to dtc W=3D1 warnings:
> >>>>>>>>>
> >>>>>>>> Comments can be more readable:
> >>>>>>>> "mdss_dsi1" node don't have "ranges" or child "reg" property, wh=
ile it
> >>>>>>>> have address/size-cells properties. This caused
> >>>>>>>> "avoid_unnecessary_addr_size" warning from dtb check.
> >>>>>>>> Remove address/size-cells properties for "mdss_dsi1" node.
> >>>>>>>>
> >>>>>>>>> I cannot parse it. Address/size cells never have ranges or chil=
dren.
> >>>>>>>>> They cannot have. These are uint32 properties.
> >>>>>>>> Pls help to comment on the revised commit message. Every time I =
write a
> >>>>>>>> commit message, also takes a while for me to double confirm whet=
her
> >>>>>>>> others can understand me correctly as well. Feel free to let us =
know if
> >>>>>>>> it is not readable to you. It will help us as non-English native=
 developers.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>        sm8550.dtsi:2937.27-2992.6: Warning (avoid_unnecessary_=
addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
> >>>>>>>>>>          unnecessary #address-cells/#size-cells without "range=
s" or child "reg" property
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>>>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> >>>>>>>>>> ---
> >>>>>>>>>
> >>>>>>>>> I disagreed with the patch before. You resubmit it without real=
ly
> >>>>>>>>> addressing my concerns.
> >>>>>>>>>
> >>>>>>>>> I am not sure if this is correct fix and I want to fix all of s=
uch
> >>>>>>>>> errors (there are multiple of them) in the same way. Feel free =
to
> >>>>>>>>> propose common solution based on arguments.
> >>>>>>>> Per my understanding, "qcom,mdss-dsi-ctrl" driver node like "mds=
s_dsi1"
> >>>>>>>> don't need to have address/size-cells properties.
> >>>>>>>
> >>>>>>> Just because dtc says so? And what about bindings?
> >>>>>> I don't find any reason why "qcom,mdss-dsi-ctrl" driver node need =
to
> >>>>>> have address/size-cells properties. Document Bindings should also =
be fixed.
> >>>>>>>
> >>>>>>>> Feel free to let us know whether there is different idea of
> >>>>>>>> "address/size-cells" needed for the "qcom,mdss-dsi-ctrl" driver =
node.
> >>>>>>>
> >>>>>>> The bindings expressed that idea. If the binding is incorrect, fi=
x the
> >>>>>>> binding and the DTS. If the binding is correct, provide rationale=
 why it
> >>>>>>> somehow does not apply here etc.
> >>>>>> Our plan is to fix the bindings as well.
> >>>>>>
> >>>>>> In case you have missed the question, I just re-place it here:
> >>>>>> While there are about 22 different soc dtsi and it's document bind=
ing
> >>>>>> files needed to be fixed. Shall we fix it for all qcom related soc=
 usage
> >>>>>> in one patch, or we'd better to split into different patches accor=
ding
> >>>>>> to soc specifically?
> >>>>>
> >>>>> Don't touch the bindings unless you understand what you are doing.
> >>>>> Your patch will be NAKed. There can be a DSI panel attached to the =
DSI
> >>>>> host, which means there is a need for #address-cells / #size-cells.
> >>>>>
> >>>> Could you please help to elaborate more on details? Like what's the
> >>>> right example here for the "qcom,mdss-dsi-ctrl" driver node needed t=
o
> >>>> have "#address-cells"/"#size-cells".
> >>>
> >>> As I wrote, the attached DSI panels make use of #address-cells / #siz=
e-cells.
> >>>
> >>> Please take a look at the sdm845-mtp.dts, which provides a complex
> >>> enough example (a panel which is attached to both DSI0 and DSI1
> >>> hosts).
> >> I can see the panel example now.
> >> While panel@0 likely node is not at in the binding that I've checked. =
There are quite a few of binding document about the same driver. I checked =
5 of the bindings document and moste of them are alike, and don't have the =
panel example.:(
> >
> > There is a single bindings documents describing MSM DSI controller, dis=
play/MSM/dsi-controller-main.yaml . It explicitly includes ../dsi-controlle=
r.yaml, which describes generic DSI host controller. The latter one include=
s an example of the DSI panel. MSM DSI bindings do not have to include one,=
 there is nothing platform specific there.
> >
> >
> >>>
> >>>> Thx to chime in that we have put a good amount of time here.
> >>>
> >>> Can't quite catch you here.
> >>>
> >>>>> Please stop wasting the time on dtc warning. The bindings (and the
> >>>>> file) are correct.
> >>>> I don't agree here.
> >>>> Either it is a wrong usage of "#address-cells"/"#size-cells", or dtc
> >>>> warning should be fixed with this usage take into account.
> >>>> "dtb check" will be a good guideline for developers to follow, I don=
't
> >>>> think it is wasting time here.
> >>>
> >>> It is a guideline, but not a rule. No warnings by default is more of
> >>> the rule. W=3D1 enables warnings that developers have to classify and
> >>> cope with.
> >>>
> >>> E.g. I don't think dtc correctly handles the case when there are both
> >>> with-address and no-address nodes (e.g. 'panel@0' and 'ports'). Note,
> >>> I might be mistaken there.
> >> Now I understand the issue, here is some thinking from my end, and wel=
come others to chime in with more ideas:
> >> 1. Only put "#address-cells" "#size-cells" right before node of panel@=
0
> >
> > No. Cells specification is a property of the host/bus. As such they do =
not belong to the board DT file.
> As "#address-cells" "#size-cells" is not marked as required properties
> in the Document dsi-controller.yaml. Did it really needed even
> "panel@[0-3]" is not present at current dsi node?
> That's good that comes to the initial discussion of current patch here. :=
)

The #address-cells / #size-cells describe the addressing of the bus.
The bus still continues to exist even with no panel being attached.

>
> I can understand that "#address-cells" "#size-cells" cannot be device
> tree overlayed by dtbo. While when there is no "panel@[0-3]" nodes shall
> we also remove "#address-cells" "#size-cells" properties for dsi node?

But why?

> >
> >> 2. Align current binding document with "panel@0" examples.
> >
> > There is already a panel in dsi-controller.yaml. Adding another example=
 is optional. Do you also need an example with the external DSI bridge?
> Current binding I am talking about is current patch binding file:
> qcom,sm8550-mdss.yaml

Why do you call it a patch? Also if you have read the description, you
would have known that the bindings describe the Mobile Display
Subsystem (MDSS) itself. And then it explicitly tells that the MDSS on
that platform has (among others) DSI blocks with proper compatibles.

> It have a ref to mdss-common.yaml,  but I cannot find the ref direct me
> to dsi-controller.yaml.

Because qcom,sm8550-mdss.yaml doesn't describe the DSI controller. I
think I have already mentioned a file that describes the DSI
controller, it is called display/msm/dsi-controller-main.yaml. Not the
best name, but it is quickly revealed by grepping for either of the
DSI compatible strings. And the dsi-controller-main.yaml has `  -
$ref: ../dsi-controller.yaml#` string inside.

> In my opinion if the example have "#address-cells" "#size-cells", then
> it's better to also include "panel@0" with "reg =3D <0>" to not confuse.

It is already there, see dsi-controller.yaml.

> >> 3. Too many bindings files for driver "qcom,mdss-dsi-ctrl", shall we a=
lign them into 1 binding files.
> >
> > There is just one.
> Currently I mentioned bindings files was searched the compatible
> "qcom,mdss-dsi-ctrl", and find binding docs like "qcom,sm8550-mdss.yaml"
> "qcom,sm8450-mdss.yaml" etc.
> There is duplicate information on "qcom,sm8550-mdss.yaml" etc, while
> "qcom,mdss-common.yaml" is not common enough for my understanding.

If you had compared the qcom,SOC-mdss.yaml, you would have seen that
they provide tight binding between compatible strings used for all the
subblocks. The `mdss-common.yaml` describes MDSS common properties. It
describes everything except the platform specifics. It can not be made
more common. And there is no duplication.

If you think you can improve the bindings, please send the patches.
They must pass the `make dt_binding_check` check.

> >> 4. enhance the dtc warning check if we still want to have "#address-ce=
lls" "#size-cells" even if there is no "panel@0" attached.
> >
> > In my opinion this is a way to go, if any. Did you include devicetree@ =
ML and the corresponding maintainers into the discussion?
> Already included devicetree@ ML at the very beginning.

Good, thanks for the confirmation.

> If the required properties part in each yaml is marked good enough, I
> think it can be an input for avoid unnecessary dtc warnings.

Patches are welcome.

> >
> >>
> >> @krzy here I try to answer your comments here as well.
> >> I am disagree on leave the warning as it is. And want to do something =
to improve this. Ideas above.
> >> Let me know if any comments is not right addressed from your comments.

--=20
With best wishes
Dmitry

