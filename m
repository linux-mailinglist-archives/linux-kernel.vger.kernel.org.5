Return-Path: <linux-kernel+bounces-162137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B54A8B5689
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128FC1F20E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2E640872;
	Mon, 29 Apr 2024 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IF48j8qN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B255F23772;
	Mon, 29 Apr 2024 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390074; cv=none; b=SEzS+abuXdxKB9lg6UsH5RWIRvgs3kWI5QNtEtGqGUacqA2oZBxNuMzfiCtpQaAmiePu6djUMMwZZGo45G4l05RnwJe+phlXVq70CN8v1T+iuHNTeHNMP3bIUXtltAwrVCW+l1SCkOsPySjk+BymOGOlI8bhpLonEGgNw83ocsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390074; c=relaxed/simple;
	bh=aKvg3KEps3tM2Kj6EjXlb4/nIS7PP+1b1pbgoXobQ18=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AIT2Z4jP0Xxq6xpMGHirLiN4aUF5bOD+Tm91trTzDPvD/saYpiRwHjtdTe8EECn5eq6bgiuWp/mSnIteLaZNEafRhVMdff29AtCjML8TLqerysSD/xZFgh/b+NSVlP8oGIVCAZ1kcSpRMmXKuKaQYJoqxHI+Ytaa5WwG/E/5D5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IF48j8qN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714390073; x=1745926073;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aKvg3KEps3tM2Kj6EjXlb4/nIS7PP+1b1pbgoXobQ18=;
  b=IF48j8qNZBDLdUSsmGp3eQu8XI030aiJPrbvuM6qsTs1GkcqakZXtedd
   GLHDoACNmaf/I6Un33GiYprk5N3V9duQP9pprExoNoBeHIEyHTTC2m8cL
   B3eIDTxIamGnO4TTq79m3Ig/sEz3OHNYGje7aqjwBrTfXJQIthAkjWT3Q
   0SA6ieBbKo5mELV/Dy1Pn5RM/sprhIHALUY5D37PZF4L9c3U5AOPthkB9
   njlEfimceREOofdWinyKTkCN7+8i3MM6vpG4RIy2KrVoYvnAALsZ0IY3q
   NvXL2q5yfgWn4mWjdaTC+Ib5ow9dngFP7wZIumep8QHVn7f5Z/FIpfx7d
   Q==;
X-CSE-ConnectionGUID: UHjW3qLJSmijXc6OVl/a8g==
X-CSE-MsgGUID: x0bwdYgRTfWAeOTnL4ucRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9919077"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9919077"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 04:27:52 -0700
X-CSE-ConnectionGUID: Knd1WZYDTCypwlGxyzqaSw==
X-CSE-MsgGUID: HF/kEQONQVSl8ALaxGojWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="56964054"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 04:27:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Apr 2024 14:27:46 +0300 (EEST)
To: Hans de Goede <hdegoede@redhat.com>
cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    markgross@kernel.org, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: ISST: Add Grand Ridge to HPM CPU list
In-Reply-To: <f7ff317b-f91b-429c-ac09-61b338264890@redhat.com>
Message-ID: <4a5d6fb2-4082-dab4-8f91-5bfb83e6ee30@linux.intel.com>
References: <20240422212222.3881606-1-srinivas.pandruvada@linux.intel.com> <f7ff317b-f91b-429c-ac09-61b338264890@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 29 Apr 2024, Hans de Goede wrote:
> On 4/22/24 11:22 PM, Srinivas Pandruvada wrote:
> > Add Grand Ridge (ATOM_CRESTMONT) to hpm_cpu_ids, so that MSR 0x54 can be
> > used.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> This looks like it needs to be applied on top of the fixes branch, or else
> after 6.10-rc1 is out.
> 
> Ilpo, what do you think ?

I've now taken this into fixes branch.

-- 
 i.


