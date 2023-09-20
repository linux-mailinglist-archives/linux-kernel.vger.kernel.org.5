Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438557A7A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjITLNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjITLNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:13:31 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EFDB4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:13:25 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59bc97d7b3dso10882037b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695208404; x=1695813204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Jwn7Ew5nILHx+5GR+NTRHmaRmX431keEmXsyqdl+cE=;
        b=N5ts5z/qcIAYAiiXCsKFQqSIhcp6iAXBz2ORgEsgZ+Z1HISeg5ffxxVQ2S/S0XfA2O
         DaEs+yMWTg9tVG7OuRB3EEG5FyjBux8fDL93Hv+3StZukOE1IZVYi6xrT9GVi4Hxgqtj
         Tsq4tEf82AkuZ1Y1cipgabwBgv6Cer/lNRduGlNWewZJWY88Wk1QQVud71NBuqlmmDu9
         OA+2k1+WTY1d7UgEmtNtAWGC15phWRC+alfiicl6snLV4YMSf3cCCO6GXJEupwwIri3l
         1/Q22dEaqAFm1Um2PmRz3R8ArWfflCoPnDyVMvPEtZrjdmF7vHCNG5KhXQJk4S7AnDcz
         lhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695208404; x=1695813204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Jwn7Ew5nILHx+5GR+NTRHmaRmX431keEmXsyqdl+cE=;
        b=KLHwckogOwy/b35g8CKiuFJQqVQXSKb9AsK3W77i/CzaJuSinnXzRSQ9qiELBhIbEA
         T6V0QiF9CTFrvNsobIMw30rx/TSE3Si0cveWtgC85+7L/ta7hZAuJ1LyPEFwb1b3GNNq
         n8u5TQVzrTDwco9Idx2LiRVGvgaMMBc1deuvnWt2eqzxinHrCNECRia3P+BX26tqpCcF
         Itol66nz9ThPwUmzMZUjdnirx3kUX0hpWPtuw9gXJTnT1TWcKD+TyPvQDLlwgM418iIU
         IvdXD/PNfi3CT4BwaMgVXiAZF2JQXped/zuo2DiBhdLRVdURZVbeLSA3lfRXrSiUjMK8
         n4tw==
X-Gm-Message-State: AOJu0YwtSaUm/aUSaWu/1GvkN+b5RPPyVEPvHXG2QLD4ocaTqp5DM3Hg
        7C8SHPgBIUYqZGYxBC451z9ubj/n2Y687onSQZfFsg==
X-Google-Smtp-Source: AGHT+IHFsk9NaAteTvH3BmgCmk5ASoDueVueBNUnIXp+GgAzs2/Sm1uxwVIu+WcbtMUf2HUohWdEYcPhj4wbxzyvucw=
X-Received: by 2002:a81:9115:0:b0:56d:4d1e:74ab with SMTP id
 i21-20020a819115000000b0056d4d1e74abmr5958371ywg.23.1695208404698; Wed, 20
 Sep 2023 04:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-3-git-send-email-quic_cang@quicinc.com> <6055cd57-4de7-4b7e-a4f3-68a7de1aef28@linaro.org>
 <6225a132-4b7f-bbb4-e863-4e62b99dd79d@quicinc.com> <31823dc4-6f50-435b-9a20-66471209ec31@linaro.org>
 <d34242f8-6e21-1549-b87d-3db2e825b7d5@quicinc.com> <1413119B-8B9C-4DE4-A086-476B2BAA60AD@linaro.org>
 <20230919120829.GB4732@thinkpad> <CAA8EJppwjzNDsPHZqUdmgQy3fAbP+AFnOo4+FTDCdpBEZp5S_w@mail.gmail.com>
 <20230920102327.GH4732@thinkpad>
In-Reply-To: <20230920102327.GH4732@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 20 Sep 2023 14:13:13 +0300
Message-ID: <CAA8EJprSVv0E7w7LQoN=Ar+tducP_7dDS8SF_k_BBi6cJDos5A@mail.gmail.com>
Subject: Re: [PATCH 2/6] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Can Guo <quic_cang@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sept 2023 at 13:23, Manivannan Sadhasivam <mani@kernel.org> wrot=
e:
>
> On Wed, Sep 20, 2023 at 01:27:59AM +0300, Dmitry Baryshkov wrote:
> > On Tue, 19 Sept 2023 at 15:08, Manivannan Sadhasivam <mani@kernel.org> =
wrote:
> > >
> > > On Fri, Sep 15, 2023 at 05:31:45AM +0300, Dmitry Baryshkov wrote:
> > > > On 11 September 2023 13:02:50 GMT+03:00, Can Guo <quic_cang@quicinc=
.com> wrote:
> > > > >
> > > > >On 9/11/2023 5:46 PM, Konrad Dybcio wrote:
> > > > >> On 11.09.2023 11:42, Can Guo wrote:
> > > > >>> Hi Konrad,
> > > > >>>
> > > > >>> On 9/11/2023 5:17 PM, Konrad Dybcio wrote:
> > > > >>>> On 11.09.2023 07:59, Can Guo wrote:
> > > > >>>>> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
> > > > >>>>>
> > > > >>>>> Retrieve UFS device version from UFS host controller's spare =
register
> > > > >>>>> which is populated by bootloader, and use the UFS device vers=
ion together
> > > > >>>>> with host controller's HW version to decide the proper power =
modes which
> > > > >>>>> should be used to configure the UFS PHY.
> > > > >>>> That sounds a bit fishy.. is there no bootloader-independent
> > > > >>>> solution to that? Can't we bring in the code that the bootload=
er
> > > > >>>> uses to determine these values?
> > > > >>>>
> > > > >>>> Konrad
> > > > >>>
> > > > >>> Agree, it is.
> > > > >>>
> > > > >>>
> > > > >>> All these complexities come from one request from PHY design te=
am - power saving.
> > > > >>>
> > > > >>> And to achieve power saving, Qualcomm UFS developers are reques=
ted to use the
> > > > >>>
> > > > >>> lowest hanging PHY settings which can sustain the Max agreed HS=
 Gear (btw host
> > > > >>>
> > > > >>> and UFS device) during UFS's lifecycle in High Level OS,  where=
as the power saving
> > > > >>>
> > > > >>> request does not apply to bootloader, which works for only a fe=
w seconds during
> > > > >>>
> > > > >>> bootup. Hence, there is no such version detect code in bootload=
er -  it just uses the
> > > > >>>
> > > > >>> highest PHY settings to configure PHY, boot up UFS and put UFS =
device version in this
> > > > >>>
> > > > >>> register.
> > > > >> First of all, your email client seems to be inserting 2 newlines
> > > > >> instead of 1. If you're using thunderbird, you may want to edit:
> > > > >>
> > > > >> mail.identity.(default or your mail identity idx).default.compos=
e_html
> > > > >>
> > > > >> to `false`
> > > > >>
> > > > >> and add that to your internal wiki page, as I see many @quic fol=
ks having
> > > > >> this issue.
> > > > >>
> > > > >>
> > > > >> Going back to the main topic, I don't think we understood each o=
ther.
> > > > >> The commit message states:
> > > > >>
> > > > >>
> > > > >> "Retrieve UFS device version from UFS host controller's spare re=
gister
> > > > >> which is populated by bootloader"
> > > > >>
> > > > >>
> > > > >> Which means the bootloader is able to somehow determine the valu=
e
> > > > >> that's in the spare register and write it there.
> > > > >>
> > > > >> I'm asking whether we can take the logic behind this value and
> > > > >> move it to Linux so that we don't depend on the bootloader to
> > > > >> guarantee it (e.g. Chrome or some other devices with more exotic
> > > > >> fw may not work this way).
> > > > >>
> > > > >>
> > > > >> Konrad
> > > > >
> > > > >
> > > > >There is no logic behind this value at all in bootloader, as I exp=
lained, after bootloader
> > > > >
> > > > >initializes UFS, bootloader simply reads UFS's device version (the=
 value you are referring)
> > > > >
> > > > >and write it to the register. But in Linux kernel, we need (or wan=
t to know) this value
> > > > >
> > > > >BEFORE we initialize UFS host controller (and UFS device).
> > > >
> > > > Depending on the bootloader behaviour is not an option. For example=
 the kernel might be started via kexec. Or via u-boot. Or grub. Or any othe=
r bootloader. So please duplicate the logic to read the UFS version instead=
.
> > > >
> > >
> > > As Can said, there is no logic in the bootloader. What it does it, af=
ter doing
> > > the UFS initialization, it writes the agreed gear (between host and t=
he device)
> > > to this register. And in linux, we use that value to initialize the d=
evice
> > > (i.e., not doing init based on the min gear).
> > >
> > > But the important factor here is that, we use this gear value to prog=
ram the PHY
> > > init sequence. So if there is no hint from the bootloader, linux will=
 program
> > > the min phy sequence (G3/G4) and then once the gear scaling happens, =
it will
> > > program the max phy sequence (G4/G5).
> > >
> > > Now on recent platforms, the init sequences are not compatible with e=
ach other
> > > i.e., once the min seq. is programmed, then before programming max se=
q. the
> > > registers not common to both seq. should be programmed to default val=
ue. In
> > > other words, min seq. specific registers should be reset to the defau=
lt value.
> > > Otherwise, there will be stability issues in the PHY.
> >
> > I see nothing wrong with adding 'default' register programming to the
> > gear tables. If we have to reset them to the default values to switch
> > the PHY settings, these writes must be a part of the corresponding
> > tables.
> >
>
> Yep, that's what I initially proposed. But Qcom wanted to avoid the cost =
of
> programming the reset tables in the PHY driver.

We should not be programming the whole reset table. Only those several
registers that are changed in the lowest settings.

>
> Can, could you please check if programming the additional sequence doesn'=
t cause
> any power/performance effect?
>
> - Mani
>
> > >
> > > So to avoid that, if we get the hint from bootloader (always the max =
supported
> > > gear between host and device), then only one seq. will be programmed.
> > >
> > > Other way to solve this issue is to reset the non common registers in=
 the init
> > > seq. to default value. But that will be an additional overhead.
> > >
> > > But... if the bootloader doesn't populate this register (if the boot =
device is
> > > not UFS, like in compute platforms), then this whole logic won't work=
. This
> > > should also be taken into consideration.
> >
> > Yep, that's the dependency on the bootloader. Which we should avoid.
> >
> > >
> > > - Mani
> > >
> > > >
> > > > P.S. you have been asked to fix your email client. Please do so. Or=
, if you are inserting these linebreaks manually, please stop.
> > > >
> > > > >Thanks,
> > > > >
> > > > >Can Guo.
> > > > >
> > > >
> > >
> > > --
> > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D
> >
> >
> >
> > --
> > With best wishes
> > Dmitry
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D



--=20
With best wishes
Dmitry
