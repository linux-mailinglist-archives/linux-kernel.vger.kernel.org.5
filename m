Return-Path: <linux-kernel+bounces-139064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FA289FE0A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D6E289B28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CC617BB3F;
	Wed, 10 Apr 2024 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ly86b8vz"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048DA17BB0A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769218; cv=none; b=cH/9paUfP4knQWKofk4s5AsxKE87e7E1uQzyEC+BCWEt9YStn9MCG4FmkajkLurMPI/ZMDPftGFhGKZIxowwA9Vys+0L+6IrPIU3f8JIFlv0qRc214gDG+bHalPDZw7A948UVqiOUp1cW4yhO61v4yYYpv9yMTxiq+LgZYF2Oms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769218; c=relaxed/simple;
	bh=2dxA21IicR5QXRGdbat2ecJe4iRi/T+diYzMzktSDfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwkb47XVJXaGqgmQSeHqeu1OPxp3cWH2MVeGQWZno+viWSVBZjafqAoSR3mtcpXhs5ztHqFAR8zMyRO1ZEwUzDSajNVovtLLvRMkpMgarvUfG38z6IgOhqIit99FP++WRXhGRx48V2eMqiXP6Wsr45gT71pJXp/T+RagHKtRCJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ly86b8vz; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so7139047276.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712769216; x=1713374016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LoiFbRr56FQyHTjxgBjvyL+ztMVJn3XIX4iUKlBJvfw=;
        b=Ly86b8vzCFj6XvXBkkYWYfsl14l28eGPNk2fUi/5/0d+4xYEOKI795UdEpb26KSZvK
         ybbvtumBoSgbuqxyAMbp7xhEtwExbj2l1qtkGjH8mg7Ug2AcN2/09LD/jSk/V/+yBA+O
         Hngui93ao6gjV9s/41tmENQ5IyaxHU5qU83iM0vBIN+Pnf3rvv0kUCeDdLSXDbNCNhpB
         iXOH9CRyvK+zP6mUAxJLMPsq7+6n8swD74mWicjiIQtV//ZmvCmSSRCfhkPXdUU3JZr+
         m4ohIHjWNkdd7hMc0ta5LCWYYGpMCdILvm9hGGxLxh/XiE/C9sTJpoFNbcrN5aL6X9ZC
         NuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712769216; x=1713374016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoiFbRr56FQyHTjxgBjvyL+ztMVJn3XIX4iUKlBJvfw=;
        b=V24GpQ/CGh/OKtHpMb3RSqBjS1KOBUjqKTDArddgRwT6IhILnK7O3L7jy5hx7cY/J1
         veY+lhcnZ92jj74hpC8BayeoV1nc/OWoc3dPvfR9/07SSKbnHu+k5nIlJb3Vpbfv8stp
         Q7HpisvK+X3KhqaDjPLigTuEf4zGGtSX9mjUp7PAfZTbp9N2mu/3Ug0xW18eqmu2bTmo
         glXmORBKkqlVfMLoBoQ6PWE8SBjFS+9sTZ+GOG2VmN/P5dW1MKXuZ3IHmg+Mm2DsY2Ag
         TcVigI1iypMKKlZv4nZMcg7z8z3kdD3g9/UXNoI6y8r+62MXN6dD3pt6dl9xp6vS5pD3
         fXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw1K5ytjMpgIYrx0kTceKO5kE3mkYjdoHV6LVVu1oQyIk1QYkE+giXSAF4ir+NZa6GUom3AVXTvgywg3kthSqoKkd1qGavLVdSFznr
X-Gm-Message-State: AOJu0YxDrbInTXwCzBiczpfQazgvcUVw+OQIZ/EtEwVWx0zBzKjdzBbe
	2/4iAhruVcpdb5jySJ3PRMtfkHAm5GgNXk1sA9gQPuP3yu2gtYmaUuPoIVdjUGmMUzeog2Mnx7k
	tkJKf/iVD1fmMYbYxbzqt74LWVquwBGnrGuaK5w==
X-Google-Smtp-Source: AGHT+IHU6fdcr8xJ013lQ/5yyMWN8QKmw/hU/MbiTWMn4p5uKfhrV5W/9HZhKNADjx3rhTTgmrbpEIWru1PRyoEyi54=
X-Received: by 2002:a25:bc4d:0:b0:dcd:1854:9f43 with SMTP id
 d13-20020a25bc4d000000b00dcd18549f43mr3076283ybk.3.1712769215940; Wed, 10 Apr
 2024 10:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410165222.5192-1-prosunofficial@gmail.com>
In-Reply-To: <20240410165222.5192-1-prosunofficial@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 10 Apr 2024 20:13:24 +0300
Message-ID: <CAA8EJppfzXEzzrQ_11O94MVn2dhcF2kGd9RR8ctJ1GmK=6C+ZQ@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: mux: replace of_node_put() with __free [linux-next]
To: R SUNDAR <prosunofficial@gmail.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	neil.armstrong@linaro.org, christophe.jaillet@wanadoo.fr, 
	u.kleine-koenig@pengutronix.de, skhan@linuxfoundation.org, 
	javier.carrasco.cruz@gmail.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 19:52, R SUNDAR <prosunofficial@gmail.com> wrote:
>
> use the new cleanup magic to replace of_node_put() with
> __free(device_node) marking to auto release and to simplify the error
> paths.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
> ---
>  drivers/usb/typec/mux/nb7vpq904m.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
> index b17826713753..72ec9ef3ac58 100644
> --- a/drivers/usb/typec/mux/nb7vpq904m.c
> +++ b/drivers/usb/typec/mux/nb7vpq904m.c
> @@ -315,29 +315,27 @@ static const int supported_data_lane_mapping[][DATA_LANES_COUNT] = {
>
>  static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
>  {
> -       struct device_node *ep;
>         u32 data_lanes[4];
>         int ret, i, j;
> -
> -       ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
> +       struct device_node *ep __free(device_node) =
> +               of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);

Please stick this to the top of the function. Otherwise LGTM.

>
>         if (ep) {
>                 ret = of_property_count_u32_elems(ep, "data-lanes");
>                 if (ret == -EINVAL)
>                         /* Property isn't here, consider default mapping */
> -                       goto out_done;
> +                       return 0;
>                 if (ret < 0)
> -                       goto out_error;
> +                       return ret;
>
>                 if (ret != DATA_LANES_COUNT) {
>                         dev_err(&nb7->client->dev, "expected 4 data lanes\n");
> -                       ret = -EINVAL;
> -                       goto out_error;
> +                       return -EINVAL;
>                 }
>
>                 ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
>                 if (ret)
> -                       goto out_error;
> +                       return ret;
>
>                 for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
>                         for (j = 0; j < DATA_LANES_COUNT; j++) {
> @@ -358,18 +356,11 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
>                         break;
>                 default:
>                         dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
> -                       ret = -EINVAL;
> -                       goto out_error;
> +                       return -EINVAL;
>                 }
>         }
>
> -out_done:
> -       ret = 0;
> -
> -out_error:
> -       of_node_put(ep);
> -
> -       return ret;
> +       return 0;
>  }
>
>  static int nb7vpq904m_probe(struct i2c_client *client)
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

