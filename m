Return-Path: <linux-kernel+bounces-64762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA93D85428F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AA9282C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE0310971;
	Wed, 14 Feb 2024 05:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajwHwaZG"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2130BD310
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890323; cv=none; b=csKYweMJbpY5zWzMIJf6MAbsbONKvP6o58L0zmn9r+LqtaR3J0/WTu591eiOhB6/y7+sCwOliR9RYNK0W+UVOTgGh3hRupxajQUyqQ08KHiU/q8ndqzP1W6JjTunQT9VKybGe64YaYE8fbviu/v584BSGlrXSLPveVljTyBO4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890323; c=relaxed/simple;
	bh=ZcqxcjQxDebT5CbvXKPEB85P6WxkC7BjuKlGqRqGBgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF/eCg7XuBY5owOzcl5hxA4YdoSrZMAuT+5UfwrX4lNwhAWkmVfehzOounxgx6kr6mN5DoGHtwszKlOd/MzEfaoftBOtbPmuCttI1sQVwpZSgTNUj/5llqfRTcfQWlk96dHxmdN/PYFf0bP6t+S0zvrGCCS6fZqypV5TGBO5NlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ajwHwaZG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d932f6ccfaso37189775ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707890318; x=1708495118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nY08EkkPJUeVUObPeyFdb1hWJ0D/OitTX82rprubt28=;
        b=ajwHwaZGRnD1R1TRE5y+xDZRjsEL+pzXFov9xrE6MTtgnaRCZJu5b1fE6z72nUswqm
         AvMl3e2mmw/Qc3q8O9gvH4kwGMtaiyPKKxCckSBzXv71zNyuIXKmMIVRxnlCCwPc5Qrb
         HbM4kGh3F5Zj8DLLYNLwlYlPlV2MCU4vihola5vRSNVCvlc1RaT02ti71j2ehFXbeefr
         LAijiDfL0uGG0ZIaxHEogMgPG/ddX8LxYGbIHcDeoA8z3j1oRB4FkXvu+PQQEnve3SL9
         TEe7gvsg1t1XW0JxdoYokKhs6gr2gWgSNa2TtmEqYpJ+uOgANM+QstoHbgLvdGdL99IV
         cDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707890318; x=1708495118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nY08EkkPJUeVUObPeyFdb1hWJ0D/OitTX82rprubt28=;
        b=LkD9YhDuqPmlOdEvML6Qw6IwL5/V5b3dGjOTxp4IY3taVZuCdtxn1ptaqSObM36g6w
         Ep0qQqAVp/ipir8pxEHE/HmJpyJRY7sZ8myBp3/I3PPa7b27ZTH0eobX5zKU89xrS/SI
         Yija/lXGm0ubJ/uiVKxMwVRZm9gIDzW8d2Emg1dwn3qLVrdCiZSJKzxFQFnvRDNFIvah
         rCmNpZcVvaSj09VXIl9qJ1qou3yRwV0tHVDo7FW7xkY2l9fLCs0hRUE0IFxrlNF8W4zs
         BIozY8TaKNPhxaxNiFO3WdJ036yHVccf1ZFRm3xmb3P+R1TnNDywQ+Q90KuNxfC2DG0f
         J74A==
X-Forwarded-Encrypted: i=1; AJvYcCUn2zbjGMZsA2nuZIQ7ZXVq+WxJeMvS19ZFyR7rU/lSiR1/i8asNs7IDzTHbp94MLXP267eKKWFLD6f65msmYIID3kqiXPjNcM4MYx4
X-Gm-Message-State: AOJu0YyTn4XHKW5orMZjo3s1DbHnHT3uf7z4EScjzJE0R9aMY6b/9tD3
	+rXp3Cm3veO6aGk5cgsncy0oN9zhD8sr14mptcHBLEwCRzZcErihUM/GxHwiTek=
X-Google-Smtp-Source: AGHT+IGhQ7H2Zp/0O/Pg0ufvkyGVHSn7dTBcgVXoYEUm94RfKCVKGGx5r5Tk819uhm7fp8LAAnNK2A==
X-Received: by 2002:a17:902:708c:b0:1d8:f071:5067 with SMTP id z12-20020a170902708c00b001d8f0715067mr1822353plk.35.1707890318439;
        Tue, 13 Feb 2024 21:58:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiv7v0g/VUOGhVZtdAvl5qwTiaKnmJDlU0BzdcWc+GYFLjbNOKuuavSx1zq806FNjT0Zzka810dkxtLaZqvb2fLatR1+EYjNH9LAsE+txrDrs96kKtbwN97fDiH4oex5XGySkqeA==
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id jk5-20020a170903330500b001db4f25b168sm859730plb.255.2024.02.13.21.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 21:58:37 -0800 (PST)
Date: Wed, 14 Feb 2024 11:28:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/opp/debugfs.c:48:54: warning: '%d' directive output may
 be truncated writing between 1 and 11 bytes into a region of size 8
Message-ID: <20240214055836.c5i3zmkhdllldwon@vireshk-i7>
References: <202402141313.81ltVF5g-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402141313.81ltVF5g-lkp@intel.com>

On 14-02-24, 13:43, kernel test robot wrote:
> Hi Viresh,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7e90b5c295ec1e47c8ad865429f046970c549a66
> commit: 46f48aca2e5aef3f430e95d1a5fb68227ec8ec85 OPP: Fix missing debugfs supply directory for OPPs
> date:   5 years ago
> config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20240214/202402141313.81ltVF5g-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240214/202402141313.81ltVF5g-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402141313.81ltVF5g-lkp@intel.com/

I have informed this earlier too, this report is incorrect and applies
to a very old commit.

-- 
viresh

