Return-Path: <linux-kernel+bounces-31758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05360833389
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3819D1C211EA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C6D2E2;
	Sat, 20 Jan 2024 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Ne8hUva9"
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D54D262;
	Sat, 20 Jan 2024 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705745409; cv=none; b=Ris2imPOmNzO1M5Sb/GTf8qMJoh64xUbpgtwwFbrU7e0cLDfjzatJotqYKTY2xJayJelyBcdo50IvdDkGJQWaXfQcJjZKgxCxzjeVFD6Yjl++xCObXbCKgQM7hF0hDeELc7CITx3UqFIA2KkM5Us4ac/oTWziY3xXWgyGxPR/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705745409; c=relaxed/simple;
	bh=4HJ80jjTnWwlgKftFCZ5a709J5SkKOSI4e8M6loxfQE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CttQ5Jbv2UaHGQ4CxYooiY5wMkqGd5RZ8sOQpJvv2xij60e1cNPPDeCNIMjt+gI23t5qgEeQ5K+01ieF+mPQXiygh8sJ66t8bwK7eoHhmtxQjDaVzBNOmClebkq9yOmUIFLFdMcT2/RHatMukLnM0LWPUG5FO4jycfiC43Sfc/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Ne8hUva9; arc=none smtp.client-ip=185.70.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1705745405; x=1706004605;
	bh=4HJ80jjTnWwlgKftFCZ5a709J5SkKOSI4e8M6loxfQE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ne8hUva9s30xo0vJPMdi1qCD6dl9veXKq8Oac84P3Locnoe/yEYyx133nWEyVvtP1
	 M8aWll5ePA21Ad+M0IctEuK3xnof8q12i4qildjXvjvIWiBUv1zgkIJMPagpRs0Dxw
	 LfoPVVQ+I1DDIFbIR1MW+/jAewKM3GrFeAf8Me327n+eZd7Et++wtNLArBocmE+oXR
	 PTvqNVdKGFuEpiiKYn9S1saXhGwDXVJEd/Jg/yQ29LJ6U4t9FppE3ftVRG7mHoGG69
	 C14WM+1Um0PJX37wbAEWspAGQE91R415LAuie0LRUsnSS2VBUouZ7vE38fsNm7C6wQ
	 WbGdbDqTUAYSw==
Date: Sat, 20 Jan 2024 10:09:52 +0000
To: raymondhackley@protonmail.com
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, nikita@trvn.ru, robh+dt@kernel.org, stephan@gerhold.net, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 0/3] arm64: dts: qcom: msm8916-samsung-fortuna: Add initial device trees
Message-ID: <20240120100943.13716-1-raymondhackley@protonmail.com>
In-Reply-To: <20240120095715.13689-1-raymondhackley@protonmail.com>
References: <20240120095715.13689-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for confusing in the title of the cover letter. There are only
2 patches in v3.

Regards,
Raymond


