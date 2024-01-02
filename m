Return-Path: <linux-kernel+bounces-14616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4600E821FB1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9093B222FE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4737E14F98;
	Tue,  2 Jan 2024 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAk1zDmy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F79514F8A;
	Tue,  2 Jan 2024 16:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AB9C433C7;
	Tue,  2 Jan 2024 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704214363;
	bh=R/bH2SJHxYJQr2krHs+SPvNR7ecZ5sreLbG58UhOGss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAk1zDmyKQ3PNobxZIxsEz6+paS7sh14rfXLXdUcIDreR2OXm0CTvyc/S8KLH8Z6L
	 9OQlAHKlFV9LiJfausFEHjwegOa4SgJYfDD/kg5xu0w1jfH8vR8FSdBnzWcFtFzjDb
	 pH5aj/sdgL275cyVZvWICZZsxOX3b+xDeTB4jxHuYXwlO5Ugs4Gb1wiNXddASO15O6
	 /zdk+ET/cjHrE5XuJiizUlhkiHckJQfkXSqG1YbfcoYqz24Qv+I9bzjvkJ9Tu+x24U
	 +MjPREv1ctXPCPklPLELDxdnMgScTtZj843nizmEzeRr5HvSHo9h8vibtVa+8Vdptu
	 GHKEYqEAr6mcQ==
Date: Tue, 2 Jan 2024 22:22:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_cang@quicinc.com, quic_mrana@quicinc.com,
	Bhaumik Bhatt <quic_bbhatt@quicinc.com>
Subject: Re: [PATCH] bus: mhi: host: Add sysfs entry to force device to enter
 EDL
Message-ID: <20240102165229.GC4917@thinkpad>
References: <1703490474-84730-1-git-send-email-quic_qianyu@quicinc.com>
 <cff4b828-9566-a2bd-287a-138d74a76a59@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cff4b828-9566-a2bd-287a-138d74a76a59@quicinc.com>

On Tue, Jan 02, 2024 at 08:31:15AM -0700, Jeffrey Hugo wrote:
> On 12/25/2023 12:47 AM, Qiang Yu wrote:
> > From: Bhaumik Bhatt <quic_bbhatt@quicinc.com>
> > 
> > Forcing the device (eg. SDX75) to enter Emergency Download Mode involves
> > writing the 0xEDEDEDED cookie to the channel 91 doorbell register and
> > forcing an SOC reset afterwards. Allow users of the MHI bus to exercise the
> > sequence using a sysfs entry.
> 
> I don't see this documented in the spec anywhere.  Is this standard behavior
> for all MHI devices?
> 
> What about devices that don't support EDL mode?
> 
> How should the host avoid using this special cookie when EDL mode is not
> desired?
> 

All points raised by Jeff are valid. I had discussions with Hemant and Bhaumik
previously on allowing the devices to enter EDL mode in a generic manner and we
didn't conclude on one final approach.

Whatever way we come up with, it should be properly described in the MHI spec
and _should_ be backwards compatible.

- Mani

> -Jeff

-- 
மணிவண்ணன் சதாசிவம்

