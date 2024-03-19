Return-Path: <linux-kernel+bounces-106941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F75687F5C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41921C218B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A357FBAE;
	Tue, 19 Mar 2024 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq/oqrYb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D87F7F2;
	Tue, 19 Mar 2024 02:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816550; cv=none; b=Ea84rw3DLFYPYihFPbg47TIMJCVfWstMYlNct+YDftPTIoAsS2VJtBjhiew6nOklCiWX3fi/xCObhe4LsnALJLdQE/lyvkhy33qZtqM/Iihmt/sEQsUzGOoOD55nrOApAhMVP6vBN7AxpRzpI6RGZdPbnpe3Amc76yKaPoXjKzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816550; c=relaxed/simple;
	bh=zAJX23UHd/9Paoq2CMnqidvxB8/P6xEMFnnlO4OCSak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZ85MvxzH40fjMWJUxqIj/tnQkzfupnq1E8naVoqk1J01IgRaMEIKASohMTI6BApW3Xhb8wUsvm7kQeCcS9GkQtXlaAU5TPdbuNKEEZSGgo/2q/JocKLVdgobpAO/fmK947TAi5hG+pFrDVqc5L0EdmziJwWM7d7BknPgj7x8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq/oqrYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79067C43399;
	Tue, 19 Mar 2024 02:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816550;
	bh=zAJX23UHd/9Paoq2CMnqidvxB8/P6xEMFnnlO4OCSak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tq/oqrYb+k5P75nIyad8a0mFyixet/T1niCR4lJ/xb2H/Sfvu2r8PhrXMHvySXMar
	 A+wt9YN+5yp+Whzt3bcn9WzpB46pQY6JIgHonjA9niVWhYNo8z+lUL/cuUOsZoqzIM
	 ew1dbAN8y4BARA9SG8YYsrgifHYutMwmrY1OXDTPSoYkLdPNP/4/EBXH/7sfdHnF99
	 7y41fn66MYHl29ORexs2ZsbQwUM0Lza3T76g6ePyq5L/ljbHgMqjaYrRBjP1DKI7EA
	 yFmSwo+8/V9Zk4bsAXY1f/t1fxxUTlR5vrK+igWV2pYWhvnATith0Y24p1ICsn51Gt
	 QLrFlnzi3Aphg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jianhua Lu <lujianhua000@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8250-xiaomi-elish: add usb pd negotiation support
Date: Mon, 18 Mar 2024 21:48:40 -0500
Message-ID: <171081652637.198276.12446437834826324312.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302131025.13741-1-lujianhua000@gmail.com>
References: <20240302131025.13741-1-lujianhua000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 02 Mar 2024 21:10:25 +0800, Jianhua Lu wrote:
> Add usb pd negotiation, but charging is controlled by pm8150b pmic,
> so it can only charge battery with 5W,
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250-xiaomi-elish: add usb pd negotiation support
      commit: 91905d8368c69bea3fb85f5c76334274a232612d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

