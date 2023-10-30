Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E807DB5E4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjJ3JMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjJ3JMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:12:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64196DF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:12:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d224dca585so220810966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1698657136; x=1699261936; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOzvxojt5IkzpqEC6kgmrbNp7izwwxbXp+yu+D9sdwU=;
        b=r+COnjRVjsVaPVs3t2VmGwM9JcaxQmUquAaehCCG3y/Q2MNtYYfglNtAnzp5uOE7cP
         WHtgDezQZyORRRyp+YGdKZuUl71+C7SiBGLhv58uQq0PqTvSPEyLFhF+Y9ouYSXjq9/q
         8ACX1d1PpFATjAJ4TT6qxiTmIt6+X3JV3INp+Ck4LSy1RzVgnS1JtCK1OIxIGGqy+Blx
         sd9j5ZK9xhUZALqzaMTVQWcTDXSNu6b7/AguOm/ejV8VeEdqtPzy0gLCWO5btK0ktuzB
         6f+jTxQ5DcAKoD9Ds4UUzQ6EpEGd+zwvbPkMT8otXMfDr2p1kc4903Fcakkqp74M8J5r
         ysSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698657136; x=1699261936;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uOzvxojt5IkzpqEC6kgmrbNp7izwwxbXp+yu+D9sdwU=;
        b=ZI1Wcc/ciyaL3oLtCtDSN5LA4XIPHVjcGivnTm65rlDYb/f8lr1NIwenRaeCPK0nYT
         ZOHZr6e5gh7ywkBABlgZkGT0U/tuwDZyc9HED7a0Y94So8D/eCOoSjaw+Fhl8aJPLPP0
         nMZtUm9fooq4NwtbSvzhfoOglsA5OzT+x3T8CUaM1lJx8I7mppRGojbiSPdzJ3SSs+wT
         j1EXOf9YDzejV+MMuW6jaqd+qlv17O1QLi1EIpZbMiGk36k/2sHh/hIMEqu8oWv5Ffeh
         jai9WWBm/Hu4+caSpI350S4cSv8TZ3a2G9guut93XfS0NAomtg8qSrBds7hzMtreRQ72
         agpA==
X-Gm-Message-State: AOJu0YwxhBbLIH1/AbqFS8yQa9GBM+oYmc8KmtpMA0RJZS9sLE0BDXoo
        xRSX1IPZzOpbgmH03m37wp3l9g==
X-Google-Smtp-Source: AGHT+IEYCma+GOM6jY6YkxKwhHrk/iK/ziLsvGWwcdC/cvUPp8XZUvhRvI0SwFwRhd8Hweyrf/evGA==
X-Received: by 2002:a17:907:360a:b0:9c7:dc4e:1a22 with SMTP id bk10-20020a170907360a00b009c7dc4e1a22mr8483803ejc.48.1698657135700;
        Mon, 30 Oct 2023 02:12:15 -0700 (PDT)
Received: from localhost (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709067d8600b0099bcf1c07c6sm5660388ejo.138.2023.10.30.02.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 02:12:15 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 30 Oct 2023 10:12:14 +0100
Message-Id: <CWLNP6QNUXN1.SNVACF2IEGI8@fairphone.com>
Cc:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        =?utf-8?q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/9] arm64: dts: qcom: sc7280: Add CDSP node
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Mukesh Ojha" <quic_mojha@quicinc.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
X-Mailer: aerc 0.15.2
References: <20231027-sc7280-remoteprocs-v1-0-05ce95d9315a@fairphone.com>
 <20231027-sc7280-remoteprocs-v1-7-05ce95d9315a@fairphone.com>
 <7934a36a-9438-719a-2ed0-4a78757b044b@quicinc.com>
In-Reply-To: <7934a36a-9438-719a-2ed0-4a78757b044b@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 30, 2023 at 10:04 AM CET, Mukesh Ojha wrote:
>
>
> On 10/27/2023 7:50 PM, Luca Weiss wrote:
> > Add the node for the ADSP found on the SC7280 SoC, using standard
> > Qualcomm firmware.
> >=20
> > The memory region for sc7280-chrome-common.dtsi is taken from msm-5.4
> > yupik.dtsi since the other areas also seem to match that file there,
> > though I cannot be sure there.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> >   arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |   5 +
> >   arch/arm64/boot/dts/qcom/sc7280.dtsi               | 138 ++++++++++++=
+++++++++
> >   2 files changed, 143 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/=
arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > index eb55616e0892..6e5a9d4c1fda 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> > @@ -29,6 +29,11 @@ adsp_mem: memory@86700000 {
> >   			no-map;
> >   		};
> >  =20
> > +		cdsp_mem: memory@88f00000 {
> > +			reg =3D <0x0 0x88f00000 0x0 0x1e00000>;
> > +			no-map;
> > +		};
> > +
>
> Just a question, why to do it here, if chrome does not use this ?

Other memory regions in sc7280.dtsi also get referenced but not actually
defined in that file, like mpss_mem and wpss_mem. Alternatively we can
also try and solve this differently, but then we should probably also
adjust mpss and wpss to be consistent.

Apart from either declaring cdsp_mem in sc7280.dtsi or
"/delete-property/ memory-region;" for CDSP I don't really have better
ideas though.

I also imagine these ChromeOS devices will want to enable cdsp at some
point but I don't know any plans there.

Regards
Luca

>
> -Mukesh
>
> >   		camera_mem: memory@8ad00000 {
> >   			reg =3D <0x0 0x8ad00000 0x0 0x500000>;
> >   			no-map;
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts=
/qcom/sc7280.dtsi
> > index cc153f4e6979..e15646289bf7 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -3815,6 +3815,144 @@ nsp_noc: interconnect@a0c0000 {
> >   			qcom,bcm-voters =3D <&apps_bcm_voter>;
> >   		};
> >  =20
> > +		remoteproc_cdsp: remoteproc@a300000 {
> > +			compatible =3D "qcom,sc7280-cdsp-pas";
> > +			reg =3D <0 0x0a300000 0 0x10000>;
> > +
> > +			interrupts-extended =3D <&intc GIC_SPI 578 IRQ_TYPE_LEVEL_HIGH>,
> > +					      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> > +					      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> > +					      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> > +					      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
> > +					      <&cdsp_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
> > +			interrupt-names =3D "wdog", "fatal", "ready", "handover",
> > +					  "stop-ack", "shutdown-ack";
> > +
> > +			clocks =3D <&rpmhcc RPMH_CXO_CLK>;
> > +			clock-names =3D "xo";
> > +
> > +			power-domains =3D <&rpmhpd SC7280_CX>,
> > +					<&rpmhpd SC7280_MX>;
> > +			power-domain-names =3D "cx", "mx";
> > +
> > +			interconnects =3D <&nsp_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 =
0>;
> > +
> > +			memory-region =3D <&cdsp_mem>;
> > +
> > +			qcom,qmp =3D <&aoss_qmp>;
> > +
> > +			qcom,smem-states =3D <&cdsp_smp2p_out 0>;
> > +			qcom,smem-state-names =3D "stop";
> > +
> > +			status =3D "disabled";
> > +
> > +			glink-edge {
> > +				interrupts-extended =3D <&ipcc IPCC_CLIENT_CDSP
> > +							     IPCC_MPROC_SIGNAL_GLINK_QMP
> > +							     IRQ_TYPE_EDGE_RISING>;
> > +				mboxes =3D <&ipcc IPCC_CLIENT_CDSP
> > +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> > +
> > +				label =3D "cdsp";
> > +				qcom,remote-pid =3D <5>;
> > +
> > +				fastrpc {
> > +					compatible =3D "qcom,fastrpc";
> > +					qcom,glink-channels =3D "fastrpcglink-apps-dsp";
> > +					label =3D "cdsp";
> > +					qcom,non-secure-domain;
> > +					#address-cells =3D <1>;
> > +					#size-cells =3D <0>;
> > +
> > +					compute-cb@1 {
> > +						compatible =3D "qcom,fastrpc-compute-cb";
> > +						reg =3D <1>;
> > +						iommus =3D <&apps_smmu 0x11a1 0x0420>,
> > +							 <&apps_smmu 0x1181 0x0420>;
> > +					};
> > +
> > +					compute-cb@2 {
> > +						compatible =3D "qcom,fastrpc-compute-cb";
> > +						reg =3D <2>;
> > +						iommus =3D <&apps_smmu 0x11a2 0x0420>,
> > +							 <&apps_smmu 0x1182 0x0420>;
> > +					};
> > +
> > +					compute-cb@3 {
> > +						compatible =3D "qcom,fastrpc-compute-cb";
> > +						reg =3D <3>;
> > +						iommus =3D <&apps_smmu 0x11a3 0x0420>,
> > +							 <&apps_smmu 0x1183 0x0420>;
> > +					};
> > +
> > +					compute-cb@4 {
> > +						compatible =3D "qcom,fastrpc-compute-cb";
> > +						reg =3D <4>;
> > +						iommus =3D <&apps_smmu 0x11a4 0x0420>,
> > +							 <&apps_smmu 0x1184 0x0420>;
> > +					};
> > +
> > +					compute-cb@5 {
> > +						compatible =3D "qcom,fastrpc-compute-cb";
> > +						reg =3D <5>;
> > +						iommus =3D <&apps_smmu 0x11a5 0x0420>,
> > +							 <&apps_smmu 0x1185 0x0420>;
> > +					};
> > +
> > +					compute-cb@6 {
> > +						compatible =3D "qcom,fastrpc-compute-cb";
> > +						reg =3D <6>;
> > +						iommus =3D <&apps_smmu 0x11a6 0x0420>,
> > +							 <&apps_smmu 0x1186 0x0420>;
> > +					};
> > +
> > +					compute-cb@7 {
> > +						compatible =3D "qcom,fastrpc-compute-cb";
> > +						reg =3D <7>;
> > +						iommus =3D <&apps_smmu 0x11a7 0x0420>,
> > +							 <&apps_smmu 0x1187 0x0420>;
> > +					};
> > +
> > +					compute-cb@8 {
> > +						compatible =3D "qcom,fastrpc-compute-cb";
> > +						reg =3D <8>;
> > +						iommus =3D <&apps_smmu 0x11a8 0x0420>,
> > +							 <&apps_smmu 0x1188 0x0420>;
> > +					};
> > +
> > +					/* note: secure cb9 in downstream */
> > +
> > +					compute-cb@11 {
> > +						compatible =3D "qcom,fastrpc-compute-cb";
> > +						reg =3D <11>;
> > +						iommus =3D <&apps_smmu 0x11ab 0x0420>,
> > +							 <&apps_smmu 0x118b 0x0420>;
> > +					};
> > +
> > +					compute-cb@12 {
> > +						compatible =3D "qcom,fastrpc-compute-cb";
> > +						reg =3D <12>;
> > +						iommus =3D <&apps_smmu 0x11ac 0x0420>,
> > +							 <&apps_smmu 0x118c 0x0420>;
> > +					};
> > +
> > +					compute-cb@13 {
> > +						compatible =3D "qcom,fastrpc-compute-cb";
> > +						reg =3D <13>;
> > +						iommus =3D <&apps_smmu 0x11ad 0x0420>,
> > +							 <&apps_smmu 0x118d 0x0420>;
> > +					};
> > +
> > +					compute-cb@14 {
> > +						compatible =3D "qcom,fastrpc-compute-cb";
> > +						reg =3D <14>;
> > +						iommus =3D <&apps_smmu 0x11ae 0x0420>,
> > +							 <&apps_smmu 0x118e 0x0420>;
> > +					};
> > +				};
> > +			};
> > +		};
> > +
> >   		usb_1: usb@a6f8800 {
> >   			compatible =3D "qcom,sc7280-dwc3", "qcom,dwc3";
> >   			reg =3D <0 0x0a6f8800 0 0x400>;
> >=20

