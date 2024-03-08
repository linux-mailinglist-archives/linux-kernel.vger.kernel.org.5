Return-Path: <linux-kernel+bounces-97207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA148766F9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088B31C21DB2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227A71CD20;
	Fri,  8 Mar 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfO4RrXq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453615AF;
	Fri,  8 Mar 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910290; cv=none; b=FqmousrvCs5xCI8j+uaHssodCyS8dyHlLKdKkdlu5kpAtaQYqdMoTihIumOv4nrC7Y5Hoq9mr7wBKWwM/2pkgwRdNdfB2Ejx/+e/2mC2JmFwJSk0fznTnXzt+xN0i0XnxivcYq/aFh8y/RwVHciUoilxVDbhbkmfgt56aqM4+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910290; c=relaxed/simple;
	bh=u/gEmAT3XX/DsAa4AUjUG98Bpzl+laVZfO8peR0n210=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=UH+zkvqEBGx9754cyX1WpLPPhJwqoAXsZuXGhSbZMfXTu7KdlIA2h+ZIY4ep3rdSP+Z7XfqOrjoYabVCespETbHQzV9utdbYF6n0M5THMk3tUkKwEcDGATZb6jFJ1uShdAEgT/3bZr64/+lQi/YYSyF1xi8TOJ8TgIlFOnhvF7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfO4RrXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5256C433F1;
	Fri,  8 Mar 2024 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709910289;
	bh=u/gEmAT3XX/DsAa4AUjUG98Bpzl+laVZfO8peR0n210=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=bfO4RrXqhIgk5Y3Zz22vssvmYfEFr40dBNHw61CgBrEnrrVMuEKusLu0LEfPuHjBt
	 chjC30xmTvOb2AANaYLkVdsJrUq7KvE91mRVizNJNX0FQiK2JeIiofoMJpP20qgHNh
	 d2cO7mI6RQZg49d4QrAdWvMRzU9zbx2ey0ZrsODMf4Uz6+toX806RYyLEVYQYuRpsi
	 Zm7f+cnA8jRvXNqCLBOQM/0/sv/zgsozoIvesBMB4M7XrINoTjN4Oi6oSTxAA6KUo4
	 skc5g3BPx2/F6Oo7wZnt6i8T9YwrkRmyVg+oxyZs0aG+2UcPc3GCI6erX8HOQMlsiJ
	 0yF2K+OlunjOg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: remove obsolete struct wmi_start_scan_arg
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240226-ath12k-obsolete-wmi_start_scan_arg-v1-1-07b0b563cb27@quicinc.com>
References: 
 <20240226-ath12k-obsolete-wmi_start_scan_arg-v1-1-07b0b563cb27@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170991028648.1311983.8441436934552157832.kvalo@kernel.org>
Date: Fri,  8 Mar 2024 15:04:48 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> ath12k inherited struct wmi_start_scan_arg from ath11k. However, in
> ath12k, this struct is unused -- struct ath12k_wmi_scan_req_arg is
> used for this functionality. So remove the unused struct.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4cd6eb606f02 wifi: ath12k: remove obsolete struct wmi_start_scan_arg

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240226-ath12k-obsolete-wmi_start_scan_arg-v1-1-07b0b563cb27@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


