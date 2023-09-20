Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D437A7B63
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjITLvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbjITLvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:51:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194ECA3;
        Wed, 20 Sep 2023 04:51:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so898337566b.1;
        Wed, 20 Sep 2023 04:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695210685; x=1695815485; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D7Lc5pDZwdEEWGjLjRcSEJ72Haq5Na/9aGx6AKo4Ork=;
        b=fBCAO+v/VouBXyOQo9bY6NnnMU6F20hqNhpy80gMbKKONnyObsgKKZ5aeffSX+93gM
         esTJpR4zWFzHzpxJ3C6bOz8KCUzCTJTnjoqPLwbl3vSBBNbIfEJtSxMHOSh6Ed5ipN9u
         Mb1E7IerQ+zv+ry13JTpYA1uoCy7HNaUAbwAsfMJnGDlG5tiD50w0BSam8tl9NP0uRmR
         cCqfsQyJ2wDgAIc5ObRvY9K+fz8BiZafe7emW7dk3gpU/x07QdDaBIpe4WT854q7XHIi
         mmzmOI8FA8jIrXkz+QmaEuJ7FG4m+o0iWfD/ZQapHwLCXB9kKgc5/UkFxRpj7iTaRXCG
         Fc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695210685; x=1695815485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7Lc5pDZwdEEWGjLjRcSEJ72Haq5Na/9aGx6AKo4Ork=;
        b=SR7AYljr97k0Cz+wE10QDg3gHF2lIWCKItxFtziHhoAiRGxlsnAZaGRpaAf8czPS1H
         zmWlGFGyfNDxyxOR8Dc9ghulTCRIvV6oELOFRHOIVkcgOcj7ahdFQKroBdCXK958uMoJ
         nGp/eZIjR5TDJneGPTfPiFbqURhTm0g9wPMChMKn68pcbyxbm04nDCn+NizAda9UxAqi
         H9UF76rESe/W9xbt91zfWawfTc93T0ZUOOzMlS8lR2Oclz+EhRsyQNggfsw7BwvMjKtX
         EoUWACKwh5/ozpIqnrFDUZY9IQrEgVL7gb2WnZeh8LAn2DcBvtnF9jcabJWHX5WTSsU4
         XOoA==
X-Gm-Message-State: AOJu0YwijjEUiXopLlc9vl6kCUy87X03+eXSXQQVKveM0U5ImTs+OiBV
        LgvqllhxTaIRqb8pF0GDkFuCsqH2nTTqHQ==
X-Google-Smtp-Source: AGHT+IF7hndeAryqIE7OWyh8kHSVv0X0F8me80j6AlZwVz1OOoWscHLIPGC4CXY7PocbuPVc7HOQTQ==
X-Received: by 2002:a17:906:109e:b0:994:4095:3abf with SMTP id u30-20020a170906109e00b0099440953abfmr1812165eju.14.1695210684931;
        Wed, 20 Sep 2023 04:51:24 -0700 (PDT)
Received: from thinkpad (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id z10-20020a170906714a00b00991e2b5a27dsm9078736ejj.37.2023.09.20.04.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 04:51:24 -0700 (PDT)
Date:   Wed, 20 Sep 2023 13:51:23 +0200
From:   Manivannan Sadhasivam <manisadhasivam.linux@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Can Guo <quic_cang@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        quic_nguyenb@quicinc.com, quic_nitirawa@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] scsi: ufs: ufs-qcom: Add support for UFS device
 version detection
Message-ID: <20230920115123.GA19004@thinkpad>
References: <1694411968-14413-3-git-send-email-quic_cang@quicinc.com>
 <6055cd57-4de7-4b7e-a4f3-68a7de1aef28@linaro.org>
 <6225a132-4b7f-bbb4-e863-4e62b99dd79d@quicinc.com>
 <31823dc4-6f50-435b-9a20-66471209ec31@linaro.org>
 <d34242f8-6e21-1549-b87d-3db2e825b7d5@quicinc.com>
 <1413119B-8B9C-4DE4-A086-476B2BAA60AD@linaro.org>
 <20230919120829.GB4732@thinkpad>
 <CAA8EJppwjzNDsPHZqUdmgQy3fAbP+AFnOo4+FTDCdpBEZp5S_w@mail.gmail.com>
 <20230920102327.GH4732@thinkpad>
 <CAA8EJprSVv0E7w7LQoN=Ar+tducP_7dDS8SF_k_BBi6cJDos5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJprSVv0E7w7LQoN=Ar+tducP_7dDS8SF_k_BBi6cJDos5A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:13:13PM +0300, Dmitry Baryshkov wrote:
> On Wed, 20 Sept 2023 at 13:23, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Wed, Sep 20, 2023 at 01:27:59AM +0300, Dmitry Baryshkov wrote:
> > > On Tue, 19 Sept 2023 at 15:08, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > >
> > > > On Fri, Sep 15, 2023 at 05:31:45AM +0300, Dmitry Baryshkov wrote:
> > > > > On 11 September 2023 13:02:50 GMT+03:00, Can Guo <quic_cang@quicinc.com> wrote:
> > > > > >
> > > > > >On 9/11/2023 5:46 PM, Konrad Dybcio wrote:
> > > > > >> On 11.09.2023 11:42, Can Guo wrote:
> > > > > >>> Hi Konrad,
> > > > > >>>
> > > > > >>> On 9/11/2023 5:17 PM, Konrad Dybcio wrote:
> > > > > >>>> On 11.09.2023 07:59, Can Guo wrote:
> > > > > >>>>> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
> > > > > >>>>>
> > > > > >>>>> Retrieve UFS device version from UFS host controller's spare register
> > > > > >>>>> which is populated by bootloader, and use the UFS device version together
> > > > > >>>>> with host controller's HW version to decide the proper power modes which
> > > > > >>>>> should be used to configure the UFS PHY.
> > > > > >>>> That sounds a bit fishy.. is there no bootloader-independent
> > > > > >>>> solution to that? Can't we bring in the code that the bootloader
> > > > > >>>> uses to determine these values?
> > > > > >>>>
> > > > > >>>> Konrad
> > > > > >>>
> > > > > >>> Agree, it is.
> > > > > >>>
> > > > > >>>
> > > > > >>> All these complexities come from one request from PHY design team - power saving.
> > > > > >>>
> > > > > >>> And to achieve power saving, Qualcomm UFS developers are requested to use the
> > > > > >>>
> > > > > >>> lowest hanging PHY settings which can sustain the Max agreed HS Gear (btw host
> > > > > >>>
> > > > > >>> and UFS device) during UFS's lifecycle in High Level OS,  whereas the power saving
> > > > > >>>
> > > > > >>> request does not apply to bootloader, which works for only a few seconds during
> > > > > >>>
> > > > > >>> bootup. Hence, there is no such version detect code in bootloader -  it just uses the
> > > > > >>>
> > > > > >>> highest PHY settings to configure PHY, boot up UFS and put UFS device version in this
> > > > > >>>
> > > > > >>> register.
> > > > > >> First of all, your email client seems to be inserting 2 newlines
> > > > > >> instead of 1. If you're using thunderbird, you may want to edit:
> > > > > >>
> > > > > >> mail.identity.(default or your mail identity idx).default.compose_html
> > > > > >>
> > > > > >> to `false`
> > > > > >>
> > > > > >> and add that to your internal wiki page, as I see many @quic folks having
> > > > > >> this issue.
> > > > > >>
> > > > > >>
> > > > > >> Going back to the main topic, I don't think we understood each other.
> > > > > >> The commit message states:
> > > > > >>
> > > > > >>
> > > > > >> "Retrieve UFS device version from UFS host controller's spare register
> > > > > >> which is populated by bootloader"
> > > > > >>
> > > > > >>
> > > > > >> Which means the bootloader is able to somehow determine the value
> > > > > >> that's in the spare register and write it there.
> > > > > >>
> > > > > >> I'm asking whether we can take the logic behind this value and
> > > > > >> move it to Linux so that we don't depend on the bootloader to
> > > > > >> guarantee it (e.g. Chrome or some other devices with more exotic
> > > > > >> fw may not work this way).
> > > > > >>
> > > > > >>
> > > > > >> Konrad
> > > > > >
> > > > > >
> > > > > >There is no logic behind this value at all in bootloader, as I explained, after bootloader
> > > > > >
> > > > > >initializes UFS, bootloader simply reads UFS's device version (the value you are referring)
> > > > > >
> > > > > >and write it to the register. But in Linux kernel, we need (or want to know) this value
> > > > > >
> > > > > >BEFORE we initialize UFS host controller (and UFS device).
> > > > >
> > > > > Depending on the bootloader behaviour is not an option. For example the kernel might be started via kexec. Or via u-boot. Or grub. Or any other bootloader. So please duplicate the logic to read the UFS version instead.
> > > > >
> > > >
> > > > As Can said, there is no logic in the bootloader. What it does it, after doing
> > > > the UFS initialization, it writes the agreed gear (between host and the device)
> > > > to this register. And in linux, we use that value to initialize the device
> > > > (i.e., not doing init based on the min gear).
> > > >
> > > > But the important factor here is that, we use this gear value to program the PHY
> > > > init sequence. So if there is no hint from the bootloader, linux will program
> > > > the min phy sequence (G3/G4) and then once the gear scaling happens, it will
> > > > program the max phy sequence (G4/G5).
> > > >
> > > > Now on recent platforms, the init sequences are not compatible with each other
> > > > i.e., once the min seq. is programmed, then before programming max seq. the
> > > > registers not common to both seq. should be programmed to default value. In
> > > > other words, min seq. specific registers should be reset to the default value.
> > > > Otherwise, there will be stability issues in the PHY.
> > >
> > > I see nothing wrong with adding 'default' register programming to the
> > > gear tables. If we have to reset them to the default values to switch
> > > the PHY settings, these writes must be a part of the corresponding
> > > tables.
> > >
> >
> > Yep, that's what I initially proposed. But Qcom wanted to avoid the cost of
> > programming the reset tables in the PHY driver.
> 
> We should not be programming the whole reset table. Only those several
> registers that are changed in the lowest settings.
> 

I was referring to "several registers" as the reset table. I should've been more
clear.

- Mani

> >
> > Can, could you please check if programming the additional sequence doesn't cause
> > any power/performance effect?
> >
> > - Mani
> >
> > > >
> > > > So to avoid that, if we get the hint from bootloader (always the max supported
> > > > gear between host and device), then only one seq. will be programmed.
> > > >
> > > > Other way to solve this issue is to reset the non common registers in the init
> > > > seq. to default value. But that will be an additional overhead.
> > > >
> > > > But... if the bootloader doesn't populate this register (if the boot device is
> > > > not UFS, like in compute platforms), then this whole logic won't work. This
> > > > should also be taken into consideration.
> > >
> > > Yep, that's the dependency on the bootloader. Which we should avoid.
> > >
> > > >
> > > > - Mani
> > > >
> > > > >
> > > > > P.S. you have been asked to fix your email client. Please do so. Or, if you are inserting these linebreaks manually, please stop.
> > > > >
> > > > > >Thanks,
> > > > > >
> > > > > >Can Guo.
> > > > > >
> > > > >
> > > >
> > > > --
> > > > மணிவண்ணன் சதாசிவம்
> > >
> > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
> >
> > --
> > மணிவண்ணன் சதாசிவம்
> 
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்
