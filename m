Return-Path: <linux-kernel+bounces-144044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E298A4130
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC471F21F02
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E55224CF;
	Sun, 14 Apr 2024 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4aQ8VZs"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD31AACB
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713083157; cv=none; b=WWxjvveSoeu9kR/U7GvV5lhj2vgb6g9ku+LtxYdexl52zyv3507bTEiHTBoSG3ScEPCKmwbr5Jqn5L+k3B0gHkYK0iFd58NP2l0/7Aaq95yzubw3Y/ZO0Cqx1jq8Fr21JnMYEzPxlEHgjGDd4bp9Z+OhdLd9/fEuv7v1ALR0wxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713083157; c=relaxed/simple;
	bh=ow/QkAJmLjJI4jVueQXSCmY0OoRclOY4LAWYmnw6Jas=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nESrVTBrB7CPeGh03UeepIpyISCve7OOKpe/iyvJPCnb5gY3EOGE/qNzSU4ER7p6r8+Umb8XZYsJZenGi9Pnyj0scJJ7oPw2LKE2ZzT3dmLh6adAHwpD4PV/XX+DEwxjARn55mQ2y0j1m0lBnkeyKN99WoI2QvZLVL5ttllcRtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4aQ8VZs; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so2676838a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 01:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713083154; x=1713687954; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lYTVweftPzOKM5O/ha43yyiaRJ+X/fR6uAf7QExh4A8=;
        b=L4aQ8VZspCcCfVQqoVBjW7gQdkxM5knBRbN/qJC//IglxxHs1JlzsfXsQwb45pnW5i
         xsczAyqY3pBHubeyohfXQmIGhyYB5FlRg85dhtb2TASV8mgh24MGWNF7TgDk38CWs6BX
         z3wUqtRcnTe99NDeOiccN46+ejxa31O1F/0AlEqwVrEKnXIVa228GuLtQPekMpsbzxfb
         zBxo126un42045mr/RykpKmJPIXe+tdavQ35E2SsIzIhLaN1Ndb99QTkvb3lvghJFv7+
         E2/ga3iXgdNPstILOCNfSpnY/ODb1cgCcY1ZRfN9WWAfAAYrQ5iIWQaNTMOkWYJjt2nW
         w51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713083154; x=1713687954;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYTVweftPzOKM5O/ha43yyiaRJ+X/fR6uAf7QExh4A8=;
        b=hYBMn2tpbUuXy8gB7WHHw1lTroMsBGvqiaqDDgEqGtLquECtrB95IZYDiRgmH7xRft
         TY0K1BREL0XxaEURwfEOXuppB5Yl2nzJSvHDd9zP9tAmapUFZFdWZmtXpD6eEef6GxSW
         k8UUdnIkf14/ZsNCpBBFkP85udtv3HFqZk67YNJwbuc6huEjY7+pyvi53L0Eh5jaaWXD
         xkZcfH5Ho73fNr2FARC1Es+WqUh2eLTdx197vww9/y8iamVySAWNwQSa83aVy0nNhTfC
         SHDHRGnICVReXiycUSe3rpoz6qNPgG57EeUAz17/QqHD0ikClVQplOrT01DErkzGkt9D
         GUWg==
X-Gm-Message-State: AOJu0YzFafFFRbuREEqJCCT44Pce6j4rtT23EfNm0qFsscFytoomBOk2
	1XsCZwH0QXmDz6IAs2wWaesHcB4Uv7/UCLg07+v+vMeDvy+TiqEu
X-Google-Smtp-Source: AGHT+IGvOapbPHxfL9rnBKitpxgFR3TP2B8klS7u5vvZ63A2KPzhplii4JLv7hGHjgdtO0VK7fO5qQ==
X-Received: by 2002:a17:907:2d88:b0:a51:dc8f:3619 with SMTP id gt8-20020a1709072d8800b00a51dc8f3619mr5013654ejc.67.1713083153861;
        Sun, 14 Apr 2024 01:25:53 -0700 (PDT)
Received: from gmail.com (2A00111001332BCD9129005EE765889E.mobile.pool.telekom.hu. [2a00:1110:133:2bcd:9129:5e:e765:889e])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906c09700b00a5264576138sm302404ejz.35.2024.04.14.01.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 01:25:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 14 Apr 2024 10:25:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events fix
Message-ID: <ZhuTDmtgtUEuJaae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-04-14

   # HEAD: dec8ced871e17eea46f097542dd074d022be4bd1 perf/x86: Fix out of range data

Fix the x86 PMU multi-counter code returning invalid
data in certain circumstances.

Thanks,

	Ingo

------------------>
Namhyung Kim (1):
      perf/x86: Fix out of range data


 arch/x86/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 09050641ce5d..5b0dd07b1ef1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1644,6 +1644,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	while (++i < cpuc->n_events) {
 		cpuc->event_list[i-1] = cpuc->event_list[i];
 		cpuc->event_constraint[i-1] = cpuc->event_constraint[i];
+		cpuc->assign[i-1] = cpuc->assign[i];
 	}
 	cpuc->event_constraint[i-1] = NULL;
 	--cpuc->n_events;

