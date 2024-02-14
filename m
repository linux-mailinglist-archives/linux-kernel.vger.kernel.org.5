Return-Path: <linux-kernel+bounces-65743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF81685510A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5862810D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F86212AAC7;
	Wed, 14 Feb 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXtTjz13"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FBD12A162;
	Wed, 14 Feb 2024 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933470; cv=none; b=cXVck5kbriyQXmhQyHPWrJn4lOYrC3kJ/f1uBIscHRjs2r9d+3tuMkcMUBqZCcJZxnKiQVIfocq2z19m0JQQ8jGm42Va/V6bzPZw38ZZRLleAD93TGiJDCNy+/zbYDHLfX77snHHL3InLDMoq4ns0MurNnZ8eaCGsIjtcIlI40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933470; c=relaxed/simple;
	bh=orxKOf7vyVoeq5LamaGVz8NcLFYJetRThm4I4MUUNIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1w5hqS1fgCZQonLzMH+a1OgaT8YFX3PxYtmgcedi1MIBxbNDGQoqMwQ8gpscDCFOAL8W4Mimk7d064/0BhC/gnr0V4sExBBtMNCGY1GovJtIwFZ84VHZGS0B6lD9oDjbARf9Gycoxdv7SRQz0lvHM5D0jMVbpK1W4XAkwTOs2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXtTjz13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E02C433F1;
	Wed, 14 Feb 2024 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933470;
	bh=orxKOf7vyVoeq5LamaGVz8NcLFYJetRThm4I4MUUNIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXtTjz13ws1akiM+OaZNoyT76p+9S/ieBQOdYcLhDexB+DR2MSJJHPGPFIVf2EMq6
	 /EQCdBhPKgN+b1ksKS15Ls2kYOOPgldW5nHT+vUA9DMF/vwKCfpnN+B64jIDguDo2C
	 x/1lMoL1aBtbTvuhvWRftjggDXLa9SxTQX2ojnTu9Cmmc26gUKnni5NKH05gFW0pAw
	 EF0MLUOTqbs0jh7zakoAPr1bHSwuDfNB70mIwNPXpiO8QWcn0HiD19Ke8sDvHdg4lZ
	 bZ98quNZogE1W/9NC/+StTRugLS8FXmqELCapyQZ6HmHoNAV6Lm3bwp0e23DM/7YLl
	 eWUNz8pSv3Z3A==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8550: Switch UFS from opp-table-hz to opp-v2
Date: Wed, 14 Feb 2024 11:57:24 -0600
Message-ID: <170793345829.27225.16322063372177962081.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203-topic-8550_ufs_oppv2-v2-1-b0bef2a73e6c@linaro.org>
References: <20240203-topic-8550_ufs_oppv2-v2-1-b0bef2a73e6c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 03 Feb 2024 01:10:11 +0100, Konrad Dybcio wrote:
> Now that the non-legacy form of OPP is supported within the UFS driver,
> go ahead and switch to it, adding support for more intermediate freq/power
> states.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: Switch UFS from opp-table-hz to opp-v2
      commit: 2f7be4caacd264b23f637f2e1d7dccf4f1e4f20e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

