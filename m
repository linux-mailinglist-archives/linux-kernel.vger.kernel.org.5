Return-Path: <linux-kernel+bounces-41848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F8D83F89A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B44A1F219B4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B8C2E419;
	Sun, 28 Jan 2024 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nblemAUS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1E2556D;
	Sun, 28 Jan 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463960; cv=none; b=tXpxF6o+P10G0bJ51/qbk3Rf+PLHDF0DBRTjWKiV+VXKDQqHy5DPZtZzvdWSNTjeYTfTg1CWEudaMQdF+sgGQC0gNkHDCeKvMdBHhPU08JEr6twWa5PAHCRQcp1KR5e5OrvhtSvx1P35pVnCAN7IJIyOzzk9hNueYIPDr0VRW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463960; c=relaxed/simple;
	bh=tSfGVSyeX+TlETCVVjGxQOxdSrHnjnWJGB+Irrwx590=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UkNMkXMQbsh+CC/ih+S/HKokEtZKihKiYTj2hznjuwC2p2soA1iMuJCX8femISAgeJGiLxhfVOADc/U/+D+JrsjmW9rwtu+F43eTZBU8Q6nDOCTwbd1Jd1oTi5KoqFW0RtihVtVo48YoEb/0MXP6SssUDjTAGgonY5J/Le68apA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nblemAUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F72C433C7;
	Sun, 28 Jan 2024 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463959;
	bh=tSfGVSyeX+TlETCVVjGxQOxdSrHnjnWJGB+Irrwx590=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nblemAUS2lxY5EYZKp3pUmtXfaAN+szsBPeHz4ShAlkrEHjknxO4R3iOlWG/l9Uky
	 PjgIVXT6zSodyEzjTuABQQf5KPQS6M5z/x5U8HZhpw7CJws5lZwROkghbF6VmKmHla
	 AybfVt8vhUizWT4lsnipEcORLKgH6b2+ChtTJiTa/gvIYIdDwMXqUWCdPpbOntm+J5
	 OZyaSiua/CU4Lcce4kSUHgPwpqKUscr1SVQeGjJ7JvOPuFlpYAy84eOiCSfRSBc2Xh
	 pk95TzG4VJ1pp0GdMS7sDqHQgWQIMkvePl/8M6iMoIzZoD60Vjx45IY2HAz0kfbUmN
	 /09puFlVYu8YQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8960: drop 2nd clock frequency from timer
Date: Sun, 28 Jan 2024 11:45:42 -0600
Message-ID: <170646395035.64610.12182696331844328019.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20230812183811.375671-1-david@ixit.cz>
References: <20230812183811.375671-1-david@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 12 Aug 2023 20:38:10 +0200, David Heidelberg wrote:
> The driver reads only one clock frequency, and the schema does not
> allow more than one frequency here.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: msm8960: drop 2nd clock frequency from timer
      commit: be8db0cd5e4c869db73dbfec4c5af5db248fe585

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

