Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC147CDC38
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjJRMrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJRMrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:47:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B1EA3;
        Wed, 18 Oct 2023 05:47:49 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b44befac59so3872898b3a.0;
        Wed, 18 Oct 2023 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697633269; x=1698238069; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9kzuTzxZVlGgh2f5mC3oIMplNBV8HnSfbYCkmlfvIO0=;
        b=FghNIC/6Ky0TDrGA5L+6MIbYS4RZzOrcCQ/gvu+h3/36los+pKUA0A5Mhm1WOCz7IS
         teerGv3bM5eUJ7csLv6Oi47uyim01+tB5nNTd17r+ulRBUqIIEscD39pnDRSTvAkatU3
         2MqGzFLR7BMUVO75gqtjGdJbrEVEflCUNbNTEhqvw9lZDb8gDP3gyDfav/L9ohUExcgF
         QAGAz2PMiEVU/trN9Ir0Zjc6sdqyYxcpsULMiTIJTM6V3SqgVi84m4q4veoBDCHsqKLv
         eOG80aHVXHBIh/pYVzOeL37berqwA0Q6swHBd45EhS8x5DJvS5+0/1W02eewL1oLzo9j
         lhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697633269; x=1698238069;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9kzuTzxZVlGgh2f5mC3oIMplNBV8HnSfbYCkmlfvIO0=;
        b=u40rByz1CfXpIApXfdLszdtmZAeiTWPwdnAwpnqMV/IkHTJ4ZunJC4Wyj6zUwsY3F3
         7XLkDKTcwfnYBik7+uHZh+MHgZVm2IDjxwBHWmcEQh7VcL9QY4A+ar2KIzydodEmswxj
         F0DpVUPQlkGK7BMOD/QAGpWEup6eTthwUuUzPZkbCNxnvJHox660Ve23nzhsKjbWwbGe
         VVUo8I43cVo7Wy8yQHzwmo/vp6U8In98fnF+yY9Vhqg4NR0TkznyjdHeSwiDAdN9SsSa
         UkjX8Mf39Hhp7t1DQHZrrRmP77UdaBAf7KQ7UTwS05C2PgXW5X3+eM69dlhblbbuqGKS
         eoAA==
X-Gm-Message-State: AOJu0YwVYjZs3z9WpmfvA9UqbhMiXxVaniZtx+wjkSQ/6/0Ao3IlPfR7
        sWpszR4URTRAbp43sVyKEd+ZBkkTI/0RbQ==
X-Google-Smtp-Source: AGHT+IGXGeVHsVlXRGS2m6a7frgX1L1AYtgLEn9FwtI5ugKjMogKB6UXepsFeotAkt1UZrRjKys6fw==
X-Received: by 2002:a05:6a20:7288:b0:15d:4cf1:212e with SMTP id o8-20020a056a20728800b0015d4cf1212emr6856294pzk.4.1697633268764;
        Wed, 18 Oct 2023 05:47:48 -0700 (PDT)
Received: from thinkpad ([117.202.186.25])
        by smtp.gmail.com with ESMTPSA id i13-20020a65484d000000b00578afd8e012sm1389183pgs.92.2023.10.18.05.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:47:48 -0700 (PDT)
Date:   Wed, 18 Oct 2023 18:17:41 +0530
From:   Manivannan Sadhasivam <manivannanece23@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
Message-ID: <20231018124741.GA47321@thinkpad>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-3-git-send-email-quic_cang@quicinc.com>
 <6055cd57-4de7-4b7e-a4f3-68a7de1aef28@linaro.org>
 <6225a132-4b7f-bbb4-e863-4e62b99dd79d@quicinc.com>
 <31823dc4-6f50-435b-9a20-66471209ec31@linaro.org>
 <d34242f8-6e21-1549-b87d-3db2e825b7d5@quicinc.com>
 <1413119B-8B9C-4DE4-A086-476B2BAA60AD@linaro.org>
 <20230919120829.GB4732@thinkpad>
 <CAA8EJppwjzNDsPHZqUdmgQy3fAbP+AFnOo4+FTDCdpBEZp5S_w@mail.gmail.com>
 <20230920102327.GH4732@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920102327.GH4732@thinkpad>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 12:23:27PM +0200, Manivannan Sadhasivam wrote:
> On Wed, Sep 20, 2023 at 01:27:59AM +0300, Dmitry Baryshkov wrote:
> > On Tue, 19 Sept 2023 at 15:08, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > >
> > > On Fri, Sep 15, 2023 at 05:31:45AM +0300, Dmitry Baryshkov wrote:
> > > > On 11 September 2023 13:02:50 GMT+03:00, Can Guo <quic_cang@quicinc.com> wrote:
> > > > >
> > > > >On 9/11/2023 5:46 PM, Konrad Dybcio wrote:
> > > > >> On 11.09.2023 11:42, Can Guo wrote:
> > > > >>> Hi Konrad,
> > > > >>>
> > > > >>> On 9/11/2023 5:17 PM, Konrad Dybcio wrote:
> > > > >>>> On 11.09.2023 07:59, Can Guo wrote:
> > > > >>>>> From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
> > > > >>>>>
> > > > >>>>> Retrieve UFS device version from UFS host controller's spare register
> > > > >>>>> which is populated by bootloader, and use the UFS device version together
> > > > >>>>> with host controller's HW version to decide the proper power modes which
> > > > >>>>> should be used to configure the UFS PHY.
> > > > >>>> That sounds a bit fishy.. is there no bootloader-independent
> > > > >>>> solution to that? Can't we bring in the code that the bootloader
> > > > >>>> uses to determine these values?
> > > > >>>>
> > > > >>>> Konrad
> > > > >>>
> > > > >>> Agree, it is.
> > > > >>>
> > > > >>>
> > > > >>> All these complexities come from one request from PHY design team - power saving.
> > > > >>>
> > > > >>> And to achieve power saving, Qualcomm UFS developers are requested to use the
> > > > >>>
> > > > >>> lowest hanging PHY settings which can sustain the Max agreed HS Gear (btw host
> > > > >>>
> > > > >>> and UFS device) during UFS's lifecycle in High Level OS,  whereas the power saving
> > > > >>>
> > > > >>> request does not apply to bootloader, which works for only a few seconds during
> > > > >>>
> > > > >>> bootup. Hence, there is no such version detect code in bootloader -  it just uses the
> > > > >>>
> > > > >>> highest PHY settings to configure PHY, boot up UFS and put UFS device version in this
> > > > >>>
> > > > >>> register.
> > > > >> First of all, your email client seems to be inserting 2 newlines
> > > > >> instead of 1. If you're using thunderbird, you may want to edit:
> > > > >>
> > > > >> mail.identity.(default or your mail identity idx).default.compose_html
> > > > >>
> > > > >> to `false`
> > > > >>
> > > > >> and add that to your internal wiki page, as I see many @quic folks having
> > > > >> this issue.
> > > > >>
> > > > >>
> > > > >> Going back to the main topic, I don't think we understood each other.
> > > > >> The commit message states:
> > > > >>
> > > > >>
> > > > >> "Retrieve UFS device version from UFS host controller's spare register
> > > > >> which is populated by bootloader"
> > > > >>
> > > > >>
> > > > >> Which means the bootloader is able to somehow determine the value
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
> > > > >There is no logic behind this value at all in bootloader, as I explained, after bootloader
> > > > >
> > > > >initializes UFS, bootloader simply reads UFS's device version (the value you are referring)
> > > > >
> > > > >and write it to the register. But in Linux kernel, we need (or want to know) this value
> > > > >
> > > > >BEFORE we initialize UFS host controller (and UFS device).
> > > >
> > > > Depending on the bootloader behaviour is not an option. For example the kernel might be started via kexec. Or via u-boot. Or grub. Or any other bootloader. So please duplicate the logic to read the UFS version instead.
> > > >
> > >
> > > As Can said, there is no logic in the bootloader. What it does it, after doing
> > > the UFS initialization, it writes the agreed gear (between host and the device)
> > > to this register. And in linux, we use that value to initialize the device
> > > (i.e., not doing init based on the min gear).
> > >
> > > But the important factor here is that, we use this gear value to program the PHY
> > > init sequence. So if there is no hint from the bootloader, linux will program
> > > the min phy sequence (G3/G4) and then once the gear scaling happens, it will
> > > program the max phy sequence (G4/G5).
> > >
> > > Now on recent platforms, the init sequences are not compatible with each other
> > > i.e., once the min seq. is programmed, then before programming max seq. the
> > > registers not common to both seq. should be programmed to default value. In
> > > other words, min seq. specific registers should be reset to the default value.
> > > Otherwise, there will be stability issues in the PHY.
> > 
> > I see nothing wrong with adding 'default' register programming to the
> > gear tables. If we have to reset them to the default values to switch
> > the PHY settings, these writes must be a part of the corresponding
> > tables.
> > 
> 
> Yep, that's what I initially proposed. But Qcom wanted to avoid the cost of
> programming the reset tables in the PHY driver.
> 
> Can, could you please check if programming the additional sequence doesn't cause
> any power/performance effect?
> 

I'd like to simplify this conversion as there has been some misunderstanding.

First of all in linux, while probing the UFS device by the host controller, it
needs to use _some_ gear. So far we were using HS_G2 as that gear and using the
PHY init sequence of G3/G4 depending on the SoC. We do not need to use G2 init
sequence because, there are only 2 init sequences available for any SoC and
since the init sequences are backwards compatible, we mostly use the min init
sequence, G3/G4. Even though this incurs slight power consumption during boot,
the ufs host controller after probing the device will switch to max gear
supported by both entities. If that max is G4/G5, then the respective init
sequence will be programmed again.

Now the issue is, for the automotive usecases, switching the gears 2 times
during boot is affecting the boot KPI (Key Performance Inidicator). So the UFS
team came with the idea of populating a spare register in the bootloader with
the max gear info that the bootloader has already found out and using the same
in the linux for first time itself. This helps linux in using a single gear
during probe time.

This is what this patch is doing. If for some reason, that register is not
populated, then we default to the existing G2 gear and do init twice as the
driver is doing currently.

I hope this clarifies the intention of this patch.

- Mani

> - Mani
> 
> > >
> > > So to avoid that, if we get the hint from bootloader (always the max supported
> > > gear between host and device), then only one seq. will be programmed.
> > >
> > > Other way to solve this issue is to reset the non common registers in the init
> > > seq. to default value. But that will be an additional overhead.
> > >
> > > But... if the bootloader doesn't populate this register (if the boot device is
> > > not UFS, like in compute platforms), then this whole logic won't work. This
> > > should also be taken into consideration.
> > 
> > Yep, that's the dependency on the bootloader. Which we should avoid.
> > 
> > >
> > > - Mani
> > >
> > > >
> > > > P.S. you have been asked to fix your email client. Please do so. Or, if you are inserting these linebreaks manually, please stop.
> > > >
> > > > >Thanks,
> > > > >
> > > > >Can Guo.
> > > > >
> > > >
> > >
> > > --
> > > மணிவண்ணன் சதாசிவம்
> > 
> > 
> > 
> > -- 
> > With best wishes
> > Dmitry
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
