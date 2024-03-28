Return-Path: <linux-kernel+bounces-122776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9003688FD14
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F79B2714F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FDA51C5F;
	Thu, 28 Mar 2024 10:32:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76B57334
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621932; cv=none; b=m5GKuWoC+ONhrj51d9JRP5ISHieinSVdoAeuuVBpSj4iVi5jVvz+o8SWnKboanxJL0Frw2vcPnktr3+RskvStKXt+5SmssSQ3BAuQ4p5vDemNPKxeOvqT77OontVEBt9ESN4+pgITp+Fz63aO3A+C7kV4lilxwaSRDSvGO5XxYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621932; c=relaxed/simple;
	bh=YDrVwEqPMtsYCuUtb7WKSyTOxQktEVVxbtraOrs3Wqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnYK8NfRirPQCvfUiFo/v0Xridhv3EmwfgDHx+yjwwLw3N5ITDEP9SKFPNZyH0lUx2XSy+Egn6EUXCDLnjvw6QpQncysy7ewTy5iMixmYP6bczBxDoUTRd1MH+MK5Zw0GzvDidr/qPS8urCBH+5m9mUZaFHGGedytJxgR3WMEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F3A615A1;
	Thu, 28 Mar 2024 03:32:43 -0700 (PDT)
Received: from bogus (unknown [10.57.81.195])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC6443F7BD;
	Thu, 28 Mar 2024 03:32:07 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:32:05 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dejia Shang <Dejia.Shang@armchina.com>
Cc: "ogabbay@kernel.org" <ogabbay@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"airlied@redhat.com" <airlied@redhat.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: About upstreaming ArmChina NPU driver
Message-ID: <20240328103205.seht2hbog3o4giv5@bogus>
References: <SH0PR01MB063461EBC046437C88A6AE84983BA@SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SH0PR01MB063461EBC046437C88A6AE84983BA@SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn>

On Thu, Mar 28, 2024 at 07:46:01AM +0000, Dejia Shang wrote:
> IMPORTANT NOTICE: The contents of this email and any attachments may be privileged and confidential. If you are not the intended recipient, please delete the email immediately. It is strictly prohibited to disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you. ©Arm Technology (China) Co., Ltd copyright and reserve all rights. 重要提示：本邮件（包括任何附件）可能含有专供明确的个人或目的使用的机密信息，并受法律保护。如果您并非该收件人，请立即删除此邮件。严禁通过任何渠道，以任何目的，向任何人披露、储存或复制邮件信息或者据此采取任何行动。感谢您的配合。 ©安谋科技（中国）有限公司 版权所有并保留一切权利。

You need to get this fixed, otherwise people will delete this email
as you have suggested and/or refrain from responding to this email.

Please talk to your local IT and get a setup without this disclaimer for
all mailing list activities.

--
Regards,
Sudeep

