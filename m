Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520077B1124
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjI1DUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1DUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:20:44 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46B94;
        Wed, 27 Sep 2023 20:20:39 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-65b10205207so37577026d6.0;
        Wed, 27 Sep 2023 20:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695871238; x=1696476038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NS/wz0bl6MuMokliWeLl4WPqdz4fGJLWZvYUHGBxFS4=;
        b=X15kYYsYgroTAczbUZ5jRwW/uWadO+s2HtJThG0GwhnUeA7JbjlfIh8UawCcZioGn/
         r1LIM0aeAD4DolcN+6td8iNsJWL77CWSLVDQM1v6fo/2zcqv616TKNAr1yIR0sP55YHY
         TpARGEueGkj1rw6MTAB+dyEG9lTcT1QZBmzplpgmH0M3SppANeF/lMasr27jHNnvkmlQ
         EMNMUOUsENf0C6PF1QHimoqINjjiwVFX9QYoWIKVmkB3Y4qbOuXpFgpLeRorAEPQ1/xr
         oB599x4FtExSyiLdHlw7nGp2YuWwuwtd5bmhDIpWqs6ymrxOzkz/Kf98B5KBdp6SNwTd
         byHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695871238; x=1696476038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NS/wz0bl6MuMokliWeLl4WPqdz4fGJLWZvYUHGBxFS4=;
        b=RzuflU/NgZ9vC1eZCe478cV1uz9mSdNdrMETqHUnV1rNad58TLBh9tI3Qq1HydOGMS
         KXf/2Zt7GWiF8GmbObiB5fOsC27visFlsosoSMOTzJNH1ANZL+BE+QWrqtVAua2TNnre
         Rr4BRpL/xZRHA7qYqJ2ndDZml0KQ9UzGSrxl4lJtmh9Bi+5qBIf8iu/lNHNdx5RFEctQ
         XZpp+j3RG9kALts5tx38WUo4K26myXJHwoMdLEfz5g+pHjYR0E33b4Y/k65mIBkrzXL9
         mivdBzokPpodB4ChsHOPR0kZE7dkpK4r4j2rPC3KTN8UleMQeiuRqjbh1MybV/4QOq9H
         hXxQ==
X-Gm-Message-State: AOJu0YzbKM9ZTMOffg60Wnc+BsuBoqu/qloW6S/p9CvpGWgwK7PF4WVk
        V/L4i71W22hWCVmXu+qJ/As/zR9CataUudSfgVo=
X-Google-Smtp-Source: AGHT+IFxC7y63XEVcyYVD8IeHqL+kfqaTfLE8fKn497jLjoPJRiCF6zhTjJv7+Hn5zBDo43mQgQtMUQtLwgEk5p6/Q0=
X-Received: by 2002:a0c:f24f:0:b0:65b:896:1cb1 with SMTP id
 z15-20020a0cf24f000000b0065b08961cb1mr28914qvl.17.1695871238178; Wed, 27 Sep
 2023 20:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <1650963852-4173-1-git-send-email-quic_spathi@quicinc.com>
 <CAPDyKFo7H=fOiX49gttrKO3gwe=ddYMjdgrO_xSnnZjZh7P7ZA@mail.gmail.com>
 <MWHPR0201MB3466C629ECABC8FD6B009276E3D79@MWHPR0201MB3466.namprd02.prod.outlook.com>
 <ea318551ec0b43429ce47bfac9ebf285@quicinc.com> <CAPDyKFq2-Jwii_aMbsqYNM_Dq0-MMEEtUYnNKGbQgvDL+M-wdw@mail.gmail.com>
 <c06480b1-95e3-49cd-9498-5c7c5f1deabe@quicinc.com>
In-Reply-To: <c06480b1-95e3-49cd-9498-5c7c5f1deabe@quicinc.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Thu, 28 Sep 2023 11:20:26 +0800
Message-ID: <CA+Da2qz2dSUKa9t4gBaDg=kAE=CjRrx2Sz_Je+nFsrM5xr_+5w@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: core: Add partial initialization support
To:     Sarthak Garg <quic_sartgarg@quicinc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Kamasali Satyanarayan (Consultant) (QUIC)" 
        <quic_kamasali@quicinc.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "merez@codeaurora.org" <merez@codeaurora.org>,
        "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
        "huijin.park@samsung.com" <huijin.park@samsung.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sept 2023 at 18:41, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
>
>
> On 6/16/2022 4:18 AM, Ulf Hansson wrote:
> > On Tue, 24 May 2022 at 07:37, Sarthak Garg (QUIC)
> > <quic_sartgarg@quicinc.com> wrote:
> >> Hi Ulf,
> >>
> >> Please find the gains seen on micron and kingston eMMC parts below with partial initialization feature (These are the averaged numbers) :
> >>
> >> 1) Micron eMMC (ManfID 0x13)
> >>
> >> Partial init                            Full Init
> >>
> >> a) _mmc_resume:                         _mmc_resume :
> >>
> >> Total time : 62ms                       Total time : 84ms
> >> (Decrease % from full init = ~26%)
> > Alright, so we gained around 22ms. Not too bad.
> >
> >> Breakup :
> >> mmc_claim_host_time: 0.2ms              mmc_claim_host_time: 0.1ms
> >> mmc_power_up_time: 33ms         mmc_power_up_time: 33ms
> >> mmc_sleepawake_time: 28ms               mmc_init_card_time: 50ms
> >> mmc_partial_init_time: 1ms
> >>
> >> b) _mmc_suspend:                        _mmc_suspend:
> >>
> >> Total time: 5ms                         Total time: 7.5ms
> >> mmc_claim_host_time: 0.5ms              mmc_claim_host_time: 1ms
> >> mmc_flush_cache_time : 1.5 ms   mmc_flush_cache_time : 2.5 ms
> >> mmc_sleep_time: 1.5ms           mmc_sleep_time: 2ms
> >> mmc_power_off_time: 1.5ms               mmc_power_off_time: 1.5ms
> > The suspend time shouldn't really differ. Or is there a reason for this?
>
>
> I think this could be due to run to run variation as we can see
> mmc_claim_host and mmc_flush_cache itself taking some extra 1ms.
>
>

Hi Sarthak

I have a question.
1.What is the difference between Partial init and Full Init on SOC
power consumption?
2.Partial init and Full init improve IO performance?
3.Could you share the test methods if you want?

> >
> >>
> >> 2) Kingston eMMC (ManfID 0x70)
> >>
> >> Partial init                            Full Init
> >>
> >> a) _mmc_resume:                 _mmc_resume :
> >> Total time : 46ms                       Total time : 62ms
> >> (Decrease % from full init = ~25%)
> >>
> >> Breakup :
> >> mmc_claim_host_time: 0.2ms              mmc_claim_host_time: 0.2ms
> >> mmc_power_up_time: 30ms         mmc_power_up_time: 30ms
> >> mmc_sleepawake_time: 14ms               mmc_init_card_time: 31ms
> >> mmc_partial_init_time: 2ms
> >>
> >>
> >> b) _mmc_suspend:                        _mmc_suspend:
> >> Total time : 5ms                        Total: 5ms
> >>
> >> Breakup :
> >> mmc_claim_host_time: 0.5ms              mmc_claim_host_time: 0.5ms
> >> mmc_flush_cache_time : 1.5 ms   mmc_flush_cache_time : 1.5 ms
> >> mmc_sleep_time: 1.5ms           mmc_sleep_time: 1ms
> >> mmc_power_off_time: 1.5ms               mmc_power_off_time: 1.5ms
> >>
> >> Did some minor modifications as well to this patchset as per avri's comment which I'll post as V2.
> >> Please let me know your inputs about these numbers.
> > Thanks for posting these numbers, much appreciated! Please try to
> > include some of the data as part of the commit message as I think it's
> > valuable information.
> >
> > When it comes to reviewing the code, I am awaiting your v2 then.
> >
> > [...]
> >
> > Kind regards
> > Uffe
>
> Sure will add this data to the commit text in V2.
>
>
