Return-Path: <linux-kernel+bounces-38661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED05A83C3C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A649B2925F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848F455E6E;
	Thu, 25 Jan 2024 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCbseu+f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B855579A;
	Thu, 25 Jan 2024 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189744; cv=none; b=CMIfXQLLMJflf0W8jjc70Gy/KAcyh0iG9PwiAdvJoKFWsZYUNNOCooc3Eut6VjJ/PM+fuvO4Dm4IDXM5jeyNiqrt9QSx8KkoyzNjHCW3wL7HEczzBS4peFlnNDCImKer4pfFmmuqVSaZ5e2/XaGIXMigoEpS+8rmXv0fIpjhQPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189744; c=relaxed/simple;
	bh=QTIZOrZxp7RFBRPvQefgAY8paDjFrKKof5RvSncdQeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N4yj+gNmugYKCck1iGGne+CQLn4fTjfxmL/OKM1IQQLoZtFIYSj5dgi6duRpOzmIzZqh0/SD/+tOC2VK7expWusbHktF67xDudTWaFH+rGDQ0iSzSP9gW+Hy9RSKkpwjRKMSiZ2A6afRR0MbLPJ9Z7n8IUzHZhYP0ALMSmJSQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCbseu+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B81C433C7;
	Thu, 25 Jan 2024 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706189744;
	bh=QTIZOrZxp7RFBRPvQefgAY8paDjFrKKof5RvSncdQeM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CCbseu+f02HKsAnVshZMrillOF83BZHZW53nihwq/8Z7TWRVLcUEHNXEeCbc5slH3
	 HspA1cj31rpXXGi7gFY4PcFvbYIRgialXwiJZh7eeb03980/Nxj7xxs10raQmWou+X
	 iIwh+ogpbXyUIlBgTUD3CSEU9RlkmZznx3aLVat7nMi2iEGoseLitQdGdL8oUWsGRf
	 iSu1UEmu+3iEB3rhuUqoPz+VwbZN8pzXoeUDBCizoEnkhWDJlNOm9WRuxqO7FU1kJ6
	 cugUNVeFArcB+ybIv9lFoBT59jVCSc44Myb9kI7Opibv9eTZqLE5ezN29oOZ9cl2T2
	 eh9TGB+wfFvUg==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 linux-leds@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240119232630.2752239-1-colin.i.king@gmail.com>
References: <20240119232630.2752239-1-colin.i.king@gmail.com>
Subject: Re: (subset) [PATCH][next] leds: aw200xx: make read-only array
 coeff_table static const
Message-Id: <170618974266.1467696.8699931696852228377.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 13:35:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Fri, 19 Jan 2024 23:26:30 +0000, Colin Ian King wrote:
> Don't populate the read-only array coeff_table on the stack at
> run time, instead make it static const.
> 
> 

Applied, thanks!

[1/1] leds: aw200xx: make read-only array coeff_table static const
      commit: bcc7f2ee83dc1dace6eeb6b25014f253ca2a2a51

--
Lee Jones [李琼斯]


