Return-Path: <linux-kernel+bounces-102773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C06E87B723
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C5282E87
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF23B8BE5;
	Thu, 14 Mar 2024 04:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nbXriEG2"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01677F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710390758; cv=none; b=k7bD+iiwCErd0x8JJ2wopHTRdiTDvbmSV4Nahrwi4kw9iGx2TVOS2RD+Y7tSOm/tI/B7CCBEvm0mpgKEKhkh4Cm1/ZFfQ1xlRZby/aqNYBGl1lGdVeqTWHC8/OVj7ATGfCt9LhiJVGHdzlp+QX9pME1O8Mp9xxlut32quD8O7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710390758; c=relaxed/simple;
	bh=GSj6N2Z5jD6x6imQv7iBhpCBB32EvpVYGf3Iyuhny8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnxB2q6/IVjCYIYQKQ/deXykyzJDRaDFruRgwNKh3RlpPeI0FC5za95ZdUcSikolj5yWl4y+KP9Pb/42qLwB5gKp5O5tLlVExXE4QivopKX3TWO5isF7PQiNm4nKWZR5NCHWICOYPH2zvawfRY1AidesB07VtgZj5bgaoi3AXUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nbXriEG2; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cedfc32250so407596a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710390756; x=1710995556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZMDI9m7lnsGUwRkadwDloxIr0GMZuZYDPZn2R+xRdM=;
        b=nbXriEG2wzoRvy68Y3cFQF25NJvO7QdPzbzyx7MNJcUT9yTWPgK0oWSjYh2sqLutYC
         6shaTEGcSr5myH1+3ckeYZ09dqIPeoQjEJyvOLI4jye7IXLeRc5HfdXvsuViszO7Zdgk
         RZYi1ngl72lCfAs+uVkKqAkZDeiSo7Vy325TQr0Hm9Z36Ab5jW+nViY4HTa7ECt3bnrT
         G6lq0Hmea720xb4MAZfc9FW6gUF16qFFMFUIEAtcIv3z9d5GhSGvGaw7iD8yp94IszLQ
         nkRgLPGc+N9YY/jA/mZZ+d75jNBYhF/RJTSzXDH0ScQHNHARoX/gAIOcIOwpbkXvUX3j
         r/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710390756; x=1710995556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZMDI9m7lnsGUwRkadwDloxIr0GMZuZYDPZn2R+xRdM=;
        b=TA05gc6dmmggWUGRv+VSTu36N++g5/Q4uhj1/3C0jEcWVjiit0y+yWLuBXPoXAeY0A
         ARZJ543Cy8pTDZlyzG2Tn4iCtOCnWpTyNIzlkr0WLSHYOXPiMX8LVviKJdtU3eUzuc0X
         01wRkHV7zE98AaM/lcgqFrowqQapLMbqfM9fRpEz2vRB2hcZHFXKuxDLxNkfna32zEft
         FXJqGJKgqEHIDOQstzIA68sD26cBuIBL6OTJeZsCKnrAesA4rCpZ6GbZuENP8euOrFml
         DaUScxOfB8fkncJ8Ac0kDkuxKzw//n4N6t4dYn61iE84PM9R35P2MZW/ORvpPYgGFqxd
         X5Jw==
X-Gm-Message-State: AOJu0Yy0gVNKm8NmLkq3OMXK9Qx4/5Olgo2lVwdcUn6lEHvlqaqoGC0t
	k4adTOCWo4ZwSusIMrCTtHjirJ3P3YN8ypM8kjyxb4P0YenKzPkZQcNU503Arf0=
X-Google-Smtp-Source: AGHT+IGOBFoaDHvogP/Kzo9KilJzG5K037wgFkT9Hny0OqT9XcmU03PRLAHfsPsDWFFLLkVfk/WTtA==
X-Received: by 2002:a05:6a20:734e:b0:1a3:4353:a281 with SMTP id v14-20020a056a20734e00b001a34353a281mr13781pzc.24.1710390755966;
        Wed, 13 Mar 2024 21:32:35 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001dddb6c0971sm499213ple.17.2024.03.13.21.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 21:32:35 -0700 (PDT)
Date: Thu, 14 Mar 2024 10:02:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the opp tree
Message-ID: <20240314043232.4jc4ipmwpz5erhn6@vireshk-i7>
References: <20240314084329.6c9c59dd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314084329.6c9c59dd@canb.auug.org.au>

On 14-03-24, 08:43, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   0b5466a8bc71 ("OPP: Extend dev_pm_opp_data with turbo support")
>   3678779d8b64 ("OPP: debugfs: Fix warning with W=1 builds")
>   6c9a1a56d316 ("OPP: debugfs: Fix warning around icc_get_name()")
>   ace4b31b297d ("cpufreq: Move dev_pm_opp_{init|free}_cpufreq_table() to pm_opp.h")
>   bde3127675ff ("dt-bindings: opp: drop maxItems from inner items")

Hi Stephen,

Sorry about that. While creating the tag for the pull request, I
rebased the commits and forgot to push my branch again. Done now.
Should match Linus's tree now.

-- 
viresh

