Return-Path: <linux-kernel+bounces-90097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED586FA4C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EABC1C20B9B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97A311739;
	Mon,  4 Mar 2024 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AyR+At29"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85432B667
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535256; cv=none; b=YLz0VWvodf11B9xWLGDTibvnTHHdojdbUwrcgUTYGUpYz4CRoh1P5I0reJHZ7+Q8cX4RBD0Li5rHVMyQxAJ8Cru1Z218M9DylqZKMbKfRN/zeeGTE+GRvDNWToFlag5/pvechhEihAnIcm0FrUieb2ZBJjYwPj9l3PlAAFj5PWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535256; c=relaxed/simple;
	bh=qwDzqEF8GG32Owpd8pywxD5f8JJ2TAEnywKhR1/cXOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9OswZeEPZy/8mRismG+Glema4R1EHfF3Npyt2TStNeDRiLaV2mCKmC81dTcNTBwXzmH3HGKjdnxumeVtNL8P15DhdBosnlMbAejtSRoyTS/kR1zvH3Y9kty4hxcIUvzAvCkZPxKZH0SQJpH0JKGyyzJGjpby4WqS6k65Hmecpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AyR+At29; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8b276979aso3040856a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 22:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709535254; x=1710140054; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D8N5jw5DNhX96aWHAoC7hlIkB5rQeSq/PiKBnWFq/Kc=;
        b=AyR+At29tycugTFyvAD88OcftWwqUJPSTmMkqzCYjFEPjlqkhAwVkK0dja3izCWiMq
         0YNFa+lELgBwDwumD2xqsMyyXd3wLhcXRQ4RkD9pvwMxT0GgT6MLhTG3+yae1FrpZxkJ
         5DcvLPHrTYByTD05AlAYzDyN0MaMj3ZEWh/wFNUmyMmZeUwCAdRuKbedS+r3glABW7fa
         qvFe9xwoc+4fv8PLnCowSkn71C/N4nqoIK6z+6AyaTdHU3Mcobaij2JKtfpuJJLvKwc1
         x50TK6YvFaC8iYP25FKyoBDRUiN6VygDFV3bN6VhpSEz62DhOXKBmcGGCd9cVpDRo+xH
         5QsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535254; x=1710140054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8N5jw5DNhX96aWHAoC7hlIkB5rQeSq/PiKBnWFq/Kc=;
        b=vtq7ch4PtrLvdYFVgvYMN4QFGQZ/dEoEN+qFkWL2KDB768L+k2jty5B7JiEomyAmtm
         snOjPQoRkdrste9w2xWw+z+CPCnljNcy5l11nk4Gf63XuHBsIPl6N5lOABGcytp920ZO
         gzS8WEp8jKWLBdGVRZdp4SXhEjiB7HE7x0KIrT1oni0tEPJGlWdWCEnYvE6jywTEW8Kf
         qaYV/yd5UZvWYh3tdQ35a/mfpsIT8BYU5rE9OBr/3uzEPeQPT+nmzpXMsgQUTSuCrOAH
         q+HPxo8hEBbphLG2WzwsKsA3nVJOhJ9iy9gI2tYNEypdtRsx65zsTtyyybTmUrGb2tTd
         PNUA==
X-Forwarded-Encrypted: i=1; AJvYcCWVU/DcbZm6TXv3S0hifuP276WmAkdlNVhebHddu6FrtV017K/Ub1jAjqXdVRHiklyXpaPc72TR1lHnBULI9QEiTHso+lncla3sIWKW
X-Gm-Message-State: AOJu0YzF2e6pUy9I0iszfJJ5UH/1ZZcgFN302M1rrEWn51MwBMZ3ZEtp
	FO0ZnptEGiszk5fYwUTAXrA8insMb9+qC1PqAV1nlFYnTuaZgMcTCqL3WyKqquI=
X-Google-Smtp-Source: AGHT+IHz5qhAqvj0ld03y+Oe0fC9BOHVqZ8VG5Zk/vWgrlA+0AnapYB2A9wkUbEc3qSB4xAkQ6x+SQ==
X-Received: by 2002:a17:90a:a88b:b0:29b:33eb:1070 with SMTP id h11-20020a17090aa88b00b0029b33eb1070mr2853462pjq.14.1709535253867;
        Sun, 03 Mar 2024 22:54:13 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id y33-20020a17090a53a400b0029ab5abcbe1sm10102638pjh.20.2024.03.03.22.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 22:54:13 -0800 (PST)
Date: Mon, 4 Mar 2024 12:24:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Liu, Yujie" <yujie.liu@intel.com>
Cc: lkp <lkp@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: drivers/opp/debugfs.c:48:54: warning: '%d' directive output may
 be truncated writing between 1 and 11 bytes into a region of size 8
Message-ID: <20240304065411.w34vbaeg2rlq6z5k@vireshk-i7>
References: <202402141313.81ltVF5g-lkp@intel.com>
 <20240214055836.c5i3zmkhdllldwon@vireshk-i7>
 <b41c6cdb78c96d5f4a909fc13c253ef0d8576c86.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b41c6cdb78c96d5f4a909fc13c253ef0d8576c86.camel@intel.com>

On 21-02-24, 06:01, Liu, Yujie wrote:
> Hi Viresh,
> 
> On Wed, 2024-02-14 at 11:28 +0530, Viresh Kumar wrote:
> > On 14-02-24, 13:43, kernel test robot wrote:
> > > Hi Viresh,
> > > 
> > > FYI, the error/warning still remains.
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   7e90b5c295ec1e47c8ad865429f046970c549a66
> > > commit: 46f48aca2e5aef3f430e95d1a5fb68227ec8ec85 OPP: Fix missing debugfs supply directory for OPPs
> > > date:   5 years ago
> > > config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20240214/202402141313.81ltVF5g-lkp@intel.com/config)
> > > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240214/202402141313.81ltVF5g-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202402141313.81ltVF5g-lkp@intel.com/
> > 
> > I have informed this earlier too, this report is incorrect and applies
> > to a very old commit.
> 
> Really sorry for not responding timely to the questions in the
> following reports:
> 
> [1] https://lore.kernel.org/all/202311061847.BOtfUmbQ-lkp@intel.com/
> [2] https://lore.kernel.org/all/202312170608.s9xI4TQb-lkp@intel.com/
> 
> We see that this still happens on the latest mainline rc regardless of
> x86_64 or arm64 arch. Please note that this is a "W=1" warning. In our
> tests, it can be reproduced with gcc-12 and gcc-13, but not with other
> versions of gcc.

Okay, I have a different version of gcc. Can you see if this change fixes it or
not ?

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index ec030b19164a..986c08e18d05 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -100,7 +100,7 @@ static void opp_debug_create_supplies(struct dev_pm_opp *opp,
        int i;

        for (i = 0; i < opp_table->regulator_count; i++) {
-               char name[15];
+               char name[19];

                snprintf(name, sizeof(name), "supply-%d", i);

-- 
viresh

