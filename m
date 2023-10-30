Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09BD7DB274
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 05:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjJ3ENn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 00:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3ENl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 00:13:41 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61D4AB4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 21:13:36 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxDOtuLT9lRqs1AA--.34396S3;
        Mon, 30 Oct 2023 12:13:34 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxO9xrLT9l5M02AA--.51747S3;
        Mon, 30 Oct 2023 12:13:33 +0800 (CST)
Message-ID: <ea335f64-16cc-47aa-b523-0aae6f64e223@loongson.cn>
Date:   Mon, 30 Oct 2023 12:13:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/loongson: Allow attach drm bridge driver by
 calling lsdc_output_init()
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20231029194607.379459-1-suijingfeng@loongson.cn>
 <20231029194607.379459-4-suijingfeng@loongson.cn>
 <CAA8EJpoWXtmMt9vpG9Q4dpv6HnMjtdmEo6rbBszXNG30NhbB1A@mail.gmail.com>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <CAA8EJpoWXtmMt9vpG9Q4dpv6HnMjtdmEo6rbBszXNG30NhbB1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxO9xrLT9l5M02AA--.51747S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw1kCw17CFykCF43Zw4rCrX_yoWrGF4UpF
        Wrta9xKr4DJFn0gry8Zr48Z34xKrZ5tFs5twsYkFy3C34Yyryfta1jqr45CFykAFsYqrWI
        yF4qqF1kuFn0yrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
        6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
        nUUI43ZEXa7IU8CksDUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/10/30 07:10, Dmitry Baryshkov wrote:
>> +
>> +/* Built-in HDMI encoder funcs on display pipe 0 */
>> +
>> +static void lsdc_pipe0_hdmi_encoder_reset(struct drm_encoder *encoder)
>> +{
>> +       struct drm_device *ddev = encoder->dev;
>> +       struct lsdc_device *ldev = to_lsdc(ddev);
>> +       u32 val;
>> +
>> +       val = PHY_CLOCK_POL | PHY_CLOCK_EN | PHY_DATA_EN;
>> +       lsdc_wreg32(ldev, LSDC_CRTC0_DVO_CONF_REG, val);
>> +
>> +       /* Using built-in GPIO emulated I2C instead of the hardware I2C */
>> +       lsdc_ureg32_clr(ldev, LSDC_HDMI0_INTF_CTRL_REG, HW_I2C_EN);
>> +
>> +       /* Help the HDMI phy get out of reset state */
>> +       lsdc_wreg32(ldev, LSDC_HDMI0_PHY_CTRL_REG, HDMI_PHY_RESET_N);
>> +
>> +       drm_dbg(ddev, "%s reset\n", encoder->name);
>> +
>> +       mdelay(20);
>> +}
>> +
>> +const struct drm_encoder_funcs lsdc_pipe0_hdmi_encoder_funcs = {
>> +       .reset = lsdc_pipe0_hdmi_encoder_reset,
>> +       .destroy = drm_encoder_cleanup,
>> +};
>> +
>> +/* Built-in HDMI encoder funcs on display pipe 1 */
> All pipe 1 code looks like a pipe0, just the registers were changed.
> Could you please refactor that to use a single instance of all
> functions and pass pipe id through the data struct?
> Then you can use macros to determine whether to use pipe 0 or pipe 1 register.
>

Yes, you are right. But please allow me to explain something.

In the past, Thomas told me to untangle it, despite this idea lead to duplicated code(or pattern).
but at the long run, this pay off.

Because the method of passing pipe id will introduce the "if and else" side effects.
But my functions have no if and else.


```
if (pipe == 0) {
     ...
} else if (pipe == 1) {
     ...
}
```

Using the C program language's Macro(#define XXX) to generate code is not fun to me.
Because every time you want to change it, It needs my brains to thinking it twice. Maybe
more than twice.

1) It needs my brains to replace the macros manually each time I saw the code.

2) When I want to change(alter) the prototype, I need to worry about all of the instances.
    sometimes it is not symmetry. The DVO port and HDMI phy itself is symmetry, but the
    external display bridge connected with them are not symmetry. So, there are some registers
    located at the domain of this display controller side should change according to the
    different type of external display bridge.

3) Code duplication is actually less harmful than unmaintainable.
    macros are abstract, as noob level programmer, we completely drop the idea of abstract.
    Bad abstract means design failure, this is what we are most afraid of.
    Generally, we would like divide the whole into small cases, handle them one by one.
    It is actually to review and understand.

4) From the viewpoint of the hardware, the display output hardware suffer from changes.
    Because users always want *new* display interface. The need of the users are also varies.
    Personally, I think macros are best for the symmetry case, while the output part of a
    display pipe always suffer from change.

>> +
>> +static void lsdc_pipe1_hdmi_encoder_reset(struct drm_encoder *encoder)
>> +{
>> +       struct drm_device *ddev = encoder->dev;
>> +       struct lsdc_device *ldev = to_lsdc(ddev);
>> +       u32 val;
>> +
>> +       val = PHY_CLOCK_POL | PHY_CLOCK_EN | PHY_DATA_EN;
>> +       lsdc_wreg32(ldev, LSDC_CRTC1_DVO_CONF_REG, val);
>> +
>> +       /* Using built-in GPIO emulated I2C instead of the hardware I2C */
>> +       lsdc_ureg32_clr(ldev, LSDC_HDMI1_INTF_CTRL_REG, HW_I2C_EN);
>> +
>> +       /* Help the HDMI phy get out of reset state */
>> +       lsdc_wreg32(ldev, LSDC_HDMI1_PHY_CTRL_REG, HDMI_PHY_RESET_N);
>> +
>> +       drm_dbg(ddev, "%s reset\n", encoder->name);
>> +
>> +       mdelay(20);
>> +}
>> +
>> +const struct drm_encoder_funcs lsdc_pipe1_hdmi_encoder_funcs = {
>> +       .reset = lsdc_pipe1_hdmi_encoder_reset,
>> +       .destroy = drm_encoder_cleanup,
>> +};

