Return-Path: <linux-kernel+bounces-27588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFB382F292
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F30F0B226DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170821C6B0;
	Tue, 16 Jan 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDcxDPja"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612A1748D;
	Tue, 16 Jan 2024 16:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF5BC433C7;
	Tue, 16 Jan 2024 16:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705423661;
	bh=fCFQedqBtnHbk0RjkLAsOwMAS2Fb6uEfIUfJDT9Jjzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDcxDPjaqkX7bh/a5dvzL+zrOdvUXO+D68NLQwuZXoE/f0CIGUrTsK/jHv7+sYSEG
	 60TM0eokPBmFx5U6RrzXiRFEE8FyxRrg6ch4s7jRk78m+BLB4KAqX9IpsfuULyJBY7
	 OEzQ+IJjnV5xLp1GgevJmJZqx4RfNuu8dRIykZUN5E+NVS00ZoXW8krtyROk1yw9JN
	 re/uUAvqbqaoJc4sky02cHWPwSsPSAsN7SAA3epwPZOuwvZkCYjsDejpPKNMln+2CE
	 Sq7AEPzpLzeW1V4gXpz4Pgx85Z256Ex4WEErbPWlUu6VAVW5+qMc9+srB5jv1CnlG7
	 ZH9L4Plv/tVPQ==
Date: Tue, 16 Jan 2024 10:47:39 -0600
From: Rob Herring <robh@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: dai-common: Narrow possible
 sound-dai-cells
Message-ID: <20240116164739.GA93647-robh@kernel.org>
References: <20240109213812.558492-1-krzysztof.kozlowski@linaro.org>
 <1ja5pdzb7k.fsf@starbuckisacylon.baylibre.com>
 <7e312b05-857f-40a6-a1a1-a954dfea7044@sirena.org.uk>
 <f9f5df54-dbeb-4246-b30f-52f3db7d94b3@linaro.org>
 <3b1b956b-985c-45f2-bda3-018aaf897295@sirena.org.uk>
 <445daac6-841a-4335-9b53-689e5bd2530c@linaro.org>
 <1jjzohxpl7.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jjzohxpl7.fsf@starbuckisacylon.baylibre.com>

On Wed, Jan 10, 2024 at 02:36:01PM +0100, Jerome Brunet wrote:
> 
> On Wed 10 Jan 2024 at 14:24, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 10/01/2024 13:57, Mark Brown wrote:
> >> On Wed, Jan 10, 2024 at 01:51:03PM +0100, Krzysztof Kozlowski wrote:
> >>> On 10/01/2024 12:37, Mark Brown wrote:
> >>>> On Wed, Jan 10, 2024 at 12:07:30PM +0100, Jerome Brunet wrote:
> >> 
> >>>>> If restricting things here is really important, defaulting to 0 (with a
> >>>>> comment explaining it) and letting actual devices then override the
> >>>>> value would feel less 'made up'
> >> 
> >>> Wait, what do you mean by "letting actual devices then override"? It's
> >>> already like this. Nothing changed. What do you refer to?
> >> 
> >> The suggestion is that instead of limiting to 1 and having one device
> >
> > Nothing limits here to 0. I limit from all technically possible values
> > to reasonable subset.
> >
> >> override limit to 0 and have all the devices that need 1 override as
> >> well.
> >
> > I don't think that actual default value for this should be provided.
> > This should be conscious choice when writing bindings and driver.
> > Similarly we do already for some other #cells:
> > #io-channel-cells, address/size-cells (dtschema), #mux-control-cells and
> > others.
> >
> > I agree we do not restrict all of them, though. However I do not see
> > single reason to allow developers use 3 as #sound-dai-cells.
> >
> 
> Similarly, I do not see a reason to forbid it.
> Submitter should not have to update the generic bindings every time we
> come up with something new.

Why not? If someone comes up with a use for N cells, I'd like to know 
about it which would be more easily seen here than hidden in some device 
specific binding.

That being said, there's a global max of 8 in dtschema already, so 
limiting here doesn't add that much.

Rob

