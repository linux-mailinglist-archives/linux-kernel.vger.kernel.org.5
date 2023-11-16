Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE68C7EE911
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345546AbjKPWAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345542AbjKPWAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:00:40 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D51618D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:00:34 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a8628e54d4so11520077b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700172033; x=1700776833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rkJdqDNNV47Wh6CF2CiwHs8JSducikbK3ovla3lQXxg=;
        b=j9WCAzFJb8s0S7HB+vGzr696Hd+dkMJBqQ3c88dXkVGEfP+TxcOIXpxEMAXLEY3kUm
         JUeS09U2raLjKEh444+zpx9ngm9K5sFDUceFsscxLy+TzSh++WHM8p0pK9Ly+6BR5L2Z
         lr4hMjYyWOlYZzr2fn2Gbl8V1g7thV2UEx2BX/fbMrX8s5E99WkcGL/8q6XmYDXlLo0K
         MEz9SNv4Rx/BgU+a6V3+S5I2jyY8p5gLDXdd/87ZApAuFmL6i6AqMu3t3Fo+gLBgyO6d
         z6stMIx51rZPOM4HaVKL4bnxvUuEkgTYg1+1h0PSPw7a3kbNFGMFbSdj3Kw/6LsiGcS+
         rXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700172033; x=1700776833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkJdqDNNV47Wh6CF2CiwHs8JSducikbK3ovla3lQXxg=;
        b=Wkb9TmT8FvCJZFlo5r2urMAo3Aeg+MembVDFN+dm1tgjbc5LPxTaTzRZ/Owq6GWYz9
         icZkXe3rl2rAG+2klwlddRNcvk0cD7nfTr0SnGPJJs4wn0MXe0pwwt4s6dGDNFL2jaIC
         TK9lyIJHq2LKXBKsg2dy3ySPB9YDMnfoOMLNUj7TG+5kNoiBDHSWVOq4MyTj17w9TbI/
         h5whkJgKfWV85cP6vREsb9cTerLH++4hr645sDkcIs9nFgmFbnZf2U63gbiepXzp+iu3
         bYw3o+uickliHOKZsGIJaCRYwLS106d5UXEY0ogXkGzZiC2j1/XJZxc7gNSkODRG2wfj
         +RSg==
X-Gm-Message-State: AOJu0YwhwifTmhRHc1iNe6Mvb5q53KHABdwdcn4CeArDiaMDrfWVFEVW
        EbXR3pkmd4ZBy9GhQIaK9hS/+VSQIxFnOaHtParM+POEaP07F0Gp
X-Google-Smtp-Source: AGHT+IF5Dm7SQbyC9efdze9GrFc+bpgUj8BuKkkSJuDmwMJ2O8CRbkE8iCz/vd3ec7czNuHpWQXAsYvwNhwXGRK/LQA=
X-Received: by 2002:a05:690c:d18:b0:5c5:b6aa:55cd with SMTP id
 cn24-20020a05690c0d1800b005c5b6aa55cdmr1428713ywb.14.1700172033597; Thu, 16
 Nov 2023 14:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-6-sui.jingfeng@linux.dev> <CAA8EJprkDpjuHEi5R01p4XNvFBr94BvXhr7AZCLr6dC8Mk=yPw@mail.gmail.com>
 <7602cd83-0e05-4e11-9bd1-10eb1d48a507@linux.dev> <CAA8EJprFjdrQtegJd5HyzGYQaMawwQOhvkE=SNqsdsBCrtfDTA@mail.gmail.com>
 <cc1bee15-f69f-4467-873d-c85cc09d60a0@linux.dev>
In-Reply-To: <cc1bee15-f69f-4467-873d-c85cc09d60a0@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 17 Nov 2023 00:00:22 +0200
Message-ID: <CAA8EJpokXj+fr99_kUOXpfMcoRPrXYaJn0m2GCm2h6HUuMDriA@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/bridge: it66121: Add a helper function to read
 chip id
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 20:29, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2023/11/16 21:00, Dmitry Baryshkov wrote:
> > On Thu, 16 Nov 2023 at 14:18, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> >> Hi,
> >>
> >>
> >> On 2023/11/15 00:06, Dmitry Baryshkov wrote:
> >>> On Tue, 14 Nov 2023 at 17:09, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> >>>> From: Sui Jingfeng <suijingfeng@loongson.cn>
> >>>>
> >>>> Read the required chip id data back by calling regmap_bulk_read() once,
> >>>> reduce the number of local variables needed in it66121_probe() function.
> >>>> And store its values into struct it66121_ctx, as it will be used latter.
> >>>>
> >>>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> >>>> ---
> >>>>    drivers/gpu/drm/bridge/ite-it66121.c | 47 ++++++++++++++++++++--------
> >>>>    1 file changed, 34 insertions(+), 13 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> >>>> index 7e473beefc79..f36d05331f25 100644
> >>>> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> >>>> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> >>>> @@ -313,6 +313,9 @@ struct it66121_ctx {
> >>>>                   bool auto_cts;
> >>>>           } audio;
> >>>>           const struct it66121_chip_info *info;
> >>>> +       u16 vender_id;
> >>>> +       u16 device_id;
> >>>> +       u8 revision;
> >>> There is no need to store them, they are not used by the driver anywhere.
> >>>
> >>>>    };
> >>>>
> >>>>    static inline struct it66121_ctx *bridge_to_it66121(struct drm_bridge *bridge)
> >>>> @@ -399,6 +402,30 @@ static void it66121_hw_reset(struct it66121_ctx *ctx)
> >>>>           gpiod_set_value(ctx->gpio_reset, 0);
> >>>>    }
> >>>>
> >>>> +static int it66121_read_chip_id(struct it66121_ctx *ctx, bool verbose)
> >>>> +{
> >>>> +       u8 id[4];
> >>>> +       int ret;
> >>>> +
> >>>> +       ret = regmap_bulk_read(ctx->regmap, IT66121_VENDOR_ID0_REG, id, 4);
> >>>> +       if (ret < 0) {
> >>>> +               dev_err(ctx->dev, "Failed to read chip ID: %d\n", ret);
> >>>> +               return ret;
> >>>> +       }
> >>>> +
> >>>> +       ctx->vender_id = (u16)id[1] << 8 | id[0];
> >>>> +       ctx->device_id = ((u16)(id[3] & IT66121_DEVICE_ID1_MASK) << 8 | id[2]);
> >>>> +       /* Revision is shared with DEVICE_ID1 */
> >>>> +       ctx->revision = FIELD_GET(IT66121_REVISION_MASK, id[3]);
> >>>> +
> >>>> +       if (verbose) {
> >>>> +               dev_info(ctx->dev, "Found ITE66121: 0x%x%x, revision: %u\n",
> >>>> +                        ctx->vender_id, ctx->device_id, ctx->revision);
> >>>> +       }
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>>    static inline int it66121_preamble_ddc(struct it66121_ctx *ctx)
> >>>>    {
> >>>>           return regmap_write(ctx->regmap, IT66121_MASTER_SEL_REG, IT66121_MASTER_SEL_HOST);
> >>>> @@ -1561,7 +1588,6 @@ static const char * const it66121_supplies[] = {
> >>>>
> >>>>    static int it66121_probe(struct i2c_client *client)
> >>>>    {
> >>>> -       u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
> >>>>           int ret;
> >>>>           struct it66121_ctx *ctx;
> >>>>           struct device *dev = &client->dev;
> >>>> @@ -1603,19 +1629,13 @@ static int it66121_probe(struct i2c_client *client)
> >>>>           if (IS_ERR(ctx->regmap))
> >>>>                   return PTR_ERR(ctx->regmap);
> >>>>
> >>>> -       regmap_read(ctx->regmap, IT66121_VENDOR_ID0_REG, &vendor_ids[0]);
> >>>> -       regmap_read(ctx->regmap, IT66121_VENDOR_ID1_REG, &vendor_ids[1]);
> >>>> -       regmap_read(ctx->regmap, IT66121_DEVICE_ID0_REG, &device_ids[0]);
> >>>> -       regmap_read(ctx->regmap, IT66121_DEVICE_ID1_REG, &device_ids[1]);
> >>>> -
> >>>> -       /* Revision is shared with DEVICE_ID1 */
> >>>> -       revision_id = FIELD_GET(IT66121_REVISION_MASK, device_ids[1]);
> >>>> -       device_ids[1] &= IT66121_DEVICE_ID1_MASK;
> >>>> +       ret = it66121_read_chip_id(ctx, false);
> >>>> +       if (ret)
> >>>> +               return ret;
> >>>>
> >>>> -       if ((vendor_ids[1] << 8 | vendor_ids[0]) != ctx->info->vid ||
> >>>> -           (device_ids[1] << 8 | device_ids[0]) != ctx->info->pid) {
> >>>> +       if (ctx->vender_id != ctx->info->vid ||
> >>>> +           ctx->device_id != ctx->info->pid)
> >> Q: There is no need to store them, they are not used by the driver anywhere.
> >>
> >> A: Here it is used, it is also used by the 0007-patch to get the entity(instance)-specific data.
> > And the patch 7 will be changed once you have proper i2c client struct
> > registered.
> >
> We will create a "wrong"i2c client intentionally by calling i2c_new_client_device, the "wrong"
> here means that 'board_info.type'  is not equal to "it66121" or "it6610".
>
> I probably know what you means, but please note that we are not object you at here.
> The reason why we prefer theit66121_get_match_data() over the i2c_get_match_data() is that our
> it66121_get_match_data()  works with *the least dependency*. Ourversion
> don't rely on the DT to provide compatible strings. Because the it66121 itself already
> provided constant hard-coded vender id and device id on-chip register. This is a bit
> similar with the PCIe devices. This chip id speak everything about chip identify.
> By re-arranging the variants into array, searching and matching against became
> straight-forward. We can also utilize the vender id and device id information to
> dynamic bind the instance specific functions *at the setup(probe) time*. Which helps
> to untangle the it66121 and it6610 cases with function object. Currently they are
> tangled. This is not a problem simply because the model supported is too small(less).

The difference is that PCI or USB are discoverable buses, but I2C and
SPI are not.
The kernel tends to use generic mechanisms if possible. And for the
I2C / SPI buses the generic mechanism is match data.
What you are doing is nice if there was just the it66121 driver.
However there is more than that. Many more drivers. And the generic
approach becomes important, as it helps other developers to work with
better efficiency.

> >> Since it6610 was introduced, this is used for chip identifying.
> >> It can also be used with in debugfs context, to show who I am.
> > I'd say, there is little point in whoami debugfs files. Debugfs is for
> > the useful information.
> >
> >>
> >>>>                   return -ENODEV;
> >>>> -       }
> >>>>
> >>>>           ctx->bridge.funcs = &it66121_bridge_funcs;
> >>>>           ctx->bridge.of_node = dev->of_node;
> >>>> @@ -1633,7 +1653,8 @@ static int it66121_probe(struct i2c_client *client)
> >>>>
> >>>>           drm_bridge_add(&ctx->bridge);
> >>>>
> >>>> -       dev_info(dev, "IT66121 revision %d probed\n", revision_id);
> >>>> +       dev_info(dev, "IT66121 probed, chip id: 0x%x:0x%x, revision: %u\n",
> >>>> +                ctx->vender_id, ctx->device_id, ctx->revision);
> >>>>
> >>>>           return 0;
> >>>>    }
> >>>> --
> >>>> 2.34.1
> >>>>
> >
> >



-- 
With best wishes
Dmitry
