Return-Path: <linux-kernel+bounces-55959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293EB84C415
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E261F25BDF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1A22C6B2;
	Wed,  7 Feb 2024 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoxW5JL5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBF128E0B;
	Wed,  7 Feb 2024 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281237; cv=none; b=dZvWbeHVAOZdSPnRqoaTrhCSLt+RxwQSxGfx9v8Ev4lPVxluaALGuPfkk8OrvEMz2M1Kl9ELZuo+o1JEfB0QCFbsOp5Hb5LamQwoKKmr/lWMI7BtH0vZcKMhAzC/r4dHg5LkzgAhaAgpWs8y47olRSb6RoHsIVhAItpC5PSYod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281237; c=relaxed/simple;
	bh=snwEmEnlXdURlEnZbQJEX2cLBcC1/EELYYEHISPcEWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPxuCQmbD2Ri7xIK3n/IKpHLELk6Oc04bk4FSLvuoRcaLFL+yVOt9UPoGsBA2ff3ep1s55qo1Dyk24JdNdumGjnGJ6gQ57EUeT9abctm3RbSpg77sbNETVqmCu/mqUZE9uiLQevOSKiJzVuf77Ts3QOrE6S6W48G7FbaVjVqa2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoxW5JL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096DDC433B1;
	Wed,  7 Feb 2024 04:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281236;
	bh=snwEmEnlXdURlEnZbQJEX2cLBcC1/EELYYEHISPcEWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EoxW5JL5D8B/4N2WcyW/artw7ymqKq3GXLqYnw4g3Rr1dAP/TrTG8L4yjakrYGxGb
	 U+tmiwNvwTCC2d204tLJ/z6WlLJ1OE3DH1cEBfnvDfXwh+bJN9RrSmH2C37RZ+YBCA
	 Cbhu3pxTHn4ACL2lqpVnVOX4X+OJbGmzFBUc6FEU37FnjwpaDHBoacdLTfTV0lu5pO
	 HuAwPHHMzJlacPMi3HBzNazwrE0LA2v3yCEyBbtNRjXVuTJP8NDdPN34VPveO1134d
	 NFCJ7yeQNqNfy6HUEH43FE/i/9bsjBWWQGMTNPZfjFmISgjOtFkW10xsU0J/+HXk4J
	 eHvyBQ7CQKkPQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v3] arm64: dts: qcom: sc8280xp: Introduce additional tsens instances
Date: Tue,  6 Feb 2024 22:46:34 -0600
Message-ID: <170728117692.479358.8204389004285378331.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206-sc8280xp-tsens2_3-v3-1-4577b3b38ea8@quicinc.com>
References: <20240206-sc8280xp-tsens2_3-v3-1-4577b3b38ea8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 06 Feb 2024 15:51:11 -0800, Bjorn Andersson wrote:
> The SC8280XP contains two additional tsens instances, providing among
> other things thermal measurements for the GPU.
> 
> Add these and a GPU thermal-zone.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: Introduce additional tsens instances
      commit: 014bbc990e27043e2d0c152bf63f8918b9c347c2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

