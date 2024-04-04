Return-Path: <linux-kernel+bounces-132143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A81B1899036
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6255B2841BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A2813CABC;
	Thu,  4 Apr 2024 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiqaHX2c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AA13CA9A;
	Thu,  4 Apr 2024 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265812; cv=none; b=ml7+EqifPsiqlwQRLPCZfQrUslwGrKLoXuu+m8mtRwF67PgT9mRWD+vDFQ1CM/Myv/pdx6kVkP0OB6VOCdPni9ZVSS9XpWwyXz5iKWXHCQMUGGe1etxCTHmlqyxxoaddG9OAjC/1LHHoNTnJ0aHWKANQXExCcHboiRdsp0xjvn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265812; c=relaxed/simple;
	bh=IUd+9jRFc2lGt2t2a5eMx3YAmpCj1Iu0XDsl36tEaoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmzzBqz85FkhqIPYvr/VF8rXuLOcJWhRlHD5n8LZpwGxO+5R0QmJ7EGJWQGreqSVgYa5rerOeM2BLxD9+L9gyKz+OOqJXNWwBCpl9DIdViWt6cP4+LvauaJkC1EJJQC67TAiwagl6DtYwwbFjr9DqPfMgWBYiNLGFkZU55M6XV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiqaHX2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1ECC43141;
	Thu,  4 Apr 2024 21:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265812;
	bh=IUd+9jRFc2lGt2t2a5eMx3YAmpCj1Iu0XDsl36tEaoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TiqaHX2c963Iy2dRTEveDjur4EUv5YYHkRzC7MP5ZHhpOrqKEPouFDUiIn/EVTvg2
	 0dIHK4nAxCQQcyI+g4k5GYWNblPvkUIK0Ny4KSfD5+gLC7UTONQnRZdfCMR2OtSlnL
	 Pu4BUwawoppzcq3D0M1DVZ+KRwuX8HLDYVgPx1ED0be6z6kr2CR+AawEkFsEdchWCJ
	 hPI5edFtsZtydxWb/UfEw1TOJNV6+5gI1RjCXcXzvn3NPWNP6NgNnvCq9xe3lih+OP
	 IcRXbonL/jA2vjLbBK532dGvRun7e4pEiso8Qzny04U0P+ABHaUCm008mansWhLSBk
	 YffbA3zbaunBA==
From: Bjorn Andersson <andersson@kernel.org>
To: Sebastian Raase <linux@sraa.de>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8998-yoshino: fix volume-up key
Date: Thu,  4 Apr 2024 16:22:59 -0500
Message-ID: <171226578685.615813.8473928683703352189.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315225237.1616550-1-linux@sraa.de>
References: <20240315225237.1616550-1-linux@sraa.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 Mar 2024 23:52:29 +0100, Sebastian Raase wrote:
> The volume-up key is connected to gpio6 on yoshino.
> Fix button node ordering while at it.
> Disable pm8998_resin, since it is now unused.
> 
> Tested on maple and lilac.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: msm8998-yoshino: fix volume-up key
      commit: 83ef6a5afc1d5e2270797a164972a3de3bd2ea52

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

