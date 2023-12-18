Return-Path: <linux-kernel+bounces-3701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7332817000
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4191C24221
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C937889;
	Mon, 18 Dec 2023 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYj0q5fO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C193788B;
	Mon, 18 Dec 2023 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702905039; x=1734441039;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=WbLnQ9aoedMi3fJhrH1mzNJbiZL9SUtmRPlN9Df9fHg=;
  b=mYj0q5fOxIq8VjXoYb9SU424K1vtz5kYIrqXh0b11J9qecJeSB6VItu0
   cjRe5HWEfZoi/ncaaEzep1bgSllb+bEVEiMLG2LEuK0tWB4Z9Qz1Wddn0
   PyRUyYQngqPbgHuxf3Bd3sfMDEdsJ17/i+cgeJazz8QU9172gaMbk+nbw
   2Q6yHcbo3VO7T9FQLj3FJ1t6Im/ROW2rArCQzAYXrXIdjyx73SOYdeiAW
   LuVcVtxrhS2uEC2MdaEnT7BIKuHiiY/78b5wWQpzNthdUujC3jijg3tlq
   s9bmyLzeBg9rH6QQ53GfDVmqx5OlfXG1lBKjewKp27k4LAsijuqh75Zoi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="461954268"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="461954268"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 05:10:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="768838605"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="768838605"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.56])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 05:10:36 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, Vishnu Sankar <vishnuocv@gmail.com>
Cc: mpearson-lenovo@squebb.ca, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, markgross@kernel.org, vsankar@lenovo.com
In-Reply-To: <20231214134702.166464-1-vishnuocv@gmail.com>
References: <20231214134702.166464-1-vishnuocv@gmail.com>
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: fix for incorrect fan
 reporting on some ThinkPad systems
Message-Id: <170290502941.2622.16136962059162731855.b4-ty@linux.intel.com>
Date: Mon, 18 Dec 2023 15:10:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Thu, 14 Dec 2023 22:47:02 +0900, Vishnu Sankar wrote:

> Some ThinkPad systems ECFW use non-standard addresses for fan control
> and reporting. This patch adds support for such ECFW so that it can report
> the correct fan values.
> Tested on Thinkpads L13 Yoga Gen 2 and X13 Yoga Gen 2.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: thinkpad_acpi: fix for incorrect fan reporting on some ThinkPad systems
      commit: 66e92e23a72761f5b53f970aeb1badc5fd92fc74

--
 i.


