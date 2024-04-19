Return-Path: <linux-kernel+bounces-151722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8868AB2BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621A11F214DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0374A130AEB;
	Fri, 19 Apr 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yW03/0W9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA6D12FB3F;
	Fri, 19 Apr 2024 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542594; cv=none; b=WyxnBKkWdjG7zuawfoPqsETVLRftSpFuvlOkJJlvelmMUQkFPqIhN9+G8HZAL+SiHGMeZF4P1eFbMznjNRKZG1Q4QQ7XjhxXxruMRbc5vxiBEDTOdww1ALlm9YEnMmgjwXG/tG9exLxzf5p3cxsYEpGQHWm7QbLjB79th0X9pgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542594; c=relaxed/simple;
	bh=bzJYqm75Nty92Q/QO9EnWmJhEqlw+KyOW6BfHwHj1k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSB7L04y9ucw20TM77TYVKE6ObtBil+b2sSWw9fKXhldqsqBL2Az79zdXsBQFWDj1Ky7VPhXhRCMKStXHyVtkNOse9xe/+ZXKXWyRPw4JziwBTlhXLZvDK7FzdWBDKSWwZHlM4jhP4XZttlSCIvbJFCV1yyiKV5AJg9mJho8Rag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yW03/0W9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713542585;
	bh=bzJYqm75Nty92Q/QO9EnWmJhEqlw+KyOW6BfHwHj1k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yW03/0W9ckf3ZQXHVqD9Rnioq31j7y+rUfgl6WZOCWat+fIuUKU9P1ezSYxaUqeCT
	 tZkeiwOshAvSD8a5jhgyHpgwHHZtjNrDgs1y5sHuW/61T4+pSrYth2uOLNuro+5Obp
	 xstypApqPQObblBk244KJLFUKc47guLvO0HiJ8b1i60j0j1/pYSJtb8jqMZVOBcE6s
	 ZdImR1sfLPJeFfjOjsepEwa+qOabMz2YB1sGozUK1wb6XdGZipSOsi9FA3bJ04VJ/f
	 lOKYlWfCuxNwiCI+3NAWfAsQ2sVgHBGIXkxyax+Zk8KnAFj6vp2ikaoiRmOUQlm8fY
	 z/+NszSEWnA8Q==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 19A593780EC6;
	Fri, 19 Apr 2024 16:03:03 +0000 (UTC)
Date: Fri, 19 Apr 2024 12:03:02 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@chromium.org>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: Re: [PATCH v3] power: supply: sbs-battery: Handle unsupported
 PROP_TIME_TO_EMPTY_NOW
Message-ID: <cf4d8131-4b63-4c7a-9f27-5a0847c656c4@notapiano>
References: <20240418-sbs-time-empty-now-error-v3-1-f286e29e3fca@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418-sbs-time-empty-now-error-v3-1-f286e29e3fca@collabora.com>

On Thu, Apr 18, 2024 at 01:34:23PM -0400, Nícolas F. R. A. Prado wrote:
> Despite the RunTimeToEmpty() (0x11) function being defined in the SBS
> specification as required, it seems that not all batteries implement it.
> On platforms with such batteries, reading the property will cause an
> error to be printed:
> 
> power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
> 
> This not only pollutes the log, distracting from real problems on the
> device, but also prevents the uevent file from being read since it
> contains all properties, including the faulty one.
> 
> The following table summarizes the findings for a handful of platforms:
> 
> Platform                                Status  Manufacturer    Model
> ------------------------------------------------------------------------
> mt8186-corsola-steelix-sku131072        OK      BYD             L22B3PG0
> mt8195-cherry-tomato-r2                 NOT OK  PANASON         AP16L5J
> mt8192-asurada-spherion-r0              NOT OK  PANASON         AP15O5L
> mt8183-kukui-jacuzzi-juniper-sku16      NOT OK  LGC KT0         AP16L8J
> mt8173-elm-hana                         OK      Sunwoda         L18D3PG1
> sc7180-trogdor-lazor-limozeen-nots-r5   NOT OK  Murata          AP18C4K
> sc7180-trogdor-kingoftown               NOT OK  333-AC-0D-A     GG02047XL
> rk3399-gru-kevin                        OK      SDI             4352D51
> 
> Detect if this is one of the quirky batteries during presence update, so
> that hot-plugging works as expected, and if so report -ENODATA for
> POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW, which removes it from uevent and
> prevents throwing errors.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Hi,

I'm coming back with more information after some more testing has been done.

Most importantly, in the meantime, a parallel investigation uncovered that the
time_to_empty_now issue was actually in the EC firmware:
https://chromium-review.googlesource.com/c/chromiumos/platform/ec/+/5465747

So the other faulty properties (which I'll mention below) could also be due to
the EC firmware. These are the EC firmware version for the platforms with
additional issues:
* RW version:    juniper_v2.0.2509-9101a0730
* RW version:    lazor_v2.0.6519-9923041f79

Hsin-Te, do you have information on whether it's an EC issue in this case as
well?

The following table shows all the faulty properties per platform:

Platform                               Manufacturer  Model      Faulty properties
---------------------------------------------------------------------------------
mt8186-corsola-steelix-sku131072       BYD           L22B3PG0   -
mt8195-cherry-tomato-r2                PANASON       AP16L5J    time_to_empty_now
mt8192-asurada-spherion-r0             PANASON       AP15O5L    time_to_empty_now
mt8183-kukui-jacuzzi-juniper-sku16     LGC KT0       AP16L8J    time_to_empty_now
                                                                capacity_error_margin
								constant_charge_current_max
								constant_charge_voltage_max
								current_avg
								technology
								manufacture_year
								manufacture_month
								manufacture_day
								SPEC_INFO
mt8173-elm-hana                        Sunwoda       L18D3PG1   -
sc7180-trogdor-lazor-limozeen-nots-r5  Murata        AP18C4K    time_to_empty_now
                                                                capacity_error_margin
								constant_charge_current_max
								constant_charge_voltage_max
								current_avg
sc7180-trogdor-kingoftown              333-AC-0D-A   GG02047XL  time_to_empty_now
rk3399-gru-kevin                       SDI           4352D51    -

If it turns out to not be an EC issue for the properties other than the
time_to_empty_now, then quirks will need to be added for them. As for SPEC_INFO
it's fine to keep it the way it is, as it already fails gracefully by falling
back to disabled PEC. However it does mean sbs_update_quirks() would need to be
moved up in sbs_update_presence(), or it will never run when SPEC_INFO fails.

Also, the battery vendor for limozeen is actually "Murata ", with a trailing
space...

While at it, I also tested whether PEC was broken on all platforms (which have
the SBS battery behind the EC I2C tunnel) to see if it could have any relation
with the faulty properties:

					                        PEC
Platform                               Manufacturer  Model      Status
------------------------------------------------------------------------
mt8186-corsola-steelix-sku131072       BYD           L22B3PG0   NOT SUPPORTED
mt8195-cherry-tomato-r2                PANASON       AP16L5J    NOT SUPPORTED
mt8192-asurada-spherion-r0             PANASON       AP15O5L    NOT SUPPORTED
mt8183-kukui-jacuzzi-juniper-sku16     LGC KT0       AP16L8J    NOT SUPPORTED
mt8173-elm-hana                        Sunwoda       L18D3PG1   BROKEN
sc7180-trogdor-lazor-limozeen-nots-r5  Murata        AP18C4K    NOT SUPPORTED
sc7180-trogdor-kingoftown              333-AC-0D-A   GG02047XL  NOT SUPPORTED
rk3399-gru-kevin                       SDI           4352D51    BROKEN

Where on the platforms marked BROKEN all properties would fail like so:
power_supply sbs-9-000b: driver failed to report `status' property: -74

Those platforms indeed had PEC enabled:
<6>[   18.109211] sbs-battery 9-000b: PEC: enabled

and I verified the reported SBS version was SBS_VERSION_1_1_WITH_PEC.

Meanwhile, all the other platforms, marked NOT SUPPORTED, didn't actually have
PEC enabled:
<6>[   14.563070] sbs-battery 8-000b: PEC: disabled

which I verified was due to version SBS_VERSION_1_0 being reported (except for
jacuzzi, which fails to report a version).

So all platforms that had batteries that support PEC, have broken PEC, but most
don't support it. In any case there doesn't seem to be a correlation with the
properties that the batteries support, so it looks to be an orthogonal issue.

Thanks,
Nícolas

