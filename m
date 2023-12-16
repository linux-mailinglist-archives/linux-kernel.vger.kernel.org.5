Return-Path: <linux-kernel+bounces-2187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A16781591C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED521F23B10
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1FB19452;
	Sat, 16 Dec 2023 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="QIui7Z+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="byrCnleX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169FF134D9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4599F5C01A0;
	Sat, 16 Dec 2023 07:56:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 16 Dec 2023 07:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1702731395; x=1702817795; bh=V/Swu2Ok4xoLueHEPWDCQ
	hLZgLyrqWw+uIjeSWzbtwI=; b=QIui7Z+IfRWYnzTi8vIFLLuA0ohXyqGo4mcyc
	S+O/BhdEdYy7u3BBbPMnACTba0cWjCUa534mWU3ZJUvQtLokMr86xdfrSTPZP0YK
	ScBk/V9NpmH1sm/yegqvT8KZWxhclY9ECqwEY/D8iEf0LuioK7Q4pJQ3mjNxUUOd
	LvG5nuMjyjz1ZgypMrasS+cA+11aoo/Nwb7Bli2/c5OdOtX47fQyn7mj6lyRihNB
	OpGkbtBDPA65naNW6SOd2TS82zsOM5EK8w4CdtzOl4Buw9roFsTxmfE3tQzDphBE
	9oARIhCxinUieFWK9rQn51GGsqMVjHqIAzy8F2edaA5KkZdKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702731395; x=1702817795; bh=V/Swu2Ok4xoLueHEPWDCQhLZgLyr
	qWw+uIjeSWzbtwI=; b=byrCnleXneksRhc6l9XdhLUGQeWBgO8FyKMmnnkWc9Et
	vw2lenscIiD0ZFFPfidGVgviGwavp1MCRsBSfyxrGV5NrRRKMM4LFLRqLq0yYtvp
	yNxcKW8I7E1XhXA1rrHK5ALbCJ10XkQY5oNsuR3vpB8JKOXOX+tKyw9l6OYQFfWy
	f3eGNnafwQpG4cBYuYIB37XCJTfaHxJ4JRjh3fP6FFgUdDZEiBxrQIrb0Vppteaq
	nncf6gLalCPiSFzqy+d1QVIRcNeSv/G8In/f2/IGSBfx7IVVB6crwJjU6xE9xtSO
	3atntxuWJUcm6TrvrBDw+SHfECuI0IYBJDl+/9UxuA==
X-ME-Sender: <xms:g559ZWxLC_18BaplY_aYHZqV8W5369YqLjui9l-OBCGuAe9b0fl2Vg>
    <xme:g559ZSRBGFtMcm1XsK9FPPT1qS-zNJerlpzlZUqD2Jbj4THIfUOzWmh0LIfMA4isQ
    xvYmsD9A-yp5EHBJNc>
X-ME-Received: <xmr:g559ZYVsatCj233x81pff4kd0Y0yVAhpoZ0lJgy2GXGOAaOQFEqkyZ-PSsR_okgSmc-lynmxCr6dcspZdQwRE9X8WXKuNGuVd1UVtmNRbJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:g559ZcgeTwB-I9Ea6E3zZgZ4EOroh8w0SyvJ92hsCll3xs7PWT0PrA>
    <xmx:g559ZYCP-0OfO5gf_BkcO8iuSiJ-i_FhwxKn2kckxtPJ4UBrGbkPKA>
    <xmx:g559ZdK1779iLhoIB8NpEUakWEgB1Q-sEqmEFo3Rlssjtc2mu9qjTQ>
    <xmx:g559ZbND1jpAr95l7HtVPZkSrCvgCk-krTDak2sb7AzHSPNV1fmSoA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Dec 2023 07:56:34 -0500 (EST)
From: Gary Rookard <garyrookard@fastmail.org>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3 0/4] staging: rtl8192e: rename variable pHT
Date: Sat, 16 Dec 2023 07:57:12 -0500
Message-ID: <20231216125712.3522-1-garyrookard@fastmail.org>
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


