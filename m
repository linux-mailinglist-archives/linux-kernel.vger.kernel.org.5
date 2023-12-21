Return-Path: <linux-kernel+bounces-8634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F6881BA70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC7A28688A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3D052F60;
	Thu, 21 Dec 2023 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hik6TYts"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D44B13B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7DBC433C9;
	Thu, 21 Dec 2023 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703171984;
	bh=zRI4Rvo9WIuXe2q5wsHOUMVgxO0MDYOlConkXgZxsnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hik6TYtsssdYrcLPuMSZUOK0NE4Vh0G4KrgupuFFJKJ22egvWhh1NYBDGGnZVKupR
	 zyA3RgtULU7msHs1fDFGQ/70uT/OztnnyQ9U1VftKMAh/Yr2Kk86Eg43iUHDcIXJmz
	 n7DIPZyfiO6W9ghMaYKE8FINpTAAFXeedIx5B0XrWN+vb1Uk1Cmd25HGyzJnhtMiTF
	 N+xzurPGBrVKacTwvse6zyW2J5TG6A8CnBSVpJRlKwYR+Nuj8jN9jdyKkiYgtVZJxq
	 8kg3o/0QZ4dHn97VBtsVGMghmLL/thkrbYwmFKeE9ggQ8HwsTuEIEIzly3obcrfm9k
	 ccG1U2XUJ4p2w==
Date: Thu, 21 Dec 2023 16:19:41 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Peng Liu <pngliu@hotmail.com>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	liupeng17@lenovo.com
Subject: Re: [PATCH v3 1/2] tick/nohz: Remove duplicate between
 tick_nohz_switch_to_nohz() and tick_setup_sched_timer()
Message-ID: <ZYRXjf5v8Mz92QP_@localhost.localdomain>
References: <20231128092354.160263-1-pngliu@hotmail.com>
 <TYCP286MB21466A2954F68505833BB0A1C683A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCP286MB21466A2954F68505833BB0A1C683A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>

Le Wed, Nov 29, 2023 at 06:35:18PM +0800, Peng Liu a écrit :
> From: Peng Liu <liupeng17@lenovo.com>
> 
> The ts->sched_timer initialization work of tick_nohz_switch_to_nohz()
> is almost the same as that of tick_setup_sched_timer(), so adjust the
> latter to get it reused by tick_nohz_switch_to_nohz().
> 
> This also makes low-res mode sched_timer benefit from the tick skew
> boot option.
> 
> Signed-off-by: Peng Liu <liupeng17@lenovo.com>

Very nice! Thank you!

I'm queuing those two patches along with further cleanups.

