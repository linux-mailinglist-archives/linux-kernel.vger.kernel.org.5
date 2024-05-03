Return-Path: <linux-kernel+bounces-167567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F11D8BAB65
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF0B283530
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB96152184;
	Fri,  3 May 2024 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQWRtLFL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9531848A;
	Fri,  3 May 2024 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734643; cv=none; b=Ni5KJIYhQGEmWwAPF/2x/BEGOoL2ux42Ns0yFown6G+dlSLk90bKbtnkle9aewBA6B3YRVXGBSkC0cwuXC89Cmb0pOAg/8Z8hDzqTv5rX3KLc16TC8pgbR76MJEGW0nRHb/xsCsHDDV3poRdXfmXNiRIhvI/YR9BxpNk9IzwZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734643; c=relaxed/simple;
	bh=TXVTCxlS48ESbvsXtvuPdx5g10Ii+VtiVOrBQtcKVr8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p1a37kIjmQEXpczDpFOLvltNVUDx0CD/c979A2gNQN2jdvXiH0a0fpTILnoeomgyghDsdhcynMliVmlh403H7L5kddaNuC+9uq8c3G9EZ99sikHB0CKT5c3ok32NE1LbqDxigliOrYzT4lGvaxgT82rVvLWmegeo8MMSnQWa6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQWRtLFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34717C116B1;
	Fri,  3 May 2024 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714734642;
	bh=TXVTCxlS48ESbvsXtvuPdx5g10Ii+VtiVOrBQtcKVr8=;
	h=Date:From:To:Cc:Subject:From;
	b=AQWRtLFLE9KIeykwOMK0wCp4VGQdSMGTu04HP8UVd6eoQM+KxcwyBT3mJVPQh+C15
	 mAzqsTz8xujk53hQJbouYOAtCW+TEuBZ/noY0oo9OkRsyqDucw9MN2cg6AIbPpEt/H
	 DQc0QpH7mer1QtAaOEQ7NYeKedZ9UXJYADzsDpYNkIBkJTW2phUYq4rOXlGffoDJ7P
	 nDI29AynJeb3v0px31ewyrjgzxGihKc4YzIOoaMGUo3r7OtfpJHL0CuaizOHGyf12S
	 ryaj6bzjMR93OwtF3X49rfiREtPLxkywNuHWiiO9GxKl0NyG/Spw1hXkCRyVwVrxzM
	 tf9P8giuZsDTA==
Date: Fri, 3 May 2024 12:10:37 +0100
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 6.10
Message-ID: <20240503111037.GA17940@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Joerg,

Please can you pull these Arm SMMU updates for 6.10? Similarly to last
time, we have quite a lot here mainly thanks to Jason's ongoing rework
of the SMMUv3 driver in pursuit of full support for IOMMUFD.

Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to 56e1a4cc2588a7cb9664457a62fd7a77e005aa01:

  iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry (2024-05-01 15:33:53 +0100)

----------------------------------------------------------------
Arm SMMU updates for 6.10

- SMMUv2:
  * Support for fault debugging hardware on Qualcomm implementations
  * Re-land support for the ->domain_alloc_paging() callback

- SMMUv3:
  * Improve handling of MSI allocation failure
  * Drop support for the "disable_bypass" cmdline option
  * Major rework of the CD creation code, following on directly from the
    STE rework merged last time around.
  * Add unit tests for the new STE/CD manipulation logic

----------------------------------------------------------------
Aleksandr Aprelkov (1):
      iommu/arm-smmu-v3: Free MSIs in case of ENOMEM

Georgi Djakov (5):
      dt-bindings: iommu: Add Qualcomm TBU
      iommu/arm-smmu-qcom-debug: Add support for TBUs
      iommu/arm-smmu: Allow using a threaded handler for context interrupts
      iommu/arm-smmu-qcom: Use a custom context fault handler for sdm845
      iommu/arm-smmu-qcom: Use the custom fault handler on more platforms

Jason Gunthorpe (13):
      iommu/arm-smmu-v3: Do not allow a SVA domain to be set on the wrong PASID
      iommu/arm-smmu-v3: Do not ATC invalidate the entire domain
      iommu/arm-smmu-v3: Add a type for the CD entry
      iommu/arm-smmu: Convert to domain_alloc_paging()
      iommu/arm-smmu-v3: Add an ops indirection to the STE code
      iommu/arm-smmu-v3: Make CD programming use arm_smmu_write_entry()
      iommu/arm-smmu-v3: Move the CD generation for S1 domains into a function
      iommu/arm-smmu-v3: Consolidate clearing a CD table entry
      iommu/arm-smmu-v3: Make arm_smmu_alloc_cd_ptr()
      iommu/arm-smmu-v3: Allocate the CD table entry in advance
      iommu/arm-smmu-v3: Move the CD generation for SVA into a function
      iommu/arm-smmu-v3: Build the whole CD in arm_smmu_make_s1_cd()
      iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry

Robin Murphy (1):
      iommu/arm-smmu-v3: Retire disable_bypass parameter

Will Deacon (1):
      iommu/arm-smmu-qcom: Don't build debug features as a kernel module

 .../devicetree/bindings/iommu/qcom,tbu.yaml        |  69 +++
 drivers/iommu/Kconfig                              |  25 +-
 drivers/iommu/arm/arm-smmu-v3/Makefile             |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 167 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c   | 465 +++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 559 +++++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  60 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c   | 496 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   8 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h         |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  20 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   3 +
 12 files changed, 1530 insertions(+), 345 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,tbu.yaml
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c

