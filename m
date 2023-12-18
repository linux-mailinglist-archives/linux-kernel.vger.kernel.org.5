Return-Path: <linux-kernel+bounces-3702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA28E817004
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DBF7B22AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F323A1BE;
	Mon, 18 Dec 2023 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afb0pqAF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB033789D;
	Mon, 18 Dec 2023 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702905047; x=1734441047;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=PYbB1Hwg0GCaCr97yxgow7pC3RiTKiDVygzzAo+x+zM=;
  b=afb0pqAFLmoxG/hXrI42zVHMyBk0bjcTDsa63bG593+fKEclivfH1gMP
   XLSvPRotvWvTC2CDOgjDdbRhHAz/dRaEj6QeiaxFt/9wjA3sfLwmdySIt
   oz3DujEkUjQdpwhFVM1Q7urXz2gVuU7/zPL/Z1HpJAMkdnebkPFrS3nyA
   z2lrP0VR4Cu0j2FO2Qfp4z+LHkggsJpNfab4lUUsIwBCWlfMD/MlcFUjf
   EIfotZS9w9HVB/j3CKe6O5aaKhRCjYyC61cXRJeyJzXyJAO2qG0F6jATP
   5KVeQKHCz4p46binFwIqLPvVDn1rcEI9F8c+jf48COo6aVTSw2kxGTsFc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="461954284"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="461954284"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 05:10:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="768838684"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="768838684"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.56])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 05:10:44 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@intel.com, hdegoede@redhat.com, 
 markgross@kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rjingar <rajvi.jingar@linux.intel.com>
In-Reply-To: <20231216011650.1973941-1-rajvi.jingar@linux.intel.com>
References: <20231216011650.1973941-1-rajvi.jingar@linux.intel.com>
Subject: Re: [PATCH 1/2] platform/x86/intel/pmc: Fix hang in
 pmc_core_send_ltr_ignore()
Message-Id: <170290503829.2622.8102265801801042918.b4-ty@linux.intel.com>
Date: Mon, 18 Dec 2023 15:10:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Fri, 15 Dec 2023 17:16:50 -0800, rjingar wrote:

> For input value 0, PMC stays unassigned which causes crash while trying
> to access PMC for register read/write. Include LTR index 0 in pmc_index
> and ltr_index calculation.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86/intel/pmc: Fix hang in pmc_core_send_ltr_ignore()
      commit: fbcf67ce5a9e2831c14bdfb895be05213e611724

--
 i.


