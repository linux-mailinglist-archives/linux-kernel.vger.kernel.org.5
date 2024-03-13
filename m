Return-Path: <linux-kernel+bounces-102454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2347687B258
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DE5281C57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5199F4D5A1;
	Wed, 13 Mar 2024 19:55:03 +0000 (UTC)
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77039210E9;
	Wed, 13 Mar 2024 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359702; cv=none; b=fCoE66glVwDAqlONBGXMbWp/AjApc/9keNVBc+uBKL6MKw67BE584UOmCIAjw9mLIRxz0RK97X97aFP2rKgnDeL6+ajkNqKdlrIIutKUgYVyIfeVuubvEfHxJfMxK7e6Idn11uh15fEYqWhFoK7lCAau5wumjfU0PCQjoPjZ9Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359702; c=relaxed/simple;
	bh=j+U9E9lfJdvcOySZsZqHvCJpzYfOaJSbSsP89+NlbHc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:References:Cc:
	 Subject:In-Reply-To; b=H72ibz9oLePnDKZ78wuAHIbNSpRXDmp3Xwl2ydND0Mhi7ATsu2wjyQW/reb5UgPMalAqxtiWviXn8ihN5wkXBOg7CuU1PYKAzHtmjOfwgkVhetGTA3qpelk+aC8MkX3HI+QGCF7nOZWi8HwmmtkbazgBmk6z7n4jAJRpEO9RxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
Received: from localhost (koleje-wifi-0013.koleje.cuni.cz [78.128.191.13])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42DJsD9Z080389
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 20:54:15 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 20:54:44 +0100
Message-Id: <CZSVWO3IDZ96.38O0P161Z99XU@matfyz.cz>
To: "Johannes Berg" <johannes@sipsolutions.net>,
        "James Prestwood"
 <prestwoj@gmail.com>,
        "Michael Yartys" <mail@yartys.no>
From: "Karel Balej" <balejk@matfyz.cz>
References: <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>, <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com>, <NbWQKmrYDD20KKHeq9TMda2MJFE00-weepZGuSIRzO5BOgMlTbWBkDlNNweA2dhbvF8TK1F_cHbMxblLVNREZa1HZEFt9TVCkTB1jo_5ppc=@yartys.no>, <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>, <20231010212240.61637-1-dimitri.ledkov@canonical.com>
Cc: <alexandre.torgue@foss.st.com>, <davem@davemloft.net>,
        <dhowells@redhat.com>, <herbert@gondor.apana.org.au>,
        <keyrings@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-modules@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <mcgrof@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <dimitri.ledkov@canonical.com>,
        <iwd@lists.linux.dev>, <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
In-Reply-To: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>

Thank you all for your feedback so far.

Since it seems that this really is a regression on the kernel side, let
me add the appropriate list to Cc and tag this:

#regzbot introduced: 16ab7cb5825f

Best regards,
K. B.

