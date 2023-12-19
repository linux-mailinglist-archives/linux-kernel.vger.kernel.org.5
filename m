Return-Path: <linux-kernel+bounces-5756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7D1818F24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5994D285EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8607A37D0F;
	Tue, 19 Dec 2023 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eH0XbKnD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279737D01;
	Tue, 19 Dec 2023 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703008984; x=1734544984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dy0g2043g4R4cRIKsX73h3cMyAW5a+xH1YG0AZtCpmI=;
  b=eH0XbKnDvMnBKc0P5ggqQDeD/pc5SjLqC1YmLBE5GfdmowQOn5hysz0j
   UO2DgmGj/RyK160+3SzEIx6iWX5CQnLtO8h86bOnx4yyrSOjrRqZmJBSh
   mU6EGxBHXjBHPngERI/kR3xxYrZPzhAQkZR82NViiTeugKg1zjB/0DsbJ
   EootblTLWLSlYFZimVPewOBNXOY01KrE/gClg03nf2Heg2KicTI0s5ngb
   w0Mur1HNg0WjTqzN3F+JnY2s8UhmfCOZjN1leOU/NDSb2lgI81W74Z+9G
   TqAUU3ejd4iC1r0WVRG/+ZXNiMGurYSid++cmstOaq3aYAr0SvlUeB0aQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2549497"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2549497"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 10:01:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="810313406"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="810313406"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 19 Dec 2023 10:01:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id B754C23A; Tue, 19 Dec 2023 20:01:02 +0200 (EET)
Date: Tue, 19 Dec 2023 20:01:02 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: make tb_bus_type const
Message-ID: <20231219180102.GK1074920@black.fi.intel.com>
References: <2023121904-utopia-broadcast-06d1@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023121904-utopia-broadcast-06d1@gregkh>

On Tue, Dec 19, 2023 at 04:43:05PM +0100, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the tb_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Andreas Noever <andreas.noever@gmail.com>
> Cc: Michael Jamet <michael.jamet@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Or you want me to pick it up?

