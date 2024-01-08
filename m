Return-Path: <linux-kernel+bounces-19333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A42C2826B86
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF311F21E8C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24B213AEE;
	Mon,  8 Jan 2024 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaN2ncaS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F013ADD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28fb463a28so152905466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 02:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704709385; x=1705314185; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FhujCW470qViRsX+Hw5x/JSRO0y6Rf4yH8UeTlvgOnE=;
        b=YaN2ncaS9Z1g8PuCblmMo1C/IPva2jPoJcj9J2KZC3pV7XPptYMHbq38/ziUgmo8mK
         IXOg7PcP60vVUSUgAJxKPZvh+5IxYlX73XfsVOXAiTj0sK7NVpdsLz/zhDkHSBoMQBK5
         zra2MDmIVU2Pv9iSAbO36aVAUjnJQA5FfpaAE5JaeDM+TegTeD49BzQuT6+fF+8nmcc3
         qSj67SG1fr8h4edri9C0apv1XDbUkTW2/xr/LKdwwSDNrammIK2RMfzCQ9u+NfjXyxwS
         /cnQBO2muIry8RXffLJYZsklujkygyx7NTbt4uvfroArp9EUh/nBIuJLxgXGLKWMd1UX
         g8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704709385; x=1705314185;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhujCW470qViRsX+Hw5x/JSRO0y6Rf4yH8UeTlvgOnE=;
        b=PoBrOIky6tB8AWV405fEU4icYH5qP4D0HzQsCs/L5sT/yEeN+1UpOpl19TXnzQM1KB
         VbuqXjEs9ZAXJERJ6cqXiA3thkvq/GN5A+5Oy7uUeA0F/gTFCLaqVUx/7hs5sxbV0pOV
         MdxFbJ6M7ANthX8gFcdIWQQMYQLqsNC3FcgESLeLLfjPuff0wzZ3Ud7s5dF7fPheDTHJ
         ZJe3bGBESxMbbmuWpKsBqmj9izJJZ2IvFhMZjyZ1PNXtwbCXN/cnL0csibx4dyHLokoZ
         plU8DyqfC6qvYVHPNtKmESRXW25xj8l7N5vkjl04I4dZFll1cJOZqpahLSxCOWjmKnZp
         mZgg==
X-Gm-Message-State: AOJu0YxWtretFeTnEXtEl904MoJxHGGIZeQdVEYH8ZV5gXj7clYezWen
	zxprU9c8b11Khtso/MMfRH8=
X-Google-Smtp-Source: AGHT+IHR4iEVriWKDFtLGeM9zc6tKD1ISPwT0UDwI4QNA9C8gp5DQkpCHAbhHSOTLP62zwBk9Oqggw==
X-Received: by 2002:a17:906:1752:b0:a28:7d3b:5706 with SMTP id d18-20020a170906175200b00a287d3b5706mr1429390eje.111.1704709384708;
        Mon, 08 Jan 2024 02:23:04 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906318100b00a2a632e4eebsm1343131ejy.119.2024.01.08.02.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 02:23:04 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 11:23:02 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL] CPU hotplug changes for v6.8
Message-ID: <ZZvNBnboWjpkQuW9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest smp/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2024-01-08

   # HEAD: fe22944cf05ede8e6f841cfecdb7093a53a3d9b3 cpu/hotplug: Increase the number of dynamic states

CPU hotplug changes for v6.8:

 - Remove unused CPU hotplug states

 - Increase the number of dynamic CPU hotplug states
   from 30 to 40, because existing drivers can exhaust
   the allocation space

 Thanks,

	Ingo

------------------>
Zenghui Yu (1):
      cpu/hotplug: Remove unused CPU hotplug states

xiaoming Wang (1):
      cpu/hotplug: Increase the number of dynamic states


 include/linux/cpuhotplug.h | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

