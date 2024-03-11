Return-Path: <linux-kernel+bounces-98742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0762877EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E255D1C21110
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A026939863;
	Mon, 11 Mar 2024 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljewefZt"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B52F55;
	Mon, 11 Mar 2024 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710155486; cv=none; b=MhOsQ+jYtgBj4gqw9NVbsI/MmYk7e/uU/1gha5UbzahrdzP3IHcIERGatCkSRb6onbrQcyv9MkpbYDQvTnFKlOOMMvhJOQnmaNComxvQDIVScmKwrnLXa+WFd0asrkgZmc6N2MvVHECEoee/AB6Us5pneeqI4Uhp8XhwZUHDWlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710155486; c=relaxed/simple;
	bh=XRuEb5oNxuILVmXpDBJ4dFKyOTuSJjmVSc84Jl5hgzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIn+OzvHynbPQb70JB6tMWeyKOUGvPkpclqOKmZhjG17ueBEnFMKwZRc7Cn9Z1nIi6HJhMXMKtZzb4Cw3utmcfRn1M86OSJYROGqD3Y0N97h/7Ygv4f3FpLCBVDQWR7xWZwktaoxn2tomPv+hKSP9iJwXyExCgLsZkxYnXl+lK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljewefZt; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21eea6aab5eso2684380fac.0;
        Mon, 11 Mar 2024 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710155483; x=1710760283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRuEb5oNxuILVmXpDBJ4dFKyOTuSJjmVSc84Jl5hgzk=;
        b=ljewefZtk2U9D95KFotdcn3wBtn9Xm106wLA3BZxnChK6eOW1oNocOF88GHR2xRnCO
         VW0mM34msQEzLGeEcLti4yNSqqbsv4pPJqWWH8vuDoJ+Gh2evl7WjDP9AMGiKKTYtRia
         ofQdBHTzGurkisqsf2Qm1NKgZGeEIp3GDUKmo3vOEW+c91NUuggvIdO0Wdy0rBTNd2Si
         CQ7G33CO7R0qqE5RTo3lI3kSrSN9Y1X/4Y2hxTxsERs14zH2Ad5a5dtgmYy4l1Ksz9qL
         ojWDGTsA1uo9nuByAZD/AuGmeXR4M1zfzZcRrxaxRQJfrfPdeoWlzhvMKHdxkTtnsqUl
         HliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710155483; x=1710760283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRuEb5oNxuILVmXpDBJ4dFKyOTuSJjmVSc84Jl5hgzk=;
        b=nlnsi/7q6Z1ffgljbZWypNyok+W53GgeN+S0iT52mURyQqoWaFIOaZKUK1wIw6czil
         TtfyhC6BM5Uqj/msMkBoESCpJceKX+yAi0SB9K6eioc2XcDTsitT8ManzAxuAnVbrNHE
         wrD88bW8XqVwIcNZj70aqQ8+Vv4utHSCK2v/scABn0iU7rhS333DdTmkxrEo8WlJ2uOw
         +JnF38/Ra4yxhV7b+FTIpyEwxOBY8EcTHCZGP6GgIlQMVBjFC/v1RgkTy/80qknYDpyK
         /4aEkrJUD+61sQVXVj1vn3jfELRwjDe5Ti4RwITvC/zrh3WGrw6MfQiHmqeIE5/gM0fG
         pb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwUpLVCVUx89SdyBHTUgOz+nG6lBYQ2F9qY/LrpP0T5gUkX9tL8t1j6QpH9QVmRgwEm7gWWQhtQpzh2vWjn/HCcEWxa0kZD7OHVuOaGo5TPj9498kjqdpdcQ04JVpWL1juP3c49xjtyIQHoJTqkmznXo85teCk7qEZ4A5zgaq0RgPQFQ==
X-Gm-Message-State: AOJu0Yx1F0yQXdzqjJiC9kKe4zyG+F2HsiI2pgMp8o3XVBHlyzXo5ttU
	s29scERh5eark6lq12mCzDS2hYNXIkMBqxAQYYV4dC6gf3jysrZNCf98HxgWDTZDCIU6+ujzhhk
	rw72occ4Atw7fU353TJ7SVCsNLk4=
X-Google-Smtp-Source: AGHT+IF5qAv1n52u00gXfBUnq2QedRPjSj70WqgOJ4BzIfWghECDI12o/fvb5ZR8KcnPDxHErA9r/dG3Sb6SJ7xxJXs=
X-Received: by 2002:a05:6870:78a:b0:221:7b5e:4efa with SMTP id
 en10-20020a056870078a00b002217b5e4efamr7512574oab.13.1710155483484; Mon, 11
 Mar 2024 04:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310171958.96388-1-animeshagarwal28@gmail.com>
 <2b939f61-c8b9-4b41-a319-3bf7be42ba3e@linaro.org> <CAE3Oz82coV5RgcRE=Lj5mm2kjdzh3iFJGpMBBw_OfZppfWAHfg@mail.gmail.com>
 <d609c172-2bb3-479a-b5f2-841aed455bff@linaro.org> <CAE3Oz80zrnLvpo=YdBA-3PAtJFP8KK4LGHpEpQaMCacFFG13Qg@mail.gmail.com>
 <ba834984-d0d7-4b46-81f6-5a2df8e74944@linaro.org> <CAE3Oz8353cPXgZa3BhtjyfdFfu+XPUhHXf=qWxWQ7sbvVK7gcg@mail.gmail.com>
 <6597b720-4b8f-4034-8f0b-b67949ef5feb@linaro.org>
In-Reply-To: <6597b720-4b8f-4034-8f0b-b67949ef5feb@linaro.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Mon, 11 Mar 2024 16:41:20 +0530
Message-ID: <CAE3Oz82m_xEnar2YWGuN4ncRWh1hs+KGfRLCqC8a1vCNp+fqHQ@mail.gmail.com>
Subject: Re: [PATCH v5] dt-bindings: imx-pata: Convert to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:56=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> This is changelog, not commit msg. I did not ask to explain differences
> from pure conversion in changelog.

Thank you for clarifying your expectations regarding the commit
message and changelog distinction. I apologize for the confusion.
I understand now that the information provided in the changelog
regarding the differences between versions does not suffice as a
replacement for a comprehensive explanation within the commit message
itself.

Moving forward, I will ensure that the commit messages contain
detailed explanations of the changes made during the pure conversion.

Thank you for your patience and continued guidance.

Best regards,
Animesh

