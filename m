Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145DB7DDEBA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjKAJwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAJwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:52:10 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1BADA;
        Wed,  1 Nov 2023 02:52:06 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4abc8169a76so39628e0c.1;
        Wed, 01 Nov 2023 02:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698832325; x=1699437125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wWuT16dEYI2em+YmuUc3qnNCMbwI4QJwMAUEgh2RO0E=;
        b=QyMEBEnnkP+Ua6qXMvRsxm1nQkCS+qTZ+Umi+0qx+rHkVME/Q9UJp8YwTwnJ3eSXd5
         lz/UAulIQfyV24NDUnUjvTnt68NWjA1g6RSV1qAiiSpWJCLno1y0bO3HylM2b/iPdBid
         flKx/iHOnMt7s0IB1tO6IFVDHUw5Y92Ei8FNq6v7D0NJHJOynqOBpQLvLHWqjdwK1nvF
         xNKvzxgqpxi2XfAvEGtoxONUAY+Ds+bPNf4GYGiyz2Kd4kHQs13LBPCBo5rH6DW0FRiX
         HvLYAQd1U2Dt2mPoYNHM0JNW1HNh8P1i82nKYdKYPv2zWhmAm8Ln6ADhG4e9e5TbVS54
         OZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698832325; x=1699437125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWuT16dEYI2em+YmuUc3qnNCMbwI4QJwMAUEgh2RO0E=;
        b=wx+0o30lM0aN7Y6R0+VkZccbt5wWG48GrKbeVaUzgbbHwmvF8NRbod28fYfc7IYOj/
         vaXPgBDeqduKucnuinYT9NDVx3NOvGRSmN19oMfnRVfiFaCATnX0VG/bU7K0LkMXybco
         q2j30UbmsNWCX9Mhyj1Q+bfSUit9nDWcQymAQ1kXKWY1IJZQON13JcQNkLZ2YBUGn7ty
         G/qSbDzvdLSD+RreilXs9LjdQr6FwYTM+AEMF0wSEXo6hYGsehaAJ6tWtd5U5PwiwdJg
         Fv4We0Ti0c/0QJwDjLf8IgW9Nx5Ng7oceA2BTCea1KcMf4donG1XIZ9etrOpQXwvl6/7
         6TdQ==
X-Gm-Message-State: AOJu0Ywpye6fJBWJU/Vo+SanWs07nSwPI1qR2gljNgYGoi1kuBo9p8Qh
        L4Dp0ge65asoRMZ6f+PEvi8ZR++PLGN5HeTdEGOwNBpJaJk=
X-Google-Smtp-Source: AGHT+IF2Lf3Zu2RtWbqFEOeM6cN2EPTc2dInEVWrp6WdEt5trxlhuTcQopt29hG6je9ZWoqMkR081+5+8F8Nu9Mr9Ow=
X-Received: by 2002:a1f:9cd0:0:b0:495:dcd2:d12a with SMTP id
 f199-20020a1f9cd0000000b00495dcd2d12amr13880505vke.9.1698832325423; Wed, 01
 Nov 2023 02:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <1678979666-551-1-git-send-email-quic_mojha@quicinc.com>
 <76943268-3982-deaf-9736-429dd51e01b0@gmail.com> <0e645486-f0be-4468-18ad-9e49088dee0b@quicinc.com>
 <CAOX2RU4xPNq4-OHUoMZtfZu05QEdpk1UtawZb1xQMrtc5ao84Q@mail.gmail.com>
 <a6c48095-179a-7e72-a282-fbc28af374cb@quicinc.com> <CAOX2RU6S-x-KrQ-qQLW-qxu4bph79d+Yq9Vj=PQwWW4o-yG2xA@mail.gmail.com>
 <CAOX2RU6rv0jcnTRAa=kiWHPk1A=DW=smS72df_t+tufOZ9XGfA@mail.gmail.com>
 <cd2c808c-bcb8-85fe-2c56-7accd4853160@quicinc.com> <CAOX2RU50+iR0jfyQqzRoTLn0Jydd_c+Ue88rDdhL6PbOKPDMVA@mail.gmail.com>
 <00b49050-5b9b-c16d-bd8f-8604ea993a26@quicinc.com>
In-Reply-To: <00b49050-5b9b-c16d-bd8f-8604ea993a26@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 1 Nov 2023 10:51:54 +0100
Message-ID: <CAOX2RU6EtRVmezcHhvTJF6Kc69_9dvzUHeoXQ1F1=ctnqhkmrw@mail.gmail.com>
Subject: Re: [PATCH v3] firmware: qcom_scm: Clear download bit during reboot
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 at 17:16, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>
> Hey Robert,
>
> Just remembered this thread again,
>
> is this issue got fixed with
>
> https://lore.kernel.org/lkml/20230816164641.3371878-1-robimarko@gmail.com/

Sadly no, as this issue is affecting all IPQ4019 boards and not just
the ones that have SDI enabled.

Regards,
Robert
>
>
> -Mukesh
>
> On 5/26/2023 3:13 AM, Robert Marko wrote:
> > On Tue, 23 May 2023 at 11:42, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 5/22/2023 3:34 PM, Robert Marko wrote:
> >>> On Mon, 22 May 2023 at 11:26, Robert Marko <robimarko@gmail.com> wrote:
> >>>>
> >>>> On Mon, 22 May 2023 at 11:11, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 5/22/2023 2:29 PM, Robert Marko wrote:
> >>>>>> On Mon, 22 May 2023 at 08:11, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 5/18/2023 3:45 PM, Robert Marko wrote:
> >>>>>>>>
> >>>>>>>> On 16. 03. 2023. 16:14, Mukesh Ojha wrote:
> >>>>>>>>> During normal restart of a system download bit should
> >>>>>>>>> be cleared irrespective of whether download mode is
> >>>>>>>>> set or not.
> >>>>>>>>>
> >>>>>>>>> Fixes: 8c1b7dc9ba22 ("firmware: qcom: scm: Expose download-mode control")
> >>>>>>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> >>>>>>>>
> >>>>>>>> Hi, this has been backported to 5.15.111, however it seems to be
> >>>>>>>> breaking reboot
> >>>>>>>> on IPQ4019 by causing the board to then hang in SBL with:
> >>>>>>>> root@OpenWrt:/# reboot
> >>>>>>>> root@OpenWrt:/# [   76.473541] device lan1 left promiscuous mode
> >>>>>>>> [   76.474204] br-lan: port 1(lan1) entered disabled state
> >>>>>>>> [   76.527975] device lan2 left promiscuous mode
> >>>>>>>> [   76.530301] br-lan: port 2(lan2) entered disabled state
> >>>>>>>> [   76.579376] device lan3 left promiscuous mode
> >>>>>>>> [   76.581698] br-lan: port 3(lan3) entered disabled state
> >>>>>>>> [   76.638434] device lan4 left promiscuous mode
> >>>>>>>> [   76.638777] br-lan: port 4(lan4) entered disabled state
> >>>>>>>> [   76.978489] qca8k-ipq4019 c000000.switch wan: Link is Down
> >>>>>>>> [   76.978883] device eth0 left promiscuous mode
> >>>>>>>> [   76.987077] ipqess-edma c080000.ethernet eth0: Link is Down
> >>>>>>>> [
> >>>>>>>> Format: Log Type - Time(microsec) - Message - Optional Info
> >>>>>>>> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> >>>>>>>> S - QC_IMAGE_VERSION_STRING=BOOT.BF.3.1.1-00123
> >>>>>>>> S - IMAGE_VARIANT_STRING=DAABANAZA
> >>>>>>>> S - OEM_IMAGE_VERSION_STRING=CRM
> >>>>>>>> S - Boot Config, 0x00000021
> >>>>>>>> S - Reset status Config, 0x00000010
> >>>>>>>> S - Core 0 Frequency, 0 MHz
> >>>>>>>> B -       261 - PBL, Start
> >>>>>>>> B -      1339 - bootable_media_detect_entry, Start
> >>>>>>>> B -      1679 - bootable_media_detect_success, Start
> >>>>>>>> B -      1693 - elf_loader_entry, Start
> >>>>>>>> B -      5076 - auth_hash_seg_entry, Start
> >>>>>>>> B -      7223 - auth_hash_seg_exit, Start
> >>>>>>>> B -    578349 - elf_segs_hash_verify_entry, Start
> >>>>>>>> B -    696356 - PBL, End
> >>>>>>>> B -    696380 - SBL1, Start
> >>>>>>>> B -    787236 - pm_device_init, Start
> >>>>>>>> D -         7 - pm_device_init, Delta
> >>>>>>>> B -    788701 - boot_flash_init, Start
> >>>>>>>> D -     52782 - boot_flash_init, Delta
> >>>>>>>> B -    845625 - boot_config_data_table_init, Start
> >>>>>>>> D -      3836 - boot_config_data_table_init, Delta - (419 Bytes)
> >>>>>>>> B -    852841 - clock_init, Start
> >>>>>>>> D -      7566 - clock_init, Delta
> >>>>>>>> B -    864883 - CDT version:2,Platform ID:9,Major ID:0,Minor
> >>>>>>>> ID:0,Subtype:64
> >>>>>>>> B -    868413 - sbl1_ddr_set_params, Start
> >>>>>>>> B -    873402 - cpr_init, Start
> >>>>>>>> D -         2 - cpr_init, Delta
> >>>>>>>> B -    877842 - Pre_DDR_clock_init, Start
> >>>>>>>> D -         4 - Pre_DDR_clock_init, Delta
> >>>>>>>> D -     13234 - sbl1_ddr_set_params, Delta
> >>>>>>>> B -    891155 - pm_driver_init, Start
> >>>>>>>> D -         2 - pm_driver_init, Delta
> >>>>>>>> B -    909105 - Image Load, Start
> >>>>>>>> B -   1030210 - Boot error ocuured!. Error code: 303d
> >>>>>>>>
> >>>>>>>> Reverting the commit fixes rebooting.
> >>>>>>>
> >>>>>>> Hi Robert,
> >>>>>>>
> >>>>>>> Can you check if disable SDI [1] works with this issue
> >>>>>>>
> >>>>>>> https://lore.kernel.org/linux-arm-msm/20230518140224.2248782-1-robimarko@gmail.com/
> >>>>>>>
> >>>>>>> [1]
> >>>>>>>
> >>>>>>>
> >>>>>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> >>>>>>> index fde33acd46b7..01496ceb7136 100644
> >>>>>>> --- a/drivers/firmware/qcom_scm.c
> >>>>>>> +++ b/drivers/firmware/qcom_scm.c
> >>>>>>> @@ -1508,6 +1508,7 @@ static int qcom_scm_probe(struct platform_device
> >>>>>>> *pdev)
> >>>>>>>      static void qcom_scm_shutdown(struct platform_device *pdev)
> >>>>>>>      {
> >>>>>>>             /* Clean shutdown, disable download mode to allow normal restart */
> >>>>>>> +       qcom_scm_disable_sdi();
> >>>>>>>             qcom_scm_set_download_mode(false);
> >>>>>>>      }
> >>>>>>
> >>>>>> Hi,
> >>>>>> I can confirm reboot works this way as well.
> >>>>>
> >>>>> That's great, So, i don't need to revert the patch and you can
> >>>>> add this in your patch without target specific check ?
> >>>>
> >>>> Oh, you mean IPQ4019 not rebooting?
> >>>> I haven't tested that, give me couple of minutes to try that out.
> >>>> Cause, the link was just back to the SDI patchset.
> >>>
> >>> And, I can confirm that IPQ4019 does not reboot even with SDI disabled if dload
> >>> mode was set so it still needs a revert.
> >>
> >> Ok, So, before we go for revert of the change.
> >>
> >> - How do you generally collect the ram dump on your device on crash ?
> >>     did you check if you get any error when qcom_scm_set_download_mode()
> >>     get called.
> >
> > Hi,
> > Unfortunately, I dont have a way to collect the RAM dump in this case.
> >
> > I checked and __qcom_scm_set_dload_mode returns 0 and there are no
> > errors.
> >
> > Regards,
> > Robert
> >>
> >>
> >> -- Mukesh
> >>
> >>>
> >>> Regards,
> >>> Robert
> >>>>
> >>>> Regards,
> >>>> Robert
> >>>>>
> >>>>> -- Mukesh
> >>>>>
> >>>>>>
> >>>>>> Regards,
> >>>>>> Robert
> >>>>>>>
> >>>>>>>
> >>>>>>> -- Mukesh
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Regards,
> >>>>>>>> Robert
> >>>>>>>>
> >>>>>>>>> ---
> >>>>>>>>> Changes in v3:
> >>>>>>>>>       - Added Fixes tag.
> >>>>>>>>>       - Removed it from below patch series, as it makes sense to go this
> >>>>>>>>> independently.
> >>>>>>>>>
> >>>>>>>>> https://lore.kernel.org/lkml/1677664555-30191-1-git-send-email-quic_mojha@quicinc.com/
> >>>>>>>>>
> >>>>>>>>> Changes in v2:
> >>>>>>>>>       - No change.
> >>>>>>>>>
> >>>>>>>>>      drivers/firmware/qcom_scm.c | 3 +--
> >>>>>>>>>      1 file changed, 1 insertion(+), 2 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> >>>>>>>>> index 468d4d5..3e020d1 100644
> >>>>>>>>> --- a/drivers/firmware/qcom_scm.c
> >>>>>>>>> +++ b/drivers/firmware/qcom_scm.c
> >>>>>>>>> @@ -1506,8 +1506,7 @@ static int qcom_scm_probe(struct platform_device
> >>>>>>>>> *pdev)
> >>>>>>>>>      static void qcom_scm_shutdown(struct platform_device *pdev)
> >>>>>>>>>      {
> >>>>>>>>>          /* Clean shutdown, disable download mode to allow normal restart */
> >>>>>>>>> -    if (download_mode)
> >>>>>>>>> -        qcom_scm_set_download_mode(false);
> >>>>>>>>> +    qcom_scm_set_download_mode(false);
> >>>>>>>>>      }
> >>>>>>>>>      static const struct of_device_id qcom_scm_dt_match[] = {
