Return-Path: <linux-kernel+bounces-90501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E938870051
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104F81F25146
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E9839AD8;
	Mon,  4 Mar 2024 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="htDr0LsP"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE738DC8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551267; cv=none; b=ExvGeOB84dxCW4DZfDDTJWOJ3CDEFjfIFOPZuViFXoxyX66cGUyDdA1izMOF1cLmsMO/VVkrGRMS82bhz7WHA2lPFSBU2UZoe+1URNJPVyuYn/j4ZLh+NoZuemZGUvlw8JIq1mLmOFYpiMMKlerRXDlE8ah725cNqHrFs5Z+WWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551267; c=relaxed/simple;
	bh=89CAsVYAN2zXiJyL10MU+anH7boWcF5E6pDAta4i614=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWd33hny76W8mFkTPvWgfJKJ77DdGHw4iS/NFGiKwWkB7O3w5VRBgvOzrGuPiXWFs2lVl7cTyVmNshsspkMQc93smWJDzjvvqNx5L125BK1CTgT8yn7KywOAT871Dvo3EWQhwTjiRQAv7x7y/WUXqJ9Tllpf6P9UKMqwveiT6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=htDr0LsP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6092a84f4so789085b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 03:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709551265; x=1710156065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=POpV966jVtwtLNbOuhb8nczXwEjbEx88TFd8lhRobks=;
        b=htDr0LsP6spCSDcKpeNpfI/C0mNx8huFFrwHxm173Ek6dunxUdsXZqa78/sZcL5njo
         aC1K247AuBZEdpv7kYHFvcFGIEeimEH+PR5gQsea8pStShyfFtB3Zh6fS7qUQpXH+DOx
         yAqQ1jKc614PaA7GsS1Y73rOg1SSbFzeJ6W0VzJZzCfkBbIlq6j+nNib9KE9z9IIPZPO
         wkwVRBiLxOj9sY+xC2AqdqFiK2J/ntSIHEs9luL3tC2rP5XP2jyXopTjec1ksiX5U3NJ
         L2B65eEm8O5O3/B2SxbxJxDbQ+PcyCyAJIsQ6ORnaZxFTjsp4OMESeE97mUGEI5AdCin
         mE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551265; x=1710156065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POpV966jVtwtLNbOuhb8nczXwEjbEx88TFd8lhRobks=;
        b=tB4Ezug74cLdnRNTxLnITzhDmJEIO6J1T1ydBXC5DiLzphaPPQN2hS36DBa66FT6Eg
         qHJ2wr/JDv17Yjt6Y2+2Yjm5QAk0HZoRDjSFKqR/W1Yc7oMCds4HOrYYuH+UYf3tZ+SF
         6lUPXk+qWqzXiWKMw+i7LrP9TzNV0vtkk8Fp5AZ5pC9zYSI2+9R+ROhPtlbxfylOQkVv
         dv4XVCDy8bdUbmBmKYqs8xel1jXI86CnNjBLKeNDkxaezXsZBNMqnx51ZIM0DJn7+qOA
         16f7D9TEE3a/IoW1mPSHk0b58BkEKrbHTqFSHWR3BU0fWKSoFjfgWGFAjx7xBdLB21ef
         8Pig==
X-Forwarded-Encrypted: i=1; AJvYcCXy70YMTBZVDe1HneGfRKZ6dQ19R1EAun9iFwZby9ZJvnOIK0yz59WyGEZ4zqa3FxdVjwY8bIxjkFCQK7L0rLxDE5+pGPTyZCQy7fMs
X-Gm-Message-State: AOJu0Yw3LJ8LuczcP5YcK3zsnAgMsA+9QpjsJ6wmi/Rr8owqfM+1xG1g
	mMOJgA4dfejuQiwYJVfjHAAn61TxetxLoo3rCDY4g5pNzNw8A2zAAkCZQ8N/JeE=
X-Google-Smtp-Source: AGHT+IHp9l8/9h1aPTyTCNgQKavrjxYrCX8+UQn+y6+tAOz+DZB+e6L22yyM+IfyPJ5hIGmpQczRCw==
X-Received: by 2002:a05:6a20:8403:b0:1a0:ebbd:9ae7 with SMTP id c3-20020a056a20840300b001a0ebbd9ae7mr6237970pzd.4.1709551265178;
        Mon, 04 Mar 2024 03:21:05 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id u19-20020aa78393000000b006e6233563cesm1469110pfm.218.2024.03.04.03.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:21:04 -0800 (PST)
Date: Mon, 4 Mar 2024 16:51:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yujie Liu <yujie.liu@intel.com>
Cc: lkp <lkp@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: drivers/opp/debugfs.c:48:54: warning: '%d' directive output may
 be truncated writing between 1 and 11 bytes into a region of size 8
Message-ID: <20240304112102.wih3u5ny3iero47n@vireshk-i7>
References: <202402141313.81ltVF5g-lkp@intel.com>
 <20240214055836.c5i3zmkhdllldwon@vireshk-i7>
 <b41c6cdb78c96d5f4a909fc13c253ef0d8576c86.camel@intel.com>
 <20240304065411.w34vbaeg2rlq6z5k@vireshk-i7>
 <ZeWGpyXXZBeYjnGW@yujie-X299>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeWGpyXXZBeYjnGW@yujie-X299>

On 04-03-24, 16:30, Yujie Liu wrote:
> This fixes the warning for "supply-%d". Seems there are other remaining
> warnings as shown below. Would you like to take a look as well?

How about this instead to fix all warnings (drop the earlier change
please) ?

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index ec030b19164a..a9ebfdf0b6a1 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -37,10 +37,12 @@ static ssize_t bw_name_read(struct file *fp, char __user *userbuf,
                            size_t count, loff_t *ppos)
 {
        struct icc_path *path = fp->private_data;
+       const char *name = icc_get_name(path);
        char buf[64];
-       int i;
+       int i = 0;

-       i = scnprintf(buf, sizeof(buf), "%.62s\n", icc_get_name(path));
+       if (name)
+               i = scnprintf(buf, sizeof(buf), "%.62s\n", name);

        return simple_read_from_buffer(userbuf, count, ppos, buf, i);
 }
@@ -56,11 +58,11 @@ static void opp_debug_create_bw(struct dev_pm_opp *opp,
                                struct dentry *pdentry)
 {
        struct dentry *d;
-       char name[20];
+       char name[] = "icc-path-XXXXXXXXXX"; /* Integers can take 10 chars max */
        int i;

        for (i = 0; i < opp_table->path_count; i++) {
-               snprintf(name, sizeof(name), "icc-path-%.1d", i);
+               snprintf(name, sizeof(name), "icc-path-%d", i);

                /* Create per-path directory */
                d = debugfs_create_dir(name, pdentry);
@@ -78,7 +80,7 @@ static void opp_debug_create_clks(struct dev_pm_opp *opp,
                                  struct opp_table *opp_table,
                                  struct dentry *pdentry)
 {
-       char name[12];
+       char name[] = "rate_hz_XXXXXXXXXX"; /* Integers can take 10 chars max */
        int i;

        if (opp_table->clk_count == 1) {
@@ -100,7 +102,7 @@ static void opp_debug_create_supplies(struct dev_pm_opp *opp,
        int i;

        for (i = 0; i < opp_table->regulator_count; i++) {
-               char name[15];
+               char name[] = "supply-XXXXXXXXXX"; /* Integers can take 10 chars max */

                snprintf(name, sizeof(name), "supply-%d", i);

-- 
viresh

