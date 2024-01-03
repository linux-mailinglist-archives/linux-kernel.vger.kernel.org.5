Return-Path: <linux-kernel+bounces-15441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CF2822C0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61421F2408D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C8018E24;
	Wed,  3 Jan 2024 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBGLCzgj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59218E0D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-466f045f8f7so1114527137.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 03:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704281190; x=1704885990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v7CrUQz2n63sCzo01/tfVMXNbvtKyfNTPMwm4goGgtQ=;
        b=DBGLCzgjcS0sP5s/erOcK0SveN3atLa6KFHtP6rEieNd74yGn0T0X3Tz2z7LMDfRK9
         FpXkPi0/X9wILguli/CRP5dTP2YymPk4PaElM9DrMo/qWKa1Dyr7XJb0dhRyX50/Yy3s
         sloXcYdMdiHSq/kJiRBMXspjiQiKWOlbkmtq+tua8Z38+DidZQZulEP37lvca+7+ECQx
         V6W2/NIz9AtWMLnyZj1aVUW7bcRsEqvJt3J/Zb+0Tx4Ok7nmtMzPP9DIw9jwRtj2BPWU
         2RqYdyH7+j2J4oPWmnMEHHVBR4/H7747FL8C8ztRaIFsbfPkbCanCtFKduKgomEK6Vkw
         4YmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704281190; x=1704885990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7CrUQz2n63sCzo01/tfVMXNbvtKyfNTPMwm4goGgtQ=;
        b=O2GHcDT6E4NdfqT+EcLGtUqUgrZ2aR1fjDn5lwMYhzEdH+zzDQAQgSeZw7hGpVV4tL
         2I1ED3pTzH2frBQ4TsLMe7B0ykU8DPhwhf+x2UV1bSGERKC9u7HJpQXj4WE6MmmP95BP
         CKwTnjkQNyrj76HZL8tv5VobRVhDXf5Q4EYh7qT+oUlRcUFalCd6zoLA7D+UJA6mnYoM
         XJ1Ab/GdP5ausedW2x3ayWmBgOGO3ieo2r9LJKxkwU6680I2xlc6WDdy/VpMm9EEJa76
         r/CH3EcLYYW8wEhwdY3LcPziOyybrDc/Uow4WrLTz6DnfX2iAqqF+ZjlO7zIehlF6d1d
         7sig==
X-Gm-Message-State: AOJu0Ywac98wzQmDLV9v2dUvNHYyrRBDhWw8WHmTr1psRSN607453uWS
	MzlH3EcZ7+LXEZN97ySo01mAzFLx9BAKypprJvJp2y4V1VRB
X-Google-Smtp-Source: AGHT+IF5qJ/vknXBg/8siMl87CIG4EDyI5NtIbNS80aWJ0TcxwEf2/T+8DUMZ5etsq1xCKB3ivIeAsghCg2v+USflHo=
X-Received: by 2002:a05:6102:3f8d:b0:467:951e:162b with SMTP id
 o13-20020a0561023f8d00b00467951e162bmr1196128vsv.28.1704281190494; Wed, 03
 Jan 2024 03:26:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103090241.164817-1-pierre.gondois@arm.com>
In-Reply-To: <20240103090241.164817-1-pierre.gondois@arm.com>
From: Marco Elver <elver@google.com>
Date: Wed, 3 Jan 2024 12:25:51 +0100
Message-ID: <CANpmjNPsBUJy6tkOdRSJyWrS9CMUOQhQyb7_hwmw68pjjiEDWQ@mail.gmail.com>
Subject: Re: [PATCH] list: Add hlist_count_nodes()
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Jani Nikula <jani.nikula@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 10:02, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Add a function to count nodes in a hlist. hlist_count_nodes()
> is similar to list_count_nodes().
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Is this patch part of another patch series? As-is, this will be dead
code, and there's no guarantee someone will just go and delete it in
future. Although this function looks useful, we also should avoid
adding new dead code.

> ---
>  include/linux/list.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 1837caedf723..0f1b1d4a2e2e 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -1175,4 +1175,19 @@ static inline void hlist_move_list(struct hlist_head *old,
>              pos && ({ n = pos->member.next; 1; });                     \
>              pos = hlist_entry_safe(n, typeof(*pos), member))
>
> +/**
> + * hlist_count_nodes - count nodes in the hlist
> + * @head:      the head for your hlist.
> + */
> +static inline size_t hlist_count_nodes(struct hlist_head *head)
> +{
> +       struct hlist_node *pos;
> +       size_t count = 0;
> +
> +       hlist_for_each(pos, head)
> +               count++;
> +
> +       return count;
> +}
> +
>  #endif
> --
> 2.25.1
>

