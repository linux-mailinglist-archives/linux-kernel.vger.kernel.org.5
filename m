Return-Path: <linux-kernel+bounces-14694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7451E8220C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877291C21F48
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8199B156DF;
	Tue,  2 Jan 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVIyP+y+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB8156D2;
	Tue,  2 Jan 2024 18:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3F4C433C7;
	Tue,  2 Jan 2024 18:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704218996;
	bh=0B4MGO3nEzwJGG528F5URY4URve6DriUG1N7zW1et+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KVIyP+y+D2TBQ3d2+wAIcHBatKMgGdadyoZYeoCJP0by22tFPtnlUYXL7SGhlM4O8
	 2K5u9HFuPnaLO2o4dwgQn49aR4UFRRwR4V+R/NOKZxnvapnPreVFV2MMq1b1PVXIel
	 fhiayKYC3YcNYUJoIPlRbXXDWOJvVP+7ijwwAKdmpnPN/J/+wd8DeW5eUjuhLkUbKQ
	 JHd5TDDCbD7p0Dj0y/2CoKNLxyoOC0aUEozbbsmWw0/vZf7yPENtcGjIiFX96Pt1MY
	 mtDtJ6CVy0V/4/5bmbPG7X6i4nezHdQr3AXvI4MsOwZPdxkMXR1OGxd6GAkH7s7FsQ
	 i3re/XN3rSd4Q==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cceb5f0918so36575831fa.2;
        Tue, 02 Jan 2024 10:09:56 -0800 (PST)
X-Gm-Message-State: AOJu0YyL3dWnjEJygco+o/zqDgtZB4fNjKv9LGl5vNEJ+smyRCF56Uh0
	6IOiv7KFIolgkfnCMREnXDXucCxOqPL7dJG/IQ==
X-Google-Smtp-Source: AGHT+IGXIEZJi6VHeuPZatY3dAslENz6hJgEbGz8cu14HmNSVOac5JR58tclYtJVnkMf8XqtqCxeUECRx+eShgwuYwo=
X-Received: by 2002:a05:651c:1a10:b0:2cc:cbd9:b3d7 with SMTP id
 by16-20020a05651c1a1000b002cccbd9b3d7mr5115618ljb.28.1704218994526; Tue, 02
 Jan 2024 10:09:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209171612.250868-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231209171612.250868-1-krzysztof.kozlowski@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 2 Jan 2024 11:09:42 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKogbT_4DPd1n94xqeHaU_J8ve5K09WOyVsRX3jxxUW3w@mail.gmail.com>
Message-ID: <CAL_JsqKogbT_4DPd1n94xqeHaU_J8ve5K09WOyVsRX3jxxUW3w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: juno: align thermal zone names with bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 10:16=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Thermal bindings require thermal zone node names to match
> certain patterns:
>
>   juno.dtb: thermal-zones: 'big-cluster', 'gpu0', 'gpu1', 'little-cluster=
', 'pmic', 'soc'
>     do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-therm=
al$', 'pinctrl-[0-9]+'

You've just traded this warning for these:

      6  thermal-zones: 'little-cluster-thermal' does not match any of
the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$',
'pinctrl-[0-9]+'
      4  thermal-zones: gpu1-thermal: 'trips' is a required property
      4  thermal-zones: gpu0-thermal: 'trips' is a required property
      4  thermal-zones: big-cluster-thermal: 'trips' is a required property

Last I checked this, it looked like the length of the child names was
limited because the thermal subsys uses the node names for its naming
which is limited to 20 chars (with null). Though the regex here allows
for 21 chars without nul. Looks like a double off by one error.

The thought I had at the time was to make the kernel drop '-thermal'
from its names. Might be an (Linux) ABI issue if userspace cares (I
think it shouldn't). Also, I'm not sure how the kernel handles the
names overflowing. Maybe it is fine and we can just extend the length
in the schema from 12 to 18 (plus the 1 starting char).

Rob

