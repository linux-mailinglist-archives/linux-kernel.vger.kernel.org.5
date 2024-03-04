Return-Path: <linux-kernel+bounces-90507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CB2870061
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EFEB2540F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6042138DFC;
	Mon,  4 Mar 2024 11:24:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC891B965
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551488; cv=none; b=ORvtu63Diaf19u1sQhNW7ndYBrqu1HbjPEjg+Du9JrqIXz9tbqmlYh/8weZCy+TkBm5OPNjA/krVSit7K1BqkAw5x5f7fAEr+v75CqYT+cbR5ztwWeAuJ6oDCaaKaqs5SUO7MlOvPa8dOUB/Wfuho4JbhwyPiQ+cjCV8McHH7Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551488; c=relaxed/simple;
	bh=GPG9L1TpZJ/NKcGaPGlmocBEfIDbkYYb0wrlQ3j6WrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaYS1gxm0FHHihMYf5S6bS+BZ/kYgi4Sy5mHFgsDGFgi7ubp8yZDKq/xwVf0YFH9bQ7FxoB00mNdffC4rXKcA//amTyOjzrupPsXImf8rKfsL0Q83+umWSubS7fwbACUzlVeyrMCC/jLFLtITmdYNmA3jpfqSpCVEo9JZvCAnMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFB081FB;
	Mon,  4 Mar 2024 03:25:21 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B65A23F738;
	Mon,  4 Mar 2024 03:24:43 -0800 (PST)
Date: Mon, 4 Mar 2024 11:24:41 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>, "open list"
 <linux-kernel@vger.kernel.org>, "Linux ARM"
 <linux-arm-kernel@lists.infradead.org>, linux-sunxi@lists.linux.dev,
 dri-devel@lists.freedesktop.org, lkft-triage@lists.linaro.org, "Maxime
 Ripard" <mripard@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: arm: ERROR: modpost: "__aeabi_uldivmod"
 [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
Message-ID: <20240304112441.707ded23@donnerap.manchester.arm.com>
In-Reply-To: <338c89bb-a70b-4f35-b71b-f974e90e3383@app.fastmail.com>
References: <CA+G9fYvG9KE15PGNoLu+SBVyShe+u5HBLQ81+kK9Zop6u=ywmw@mail.gmail.com>
	<338c89bb-a70b-4f35-b71b-f974e90e3383@app.fastmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 Mar 2024 12:11:36 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

Hi,

> On Mon, Mar 4, 2024, at 09:07, Naresh Kamboju wrote:
> > The arm defconfig builds failed on today's Linux next tag next-20240304.
> >
> > Build log:
> > ---------
> > ERROR: modpost: "__aeabi_uldivmod"
> > [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
> >  
> 
> Apparently caused by the 64-bit division in 358e76fd613a
> ("drm/sun4i: hdmi: Consolidate atomic_check and mode_valid"):
> 
> 
> +static enum drm_mode_status
> +sun4i_hdmi_connector_clock_valid(const struct drm_connector *connector,
> +                                const struct drm_display_mode *mode,
> +                                unsigned long long clock)
>  {
> -       struct sun4i_hdmi *hdmi = drm_encoder_to_sun4i_hdmi(encoder);
> -       unsigned long rate = mode->clock * 1000;
> -       unsigned long diff = rate / 200; /* +-0.5% allowed by HDMI spec */
> +       const struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
> +       unsigned long diff = clock / 200; /* +-0.5% allowed by HDMI spec */

Wouldn't "div_u64(clock, 200)" solve this problem?

Cheers,
Andre

>         long rounded_rate;
> 
> This used to be a 32-bit division. If the rate is never more than
> 4.2GHz, clock could be turned back into 'unsigned long' to avoid
> the expensive div_u64().
> 
>       Arnd
> 


