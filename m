Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2597C7F0135
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 17:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjKRQr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 11:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 11:47:26 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF106E0;
        Sat, 18 Nov 2023 08:47:23 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5c9169300caso5990867b3.2;
        Sat, 18 Nov 2023 08:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700326043; x=1700930843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc5iY++oK0EVkooDY6ElLmU2NXeGpGEobVkWGqYFYOY=;
        b=nA/+3o3XlClFnqyz43PNXC5RdSdZJMfw4cvUuFEHaTgffLmHH+SzjAkQNMRReCec2B
         4neRERDK7nMqGeiLmfiYOF4XF5rdwQAAUy8K3FVcjEq1+1JeO55hdRpxu80vjWDaVvba
         SfSF/Q1xMoi1rsUf/BmQdeadAX37s3FWqFBbq07vs7EeD7ChboTDvQZtX0XA/Jqqz3L4
         Ebah8Z6eV1OLb06tw/8Ki8/9y1dOYkH5cTw+im5n5zt/u1mSmCIphquzK3E6WnzME1kx
         T+EQsEyAuC8cwpebDB5COuJfHN+p4xy8BDlbU+nJGfbBU19hYCtCJNQk8y7IX0hOoP9q
         6efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700326043; x=1700930843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wc5iY++oK0EVkooDY6ElLmU2NXeGpGEobVkWGqYFYOY=;
        b=E6ByceA7hh8j+EkGjNfkqHcdhkZfQurxq4BHWIk3M0TEJWezbvGgsam6ljG6lxrmzc
         lxrYPfg9XvIPqTWVG/gnuc1qUHYlAiuPfzXE/+L18gxvYFIIFbeDgaFovfPCoBMa2cW6
         Liu9YIanuOhPz0nKEaLueQ8cgAmgwglfmRf3T2vQe6QhPvxAZ2ObHQkaBAE4nT9YpHJh
         9sDjLJnShEdtwEC95DkAoBaivXVBVEHHhTdcYSXymrIUaw7CxHBrbN+k7dbkZB0j2QeT
         u8Sr6NsMNVMLTCO5sFip8/byCbIW6MODxUzfyik2idpumYJHncw7Epq7BwWLaY88aB70
         3CkA==
X-Gm-Message-State: AOJu0Yzp0NV0E8zzmTbNIfdfRimKv2ydILgOcIIGQ1JnrIjzBplU6vgs
        aphsbBn2Zr8aG62iLDYRhRpvpLTAIDmJ+pNAn2QoA4j+IKQ=
X-Google-Smtp-Source: AGHT+IFLfT+GCO3PNsz8qgZwUHjSmGMuS1fLvWXPX2aNLZswe9JssRj0JNz9IEu7QD/5YT46sNGpcnrFLDqKUhbbwbE=
X-Received: by 2002:a81:4f06:0:b0:589:8b55:f7f7 with SMTP id
 d6-20020a814f06000000b005898b55f7f7mr2798636ywb.39.1700326042865; Sat, 18 Nov
 2023 08:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20231101142445.8753-1-ddrokosov@salutedevices.com> <20231101142445.8753-5-ddrokosov@salutedevices.com>
In-Reply-To: <20231101142445.8753-5-ddrokosov@salutedevices.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Nov 2023 18:46:45 +0200
Message-ID: <CAHp75VcZ9JN2Ah3z8fDwdFNzts330Dccs0UYUx07KZ8_dV4aaQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] leds: aw200xx: calculate dts property
 display_rows in the driver
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        kernel@sberdevices.ru, rockosov@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org,
        George Stark <gnstark@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 1, 2023 at 4:24=E2=80=AFPM Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> From: George Stark <gnstark@salutedevices.com>
>
> Get rid of device tree property "awinic,display-rows". The property
> value actually means number of current switches and depends on how leds
> are connected to the device. It should be calculated manually by max
> used led number. In the same way it is computed automatically now.
> Max used led is taken from led definition subnodes.

...

> +static bool aw200xx_probe_get_display_rows(struct device *dev, struct aw=
200xx *chip)
> +{
> +       struct fwnode_handle *child;
> +       u32 max_source =3D 0;
> +
> +       device_for_each_child_node(dev, child) {
> +               u32 source;
> +               int ret;
> +
> +               ret =3D fwnode_property_read_u32(child, "reg", &source);
> +               if (ret || source >=3D chip->cdef->channels)
> +                       continue;
> +
> +               max_source =3D max(max_source, source);
> +       }

> +       chip->display_rows =3D max_source / chip->cdef->display_size_colu=
mns + 1;
> +       return !!chip->display_rows;

This is a bit weird. Can we rewrite it as

  if (max_source =3D=3D 0)
    return false;

  ->display_rows =3D ...
  return true;

?

> +}


--=20
With Best Regards,
Andy Shevchenko
