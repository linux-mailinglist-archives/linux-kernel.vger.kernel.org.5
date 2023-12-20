Return-Path: <linux-kernel+bounces-7454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E43181A81C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33A9B22EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 21:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D9648CFD;
	Wed, 20 Dec 2023 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPnDMo7p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDC6495C1;
	Wed, 20 Dec 2023 21:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32AAC433C8;
	Wed, 20 Dec 2023 21:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703108192;
	bh=8fD+g/UALuuFVC/2IctyRtQM4JlqRN9pptw2dt8R384=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPnDMo7pNAr/kSeAnISx6iuXuIfsSnkY1fKBKFrT3QgIbqPjQugd/OPucZIcKIpkR
	 VgyhBRqne7a7T2qdpp79bzBdY7TdF+ZnOXIILHpvaHQEqwWRRamFOKNEc9GqZ2GM0G
	 6k9rmb+DazFqGagtmG/7WXvigSPZfmi46GjfgghdlY3TMHQ+F1VqfMyDXTkSSs3WWY
	 r4eLEgwSuVmi0g9kr0MEkRv3hSPPkqnxB7FaqDQ/BSoxSUJUoyZHwqYE9jlHRMZopE
	 7NPikncxVjQCVqnkhU/wRWfnHZPYRcKSusq37pLNTsJK5Yk1JkYGa460DVfaGpDxxd
	 UxyFN4JL30JQw==
Received: (nullmailer pid 1179044 invoked by uid 1000);
	Wed, 20 Dec 2023 21:36:29 -0000
Date: Wed, 20 Dec 2023 15:36:29 -0600
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Conor Dooley <conor@kernel.org>, jingbao qiu <qiujingbao.dlmu@gmail.com>, a.zummo@towertech.it, alexandre.belloni@bootlin.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, chao.wei@sophgo.com, unicorn_wang@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dlan@gentoo.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: sophgo: add RTC support for
 Sophgo CV1800 series SoC
Message-ID: <20231220213629.GA1177070-robh@kernel.org>
References: <20231217-swept-uncorrupt-92ac058dba4b@spud>
 <IA1PR20MB4953BE30DC29820912321C07BB90A@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953BE30DC29820912321C07BB90A@IA1PR20MB4953.namprd20.prod.outlook.com>

On Mon, Dec 18, 2023 at 11:41:52AM +0800, Inochi Amaoto wrote:
> >On Sun, Dec 17, 2023 at 09:16:39PM +0800, jingbao qiu wrote:
> >> On Sun, Dec 17, 2023 at 8:26=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
> >rote:
> >> >
> >> > On Sun, Dec 17, 2023 at 07:09:50PM +0800, Jingbao Qiu wrote:
> >> >
> >> > > +  reg:
> >> > > +    items:
> >> > > +      - description: data register
> >> > > +      - description: control register
> >> >
> >> > > +    rtc@5025000{
> >> > > +      compatible =3D "sophgo,cv1800-rtc";
> >> > > +      reg =3D <0x5025000 0x1000>, <0x5026000 0x1000>;
> >> >
> >> > Why are these two regions rather than just one, given they are located
> >> > next to one another?
> >> > Are they separate on one of the other devices in this family?
> >> >
> >> > Thanks,
> >> > Conor.
> >> >
> >>=20
> >> I think there are two reasons, the first one is to distinguish
> >> different logical ,
> >> REG_ CTRL (base on 0x5025000) controls clock calibration, sleep,and other
> >> functions, RTC_ CORE (base on 0x5026000) has basic RTC functionality,
> >> The second is the maximum address used by RTC_CTRL (base on 0x5025000)
> >> is 0x0ac,which is much smaller than 0x1000. Therefore, the datasheet divi=
> >des
> >> it into two parts for introduction, and I also divide it into two
> >> parts based on this
> >> introduction.So do you suggest that I merge them together=EF=BC=9F
> >
> >If all of the cv1800 series devices have them sequentially, I would just
> >make them one region.
> >
> 
> I agree with using one region. The ctrl and core region are highly
> releated.
> 
> Moreover, I suggest using syscon to describe this region, the reboot
> device is also in this region.

Then the description of the device is incomplete. Please describe the 
whole block/device.

Rob


