Return-Path: <linux-kernel+bounces-123404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22C890815
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BD3298FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91287D07D;
	Thu, 28 Mar 2024 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtiIMkQm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BB1879
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649748; cv=none; b=kNnzQkYABSrdOfSP4q0ApOi7hCHWfUqp1BMLGdmWiSYQX68IBdulwZ/xlwQBidzsPnnqAhKzMgBR0V9O8E+hvl37GN5sLoJM+AqcgoDrwVpFEbHsoJGirYHJMK6QTD70FaOjVhrt63eIfVVduWKl/uecxRYrUToK/t7dMOpJzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649748; c=relaxed/simple;
	bh=rIL/RbCTqRPeLSNUR01+nAhLNjjxpyUuDFgGJNbe3gk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QDV42LSp2oTyrnPaAzMs3aPd/uKVrQs9bhxzDrDDAt2iWlmAs2ADy/CWD2R8qvK1wnfKR/qNeLWefykjbxTkAEPVgob8pGHNDF1sFGhFyQAm5gaTLe8TsOee0Nx4sA86EpQrpGScBwMsT6zd0pGPsLSJYIb4a2M3uD0zo9yByDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtiIMkQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72449C433F1;
	Thu, 28 Mar 2024 18:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711649747;
	bh=rIL/RbCTqRPeLSNUR01+nAhLNjjxpyUuDFgGJNbe3gk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CtiIMkQmCh9a/0N/3P2DLD0QhLHp/Kt9fbxbPQ3ssIYyckRTxinp8lfwYUpzO/jac
	 fMlHWcbfiiIzdQyKdC9bgxtCB35ZsJraQtdF1pB8tMmXpA8hg44HW9S2J2cFYxGnOB
	 yo7iD+WWFCKD8xqz29xGf422wyt8O+EHbXzO4K+Iqc0EtCtr/kVjxmK/4VznQvWNY7
	 t69gA4hN1ZDPlb19F39mUW9jZ0cYAH7rydGF9yMraDsFnf7bBb9kXkrrqSKSQRFzrU
	 q0N3teu3U99JwA0RmmEDyBSbE5WAUbdZxlZSTzF4Pmd3bXx1B9lb/RQKH0mJb4f8gj
	 2OCCBPT/3vbMQ==
From: Vinod Koul <vkoul@kernel.org>
To: alsa-devel@alsa-project.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
In-Reply-To: <2024013025-spoiling-exact-ad20@gregkh>
References: <2024013025-spoiling-exact-ad20@gregkh>
Subject: Re: (subset) [PATCH 0/7] Soundwire: clean up sysfs group creation
Message-Id: <171164974294.128475.17340584183341425045.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 23:45:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 30 Jan 2024 10:46:26 -0800, Greg Kroah-Hartman wrote:
> Note, this is a redone version of a very old series I wrote back in
> 2022:
> 	https://lore.kernel.org/r/20220824135951.3604059-1-gregkh@linuxfoundation.org
> but everyone has forgotten about it now, and I've reworked it, so I'm
> considering it a "new" version, and not v2.
> 
> Here's a series that adds the functionality to the driver core to hide
> entire attribute groups, in a much saner way than we have attempted in
> the past (i.e. dynamically figuring it out.)  Many thanks to Dan for
> this patch.  I'll also be taking this into my driver-core branch and
> creating a stable tag for anyone else to pull from to get it into their
> trees, as I think it will want to be in many for this development cycle.
> 
> [...]

Applied, thanks!

[2/6] soundwire: sysfs: move sdw_slave_dev_attr_group into the existing list of groups
      commit: b1b11bb07898b7e0313438734c310100219e676f
[3/6] soundwire: sysfs: cleanup the logic for creating the dp0 sysfs attributes
      commit: 3ee43f7cc9841cdf3f2bec2de4b1e729fd17e303
[4/6] soundwire: sysfs: have the driver core handle the creation of the device groups
      commit: fc7e56017b51482f1b9da2e778eedb4bd1deb6b3
[5/6] soundwire: sysfs: remove sdw_slave_sysfs_init()
      commit: f88c1afe338edbcbfd23743742c45581075fb86c
[6/6] soundwire: sysfs: remove unneeded ATTRIBUTE_GROUPS() comments
      commit: 91c4dd2e5c9066577960c7eef7dd8e699220c85e

Best regards,
-- 
~Vinod



