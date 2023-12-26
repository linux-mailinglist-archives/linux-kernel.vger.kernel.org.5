Return-Path: <linux-kernel+bounces-11553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE9881E824
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896A81C21608
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3E24F21F;
	Tue, 26 Dec 2023 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcbwyvX0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04BC4F207;
	Tue, 26 Dec 2023 15:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19656C433C8;
	Tue, 26 Dec 2023 15:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703605519;
	bh=NhmamG9+fHayVcbk79Rh5B4IaSWcmsGnW4aUZA8zJyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HcbwyvX0vsblx50SKZKV3SZKdVVYSi+MKE8TeMyF8gCLIzzcIjW1FkEqYr1G6X9NI
	 DcmgAISjZGRszhQY9EXn+Hr74NNhV8eeLLdJkMIulAycK7btcah2yzVKqGKDEojqYv
	 qGLE0wbhXY/NGDyiOsQh/Kk14pjYKlK4auEZRU6LeLE+1r3isiApFStPNwChYZpgLD
	 D/Jxhcp15msfSE17epvZadmpJkFCNL/g9r4FfUBlCG0YLx67YQsxy/hFRnMxoXsrMM
	 4vrfi444ZPgXJEZ3skv+e/flB2t7Az0SKjgqmUGtmMtayKj6w6EQnvuMKMDajkIuGI
	 LFETtXEXjyzkw==
Date: Tue, 26 Dec 2023 15:45:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
 joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
 paul.cercueil@analog.com, Michael.Hennerich@analog.com, lars@metafoo.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dan.carpenter@linaro.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/11] MAINTAINERS: Add MAINTAINERS entry for AD7091R
Message-ID: <20231226154509.450c5e40@jic23-huawei>
In-Reply-To: <ZYWFwVzQN4vU7FdG@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1703013352.git.marcelo.schmitt1@gmail.com>
	<4247e653354f8eb362264189db24c612d5e4e131.1703013352.git.marcelo.schmitt1@gmail.com>
	<20231221165947.6c64b2c5@jic23-huawei>
	<ZYWFwVzQN4vU7FdG@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 09:49:05 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 12/21, Jonathan Cameron wrote:
> > On Tue, 19 Dec 2023 17:32:59 -0300
> > Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> >   
> > > The driver for AD7091R was added in
> > > ca693001: iio: adc: Add support for AD7091R5 ADC
> > > but no MAINTAINERS file entry was added for it since then.
> > > Add a proper MAINTAINERS file entry for the AD7091R driver.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>  
> > Hi Marcelo
> > 
> > The series looks good to me now. However timing is a bit against
> > us because I won't squeeze in another pull request (unless the
> > kernel release is delayed for some and Linus strong hints at that
> > this weekend).
> > 
> > What I'll probably do with this series is pull out the first 2 patches
> > as fixes to go in either at the back end of the merge window or just
> > after, then pick the rest of the patches up for 6.9.
> > 
> > If I seem to have lost track of them in about the 2nd week of January,
> > feel free to poke me. 
> >   
> okay, sounds good.
Seems that Linus has confirmed he'll do an rc8. So I might get a final
pull request in.  So with that in mind I've picked this whole series up.

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to take a quick look at it.

Thanks,

Jonathan

> Also, will do the change to ABI doc in a separate patch so this set doesn't get
> blocked by the mistakes I will make on the ABI patch. :)
> 
> Thanks,
> Marcelo
> 
> > Jonathan  
> > > ---
> > >  MAINTAINERS | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 4eddc4212f2b..3473cfbac826 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1126,6 +1126,14 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> > >  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> > >  F:	drivers/iio/adc/ad4130.c
> > >  
> > > +ANALOG DEVICES INC AD7091R DRIVER
> > > +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > +L:	linux-iio@vger.kernel.org
> > > +S:	Supported
> > > +W:	http://ez.analog.com/community/linux-device-drivers
> > > +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
> > > +F:	drivers/iio/adc/drivers/iio/adc/ad7091r*
> > > +
> > >  ANALOG DEVICES INC AD7192 DRIVER
> > >  M:	Alexandru Tachici <alexandru.tachici@analog.com>
> > >  L:	linux-iio@vger.kernel.org  
> >   


