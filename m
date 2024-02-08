Return-Path: <linux-kernel+bounces-58426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9860E84E662
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53435284425
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF28485C64;
	Thu,  8 Feb 2024 17:10:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3D8175C;
	Thu,  8 Feb 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412220; cv=none; b=AOyBV9LwAcrmFi9EqhSbAF91d9mT4i6O/ySwwGVV9rvshfidSSuwQRmbuD08gPW/GYjeYdDb82/8DahPUDFMX3V+hUbQ5swMlXlR1IteJnrmFRJjv8utAL1/aHFfePTkvSeMmmvDorrybYqzY9Oi4iwmaRWfiCvh84GVVixF/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412220; c=relaxed/simple;
	bh=EiTp+QZUzfGgdscwX8fv/V9k4Fpp4fsSWE+eCvZ+iyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROmU5C2Eive6e2WMlQ/yn1fRXd/vsiybL5ZckkNV1lgeLa057E82m7j2gRkuo9dgH3Zx5mlZAtDTkrkk3kwSQbePt3iY9MisWMjdFlYAHRJyPqeDm3QzjaLlBtghY6U8xd9cs25fRSktcSeR4cN530DZr+xsFzP5C8eNBx4kYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261CCC433F1;
	Thu,  8 Feb 2024 17:10:17 +0000 (UTC)
Date: Thu, 8 Feb 2024 12:10:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
 <tony.luck@intel.com>, <bp@alien8.de>, <x86@kernel.org>,
 <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: Re: [PATCH v3 0/2] Update mce_record tracepoint
Message-ID: <20240208121013.1946ef7f@rorschach.local.home>
In-Reply-To: <20240126075800.1174583-1-avadhut.naik@amd.com>
References: <20240126075800.1174583-1-avadhut.naik@amd.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jan 2024 01:57:58 -0600
Avadhut Naik <avadhut.naik@amd.com> wrote:

> This patchset updates the mce_record tracepoint so that the recently added
> fields of struct mce are exported through it to userspace.
>=20
> The first patch adds PPIN (Protected Processor Inventory Number) field to
> the tracepoint.
>=20
> The second patch adds the microcode field (Microcode Revision) to the
> tracepoint.

=46rom a tracing POV only:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

