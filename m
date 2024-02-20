Return-Path: <linux-kernel+bounces-73044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8240785BCA0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB12B219C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6AE69E1A;
	Tue, 20 Feb 2024 12:54:21 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A169D20
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433661; cv=none; b=Ys9n4JuQLFWn5+95Uj8pIFgrXJeCZCv/dgcoQNfkvb1k7/yya4rr4B9P4WNpgSm+bkTPtZO3YdrpdIQuQsWGMloLUXLEGs2l3Z4uc8+7ZXhsl5bf8nHhQqC2xZmueo/mJ9cwgOTNdgaXs792HMq7k042+gaCX7pN5gzyPv7H+yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433661; c=relaxed/simple;
	bh=oJSQtp9yuDvgjsR4TEK8t50L14uFuL/EUmrb3ZJrqv0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cEiPX7ImYPywhQB+QdOpQJxqtUXaH1I2XRg9NouQa5jkTFk5ctdspobMObvE05g9Vv5COaNdXtAz24djh3RVciGZZUaWljVclE8Ox+UOg3NBS6oMOTIl2/nBYfI0H8TH/ET+1lXbg5YeGSPbTZGqlUBCFm2Q0jQI0mY/Wa93ZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TfK9P0wgHz4wxX;
	Tue, 20 Feb 2024 23:54:17 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <jdelvare@suse.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1704900449.git.u.kleine-koenig@pengutronix.de>
References: <cover.1704900449.git.u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/7] macintosh: Convert to platform remove callback returning void
Message-Id: <170843363897.1291121.16845812107659928983.b4-ty@ellerman.id.au>
Date: Tue, 20 Feb 2024 23:53:58 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 10 Jan 2024 16:42:47 +0100, Uwe Kleine-König wrote:
> this series converts all drivers below drivers/macintosh to use
> .remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
> callback that returns no value") for an extended explanation and the
> eventual goal. The TL;DR; is to make it harder for driver authors to
> leak resources without noticing.
> 
> This is merge window material. All patches are pairwise independent of
> each other so they can be applied individually. There isn't a maintainer
> for drivers/macintosh, I'm still sending this as a series in the hope
> Michael feels repsonsible and applies it completely.
> 
> [...]

Applied to powerpc/next.

[1/7] macintosh: therm_windtunnel: Convert to platform remove callback returning void
      https://git.kernel.org/powerpc/c/bd6d99b70b2ffa96119826f22e96a5b77e6f90d6
[2/7] macintosh: windfarm_pm112: Convert to platform remove callback returning void
      https://git.kernel.org/powerpc/c/839cf59b5596abcdfbcdc4278a7bd4f8da32e1b2
[3/7] macintosh: windfarm_pm121: Convert to platform remove callback returning void
      https://git.kernel.org/powerpc/c/2e7e64c8427c2385bf47456a612d908f827bbbbf
[4/7] macintosh: windfarm_pm72: Convert to platform remove callback returning void
      https://git.kernel.org/powerpc/c/057894a40e973c829baacce0b9de6bdf6c8ec1da
[5/7] macintosh: windfarm_pm81: Convert to platform remove callback returning void
      https://git.kernel.org/powerpc/c/fb0217d79d77f1092929bae1137ac0f586c29fec
[6/7] macintosh: windfarm_pm91: Convert to platform remove callback returning void
      https://git.kernel.org/powerpc/c/7cfe99872c711ffa727db85c608a0897955a2758
[7/7] macintosh: windfarm_rm31: Convert to platform remove callback returning void
      https://git.kernel.org/powerpc/c/4b26558415d628ad2c0d3d4ec65156a0c99eaf02

cheers

