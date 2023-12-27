Return-Path: <linux-kernel+bounces-11986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD1981EE82
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14671F218EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587B3446AD;
	Wed, 27 Dec 2023 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EFDg8o4s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C618446A6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2343c31c4bso575931266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 03:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1703675528; x=1704280328; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBVV0PEU9Ixo7XLjZnYGSo9vRDDhsR0F2qNKkSgsVpc=;
        b=EFDg8o4stg6DqcfnZjdoFgCRPDMxfvjYX1GK62MCFaCO80lucizZsAEgrQpec2YGFV
         /z7HSwZiL9GhESBGWQ4UxQWBH45PRtpGTfWkYRZIw4cy/j9QKXZkNoMJkSSoLKNIJwON
         kvXsdUPb1e75dkFuon88w+3T+dwjc3u4b15iwgpIY56U0EX1SjJjyuyLLhI+d7QCf7Uq
         XOGlHUZXNcksGB9Tgi4akXU7S+gVloiZSQ4JSTezeE8gKQqNbMFE0xvjw1fUoJCbQBtq
         IbKbsGH8SqfT1GORChZlrk3uhk7VudX1zTSFWListKvpgHMcy4nA1IGzdAnzPEAo2Pdj
         wPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703675528; x=1704280328;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBVV0PEU9Ixo7XLjZnYGSo9vRDDhsR0F2qNKkSgsVpc=;
        b=hspTillPSA2pbQ+zTXxAyWzTU+mTXwqvpZZ9OzXYXVSxJQ//me5K6g3e3x+P0G2D5a
         SWM3hOPI03+2nxt51nVvMLMzADD7vGJro+6WEC5LQgfdLbGBnzqu048PFLDmf8Wh7n4H
         sipwaULAFSzNMn8amafvv4WcphFhTm81Xb6sQCwgVBXZPqxZuh44BJ9+hkhDYbmyW6aU
         +SvVhR4An5khtX067Lh9Lr2jOYoL2YG7kC6ZZUnH/6fEWpY/Ytx4M55xjz+m0CB85Xil
         SobSrza/+fZmH5jPF9rDpWyDBN5g6n4gKnUYNjWzm3C/+VNhX6yJqrv2Dkd33cXbsJIx
         6fgQ==
X-Gm-Message-State: AOJu0YxeiSxcHOvXzIk/5pNS8kMOgR6ehOuq5iVa2rr7rflCF6wlSM9q
	++n+73S5QBR0JFVA2bmei1yXOTd9DV/euw==
X-Google-Smtp-Source: AGHT+IGzZWV5ur9CjQEtV+64thAuxA+gOAfookGHEM0PB7jmrpV10arquAMxnlPq8FB+om/ahwzGug==
X-Received: by 2002:a17:906:259:b0:a23:2e58:42af with SMTP id 25-20020a170906025900b00a232e5842afmr2398177ejl.20.1703675528598;
        Wed, 27 Dec 2023 03:12:08 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id zz15-20020a170907350f00b00a26c8c70069sm4468960ejb.48.2023.12.27.03.12.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2023 03:12:08 -0800 (PST)
From: Jiri Kosina <jkosina@suse.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date: Wed, 27 Dec 2023 12:12:09 +0100 (CET)
To: kernel test robot <lkp@intel.com>
cc: =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>, 
    oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: drivers/hid/hid-magicmouse.c:146: warning: Function parameter
 or member 'battery_timer' not described in 'magicmouse_sc'
In-Reply-To: <202312261056.AmFPDIL5-lkp@intel.com>
Message-ID: <nycvar.YFH.7.76.2312271211110.24250@cbobk.fhfr.pm>
References: <202312261056.AmFPDIL5-lkp@intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 26 Dec 2023, kernel test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
> commit: 0b91b4e4dae63cd43871fc2012370b86ee588f91 HID: magicmouse: Report battery level over USB
> date:   2 years, 1 month ago
> config: x86_64-randconfig-x066-20230529 (https://download.01.org/0day-ci/archive/20231226/202312261056.AmFPDIL5-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312261056.AmFPDIL5-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312261056.AmFPDIL5-lkp@intel.com/

Thanks for the report. Now fixed in hid.git as below.



From: Jiri Kosina <jkosina@suse.com>
Subject: [PATCH] HID: magicmouse: fix kerneldoc for struct magicmouse_sc

Description for hdev, work and battery_timer of struct magicmouse_sc were
missing. Fix that.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312261056.AmFPDIL5-lkp@intel.com/
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-magicmouse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index c9c968d4b36a..a46ff4e8b99f 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -120,6 +120,9 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
  * @scroll_jiffies: Time of last scroll motion.
  * @touches: Most recent data for a touch, indexed by tracking ID.
  * @tracking_ids: Mapping of current touch input data to @touches.
+ * @hdev: Pointer to the underlying HID device.
+ * @work: Workqueue to handle initialization retry for quirky devices.
+ * @battery_timer: Timer for obtaining battery level information.
  */
 struct magicmouse_sc {
 	struct input_dev *input;

-- 
Jiri Kosina
SUSE Labs


