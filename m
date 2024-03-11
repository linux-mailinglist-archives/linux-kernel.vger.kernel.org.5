Return-Path: <linux-kernel+bounces-99504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E78287895E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FF01F21CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098BC5676F;
	Mon, 11 Mar 2024 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRZCIsUw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C6A53E2C;
	Mon, 11 Mar 2024 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710188503; cv=none; b=NhfWsiOQWN+32ruee9l+uTbzXCXy3p7HBsKIeGYDdh47BRfrfEHOuWP8TBZDzJ1I6oCKRQQxRvXQprGAPGeXBeoqi2buVoe+u5ljGYn4K6ZGTgbYMQM63+AwAGaBpcn/zCuV+8d/+0brx0VliqDN3Zw7EiRQ1Q/RiFFlCcgsYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710188503; c=relaxed/simple;
	bh=m0g91sXKYJS/kIzIdqTu2G6HaWEmgoKbDue6b3HELzA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=D7gD8ONUIFToxXSowm0jMjeuf2N9HcuVwOM73rdWXn6u+RNsbsRTb+l9Cjr/y54glTRlbU888E9qm6/JFBtPUfoANz1EJcQPVwmEJRFkZ8NSy0IW0h+8nXduIfwRAZn90xXowAEF+dhzv8s1z7DfNJzgWMJSG46iOpSp2kEhmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRZCIsUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D49C433C7;
	Mon, 11 Mar 2024 20:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710188502;
	bh=m0g91sXKYJS/kIzIdqTu2G6HaWEmgoKbDue6b3HELzA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fRZCIsUw+ltmZpj7Ioa6QyF4bBXq0ClTyx5UbpaGj0BwwmhEKNap0i2kmsFvMTfYH
	 uAF252gxfBFsafjM9Yuk4LafJYv3Me+15/ThPDqUT/zg6IVy0kX5DdZAEfIwHN5CJa
	 kaWzEkGHE7xv/n1Re/hQ6Xh2eldHCz0IXefPxRAdP4TN6IF7a3sTG3G7rzjwPKzjFm
	 9x7SzQmlcJu6w9SEwD1WoiYIV/WJ86JSJ9WMmBIwMVMwH/b8Ox9dwWhkJV1+UUAUt4
	 SeFUzsKgAL8hqx2FabponQ8JhErgPZBo8wt5HWubHhzrwi+E8LQSEkDhXyw5hd4fY/
	 Ptdw0KX8aKSVg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Mar 2024 22:21:38 +0200
Message-Id: <CZR7866WNY28.3KDPSXW81I82N@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rnsastry@linux.ibm.com>,
 <peterhuewe@gmx.de>, <viparash@in.ibm.com>, <devicetree@vger.kernel.org>,
 <jsnitsel@redhat.com>
Subject: Re: [RFC PATCH v2 1/3] powerpc/prom_init: Replace
 linux,sml-base/sml-size with linux,sml-log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <mpe@ellerman.id.au>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.17.0
References: <20240311132030.1103122-1-stefanb@linux.ibm.com>
 <20240311132030.1103122-2-stefanb@linux.ibm.com>
In-Reply-To: <20240311132030.1103122-2-stefanb@linux.ibm.com>

On Mon Mar 11, 2024 at 3:20 PM EET, Stefan Berger wrote:
> linux,sml-base holds the address of a buffer with the TPM log. This
> buffer may become invalid after a kexec. To avoid accessing an invalid
> address or corrupted buffer, embed the whole TPM log in the device tree
> property linux,sml-log. This helps to protect the log since it is
> properly carried across a kexec soft reboot with both of the kexec
> syscalls.

- Describe the environment where TPM log gets corrupted.
- Describe why TPM log gets corrupted on kexec.

>
> Avoid having the firmware ingest the whole TPM log when calling
> prom_setprop but only create the linux,sml-log property as a place holder=
.
> Insert the actual TPM log during the tree flattening phase.

This commit message should shed some light about reasons of the
corruption in order to conclude that it should be fixed up like
this. I.e. why the "post-state" is a legit state where can be
continued despite a log being corrupted. Especially in security
features this is pretty essential information.

BR, Jarkko

