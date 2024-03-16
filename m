Return-Path: <linux-kernel+bounces-105248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CA887DB0C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07184B217A4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC491BF2B;
	Sat, 16 Mar 2024 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vallxqpk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEBC1BDCE;
	Sat, 16 Mar 2024 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710609880; cv=none; b=iSHn0yJZ1+2JhjdZML3RohdTSk4aWmntnZemAlEznVttMgewHo0uzOH/uHHTWoBXR7whBfMvfrDVzzxjTP71zb9mHgvts8QzlQXMhM4OzpoyfaA695gk1FYjAhDIQqE0/PCS5+QBrpl6zmFi1XwKvGUAb4N6fmxWRTMDbus626Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710609880; c=relaxed/simple;
	bh=t2f9OCV2id9IXt90SjuS1wuibjrWOdvYSHURUhVXBCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWFFBOA0pxe0Fp0fZok10XlmJEf6F8oWeaj5AzBIxTPa+2FjPg8Bqpg1y4sYF7vzOsu7hUEiH6h3mJlUTD6OxoYjzb2DsXtSF0HKeecq5M32iOlOsxrbrHZFei6yDGkgPU1YVUOwkaBkJw1kJyxjMqnz9SMuBFqds3Qgxihqs+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vallxqpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E307C433F1;
	Sat, 16 Mar 2024 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710609879;
	bh=t2f9OCV2id9IXt90SjuS1wuibjrWOdvYSHURUhVXBCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vallxqpk8xB2VeXjticMxlwQFQ+em2yaUhv4FF8f7i7m5oXFD2XPtOz2UXt/g0WUe
	 E+5wMuOdRVJ4ZCVl37W3G3fI3RKhS6bhHatbPqRYeMhPhgLFeKZz/zXdAExgpxqMi0
	 dsPtdKld/ezhDUxzDUrJfDf5Y4hFcN5qbLg7vyhGtzA4okLqTiiQ1IPmIKViE60d0F
	 EzuNoYwYsI4Rz72rWcHiOdWduAiNAsZpwnC8yyU6oYyoMv+hUCVKvRJAEef0o3pYc/
	 WFjFnONb3j2WXGa3UHKj/cYOrXEKN5LGEyuNMBzQmXJ54o4MRhvzW4H7dxFWWOLQIW
	 v8RmQvBhVDxHg==
Date: Sat, 16 Mar 2024 12:24:36 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Guru Das Srinagesh <quic_gurus@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: Re: [PATCH v7 08/12] firmware: qcom: qseecom: convert to using the
 TZ allocator
Message-ID: <vevlpit6xttrrpse6lxw43vnmf7hpoxsovoofrdvam7dmmvyyh@5bajhnotdr3y>
References: <20240205182810.58382-1-brgl@bgdev.pl>
 <20240205182810.58382-9-brgl@bgdev.pl>
 <yu5uhamdlygti3jo73ipy3gxhcmgxrm5g6imgqg6ksleim4ton@npvzlex2j4xi>
 <CAMRc=Mctm-cyYPpu-Vb+fr1cWJPUW49shaa9HEXYp+rkF_CHUw@mail.gmail.com>
 <odnisr4flot3rgwwqpjob3qtw63jow7hcj4guy6ao6spdz6fm4@wtcm62o3hgxm>
 <CAMRc=Mezj4BQ=-4SfgdE6OmKX0X8+xedvroBNeaDeyqey4=2DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mezj4BQ=-4SfgdE6OmKX0X8+xedvroBNeaDeyqey4=2DQ@mail.gmail.com>

On Sun, Mar 03, 2024 at 05:18:18PM +0100, Bartosz Golaszewski wrote:
> On Tue, Feb 27, 2024 at 5:53 PM Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Tue, Feb 20, 2024 at 10:54:02AM +0100, Bartosz Golaszewski wrote:
> > >
> > > I disagree. If we have a better interface in place, then let's use it
> > > right away, otherwise it's just useless churn.
> > >
> >
> > The functional change and the use of cleanup macros, could be done
> > independently of each other, each one fully beneficial on their own.
> >
> > As such I don't find it hard to claim that they are two independent
> > changes.
> >
> 
> This series would be 50% bigger for no reason if we split every patch
> using the new allocator into two.

I'm not asking you to split every patch into two, unless that makes
sense.

> I absolutely don't see how this makes any sense.

I find it unnecessarily hard to determine which parts of _this_ patch is
functional and which is cleanup.

> We're removing the calls to old interfaces and using
> the new ones instead. The new ones happen to support cleanup so we use
> it right away. If the old ones supported cleanup then maybeeee it
> would make some sense to convert them first and then use tzmem. As it
> is, there's really no point.
> 

The old interface is kzalloc(). I haven't used the cleanup mechanism
myself yet, but are you saying that there's no cleanup support for
kzalloc()?

Regards,
Bjorn

