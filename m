Return-Path: <linux-kernel+bounces-94185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E7A873B0A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B722855CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3063A1361D3;
	Wed,  6 Mar 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtV/cuRw"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E750E13175F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739875; cv=none; b=TEQyQabrtz2BTQRaTGW5zUmWrLy8noqBOgLbCRv0sWjSuAlyG8qXx2mpU+sw7OxSjLQ1bvAZi6RXHFviyuU4P31oNhpytqHv1x4Oz0aM7Jy1eiU1CS5cbgXYSb08G0M1OsHtEGiqyZgB2D0KO3HPAi4HBSq29u37C5OcxS/LETk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739875; c=relaxed/simple;
	bh=fy3hqPPtFleijSb5Uq92VFf00vojXkST46ntWh1Qq0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCspjZtXTy5OfqseGXQbSZ7Drl9/hWMyMCIzymAT5hYnaX6gEGGIAXejTp1rFoEJM51K1Uavo7Z/E97fbhvmkWCsfUZVKJY/w3UkZhkrKHts8LF7SwwB1NC1uNEwNc7dZFG/B2S11qIm9UClF+hbRXZQMcIVmNRk/JHxkoDgeLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xtV/cuRw; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so6278295a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709739873; x=1710344673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4GTEQwM/YBhR8th/Bxd4bpNmbVxmzOwpK9LNFUE5Vk4=;
        b=xtV/cuRwi0tFhIUuxrRsmEpArd+viPDJnnPg6HLpEJiVi+CSA9SceY4x53Crri0cUX
         OOioWlrVv2S6st8FiqPlI5K61FqQ6YnijCzp1sonPjlD9C70T5ulnm3Tjn/ukqpwnj1L
         HnH7TDTBrmDekFF1waiSCba3lv+LjQK66HxcTujXXq28D2kOhIziARkL8t+NVNEoKy1L
         cSkRjEcUw0Q8s3+MvikXIT8zxU0FlKHQHL9p5hPrKvGQnY6UJQe4xke4tdEFFVXO/5BE
         aw6o2+KOWgRG4d/6xG3QyMpSoBPwIaRnMUb2Z0Y3C/+oJJ4nn32uQ3dZPTgr7LPZ50k7
         xDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739873; x=1710344673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GTEQwM/YBhR8th/Bxd4bpNmbVxmzOwpK9LNFUE5Vk4=;
        b=Uaf2peZEpmazrNfN0SYK6P1pfwevx9UN+Nq4bFvdwbfc4DY/htaqbfJ4iwwkFhDAyN
         40FVRvLOMSU217V7tawR1t26d2eQ5Y0xVXQNIjRaroVefvcfqvm50dn1ORB+Enw1W+MG
         gOle2nAh0TOOhgxQSDyv0I3jVpMdWWpl6y6GglYjaMRLCD+fj7IbGvAtJQ/5RxB/BNdg
         qEPKqWgyFJ9X6kNb9tJpYC7EvCZLEusKB4Qsiuzu9pihO2inBrrsI4p7Nl2gLAZcgdEa
         IZS9SieZVXQ8jyQYlM9ufXwHd0sFznjZzn1JU8ffcIzkf8LBYHznJkey8Pz62ED5nBuO
         XU4Q==
X-Gm-Message-State: AOJu0YypPvbsfIN5fVFiAANHrsQQGEsVnx5Me//KO4QcoKg9gwHlSwmw
	GGKPJxuM4jSSi6VKfWc8h4fc+OxK0gxD9Fj2YUbZFv9bzCivjlOp38Oiv4b+BxOaY3p64fI9OOX
	gGyq+35EZeOHLAa8CJck/fMNRV+CBkISVAA5pmQ==
X-Google-Smtp-Source: AGHT+IEKhURjpbpHGzpdESWS0FfkOUbCcWPpQepL+OGNHo54YuaIt3b2OroBL+hMUx1Es5TrHK1Ew3J4/1GOckD5p+E=
X-Received: by 2002:a17:90a:6b82:b0:29b:8134:5bc9 with SMTP id
 w2-20020a17090a6b8200b0029b81345bc9mr415677pjj.29.1709739873094; Wed, 06 Mar
 2024 07:44:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304094831.3639338-1-mingo@kernel.org> <20240304094831.3639338-5-mingo@kernel.org>
In-Reply-To: <20240304094831.3639338-5-mingo@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 6 Mar 2024 16:44:22 +0100
Message-ID: <CAKfTPtCHVkZudjwzErGvm+LboB39shN_rOVLXMMusEkdXAk0aw@mail.gmail.com>
Subject: Re: [PATCH 4/9] sched/balancing: Change comment formatting to not
 overlap Git conflict marker lines
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 10:48, Ingo Molnar <mingo@kernel.org> wrote:
>
> So the scheduler has two such comment blocks, with '=' used as a double underline:
>
>         /*
>          * VRUNTIME
>          * ========
>          *
>
> '========' also happens to be a Git conflict marker, throwing off a simple
> search in an editor for this pattern.
>
> Change them to '-------' type of underline instead - it looks just as good.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f11fc6dd39b1..934ace69eb30 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3679,7 +3679,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
>
>         /*
>          * VRUNTIME
> -        * ========
> +        * --------
>          *
>          * COROLLARY #1: The virtual runtime of the entity needs to be
>          * adjusted if re-weight at !0-lag point.
> @@ -3762,7 +3762,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
>
>         /*
>          * DEADLINE
> -        * ========
> +        * --------
>          *
>          * When the weight changes, the virtual time slope changes and
>          * we should adjust the relative virtual deadline accordingly.
> --
> 2.40.1
>

