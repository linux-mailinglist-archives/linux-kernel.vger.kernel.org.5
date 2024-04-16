Return-Path: <linux-kernel+bounces-146791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B143E8A6AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BB71C214C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F3512BF2E;
	Tue, 16 Apr 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORilsQcr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB19A12BF21;
	Tue, 16 Apr 2024 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270740; cv=none; b=aXEWyH34FBVXdpH5dqmfshEFrsoXjO98PUFGfhf7B9nXVYZY7dfpoVDi3nSLh5NzhnyFqkb8WkLCmZTdhyLbcSBh8SFq7T7HwwAMhycDXTYZualqZ/2CY9loMppELIgQo7GfYSed7uHTLk5wDRDILIBFg+3v2gmn6jegJozKZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270740; c=relaxed/simple;
	bh=fgYWtZcf1kP/Yj20HbuQ4yd3wFIQUmQrfWTi6edOk2E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kk9Dy1KUCbJjJRQci4c9YaGcMU+B0m0OZYhlKZBoiAwzr5qWNd/mWGqC3yPLRxW5JWSXygiSLs0eGlJEBSFv/1j6/zgth4Hr7gYSZiDtyOwZCK9rNdbno+TSnsAbjwtdccRd/jK4l5aFLkZaQtAqt8WqJw3JikcOx4TKeu10smI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORilsQcr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713270739; x=1744806739;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=fgYWtZcf1kP/Yj20HbuQ4yd3wFIQUmQrfWTi6edOk2E=;
  b=ORilsQcrXytrX3QoZ2LuRrc4MV1BmssL9GRZo99qWQWAl+amh0ZYr2oy
   udw+95C6bRmQIZvXRROBId3aP8fdDl5PpgKlY1cv2qBsjm/dIOot0LzV4
   WQz9VPlGDnTHMrdi3ezFjaNDbOUDKzGcPQLFze4YvTL8seqOO2+at3x07
   Q1Vil/k4TAbw8/hWRUAad7r8kQZmKFmO4+6/OIaym31yfw9UziKQOVw3o
   9g9C7cpCjF19sLdZJW8+xQLjMlyxsmE2aKkyGDKUjcaj7aS6moCJknKbr
   6/LBqUkFDM8Nn7pSdHWayxd4OB0AkysaKdNPRUsx/jEiSAneKP3oQ8tGx
   A==;
X-CSE-ConnectionGUID: gyabEHlSQvuI19ZR9yIe+A==
X-CSE-MsgGUID: PflqKzkDR0ajZscaJk4aDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19307472"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="19307472"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 05:32:18 -0700
X-CSE-ConnectionGUID: xP+xIbBIS3CKwN3PSxqXeQ==
X-CSE-MsgGUID: 1/hHeec1T+i8TCMKmDjydg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="59696834"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.34])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 05:32:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240415220625.2828339-1-srinivas.pandruvada@linux.intel.com>
References: <20240415220625.2828339-1-srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Increase minor number
 support
Message-Id: <171327073041.3662.9594965075295921294.b4-ty@linux.intel.com>
Date: Tue, 16 Apr 2024 15:32:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 15 Apr 2024 15:06:25 -0700, Srinivas Pandruvada wrote:

> No new changes will be added for minor version 2. Change the minor
> version number to 2 and stop displaying log message for unsupported
> minor version 2.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel-uncore-freq: Increase minor number support
      commit: bc774d46b41482534c7ba92f6342ca0a355c13af

--
 i.


