Return-Path: <linux-kernel+bounces-16559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0747824033
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5E61F2531E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15511210FC;
	Thu,  4 Jan 2024 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwgEweuG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CF20DFE;
	Thu,  4 Jan 2024 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704366190; x=1735902190;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8AD2mwTpSOPN46qJMOG/GtGnn6omFmnzhTc8pTVXNhU=;
  b=PwgEweuGi/rFmWd9lQS6VeKmMRBCq8msbpc/d96jazTg+zbh24wLEr7T
   8zpapTO4+o+y3LYVq3nb717DzGBi6U1TQlqvhuQqJ7EJm3v67lgzkiCzs
   fWgeqruZ22UfWhKg7icby5IdorrgNtC9HmtDOV963Ww32nOoGewU4CzU3
   dsrNwH1yOzVUMWagyL7aIEDTfCxusQP5QCWpKGLC1synQiZTxgjPY5Jd6
   gOV/dooV8v4XCuBDtoJgQp9LfkACzYliA+y9v1iUFmavn7VuXdC2OtlNS
   4XMCVjxrwLIMXV+VYEhyn31Kvnyf/gclGkK2Kd8LuVRfAe24w/jfblsU5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="400991924"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="400991924"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 03:03:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="814597939"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="814597939"
Received: from pdelarag-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.32])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 03:03:07 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, Mauro Carvalho
 Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] scripts/get_abi.pl: ignore some temp files
In-Reply-To: <87plyi86zg.fsf@meer.lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231228233113.5218-1-rdunlap@infradead.org>
 <87plyi86zg.fsf@meer.lwn.net>
Date: Thu, 04 Jan 2024 13:03:04 +0200
Message-ID: <87v889z7h3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 03 Jan 2024, Jonathan Corbet <corbet@lwn.net> wrote:
> It would have been nice to create all of those files with a .abi
> extension so we didn't have to do this kind of blocklisting, but so be
> it.

Alternatively, we could switch to yaml instead of using another homebrew
format with another homebrew parser, and rename them .yaml.

BR,
Jani.


-- 
Jani Nikula, Intel

