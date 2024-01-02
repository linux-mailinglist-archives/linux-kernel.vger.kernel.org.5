Return-Path: <linux-kernel+bounces-14443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1159821D20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23FA8B21F98
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA32101CF;
	Tue,  2 Jan 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F/ehNzKq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F64C1119C;
	Tue,  2 Jan 2024 13:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4A9C433C7;
	Tue,  2 Jan 2024 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704203587;
	bh=GjOKiW0xtneKjT+iVjyAoNrxX77mFm1Dq2j6C8liY9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/ehNzKqswC0ZnX/TtOamWQ/36hQN7FbZuWjYAjJR0QS3T/FjDAT5Y6aTuRKDwPqa
	 LwEmdEMrrxEtmtRpxpV7uCja0xh4KW0U3GcZ6oKts53vJrJccrgGDYVjSK1kUokGkq
	 qhEDN7rgiVeeOS1XCNQCCmdTBGW7BZIz+z3GDAQU=
Date: Tue, 2 Jan 2024 14:53:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	cros-qcom-dts-watchers@chromium.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] Fairphone 5 PMIC-GLINK support (USB-C, charger, fuel
 gauge)
Message-ID: <2024010205-placidly-expire-221c@gregkh>
References: <20231220-fp5-pmic-glink-v1-0-2a1f8e3c661c@fairphone.com>
 <8d042095-1e09-45cc-9762-909fe8d663a9@linaro.org>
 <CXTU5MLN0YDS.29PPV8KZF8G9R@fairphone.com>
 <CAA8EJpoD3x=kVLu4x2yLtAqCp=wmGSU4ssq5Oj_SD5VQ=GyAYQ@mail.gmail.com>
 <d2007240-2779-4881-8e9d-1c4f5daa55e5@linaro.org>
 <CXU22OZNAH2H.24YIQWBA4KE3C@fairphone.com>
 <2024010227-darn-litmus-4ddf@gregkh>
 <CY49JOEDOEZX.1KNYT91GHL3MX@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY49JOEDOEZX.1KNYT91GHL3MX@fairphone.com>

On Tue, Jan 02, 2024 at 02:43:24PM +0100, Luca Weiss wrote:
> On Tue Jan 2, 2024 at 2:36 PM CET, Greg Kroah-Hartman wrote:
> > On Thu, Dec 21, 2023 at 02:45:26PM +0100, Luca Weiss wrote:
> > > On Thu Dec 21, 2023 at 1:53 PM CET, Konrad Dybcio wrote:
> > > > On 21.12.2023 11:34, Dmitry Baryshkov wrote:
> > > > > On Thu, 21 Dec 2023 at 09:33, Luca Weiss <luca.weiss@fairphone.com> wrote:
> > > > >>
> > > > >> On Wed Dec 20, 2023 at 1:32 PM CET, Konrad Dybcio wrote:
> > > > >>> On 20.12.2023 11:02, Luca Weiss wrote:
> > > > >>>> This series adds all the necessary bits to enable USB-C role switching,
> > > > >>>> charger and fuel gauge (all via pmic-glink) on Fairphone 5.
> > > > >>>>
> > > > >>>> One thing that could be made different is the pmic-glink compatible.
> > > > >>>> I've chosen to use qcm6490 compatible for it and not sc7280 since
> > > > >>>> there's plenty of firmware variety on sc7280-based platforms and they
> > > > >>>> might require different quirks in the future, so limit this PDOS quirk
> > > > >>>> to just qcm6490 for now.
> > > > >>>>
> > > > >>>> If someone thinks it should be qcom,sc7280-pmic-glink, please let me
> > > > >>>> know :)
> > > > >>> IMO it's best to continue using the "base soc" (which just so happened
> > > > >>> to fall onto sc7280 this time around) for all compatibles, unless the
> > > > >>> derivatives actually had changes
> > > > >>
> > > > >> Hi Konrad,
> > > > >>
> > > > >> I think at some point I asked Dmitry what he thought and he mentioned
> > > > >> qcm6490. Even found the message again:
> > > > >>
> > > > >>> well, since it is a firmware thing, you might want to emphasise that.
> > > > >>> So from my POV qcm6490 makes more sense
> > > > >>
> > > > >> But yeah since it's likely that sc7280 firmware behaves the same as
> > > > >> qcm6490 firmware it's probably okay to use sc7280 compatible, worst case
> > > > >> we change it later :) I'll send a v2 with those changes.
> > > > > 
> > > > > Worst case we end up with sc7280 which has yet another slightly
> > > > > different UCSI / PMIC GLINK implementation, but the compatible string
> > > > > is already taken.
> > > > > I still suppose that this should be a qcm6490-related string.
> > > > Right, let's keep qcm then
> > > 
> > > Ack from my side also. Thanks for the feedback!
> >
> > This doesn't apply to my tree, where should it be going through?
> 
> As far as I can see the dependency for the driver commit 1d103d6af241
> ("usb: typec: ucsi: fix UCSI on buggy Qualcomm devices") was applied to
> Bjorn's qcom tree, so 2/3 should also go there then.
> 
> Patch 3/3 (arm64 dts) definitely also Bjorn's qcom tree.
> 
> So that leaves patch 1/3 which Bjorn can probably pick up as well but
> looking at git log you also picked up some for that file in the past,
> dunno.

Ok, for any remaining ones that want to be merged before 6.8-rc1 is out,
feel free to add my:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

If they don't get picked up by 6.8-rc1, feel free to rebase and send it
for me to take through my tree.

thanks,

greg k-h

