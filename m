Return-Path: <linux-kernel+bounces-2182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB310815914
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700BF285EE9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41141D69E;
	Sat, 16 Dec 2023 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="GyYj8oDq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EZtC6XK6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5478B18EBF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 69D875C00DE;
	Sat, 16 Dec 2023 07:52:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 16 Dec 2023 07:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1702731147; x=1702817547; bh=V/Swu2Ok4xoLueHEPWDCQ
	hLZgLyrqWw+uIjeSWzbtwI=; b=GyYj8oDq4e06+3HOUGVWgdfODhmoZjC9MefCJ
	mos0hyYRpoV2R0waWCC+akkOLkI/h0I2qG2ZenvQkyUzianJTCqFGIWj2MIkfWxJ
	ixdVH3x1PXaW89+HsRYnZdpwIMHlxxlkVNl0f7avIEbNy8bX2w35Wp1aPEOHT00J
	XCVZgasDClcVXytumyflxsUw3rrtln3GyOJDxsr14sMxsJM3b6CUsdpizVO8m80Y
	mEHR1FJR0JYpreDvMF04QEul9L409DMr90UGDv5dIh+ZS1DN8L84YwBdLExlV13V
	LWQ3yGnNFnSr+/yWAVdjk/l0kQkq184PX6IrlVEpaRNiQNQdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702731147; x=1702817547; bh=V/Swu2Ok4xoLueHEPWDCQhLZgLyr
	qWw+uIjeSWzbtwI=; b=EZtC6XK6cI9px0LqJn9yO3lu5GtzIqkbg7Cb43JWU5P0
	j+fM2PgX+32QUKtNQmxtp6QAwCGPtrHFg19El4DBl2V/Sx76C5kfbJgJyH5IOLcV
	foMc/u8yvkHtJxXzLDqwdOdW1EiV7ZpguXDg/zeHXQe2Sc/wHmtHeVTM40WNYVAD
	T/kS2or95WYmCI5Owo3t0Zm1kycKgWv2WoYyI0G5rdcO24x8K/9vgyr5KVoDk2vC
	5hZCJR0Sll9Bo5DfdZlWDvMZ0XIqJr7G5jQJ4bCCSw0PSY++1RyNfwP7F/L+4AN+
	lCYC9YB8YRm/cHlY0W8Ee/Pg3k2MEetPEtUQFO+WbA==
X-ME-Sender: <xms:i519ZWPutzOEHqrusFqK9l3LwUN9HRu3ujIuDma-8UJCZlvwc55UmA>
    <xme:i519ZU-OtyrxPQz6mdBOcqBzAMHNYIQoKI65ZUUuQLmTNrnBLlAR1MiVB2flRuYcQ
    joBqLUwWiKZiuPjhbM>
X-ME-Received: <xmr:i519ZdTpNsRyn_AK-3mRAEPupRsKCoa1N95ROkMpOg2cX6ehyIoxNrRNd5IJZT_d4TJpFdIau4sSoofl2q80-rJ5tblbMQngauFnWCVt0lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtgedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:i519ZWtzyY3R9ccjybSLHUSGlrEFf_UmYM8_fVs8aIX09iiOAMI2KQ>
    <xmx:i519ZecKYMknWHewOLHxl66_Stm1tX4eInUF-Nt99-nG6a234n3mmw>
    <xmx:i519Za3KiudQs7cNwupCoIPfzsCLLgQ4m-yQTaxirG3sUjBKWEEHZw>
    <xmx:i519Ze74brAPw5C3oNvuIylVub1MXu1LhE_anit4bpWsX3B5BoMJhQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Dec 2023 07:52:26 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3 0/4] staging: rtl8192e: rename variable pHT
Date: Sat, 16 Dec 2023 07:52:59 -0500
Message-ID: <20231216125303.3404-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series renames (4) different variables with
checkpatch coding style issue Avoid CamelCase.

(resubmittals)

Patch 1/4) rename variable pHT
Patch 2/4) rename variable pCapELE
Patch 3/4) rename variable HTGetHighestMCSRate
Patch 4/4) rename variable HTFilterMCSRate

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>

Gary Rookard (4):
  staging: rtl8192e: rename variable pHT
  staging: rtl8192e: rename variable pCapELE
  staging: rtl8192e: rename variable HTGetHighestMCSRate
  staging: rtl8192e: renamed variable HTFilterMCSRate

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 86 +++++++++++------------
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 drivers/staging/rtl8192e/rtllib_wx.c      |  2 +-
 3 files changed, 45 insertions(+), 45 deletions(-)

-- 
2.41.0


