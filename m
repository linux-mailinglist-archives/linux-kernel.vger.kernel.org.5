Return-Path: <linux-kernel+bounces-78727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 803978617E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3855628A0AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA3E83CA8;
	Fri, 23 Feb 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDL5Y02+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D8D84FA1;
	Fri, 23 Feb 2024 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705728; cv=none; b=X+Ay9TQKHRmfb7nVgy2KEZ7gZT+UZGHPOD7ItvBTEoVibdNvxui3AIRL+OC+6Z/dnz8P81Heaa1awThC1hCqjtLrKIjUWWwcq7fjaopL/La4/ALUEeoh86fVpMrwydpM+9Eq+TgAoNIkP4nA5OPvdQ8wnsy4n1+/15N7yn5hi0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705728; c=relaxed/simple;
	bh=MKwvCMy8mgFWdbvzLyOsYqWArU5NYYRlO+TE1+VYsX0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=THWjdJbxbQXqH9E2Rn03bwdM856BmnRkYgBMMQr3l3F80GATp/FLSVOG7/Zf3A3mmIUbkEPh0Phvm7khqRGZmtBrQxvwqxuM3LdjPK7OqACBxBgZ92kvyeSA4ZNDi83/tvo/A0QJ++WFeVAhtyPk9roAQ/UbtCL1gzazg1WRptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDL5Y02+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4B0C433F1;
	Fri, 23 Feb 2024 16:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708705727;
	bh=MKwvCMy8mgFWdbvzLyOsYqWArU5NYYRlO+TE1+VYsX0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FDL5Y02+HEIiYaW0kbThPhPZ5tpkcEb6j8qRIscIJQcZKJqdHUcl6flVaSz66yUg7
	 BMle0D2XUu60z49ecU5S+lXh/RmAHkziGc6RKUdso/xlD6G0q5n0Zt7vxBMkZsyQGK
	 AFlWcWyfa2TV/wK+DwSvpPQasjAsjE8ySm5hFRTwRICxPrl7KRIzksFx26MA2v/6ui
	 CCak8RETlNWeV49Jpu+d/FMOHeWtejvHrT+7JV6vztuGSAfTjH8GYlJShrwVMj6toa
	 q1AmEnwkCppWTlGYZPTqGd02csea04b7DzYGhkuVFo2uHJ9H7tkiGTTXR1MEPMZnQm
	 wvsZC8x59WyVA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, 
 pavel@ucw.cz, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor+dt@kernel.org, andersson@kernel.org, quic_kgunda@quicinc.com, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240202180151.4116329-1-quic_jhugo@quicinc.com>
References: <20240202180151.4116329-1-quic_jhugo@quicinc.com>
Subject: Re: (subset) [PATCH] dt-bindings: backlight: qcom-wled: Fix
 bouncing email addresses
Message-Id: <170870572457.1740438.258994199463486668.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 16:28:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 02 Feb 2024 11:01:51 -0700, Jeffrey Hugo wrote:
> Bjorn is no longer at Linaro.  Update his email address to @kernel to
> match the .mailmap entry.
> 
> The servers for @codeaurora are long retired and messages sent there
> will bounce.  Update Kiran's email address to match the .mailmap entry.
> 
> This will help anyone that is looking to reach out about this binding
> and is not using .mailmap to pre-process their message.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: backlight: qcom-wled: Fix bouncing email addresses
      commit: f842d487c6a2f17a9d4d9bbcbfdb90b49adac71d

--
Lee Jones [李琼斯]


