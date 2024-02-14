Return-Path: <linux-kernel+bounces-65431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D585854CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20EF1F21C37
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1585D901;
	Wed, 14 Feb 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEsCuGZY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356DF5D757;
	Wed, 14 Feb 2024 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924743; cv=none; b=KoJN5xv5SsOC258srom2cM3KvbKv+wjkRnGSZGhegEUJQ+AaoIXJyNRJuJSP4y4y89AlhkdiD+y9WmEn8Yor8AZ6OEB6h8R2wVY4uddnPFvMz84KYYe5FjDbKjK5k96yli0MJFJkQa5hhx44/sZAQYPJMMCQav7wl/e8v48g87s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924743; c=relaxed/simple;
	bh=FejdNMrpdofeTtIgHwVlJX3RhPAaERtChgynis6wUyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnHP4MtWvACQBCsz7n/oUdM1Vb+Fs3ad1A302da581o9y5d7AZCxYXZrNh2Wf/Hp+4tA1xtj/vjB/Y46GUoWAiLV+nzvMijYQuRdEJGysWWQuH+sUg5pxqDeSWFWYOcbSmqAWGlJuNGh4Au6ASlsByyG/NN0QBfqKRJDrTxZIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEsCuGZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63F4C433F1;
	Wed, 14 Feb 2024 15:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707924742;
	bh=FejdNMrpdofeTtIgHwVlJX3RhPAaERtChgynis6wUyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WEsCuGZYCrZhG+VBXTAVxboaJo9t9mo+pwaWyUnC/ZYoovILW2susXWKcO8N7CVAA
	 5ggQAOkfK8nst22lG1a1OQS748WWzIM40KG37jDw0/3Rd8ghD5JO68X1KGc7wN6UWg
	 z66mz1W7EsDwN9Rp5lRlckjdiZlZAHKO2ZKYHEZrs4ixK1JLwsVM50aFmlniRi8jKO
	 OzG84pjcXMK5p2xImU7ux2lAR+dPCephCqu11G9dKIZIYMRSABs4IwXa4z8Nkg2xzJ
	 vAxh/FxTlB6bBy5iACi3v/Fj3gXR0UbhuHGU29MtAR68Voka7MRS1DmIWbd/LBE8fA
	 Ig0saHGs1lJQQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0f7585d89so43565371fa.3;
        Wed, 14 Feb 2024 07:32:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUw+5lPFplGqvj1MYKo6OJms2q7hssc32FlwjvPtOBA+tDREHoCfVz+idCVGpdnyQXgIeDx21jWoDH9prrOhUKRDeH49it7poqvDonpIx8+IP9pQGd1T7Lg+o7Jeg3ENUwb4drqIYIodW5GPO5G9XkmRGjDpiBDKHb3IDfAhgZ7794JPzpc+Os=
X-Gm-Message-State: AOJu0Yzmv2qP5PEd/ciFFGffSGEKSH2FDUZIgigTBuTgk2IAefz9q29Z
	Ur0zJFN4Hfn6HQVACNjr+yrrsitBK/1vxt7ZF/7kFJoKpVm4vZNWvSS5z4ry+d7Brtc1huaNoNW
	0hEZFg0DlttT7uwOYB/aHsFCLJA==
X-Google-Smtp-Source: AGHT+IGNETA4hh1PpqV18M5PpErryjSDPLk3hVcIZZYvhGWLbhl0Wu+Z2BaMuWnXz+oEQxY1KjeKq/WKVjAnKUyUj+A=
X-Received: by 2002:a05:651c:2008:b0:2d0:cbcd:a33c with SMTP id
 s8-20020a05651c200800b002d0cbcda33cmr1952171ljo.53.1707924740981; Wed, 14 Feb
 2024 07:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
 <20240213160521.15925-2-quic_jinlmao@quicinc.com> <20240213222957.GA2502642-robh@kernel.org>
 <a062ce8d-638a-4a33-8afa-45ad47efcd72@quicinc.com> <df3162c0-4b29-77a2-20b5-b36637fb11cf@arm.com>
 <162256e1-416f-46ea-9698-9de507768cb0@quicinc.com>
In-Reply-To: <162256e1-416f-46ea-9698-9de507768cb0@quicinc.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 14 Feb 2024 15:32:07 +0000
X-Gmail-Original-Message-ID: <CAL_JsqL2aQw4zoLjvZq-M2_Sb8Q5KkAOcgfGOL2yf9ngixh3+A@mail.gmail.com>
Message-ID: <CAL_JsqL2aQw4zoLjvZq-M2_Sb8Q5KkAOcgfGOL2yf9ngixh3+A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename qcom,dsb-element-size
To: Jinlong Mao <quic_jinlmao@quicinc.com>
Cc: James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tao Zhang <quic_taozha@quicinc.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 8:18=E2=80=AFAM Jinlong Mao <quic_jinlmao@quicinc.c=
om> wrote:
>
>
> On 2/14/2024 5:36 PM, James Clark wrote:
> >
> > On 14/02/2024 01:43, Jinlong Mao wrote:
> >> On 2/14/2024 6:29 AM, Rob Herring wrote:
> >>> On Tue, Feb 13, 2024 at 08:05:17AM -0800, Mao Jinlong wrote:
> >>>> Change qcom,dsb-element-size to qcom,dsb-element-bits as the unit is
> >>>> bit.
> >>> That may be, but this is an ABI and you are stuck with it. Unless, yo=
u
> >>> can justify why that doesn't matter. (IIRC, this is new, so maybe no
> >>> users yet?)
> >> Hi Rob,
> >>
> >> Because for CMB type, it uses qcom,cmb-element-bits. So I change the
> >> format to be the same as
> >> CMB.
> >>
> >> Thanks
> >> Jinlong Mao
> >>
> > I think what Rob was trying to say was that in the interest of not
> > breaking existing DTs it's best to leave the existing names as they are=
,
> > even if they aren't technically correct. And to only add new parameters
> > with the -bits suffix, even if it's inconsistent with what's already th=
ere.
>
> Hi Rob & James,
>
> There is no tpdm nodes in any DT as of now. So I want to make this
> change before any tpdm
> node is added in DT.

Then the commit msg needs to state that detail.

Rob

