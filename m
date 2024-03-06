Return-Path: <linux-kernel+bounces-94505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04668740C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC21E28673B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D74914036A;
	Wed,  6 Mar 2024 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yro2YoIx"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410113E7DB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754576; cv=none; b=qiWDi8R2ymEqc9NQv+Gz+x/kSRUkqI47xm99Pzidd8LXLr2AXuLyEA0ErYkKxNxNNkjTop24hPeUvzqkpB5WQWy8WQqWkxqbiMfFMk//qTErCjyjCTCSGdNpSgFWYELVNYjyx8No4UbMmWWST6IbPyxeAjNF7OohT5zTykL72ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754576; c=relaxed/simple;
	bh=nPlyaesjYNbkV2scuIPLuOkf3mna0HTcvu1bn+dY8YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EN0EOZWBWySIHs04ZU6Q7zOiEUKZXINIXE1SpMMO9Ofejgv59noRA54mRcJeBGOctUjnRKGSSRQMIX3pZNNTwwtlLyJAjfwxRQlKxawwYNbZkO43aoNuPFPiDjR7jiw9FUokCY9BiSLgQTWcGeapFo/vIxq31CIY4dbASGawa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yro2YoIx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-608ccac1899so1397587b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709754574; x=1710359374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPlyaesjYNbkV2scuIPLuOkf3mna0HTcvu1bn+dY8YI=;
        b=Yro2YoIxVHiCUZZqMZDh7Vr3vscV+8B6DQ7IKlmr19lRxBaYtcSxKoWbO0k0CgaO1s
         KSUuDORKC92XCwxtV7sv5hpRRd0fbVnpj8MFsbIYgSC9/TQ0B9Pl/fz3yHXbfiW15jR+
         svnOfGaQnFWopnVSrmpwmYailosH76Qg1dq0rlxkDF92UNiM+bbmnVJmlshqJPfmzW8K
         5amp/eVG4vLeukWPqoYzw8CMfiXdpohgmU8cnqnOIoTypNPQ66Vy/jxV3zRAGyMlIzHJ
         z3xaS4RNHAfpdko42h6iUVLnZ/t/09AGUDvazF2SUXnjvcHpFnknc2zvDIhZKRtCpwmf
         Hypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754574; x=1710359374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPlyaesjYNbkV2scuIPLuOkf3mna0HTcvu1bn+dY8YI=;
        b=kFvT/T0DNP2OgaI55nh8yatxd/e/xn36rZjQSGiF1qu9obPXjNBNRfssULBFxl7/FA
         FV+FLtzx/VZWPi+nzRAiWfbUpgVwtiVhPk5z0vYjq+Za40IHrhzusUp28XBZwxz++r/D
         VWAc6/lEMWAc86aH1ngByIjwja24HI9U88PcH4HcYLcRJdSYkg0LDp0LGCFPqbGGs9OX
         NFg+wrTCWjD+aVXkk1MK4RUrzHpD+kvIBKo06HXOG0ZYJBybAie6FscWdzrwM5WoI8yI
         VqZxFG6cqEBk17LlsEfU6FzZEicF26syxJKH4AFYuVD2nEqT3i034tyzx7Yoqc5cxG9P
         CLcg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Xa2om5AcMMQjNQLGHALXlgdA5SPHmw6BNG/JvNmprqC1ZVfepzJDM0Yuoool3oYHnBHwh22j4/BeruXOuMUe+LWcTUItJ2vb+QWB
X-Gm-Message-State: AOJu0Yx9c0ZPZpQwiRQHGuIUS7BI3kj/JIaEH44cwuJmo3fbFovkbYd6
	GJcyq+VEU8OwPoULJa3BHo3S32CjBzVZ5xYAI13TrjDCIvbATp5GE7gb7P8q6t7YLNy+1A8dgX3
	2bRBRcIzcEBTuJsnSFfKpUaKb0gsjsgQ0ECtEkA==
X-Google-Smtp-Source: AGHT+IHxsHr/alraTiTEqBEIabc4AtN/z3ZG5Fo2cAVhC41CbFpwoSrEAqQlrDjlml+vAdN3ScgmBzzdVF0/UxuJffI=
X-Received: by 2002:a0d:d4c5:0:b0:609:dbbc:451b with SMTP id
 w188-20020a0dd4c5000000b00609dbbc451bmr2705058ywd.23.1709754574622; Wed, 06
 Mar 2024 11:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
 <Zegx5PCtg6hs8zyp@trax> <CACRpkdYZrDgVVCp2bqJqY1BpeHSXDWbRSqk6d=N_QhC4OVv=Ew@mail.gmail.com>
 <Zeh8HGDToMoHglD2@trax> <CACRpkdZ1ervTXj6++oBPDNJT3TpVgPeYsyhaEMRYavJQ5iZPqg@mail.gmail.com>
 <CAPDyKFqYDPgNjSkpH=XATkUY2XtjsaDstChcAnGxoas4jgDVfw@mail.gmail.com>
In-Reply-To: <CAPDyKFqYDPgNjSkpH=XATkUY2XtjsaDstChcAnGxoas4jgDVfw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 20:49:23 +0100
Message-ID: <CACRpkdaUUD8UMp9GxNVQfdAM8QV_LASp-k5hh1cvQrGVHKySKA@mail.gmail.com>
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Tomas Winkler <tomas.winkler@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 4:57=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
> On Wed, 6 Mar 2024 at 15:38, Linus Walleij <linus.walleij@linaro.org> wro=
te:

> > We should probably rename it part_cfg because that is what we
> > store in it, it's assigned from card->part[idx].part_cfg.
> >
> > Then the id field in mmc_rpmb_data should be deleted along
> > with all the IDA counter code etc and the partition name hardcoded
> > to be "0" as there will never be anything else.
>
> Seems reasonable to me. Are you thinking of sending a cleanup patch on
> top of $subject patch?

Yes I can do that once this patch is finalized and merged.

Yours,
Linus Walleij

