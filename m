Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EA07DB5F8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjJ3JRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjJ3JRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:17:03 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE1AAB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:17:00 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9a58f5f33dso3427446276.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698657419; x=1699262219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mr/FHzokc9n1TPuAhp7akRblNKnfq2GX5dSdtsjKfKE=;
        b=PmfbX4fs+aaiQaZtRMfKJOHev0CaZF4DAeaWxCXDV1N3ZPEAmJYgeAu3dw8aaiZnrL
         fs4N9IioGbUMG/hqf2ZpHSp0WY/dlitIl8ROm3DPKk9RUjnc/Fi5w9hpAhD1IzRUkhwb
         J+1I82SQNq+XPNqxJHVT32i8WnRlP2/NwrEy20eZUP2152YN2h33fu5pen41Vse2fjfn
         6ZAsX2ogq0eSK6YO0JLOhy70mz6Or5I75Ht7Ph8xwOns6IfR4xp1xdy2lcIZV1hYSNpc
         zBvOBYfTGMmItPTO25aEkkdBXLw3b/62Ae7zsk/mNjLonUCAL1v+fS4t2a7ovOLP6mRU
         cd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698657419; x=1699262219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mr/FHzokc9n1TPuAhp7akRblNKnfq2GX5dSdtsjKfKE=;
        b=oR9sAKu9ucY74OFODktH+UHreZaxRJo7GLtMy1B5JwW/KUC5NlpBVs/XT4RM/K0NmC
         65smL6qiEp7eg6EdubjgaYqjUotTet8q5qyxIEi+0ZPqwyIZRjVC9z8dJGUMdf4vbF3Q
         gQKSFKFmpuqFpf4+QRWvDiL88WeFRpHsrLHFG4FPMN8QDZO6GSgfzajkyOJDCnwmyPsh
         mFeUhqQiMmZWHXjLnxgrOyUM2JvOAVqtAiYlaXfQPQscUH/iK7Dz+pKo9w5rELHFdqFt
         9mK3+uR6HdVdsOgWOfuXrlLRoermV9dwmcQ6g/WM/4a6pkPJJrYW7gRfb9nEJP3wR+RE
         rMbA==
X-Gm-Message-State: AOJu0Yzyqgn5bjj5f3AirEDCjDf7Gn+uKXScG5rXPrSgvtPLnmX+VVPA
        cIbVxz/fNjH3XLvOb/EPpzxLD+qClF36NSEHrWs0rQ==
X-Google-Smtp-Source: AGHT+IF8OUqQ/miefVyh/iIuR6Gb2gxF6tC2w4n0ty2Q82u6LrIRgu1R9h5Xzk6si2BQeJ6KtVDcIhlSK/sUNu0hZ0c=
X-Received: by 2002:a25:b08a:0:b0:da0:58da:2709 with SMTP id
 f10-20020a25b08a000000b00da058da2709mr7289610ybj.58.1698657419215; Mon, 30
 Oct 2023 02:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231029194607.379459-1-suijingfeng@loongson.cn>
 <20231029194607.379459-4-suijingfeng@loongson.cn> <CAA8EJpoWXtmMt9vpG9Q4dpv6HnMjtdmEo6rbBszXNG30NhbB1A@mail.gmail.com>
 <ea335f64-16cc-47aa-b523-0aae6f64e223@loongson.cn>
In-Reply-To: <ea335f64-16cc-47aa-b523-0aae6f64e223@loongson.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 30 Oct 2023 11:16:47 +0200
Message-ID: <CAA8EJppYWO6O_xYt1WoRa_eoZ04wFdq39f-tvKj0R5BKnbFRkA@mail.gmail.com>
Subject: Re: [PATCH 3/8] drm/loongson: Allow attach drm bridge driver by
 calling lsdc_output_init()
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 06:13, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>
> Hi,
>
>
> On 2023/10/30 07:10, Dmitry Baryshkov wrote:
> >> +
> >> +/* Built-in HDMI encoder funcs on display pipe 0 */
> >> +
> >> +static void lsdc_pipe0_hdmi_encoder_reset(struct drm_encoder *encoder)
> >> +{
> >> +       struct drm_device *ddev = encoder->dev;
> >> +       struct lsdc_device *ldev = to_lsdc(ddev);
> >> +       u32 val;
> >> +
> >> +       val = PHY_CLOCK_POL | PHY_CLOCK_EN | PHY_DATA_EN;
> >> +       lsdc_wreg32(ldev, LSDC_CRTC0_DVO_CONF_REG, val);
> >> +
> >> +       /* Using built-in GPIO emulated I2C instead of the hardware I2C */
> >> +       lsdc_ureg32_clr(ldev, LSDC_HDMI0_INTF_CTRL_REG, HW_I2C_EN);
> >> +
> >> +       /* Help the HDMI phy get out of reset state */
> >> +       lsdc_wreg32(ldev, LSDC_HDMI0_PHY_CTRL_REG, HDMI_PHY_RESET_N);
> >> +
> >> +       drm_dbg(ddev, "%s reset\n", encoder->name);
> >> +
> >> +       mdelay(20);
> >> +}
> >> +
> >> +const struct drm_encoder_funcs lsdc_pipe0_hdmi_encoder_funcs = {
> >> +       .reset = lsdc_pipe0_hdmi_encoder_reset,
> >> +       .destroy = drm_encoder_cleanup,
> >> +};
> >> +
> >> +/* Built-in HDMI encoder funcs on display pipe 1 */
> > All pipe 1 code looks like a pipe0, just the registers were changed.
> > Could you please refactor that to use a single instance of all
> > functions and pass pipe id through the data struct?
> > Then you can use macros to determine whether to use pipe 0 or pipe 1 register.
> >
>
> Yes, you are right. But please allow me to explain something.
>
> In the past, Thomas told me to untangle it, despite this idea lead to duplicated code(or pattern).
> but at the long run, this pay off.
>
> Because the method of passing pipe id will introduce the "if and else" side effects.
> But my functions have no if and else.
>
>
> ```
> if (pipe == 0) {
>      ...
> } else if (pipe == 1) {
>      ...
> }
> ```

I was thinking about something easier:

static void lsdc_pipe_hdmi_encoder_reset(struct drm_encoder *encoder)
{
   ....
   lsdc_wreg32(ldev, LSDC_CRTCn_DVO_CONF_REG(ldev->pipe_id), val);
   ...
};

So, no ifs, just define per-pipe registers.


>
> Using the C program language's Macro(#define XXX) to generate code is not fun to me.
> Because every time you want to change it, It needs my brains to thinking it twice. Maybe
> more than twice.
>
> 1) It needs my brains to replace the macros manually each time I saw the code.
>
> 2) When I want to change(alter) the prototype, I need to worry about all of the instances.
>     sometimes it is not symmetry. The DVO port and HDMI phy itself is symmetry, but the
>     external display bridge connected with them are not symmetry. So, there are some registers
>     located at the domain of this display controller side should change according to the
>     different type of external display bridge.
>
> 3) Code duplication is actually less harmful than unmaintainable.
>     macros are abstract, as noob level programmer, we completely drop the idea of abstract.
>     Bad abstract means design failure, this is what we are most afraid of.
>     Generally, we would like divide the whole into small cases, handle them one by one.
>     It is actually to review and understand.

Code duplication is both harmful and unmaintainable. It is _very_hard_
to spot the difference between pipe0 and pipe1. And it is _very_easy_
to patch just one instance of these functions leaving the issue in the
second one. So, I'd say, all the c&p functions are a no-go.

>
> 4) From the viewpoint of the hardware, the display output hardware suffer from changes.
>     Because users always want *new* display interface. The need of the users are also varies.
>     Personally, I think macros are best for the symmetry case, while the output part of a
>     display pipe always suffer from change.
>
> >> +
> >> +static void lsdc_pipe1_hdmi_encoder_reset(struct drm_encoder *encoder)
> >> +{
> >> +       struct drm_device *ddev = encoder->dev;
> >> +       struct lsdc_device *ldev = to_lsdc(ddev);
> >> +       u32 val;
> >> +
> >> +       val = PHY_CLOCK_POL | PHY_CLOCK_EN | PHY_DATA_EN;
> >> +       lsdc_wreg32(ldev, LSDC_CRTC1_DVO_CONF_REG, val);
> >> +
> >> +       /* Using built-in GPIO emulated I2C instead of the hardware I2C */
> >> +       lsdc_ureg32_clr(ldev, LSDC_HDMI1_INTF_CTRL_REG, HW_I2C_EN);
> >> +
> >> +       /* Help the HDMI phy get out of reset state */
> >> +       lsdc_wreg32(ldev, LSDC_HDMI1_PHY_CTRL_REG, HDMI_PHY_RESET_N);
> >> +
> >> +       drm_dbg(ddev, "%s reset\n", encoder->name);
> >> +
> >> +       mdelay(20);
> >> +}
> >> +
> >> +const struct drm_encoder_funcs lsdc_pipe1_hdmi_encoder_funcs = {
> >> +       .reset = lsdc_pipe1_hdmi_encoder_reset,
> >> +       .destroy = drm_encoder_cleanup,
> >> +};
>


-- 
With best wishes
Dmitry
