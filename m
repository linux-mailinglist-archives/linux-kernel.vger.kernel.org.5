Return-Path: <linux-kernel+bounces-65478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275F9854D98
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A901F24944
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1A75F875;
	Wed, 14 Feb 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pym00YR2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315425F84B;
	Wed, 14 Feb 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926632; cv=none; b=GFn4KbBfc6t1Fu+gGbITUhsjK3ZS5mI/lVyXwa8+zkiWaYaL3v1V+UXcexMaMe1DjiWZZvRSGO0LfYh7YAYUwMlM6QYfdR3EPT66uGlK+kmw4moUEowLsv8InUc2600f+ta+ahQXmSbfvxcOo+ggwAJWs9Ko1O3iwZp7ifBchug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926632; c=relaxed/simple;
	bh=JD4Ty6gdPF15+mHcLyVWSJFoBErubK0hC5IpuPhnfbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeOXhuNzBczuHpTFW4D49Ir8M8+4dUFyBv/P1vGdXyUR/WNv0VOX7hLPotQ+eG4G9BnOXz2EXB5S7oaFoVeCoioNd3Bgf4MCH/z2WfGXbFREyCLOD3CnXIsOKZnypkY3gLupXbbzwkww1eA6yjfBgQD71x53IKJSD80Xua9LT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pym00YR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CD2C433C7;
	Wed, 14 Feb 2024 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707926631;
	bh=JD4Ty6gdPF15+mHcLyVWSJFoBErubK0hC5IpuPhnfbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pym00YR2ob2im0Pt3jbSD5QrIzOfMdhbzyX2f8WCX7WZ/XOiQ9i6oVmWzWaM5MQ6R
	 s6Cat+AVFaDSiIhW4VuReQMxIwRGCY4m2JCmImdKrzvtPYwQadk76ekyaEpripKx8P
	 UDArj8tqiTZ5SQ/8GuVszwjU9Hm6eY2S/3INeTLrPyj2SBxZfBDU4uaU9j3mO0ZHtF
	 8cnw6BQ8PjKWr38lcYFVrYvdaK87zxCdRU/r6p4CrEHcjC2qv8DkEzj9VtzL+bwJJ2
	 iKITHBIQFv7HWC4A05Ro8nhMBZbSkVdIjRjyPjsLVMyFmRT5NZzBOnUC18jIPUfRJx
	 2877OudrOz8xg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d11d17dddeso6955101fa.3;
        Wed, 14 Feb 2024 08:03:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWorzMKk/oyGGRzYadxYc7O0wcMSsZYvAdhLPAT9vuo2sw84o+E63bFJykbzgogphRlIrPaOLQnr2hmYCDIOZu3aZxfOAQr5s7DpvdRy/v+yyUl6lBxlCI95w421K0qR67RPhkIep3ZpU0bLCFthRsyx5uKMM2Ax/9+0HqGMfKgDY1YoL4XAyU=
X-Gm-Message-State: AOJu0YzzbkoR+YE97hAqezre7X9J0J40Gu9VcAIibn3X+3Txm+ywTb5C
	kNw6PK9xQmAjR2CKRzbhiQrKpuN2DFO/rGmLCeuC+nxBB0M6A+DfYWsn7BbMB/A9Rz93M3/EplX
	lpDcRdKujRAUTv4fnDMzDy0ziLQ==
X-Google-Smtp-Source: AGHT+IHGj3vqeQDsmPo7C/68lZFAnpCyA1N1WsUlXo7j5vsgNB+c0Ar8dtdsESkEAeIwljmltxioVOPdoeopN5dzeDA=
X-Received: by 2002:a2e:b5c7:0:b0:2d0:eb23:3b5d with SMTP id
 g7-20020a2eb5c7000000b002d0eb233b5dmr2172254ljn.46.1707926629865; Wed, 14 Feb
 2024 08:03:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
 <20240213160521.15925-2-quic_jinlmao@quicinc.com> <20240213222957.GA2502642-robh@kernel.org>
 <c70df5a6-20af-4cee-b147-5847751fa36b@arm.com>
In-Reply-To: <c70df5a6-20af-4cee-b147-5847751fa36b@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 14 Feb 2024 16:03:34 +0000
X-Gmail-Original-Message-ID: <CAL_JsqKdAzPEGh941S05kraTjOcEpsPCnDRkppNkb8pBCpZu6g@mail.gmail.com>
Message-ID: <CAL_JsqKdAzPEGh941S05kraTjOcEpsPCnDRkppNkb8pBCpZu6g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename qcom,dsb-element-size
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mao Jinlong <quic_jinlmao@quicinc.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tao Zhang <quic_taozha@quicinc.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:56=E2=80=AFAM Suzuki K Poulose <suzuki.poulose@ar=
m.com> wrote:
>
> On 13/02/2024 22:29, Rob Herring wrote:
> > On Tue, Feb 13, 2024 at 08:05:17AM -0800, Mao Jinlong wrote:
> >> Change qcom,dsb-element-size to qcom,dsb-element-bits as the unit is
> >> bit.
> >
> > That may be, but this is an ABI and you are stuck with it. Unless, you
> > can justify why that doesn't matter. (IIRC, this is new, so maybe no
> > users yet?)
>
> This was added and support queued in v6.8. This change won't make it to
> v6.8 (given it has to go via two levels and is technically not a fix).

I'd argue it is a fix. But given no users yet, delaying is fine.

> As James also pointed out, it doesn't matter what the name is (now that
> it has been published).

v6.8 final is what we consider published.

Rob

