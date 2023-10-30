Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3F97DB5EA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjJ3JOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbjJ3JN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:13:58 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE638A7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:13:53 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8DxBfHPcz9lQ7U1AA--.39750S3;
        Mon, 30 Oct 2023 17:13:51 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxE+TJcz9lgOc2AA--.54536S3;
        Mon, 30 Oct 2023 17:13:47 +0800 (CST)
Message-ID: <0b704a08-46d2-4c31-b51f-8abf09f99f88@loongson.cn>
Date:   Mon, 30 Oct 2023 17:13:57 +0800
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
X-CM-TRANSID: AQAAf8BxE+TJcz9lgOc2AA--.54536S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWDCF1DCFWrJF1fJr4UWrX_yoW8Aw4rpF
        W8Xa98Krs8Jr1kWwn2vr4DA3sFqrsYyFyrt3yvkw13JasIyr9YvF48Xw4DGFy8Aa4Fgr4S
        yw1qgr13ua1Yk3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
        AVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
        kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
        6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
        Ja73UjIFyTuYvjxU7G-eUUUUU
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
>> +
>> +/* Built-in DVO encoder helper funcs */
>> +
>> +static void lsdc_dvo_atomic_disable(struct drm_encoder *encoder,
>> +                                   struct drm_atomic_state *state)
>> +{
>> +}
>> +
>> +static void lsdc_dvo_atomic_enable(struct drm_encoder *encoder,
>> +                                  struct drm_atomic_state *state)
>> +{
>> +}
>> +
>> +static void lsdc_dvo_atomic_modeset(struct drm_encoder *encoder,
>> +                                   struct drm_crtc_state *crtc_state,
>> +                                   struct drm_connector_state *conn_state)
>> +{
>> +}
> You do not need these empty callbacks, do you?


Thanks a lot for the sharpen eyes.

Yes. I do not need these empty callbacks.
I have some program experience with Linux-4.19 kernel.
I clearly remember that these empty callbacks was need when I add lt8619 display bridge driver.
I have just remove it and tested, it seems that those is not need anymore.

Thanks a lot for review, this problem will be fixed at the next version.




