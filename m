Return-Path: <linux-kernel+bounces-152375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC948ABD17
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 22:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153501C208BD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4375347F41;
	Sat, 20 Apr 2024 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6bC9itG"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96B205E36
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713646059; cv=none; b=orsBRTTHD33gKCO/AEkHbqrvchv1DbDjmFlVjkWXdqC9DrafB2UgmAPcYaPfcWHc5f1mPD+L7OAykQk2XSxy+W/54/AKNh7ukUZYvj4M621G8aFhdV9GgrA/e8LVybun1EU3ZXfXyaCWPgGPQ771GP6BvaLExlf/tSsDvGxuXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713646059; c=relaxed/simple;
	bh=nAX4qtsNUWhy1uiAgeSRQF1UqmwuPnkAS2XUGJmyi4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqkIplXWHrXGElrBAdqHV3B9RU2s/fXKXX/lsmLgm9q8yMq1126SJz9oI9b6zdnDnbq+pkcj5JcqA2Zo2TUV0sr+jnY2MguYchBjKNz7ST4BmegQJBT+Q/8lYTZg7qtfQAbUQWVWJmSMuvbOU3VBuZbTxr4MX+hUf7o3rnl/zEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M6bC9itG; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ed06982819so80359a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713646057; x=1714250857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kb/bevCZdlKe2zh21irqMcJQYjEy0O/ZCeu3ucaLGIQ=;
        b=M6bC9itGHIEIvgg7Rk3e+m6FR7UADyUUOfdwnC0xT+8EOzQ3SvhnFWkkP7nT1DaZn+
         XV/SQyjAxoGFW2rCpz8YDR9cu48+95zgTe1ZOLBy7/HG+gCwQAOca7Cs+4sJwjHesSX5
         4ASExXETyu/4/7UEgAzuTC0BhrIIeFKdbm+8fClUJEoL56j89Az2CiQWZchxeCftJ+9h
         dAq12ID49Ev9AZGeNIHSjZMEKVYHobBu/66ZYDNWExFaBKBULlToK9Rc5mFWdG4Z5vlo
         UK5Ep2D0R0vvc7b8tznICiJY6UIHwXFYRQx8DQwvRRj4cHIMA/YVI0DLz3sR+RQhxXkN
         imhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713646057; x=1714250857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kb/bevCZdlKe2zh21irqMcJQYjEy0O/ZCeu3ucaLGIQ=;
        b=aW6q3m1WEbplKix9jxvz2ncPlr/rWIw9517sOV+lwwCyCNbZGm91pIAwEonKK9LucX
         6vnw5K1MTnd4vt8Jswru2/E6g5lRS9+DZhdtYZmPi1LEQ160YyZS6wL/lrPgqlhgd5rg
         Nw39Aop9+90hLmuyr3QB/tBUrKAp2OU2O73uwmV4ZClEj/TZEVQh8VyL3+wIw7wfQFvh
         SmSyAtxNCJw0E6JgLu9uZ3IThM2LtBEuTEn9lfTZpMqdmy1fbyBdZRzBx6o1wVbbhg1K
         DqOCMUBjgvVgLovaASsynPPcPyfnu9yal4LTt9M8GBBdVvRyS3ZdtklDK9YTI8YdKDE+
         iWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqur3YPmXUVnKSjhKbD6ek0zgzGB0S0Yc+4y/dVEsrYj2ge9WT9xNTcNrAtsJ3NgVvIbdBiP9uamh2aagDpVG7FQodML3nkNItMKQx
X-Gm-Message-State: AOJu0YwhJHlEVkEqaxpRJdVk9Bs1lDFlTqUHX64aFz9XgAjUQ24pMZ3N
	/PV/SW5vYdOtpkziVnhg6V6UB0rOS/txPld5SBCqQBHpeEvAJo/rUswce/ki/n2irarObgf1DKP
	azY6ERKdYneLhBZ+7VsFd3zWirBgdC9bfjpEfBg==
X-Google-Smtp-Source: AGHT+IG262rt420pNwzY8AZsDmczVXNlMCTF70H6EVqdZNolfSDASIpwbTO50b8BEaku8NlH8ubL3mViPrkfZfXmm38=
X-Received: by 2002:a05:6808:10ca:b0:3c6:be9:f4f9 with SMTP id
 s10-20020a05680810ca00b003c60be9f4f9mr8118471ois.28.1713646056797; Sat, 20
 Apr 2024 13:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420164927.15290-1-prosunofficial@gmail.com>
In-Reply-To: <20240420164927.15290-1-prosunofficial@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 20 Apr 2024 23:47:25 +0300
Message-ID: <CAA8EJpqnZPVG6swW6T3YjG-ekinyYeif6SqardH0O_0puJn8Xg@mail.gmail.com>
Subject: Re: [PATCH v2] remove indentation for common path [linux-next]
To: sundar <prosunofficial@gmail.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	neil.armstrong@linaro.org, u.kleine-koenig@pengutronix.de, 
	christophe.jaillet@wanadoo.fr, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	javier.carrasco.cruz@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Apr 2024 at 19:49, sundar <prosunofficial@gmail.com> wrote:
>
> Added check if pointer is null and removed indentation for common path
>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: sundar <prosunofficial@gmail.com>
> ---
>
> Fixed nitpicks in code according to comments received on other patch.
>
> https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/
>
> goal is to get rid of of_node_put,but sending this patch first to do one
> thing at a time.
>
> Changes since v1 - fixed the typo error for spell from identation to
> indentation
>
> v1 patch link - https://lore.kernel.org/all/20240420145522.15018-1-prosunofficial@gmail.com/
>
>  drivers/usb/typec/mux/nb7vpq904m.c | 49 +++++++++++++++---------------
>  1 file changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
> index b17826713753..fe0257840dd5 100644
> --- a/drivers/usb/typec/mux/nb7vpq904m.c
> +++ b/drivers/usb/typec/mux/nb7vpq904m.c
> @@ -321,35 +321,37 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
>
>         ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
>
> -       if (ep) {
> -               ret = of_property_count_u32_elems(ep, "data-lanes");
> -               if (ret == -EINVAL)
> -                       /* Property isn't here, consider default mapping */
> -                       goto out_done;
> -               if (ret < 0)
> -                       goto out_error;
> -
> -               if (ret != DATA_LANES_COUNT) {
> -                       dev_err(&nb7->client->dev, "expected 4 data lanes\n");
> -                       ret = -EINVAL;
> -                       goto out_error;
> -               }
> +       if (!ep)
> +               return 0;
>
> -               ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
> -               if (ret)
> -                       goto out_error;
> +       ret = of_property_count_u32_elems(ep, "data-lanes");
> +       if (ret == -EINVAL)
> +               /* Property isn't here, consider default mapping */
> +               goto out_done;
> +       if (ret < 0)
> +               goto out_error;
> +
> +       if (ret != DATA_LANES_COUNT) {
> +               dev_err(&nb7->client->dev, "expected 4 data lanes\n");
> +               ret = -EINVAL;
> +               goto out_error;
> +       }
>
> -               for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
> -                       for (j = 0; j < DATA_LANES_COUNT; j++) {
> -                               if (data_lanes[j] != supported_data_lane_mapping[i][j])
> -                                       break;
> -                       }
> +       ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
> +       if (ret)
> +               goto out_error;
>
> -                       if (j == DATA_LANES_COUNT)
> +       for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
> +               for (j = 0; j < DATA_LANES_COUNT; j++) {
> +                       if (data_lanes[j] != supported_data_lane_mapping[i][j])
>                                 break;
>                 }
>
> -               switch (i) {
> +               if (j == DATA_LANES_COUNT)
> +                       break;
> +       }
> +
> +       switch (i) {
>                 case NORMAL_LANE_MAPPING:

switch-cases should also be shifted one level to the left, see
Documentation/process/coding-style.rst

>                         break;
>                 case INVERT_LANE_MAPPING:
> @@ -360,7 +362,6 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
>                         dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
>                         ret = -EINVAL;
>                         goto out_error;
> -               }
>         }
>
>  out_done:
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

