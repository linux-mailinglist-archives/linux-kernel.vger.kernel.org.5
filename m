Return-Path: <linux-kernel+bounces-13399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93970820497
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF802821E6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF5F79CC;
	Sat, 30 Dec 2023 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpMv5QNJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D58B7488;
	Sat, 30 Dec 2023 11:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA75C433C7;
	Sat, 30 Dec 2023 11:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703935740;
	bh=ME7rmguraS+QpHkqvcm2mb6WLPZeSXv2g9gGYhHbKd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BpMv5QNJkSEJvW9tGPoVnTR2P/7BBPeGd2MRE1q/3tqKOeuO3DIMvoyeFk9THxxla
	 AqDpasD4j3SAO+H4A8qidvEryGKwlRjemoK4od6FzfOpvYHqXh3aJLq+A++UuVLBW/
	 +7bt5ACb5KZYuCez/AYXlEMJZit5LQ/yt+YWHqoyqcTFBU9KLW1mvfcAHq+ymH/g7+
	 4ZxOnfSudeveWRJziqNNztCWAC4NstynHPE5fxvatEo7gkRqGaqMWnUKNc977iwYmR
	 RRUAa3xUX0ViGOrlFw+Dv7m+mAFetaL5AeGVfnFpgpHXF/OA+Ff8zQcoSco5dJwKie
	 gqg9z7Ej0ByMQ==
Date: Sat, 30 Dec 2023 11:28:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH v2 01/10] dt-bindings: iio: pressure:
 honeywell,mprls0025pa.yaml fix
Message-ID: <20231230112852.2a9c3d64@jic23-huawei>
In-Reply-To: <ZYvOJ9tlO1fp_QBT@sunspire>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
	<20231224143500.10940-2-petre.rodan@subdimension.ro>
	<20231226162839.5ceddc9e@jic23-huawei>
	<ZYvOJ9tlO1fp_QBT@sunspire>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Dec 2023 09:11:35 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Hello Cameron,
> 
> On Tue, Dec 26, 2023 at 04:28:39PM +0000, Jonathan Cameron wrote:
> > On Sun, 24 Dec 2023 16:34:46 +0200
> > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> >   
> > > Define enum inside the honeywell,transfer-function property block.
> > > 
> > > Set the correct irq edge in the example block.
> > > Based on the datasheet, in table 13 on page 11:
> > > "End-of-conversion indicator: This pin is set high when a measurement
> > > and calculation have been completed and the data is ready to be
> > > clocked out"
> > > 
> > > Add description on End-of-conversion interrupt.
> > > 
> > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > > Signed-off-by: Andreas Klinger <ak@it-klinger.de>  
> > What's the relationship between Andreas and this patch?
> > 
> > Petre seems to have sent it so either Andreas should have a Co-authored-by or
> > should be the author... Or not there at all  
> 
> Andreas has written this driver as it is in the mainline tree right now and he
> is marked as a maintainer for it.
> A month back I told him about the enum off-by-one problem and also about my plan
> of adding more features to the driver.
> He was happy to accept my code and once I sent v1 of this patch to the list has
> asked to work together for the v2 you see here. This has helped with cleaning up
> the code. He requested the additional 'Signed-off-by' tag, but if you have a more
> explicit one I will happily use it. 'Co-developed-by' it is.

Yup, needs combination of Co-developed-by and a Sign off for this case as in
effect both of you wrote the code.

> 
> He also owns an i2c version of the sensor so he was able to make sure that the
> original half of the driver still works after my refactor, hence the 'Tested-by'
> tag in the last patch.

That's fine.

> 
> please tell me how do the 'fixes'/feature/improvement tags/keywords look like?
> are these to be added on the subject line, or should they reside near my
> 'Signed-off-by' inside the email body? I probably missed the documentation where
> these are covered :)
See https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst
for lots of detail.  The fixes tag has a particular format and goes in the main
tag block. Lots of examples in tree so can just take a look at the git history for
how to apply these rules in practice.

> 
> also, should I add a 'Reviewed-by:' you for 09/10 and 10/10 (the last two patches)?
No. Tags should be explicitly given.  I tend not to give RB for stuff I'll pick up
because they will have my SoB anyway as the person who applies the patches
and that includes reviewing.

In this case, Andreas asked for a tag to be included whereas I have not.

Jonathan


> 
> best regards,
> peter


